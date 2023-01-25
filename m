Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1AC67B723
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 17:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbjAYQqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 11:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjAYQqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:46:35 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA32E59773;
        Wed, 25 Jan 2023 08:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1674665160;
        bh=paapgfjmgPaN5T7k6xQM//Hh7LSZk2RTA2PjeNkd7yk=;
        h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
         References;
        b=ANFwNt44vTqLx/qUQIhTg88uCtTiCcCUM5uxR4kxMFox0fYJwM1Dl35MJ3E11X+6U
         F4XNCfVYj+OYiD64blbuTTGVCSdDQMmPSbXRPmTvbjZra5PAjxgJfnoVmFkvJjY8B5
         ycG1jetA6G2K9muQB/sK/wdDrFmer5FNw1YAKLJ0bDKVkBmgDrKwDiwmP/CgupU63G
         fHJAa94hqe4/BwWNrxkjH7c6KerjTMEn1fgSNlpRubQCiTKdnVGMgvbYj85rrMHm+s
         aNlmBsPJhonUGcvNvIzhMNUJtpQVxEHgQ9AQymS8ebgVRhqdGojaNsh/lidqJ7VReD
         RYUaVpfCJ4aXw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([80.245.74.59]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFsYx-1pSho03plf-00HPuk; Wed, 25
 Jan 2023 17:46:00 +0100
Date:   Wed, 25 Jan 2023 17:45:59 +0100
From:   Frank Wunderlich <frank-w@public-files.de>
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        erkin.bozoglu@xeront.com, Sean Wang <sean.wang@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>
Subject: Re: [PATCH 1/5] arm: dts: mt7623: add gmacs to mt7623.dtsi
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <20230120205318.519493-2-arinc.unal@arinc9.com>
References: <20230120205318.519493-1-arinc.unal@arinc9.com> <20230120205318.519493-2-arinc.unal@arinc9.com>
Message-ID: <BAF25F3F-7B1B-4E9D-A0D9-89DB663B0AB3@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bNw1YneOOksE+eJPmGUva0CNxBJxgB5ae3xO6hBePa2MSuh/nQd
 vXn/l1dF/q3AuhEMRCFIbdiqtXtJX+Odw+6YAc80VnfzkrFXlwzrs/8cpvln8JlrVHKt3zY
 rI1zx/kksKeOTqyT3GvoxZOwxi4Tb777f4z9Re7fM6NBLhOMOznv6IgCw77Aqii388yhmeY
 ozjMZ+RyfXYU/1fHhksQA==
UI-OutboundReport: notjunk:1;M01:P0:6Q2eUUuj21g=;XdBoI5gTcoxhHyv/16CUTI0rkiX
 Lku+RnjSg6IIMWmsm6IMFxfkoklB7XWpcx7fTsPBCrP263NlO0Tq/Yu4Qac0gQIOboEOVWTAH
 Zc/YuSEBUl47WrfzM6U1dHRfuPrDWeoxkeTjfTFGUUIDnx01lFHdpRLETZPWIvuDWC4Vz9P9H
 osOQ9P9dCnQubBay1EevAal5aLJKSKf71e2hatqFrvClCZgspIiujBow0Og5iNveaG+Iu8lYK
 z7CTtuiHLExs6RR/aaGlMujT56HqGR2KO5FD8WY1iUE8TncAOFFMWxcuiYNupF7sBFaTHOy1Y
 ergIMtRCQcOV/t9B3CE70Dmey4KLdoG21TyoCOVdHKwl8L+tQS5N2Y9vJ9JQuC0jtQk0NsQ2M
 p21szIFVD6EGIKSC4u/e7dsgB3s7gErnDTNrM67HKUKPLSY+Gy0APiB72KRVFbSTRWWBQKrFZ
 PNCNvQP5NNTL+hzudoSDtFs3vd65Am9RzCKc/iSvGK2teT22tHjxIIMXIN5jnuFLLpqET7bb/
 f+Sm42wzMgW8hUdFgfIJaCURVyNiBk+lXTHhiIC61hR/jGTIdaWbV7M2MaZE5C15XrPK+SG9/
 ORbLE7aO2pMbnLVv7klSFbmCFs2HuhiHwoa/qduAjTxGQl14ZiJkFB6epGaOgRqtNOEP511KO
 v5qaZjn41QW/nRqVayNdl39hqkwjMVcGWeT3xhLla2YzuEjC0d6W8tpq/p+jY8cpTSk3AYbT5
 NVSO3A93UjJBCHPxk2MaJfNX2TYiFTKcR6BqRglbEKekbLyTjYYMCirnAUogemHlaWNEKVpAg
 n6vUfjjJTbSS+fKVNUEPzjnOLb0GiMnSoDN3+AOrOcFa3kmSD10vI25s9gt/MGOCeLNBFsBLr
 VRoQ5/wXmzeznbm4Gl7JwRdBVbkThcC/IIq6+p1nhtSIPITKvI9B4x5cme8buR2qfMYHN+Ori
 t1a6JUKV+v1jOlHx4x9uNPh/Hfo=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20=2E Januar 2023 21:53:14 MEZ schrieb "Ar=C4=B1n=C3=A7 =C3=9CNAL" <arin=
c=2Eunal@arinc9=2Ecom>:

>index 25d31e40a553=2E=2E5eb698a90d34 100644
>--- a/arch/arm/boot/dts/mt7623=2Edtsi
>+++ b/arch/arm/boot/dts/mt7623=2Edtsi
>@@ -981,6 +981,20 @@ eth: ethernet@1b100000 {
> 		#address-cells =3D <1>;
> 		#size-cells =3D <0>;
> 		status =3D "disabled";
>+
>+		gmac0: mac@0 {
>+			compatible =3D "mediatek,eth-mac";
>+			reg =3D <0>;
>+			phy-mode =3D "trgmii";
>+			status =3D "disabled";
>+		};
>+
>+		gmac1: mac@1 {
>+			compatible =3D "mediatek,eth-mac";
>+			reg =3D <1>;
>+			phy-mode =3D "rgmii";
>+			status =3D "disabled";
>+		};
> 	};
>=20

>diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2=2Edts b/arch/arm/b=
oot/dts/mt7623n-bananapi-bpi-r2=2Edts
>index 5008115d2494=2E=2Ea5800a524302 100644
>--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2=2Edts
>+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2=2Edts
>@@ -175,9 +175,7 @@ &eth {
> 	status =3D "okay";
>=20
> 	gmac0: mac@0 {

Should node not be accessed with label (&gmac0) instead of defining it aga=
in and shadow the one from dtsi?

>-		compatible =3D "mediatek,eth-mac";
>-		reg =3D <0>;
>-		phy-mode =3D "trgmii";
>+		status =3D "okay";
>=20
> 		fixed-link {
> 			speed =3D <1000>;

Same for other boards=2E

regards Frank
