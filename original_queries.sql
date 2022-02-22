create table bus_stops
(
    bus_stop_id serial primary key,
    address text not null,
    lactitude numeric not null check ( lactitude>=-90 and lactitude<=90 ),
    longitude numeric not null check ( longitude>=-180 and longitude<=180),
    unique (lactitude,longitude)
);
create table company
(
    company_id serial primary key,
    company_name text not null
);
create table customer
(
    customer_id serial primary key,
    customer_name text not null
);
create table bus_route
(
    route_id serial primary key,
    bus_stop_list int[] not null
);
create table bus
(
    bus_id serial primary key,
    company_id int not null,
    tracker_id int not null,
    route_id int not null,
    constraint fk_bus_company
        foreign key (company_id) references company(company_id),
    constraint fk_bus_route
        foreign key (route_id) references bus_route(route_id)
);
create table ticket
(
    ticket_id serial primary key,
    bus_no int not null,
    start_index int not null,
    end_index int not null,
    route_id int not null,
    price int not null,
    constraint fk_bus_ticket
        foreign key (bus_no) references bus(bus_id),
    constraint fk_ticket_route
        foreign key (route_id) references bus_route(route_id)
);
create table ticket_price
(
    ticket_price_id serial primary key,
    ticket_id int not null,
    price int not null,
    date_modified date default current_date,
    constraint fk_ticket_price
        foreign key (ticket_id) references ticket(ticket_id)
);
create table reviews
(
    review_id serial primary key,
    rating int not null check ( rating>=1 and rating<=5 ),
    review_data date default current_date,
    comment varchar(63),
    bus_no int not null,
    customer_id int not null,
    constraint fk_bus_review
        foreign key (bus_no) references bus(bus_id),
    constraint fk_customer_review
        foreign key (customer_id) references customer(customer_id),
    unique (bus_no,customer_id)
);

--------------------------------------------------------------------------------------------------------------------

INSERT INTO bus_stops(address, lactitude,longitude)
VALUES ('Police Plaza' ,23.77372235339186, 90.41619845459428);

INSERT INTO bus_stops(address, lactitude,longitude)
VALUES ('Gulshan 1',23.78051326059967, 90.41711310674275 );

INSERT INTO bus_stops(address, lactitude,longitude)
VALUES ('Gulshan 2' ,23.793947722834744, 90.41499501226576);

INSERT INTO bus_stops(address, lactitude,longitude)
VALUES ('Banani' ,23.794092507191472, 90.40652739692355);

INSERT INTO bus_stops(address, lactitude,longitude)
VALUES ('Notun Bazar' ,23.797599050613776, 90.42374178343026);

INSERT INTO bus_stops(address, lactitude,longitude)
VALUES ('Gulistan' ,23.72538983680666, 90.41179956623789);

INSERT INTO bus_stops(address, lactitude,longitude)
VALUES ('Shahbag' ,23.739542715311856, 90.39588326993578);

INSERT INTO bus_stops(address, lactitude,longitude)
VALUES ('Farmgate' ,23.757489317254066, 90.38989923740299);

--------------------------------------------------------------------------------------------------------------------

INSERT INTO public.company (
company_name) VALUES (
'Saintmartin Hyundai'::text)
 returning company_id;

INSERT INTO public.company (
company_name) VALUES (
'Saintmartin Paribahan'::text)
 returning company_id;

INSERT INTO public.company (
company_name) VALUES (
'ShohagTravels'::text)
 returning company_id;

INSERT INTO public.company (
company_name) VALUES (
'Volvo Travels'::text)
 returning company_id;

INSERT INTO public.company (
company_name) VALUES (
'Green Line'::text)
 returning company_id;
 
 --------------------------------------------------------------------------------------------------------------------

INSERT INTO public.customer(customer_name)
	VALUES ('Asif');
INSERT INTO public.customer(customer_name)
	VALUES ('Nawmi');
INSERT INTO public.customer(customer_name)
	VALUES ('Takbir');
INSERT INTO public.customer(customer_name)
	VALUES ('Afnan');
INSERT INTO public.customer(customer_name)
	VALUES ('Saif');
INSERT INTO public.customer(customer_name)
	VALUES ('Sharif');
	
--------------------------------------------------------------------------------------------------------------------
	
INSERT INTO public.bus_route(bus_stop_list)
	VALUES ('{1,2,3}');
	
INSERT INTO public.bus_route(bus_stop_list)
	VALUES ('{4,3,5}');

INSERT INTO public.bus_route(bus_stop_list)
	VALUES ('{6,7,8,4}');
	
--------------------------------------------------------------------------------------------------------------------

