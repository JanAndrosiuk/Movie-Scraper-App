% rebase('base.tpl', title='Produkty')
{{!zawartosc or ''}}

% for key in produkty.keys():
<div>
<h3>{{produkty[key]["nazwa"]}}</h3>
<p>cena: <b>{{produkty[key]["cena"]}}</b></p>
<a style="text-decoration:none" href="http://localhost:8001/produkty/{{key}}/">szczegolowe informacje o {{produkty[key]["nazwa"]}}</a>
<div>
% end
<p></p>
<div>
<a style="text-decoration:none" href="http://localhost:8001/">Strona glowna</a>
</div>
