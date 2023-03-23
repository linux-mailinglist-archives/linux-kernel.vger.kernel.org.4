Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1096C6165
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjCWINr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjCWINp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:13:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6180323130;
        Thu, 23 Mar 2023 01:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1679559223; x=1711095223;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NFSoKBhi6R5X0QVCKQ8IrghC4gXzDiIpe9L/ab5ePEo=;
  b=b0nfnYFMuNMI0TTNwBt5zgwc57WmWiDnBFzt4NJrIU+vuXazRHaDC5nU
   Iw/vcDMLuiSk89dvmmnLSQ7WsNTRY8gIo4ieNE8cSqWx5Qba9UzH1yfLw
   T8Vd5Tx6jiteCD7hHSWXGiBYdW0FcjN9rfrEL8HrTNGedKjWtI0MHPHCo
   uEN+dgL+stGvVGKVByMTdfTMxCrb4bw3KB1TU+kgZwCRYjzgVNw+xZndn
   Go+T34kYByCIlYn/cschtPqs9xWdUdIPVMQ3DKXg+ijQ72x89qoUGHWv2
   poDARpKrRLu/ddzRrOSNssUV1VA7dr3jXsEmKHWgeaiFbH4zvYp9ULn7m
   A==;
X-IronPort-AV: E=Sophos;i="5.98,283,1673938800"; 
   d="asc'?scan'208";a="203023966"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Mar 2023 01:13:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 01:13:37 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 23 Mar 2023 01:13:34 -0700
Date:   Thu, 23 Mar 2023 08:13:15 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, <lkft-triage@lists.linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, <lstoakes@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <liam.howlett@oracle.com>, <willy@infradead.org>,
        <vernon2gm@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: next-20230323: arm64: vma_merge (mm/mmap.c:952 (discriminator
 1)) - Unable to handle kernel paging request at virtual address
 0000000000100111 -
Message-ID: <56499ad1-3d82-457e-9886-12b4665c4f9f@spud>
References: <CA+G9fYvBxp38KEggtvtvVtGMaSBdL3NDV9ns=Zi9-Jtx7H9g1A@mail.gmail.com>
 <f8628535-05a4-4d42-217f-88d68749010f@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ngahxEO0Y0ADLOJ0"
Content-Disposition: inline
In-Reply-To: <f8628535-05a4-4d42-217f-88d68749010f@suse.cz>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ngahxEO0Y0ADLOJ0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2023 at 08:51:25AM +0100, Vlastimil Babka wrote:
> On 3/23/23 08:35, Naresh Kamboju wrote:
> > The following kernel crash was noticed on arm x15, arm64 hikey-6220, Ju=
no-r2,
> > x86_64 and i386 devices on Linux next-20230323.

To add one more to the sample size, it's falling over on RISC-V too!

> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >=20
> > crash log on arm64:
> > ---------------
> > [   19.281223] Unable to handle kernel paging request at virtual
> > address 0000000000100111
> > [   19.289189] Mem abort info:
> > [   19.291995]   ESR =3D 0x0000000096000006
> > [   19.295757]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > [   19.301086]   SET =3D 0, FnV =3D 0
> > [   19.304151]   EA =3D 0, S1PTW =3D 0
> > [   19.307302]   FSC =3D 0x06: level 2 translation fault
> > [   19.312194] Data abort info:
> > [   19.315083]   ISV =3D 0, ISS =3D 0x00000006
> > [   19.318930]   CM =3D 0, WnR =3D 0
> > [   19.321901] user pgtable: 4k pages, 48-bit VAs, pgdp=3D00000008a23c5=
000
> > [   19.328374] [0000000000100111] pgd=3D08000008a14c5003,
> > p4d=3D08000008a14c5003, pud=3D08000008a14c6003, pmd=3D0000000000000000
> > [   19.339037] Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
> > [   19.345315] Modules linked in:
> > [   19.348373] CPU: 2 PID: 1 Comm: init Not tainted 6.3.0-rc3-next-2023=
0323 #1
>=20
> next-20230323 seems to contain v2 of Lorenzo's vma_merge cleanups
>=20
> > [   19.355347] Hardware name: ARM Juno development board (r2) (DT)
> > [   19.361273] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [   19.368246] pc : vma_merge (mm/mmap.c:952 (discriminator 1))
>=20
> And this is a line involving 'next' and Liam pointed out a possibly
> unitialized next in v2, so that's probably it.
> Andrew replaced it with a fixed version so it should make its way to -next
> as well.

Cool, hopefully it is fixed tomorrow :)

Cheers,
Conor.

