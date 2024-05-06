create database Filmes;
use Filmes;

create table Filmes(
	id 	int primary key auto_increment,
    titulo varchar(60),
    minutos int
);

delimiter $

create trigger chk_minutos before insert on Filmes
	for each row
    begin
		if new.minutos < 0 then
			set new.minutos = null;
		end if;
	end$
    delimiter ;
insert into Filmes (titulo, minutos) values
("The terrible trigger",120),
("O alto da compadecida",135),
("Foroeste caboclo",240),
("The matrix",90),
("Blade runner", -88),
("O labirinto do fauno",110),
("Metropole",0),
("A lista",120);

delimiter $
create trigger chk_minutos before insert on Filmes
	for each row
    begin
		if new.minutos < 0 then
        
        signal sqlstate '45000'
        SET message_text = "Valor inválido para minutos",
        mysql_errno = 2022;
	END if;
    END$
    delimiter ;
    
create table Log_deletions(
		id int primary key auto_increment,
        titulo varchar(60),
        quando datetime,
        quem varchar(40)
    );
delimiter $

create trigger log_deletions after delete on Filmes
	for each row
		begin
			insert into Log_deletions values (null,old.titulo, sysdate(), user());
		end$
	delimiter ;
    
delete from Filmes where id = 2;
delete from Filmes where id = 4;

select * from Log_deletions;