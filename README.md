# Projeto RISC-V

**Projeto: RVX (RISC-V)**  
**Tecnologia: SAED 32nm**  
**Ferramenta: ICC2**

## Grupos

| Grupo | Integrantes |
|-------|------------|
| **grupo_1** | Cleber Ramires Machado, Gisele Ramires Machado, Bruna Rosa Garcia |
| **grupo_2** | Clara Luz Salles Cavalcante, Ester Gomes Pais, Suyane Melissa Soares Florencio |
| **grupo_3** | Ângelo Ferreira, Gabriel Pinós Camargo, Michel Fritsch Dick |
| **grupo_4** | Cristofer Farenzena Sanhudo, Gabriel Machado Dick, Matheus Almeida Silva |
| **grupo_5** | Augusto Kessler Pires, Júlia Mombach da Silva, Sofia Popsin Gomes |
| **grupo_6** | Kairan Mateus Lara Morandin, Vitor Hugo da Silveira Fuerstenau Maciel |
| **grupo_7** | Pedro Henrique Freitas Fleck, Rafaela Rembold Favero |
| **grupo_8** | Gabriela Silva Rublescki, Thais Marcelle Dihl da Silva |
| **grupo_9** | Fabricio Lorenzon, Gabriel Caldieraro Lencina, Pedro Marques Jaeger |


**Sem grupo definido:** Eduardo Domingo Marañon Aguilar, Fabio Benevenuti, Vinicius Patriarca Miranda Miguel

---

## Instruções

1. Crie o projeto na raiz do seu usuário
2. Para cada entrega, crie uma subpasta com o nome da entrega no google drive
3. Dentro de cada subpasta, coloque o relatório (.md) preenchido, os prints e os arquivos solicitados
4. Um flow modelo em ICC2 estará disponível nesta pasta para referência

## Estrutura esperada

```
grupo_1/
├── entrega_2/
│   ├── relatorio.md
│   ├── prints/
│   └── scripts/
├── entrega_3/
│   ├── relatorio.md
│   ├── prints/
│   └── scripts/
└── entrega_5/
    ├── relatorio.md
    ├── prints/
    └── scripts/
```

---

## Entrega 2 - Síntese Lógica + Síntese Física até Floorplan

**Prazo: 06/08 (Quinta-feira)**

### O que entregar

- **Síntese Lógica:**
  - Script de síntese lógica utilizado (ou trecho relevante)
  - Report de área pós-síntese lógica
  - Report de timing pós-síntese lógica
  - Netlist gerada (.v)

- **Síntese Física (até Floorplan):**
  - Print do floorplan no ICC2
  - Script utilizado até o passo 02-floorplan
  - Report de utilização

### Relatório (relatorio.md)

Preencher com:
- Frequência alvo utilizada
- Configuração de MCMM (corners e scenarios)
- Decisões de floorplan (shape, utilization, offset)
- Resultados obtidos (área, timing)

---

## Entrega 3 - Síntese Física Completa (sem Memory Compiler)

**Prazo: 13/08 (Quinta-feira)**

### O que entregar

- **Scripts:** todos os scripts do flow ICC2 utilizados
- **Prints:**
  - Floorplan
  - Placement
  - CTS (Clock Tree Analysis)
  - Routing (layout final)
  - Congestion map
- **Reports:**
  - report_timing (setup e hold)
  - report_power
  - report_area
  - report_clock_qor
  - DRC (report_constraints -all_violators)

### Relatório (relatorio.md)

Preencher com:
- Frequência alvo e se foi atingida
- Configuração de MCMM
- Resumo dos resultados de timing, área e power
- Violações encontradas e como foram tratadas
- Problemas de congestion (se houver)

---

## Entrega 5 - Síntese Física Completa com DFT e Memory Compiler

**Prazo: 20/08 (Quinta-feira)**

### O que entregar

- **Memory Compiler (SAED32):**
  - Configuração da memória gerada (tipo, tamanho, número de palavras, largura)
  - Arquivos gerados pelo memory compiler (.db, .lef, .v, .gds, etc.)
  - Print do layout mostrando a macro de memória posicionada

- **DFT:**
  - Script de inserção de scan chains
  - Report de cobertura de teste (se disponível)
  - Print mostrando as scan chains no layout

- **Flow completo:**
  - Todos os scripts do flow ICC2
  - Reports finais (timing, power, area, DRC)
  - Print do layout final
  - GDS final (write_gds)

### Relatório (relatorio.md)

Preencher com:
- Especificações da memória utilizada (memory compiler)
- Como a macro foi integrada ao floorplan
- Configuração de DFT (número de scan chains, estratégia)
- Resultados finais de timing, área e power
- Comparação com a entrega 3 (impacto do memory compiler e DFT)
- Dificuldades encontradas