> > [   19.371917] lr : vma_merge (mm/mmap.c:945)
> > [   19.375670] sp : ffff80000b37bb40
> > [   19.378985] x29: ffff80000b37bb40 x28: ffff000820c0ff20 x27: 0000000=
000000000
> > [   19.386139] x26: ffff000820c17210 x25: ffff000800bfac00 x24: 0000fff=
f8e8b7000
> > [   19.393293] x23: 0000000000100071 x22: ffff000800898d80 x21: 0000000=
000100071
> > [   19.400446] x20: ffff80000b37bd18 x19: 0000ffff8e8ba000 x18: ffff800=
00b37bd18
> > [   19.407599] x17: 0000000000000000 x16: ffff8000099a58c8 x15: 0000fff=
f8e9aefff
> > [   19.414752] x14: 0000ffff8e8b7000 x13: 1fffe001041bb361 x12: ffff800=
00b37baf8
> > [   19.421905] x11: ffff000822473400 x10: ffff000820dd9b08 x9 : ffff800=
00830fc64
> > [   19.429057] x8 : 0000ffff8e8b7000 x7 : 0000ffff8e8b7000 x6 : ffff000=
820dd9b50
> > [   19.436210] x5 : ffff000820c0ff20 x4 : 0000000000000187 x3 : ffff000=
800bfac00
> > [   19.443363] x2 : 0000000000000000 x1 : 0000000000100071 x0 : 0000000=
000000000
> > [   19.450515] Call trace:
> > [   19.452960] vma_merge (mm/mmap.c:952 (discriminator 1))
> > [   19.456279] mprotect_fixup (mm/mprotect.c:676)
> > [   19.460034] do_mprotect_pkey.constprop.0 (mm/mprotect.c:862)
> > [   19.465094] __arm64_sys_mprotect (mm/mprotect.c:880)
> > [   19.469283] invoke_syscall (arch/arm64/include/asm/current.h:19
> > arch/arm64/kernel/syscall.c:57)
> > [   19.473041] el0_svc_common (arch/arm64/include/asm/daifflags.h:28
> > arch/arm64/kernel/syscall.c:150)
> > [   19.476796] do_el0_svc (arch/arm64/kernel/syscall.c:194)
> > [   19.480117] el0_svc (arch/arm64/include/asm/daifflags.h:28
> > arch/arm64/kernel/entry-common.c:133
> > arch/arm64/kernel/entry-common.c:142
> > arch/arm64/kernel/entry-common.c:638)
> > [   19.483177] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:6=
56)
> > [   19.487454] el0t_64_sync (arch/arm64/kernel/entry.S:591)
> > [ 19.491123] Code: eb18001f 54000800 52800002 b40004d7 (f94052e1)
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0:* 1f                    (bad)  <-- trapping instruction
> >    1: 00 18                add    %bl,(%rax)
> >    3: eb 00                jmp    0x5
> >    5: 08 00                or     %al,(%rax)
> >    7: 54                    push   %rsp
> >    8: 02 00                add    (%rax),%al
> >    a: 80 52 d7 04          adcb   $0x4,-0x29(%rdx)
> >    e: 00                    .byte 0x0
> >    f: b4 e1                mov    $0xe1,%ah
> >   11: 52                    push   %rdx
> >   12: 40 f9                rex stc
> >=20
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0: e1 52                loope  0x54
> >    2: 40 f9                rex stc
>=20
> Looks like an x86 decodecode of arm64 code :) calling a wrong objdump or
> something?
>=20
> > [   19.497226] ---[ end trace 0000000000000000 ]---
> > [   19.501883] Kernel panic - not syncing: Attempted to kill init!
> > exitcode=3D0x0000000b
> > [   19.509551] SMP: stopping secondary CPUs
> > [   19.513665] Kernel Offset: disabled
> > [   19.517152] CPU features: 0x400002,0c3c0400,0000421b
> > [   19.522123] Memory Limit: none
> > [   19.525181] ---[ end Kernel panic - not syncing: Attempted to kill
> > init! exitcode=3D0x0000000b ]---
> >=20
> >=20
> > metadata:
> >   git_ref: master
> >   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
> >   git_sha: 7c4a254d78f89546d0e74a40617ef24c6151c8d1
> >   git_describe: next-20230323
> >   kernel_version: 6.3.0-rc3
> >   kernel-config:
> > https://storage.tuxsuite.com/public/linaro/lkft/builds/2NOjwfRUa0fjWWZB=
WCUG4Ypift7/config
> >   build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/p=
ipelines/815177945
> >   artifact-location:
> > https://storage.tuxsuite.com/public/linaro/lkft/builds/2NOjwfRUa0fjWWZB=
WCUG4Ypift7
> >   toolchain: gcc-11
> >=20
> >=20
> > --
> > Linaro LKFT
> > https://lkft.linaro.org
> >=20
>=20
>=20

--ngahxEO0Y0ADLOJ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZBwKGwAKCRB4tDGHoIJi
0jlYAP9Sh4sQGK6DIyqK8VBDNdhY6p7oUNdxAD4cD5tnxb3evgEAtIh4A5VUhHX6
gqOBSUFhpjlbSK0D0BYqQMQuxWloqgk=
=aOdS
-----END PGP SIGNATURE-----

--ngahxEO0Y0ADLOJ0--
