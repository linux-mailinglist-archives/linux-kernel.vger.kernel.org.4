Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C0662F33D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241871AbiKRLG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241346AbiKRLF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:05:57 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ED59A263
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 03:05:39 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so4768024pjk.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 03:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=boRo1TnVOEHLQmZOXc629OxRU6RPxV2doXrJlzV3Qe0=;
        b=jRqsjZmQugTVpMNpumb/8owRRdl2C2plcEPFTmuGa+uX6EpOjGBpIMaWx1bG6moqef
         qRee39MJcmqJN3WXbAsOTLDVuPle8IAGRKZLhpPpH4Nwo0CBgHfhGA4kosN3WNsdWjLN
         +eE8oHBapRxXUZmAjJ7BecZPmowIZOA6WR5unEO+bzyxn8RGtDZkGY/m5DaKtXOkbP/s
         S6ZVgfrMfAsXHIn/povynMDuuaXOcw0q6AMm/8oklQI+8gIo/vcqsPTEXMGMZG40nrM7
         J+cF2rGfueVhz5ztdBXPCkf2HDhg2I/iExikn7dSIo3Qk7AJbHSjM30/mR8CmHJtU9Ss
         x/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=boRo1TnVOEHLQmZOXc629OxRU6RPxV2doXrJlzV3Qe0=;
        b=VUk0RIuR1uqZdnardtUFepfrVnofFJMT8Q0XhLWr3UeDTzbCjRP2IAI6+5JqqnMpEp
         jTg1CFXLbZxaBnO6y24R2XPphdDVna+cIZNq4YaHf2w/9Vv+yVImSknobWfgGhPQVxh+
         koUWg5yPVawRZq99H4bfdc7H8YTyZZLemb07MSh6S4ohYREMxLWIzOA75bVGZ+rxzzNj
         kXg64GR+ivn5IsNHuBR8EBWIUnn8h8O7ktj2qNXbBn/Y98q6yX+eu3udiE1cRih15T4s
         MSNBaOoaR59gJjEdyjZN0qfdYdev6bW0KOX0i+l9utWAHrHu9LUm3nP4Uj/eL6cX0KX1
         VXcA==
X-Gm-Message-State: ANoB5pmtQRuAKEa9wMpC3czV5WCf/q4NQwNHr9LJ06mu3pSTapxe6ht4
        H8/3jUydLxeMctFT6W72uhPSbYOndX4XX42WNSM=
X-Google-Smtp-Source: AA0mqf4TLc1P2qlWTT73HEuA0gRXIBuSox+qYAySfwuxsoeD6MxjsxAbJ5KUfsUL5mJ/4lhHyPU6PeN4HunoVyuziGY=
X-Received: by 2002:a17:902:9f8f:b0:186:738e:5703 with SMTP id
 g15-20020a1709029f8f00b00186738e5703mr6939320plq.136.1668769526127; Fri, 18
 Nov 2022 03:05:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a20:6914:b0:a6:c414:2967 with HTTP; Fri, 18 Nov 2022
 03:05:25 -0800 (PST)
