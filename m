Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7656673106C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbjFOHUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244612AbjFOHTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:19:15 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A171C2683;
        Thu, 15 Jun 2023 00:18:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686812433; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=l6x7t9JDP8p6zgSDcEHnbEe8irqjs+QmLHJFUP8LWgQFo/aaS1OUikj4hmTZQbxy5v
    fzOTjvamNmggkdR3IYLoaiHveMmKWzgugRhSo7txY/eJXRqZIdHTcIJgUxGhV4DWJ3yL
    CKPRTe6fKxN3BP/aHVeDFgJtnG0P0R9Ch4PJv4GDC81nMovHeYeIvrA9EghcYD70QGbs
    ZiVVBqu042fCQBKxGuDzcepKBj/6y9coq/fIJIxb/CL8jsZ6+kCRFUsqgt5UOJg34kjB
    LSbeN5ZnNAz/VVkmfx9sIdQnq+Ol5lLkBxp4hitL5COUNq4NLCaGWalBvf4fx2k/+xCB
    FI+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686812433;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Pun22zFGCocM+PFhnmP2zLNHFo+3iLvVLg8m4mkXy9I=;
    b=dMrPlCZK5WjVh/A/B1N/bEOie/Kt0cqI/6EJmzOA5C85UGk8jdL5OTvQ02hiKHo7u5
    hmECgSuq0KF5yyt36aBAi0aQaZSt9tQC1U5qiGCpSHPEFHcI8SwiNEMWlNTTRI+E4+SR
    dGTybg/3Q7tejMNURNArXiFJfL/mvnNTorcJDRmv2TNxJcU8sFCI3wFvxyEsPvIexLjT
    AGjCZ5lcNXw0YeUAB64vaa+jvFrKZhLWChySlBa9TpOfQ/bIJJvsVpBvhhVAhVIE0mK7
    U+bSCo5oiQKVyATjvD4hgT1KbK24yiQBDSrATDsYjocsLtcU2BEGPfKkC5xgs63GJ8Cq
    raZA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686812433;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Pun22zFGCocM+PFhnmP2zLNHFo+3iLvVLg8m4mkXy9I=;
    b=kQEPjfPTkNizYEok7XVFXpdg+9Wnj1PgARJfI0UtN6G5kmkWrOI0lna15VTRmepcIW
    /vTIWk7QINBuGgSUdim+AHEOmT75f+ma9lR7z8+x1kVveYydE/bpXqUr8lTaJFh2RQt3
    E5aIdhPKrXLS6eOJhnVHHWSwE0RtEkU5ZUBNCLHhuZefSD2A8dhRitKWsEmTcNo9XJ0+
    pv0AQ6eUgOFllwFU4XEGnASj5cWDjyHUBfu+RKT10Rcz6okq7IdhJS04Nt+1YhFEyFXO
    WojQjGBVzTvtW7uESWftHhlZqlPF0kKp1EYqUHMZ0Qm2vTNpiyoGVJFI4yJ5Uaksnt4N
    51dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686812433;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Pun22zFGCocM+PFhnmP2zLNHFo+3iLvVLg8m4mkXy9I=;
    b=rpZocAaZVFG/akDJ33Etz6ZWna5ywcfCrhGMR+xT2KjhhtzLaUha3wGbNMsp1ZRSpb
    9V1m3RES+Ja8u4iKZTDw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGeonQ="
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id jaf17fz5F70X23O
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Thu, 15 Jun 2023 09:00:33 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 3/9] MIPS: DTS: CI20: Add parent supplies to ACT8600
 regulators
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20230604145642.200577-4-paul@crapouillou.net>
Date:   Thu, 15 Jun 2023 09:00:32 +0200
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        list@opendingux.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <D6E7498A-3172-42C6-804A-CB5A323F91DC@goldelico.com>
References: <20230604145642.200577-1-paul@crapouillou.net>
 <20230604145642.200577-4-paul@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 04.06.2023 um 16:56 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Provide parent regulators to the ACT8600 regulators that need one.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> arch/mips/boot/dts/ingenic/ci20.dts | 7 +++++++
> 1 file changed, 7 insertions(+)
>=20
> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts =
b/arch/mips/boot/dts/ingenic/ci20.dts
> index 5361606c5e13..662796acda41 100644
> --- a/arch/mips/boot/dts/ingenic/ci20.dts
> +++ b/arch/mips/boot/dts/ingenic/ci20.dts
> @@ -242,16 +242,19 @@ regulators {
> 			vddcore: DCDC1 {
> 				regulator-min-microvolt =3D <1100000>;
> 				regulator-max-microvolt =3D <1100000>;
> +				vp1-supply =3D <&vcc_33v>;

where is vcc_33v defined?

Unless [7/9] "MIPS: DTS: CI20: Enable support for WiFi / Bluetooth" is =
applied?

This way the patches in between can't be bisected.

> 				regulator-always-on;
> 			};
> 			vddmem: DCDC2 {
> 				regulator-min-microvolt =3D <1500000>;
> 				regulator-max-microvolt =3D <1500000>;
> +				vp2-supply =3D <&vcc_33v>;
> 				regulator-always-on;
> 			};
> 			vcc_33: DCDC3 {
> 				regulator-min-microvolt =3D <3300000>;
> 				regulator-max-microvolt =3D <3300000>;
> +				vp3-supply =3D <&vcc_33v>;
> 				regulator-always-on;
> 			};
> 			vcc_50: SUDCDC_REG4 {
> @@ -262,21 +265,25 @@ vcc_50: SUDCDC_REG4 {
> 			vcc_25: LDO5 {
> 				regulator-min-microvolt =3D <2500000>;
> 				regulator-max-microvolt =3D <2500000>;
> +				inl-supply =3D <&vcc_33v>;
> 				regulator-always-on;
> 			};
> 			wifi_io: LDO6 {
> 				regulator-min-microvolt =3D <2500000>;
> 				regulator-max-microvolt =3D <2500000>;
> +				inl-supply =3D <&vcc_33v>;
> 				regulator-always-on;
> 			};
> 			cim_io_28: LDO7 {
> 				regulator-min-microvolt =3D <2800000>;
> 				regulator-max-microvolt =3D <2800000>;
> +				inl-supply =3D <&vcc_33v>;
> 				regulator-always-on;
> 			};
> 			cim_io_15: LDO8 {
> 				regulator-min-microvolt =3D <1500000>;
> 				regulator-max-microvolt =3D <1500000>;
> +				inl-supply =3D <&vcc_33v>;
> 				regulator-always-on;
> 			};
> 			vrtc_18: LDO_REG9 {
> --=20
> 2.39.2
>=20

