Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A8E6832E4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjAaQkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjAaQkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:40:22 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E5F1448C;
        Tue, 31 Jan 2023 08:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1675183189;
        bh=RIe/S0uaHaYJgMue7HTYnNWRd6tihNmsPFU03DnY8u8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=isMvIMW85ulIIsw+DyntNGcMfLEwAkxiSDXtg7YOdjH+xnCToKe556R4yznLn06Bt
         ceFCUq/FdovTeiqKHYfg7YlWxcyNlikfz0l9ijlksUm5ffA1I5WltVb4DIPWNMq3Xx
         8duOru4vZni41IcCSn9/RFqBks5heGxKN/LnoUiTZV5mQHPY9VWM0LLYdwCO+AcK9/
         sFxEZPG0dqsDQHZzAC8OHrx0OIJn4J97OjzHIpfd3QC6pfgZKI6qHkba5qPGKSGlbX
         +JgroiBSXdsrhikX3Uj1HV9/hqtjq60iXoOijhYJeQpU7Pwat1/58hlVh7ZXLdKS/B
         +f2EF8l+YUxWQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.157.42] ([217.61.157.42]) by web-mail.gmx.net
 (3c-app-gmx-bs58.server.lan [172.19.170.142]) (via HTTP); Tue, 31 Jan 2023
 17:39:49 +0100
MIME-Version: 1.0
Message-ID: <trinity-a044d8eb-8bc2-4b96-9abf-874dcc10db54-1675183189634@3c-app-gmx-bs58>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     =?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        erkin.bozoglu@xeront.com, Sean Wang <sean.wang@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>
Subject: Aw: Re: [PATCH 4/5] arm: dts: mt7623: mux phy0 on Bananapi BPI-R2
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 31 Jan 2023 17:39:49 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <c78e2725-0be7-caa8-40db-2f355cc2cdec@gmail.com>
References: <20230120205318.519493-1-arinc.unal@arinc9.com>
 <20230120205318.519493-5-arinc.unal@arinc9.com>
 <9A7BD95A-F026-4EAB-96E1-12B1B0C6AAA4@public-files.de>
 <cf7d3247-4d21-98f0-819b-7653153ee4c0@arinc9.com>
 <c78e2725-0be7-caa8-40db-2f355cc2cdec@gmail.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:wf6YfoT4OK7QjKfeIa90qRY/Tb8ei+6zlrygKrdduKqgS6qdQfLxP0l8PayX9BnEIPDfc
 pdyT//908UqfNdZYga/38QiI5k6TgG3IuEIO/DkURyUKlP3LH3eOJm1rtL7poHolpgswbSyhj3Q5
 e/+bvASvLDE8izw8Rh9e1a4iWntSIL3ianjJV/HiIo2iSVUZZBZLGc0+ObcUbpB53w0yft5Jmlz3
 vyb5FYDa3qEiXWoOOXdJ3Mpev3jlkdQBDMKx5VTxFcls6F05V+Hng7KNZPjoW3ikuc1LnS6OgfaC
 V4=
