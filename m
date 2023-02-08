Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFB468EC6B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjBHKKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjBHKKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:10:34 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D679B3E0AF;
        Wed,  8 Feb 2023 02:09:52 -0800 (PST)
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sjoerd)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D3D446602090;
        Wed,  8 Feb 2023 10:09:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675850990;
        bh=/5ijapG9vCBrHU1aJI7Ikdb7hJ0FdiJFM02ACUiAJNs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Evld1j8rXIZ/3mLNgeHlLCLNJs/4d3VSbkvX1sZ7PeOdemUeAql00HUkS/Bbi7ytH
         Tg7MD2xyML8kblK7EeYpTlMI00rBCLUbZl/rp9BbFKG+ksjyhYXpcTpiNelWvmamr9
         MZZ+0FFBnxgNdsC+96gv9aC5XvOP9SkAfFJhiyMvijj8KUgJRwiNxruNN52fxiUIar
         SrL1bMWYvDu16n+wp5taWPC6LsNURyXmOAzpHOV7RSAlrSg0wlGckBsdPK55u1t7Ky
         EbY/hYGP2rRCGoJNfhVRo3xMRd54DvRQZBFJE6Qtl+fnC86sHCsNhUV48F4YYVmzsq
         Jo3ciTtCkTC1w==
Received: by beast.luon.net (Postfix, from userid 1000)
        id 508F669D0985; Wed,  8 Feb 2023 11:09:48 +0100 (CET)
Message-ID: <7aceaa7d85b629e0c135eb3eb6199eea445b65e5.camel@collabora.com>
Subject: Re: [PATCH] ARM: dts: rockchip: fix a typo error for rk3288 spdif
 node
From:   Sjoerd Simons <sjoerd@collabora.com>
To:     Jianqun Xu <jay.xu@rock-chips.com>, heiko@sntech.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 08 Feb 2023 11:09:48 +0100
In-Reply-To: <20230208091411.1603142-1-jay.xu@rock-chips.com>
References: <20230208091411.1603142-1-jay.xu@rock-chips.com>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On Wed, 2023-02-08 at 17:14 +0800, Jianqun Xu wrote:
> Fixes: 874e568e500a ("ARM: dts: rockchip: Add SPDIF transceiver for
> RK3288")
>=20
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> Change-Id: I13940ae543ba6ca597663aa5f209b1f5b0090b19

Nice catch;

Reviewed-by: Sjoerd Simons <sjoerd@collabora.com>

> ---
> =C2=A0arch/arm/boot/dts/rk3288.dtsi | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/rk3288.dtsi
> b/arch/arm/boot/dts/rk3288.dtsi
> index 487b0e03d4b4..648fa6223351 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -942,7 +942,7 @@ wdt: watchdog@ff800000 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0status =3D "disabled";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spdif: sound@ff88b0000 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spdif: sound@ff8b0000 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0compatible =3D "rockchip,rk3288-spdif",
> "rockchip,rk3066-spdif";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0reg =3D <0x0 0xff8b0000 0x0 0x10000>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0#sound-dai-cells =3D <0>;

--=20
Sjoerd Simons
Collabora Ltd.
