Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C0068A9EC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 14:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjBDNIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 08:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjBDNIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 08:08:04 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C03028846;
        Sat,  4 Feb 2023 05:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1675516042;
        bh=4d6uDZEW3xj/itubMwviUpA+yDytdRhgIPQgLyFYiNw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=k5r/S7UzGLA1U3fBnx5W7kjfmm5TCMeKoVVW3kTdtNDu3SXz39YjMhoaqNR3TcXfp
         J6p6R3D69BY/pBNWiQ1AB5/R7/zhWU/bgAg/DnD/pF2N1aRyQ5L2y7oQ35DNYbgNw+
         qmOuIE7Znvwmdi4UcbzCJqp8G48jH9xlYsQytbEuTrMS8smrJEJx3bNdPPasboAl3Y
         W3scERnjaF/I0+NHLPvLAWIhu9FQsHfoTwnc9QBDAxHwDPzYyP3kdL1d1LV7ZYPliS
         udIPW3ZdAQCgGhhd/44d+n7pEaPf3pmOYUfBHvj2ih5fNniVrOwgUsBnSaVfogUBxi
         rzDQEdlkRaDqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [157.180.225.92] ([157.180.225.92]) by web-mail.gmx.net
 (3c-app-gmx-bs72.server.lan [172.19.170.208]) (via HTTP); Sat, 4 Feb 2023
 14:07:22 +0100
MIME-Version: 1.0
Message-ID: <trinity-3c3b11eb-2503-4637-b8f6-05686bd1ad88-1675516042495@3c-app-gmx-bs72>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     =?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Cc:     arinc9.unal@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        erkin.bozoglu@xeront.com, Sean Wang <sean.wang@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>
Subject: Aw: Re:  Re: [PATCH v2 4/5] arm: dts: mt7623: mux phy0 on Bananapi
 BPI-R2
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 4 Feb 2023 14:07:22 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <f628db9c-cf61-e1bc-2160-0c8d1caa0fbe@arinc9.com>
References: <20230201185656.17164-1-arinc.unal@arinc9.com>
 <20230201185656.17164-5-arinc.unal@arinc9.com>
 <AC473057-266B-4403-9270-8007E0EC257C@public-files.de>
 <75d3758a-5502-03a4-b3a2-990f9339705b@arinc9.com>
 <trinity-ec3920c5-a96a-4edf-9ff1-4bf07e7b4d07-1675506452617@3c-app-gmx-bs72>
 <trinity-a01f321e-0973-417e-9a25-9350f63ece37-1675511027203@3c-app-gmx-bs72>
 <f628db9c-cf61-e1bc-2160-0c8d1caa0fbe@arinc9.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:2f7IPHsaQ3ie6c1OE7RdMDBst8fc99xmyWkxGQE6mdqo3Q9nkhqgDxT2q2YVhWGBY+8f1
 g+JJx9fkzmOXlVO49aU2pPjHRK0SEhIGOjEgi74WgwpCnl9P+u3mPT9SNeAaacqq4zeSAQ/+6+Qz
 SZ4e7h1zFScV98n4fr1CUbOYsXBuKVs7ybmXfUoNR2PyCIXZ1Zp3fl2k+QJ9PnjpxFbvjSzGX8Ad
 NLCFWe75a+hjtzX9Lh+wRKEmilHv5ssDpQTphdtdU51du+6AwnZ7dMScQvxTh2pkFERcEuq7znyF
 Ls=
UI-OutboundReport: notjunk:1;M01:P0:cJEiZ27hpLg=;y/wlEQMmdnR8E/AxCLSuhWSxKIS
 UfDyP6HUnDlHi3NsaCaauT0KK15iFA1Qw0XAHFNZzjnKyzWX+QEjxoHKTGf0XjwZb73PjYQeB
 TioacBowbdM5W9IcQJ/vlnybkg6+AlAI8z2cWmOXWOtRw5vSfpI9S94IIibqgbOa/h3ocHL7g
 1WzHFUd4GPDGrVfv6XQnBvIL+b1tSIdlAiiyekbV/z53ukK+vtxK4uEVz/2lGVxJEPjs6o6gD
 H7UXTVAJ6dP1fXAM9vITmtAmt87M8unOQpAHwksdh09HVNqe3OaNtR2/xKNGmYGPCGW149H5+
 jOUpn9g8uErT6aZApGwf09u4legp9OkdvQL26hX/zbqlvDfWLRRYubUmAso4F9NjXcfqYIK6K
 mFmwmIE6m8gB+kRmD2Dfj5azf139Qu5Ys78/yf/ExxvU48kY6si5iC+7Bc9E7x7AZtqo2IFgz
 vMDaCB6FN5NbMEtNO7BdYIyb8zfB1zmgndYZt/z/4QoCfuQ5Wvjf1iKgVbBpaOdOBihne0ldI
 f9gn9jO2C7WfMBsQKxPucbVJIyV9XWDLQmvPnGHa8gtnSfT65Q708uWW9JeYLS64y31NxIRcN
 hgc2rbRSpUoHTcT8voSrlB7AeEzTJyHaSdrgXtMhrLjLteJ6GZEa+DCKRa6CbGbzt7ZENo/69
 jESVmMTCOQa1cL5Gg5a0KBJHTq9ryEM6J6xDuV085d6+1PkFWBVHzASeTQcyKLvaJqmDCMydG
 8Ag7Y5FxcuyaZ6BYcOX64Y3J0tILrjqh9ZJ+m9za+vQAczx5LpSLiiaudFSpOS9a41PbGrUbu
 nhi4yCFGT6zjOBUfO66H11dQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Gesendet: Samstag, 04=2E Februar 2023 um 13:12 Uhr
