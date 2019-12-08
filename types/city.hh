#pragma once
#include <list>
#include <string>
#include <map>
#include <vector>
#include <exception>
#include <memory>
#include <cmath>
#include "house.hh"
#include <exception>
#include <iostream>
#include <algorithm>

class city
{
private:
    std::vector<house_ptr> houses;
	int radius;
public:
    city() = default;
    ~city() = default;
    city(city const &) = default;
    void add_house(house_ptr);
    void remove_house(house &);
    std::vector<house_ptr> & get_houses();
    house_ptr get_house(std::string const &);
    house_ptr get_house(unsigned int);
    house_ptr get_house(point const &);
    house_ptr add_neighbor(house_ptr, int);
	void set_radius(int r) { radius = r; }
	int get_radius() const { return radius; }

 	std::list<house_ptr> a_star(house_ptr, house_ptr);
 	std::list<house_ptr> dijkstra(house_ptr, house_ptr);
	void tarjan();
	void kruksal();
	void k_coloring();
};

class out_of_radius : std::exception {
public:
	const char * what() const noexcept override {
		return "Out Of Range";
	}
};

class path_not_found : std::exception {
public:
	const char * what() const noexcept override {
		return "Path not found!";
	}
};
