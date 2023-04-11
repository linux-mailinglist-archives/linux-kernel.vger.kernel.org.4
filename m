Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0236DD707
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjDKJjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjDKJii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:38:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE1744A9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 02:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681205873; x=1712741873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MyltFylIFYtbOCTHYFJyDF5AXeTRkYCwlYLXFW0zW5Q=;
  b=L1++jc6w2Fi+tc4Ors7f2YBNoJUNcmxQ2awwVTRZCQcVgP5dfl+IgJwJ
   RMof3z07yVWJytuKo+V9kKJfihS0LASfz8p9xDk32KcoS+sFU/5mQco/D
   gApoT7hd8sG00ndL+a3j4WZNc20wLXGlU1NX8JD/wPf+VafGksPNJZ4oS
   fpBHIoq73SOcwY2735sS4lI8yDleLABptID56KnLNjNBtFAFlru7nGpwM
   5PBxy3ThkfUHeHY3tX9cT8InfUcE+H+HfC7745c5+d/HPYutQITRVFRjC
   nzrdQJE9oMC7HEZferPMWss8P41XColDrFW1AKhG2wTzeMF/cHhb9LGpA
   w==;
X-IronPort-AV: E=Sophos;i="5.98,336,1673938800"; 
   d="asc'?scan'208";a="220333193"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Apr 2023 02:37:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 11 Apr 2023 02:37:53 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 11 Apr 2023 02:37:51 -0700
Date:   Tue, 11 Apr 2023 10:37:36 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jisheng Zhang <jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: enable BUILDTIME_TABLE_SORT for !MMU
Message-ID: <20230411-flier-establish-d3ffd434be28@wendy>
References: <20230409164306.3801-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EG2YHGo4BKAgt7Xt"
Content-Disposition: inline
In-Reply-To: <20230409164306.3801-1-jszhang@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--EG2YHGo4BKAgt7Xt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Jisheng,

On Mon, Apr 10, 2023 at 12:43:06AM +0800, Jisheng Zhang wrote:
> BUILDTIME_TABLE_SORT works for !MMU as well, so enable it.
>=20
> Tested on QEMU and FPGA.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Fails to build for nommu_k210_defconfig:

make ARCH=3Driscv CROSS_COMPILE=3Driscv64-unknown-linux-gnu- O=3Dbuild -sk =
-j30
no __ex_table in file: vmlinux
Failed to sort kernel tables
make[2]: *** [../scripts/Makefile.vmlinux:35: vmlinux] Error 1
make[2]: *** Deleting file 'vmlinux'
make[2]: Target '__default' not remade because of errors.
make[1]: *** [/home/conor/stuff/linux/Makefile:1250: vmlinux] Error 2
make[1]: Target '__all' not remade because of errors.
make: *** [Makefile:226: __sub-make] Error 2
make: Target '__all' not remade because of errors.

:(

> ---
>  arch/riscv/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index c5e42cc37604..212ea28e346b 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -50,7 +50,7 @@ config RISCV
>  	select ARCH_WANT_LD_ORPHAN_WARN if !XIP_KERNEL
>  	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
>  	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
> -	select BUILDTIME_TABLE_SORT if MMU
> +	select BUILDTIME_TABLE_SORT
>  	select CLINT_TIMER if !MMU
>  	select CLONE_BACKWARDS
>  	select COMMON_CLK
> --=20
> 2.40.0
>=20

--EG2YHGo4BKAgt7Xt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDUqYAAKCRB4tDGHoIJi
0s+NAP95rLxAoXj+yAMZk9GEMzPkMjw9Nj+tBJ5nl1M3voR1/wD9E62rAX0Y0ogV
wr7SweOexWbvfYXlHHZdCWlyyoAXwQ0=
=VObW
-----END PGP SIGNATURE-----

--EG2YHGo4BKAgt7Xt--
