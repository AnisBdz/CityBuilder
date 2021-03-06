#include "house_ref.hh"

house_ptr house_ref_name::execute(city & c, Contexte const & ctx) const {
	return c.get_house(name);
}

bool house_ref_name::test(city & c, Contexte const & ctx) const {
	return c.house_exists(name);
}

house_ptr house_ref_index::execute(city & c, Contexte const & ctx) const {
	return c.get_house(index->calculer(ctx));
}

bool house_ref_index::test(city & c, Contexte const & ctx) const {
	return c.house_exists(index->calculer(ctx));
}

house_ptr house_ref_coordinates::execute(city & c, Contexte const & ctx) const {
	return c.get_house(coordinates->execute(ctx));
}

bool house_ref_coordinates::test(city & c, Contexte const & ctx) const {
	return c.house_exists(coordinates->execute(ctx));
}

house_ptr house_ref_create::execute(city & c, Contexte const & ctx) const {
	return std::make_shared<house>(coordinates->execute(ctx), degree(0), name);
}

house_ptr house_ref_create_random::execute(city & c, Contexte const & ctx) const {
	auto h = std::make_shared<house>(point(0,0,0), degree(0), name);
	return c.add_random_house(h);
}
