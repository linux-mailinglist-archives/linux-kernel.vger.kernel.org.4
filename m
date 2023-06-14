Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294EE7307B7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbjFNTCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjFNTCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:02:22 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCAB1BE9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 12:02:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b4f95833c7so7523385ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 12:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686769341; x=1689361341;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Frj1We9PT5qe7Tl5HvPtS7b9Siv1Bn/lyZPCJ/I6GyY=;
        b=Yup4g8vMcxGnLshflLizaos0R3gjZ6KGRdWzPJNklaIT0xagKS0aZhltmtEwJJE9Mt
         fNeQpQr4BhQji0ckJA3HKm3K5ZQxoJubcK9BlqGhhaR5p8ejtcb7FkME1WksIOgTemKY
         00TCS1QzFoW4iLoYxoYA3gxeDQHT1IR5a7leTELl2lE1aUO29d+zaz3A0EMd45q4Lbqw
         8xQlytYf3/waZtD+0DM6Kfumr5/uklRVAk7EqqZ/BleDVYKS+bPAjGYyobVh+rP3dCmf
         2065fXGzZns2Rs7VK9VChYFuw3PeuCj8yVKaDya5bDq58ywIBqWgsvkOpZAFg9K/8VYh
         6gcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686769341; x=1689361341;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Frj1We9PT5qe7Tl5HvPtS7b9Siv1Bn/lyZPCJ/I6GyY=;
        b=GR67ew0BfK6TqH5sCgjr5HBHbjbwNbhzONMMoGpq44kMJPlJOk7ajemUilgND7m9gp
         njyQzuP25sKOc6wkqpr8VQ7eXDVntGF9EiYQBjcrpyhs4ByNxq5ASqkp6SkR7xGqju5V
         ickkyyXxB/BgyrAeiR/lLNRIA+LclAToA++BK/XFq81pCwwgsG6zlsSj2qdujxLxqpHQ
         sPTXGIFhyY6PBQpY9oxxawKE662QJFVH9aeZPI86/6edYbHqmpEREyJ3KXpcKoDhgoot
         +tvHdWc27cyJGAgJWkHlxASFwWQ4VPIToHmmlW+eKmc2s62t6wBfblhvyY/hGAzib8/d
         3qyQ==
X-Gm-Message-State: AC+VfDx306JO5K6/IX9fZcb3ZbdAwuARHr+1yPvGhUvTNgKpqB+/wjn/
        ztf9nHcSifshWYtYZX2pTngrZtMkuzMk9mcA/Wc=
X-Google-Smtp-Source: ACHHUZ6KJ6fU3EH68z93w0/SVmuwwmLEN/qHEt0Lr+1+3u9CX4XQDqKvGJXddUmWMSQRMle69bytFr+hbTi7RpSMHxQ=
X-Received: by 2002:a17:90b:4f82:b0:253:38bf:9757 with SMTP id
 qe2-20020a17090b4f8200b0025338bf9757mr1981608pjb.43.1686769341270; Wed, 14
 Jun 2023 12:02:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a06:2602:b0:606:7a32:8349 with HTTP; Wed, 14 Jun 2023
 12:02:20 -0700 (PDT)
Reply-To: www.ubabankheadoffice@gmail.com
From:   "bedrisekalexej@gmail.com" <bedrisekalexej@gmail.com>
Date:   Wed, 14 Jun 2023 12:02:20 -0700
Message-ID: <CAFFa7ByyDCKdWB9YiNXV+9jhLkxDp526b33x2C+=WG0Sr4aJBg@mail.gmail.com>
Subject: =?UTF-8?B?xb5pdmpv?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pozor upravi=C4=8Denca,

To e-po=C5=A1tno sporo=C4=8Dilo prihaja neposredno od skupine odbora za boj
proti goljufijam Urada Afri=C5=A1ke unije (AU) Republike Togo v sodelovanju
z delovno postajo Zdru=C5=BEenih narodov (ZN) Lome-Togo, razred P-4 Post-AF
=C5=A0tevilka / RP/RDBCPN/SHS /0001.v zvezi z obse=C5=BEnim zbiranjem
(aretacijami) internetnih goljufov. Zaradi velikega =C5=A1tevila prito=C5=
=BEb,
ki jih prejemamo od Zdru=C5=BEenih narodov (ZN) na ravni goljufov/goljufov
z afri=C5=A1kimi narodnostmi. Vsi ponudniki internetnih storitev so opazili
pove=C4=8Danje e-po=C5=A1tnega prometa iz Afrike na druge celine.

V tej akciji je bilo do zdaj prijetih 306 (306) goljufov in ta akcija
=C5=A1e vedno poteka. Povrnili smo skupno 857 milijonov dolarjev v gotovini
in premo=C5=BEenju, za katerega je potrjeno, da izvira od njegovih =C5=BErt=
ev.
Na=C5=A1li smo na sto tiso=C4=8De e-po=C5=A1tnih naslovov =C5=BErtev iz nji=
hovih imenikov.
V tem =C4=8Dasu vas bomo kontaktirali.

Ve=C4=8Dkrat smo neuspe=C5=A1no posku=C5=A1ali vzpostaviti stik z vami, zat=
o vam
po=C5=A1iljamo ta zadnji opomnik, da od=C5=A1kodninska komisija Zdru=C5=BEe=
nih
narodov ne bo imela druge izbire, kot da odpi=C5=A1e va=C5=A1 denar v vi=C5=
=A1ini
750.000,00 $ od=C5=A1kodnine in ga ozna=C4=8Di. ker ni obvezno, zato vas
prosimo, da nemudoma odgovorite na to pismo, da pojasnite svoje
stali=C5=A1=C4=8De glede te zadeve, preden bo prepozno, ukrepajte hitro in
sledite navodilom v svoje dobro. Ve=C4=8D podrobnosti bo na voljo, ko se
obrnete na United Bank of Africa Lome, Togo

=C2=BBDanes vas obve=C5=A1=C4=8Damo, da je banka UBA nakazala va=C5=A1 dena=
r na va=C5=A1o
kartico VISA in je tudi pripravljena za dostavo.
Obrnite se na generalnega direktorja Banco UBA zdaj
Ime................. Gospa Viviana Francis
E-po=C5=A1tni naslov ........ www.ubabankheadoffice@gmail.com

Njegove podatke je omenil eden od sindikatov, ki so ga aretirali kot
eno od svojih =C5=BErtev operacij. S tem vas opozarjamo, da jim tega
sporo=C4=8Dila iz kakr=C5=A1nega koli razloga ne posredujete ali podvajate,=
 saj
na=C5=A1 agent tajne slu=C5=BEbe ZDA =C5=BEe sledi drugim kriminalcem.

Po=C5=A1ljite naslednje podatke, da vam akreditirano kartico VISA ATM
dostavimo na va=C5=A1 naslov.

Va=C5=A1e polno ime=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
Va=C5=A1a dr=C5=BEava izvora=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
Va=C5=A1 naslov =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
Elektronski naslov =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
Va=C5=A1a telefonska =C5=A1tevilka =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
Tvoja starost =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
Va=C5=A1 spol =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
Va=C5=A1 poklic =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

N/A; Zato vas prosim, da se mi nemudoma oglasite =C5=A1e danes, da lahko
nemudoma za=C4=8Dnemo z vsemi potrebnimi postopki in protokoli za
sprostitev va=C5=A1ega od=C5=A1kodninskega sklada.
S spo=C5=A1tovanjem,
Urad skupine za boj proti goljufijam podru=C5=BEnice Afri=C5=A1ke unije (AU=
) v
Republiki Togo
