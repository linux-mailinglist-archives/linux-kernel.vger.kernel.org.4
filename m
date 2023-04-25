Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06146EE28F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbjDYNO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjDYNO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:14:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254E72D52
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1682428495; x=1713964495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EliR2mT5GHfq/CKDHDhaxmjdPcWX1dx8dle38J9zdZo=;
  b=EANxaqlSntXqP8cG4syR45fRFdYcoAWJLOmc1X+/tMIiNbZqaC9OLuyP
   VxWbNlTqvc9Xgt5jzzh7pJeVFihQLlKDmC6ZAzVFAtI9ngkfad3hHdRZT
   gcsnHySN9A5TjcK8CSq1ZbC3DfKDnQdWdj9WjSs/Wznew0oLEWPCZzsEY
   da1tCLu9D7GJVzkJMmTdANxfZRV7M3c0t+BJOWb6tsxXWZV+772czRZe3
   mwp3L5QfLAavb4NaHF98ZXaMm7+QWWR2Au2pDyKGsO3NJpYRhT/633brz
   oXoe769y+TbBCpDWVxmOaOdIE3wcsdhknLK2yqoGve9lwo0RgjyoFkJ6s
   w==;
X-IronPort-AV: E=Sophos;i="5.99,225,1677567600"; 
   d="asc'?scan'208";a="222476364"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Apr 2023 06:14:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 25 Apr 2023 06:14:54 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 25 Apr 2023 06:14:53 -0700
Date:   Tue, 25 Apr 2023 14:14:36 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Yangyu Chen <cyy@cyyself.name>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Wende Tan <twd2.me@gmail.com>, Soha Jin <soha@lohu.info>,
        Hongren Zheng <i@zenithal.me>
Subject: Re: [PATCH 0/2] Allow case-insensitive RISC-V ISA string
Message-ID: <20230425-flyable-prompter-5b1e4cebf9db@wendy>
References: <tencent_1647475C9618C390BEC601BE2CC1206D0C07@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7A3Ma5DfJIchBKeX"
Content-Disposition: inline
In-Reply-To: <tencent_1647475C9618C390BEC601BE2CC1206D0C07@qq.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--7A3Ma5DfJIchBKeX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey!

For some reason this cover letter has been detached from the series
itself. I think that might be a bug with git send-email.

The rest of the series is:
<tencent_63090269FF399AE30AC774848C344EF2F10A@qq.com>
<tencent_221A82C2DAF38E66B85B313221958DDD7C08@qq.com>

On Tue, Apr 25, 2023 at 08:00:14PM +0800, Yangyu Chen wrote:
> According to RISC-V ISA specification, the ISA naming strings are
> case insensitive. The kernel docs require the riscv,isa string must
> be all lowercase to simplify parsing currently. However, this=20
> limitation is not consistent with RISC-V ISA Spec.

Correct. riscv,isa allows only subset of what the ISA spec does.

> The motivation for this patch series is that some SoC generators
> will provide ISA strings with uppercase letters in the device tree.

If these generators are emitting devicetrees, why not fix the code in
these generators so that they produce something that is aligned with the
dt-binding?

> For example, the rocket-chip will have "Zicsr_Zifencei_Zihpm_Xrocket"
> in the ISA string.

https://github.com/chipsalliance/rocket-chip/pull/3232

It looks like when this was added to rocket-chip it was not actually
tested properly? The output would not pass dt-validate. The author is on
CC I assume, so maybe they can fix rocket-chip? You can CC @conchuod on
that PR if you like.

Do any other core generators emit capitals here, or have you only
noticed it with rocket-chip?

> If we did not modify the ISA string manually, the
> parser in the current kernel will have errors when the pointer meets
> uppercase letters because it assumes the string only has digits,=20
> lowercase letters, and underscores. Then, the parser will fail and
> the pointer of the parser will continue at the next position, which
> will confuse the parser and cause the kernel to misbehave.
>=20
> For example, "Zifencei" will be parsed as "ifc" since the parser will
> fail at 'Z' and then continue at 'i'. Then, if we disable the FPU in
> the CPU hardware and remove the "fd" from the device tree but leave
> the CONFIG_FPU=3Dy in the kernel, the kernel will panic at=20
> `__fstate_restore` function since the "Zifencei" (parsed as "ifc")
> will confuse the current kernel that the CPU has "f", and the kernel
> will save and restore the FPU registers during the context switch,
> leading to illegal instruction exceptions.

Here's an idea, run dtbs_check to validate your devicetree is correct?
If you mess up your devicetree in other ways, then your system is going
to have issues, so why would riscv,isa be any different?

> However, it is not necessary to require the ISA string must be all
> lowercase. The case-insensitive parser can be easily implemented
> using `strncasecmp` and `tolower` functions. Moreover, the kernel
> parser implementation should match the ISA specification rather than
> using a more strict rule.

On the contrary, we actually *cannot* match the ISA specification at
this point.
For example, the ISA spec currently says that zicsr and zifencei are
not part of `i`, but riscv,isa was defined prior to the extraction of
those extensions from `i` and so `i` in riscv,isa means the same
`i_zicsr_zifencei` in the RISC-V ISA specification.

> This patch series allows case-insensitive RISC-V ISA string:
> * Patch 1 modifies the ISA string parser in the kernel to support
>   case-insensitive ISA string parsing. It replaces `strncmp` with
>   `strncasecmp`, replaces `islower` with `isalpha`, and wraps the
>   dereferenced char in the parser with `tolower`.
> * Patch 2 modifies the docs to no longer require the riscv,isa
>   string to be all lowercase.

So what happens if you boot an old kernel with a devicetree whose
riscv,isa string has been validated by this modified dt-binding, but
contains capital letters?
That kernel + dtb will have issues in the manner you describe above but
dtbs_check etc will have passed.
If anything, the kernel should abort parsing the ISA string if it sees
a capital letter to avoid scenarios like the above.

=46rom me this is a NAK on that basis, sorry. Please try and fix the
generators to emit devicetrees that pass dt-validate.

Thanks,
Conor.

--7A3Ma5DfJIchBKeX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEfSOwAKCRB4tDGHoIJi
0l40AQDJ8WcQgKPnZcx88tEI56RsG3jcYPmB1VBc6634Q9JTGgD+P2Y3Te+9OhAW
Xlsmfixe/JLU2F//Pjh+0MvISv6tpgg=
=6dOF
-----END PGP SIGNATURE-----

--7A3Ma5DfJIchBKeX--
