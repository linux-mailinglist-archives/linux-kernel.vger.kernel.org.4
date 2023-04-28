Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081C36F1F71
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346081AbjD1UeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjD1Ud7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:33:59 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E356F59D0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:33:22 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-74db3642400so22620585a.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682714001; x=1685306001;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RTYsdnb3XWNHNFKshQ5YLmNW4QB6EHQGAfUnwG76TeE=;
        b=nHRDgHjAk/p7MMPsPd5WlQaPvOFfGYKDqG3nJNSeGblSDpe2R/5f42/SJ2tJubcWu8
         tNP/qVQlU5ZDJtKtwCcGaPSxDmr1bcgnPwTB56R1o54n5/FVP9qnPPj+kMEnUMgOOqhn
         +uxyknSS/ODO+6hHlrtL9zdmjDGzubb7pRopWYnPmGbcdlDfqV3Ma02UIHmsHIxX8kwU
         k4gvNnlYZEuIpXFLtd9MW5gwU/0X8JmGUh99jm/j4vqv2iQQ6p3jZDB0lXMIO2no9qxC
         wSkokZA3TCMggYJ193N68yxlJrj++2evWOdfPlABUukXqc+rpOZG7TZn9RMf2XJvP4yp
         /WuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682714001; x=1685306001;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RTYsdnb3XWNHNFKshQ5YLmNW4QB6EHQGAfUnwG76TeE=;
        b=Tn/zt9Jtf3tXACk4/wCOg1DwOyvsPJcc4wlytvQPOEjwqejeVfmg+Xdu0Qa16COZY2
         /HANMh2lDv03UmLQtEK9DAHDB8hNasdaMkwb95F2cKc8oaFZL3020wqzijS8K4zxrBK2
         wgK4ioK9Ma5NHFLatN+Io+KZT3Mt4fFVUmIvowr6g7A6iYTntq8gQSD2nngsGJyRIWNT
         dhHk5t0XKpPMhx3EmJApmZQ9XzMxUuIgdPqly2xkSTgfqrM2qXVah8d51RbXhwqlIVMe
         Z4LdFGV39dZ7j412LOdrZAotJEBXOHROFGrIN4usuSLylpn9kSatNLHpHmX0VSMTW3CK
         P7Nw==
X-Gm-Message-State: AC+VfDydPf7aL8JJbcfXZJUg8oWqPBKwMOvbPHQFSR2H6PfT+1l1+iAo
        yfu/Tnp44UNKeIfjBYm2HCm5W5pKs/MvfGqGQ3Y=
X-Google-Smtp-Source: ACHHUZ4F4Rui61tNibL45YZSb71vm2ovME613w8k8GW7tcCq2FSsxw+C+4VUVEuG+i4e86nybshhZ5nde9pRcOjhWtg=
X-Received: by 2002:a17:90b:18e:b0:247:6022:9595 with SMTP id
 t14-20020a17090b018e00b0024760229595mr6342732pjs.45.1682713561462; Fri, 28
 Apr 2023 13:26:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:b710:b0:3dd:5e4e:dd43 with HTTP; Fri, 28 Apr 2023
 13:26:00 -0700 (PDT)
Reply-To: Info.americaatmbank@gmail.com
From:   UNITED BANK OF AMERICA <unitedbankunitedbank84@gmail.com>
Date:   Fri, 28 Apr 2023 13:26:00 -0700
Message-ID: <CAA9iZpCVHndwt=Tn109MgKLh_NzE1dh--DFHza-VXhfPA3W8Kg@mail.gmail.com>
Subject: =?UTF-8?Q?T=C3=84HELEPANU?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terrorismivastase v=C3=B5itluse ja kuritegevuse kontrolli osakond
J. EDGAR HOOVER HOONE 935 PENNSYLVANIA AVENUE,
Washingtoni loodeosa, D.C.
Viitenumber: 20535-0001

HEAD UUDISED

V=C3=B5tan teiega =C3=BChendust e-posti teel, kuna minu arvates on k=C3=B5i=
ge =C3=B5igem
ja sobivaim selgitada, miks ma teiega =C3=BChendust v=C3=B5tan.