> Von: "Ar=C4=B1n=C3=A7 =C3=9CNAL" <arinc=2Eunal@arinc9=2Ecom>
> An: "Frank Wunderlich" <frank-w@public-files=2Ede>
> Cc: arinc9=2Eunal@gmail=2Ecom, "Rob Herring" <robh+dt@kernel=2Eorg>, "Kr=
zysztof Kozlowski" <krzysztof=2Ekozlowski+dt@linaro=2Eorg>, "Matthias Brugg=
er" <matthias=2Ebgg@gmail=2Ecom>, devicetree@vger=2Ekernel=2Eorg, linux-arm=
-kernel@lists=2Einfradead=2Eorg, linux-mediatek@lists=2Einfradead=2Eorg, li=
nux-kernel@vger=2Ekernel=2Eorg, erkin=2Ebozoglu@xeront=2Ecom, "Sean Wang" <=
sean=2Ewang@mediatek=2Ecom>, "DENG Qingfang" <dqfext@gmail=2Ecom>
> Betreff: Re: Aw: Re: [PATCH v2 4/5] arm: dts: mt7623: mux phy0 on Banana=
pi BPI-R2
>
> On 4=2E02=2E2023 14:43, Frank Wunderlich wrote:
> >> Gesendet: Samstag, 04=2E Februar 2023 um 11:27 Uhr
> >> Von: "Frank Wunderlich" <frank-w@public-files=2Ede>
> >> An: "Ar=C4=B1n=C3=A7 =C3=9CNAL" <arinc=2Eunal@arinc9=2Ecom>
> >> Cc: arinc9=2Eunal@gmail=2Ecom, "Rob Herring" <robh+dt@kernel=2Eorg>, =
"Krzysztof Kozlowski" <krzysztof=2Ekozlowski+dt@linaro=2Eorg>, "Matthias Br=
ugger" <matthias=2Ebgg@gmail=2Ecom>, devicetree@vger=2Ekernel=2Eorg, linux-=
arm-kernel@lists=2Einfradead=2Eorg, linux-mediatek@lists=2Einfradead=2Eorg,=
 linux-kernel@vger=2Ekernel=2Eorg, erkin=2Ebozoglu@xeront=2Ecom, "Sean Wang=
" <sean=2Ewang@mediatek=2Ecom>, "DENG Qingfang" <dqfext@gmail=2Ecom>
> >> Betreff: Aw: Re: [PATCH v2 4/5] arm: dts: mt7623: mux phy0 on Bananap=
i BPI-R2
> >>
> >> Hi aranc,
> >>
> >> have tested this series, basicly it works, but i get only ~620 Mbits/=
sec (much more i will need on wan) in tx-mode of r2, rx-mode (iperf3 -c IP =
-R on r2) gets full 939 Mbits/sec=2E Both no retransmitts=2E
> >>
> >> tried with my laptop which gets 940Mbit/sec in tx mode too=2E=2E=2Eot=
her end is a R2 with 5=2E15 connected to lan0 (and eth1+aux enabled, dmesg =
clean so far=2E=2E=2Efor the "kernel log flooded"-comment)=2E
> >>
> >> maybe gmac1 needs to be tweaked a bit (clock-settings)?
> >>
> >> can you confirm this with your board?
> >=20
> > tested the vlan_aware way with 5=2E15=2E80 and got better result
> >=20
> > ip link add br0 type bridge vlan_filtering 1
> > ip l set aux master br0
> > ip l set wan master br0
> > bridge vlan add vid 99 dev wan
> > bridge vlan add vid 99 dev aux
> > bridge vlan
> > ip l s eth1 up
> > ip l s wan up
> > ip a a 192=2E168=2E0=2E11/24 dev eth1
> > ip l s br0 up
> > ip l s aux up
> >=20
> > i see traffic on eth1 increasing and iperf3 shows in both directions ~=
940Mbit/s, no strange mesages in dmesg while testing=2E=2E=2Ewhere do you s=
ee these?
>=20
> You didn't put eth1 on a bridge=2E I suggest you read my mails with high=
er=20
> attention so both of our time is spent efficiently=2E

sorry if i misseed this detail, but it was not part of the instructions i =
got from mtk and did not found it in our mail-conversion=2E why do i need t=
o add the gmac into the bridge??

the gmac is connected physically to mt7531 p5, and my vlan_aware bridge br=
idges this port (aux=3Dp5) with wan,=20
so i see no need to add eth1 to this bridge too=2E=2E=2Etraffic on wan is =
tagged with vlan 99 and leaving untagged
on aux which is arriving eth1=2E=2E=2E

> > tested vlan-way with 6=2E2 and felix' Patches to more comparable with =
your test=2E=2E=2Eand got same result (~625Mbit/s in tx and 940Mbit/s in rx=
-mode=3D-R on r2)=2E=2E=2Eso it seems anything between 5=2E15 and 6=2E2 red=
uced gmac1 tx bandwidth=2E
>=20
> I don't see an incentive to investigate unless the issue is confirmed on=
=20
> a daily netdev/net-next=2Egit main tree=2E

have same result on net-next/main with your series, no additional patches =
on top except adding my build-script and defconfig=2E

> >=20
> > to summarize:
> >=20
> > i get same result with your patches and my old vlan_bridge way with sa=
me codebase=2E=2E=2Ehow do i see your problem with the vlan-bridge-way? Do =
you test with bpi-r2 or only any other board and change r2 to have same DT?
>=20
> I tested this only on a Bananapi BPI-R2 using the devicetree with this=
=20
> series applied on a few days old netdev/net-next=2Egit main tree=2E

btw=2E i do this in my currently very limited free time in short chunks, s=
o please forgive me if i miss a detail=2E

> Ar=C4=B1n=C3=A7
