Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797C868A9AF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 12:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjBDLoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 06:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBDLoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 06:44:16 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140671C58A;
        Sat,  4 Feb 2023 03:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1675511027;
        bh=1SAICf6ftRetupzn8o/MGmN59atV8iff6TAq9xs42qA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=laZ/DjlRB0U/ZrcehEN3Bpym2vxEypIJGu30kXtSWkAk4KQ/oujAICrcjT4NtRazu
         xaizTXVBL0l3Rsh3Lgn4DTRVzWZdq/IJ1oxwM48pb60gnSzLEpD6d7PGG9hYN5oEP8
         CXJjB7h1PvmYKDDPBYgy+rNQY4cDNG2hxF4j2dhyeAt9SKdc90UldwWIHZDCYhLGA+
         PWUmaR/JrTUO/2OU81L9coCIQRqCpDqmUikCAbFZZWlVAioR7sZYAA0F9n6S1uav1W
         tUXk5/TEDV/YoVKnO9CgdALg4pQW7czDKRotC2GwLjPOS037VNEm8wI7v9XbCjR9Z6
         H4dhtdssh4wOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [157.180.225.92] ([157.180.225.92]) by web-mail.gmx.net
 (3c-app-gmx-bs72.server.lan [172.19.170.208]) (via HTTP); Sat, 4 Feb 2023
 12:43:47 +0100
MIME-Version: 1.0
Message-ID: <trinity-a01f321e-0973-417e-9a25-9350f63ece37-1675511027203@3c-app-gmx-bs72>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     =?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Cc:     arinc9.unal@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        erkin.bozoglu@xeront.com, Sean Wang <sean.wang@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>
Subject: Aw: Re: [PATCH v2 4/5] arm: dts: mt7623: mux phy0 on Bananapi
 BPI-R2
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 4 Feb 2023 12:43:47 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <trinity-ec3920c5-a96a-4edf-9ff1-4bf07e7b4d07-1675506452617@3c-app-gmx-bs72>
References: <20230201185656.17164-1-arinc.unal@arinc9.com>
 <20230201185656.17164-5-arinc.unal@arinc9.com>
 <AC473057-266B-4403-9270-8007E0EC257C@public-files.de>
 <75d3758a-5502-03a4-b3a2-990f9339705b@arinc9.com>
 <trinity-ec3920c5-a96a-4edf-9ff1-4bf07e7b4d07-1675506452617@3c-app-gmx-bs72>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:je28Vgya+fG0CeQ41N1guRNJnqTPYl7eWFL8WJPyOsVsB42t2SnaSgzP1w8TqLX9oKuvS
 tWUtwSNaJa0LSWszzbXCdeEz/fmV9fQlzEOKLSLIuE7gmXGknRnNU2WxMEnWAFBXKiy5IBRuqgEx
 +eGRMUq/z3x7Va2fuG1RJy+aZAUkywlLBaRc/EHoZfQLFsaZwU+luAMynYkeQyTmu/Uz4MaqGUbM
 wXpWA+5qGgAGnH/llGT9PWi7L5XJx4wvFyRzFE7lVfAf0KPzpWi4Bbs4ujfG+sdn23A0iB1kXXaR
 HU=