UI-OutboundReport: notjunk:1;M01:P0:2dBudpK+voc=;7y5POLU7oXjvPhuCAqB51PX0Qdj
 5aUy4YWDfCiOcmur90YZnmx5SN9uUOgNpE6HmfEjoOUsUnCTEP3PPqgzXG/JpyjYsJsdBfy69
 OFz81xxWSaUzWlggofUujZxSIi79Jzet/QC7HVLj+wb9UYlukIJ7JK2b9gs1EqE6ASvDl2dwK
 bg5TEpRZMp3XqWmqggfSvtNxnOhanxmMM2uVORw4aFUJmiNc1+i/0ZLF6KM+87WPPJWiGqBnT
 TSfvQ6XaNafU8PfvaoGgI2zB4Mf0grU8sxFeED5VLcO4KmhL4CJBFBhpvEko6CL6Z45ynJatF
 YwzU7WxhGkzU1C3MqwfYC9x52u4M9OPajSTfGGv6gS3UGOHQ2aUO/XJcRrPdl/4q2gfVkVXQ+
 4cs7V7jSJYHbsS4upbB04geSo8yOVuuIaQ8cEFGGLJyeRmxE2PcPsSWncSa67RWcef/gfaPFL
 WFRFlgPEUgCR4J8IC44QmeusfJYtO71+N+gZpgPjPPuV5oG1sZoRiwEBTg9kaExoXBL7wUYfz
 FLRIQlYfZ97SMNYZwOq7TUkb8Tvd2+faG/d1bp1O1YksWVexFYqK/MWpyiEmFmKkbpxMY5HD+
 yKWdrTimizRUIik9CBl0GftSZnHwUi/mgp8oF14kRto1P7RGYWD99cYphC5ugPcmVNKBQZf/F
 4BmBaUBL5IhkFmr3Thd1mOVE/y3V2Sz4hlXMqXwkW8Bjv/pDoUG/OXi2R8r9Fk9bMswiniEkT
 2vCm74Zp0fD4sMWP51N1+lTvNTdDFkIDey6q+KIcTHO7Utj31Y94WeUp0Z/QXoxN/ly2vjunM
 l+WQ4Mi7SF6h32idL5GW/qYD4lzGRG4cRCB/astIZX17M=
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
> Gesendet: Dienstag, 31=2E Januar 2023 um 12:55 Uhr
> Von: "Matthias Brugger" <matthias=2Ebgg@gmail=2Ecom>
> An: "Ar=C4=B1n=C3=A7 =C3=9CNAL" <arinc=2Eunal@arinc9=2Ecom>, frank-w@pub=
lic-files=2Ede, "Rob Herring" <robh+dt@kernel=2Eorg>, "Krzysztof Kozlowski"=
 <krzysztof=2Ekozlowski+dt@linaro=2Eorg>
> Cc: devicetree@vger=2Ekernel=2Eorg, linux-arm-kernel@lists=2Einfradead=
=2Eorg, linux-mediatek@lists=2Einfradead=2Eorg, linux-kernel@vger=2Ekernel=
=2Eorg, erkin=2Ebozoglu@xeront=2Ecom, "Sean Wang" <sean=2Ewang@mediatek=2Ec=
om>, "DENG Qingfang" <dqfext@gmail=2Ecom>
> Betreff: Re: [PATCH 4/5] arm: dts: mt7623: mux phy0 on Bananapi BPI-R2
>
>=20
>=20
> On 25/01/2023 17:54, Ar=C4=B1n=C3=A7 =C3=9CNAL wrote:
> > On 25=2E01=2E2023 19:41, Frank Wunderlich wrote:
> >> Am 20=2E Januar 2023 21:53:17 MEZ schrieb "Ar=C4=B1n=C3=A7 =C3=9CNAL"=
 <arinc=2Eunal@arinc9=2Ecom>:
> >>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch@1f {
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ompatible =3D "mediatek,mt7530";
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eg =3D <0x1f>;
> >>> @@ -199,11 +208,6 @@ ports {
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1>;
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <0>;
> >>>
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 port@0 {
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0>;
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 label =3D "wan";
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 };
> >>> -
> >>
> >> This will break existing userspace setups using wan as interface name=
=2E
> >=20
> > Yup=2E The OS being used will have to either rename the interface or a=
dapt to the=20
> > new name, eth1=2E
> >=20
>=20
> In that case please explain in the commit message why this is needed=2E =
We are=20
> trying really hard to not break userspace by a device-tree update=2E

I understand the reason why Ar=C4=B1n=C3=A7 wants to change it:

currently all ports including wan-port are routed via dsa over gmac0 (trgm=
ii), Ar=C4=B1n=C3=A7 enables the second gmac and port5 of switch to route w=
an-traffic over the other gmac=2E But unfortunately there is no mainline-wa=
y to rename the gmac1 interface (eth1) to wan=2E=2E=2Ethis would be a way t=
o not break the userspace=2E

i had an older patch for mtk_eth_soc [1] which do it at driver level for m=
ediatek ethernet driver, but afair a generic way to (re)name interfaces in =
dts (vendor independ) was requested as the right way=2E

regards Frank

[1] https://github=2Ecom/frank-w/BPI-Router-Linux/commit/5088c9c81e9001462=
2a950fca38cfb29e0421155