Olen eriagent proua Joyce Hook, =C3=A4sja ametisse nimetatud Ameerika
=C3=9Chendriikide FBI pettuste uurija, kes t=C3=B6=C3=B6tab koos Ameerika
=C3=9Chendriikide kriminaaljuurdlusosakonna (CID) pettuste =C3=BCksusega.

Olen spetsialiseerunud fondide, sealhulgas [h=C3=BCvitis-/p=C3=A4rimisfondi=
d v=C3=B5i
L=C3=84HEDASED], saadetiste fundamentaalsetele uurimistele
Box, Lotto=C2=AE JACKPOT, LAENUD] ja olen m=C3=A4rganud, et olete saanud
Paljud meilid p=C3=A4rinevad inimestelt, kes v=C3=A4idavad, et nad saavad t=
eile
raha, kuid ma soovitan seda, kui olete m=C3=B5nega neist endiselt =C3=BChen=
duses
Siiski soovitame teil esialgu igasugune suhtlemine l=C3=B5petada, sest
nende inimeste kohta on tehtud uurimist ja need on petturid.

Tahaksin kuulutada meie l=C3=A4biviidud uurimise eduks
Paar p=C3=A4eva tagasi; Arvasin, et oleks kasulik teada, miks see uurimine
pooleli on. Teabe saamiseks on t=C3=B5esti kinnitatud, et teil oli 100%
=C3=B5igustatud tasumata tehing ja teie
Teil on t=C3=A4ielik =C3=B5igus seda raha n=C3=B5uda, kuna on kinnitatud, e=
t olete
nimetatud 2,6 miljoni dollari v=C3=B5i h=C3=BCvitise/p=C3=A4rimisfondide =
=C3=B5igustatud
saaja v=C3=B5i l=C3=A4hisugulane, kuid selle raha k=C3=A4ttesaamise viibimi=
se t=C3=B5ttu
on teie raha n=C3=BC=C3=BCd kinnitatud 2,6 miljonit dollarit on heaks kiide=
tud
USA dollari eest, mille maksab siin Ameerika =C3=9Chendriikide (USA)
presidendi kantselei.

Teatan sellest t=C3=A4na, kuna m=C3=A4rkasin, et te ei suhtle seadusliku
isikuga, kes vastutab selle raha teile k=C3=A4ttesaamise eest. See reklaam
peaks olema teile avatud, kuid teid v=C3=B5ivad petta need hoolimatud
kurjategijad, kellele olete =C3=BChe v=C3=B5i teise kasti hankimisel raha
saatnud, mis pole reaalne, mist=C3=B5ttu otsustasin aidata teil raha saada
otse FBI-st. Ma tean, et kui olete huvitatud oma 2,6 miljoni USA
dollari suuruse tasumata seadusliku raha vastuv=C3=B5tmisest, soovitan teil
kohe minuga =C3=BChendust v=C3=B5tta. K=C3=B5ik, mida ma vajan, on teie koo=
st=C3=B6=C3=B6 ja
m=C3=B5istmine.

V=C3=B5tsime =C3=BChendust United Bank Of America'iga Ameerika =C3=9Chendri=
ikides
(USA), et t=C3=B6=C3=B6delda teie raha panga=C3=BClekandega. Raha kantakse =
otse teie
kontole.

V=C3=B5tke =C3=BChendust United Bank Of America direktoriga alloleval e-pos=
ti
aadressil, kelle nimi on

Proua Cox Pamela
E-posti aadress: (info.americaatmbank@gmail.com)
Ameerika Pank

Saatke talle allpool oma pangakonto andmed, et ta saaks teie kogu raha
=C3=BCle kanda.

1. Teie t=C3=A4isnimi =3D=3D=3D=3D=3D
2. Konto number =3D=3D=3D=3D
3. Panga nimi =3D=3D=3D=3D
4. Panga aadress =3D=3D=3D=3D
5. Riik =3D=3D=3D=3D
6. Telefoninumber =3D=3D=3D=3D
7. IBAN =3D=3D=3D=3D
8. ID-kaart =3D=3D=3D=3D
9. Sinu amet =3D=3D=3D=3D
10. Vanus =3D=3D=3D=3D
11. Sugu =3D=3D=3D=3D
12. Sinu L=C3=A4him Sugulane =3D=3D=3D=3D

Lugupidamisega
Proua Joyce Hook
=C3=84sja ametisse nimetatud USA
(USA) FBI pettuste uurija
