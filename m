Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2092967B712
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 17:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbjAYQmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 11:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbjAYQmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:42:08 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC7237565;
        Wed, 25 Jan 2023 08:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1674664893;
        bh=rq+I8BBcOwkHDtDkBgR8HbDE4eXh6wxwg8QxpCdBsuk=;
        h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
         References;
        b=Aib0yHDu+eyiQv28rupHTeZhOzRItxLLzzSnQWkDqzpyA/2TJf0OMdEGE4mYpX3PE
         Av7TfeuAuAA0/G0teARI99Jmu1BgpijM1f47Hs2GqMqm1aMIW/3VyXLns9W5HcwwGC
         Bh4NaKNuvH9T+9d6EdOkLHASvpm1lCiEwQdjNclizsuTXRDiBxOpeeA/omjkMq06aa
         8VzAKzef5k6GW0PxwsnlBDLO14pcuhjLIjWOOaEjiEdPBeLPJekd1wINQZxOyaFsUr
         e5p9yRWsnSr6Q2l8VTUpA7v2gWt2iAef9PkBq0erZJhIDgNQqj1fYyyo2Z0+FUvlD1
         lLWANVNlGFAOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([80.245.74.59]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N33ET-1ofqaG02KD-013RVC; Wed, 25
 Jan 2023 17:41:33 +0100
Date:   Wed, 25 Jan 2023 17:41:25 +0100
From:   Frank Wunderlich <frank-w@public-files.de>
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        erkin.bozoglu@xeront.com, Sean Wang <sean.wang@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>
Subject: Re: [PATCH 4/5] arm: dts: mt7623: mux phy0 on Bananapi BPI-R2
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <20230120205318.519493-5-arinc.unal@arinc9.com>
References: <20230120205318.519493-1-arinc.unal@arinc9.com> <20230120205318.519493-5-arinc.unal@arinc9.com>
Message-ID: <9A7BD95A-F026-4EAB-96E1-12B1B0C6AAA4@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CG5Ii1F2NzN0unmUtBDjSqSGd3Cfi/OGshwd2tOQ+KvmtVd8au4
 VD+h0gQ0/p3kX6FHp5MTu/2MvM0VEcPvzs+TsWPU86u26qfKhK1ThTcIyZq/oPfHxaeb+zQ
 iRGVr0cbfzoFsfcUUWOeCbHb310xYBXdWcmEA8rNipZGmw9rLIuV92BOt99UoLlBzTqsWYY
 X4UGMEBCvepZgHZ08dhVQ==
UI-OutboundReport: notjunk:1;M01:P0:K5UPTwbdRb8=;kWsV7bmkHlOyetrvEMoeRlecVhy
 txkPzft12wrIFC5uE169oHr5ThrVpekB/nkEJYYFQAwfnxsH914wxKGk4usF5NT0o8wPpNco7
 raEszTt63uPhOUvdQrutQ9XIp3Hoh4/VdOX11/eQ2oOw760xObk7ObF5Qj3EYF+LQHFVdna9u
 oP7IJQKX0xZOdc+1Nd2YVHFCxNipJ9nYsspQ68sdnubve7zngVsj9Thm7I2fbKCKhJd91IMYE
 UXrxyMN+2c7qDKVnZ5epSIlriP9eVdh2sH1QMBxfsqA9kAMektkVa515AwqomYUqJtFnDZacS
 GASml8R22UbNcI+NEHjRE5Wx7QTBv1bBkxBMf9WwF/ayua78K9mVJmFST2Dcc6p4DbTXvzc7C
 oSSeI7R1da7ecnrpkFjb6IvWblVAeTgRbcmwLMq5zfBQkbW6xZGFc2rtURM5ejDPrAdloLMIP
 GTC9aTOZupTVayK/PLIjhKv2iChEYkXbwzZ4cZOtN0KJK16D7WfvGvJgjzzGrPQzQEU06g0RQ
 V0ZdI8Yl+wd+6pLR/BHTgOS4m2T8zT6AeKo9H6skO63nWkSbw6FZv6gJMLhrhUgIi3A49UI6U
 QdNqLxuHVX46vOGDMfzggVa6AVIJG1b+xFrQfeNqClu1ySK2Sr/RkeB9ZPotnMnvyUb54dciJ
 uT9UFAOtICPOaEOZQDvO6QIlnSgB0EId302jDAKsfpfA2656PoCsByRH8xi//HXMvLHM3niOY
 eqyfVRNz5TQkdugiKPCw/42QiJvb+6tGr8lu+q6SJXkRhrnik0c4G9NJdp6XiZ+e4LSH+F2CI
 lJDIG9FSFMzr0f4drH/Y4EPww93iTWJv86nI/5VCWl1V3WyjgM2XHm41x2ntIHPA+Py41hq1d
 G2AFXASKAss8utIX1JGbmWdCEOBJIFWhHO7ZXx5IPp3dhN7jNooDgjnq4JPVmeLfbHKuRVVNi
 Grm01g==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20=2E Januar 2023 21:53:17 MEZ schrieb "Ar=C4=B1n=C3=A7 =C3=9CNAL" <arin=
c=2Eunal@arinc9=2Ecom>:

> 		switch@1f {
> 			compatible =3D "mediatek,mt7530";
> 			reg =3D <0x1f>;
>@@ -199,11 +208,6 @@ ports {
> 				#address-cells =3D <1>;
> 				#size-cells =3D <0>;
>=20
>-				port@0 {
>-					reg =3D <0>;
>-					label =3D "wan";
>-				};
>-

This will break existing userspace setups using wan as interface name=2E

> 				port@1 {
> 					reg =3D <1>;
> 					label =3D "lan0";


regards Frank
