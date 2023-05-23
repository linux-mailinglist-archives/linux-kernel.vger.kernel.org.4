Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200B770DB35
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbjEWLJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236411AbjEWLJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:09:12 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B96F126;
        Tue, 23 May 2023 04:08:58 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230523110856euoutp01a4fc7c6fb70a07aa07838521251660b1~hwS2Dtlbh3064230642euoutp01B;
        Tue, 23 May 2023 11:08:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230523110856euoutp01a4fc7c6fb70a07aa07838521251660b1~hwS2Dtlbh3064230642euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684840136;
        bh=VMQGox2nl/tkWJYkaVgAcYU2v2FO6y5JUE+1QsOB8YA=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=RKKpQmtX3I7OMMc6+ya5JUacg+SxH4iSYx6nysjJWBUHiywwFvg0vdB9tBz+ki2VD
         KvJS/DI9aI6VR/dLo/bDaudcGBWpmQ4Pa582eAbHvDf3Mua3hLyzpiNEmdZsibYyWQ
         HL8V44tsFZ4ztqxjo57iyFyWa62ZQsxYVJAorOeo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230523110856eucas1p19cc7612d1ff16659ef32928aeab429e0~hwS1zjqNz1306113061eucas1p1M;
        Tue, 23 May 2023 11:08:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 71.DD.37758.8CE9C646; Tue, 23
        May 2023 12:08:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230523110856eucas1p21fa527b7743f77be009691396927e1d2~hwS1bRoJC1661116611eucas1p2A;
        Tue, 23 May 2023 11:08:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230523110856eusmtrp2631d4095d8e19e49dc1178b0f76915c6~hwS1aoRad2785727857eusmtrp2I;
        Tue, 23 May 2023 11:08:56 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-32-646c9ec888df
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2C.F3.10549.8CE9C646; Tue, 23
        May 2023 12:08:56 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230523110855eusmtip207c49ac1e034c1f94c7e7a6275b8a1bc~hwS1M_SZL0860908609eusmtip2W;
        Tue, 23 May 2023 11:08:55 +0000 (GMT)
Received: from localhost (106.210.248.82) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 23 May 2023 12:08:55 +0100
Date:   Tue, 23 May 2023 13:08:54 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: bott test warning
Message-ID: <20230523110854.43gfswi34gi3cdnd@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="zgd3dmqvzqcusq52"
Content-Disposition: inline
In-Reply-To: <20230523135739.73068c68@canb.auug.org.au>
X-Originating-IP: [106.210.248.82]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7djPc7on5uWkGGybKGtxedccNouDC9sY
        LW5MeMposXXvVXYHFo/GGzfYPDat6mTz+LxJLoA5issmJTUnsyy1SN8ugSvjccce9oLVIhVr
        NrQxNzB+Euxi5OSQEDCRWPB0IlsXIxeHkMAKRonTZzcyQjhfGCUO3f0PlfnMKDG77QMTTMv3
        hnOMILaQwHJGialLKxCKNt1lgnC2MEpsPXqeDaSKRUBVYvqb9awgNpuAjsT5N3eYuxg5OEQE
        tCUO/BYAqWcWmMMo8eriE1aQuLCAlkTTNhMQk1fAXGJlTz5IJ6+AoMTJmU9YQMLMAhUSp2db
        Q5jSEsv/cYBUcAIVT7z5DepKJYnVXX/YIOxaiVNbboEdJiHwhUPizpy5rBAJF4npdy+yQ9jC
        Eq+Ob4GyZST+75wP1TCZUWL/vw/sEM5qRolljV+hVlhLtFx5AtXhKHF78Q6w4yQE+CRuvAUH
        LzOQOWnbdGaIMK9ER5sQRLWaxOp7b1gmMCrPQvLZLITPZiF8Ngtsjo7Egt2f2DCEtSWWLXzN
        DGHbSqxb955lASP7Kkbx1NLi3PTUYuO81HK94sTc4tK8dL3k/NxNjMCUdPrf8a87GFe8+qh3
        iJGJg/EQowpQ86MNqy8wSrHk5eelKonwnijPThHiTUmsrEotyo8vKs1JLT7EKM3BoiTOq217
        MllIID2xJDU7NbUgtQgmy8TBKdXAlGp8YGVIyJTv5WovZdPrns63+t0zdfU997r7ppKbspf9
        iWKKOjJ3m5HPP6B71s3/mfrlwItUxg9f5hWd5N8wQVAlSOf3afWXMiL/Dz85NsPaU5ll4+5L
        /jkra7d/nWNtv5JPW3pCwJErRvIfKuqNXj5ZeF1fXCw1/aBXqNL6v4aGOrtrd6RrZ9dc/ljS
        m5n/OKps8+UrLkoZ/v8ufivJPv98++QNMWc4S+9Nc55eqr1v7nTPV0mz5rnPLyi3UN6jZ7v+
        3rLnel8LC3XvP63MOBanYp539euXHK8v/R5dgoVZi+Z5f39a7WjQeT/2v5yHZ8bh6UmXTz6+
        osotYK/fUuD45WzqvYhbYm9Sm2zuK7EUZyQaajEXFScCACNoAZrEAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xe7on5uWkGDR3s1lc3jWHzeLgwjZG
        ixsTnjJabN17ld2BxaPxxg02j02rOtk8Pm+SC2CO0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAz
        MrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MuYunofe8FKkYqjF6saGD8IdjFyckgImEh8bzjH
        2MXIxSEksJRR4tvL7ywQCRmJjV+uskLYwhJ/rnWxQRR9ZJRYfGc6lLOFUWLX1nYmkCoWAVWJ
        6W/Wg3WwCehInH9zh7mLkYNDREBb4sBvAZB6ZoE5jBKvLj5hBYkLC2hJNG0zATF5BcwlVvbk
        Q4zsYpRYfXMRI8gYXgFBiZMzn4AdxCxQJnH17mMmkHpmAWmJ5f84QMKcQK0Tb35jgrhTSWJ1
        1x82CLtW4vPfZ4wTGIVnIZk0C8mkWQiTIMJaEjf+vcQU1pZYtvA1M4RtK7Fu3XuWBYzsqxhF
        UkuLc9Nziw31ihNzi0vz0vWS83M3MQJjc9uxn5t3MM579VHvECMTB+MhRhWgzkcbVl9glGLJ
        y89LVRLhPVGenSLEm5JYWZValB9fVJqTWnyI0RQYhhOZpUST84FJI68k3tDMwNTQxMzSwNTS
        zFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgSnCl7FnkXjj9Jayn8fyiqqTjff/cl3ht+lu
        7+z1xy2f6Bx/PG0ZH0cnN8Mac3HtCaw/vL/0PtrC6b9tovi2BXV3pu2rnXXvNq/o4sYZbaWm
        /hILeyt3PDu6sMaj8RefZNfU+lc3zuhE689Y/XXpQoc+9kvvNV1Wi8zu1HfKOn0z8WagbH3d
        086QAMMuiTcfd8YvUTl3/NWkOV4PHdYu53t4qkD8UvJz0QcvX9pfevn490SFSd/XS83eHSOZ
        HF2a7P9c/KnZo1lJZXbPL6ffvaxduee2pvrCuhOFbF9s7douL1B49dVKqstx14kNKU9Lpznf
        vXSYLYthk+um4weMmJXnHFa5abNn74wtSuniTgv+KbEUZyQaajEXFScCACkwcIxiAwAA
