Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6ABE6CD20D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 08:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjC2GZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 02:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjC2GZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 02:25:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE82B19C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 23:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680071100; x=1711607100;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=btrEcK6oKDnlwNVGNsowDbjHvRzGVgad8YxisSvBgaU=;
  b=qv9i8bzoiVMVWcoIb419+7/wG4sPwTrRio9NPsnOfz6XhPv4GGBwI/tE
   0aejoaBY9SfFfOqi3ebBi26WoWK9Q4Pobp/r/ElJQSyk6wYnWtMpGS6LN
   0Wzl1MxZfmp0T4x0330ud/bKVDSEAq5u6c9c6Day3c76Gj+piNFok0EQw
   FUaC15DKb7iR2oJanqUQpE+oohfBD9voP/a3+yR67mcwFRF9bhF0FohMg
   /yW7BNvdYsVfL+zzBL8oRQQKFcXQ6BUj9w14VYzI7ByTXbzp3XNF46VQ+
   mLP674JDBGvmlc18F1SEN5DuP9IU2bG2r963eQrdM2R7Y/pjkAWNNxkNh
   w==;
X-IronPort-AV: E=Sophos;i="5.98,300,1673938800"; 
   d="asc'?scan'208";a="144426032"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Mar 2023 23:24:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 23:24:59 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 28 Mar 2023 23:24:58 -0700
Date:   Wed, 29 Mar 2023 07:24:45 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     =?utf-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
CC:     Conor Dooley <conor@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH] riscv/fault: Dump user opcode bytes on
 fatal faults
Message-ID: <747a3382-17e7-4167-a1bb-30a9482be4d1@spud>
References: <20230327115642.1610-1-cuiyunhui@bytedance.com>
 <d7111158-7e17-4c88-a8c1-a568db5891fa@spud>
 <CAEEQ3wkKr9NhKwo0O3D=pfi80j7-cup3VgaWuk8vdk87=ryy6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/UTeI/7U2Ed3I4C0"
Content-Disposition: inline
In-Reply-To: <CAEEQ3wkKr9NhKwo0O3D=pfi80j7-cup3VgaWuk8vdk87=ryy6g@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--/UTeI/7U2Ed3I4C0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey =E8=BF=90=E8=BE=89=E5=B4=94,

On Wed, Mar 29, 2023 at 11:52:21AM +0800, =E8=BF=90=E8=BE=89=E5=B4=94 wrote:
> On Wed, Mar 29, 2023 at 1:03=E2=80=AFAM Conor Dooley <conor@kernel.org> w=
rote:
>=20
> > riscv/fault: Dump user opcode bytes on fatal faults
> >
> > I think you can drop the /fault, we don't usually use prefixes that like
> > for RISC-V.
> >
> ok, i'll update it on v2
>=20
>=20
> > > In this way, we found the problem: in the system bringup , it is
> > > precisely that we have not enabled the floating point function.
> >
> > What do you mean by that "have not enabled the floating point function"?
>=20
> The related cpu feature(COMPAT_HWCAP_ISA_F) is not enabled in the
> riscv_fill_hwcap function interface.

Right, I'm trying to figure out of this is another bug in the kernel -
if you don't have "fd" in riscv,isa in your devicetree then, even if
CONFIG_FPU is set, none of the FPU code is meant to run, right?

> > > So when an exception occurs, it is necessary to dump the instruction
> > > that caused the exception, like x86/fault (ba54d856a9d8).
> >
> > That's not the usual format for referring to commits, checkpatch should
> > complain about that.
>=20
> ok, i'll update it on v2.
>=20
> > >
> > > Logs:
> > > [    0.822481] Run /init as init process
> > > [    0.837569] init[1]: unhandled signal 4 code 0x1 at 0x000000000005=
e028 in bb[10000+5fe000]
> > > [    0.932292] CPU: 0 PID: 1 Comm: init Not tainted 5.14.0-rc4-00048-=
g4a843c9043e8-dirty #138
> >
> > 5.14-rc4?, oof! Need to get yourself onto a released, LTS kernel I
> > think!
>=20
> Just a print,v6.3-rc1 also has this problem.

Right, but that's a pretty old kernel to be using!
Seeing 5.14 and the patch not applying made me wonder if the patch was
generated against an old kernel.

> > Anyway, this patch doesn't apply to either riscv/for-next, riscv/fixes
> > or v6.3-rc1. What is the appropriate base to apply this patch?
>=20
> ok, i'll update it on v2.
>=20
>=20
> > > [    0.936073]  s2 : 0000000000000000 s3 : 0000000000000000 s4 : 0000=
000000000000
> > > [    0.936495]  s5 : 0000000000000000 s6 : 0000000000000000 s7 : 0000=
000000000000
> > > [    0.936947]  s8 : 0000000000000000 s9 : 0000000000000000 s10: 0000=
000000000000
> > > [    0.937487]  s11: 0000000000d14980 t3 : 0000000000000000 t4 : 0000=
000000000000
> > > [    0.937954]  t5 : 0000000000000000 t6 : 0000000000000000
> > > [    0.938510] status: 0000000200000020 badaddr: 00000000f0028053 cau=
se: 0000000000000002
> >
> > I have no idea what the significance of this particular backtrace is,
> > could you elaborate on what this is demonstrating? (and drop the leading
> > [###] too as it doesn't exactly add anything!
>=20
> The current call trace does not show the instruction that caused the
> exception. ok, I'll remove it on v2.

What would be nice to have is what the new show_opcodes() function will
look like ;)

Thanks,
Conor.

--/UTeI/7U2Ed3I4C0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCPZpwAKCRB4tDGHoIJi
0s1fAQCm4oULcphdtOSND1cOULbltbKkGusev+/Y2mapc2krNQD+MBYsxPndY7B2
yGrJcCth6aAkpeq9EbjApkUKK0nT3wg=
=/241
-----END PGP SIGNATURE-----

--/UTeI/7U2Ed3I4C0--
