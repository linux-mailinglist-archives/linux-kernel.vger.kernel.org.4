Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA3F6D1E62
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCaKzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjCaKzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:55:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410171D2EB;
        Fri, 31 Mar 2023 03:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680260133; x=1711796133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fmFXNjlDNk/NwlvKemf9I4yf1T0EbLEfb7ypDG0gvOg=;
  b=uQKKseIUQkDZ04FpXyOA/S3+SFUvc0Rlayxz61CACuNAtH3wWWyT5cEN
   Fvlkw7Kol6kWxXPxKSbT/h7hllwyohcAyczjAVJbgSHxgXoIhPsngLrYz
   7U1ps+ve7w0IJGpsL945k3TsvzGIcUcd7D4PEA9Op3x93yUE7sQquz3T6
   UsT6d6a1o/YDYbIrmHJu1CfRs+Na7Yft8wtB4o5T5Xh7BaqSpeQ4ZY7+u
   GPn/hhqh7Espa/scTduds12+iZONMU7CH+dY4LC0tNR1bNx37UOihUHBK
   7ggDLZJ4bI4JQRnlC99fO5pFQf6dpbf78dKmA5lutm0+6M79/EA3uJUgo
   A==;
X-IronPort-AV: E=Sophos;i="5.98,307,1673938800"; 
   d="asc'?scan'208";a="207170249"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2023 03:55:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 03:55:31 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 31 Mar 2023 03:55:29 -0700
Date:   Fri, 31 Mar 2023 11:55:15 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        guoren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        <linux-riscv@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v7 1/6] riscv: mm: dma-noncoherent: Switch using function
 pointers for cache management
Message-ID: <50e932df-cb20-4679-b911-fd9d7f0f2c1d@spud>
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230330204217.47666-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <6ca5941a-8803-477d-8b40-17292decc5af@app.fastmail.com>
 <CA+V-a8tkiDXG37YjFKPxrGoXVQMVBemMdBcfb+uUDzBofOWH_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CSbvtOdTMuQLjL4r"
Content-Disposition: inline
In-Reply-To: <CA+V-a8tkiDXG37YjFKPxrGoXVQMVBemMdBcfb+uUDzBofOWH_A@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--CSbvtOdTMuQLjL4r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 31, 2023 at 11:37:30AM +0100, Lad, Prabhakar wrote:

> > As far as I recall, the #else path here was needed previously
> > to work around a binutils dependency, but with the current
> > code, it should be possible to just always enable
> > CONFIG_RISCV_ISA_ZICBOM when RISCV_DMA_NONCOHERENT is used.
> >
> Are you suggesting something like below?
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 4dadf35ac721..a55dee98ccf8 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -242,6 +242,7 @@ config RISCV_DMA_NONCOHERENT
>         select ARCH_HAS_SYNC_DMA_FOR_CPU
>         select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>         select DMA_DIRECT_REMAP
> +       select RISCV_ISA_ZICBOM
>=20
>  config AS_HAS_INSN
>         def_bool $(as-instr,.insn r 51$(comma) 0$(comma) 0$(comma)
> t0$(comma) t0$(comma) zero)
> @@ -465,7 +466,6 @@ config RISCV_ISA_ZICBOM
>         depends on MMU
>         depends on RISCV_ALTERNATIVE
>         default y
> -       select RISCV_DMA_NONCOHERENT
>         help
>            Adds support to dynamically detect the presence of the ZICBOM
>            extension (Cache Block Management Operations) and enable its
>

Does that actually work? I don't think it does.
If you try to enable RISCV_ISA_ZICBOM then you won't get
RISC_DMA_NONCOHERENT turned on. Run menuconfig and disable support for
Renesas, SiFive and T-Head SoCs & you can replicate.

I think one of RISCV_ISA_ZICBOM and RISCV_DMA_NONCOHERENT should just be
dropped, although I don't know which one to pick!
Making RISCV_DMA_NONCOHERENT user selectable probably makes the most
sense.


--CSbvtOdTMuQLjL4r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCa8EwAKCRB4tDGHoIJi
0gv8AQDmXopbmBtrwgpdT70H1KpMBgB8DRztldVostbpyT7KpAEA2JJggZT9ayUa
tSrS0FeAl7Q+HC4ExyMuP+/iqLDQLAQ=
=rDeY
-----END PGP SIGNATURE-----

--CSbvtOdTMuQLjL4r--
