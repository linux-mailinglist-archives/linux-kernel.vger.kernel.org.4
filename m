Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C0070DB61
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbjEWLUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbjEWLUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:20:06 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC49C4;
        Tue, 23 May 2023 04:20:05 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230523112003euoutp025abf13a70dec7b770010410165594f3f~hwcjQ4qah1344413444euoutp02f;
        Tue, 23 May 2023 11:20:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230523112003euoutp025abf13a70dec7b770010410165594f3f~hwcjQ4qah1344413444euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684840803;
        bh=NhlgtIzHsKmsPU5g/FS0uuD7atxyv9UToKcr8QGWkwU=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=PQ2krdBWkevzyxBu1hBlbzjCpRPu4s152bdMSl0dp5MAsWdRiMMQQR628Nio3GMVo
         +4RxiGA3iVcZyo5R1hLNnSXlm0WGFTYZ23xie4Afb6iS60whlJ4DlmXllea4GjXXUT
         tZBksmvY8VAONB4zAfzWOfqD5tNFNZYb8kPx+/FE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230523112003eucas1p1c2faee0b8e4cd13d86724efb9c0b3d87~hwci5EF3g2286222862eucas1p1o;
        Tue, 23 May 2023 11:20:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C5.2A.42423.361AC646; Tue, 23
        May 2023 12:20:03 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230523112002eucas1p29808112c0e3d9c40a34ac3629219d2e9~hwcib9fig1143611436eucas1p2N;
        Tue, 23 May 2023 11:20:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230523112002eusmtrp130a02d92038b4e4925c40c5db9f8f5dc~hwcibIfx_2641026410eusmtrp1m;
        Tue, 23 May 2023 11:20:02 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-d4-646ca163cfe1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 66.B5.10549.261AC646; Tue, 23
        May 2023 12:20:02 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230523112002eusmtip2537422a97c37887457375ead2b9faac4~hwciPnRnU1573615736eusmtip2z;
        Tue, 23 May 2023 11:20:02 +0000 (GMT)