Reply-To: msbelinaya892@gmail.com
From:   msbelinaya <msbel88@gmail.com>
Date:   Fri, 18 Nov 2022 11:05:25 +0000
Message-ID: <CAAOqCAwfNDafsuapcPRebAc-mokh5t7F5XwS2jOk5o-O-VkARA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1033 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4811]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [msbel88[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [msbel88[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [msbelinaya892[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tarjoan sinulle yst=C3=A4vyytt=C3=A4ni ja luotan, ett=C3=A4 otat minut vast=
aan
=E2=80=8B=E2=80=8Byst=C3=A4v=C3=A4llisell=C3=A4 syd=C3=A4mell=C3=A4. T=C3=
=A4m=C3=A4 sai minut ottamaan yhteytt=C3=A4 h=C3=A4neen ja
katsomaan, kuinka voimme auttaa toisiamme. Olen rouva Kodjovi Hegbor
Turkista ja ty=C3=B6skentelen operatiivisena johtajana
StandardBNP Bank Limited Turkki. Uskon, ett=C3=A4 Jumalan tahto on l=C3=B6y=
t=C3=A4=C3=A4
sinut nyt. Minulla on t=C3=A4rke=C3=A4 liike-el=C3=A4m=C3=A4n keskustelu, j=
onka haluan
k=C3=A4yd=C3=A4.
Jaan yhden, josta uskon sinun olevan kiinnostunut sellaisenaan

yhdist=C3=A4t sukunimesi ja hy=C3=B6dyt siit=C3=A4. Vuonna 2018 Ivan, maan
kansalainen, siirsi 8 400 000,00 puntaa ulkomaiselle tilille
pankissani 36 kalenterikuukaudeksi. T=C3=A4m=C3=A4n talletussopimuksen
p=C3=A4=C3=A4ttymisp=C3=A4iv=C3=A4 oli 16. tammikuuta 2021. Valitettavasti =
olin yksi
Kiinassa =C3=A4skett=C3=A4isen 2019-2020 koronaviruspandemian (Covid19) uhr=
eista
ollessani
ty=C3=B6matkalla, joka tappoi ainakin 68 000 ihmist=C3=A4. Pankkip=C3=A4=C3=
=A4llikk=C3=B6ni ei
edes tied=C3=A4 h=C3=A4nen kuolemastaan, h=C3=A4n tiesi, koska h=C3=A4n oli=
 yst=C3=A4v=C3=A4ni ja
oli tilivastaava, kun h=C3=A4nen tilins=C3=A4 avattiin ennen ylennyst=C3=A4=
ni. Herra
Iv=C3=A1n ei kuitenkaan mainitse sukulaisia/perillisi=C3=A4. kun avasin til=
in ja
kun en ollut naimisissa, minulla oli lapsia. Viime viikolla pankin
johto antoi minulle ohjeet, mit=C3=A4 tehd=C3=A4 varoillasi, jos jatkan
sopimustasi. Tied=C3=A4n, ett=C3=A4 l=C3=A4hden ja etsin tapaa ratkaista ti=
lanne,
koska jos pankinjohtajani saavat tiet=C3=A4=C3=A4, ett=C3=A4 Ivan on kuollu=
t ja h=C3=A4n
ei ole, he ottavat varat henkil=C3=B6kohtaiseen k=C3=A4ytt=C3=B6=C3=B6n ja =
n=C3=A4in h=C3=A4n on
poissa. ei. Haluan j=C3=A4tt=C3=A4=C3=A4 sen, se tapahtui. Se oli viimeinen=
 kerta,
kun n=C3=A4in sinut. nimi, ett=C3=A4 h=C3=A4n on onnellinen ja nyt olen pyy=
t=C3=A4nyt
h=C3=A4nen apuaan esitell=C3=A4kseni h=C3=A4net sukulaiseksi/tilin perillis=
eksi ja
ett=C3=A4 h=C3=A4nell=C3=A4 on sama sukunimi kuin h=C3=A4nell=C3=A4 ja pank=
kini vapauttaa h=C3=A4nen
tilin. Ei riskej=C3=A4; kauppa tapahtuu laillisen sopimuksen perusteella
Se suojaa sinua kaikilta lain rikkomuksilta. esitet=C3=A4=C3=A4n
rahapankkijohtajilla on varaa kantaa, on jo rikas.
En ole ahne, joten ehdotan, ett=C3=A4 jaamme varat tasan,
50/50% molemmille osapuolille, osuuteni auttaa minua perustamaan oman
yrityksen ja
K=C3=A4yt=C3=A4n hyv=C3=A4ntekev=C3=A4isyysmenettely=C3=A4, joka on ollut u=
nelmani. Kerro minulle
Harkitse tarjoustani, tarvitsen todella apuasi t=C3=A4ss=C3=A4 liiketoiminn=
assa.
Valitsin sinut auttamaan minua, en ty=C3=B6si vuoksi, vaan Jumalan vuoksi.
Haluan sinun varaavan aikaa rukoillaksesi t=C3=A4m=C3=A4n viestin johdosta.
Ole hyv=C3=A4 ja kerro mielipiteesi ennen kuin otat meihin yhteytt=C3=A4 ja
k=C3=A4sittele n=C3=A4it=C3=A4 tietoja NIIN LUOTTAMUKSELLISENA. Kun saat va=
stauksen,
tiukasti
Annan kaupan yksityiskohdat henkil=C3=B6kohtaisen s=C3=A4hk=C3=B6postiosoit=
teeni
kautta msbelinaya892@gmail.com. Ota kopio rahaston
talletustodistuksesta a
my=C3=B6s ote tietueet tuottavan yhti=C3=B6n kaupparekisterist=C3=A4. Jumal=
a
siunatkoon sinua, odotan pikaista vastaustasi. Yst=C3=A4v=C3=A4llisin terve=
isin,
rouva.
Kodja Hegbor msbelinaya892@gmail.com
