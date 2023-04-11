Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FB36DDD41
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjDKOHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjDKOHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:07:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956C419C;
        Tue, 11 Apr 2023 07:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681222029; x=1712758029;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iwXMraFk3rEELAWbRtbHrkEz6gUhWBvUZKer76tBfNQ=;
  b=hxYyfBK6gnN44LuVjpjcWE7/3btCqyNo88aYI+IpCLVnsvqUu4EbUp2t
   yYuL4hl9BTGH0BK5Yf6zRASqf/L+ZD6y/R83M832ZKoBTX2JK2cQTXb6X
   dOobPUMoWKpzVmUQoYHuuyanZx4NkTAMvZGvYybjxMSmuiGcj6pL3KkgS
   +FaZtM5dnC+lVC5Kl0MY3c0A91RqVapqcu0b1VNlGs6mixiNFUo/iZ8vl
   HWLF9We7FCrSQ4OSoGEf7gHCns3JB5WY0ToKI4jIELPmBq5p1odsKNi/Y
   6Mc2byM2id37epODVcON8yCqJPfXAlVfWDxC4nwmnyMZnpJCQu/zbdOIz
   g==;
X-IronPort-AV: E=Sophos;i="5.98,336,1673938800"; 
   d="asc'?scan'208";a="220369799"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Apr 2023 07:07:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 11 Apr 2023 07:07:08 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 11 Apr 2023 07:07:04 -0700
Date:   Tue, 11 Apr 2023 15:06:49 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Evan Green <evan@rivosinc.com>
CC:     Palmer Dabbelt <palmer@rivosinc.com>, <slewis@rivosinc.com>,
        <heiko@sntech.de>, Conor Dooley <conor@kernel.org>,
        <vineetg@rivosinc.com>, Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Samuel Holland <samuel@sholland.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v6 4/6] RISC-V: hwprobe: Support probing of misaligned
 access performance
Message-ID: <20230411-prefix-rename-71ab4af0324a@wendy>
References: <20230407231103.2622178-1-evan@rivosinc.com>
 <20230407231103.2622178-5-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YDuEwp07zFXzbIC1"
Content-Disposition: inline
In-Reply-To: <20230407231103.2622178-5-evan@rivosinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--YDuEwp07zFXzbIC1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 07, 2023 at 04:11:01PM -0700, Evan Green wrote:
> This allows userspace to select various routines to use based on the
> performance of misaligned access on the target hardware.
>=20
> Rather than adding DT bindings, this change taps into the alternatives
> mechanism used to probe CPU errata. Add a new function pointer alongside
> the vendor-specific errata_patch_func() that probes for desirable errata
> (otherwise known as "features"). Unlike the errata_patch_func(), this
> function is called on each CPU as it comes up, so it can save
> feature information per-CPU.
>=20
> The T-head C906 has fast unaligned access, both as defined by GCC [1],
> and in performing a basic benchmark, which determined that byte copies
> are >50% slower than a misaligned word copy of the same data size (source
> for this test at [2]):
>=20
> bytecopy size f000 count 50000 offset 0 took 31664899 us
> wordcopy size f000 count 50000 offset 0 took 5180919 us
> wordcopy size f000 count 50000 offset 1 took 13416949 us
>=20
> [1] https://github.com/gcc-mirror/gcc/blob/master/gcc/config/riscv/riscv.=
cc#L353
> [2] https://pastebin.com/EPXvDHSW
>=20
> Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Evan Green <evan@rivosinc.com>
> Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> Tested-by: Heiko Stuebner <heiko.stuebner@vrull.eu>

I think I had given you an R-b a few versions back, guess it was dropped
due to changes or w/e :)

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Perhaps at some point the "errata" naming of those files should change,
but today is not that day.

Cheers,
Conor.

--YDuEwp07zFXzbIC1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDVpeQAKCRB4tDGHoIJi
0t7jAQDMNiwdcIYzMff2OO0oRagi00n+9SjD1CMom7IerxVzoQD8DNnuZQ82JyZU
KaysKejn3MqblyvB0zU+J9PRFOQyJA8=
=Skce
-----END PGP SIGNATURE-----

--YDuEwp07zFXzbIC1--
