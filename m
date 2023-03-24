Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED756C7D46
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjCXLhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCXLhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:37:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1AF1CF7E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1679657851; x=1711193851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IYX2yiBdi+H5GU+DmapKpR5UJVC8Y6HTCJ/8rFnvS8Q=;
  b=db5Fntd9kzIyeWl+7qRBo4BeFRhME72hEX9NRSzMK/kLoc3BjFg2bQp0
   e2fJG2IrDHK0Csfc6q1EXzqVQZV6wa4VwPYRSVgur3AV3/5sgbjPANIDb
   nKGPu8NNNVzxJKs1MOhg/7XoU4k6uvSGWb/AhJFRIVt/wqllN0gqGvOvN
   hl1JVe+rfHaCoPn5Mxrutdh6IvWW8KuceT7ZO1WeodVu/UPij3tu/J1zF
   IfucBajRTo1lMBdH5hPqKa6DSa/8aYgF78jGdwY7Yhj8JM0fGwwE/gFRF
   UE98MRL7ZaT9RaASj7j6VruMG7Iyrw5WaYL5HdebFg3G1cvHcX+tDBFXS
   w==;
X-IronPort-AV: E=Sophos;i="5.98,287,1673938800"; 
   d="asc'?scan'208";a="143714944"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Mar 2023 04:37:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 04:37:26 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 24 Mar 2023 04:37:24 -0700
Date:   Fri, 24 Mar 2023 11:37:05 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     <palmer@dabbelt.com>, <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/2] RISC-V: Fixes for
 riscv_has_extension[un]likely()'s alternative dependency
Message-ID: <e7a93223-54e4-4c97-b121-5d1be3af0d65@spud>
References: <20230324100538.3514663-1-conor.dooley@microchip.com>
 <20230324113107.djp4ejnlpzn3qzrb@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ny1hFZsdzoiIlIxz"
Content-Disposition: inline
In-Reply-To: <20230324113107.djp4ejnlpzn3qzrb@orel>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ny1hFZsdzoiIlIxz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2023 at 12:31:07PM +0100, Andrew Jones wrote:
> On Fri, Mar 24, 2023 at 10:05:37AM +0000, Conor Dooley wrote:
> > Here's my attempt at fixing both the use of an FPU on XIP kernels and
> > the issue that Jason ran into where CONFIG_FPU, which needs the
> > alternatives frame work for has_fpu() checks, could be enabled without
> > the alternatives actually being present.
> >=20
> > For the former, a "slow" fallback that does not use alternatives is
> > added to riscv_has_extension_[un]likely() that can be used with XIP.
> > Obviously, we want to make use of Jisheng's alternatives based approach
> > where possible, so any users of riscv_has_extension_[un]likely() will
> > want to make sure that they select RISCV_ALTERNATIVE.
> > If they don't however, they'll hit the fallback path which (should,
> > sparing a silly mistake from me!) behave in the same way, thus
> > succeeding silently. Sounds like a
> >=20
> > To prevent "depends on !XIP_KERNEL; select RISCV_ALTERNATIVE" spreading
> > like the plague through the various places that want to check for the
> > presence of extensions, and sidestep the potential silent "success"
> > mentioned above, all users RISCV_ALTERNATIVE are converted from selects
> > to dependencies, with the option being selected for all !XIP_KERNEL
> > builds.
> >=20
> > I know that the VDSO was a key place that Jisheng wanted to use the new
> > helper rather than static branches, and I think the fallback path
> > should not cause issues there.
> >=20
> > See the thread at [1] for the prior discussion.
> >=20
> > Cheers,
> > Conor.
> >=20
> > 1 - https://lore.kernel.org/linux-riscv/20230128172856.3814-1-jszhang@k=
ernel.org/T/#m21390d570997145d31dd8bb95002fd61f99c6573
> >=20
> > CC: Paul Walmsley <paul.walmsley@sifive.com>
> > CC: Palmer Dabbelt <palmer@dabbelt.com>
> > CC: Conor Dooley <conor.dooley@microchip.com>
> > CC: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > CC: Andrew Jones <ajones@ventanamicro.com>
> > CC: Anup Patel <apatel@ventanamicro.com>
> > CC: Jisheng Zhang <jszhang@kernel.org>
> > CC: Andrew Jones <ajones@ventanamicro.com>
> > CC: Jason A. Donenfeld <Jason@zx2c4.com>
> > CC: linux-riscv@lists.infradead.org
> > CC: linux-kernel@vger.kernel.org
> >=20
> > Conor Dooley (2):
> >   RISC-V: add non-alternative fallback for
> >     riscv_has_extension_[un]likely()
> >   RISC-V: always select RISCV_ALTERNATIVE for non-xip kernels
> >=20
> >  arch/riscv/Kconfig             | 12 ++++----
> >  arch/riscv/Kconfig.erratas     |  6 ++--
> >  arch/riscv/include/asm/hwcap.h | 50 ++++++++++++++++++++--------------
> >  3 files changed, 38 insertions(+), 30 deletions(-)
> >=20
> > --=20
> > 2.39.2
> >
>=20
> LGTM, but if it was based on for-next then it could also immediately be
> applied to zicboz. For the series,

Hmm, I did it on top of fixes since this needs to go into v6.3.
Perhaps I can create a standalone patch for Zicboz and Palmer could merge
these two into both fixes & for-next, with the standalone applied on
top?



--ny1hFZsdzoiIlIxz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZB2LYQAKCRB4tDGHoIJi
0lyGAP41T7BFcI8gpNw9Enx+WARRH/LnHpRTEIp5DD90xctutwEA/0H/s+TCAH2W
54dRVB1P9vR5Fb4nrt/k06p8ZHDa3wg=
=4buk
-----END PGP SIGNATURE-----

--ny1hFZsdzoiIlIxz--
