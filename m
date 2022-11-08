Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0971620620
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiKHBed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbiKHBea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:34:30 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76779E6;
        Mon,  7 Nov 2022 17:34:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1667871240; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=hYnDcG3IUi2Ki1Z9MH7oJY6XcT3e6Ni25zdj7tgu1X6Ingy9wqrJEWctWM1RPgcLEm38BJ1CchDqGLGMApBSGG5AF44pqM1D//aO7+FfGXHMufKCPumvxwyXpEcRyzSDXvelP3qqIwzFQe7ur6F7sS1iPsXA+G/q669ty/7+NY4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1667871240; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=bWSow0ANRbgZL+RpPiwpQoWZxSeKC1ZJf+WW9du0GoQ=; 
        b=GnCZUIn6vVdh/hyI22q1ZfSx2UxHv+el5LQ2Mc2z0NvJj7/GQE/Ci3EPSwdE/Fo2KIj+K+czVRCcruydY06m/J5iN503a/fDxeoO2AeXWTS5NbYrEfSBqIX/SvVb5wiFLzQyDJqZQ4cFtp0h76sgfSf/U4zArjasbd7qS8dY0vo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1667871240;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=bWSow0ANRbgZL+RpPiwpQoWZxSeKC1ZJf+WW9du0GoQ=;
        b=DsPm34O2/9q5MaN31669a52IxxaOMzZwIPBZEL8oS0nzuCvw3mLfXOJO4zfvZb/P
        /7razN4vVgVy8aL0kSm60zYb7yVqOMuWNyDib6i9hduTFXl0O4rzmRhzl8N+xK7TcSz
        QImmjbxKlcmzAq+r0stL5AEDG/1wpaTgoDZxa7eQ=
Received: from edelgard.fodlan.icenowy.me (112.94.103.200 [112.94.103.200]) by mx.zohomail.com
        with SMTPS id 1667871237476152.56577536025281; Mon, 7 Nov 2022 17:33:57 -0800 (PST)
Message-ID: <6b11ee97ebf53dd30bab14c9c40ef8f073a616aa.camel@icenowy.me>
Subject: Re: [PATCH v2] arm64: allwinner: a64: add device tree for SoPine
 with clusterboard
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Renze Nicolai <renze@rnplus.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Date:   Tue, 08 Nov 2022 09:33:51 +0800
In-Reply-To: <c2523181268451aa04a2474a2cf5bedb@rnplus.nl>
References: <b3b8320f0d2b54a0557331977582d05c@rnplus.nl>
         <334c5f69-2f25-aeb1-b87f-500cf2a6c205@linaro.org>
         <c2523181268451aa04a2474a2cf5bedb@rnplus.nl>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2022-11-07=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 21:55 +0100=EF=BC=
=8CRenze Nicolai=E5=86=99=E9=81=93=EF=BC=9A
> Hello Krzysztof,
>=20
> Thank you for your feedback! I've fixed the indentation and I've
> added=20
> the compatible and model elements.

One small issue, I think the clusterboard has one node that comes with
eMMC, which is different from other nodes.

Should these have different DT's ?

>=20
> Greetings,
> Renze Nicolai
>=20
>=20
> The Pine64 clusterboard needs a to have the tx delay changed to
> 500ps for ethernet to work. This solution was described by multiple
> people on the Pine64 forum years ago and nobody has submitted it.
>=20
> Add a device tree for SoPine with the clusterboard.
>=20
> Signed-off-by: Renze Nicolai <renze@rnplus.nl>
> ---
> =C2=A0 arch/arm64/boot/dts/allwinner/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0 .../allwinner/sun50i-a64-sopine-clusterboard.dts | 16
> ++++++++++++++++
> =C2=A0 2 files changed, 17 insertions(+)
> =C2=A0 create mode 100644=20
> arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-clusterboard.dts
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile=20
> b/arch/arm64/boot/dts/allwinner/Makefile
> index 6a96494a2e0a..15b011d1aaea 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -15,6 +15,7 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D=20
> sun50i-a64-pinephone-1.2.dtb
> =C2=A0 dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinetab.dtb
> =C2=A0 dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinetab-early-adopter.dtb
> =C2=A0 dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-sopine-baseboard.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-sopine-clusterboard.dtb
> =C2=A0 dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-teres-i.dtb
> =C2=A0 dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a100-allwinner-perf1.dtb
> =C2=A0 dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h5-bananapi-m2-plus.dtb
> diff --git=20
> a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-clusterboard.dts=20
> b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-clusterboard.dts
> new file mode 100644
> index 000000000000..f75325d43d76
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-
> clusterboard.dts
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +// Copyright (c) 2022 Renze Nicolai <renze@rnplus.nl>
> +
> +/dts-v1/;
> +
> +#include "sun50i-a64-sopine-baseboard.dts"
> +
> +/ {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0model =3D "SoPine with cluster=
board";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0compatible =3D "pine64,sopine-=
clusterboard", "pine64,sopine",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "allwinner,sun50i-a64";
> +};
> +
> +&emac {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0allwinner,tx-delay-ps =3D <500=
>;
> +};

