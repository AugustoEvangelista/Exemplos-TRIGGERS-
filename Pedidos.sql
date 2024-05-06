CREATE TABLE Pedidos(
	IDPedido INT auto_increment primary key,
	DataPedido datetime,
    NomeCliente varchar(100)
);

insert into Pedidos(DataPedido, NomeCliente) values
(NOW(), 'Cliente 1 '),
(NOW(), 'Cliente 2 '),
(NOW(), 'Cliente 3 ');

DELIMITER $
CREATE TRIGGER RegistroDataCriacaoPedido
before insert on Pedidos
for each row
begin
	set NEW.DataPerdido = now();
end;
$
DELIMITER ;

insert into Pedidos (NomeCliente) values ('Novo Cliente');

select * from Pedidos;