Received: from localhost (106.210.248.82) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 23 May 2023 12:20:02 +0100
Date:   Tue, 23 May 2023 13:20:01 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: bott test warning
Message-ID: <20230523112001.owwx7sa7qofwuzfd@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="gny3tkialmcud3zd"
Content-Disposition: inline
In-Reply-To: <20230523135739.73068c68@canb.auug.org.au>
X-Originating-IP: [106.210.248.82]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7djPc7rJC3NSDGYeFbO4vGsOm8XBhW2M
        FjcmPGW02Lr3KrsDi0fjjRtsHptWdbJ5fN4kF8AcxWWTkpqTWZZapG+XwJUx4+RkpoI2lYo9
        E9czNjBOle9i5OSQEDCROL/5MXsXIxeHkMAKRonNW45DOV8YJXa1nINyPjNKPLh1jBGm5WvT
        cmaIxHJGif8z37HAVS2ZOIURwtnCKDFhxi6gMg4OFgFViaP9+iDdbAI6Euff3AELiwhoSxz4
        LQBSziwwh1Hi1cUnrCBxYQEtiaZtJiDlvALmElu2rGSHsAUlTs58wgJiMwtUSFy/3AlWziwg
        LbH8HwdImBOofOLNb0wQdypJrO76wwZh10qc2nILKj6ZU+LpHHWQVgkBF4nO62YQYWGJV8e3
        sEPYMhKnJ/eAfQVUziix/98HdghnNaPEssavUIOsJVquPIHqcJS4vXgHC8RQPokbbwUhzuST
        mLRtOjNEmFeio00IolpNYvW9NywTGJVnIXlsFpLHZiE8BmFaSWy6HIsiClKsI7Fg9yc2DGFt
        iWULXzND2LoSXccOQM2Olzj29RozphpbiXXr3rMsYORZxSieWlqcm55abJiXWq5XnJhbXJqX
        rpecn7uJEZgIT/87/mkH49xXH/UOMTJxMB5iVAFqfrRh9QVGKZa8/LxUJRHeE+XZKUK8KYmV
        ValF+fFFpTmpxYcYpTlYlMR5tW1PJgsJpCeWpGanphakFsFkmTg4pRqY9F+tFS1mYJ7xSn7y
        hedm317tOn/gebzxr5ktVk9Ei9MnKb2afKH1xv66h+qWCS5c2Wv0F6jvmJlUc1zb8uGjsGJ9
        prmfo5atWHyz9XOIzGrnbCuT689l7b6+930U9Kw8mC/H1ee2ZOyky1MFNmgtZq10OTD3/Q2L
        pe7PPZ7f/Rv3xVuwzPA2e9hyubifYQ1OagL1sftE33Cav49+nlil6lv/cJrUWsabvt+8LzKH
        d7PwSTsICR1fsqqmx6rw4cH//4WzT14W+NiVc/94uXLS0uVCIV9fZUa23fKTTGqLPcXbHLfi
        sQAPn6Thu4vqlZV7jtox/50apD/T1KxmtdK747cvZbUo8mbIWDDd1TmuxFKckWioxVxUnAgA
        rcuXDv8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42I5/e/4Pd2khTkpBl9emlhc3jWHzeLgwjZG
        ixsTnjJabN17ld2BxaPxxg02j02rOtk8Pm+SC2CO0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAz
        MrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Ms4ObmfraBFpaJn+nrmBsaJ8l2MnBwSAiYSX5uW
        M3cxcnEICSxllNjw6hUzREJGYuOXq6wQtrDEn2tdbCC2kMBHRonHlwUgGrYwSqy/+Q6oiIOD
        RUBV4mi/PkgNm4COxPk3d5hBwiIC2hIHfoOVMwvMYZR4dfEJWLmwgJZE0zYTkHJeAXOJLVtW
        skOM7GKUWH1zESNEQlDi5MwnLCA2s0CZxPuvIDdwANnSEsv/cYCEOYF6J978xgRxppLE6q4/
        bBB2rcTnv88YJzAKz0IyaRaSSbMQJkGYVhKbLseiiIIUa0nc+PeSCUNYW2LZwtfMMPbDiVOZ
        IOx4iWNfrzFjqrGVWLfuPcsCRp5VjCKppcW56bnFhnrFibnFpXnpesn5uZsYgelg27Gfm3cw
        znv1Ue8QIxMH4yFGFaDORxtWX2CUYsnLz0tVEuE9UZ6dIsSbklhZlVqUH19UmpNafIjRFBj6
        E5mlRJPzgYkqryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qBaaZF
        +uz4Ofq3k19vDA9Laf95kyV6Ybuqq+zi1c9779+3eGsU/d/f5oxfbcdc9eeL09dvFvUKV564
        78v+qyfizwptLG5maHyx+4jCD6s8UdOYlLb8mptB+5+r+rptd5I+9q1V7+mdoP8it41M+V5K
        LxU+3K+25aGEbnVyhMXLUzdUyz1Xb9hX+E1zM8P+u1cnmV+xWZ5d0FvcLRCk1u266W1AtdBO
        Te/05nPpiRMvJ3atPDK7Im2lS/ZRqXMrNOfnWjO1mv9d9vdSzBOLp9sjKq+X2+dKc1w9xceW
        Fv733puKLvFgti+1j55c5e5In5USE9ma/Nf4+HSJxtSGef+POJwXlpk14WR89TKBTdumKLEU
        ZyQaajEXFScCABaf6FGcAwAA
X-CMS-MailID: 20230523112002eucas1p29808112c0e3d9c40a34ac3629219d2e9
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

--gny3tkialmcud3zd
Content-Type: multipart/mixed; boundary="muu3ipgqvr4kuhhh"
Content-Disposition: inline

--muu3ipgqvr4kuhhh
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
> sysctl table check failed: kernel/keys Not a file
> sysctl table check failed: kernel/keys No proc_handler
> sysctl table check failed: kernel/keys bogus .mode 0555
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
Does the attached patch solve the issue?


