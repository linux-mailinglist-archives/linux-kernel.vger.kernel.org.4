Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE7E674EF2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjATIF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjATIFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:05:53 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2B740D6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674201954; x=1705737954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M/vFMlrK2KnqeufhmqNtiNZik2hNdR9y2XiFORuw/PQ=;
  b=QlP4yYJ/HkpPbLibBNcmskWIQfelMpnb4LoO/uZbU4r2XRm0y/RRjKg3
   m3tGWqmJOKiSt7zz4iRNeELwzLJeen6gmN6u8SO5i1YAwGd0gse+OK1ta
   raxtJ+s8+fyINqSz2V/lQ9l2asiAJfma7cerS3bRU8MmyhCoVl1ILOnYq
   5OWtaEYyeC2nDFUu7tNMLgp2/Yk6vJD8GCeU78Wnz28sCW3u0TZWPbZN6
   S9zlG3ZT02+mCTygS8tKACrc9PtROYjUGSV06kCiwpDsCmTGOLIW41oZF
   ZHdW9ObIaA+e+pulolKSNh6wVZCoRh0pXQOjYvUVB5tLf+EGt/a47blpP
   A==;
X-IronPort-AV: E=Sophos;i="5.97,231,1669100400"; 
   d="asc'?scan'208";a="197592595"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2023 01:05:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 01:05:52 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Fri, 20 Jan 2023 01:05:50 -0700
Date:   Fri, 20 Jan 2023 08:05:27 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jesse Taube <mr.bossman075@gmail.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Yimin Gu <ustcymgu@gmail.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v1 2/2] riscv: configs: Add nommu decfconfig for RV32
Message-ID: <Y8pLR7CUad2eLe+A@wendy>
References: <20230119052642.1112171-1-Mr.Bossman075@gmail.com>
 <20230119052642.1112171-3-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GLd6KBy4q8LeeBDp"
Content-Disposition: inline
In-Reply-To: <20230119052642.1112171-3-Mr.Bossman075@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--GLd6KBy4q8LeeBDp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Jesse,

Same here w/ a single nit.
I'll leave judging whether supporting rv32 nommu is worthwhile to others!

On Thu, Jan 19, 2023 at 12:26:42AM -0500, Jesse Taube wrote:
> riscv: configs: Add nommu decfconfig for RV32

typo: defconfig

Thanks,
Conor.

> 32bit risc-v can be configured to run without MMU. This patch adds
> an example configuration for RV32 nommu virtual machine.
>=20
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> Cc: Yimin Gu <ustcymgu@gmail.com>
> ---
>  arch/riscv/configs/rv32_nommu_virt_defconfig | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 arch/riscv/configs/rv32_nommu_virt_defconfig
>=20
> diff --git a/arch/riscv/configs/rv32_nommu_virt_defconfig b/arch/riscv/co=
nfigs/rv32_nommu_virt_defconfig
> new file mode 100644
> index 000000000000..460907253a80
> --- /dev/null
> +++ b/arch/riscv/configs/rv32_nommu_virt_defconfig
> @@ -0,0 +1,16 @@
> +CONFIG_BLK_DEV_INITRD=3Dy
> +# CONFIG_MMU is not set
> +CONFIG_COMPAT_32BIT_TIME=3Dy
> +CONFIG_SOC_VIRT=3Dy
> +CONFIG_NONPORTABLE=3Dy
> +CONFIG_ARCH_RV32I=3Dy
> +CONFIG_BINFMT_FLAT=3Dy
> +CONFIG_SLOB=3Dy
> +CONFIG_VIRTIO_BLK=3Dy
> +CONFIG_SERIAL_8250=3Dy
> +CONFIG_SERIAL_8250_CONSOLE=3Dy
> +CONFIG_SERIAL_OF_PLATFORM=3Dy
> +CONFIG_VIRTIO_MMIO=3Dy
> +CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=3Dy
> +CONFIG_EXT2_FS=3Dy
> +CONFIG_PRINTK_TIME=3Dy
> --=20
> 2.39.0
>=20
>=20

--GLd6KBy4q8LeeBDp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8pLRwAKCRB4tDGHoIJi
0kg2APsF9EWMCh3V0/jjH/xYpiSbRuTSUV5wrKfqJH3ToQ7IWwD/RJR7Rut4vZTe
BQoyi9Tt2/66Fk2/IAg2KAkUwC9x+AE=
=yXNl
-----END PGP SIGNATURE-----

--GLd6KBy4q8LeeBDp--