UI-OutboundReport: notjunk:1;M01:P0:OQ1pkurxuh0=;+Q3GeHXPMZieXEajDBzteEgp7gp
 CI7M7d2DIPtovKnJNTiQtRw/gBbyiww0i7qINYBXezFiBFozr6UjIWTqM0/SZibGNKR/lpnqA
 03JRLxUoCf9FI+1BmWEy3fRokQ+96vj/c4X/9dmH843eS4RVruWeHN43FsvkBsEDgokhd+DyJ
 lOlx+Yzvwi9IUuijn057ey4qFZ1JyCKj6fMdL+4OEMpkUdNQZt+dcl/Ih0NY2mweYC4cyjBSe
 xsLffTV2Tm+ZnZnycCluGhJYXY5837LG4Ec6LjeUxY15DGJSnSKMM1fVCdQNp51QTcaaWI4CH
 HomtwREo99e62BWbcg4UtdGJrMWCff6SxSPgjblcdbgw/FxpMu60ytegm6vrobh49K9gq+CQI
 3LkHeHWA3ZgItcmImS1BD18E1+jS2NzytUk0kWblVyYZoRvS2zQ8OL6EiOehnInCOzXTSXiTc
 i5alPylFSWj8w4ND296/7pkSe2LXHWpz+s2+OpuKFmALeKiTYLPsV6JrHWr94PBBHFZcZDxSb
 ea9MbeZp0sgTBGR7bp1gbpNrzffqGnLLAYj7IhFXsZnXNj5dW5S5qr4kPgK0yw/tT7t3lWmXf
 DSCtrYBjVKUodhLyk+utmWbHuxxehROLMF3TC/ktMzwowWqBrgBmSIg+xXycLys6a1YMX+vS0
 IE3SMZvMyH6IcgBamLBAMcoUh1dQTKdbPY2KfFIDjLZvoaZd/mafQaNAJ6DEidG+fQk9iyfER
 RJPprW0uNigWPsTBZdIXWZirFoq1F2V8jvJubvLAWttD/l2LcGCrucpWi/ExUf4/2yst26POK
 TwPxyxmJK7pEOR4h6IB4RGBo7lGZrxV8kYpN2/NzYmRk0=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Gesendet: Samstag, 04=2E Februar 2023 um 11:27 Uhr
> Von: "Frank Wunderlich" <frank-w@public-files=2Ede>
> An: "Ar=C4=B1n=C3=A7 =C3=9CNAL" <arinc=2Eunal@arinc9=2Ecom>
> Cc: arinc9=2Eunal@gmail=2Ecom, "Rob Herring" <robh+dt@kernel=2Eorg>, "Kr=
zysztof Kozlowski" <krzysztof=2Ekozlowski+dt@linaro=2Eorg>, "Matthias Brugg=
er" <matthias=2Ebgg@gmail=2Ecom>, devicetree@vger=2Ekernel=2Eorg, linux-arm=
-kernel@lists=2Einfradead=2Eorg, linux-mediatek@lists=2Einfradead=2Eorg, li=
nux-kernel@vger=2Ekernel=2Eorg, erkin=2Ebozoglu@xeront=2Ecom, "Sean Wang" <=
sean=2Ewang@mediatek=2Ecom>, "DENG Qingfang" <dqfext@gmail=2Ecom>
> Betreff: Aw: Re: [PATCH v2 4/5] arm: dts: mt7623: mux phy0 on Bananapi B=
PI-R2
>
> Hi aranc,
>=20
> have tested this series, basicly it works, but i get only ~620 Mbits/sec=
 (much more i will need on wan) in tx-mode of r2, rx-mode (iperf3 -c IP -R =
on r2) gets full 939 Mbits/sec=2E Both no retransmitts=2E
>=20
> tried with my laptop which gets 940Mbit/sec in tx mode too=2E=2E=2Eother=
 end is a R2 with 5=2E15 connected to lan0 (and eth1+aux enabled, dmesg cle=
an so far=2E=2E=2Efor the "kernel log flooded"-comment)=2E
>=20
> maybe gmac1 needs to be tweaked a bit (clock-settings)?
>=20
> can you confirm this with your board?

tested the vlan_aware way with 5=2E15=2E80 and got better result

ip link add br0 type bridge vlan_filtering 1
ip l set aux master br0
ip l set wan master br0
bridge vlan add vid 99 dev wan
bridge vlan add vid 99 dev aux
bridge vlan
ip l s eth1 up
ip l s wan up
ip a a 192=2E168=2E0=2E11/24 dev eth1
ip l s br0 up
ip l s aux up

i see traffic on eth1 increasing and iperf3 shows in both directions ~940M=
bit/s, no strange mesages in dmesg while testing=2E=2E=2Ewhere do you see t=
hese?

tested vlan-way with 6=2E2 and felix' Patches to more comparable with your=
 test=2E=2E=2Eand got same result (~625Mbit/s in tx and 940Mbit/s in rx-mod=
e=3D-R on r2)=2E=2E=2Eso it seems anything between 5=2E15 and 6=2E2 reduced=
 gmac1 tx bandwidth=2E

to summarize:

i get same result with your patches and my old vlan_bridge way with same c=
odebase=2E=2E=2Ehow do i see your problem with the vlan-bridge-way? Do you =
test with bpi-r2 or only any other board and change r2 to have same DT?

regards Frank
