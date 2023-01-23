Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D285F677A64
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 12:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjAWLxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 06:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjAWLxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 06:53:47 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA8B11EBB;
        Mon, 23 Jan 2023 03:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674474827; x=1706010827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XOKFYtVwSuo7NbceUr8gbJ4il7bdjARy4NJ/Z6J55HI=;
  b=A0CfBle0F/i8RhDrXOPbQ/whmXHOFnoHruxA2o1ug4PKEhYHPCsb0Q4O
   P8be6k02pK79izoygNkm1biLDLTbhFlyPvnObzbkEQmnb9L0EsHgJrG2k
   GzoeiAbsffExZS/pF+cY+bZNLScNhAJE1nZg18jATjJJ31mNIRMs+aMKd
   GHVKGbkXi6DUmWoLvy+C+3iOJWmtzkmyEw3PZjS870jOoh8DZcXYLRVxI
   X11JTTA+c59ccPbhd933jThorCxqY3wbUQH8Wsi/E/URyTmRit2egLcEs
   IB/ykIaAKEAe6kQIJj63qozjhJc5IIO/w5E8Bdkscdca9eg5Lqo8adk1V
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,239,1669100400"; 
   d="asc'?scan'208";a="193427985"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jan 2023 04:53:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 04:53:44 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 23 Jan 2023 04:53:42 -0700
Date:   Mon, 23 Jan 2023 11:53:19 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Subject: Re: [PATCH v3] riscv: Allow to downgrade paging mode from the command
Message-ID: <Y851L2KgfIF3V6of@wendy>
References: <20230123104841.813999-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XcFxwQIDKAyigG7z"
Content-Disposition: inline
In-Reply-To: <20230123104841.813999-1-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--XcFxwQIDKAyigG7z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Alex,

On Mon, Jan 23, 2023 at 11:48:41AM +0100, Alexandre Ghiti wrote:
> Add 2 early command line parameters that allow to downgrade satp mode
> (using the same naming as x86):
> - "no5lvl": use a 4-level page table (down from sv57 to sv48)
> - "no4lvl": use a 3-level page table (down from sv57/sv48 to sv39)
>=20
> Note that going through the device tree to get the kernel command line
> works with ACPI too since the efi stub creates a device tree anyway with
> the command line.
>=20
> Also, as those params are treated very early in the boot process and we
> use standard device tree functions that may be kasan instrumented, we
> only enable them for !KASAN configurations.
>=20
> Reviewed-by: Bj=F6rn T=F6pel <bjorn@kernel.org>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---

A changelog would be nice here, especially since this is a resend.

>  .../admin-guide/kernel-parameters.txt         |  9 ++-
>  arch/riscv/mm/init.c                          | 72 +++++++++++++++++--
>  2 files changed, 74 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 6cfa6e3996cf..fd647412ec91 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3578,8 +3578,15 @@
>  			emulation library even if a 387 maths coprocessor
>  			is present.
> =20
> -	no5lvl		[X86-64] Disable 5-level paging mode. Forces
> +	no4lvl		[RISCV] Disable 4-level and 5-level paging modes. Forces
> +			kernel to use 3-level paging instead.
> +			Note: On RISC-V, this can't be used when KASAN is
> +			enabled.
> +
> +	no5lvl		[X86-64,RISCV] Disable 5-level paging mode. Forces
>  			kernel to use 4-level paging instead.
> +			Note: On RISC-V, this can't be used when KASAN is
> +			enabled.
> =20
>  	nofsgsbase	[X86] Disables FSGSBASE instructions.
> =20

For the improved descriptions & commit message:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.


--XcFxwQIDKAyigG7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY851LwAKCRB4tDGHoIJi
0l53AQCQBy900mmtPk9mKM2S57CvkHVjvKm4ZRfqIL0OzE1p/wD9EENKG8gQAyvL
Ul0Q3WPbMqxqHndNJMtEyr2dDYBQkAI=
=gpGS
-----END PGP SIGNATURE-----

--XcFxwQIDKAyigG7z--