INSERT INTO public.bus(company_id, tracker_id, route_id)
	VALUES (1, 1, 1);

INSERT INTO public.bus(company_id, tracker_id, route_id)
	VALUES (2, 2, 2);

INSERT INTO public.bus(company_id, tracker_id, route_id)
	VALUES (3, 3, 3);
	
INSERT INTO public.bus(company_id, tracker_id, route_id)
	VALUES (4, 4, 1);
	
INSERT INTO public.bus(company_id, tracker_id, route_id)
	VALUES (5, 5, 2);

INSERT INTO public.bus(company_id, tracker_id, route_id)
	VALUES (1, 5, 3);
	
--------------------------------------------------------------------------------------------------------------------

INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 1, 1, 3, 1, 30);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 1, 1, 2, 1, 20);

INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 1, 2, 3, 1, 20);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 1, 3, 2, 1, 20);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 1, 3, 1, 1, 30);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 1, 2, 1, 1, 20);


INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 2, 4, 5, 2, 30);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 2, 4, 3, 2, 20);

INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 2, 3, 5, 2, 20);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 2, 5, 4, 2, 30);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 2, 5, 3, 2, 20);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 2, 3, 4, 2, 20);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 3, 6, 4, 3, 40);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 3, 6, 8, 3, 30);

INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 3, 6, 7, 3, 20);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 3, 7, 6, 3, 20);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 3, 7, 8, 3, 20);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 3, 7, 4, 3, 30);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 3, 8, 7, 3, 20);

INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 3, 8, 6, 3, 30);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 3, 8, 4, 3, 20);

INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 3, 4, 8, 3, 20);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 3, 4, 7, 3, 30);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 3, 4, 6, 3, 40);


INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 4, 1, 3, 1, 30);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 4, 1, 2, 1, 20);

INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 4, 2, 3, 1, 20);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 4, 3, 2, 1, 20);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 4, 3, 1, 1, 30);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 4, 2, 1, 1, 20);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 5, 4, 5, 2, 30);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 5, 4, 3, 2, 20);

INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 5, 3, 5, 2, 20);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 5, 5, 4, 2, 30);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 5, 5, 3, 2, 20);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 5, 3, 4, 2, 20);

INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 6, 6, 4, 3, 40);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 6, 6, 8, 3, 30);

INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 6, 6, 7, 3, 20);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 6, 7, 6, 3, 20);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 6, 7, 8, 3, 20);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 6, 7, 4, 3, 30);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 6, 8, 7, 3, 20);

INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 6, 8, 6, 3, 30);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 6, 8, 4, 3, 20);

INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 6, 4, 8, 3, 20);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 6, 4, 7, 3, 30);
	
INSERT INTO public.ticket(bus_no,
			start_index, end_index, route_id, price)
	VALUES ( 6, 4, 6, 3, 40);
	
--------------------------------------------------------------------------------------------------------------------
	
INSERT INTO public.reviews( rating, comment, bus_no, customer_id)
	VALUES (2, 'Very poor service!', 1, 1);
INSERT INTO public.reviews( rating, comment, bus_no, customer_id)
	VALUES (3, 'Improvement needed!', 1, 2);
INSERT INTO public.reviews( rating, comment, bus_no, customer_id)
	VALUES (2, 'Driver drives recklessly.', 1, 3);
INSERT INTO public.reviews( rating, comment, bus_no, customer_id)
	VALUES (1, 'Seat cover repair needed.', 1, 4);
	
INSERT INTO public.reviews( rating, comment, bus_no, customer_id)
	VALUES (5, 'Very good service!', 2, 1);
INSERT INTO public.reviews( rating, comment, bus_no, customer_id)
	VALUES (5, 'Quality is satisfactory!', 2, 5);
INSERT INTO public.reviews( rating, comment, bus_no, customer_id)
	VALUES (4, 'Driver drives sincerely.', 2, 3);
INSERT INTO public.reviews( rating, comment, bus_no, customer_id)
	VALUES (3, 'Punctuality needed.', 2, 6);
	
INSERT INTO public.reviews( rating, comment, bus_no, customer_id)
	VALUES (5, 'Very nice service!', 3, 1);
INSERT INTO public.reviews( rating, comment, bus_no, customer_id)
	VALUES (5, 'Quality is good!', 3, 5);
INSERT INTO public.reviews( rating, comment, bus_no, customer_id)
	VALUES (4, 'Driver drives carefully.', 4, 3);
INSERT INTO public.reviews( rating, comment, bus_no, customer_id)
	VALUES (5, 'Punctuality maintained.', 4, 6);
	
--------------------------------------------------------------------------------------------------------------------