--=20

Joel Granados

--muu3ipgqvr4kuhhh
Content-Type: text/x-diff; charset="us-ascii"
Content-Disposition: attachment;
	filename="0001-sysctl-add-missing-kernel-subdir-nodes.patch"
Content-Transfer-Encoding: quoted-printable

=46rom c5e439534a8b493679e517616c631af277fcad26 Mon Sep 17 00:00:00 2001
=46rom: Joel Granados <j.granados@samsung.com>
Date: Tue, 23 May 2023 13:15:02 +0200
Subject: [PATCH] sysctl: add missing kernel subdir nodes

The "kernel/usermodehelper" and "kernel/keys" paths are directories with
sysctl tables of their own; add them to the sysctl_init call.

Signed-off-by: Joel Granados <j.granados@samsung.com>
Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 kernel/sysctl.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index fa2aa8bd32b6..73fa9cf7ee11 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1782,11 +1782,6 @@ static struct ctl_table kern_table[] =3D {
 		.mode		=3D 0644,
 		.proc_handler	=3D sysctl_max_threads,
 	},
-	{
-		.procname	=3D "usermodehelper",
-		.mode		=3D 0555,
-		.child		=3D usermodehelper_table,
-	},
 	{
 		.procname	=3D "overflowuid",
 		.data		=3D &overflowuid,
@@ -1962,13 +1957,6 @@ static struct ctl_table kern_table[] =3D {
 		.proc_handler	=3D proc_dointvec,
 	},
 #endif
-#ifdef CONFIG_KEYS
-	{
-		.procname	=3D "keys",
-		.mode		=3D 0555,
-		.child		=3D key_sysctls,
-	},
-#endif
 #ifdef CONFIG_PERF_EVENTS
 	/*
 	 * User-space scripts rely on the existence of this file
@@ -2351,6 +2339,11 @@ static struct ctl_table dev_table[] =3D {
 int __init sysctl_init_bases(void)
 {
 	register_sysctl_init("kernel", kern_table);
+	register_sysctl_init("kernel/usermodehelper", usermodehelper_table);
+#ifdef CONFIG_KEYS
+	register_sysctl_init("kernel/keys", key_sysctls);
+#endif
+
 	register_sysctl_init("vm", vm_table);
 	register_sysctl_init("debug", debug_table);
 	register_sysctl_init("dev", dev_table);
--=20
2.30.2


--muu3ipgqvr4kuhhh--

--gny3tkialmcud3zd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmRsoV8ACgkQupfNUreW
QU85sAwAiVjesR5QUJPZHJBnuQClElS6Khc7WMJh9O45XekTkdF8HgQLdQ6WzHJ0
WvPYP8hMHbDwbDr3wtMrLCkUv9unRg8UDZUfFBTlqIDlAGP0OnlixJ+463WmQ6S2
bP2zG9PP2abcQaNhbBKwOlJjRb2+uM1zcUdHcvfpCT330GfxkWJ5TL5YAr2jM2zN
pIhQuBMbdr/OpurbbG82DouKuBa7KObb+Cl0PZST84XpkmeJOdilLrxr0+R3L5af
WlCDQwWf4/gyQ/m0kwcx3dxZy5nYgXs2ixC+O55U8nnKOxJquon2Ntrb5OK7ln6l
uaiBhEOpKBhLdAufrSCjYtQCk1fUGjHmsLuzn1pzCoX5f3Lqh/rICKtcrhUUZNxO
NveCVkkxxTBmSxpPgnTs1d0JeRDyKAeGbgFTV+xJ2E5HGKT+5kTm5qaeaxg6sCMW
VK6KHiiWRUZKppC1RZ9WrGtIckA/ARpq9B/RgRA8iRvc+kKsXiNezE+GcGZm9VSm
k7W4Dvao
=PZoi
-----END PGP SIGNATURE-----

--gny3tkialmcud3zd--
