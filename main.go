package main

import (
	_ "embed"
	"log"
	"os"
	"sort"
	"time"

	"gopkg.in/yaml.v2"
)

func main() {
	log.SetFlags(0)

	if len(os.Args) == 1 {
		log.Fatal("missing filename")
	}
	filename := os.Args[1]

	// load curriculum vitae
	var in CV
	loadYaml(filename, &in)

	// update empty toyear field to current year
	for i, _ := range in.Experience {
		if in.Experience[i].ToYear == 0 {
			in.Experience[i].ToYear = time.Now().Year()
		}
	}
	sort.Sort(sort.Reverse(TechSkillByE(in.TechnicalSkills)))
	for i, _ := range in.Experience {
		in.Experience[i].showShort = true
		in.Experience[i].showMore = true
	}

	var co Company
	NewTemplate(&co, &in).WriteTo(os.Stdout)
}

// loadYaml reads the given yaml file and unmarshals into object.
// Fatal on errors.
func loadYaml(filename string, into interface{}) {
	data, err := os.ReadFile(filename)
	if err != nil {
		log.Fatal(err)
	}
	if err := yaml.Unmarshal(data, into); err != nil {
		log.Fatal(err)
	}
}
