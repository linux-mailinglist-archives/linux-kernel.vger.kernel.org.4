Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3126D20B6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjCaMqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjCaMqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:46:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F5220638;
        Fri, 31 Mar 2023 05:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680266747; x=1711802747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XSJ9xYx7OKiDUOZcxx839tz93MC5ZSo3mvtiQkoZYKA=;
  b=apPXsXgOBVZMM8Jmpf+q/nzqbBP3gwMIx9dKKO5zuE7FF+LeOcDnpupP
   C6d7I+sCMppP0eK+OJfcp1vbVjmbNdckTE3k6C3tD0erRKa/v2EdJFcWB
   ZXzSCfP2C/0EExQ4PxCmeiWGMs35I4x+TTgpPcXIAjzN/aHp1A0XrBi+C
   CR9b+W/Ns13Jm/FmuzP9SsXnhqQJBpzvm23BdofdHLAGNuRLdJYAGJXtQ
   QYA4m7J02TPVQfRm6ByI2is8cgHsy4/tRhfj33MxsuZZouU6jAMz9cuYF
   MA3yqEL0yxvS24w4LtkDIixvDYSoJ2EY/SwXWiR4d1wiB5QcdEHL6qL7A
   g==;
X-IronPort-AV: E=Sophos;i="5.98,307,1673938800"; 
   d="asc'?scan'208";a="207589991"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2023 05:45:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 05:45:44 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 31 Mar 2023 05:45:41 -0700
Date:   Fri, 31 Mar 2023 13:45:27 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        <linux-riscv@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v7 5/6] cache: Add L2 cache management for Andes AX45MP
 RISC-V core
Message-ID: <5468019d-e688-4019-882f-6f9611443408@spud>
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230330204217.47666-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ujmC02K2mc/43jGi"
Content-Disposition: inline
In-Reply-To: <20230330204217.47666-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ujmC02K2mc/43jGi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 30, 2023 at 09:42:16PM +0100, Prabhakar wrote:

> +STANDALONE CACHE CONTROLLER DRIVERS

> +F:	include/cache

This can go since the file no longer exists.

> +config AX45MP_L2_CACHE
> +	bool "Andes Technology AX45MP L2 Cache controller"
> +	depends on RISCV && RISCV_DMA_NONCOHERENT

This can just be depends on RISCV_DMA_NONCOHERENT, since that's only
defined on RISC-V.

> +static void ax45mp_get_l2_line_size(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	ret = of_property_read_u32(np, "cache-line-size", &ax45mp_priv->ax45mp_cache_line_size);
> +	if (ret) {
> +		dev_err(dev, "Failed to get cache-line-size, defaulting to 64 bytes\n");
> +		ax45mp_priv->ax45mp_cache_line_size = AX45MP_CACHE_LINE_SIZE;
> +	}
> +
> +	if (ax45mp_priv->ax45mp_cache_line_size != AX45MP_CACHE_LINE_SIZE) {
> +		dev_err(dev, "Expected cache-line-size to be 64 bytes (found:%u). Defaulting to 64 bytes\n",
> +			ax45mp_priv->ax45mp_cache_line_size);
> +		ax45mp_priv->ax45mp_cache_line_size = AX45MP_CACHE_LINE_SIZE;
> +	}

I forget, why are we doing this defaulting rather than falling over
immediately if we detect the property is missing or wrong?

> +}

> +static const struct riscv_cache_ops ax45mp_cmo_ops = {
> +	.clean_range = &ax45mp_cpu_dma_wb_range,
> +	.inv_range = &ax45mp_cpu_dma_inval_range,
> +	.flush_range = &ax45mp_cpu_dma_flush_range,
> +};

I think it would be nice if your driver functions matched the names used
by the ops. (and as I said on the other patch, I think the ops should
match the cross-arch naming.

Otherwise, looks grand - although I think I was mostly happy with the
last revision too.a

Cheers,
Conor.

--ujmC02K2mc/43jGi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCbV5wAKCRB4tDGHoIJi
0jXXAP0Wzcz5s99w4wfN/xL5lC591ZxAOt8+z4NTdIBaxn4mzQD+PLdKyy6NKLib
xz7hD43NmKAe5yK/zmiimoEH/rNnTA4=
=25N2
-----END PGP SIGNATURE-----

--ujmC02K2mc/43jGi--
