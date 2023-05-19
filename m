Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E5C7098C8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 15:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjESNzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 09:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjESNzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 09:55:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F077712C
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 06:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684504500; x=1716040500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SFnwP/vyGrDIlPPr2daJemFKu+u/gI6MTNacrNW4jKs=;
  b=qjBn+JjTG7s7c0LCkvjM0ZuMJN880ck63NrelokQWg78yORayFrWfLfq
   zUxX1LUQvetJpOVt+RFWlqqOY+Yvmx6NMR+qivNnQSW7q3aLbtHarVRf9
   pOXkaBFxo3o7/CBhU8xPj/+pQ7MBc1eB4ymX0ixfPrduG140hdJkro9XY
   VprACmflGTZyrCtnoeZeyhHTYqKgdym2jdf7aeE31b9WVn2j32hx9sX4z
   WhNMj0m8FsgtPZv2YygqIkdRcShiFgae9a3lTndarDBxzJnT9JVCkqS6u
   lEF5p9IQMho/qT2dMFmuoPel51byM8HTtzNXJxOO+/Q1ayUyi8pR4sqIx
   w==;
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="asc'?scan'208";a="152970577"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 May 2023 06:54:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 19 May 2023 06:54:54 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 19 May 2023 06:54:53 -0700
Date:   Fri, 19 May 2023 14:54:32 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -fixes] riscv: Fix unused variable warning when
 BUILTIN_DTB is set
Message-ID: <20230519-backhand-overbid-1df4d90f7da8@wendy>
References: <20230519131311.391960-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aPJ+XWcPL1J5bSvX"
Content-Disposition: inline
In-Reply-To: <20230519131311.391960-1-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--aPJ+XWcPL1J5bSvX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 03:13:11PM +0200, Alexandre Ghiti wrote:
> commit ef69d2559fe9 ("riscv: Move early dtb mapping into the fixmap
> region") wrongly moved the #ifndef CONFIG_BUILTIN_DTB surrounding the pa
> variable definition in create_fdt_early_page_table(), so move it back to
> its right place to quiet the following warning:
>=20
> ../arch/riscv/mm/init.c: In function =E2=80=98create_fdt_early_page_table=
=E2=80=99:
> ../arch/riscv/mm/init.c:925:12: warning: unused variable =E2=80=98pa=E2=
=80=99 [-Wunused-variable]
>   925 |  uintptr_t pa =3D dtb_pa & ~(PMD_SIZE - 1);
>=20
> Fixes: ef69d2559fe9 ("riscv: Move early dtb mapping into the fixmap regio=
n")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks Alex.

--aPJ+XWcPL1J5bSvX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGd/mAAKCRB4tDGHoIJi
0h2IAPwLAxCJ/+0IRNhP4m6vQWaDwze4VcB5EC2wibqTlCYvYwEAyzyVVdDhAhwW
JYlxPuibr/SjwKVsvC8sLseZIFPboAA=
=WuyF
-----END PGP SIGNATURE-----

--aPJ+XWcPL1J5bSvX--
