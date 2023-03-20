Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5376C1274
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjCTM6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjCTM5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:57:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D777AAA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1679317010; x=1710853010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JxYQs4vBC++B9Sz4RVW+Z4iBWNDki12w1yoHgV52Gxk=;
  b=X2hG0pCkpwDvjno24DzTqtOBZZ/ocU2mMDcccFhZQcm+6DitMcf1UJCJ
   Fc407NVJ5yoXl579Mi3e3ABJc8P37Qi2nSZ4Lv3NTPrQDfVIedamqOKEx
   csB49/Ez8A7AGW93w7ErJus0/6qrM5MBtBPBfKHLbOZbW6HyBQVo5rAJs
   OuKkTcFlHdF7scjq4JtDIPwgRAE0mHW2j18V8GDQP2r7k2vJh6AW3OTpA
   Eeip1Gd6/acgAjbW7zQk+mMIfn+F+Hi0AOTYKf/bwiqywtONzJUvCusL2
   +IYKubnNkPOI1u1Mmaj1phjHZlhgfBcrznp6Dj+8FdNPJ8cp361T+jjzA
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,274,1673938800"; 
   d="asc'?scan'208";a="142921144"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Mar 2023 05:56:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 05:56:49 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 20 Mar 2023 05:56:48 -0700
Date:   Mon, 20 Mar 2023 12:56:18 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <leyfoon.tan@starfivetech.com>,
        <mason.huo@starfivetech.com>
Subject: Re: [PATCH v6 4/4] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Message-ID: <ad8fcf05-0e3f-4350-b9ad-533cee984580@spud>
References: <20230314050316.31701-1-jeeheng.sia@starfivetech.com>
 <20230314050316.31701-5-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="92iwmNY3MZHZxEZB"
Content-Disposition: inline
In-Reply-To: <20230314050316.31701-5-jeeheng.sia@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--92iwmNY3MZHZxEZB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 14, 2023 at 01:03:16PM +0800, Sia Jee Heng wrote:
> Low level Arch functions were created to support hibernation.
> swsusp_arch_suspend() relies code from __cpu_suspend_enter() to write
> cpu state onto the stack, then calling swsusp_save() to save the memory
> image.
>=20
> Arch specific hibernation header is implemented and is utilized by the
> arch_hibernation_header_restore() and arch_hibernation_header_save()
> functions. The arch specific hibernation header consists of satp, hartid,
> and the cpu_resume address. The kernel built version is also need to be
> saved into the hibernation image header to making sure only the same
> kernel is restore when resume.
>=20
> swsusp_arch_resume() creates a temporary page table that covering only
> the linear map. It copies the restore code to a 'safe' page, then start
> to restore the memory image. Once completed, it restores the original
> kernel's page table. It then calls into __hibernate_cpu_resume()
> to restore the CPU context. Finally, it follows the normal hibernation
> path back to the hibernation core.
>=20
> To enable hibernation/suspend to disk into RISCV, the below config
> need to be enabled:
> - CONFIG_ARCH_HIBERNATION_HEADER
> - CONFIG_ARCH_HIBERNATION_POSSIBLE
>=20
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> Reviewed-by: Mason Huo <mason.huo@starfivetech.com>

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index c5e42cc37604..473c2a1a6884 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -707,6 +707,12 @@  menu "Power management options"
> =20
>  source "kernel/power/Kconfig"
> =20
> +config ARCH_HIBERNATION_POSSIBLE
> +	def_bool y
> +
> +config ARCH_HIBERNATION_HEADER
> +	def_bool HIBERNATION
> +
>  endmenu # "Power management options"
> =20
>  menu "CPU Power Management"

Since these options are not user-selectable, how come these are
def_bools, rather than just selecting them in the main `config RISCV`
section? Is there some sort of dependency that goes wrong when
structured that way?

> diff --git a/arch/riscv/kernel/hibernate.c b/arch/riscv/kernel/hibernate.c
> new file mode 100644
> index 000000000000..f11be60b0668
> --- /dev/null
> +++ b/arch/riscv/kernel/hibernate.c

> +/**
> + * struct arch_hibernate_hdr_invariants - container to store kernel buil=
d version.
> + * @uts_version: to save the build number and date so that the we do not=
 resume with

nit: s/so that the we/so that we/

I noted previously that the page table stuff is beyond me, so modulo
that, I'm happy with how this looks now.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for adding hibernation support!
Conor.

--92iwmNY3MZHZxEZB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZBhX8gAKCRB4tDGHoIJi
0l8vAP9Ee+Fz+1lL0amzFYBI/Hu68qUOkYzhS1WKahRNKBYm7wD/VHK4GaBsPUg4
KCiyt/fV6/UPkd/ICdIl2l/kmo6WUg0=
=Npkv
-----END PGP SIGNATURE-----

--92iwmNY3MZHZxEZB--
