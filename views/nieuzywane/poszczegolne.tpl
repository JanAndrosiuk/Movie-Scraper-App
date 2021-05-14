% rebase('base.tpl', title='Szczegoly')
{{!zawartosc or ''}}

% 
<div>
<h3>{{produkty[produkt]["nazwa"]}}</h3>
<p>cena: <b>{{produkty[produkt]["cena"]}}</b></p>
<p>opis: {{produkty[produkt]["opis"]}}</p>

% for key in produkty.keys():
<div>
% if (key != produkt):
<a style="text-decoration:none" href="http://localhost:8001/produkty/{{key}}/">wiecej informacji o {{produkty[key]["nazwa"]}}</a>
</div>
% end
% end

<p></p>
<a style="text-decoration:none" href="http://localhost:8001/produkty/">Powrot do wszystkich produktow</a>
<div>
<div>
<a style="text-decoration:none" href="http://localhost:8001/">Strona glowna</a>
</div>
% end
