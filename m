Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A587744DA1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 14:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjGBMmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 08:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGBMmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 08:42:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED4812A;
        Sun,  2 Jul 2023 05:42:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2EB660BD8;
        Sun,  2 Jul 2023 12:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3918FC433C7;
        Sun,  2 Jul 2023 12:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688301761;
        bh=jVfUQVWB8u0PmmvQDyZ7KO7ngMdVLhTl+YUPfPEXFwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=etgRBNp8U1GtrE29PKQP3Z3l+S96gV65/AkfTD5miA8hii+65r21ZygpaH4oa/xqS
         VD0FpE9p5jIRdEFGPQS1D0AICq7rxv0y5f/bvUqiaSL87hpivTQ/SdqvrmaQ7YGgaB
         6h+1UjENycYhZ9wBlyWGHvrhtLeSvTliD6PYZU2t43XGlgI9C+gT+XvZ08nKG8NxKN
         oO9wGR43e29JGoaxOOjN/2Hjcz0NmWGPf9KBz9K+WiKz+LNXCxztfy7d7cRDmYzpYt
         f7n8CTIbVoCqzaK5zocFUDlpy5BejlA1DUts7zqhSx+YX4HrLbmMeuKKPZ/2JzPYfo
         X/dZEkgXcsExQ==
Date:   Sun, 2 Jul 2023 13:42:34 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yunhui Cui <cuiyunhui@bytedance.com>
Cc:     ardb@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        rminnich@gmail.com, mark.rutland@arm.com, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com
Subject: Re: [PATCH v2 3/3] riscv: obtain SMBIOS entry from FFI.
Message-ID: <20230702-confiding-aqueduct-25c3c2852de3@spud>
References: <20230702095735.860-1-cuiyunhui@bytedance.com>
 <20230702095735.860-3-cuiyunhui@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UYIYQ5+ccvyV+xol"
Content-Disposition: inline
In-Reply-To: <20230702095735.860-3-cuiyunhui@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UYIYQ5+ccvyV+xol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Sun, Jul 02, 2023 at 05:57:34PM +0800, Yunhui Cui wrote:
> When we bringup with coreboot on riscv, we need to obtain
> the entry address of SMBIOS through the FFI scheme.

What do you need it for?

>=20
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/kernel/ffi.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/riscv/kernel/ffi.c b/arch/riscv/kernel/ffi.c
> index c5ac2b5d9148..c44f943a1cb5 100644
> --- a/arch/riscv/kernel/ffi.c
> +++ b/arch/riscv/kernel/ffi.c
> @@ -8,6 +8,7 @@
>  #include <linux/of.h>
>  #include <linux/of_fdt.h>
>  #include <linux/libfdt.h>
> +#include <linux/ffi.h>
> =20
>  u64 acpi_rsdp;
> =20
> @@ -34,4 +35,7 @@ void __init ffi_acpi_root_pointer(void)
>  void __init ffi_init(void)
>  {
>  	ffi_acpi_root_pointer();
> +#if CONFIG_FDT_FW_INTERFACE
> +	ffi_smbios_root_pointer();
> +#endif

Please stub this function so that we don't need ifdeffery here.

Cheers,
Conor.

--UYIYQ5+ccvyV+xol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKFwugAKCRB4tDGHoIJi
0u0QAP9PDkIgfu8QYYuLUfYPSliixPVA8qI4IFs1lvMEqm8TFQEAjpx7JLvefDUL
j3QKZLxc+OyZF1oBq//GpMhDgP3T2Q0=
=aVzp
-----END PGP SIGNATURE-----

--UYIYQ5+ccvyV+xol--
