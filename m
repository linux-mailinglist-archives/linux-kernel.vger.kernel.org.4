Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1057710C64
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241043AbjEYMut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjEYMur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:50:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0423812F;
        Thu, 25 May 2023 05:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685019046; x=1716555046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gnIghBiDVeI92f1OSI9YGrzltj/g25Nt66G/3GQMoc4=;
  b=vYwovre1ftkpFRKK2ZZBnGvToyg8r7ZW6e7TCosV6ERHgbL8brt2LTu4
   dhWRcLqGdA9ctjBo+ZxHJ1Qx9cYM8bHAyUtJH6hjZCdO6DgSUXI19m7bF
   ORCcU9SdvVX9vXxVQbmUmSUNdPCSvLSk9zhxSl6OscmhOuz5U5Ym55pJU
   r3X2DEm4xekOdwxZ9Z7zRHDkscM9SFsN5f7zXdRvZHixnuDV9P3vjHzGh
   iYocbt4u+RKOgBShv2OyuNTPD65gm/4fLI9bBAPlGM2o+q4nxDuQbUFS6
   UjMpsPN7thqgAC7aiDyw+S1o6Bv0a3HtZ1Ydx1znBgttyEasGNCQ7qLH0
   A==;
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="asc'?scan'208";a="215444870"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 May 2023 05:50:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 25 May 2023 05:50:44 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 25 May 2023 05:50:42 -0700
Date:   Thu, 25 May 2023 13:50:19 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
CC:     Conor Dooley <conor@kernel.org>, <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, <alex@ghiti.fr>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        <linux-next@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>,
        <vitaly.wool@konsulko.com>
Subject: Re: linux-next: Tree for May 15 (several RV64 build errors)
Message-ID: <20230525-scoff-eldest-57ec643005dc@wendy>
References: <20230524-scalping-number-63ec10c1f7bf@spud>
 <mhng-29a35d51-8791-449e-96f6-a7faf77f3f36@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GA19nHWYt1Z7wyOt"
Content-Disposition: inline
In-Reply-To: <mhng-29a35d51-8791-449e-96f6-a7faf77f3f36@palmer-ri-x1c9a>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--GA19nHWYt1Z7wyOt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 04:11:05PM -0700, Palmer Dabbelt wrote:
> On Wed, 24 May 2023 15:49:41 PDT (-0700), Conor Dooley wrote:
> > On Wed, May 24, 2023 at 03:41:15PM -0700, Randy Dunlap wrote:

> > > XIP_KERNEL already has "depends on !COMPILE_TEST", since April of 202=
1.
> >=20
> > Half of me wants to say just remove XIP_KERNEL entirely. Or make it
> > depend on BROKEN, since noone seems to actually test it and I don't
> > think we even know if it works right now?
>=20
> Ya, let's do it.  If it's broken and nobody has said anything but
> randconfig, then probably nobody's using it.  Let's mark it as broken or
> deprecated or whatever and then see if anyone complains.

Apart from being able to generate kernels that are broken (IOW this
randconfig), when we changed the dtb back to being in the fix, we
removed some special case XIP_KERNEL stuff (that's commit f1581626071c
("riscv: Do not set initial_boot_params to the linear address of the
dtb")) where Alex didn't know for sure whether it was safe to do.


Vexriscv (which is Myrtle I think) & Vitaly Wool both have an interest
in it. I dunno Myrtle's email, but I've CCed Vitaly. Maybe someone can
at least test the thing :)

Cheers,
Conor.

--GA19nHWYt1Z7wyOt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG9ZiwAKCRB4tDGHoIJi
0uTYAQD75o4X0KcjEEibuYRBtbJxLrzul579rcG5gj7RbbR/WQEAyRAKttZ1DLiQ
bjZFN8t3FSiE3wAGS14B7QIwTxW+mgE=
=b8Nx
-----END PGP SIGNATURE-----

--GA19nHWYt1Z7wyOt--