X-CMS-MailID: 20230523110856eucas1p21fa527b7743f77be009691396927e1d2
X-Msg-Generator: CA
X-RootMTR: 20230523035747eucas1p2f10754f5eb6759d6665a35562c523841
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230523035747eucas1p2f10754f5eb6759d6665a35562c523841
References: <CGME20230523035747eucas1p2f10754f5eb6759d6665a35562c523841@eucas1p2.samsung.com>
        <20230523135739.73068c68@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--zgd3dmqvzqcusq52
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2023 at 01:57:39PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next boot test (powerpc pseries_le_defconfig) produced
> this warning:
>=20
> sysctl table check failed: kernel/usermodehelper Not a file
> sysctl table check failed: kernel/usermodehelper No proc_handler
> sysctl table check failed: kernel/usermodehelper bogus .mode 0555
This is because I missed to handle the child in usermodehelper=20

> sysctl table check failed: kernel/keys Not a file
> sysctl table check failed: kernel/keys No proc_handler
> sysctl table check failed: kernel/keys bogus .mode 0555
Also because of the child being there.

> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.4.0-rc3-04222-g1999c5d1802e #1
> Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf00=
0004 of:SLOF,HEAD pSeries
> Call Trace:
> [c0000000028bfd40] [c00000000113ea2c] dump_stack_lvl+0x70/0xa0 (unreliabl=
e)
> [c0000000028bfd70] [c0000000006166f0] __register_sysctl_table+0x7f0/0x9e0
> [c0000000028bfe50] [c00000000204e650] __register_sysctl_init+0x40/0x78
> [c0000000028bfec0] [c00000000202d660] sysctl_init_bases+0x40/0xb4
> [c0000000028bfef0] [c00000000204e6dc] proc_sys_init+0x54/0x68
> [c0000000028bff10] [c00000000204dff4] proc_root_init+0xb8/0xdc
> [c0000000028bff30] [c0000000020045d8] start_kernel+0x7f8/0x834
> [c0000000028bffe0] [c00000000000e998] start_here_common+0x1c/0x20
> failed when register_sysctl kern_table to kernel
>=20
> I am not sure exactly which commit caused this.
>=20
> --=20
> Cheers,
> Stephen Rothwell

Let me respin go a next version of this patch.

Thx for the test

--=20

Joel Granados

--zgd3dmqvzqcusq52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmRsnsUACgkQupfNUreW
QU849wwAg/y1xcfhQotnksbe2qpbmxtnzeY7CwWtrM9qCDWAgbkTcXXcl3UFGiNc
Dzlt3yhLLRv/zi1nKd8xp/INw7/rnQbV/bGD1zC7VIUnW5PwM+VXOt2JmzMAQcBF
JMYiG9LO+8yg5g2IbIft3mXVQPe96OKTTFQkbb3Y17+Y6zhxiIxolOmd8Wok8rVj
1OActGfsPwHNipkMgWHMKhBG74ZERXWuw9k7Pbnb285+9vyZwKir4RMB5Lq04ulV
+Avr5tEfyJDNRHqR0bKQIxYu8E2wtBNio6fOa7s3RHwIewHUP7N3VMO+QdCyidAs
U2j5UiIaWffUFpQQEKf4dR5ObJ1gEn211O2ZU/mAmCqCoBwS0YLsVL4o2YkbTiQ+
MfDWvN+UkP4ODPKf1SYeV7pG3LoNAsAEy2FziZZQRkZI2a3s7BEosq63c5vffOzc
yCbGLsYLPqHB2CjVF4y+AX3dGtAA+BRts0yw2sYux74zMrj4OznOV1YBuJ63GEVI
ay+kYVDW
=Mzsf
-----END PGP SIGNATURE-----

--zgd3dmqvzqcusq52--
