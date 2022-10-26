Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CEE60EBCA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 00:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbiJZWoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 18:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbiJZWnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 18:43:55 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E35B31382C4;
        Wed, 26 Oct 2022 15:43:43 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 3E72645F4;
        Thu, 27 Oct 2022 00:43:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1666824223;
        bh=cWJrh+4WCcyvm/bC7QDo7SLpdliy33Tc64LT+Dh/mqI=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=kYdJqh4YcpcPbQ6fdbHeflPyOx4/DgP2plZfzVH+WFzCMTkcgQEUxmFjnTDD0nuVA
         RvBWnX1Jefcy6oDHMM15a2rKgf/P5PYAUeXgi/5nUa/wCo++wYy3afds0uu6V9nWLZ
         m7K3PCCJFILjnsnqEFyG2prno/5bYFZocOoAb6muvw+TmdPJaRmA6dF+hJmmvh+rHX
         0ERAV6G+r5qDeBqHrQIcvRRoR/zz+EV+o+1QHSD2S4Tf/Ye1bR7yhdsgbkv61cNi7z
         RaDf3MJA4GfJIq9KgQ4mqg7jYX3+Yi+NpoBx5EywRoFIpG1sg41sVN/FotYZIy0wpt
         LmvfqKtU+0CXHkDDPtKHPxUhQMg9bCK3KG9JtxNQ2peYntO4tKcfC7RE9rboUzCUag
         g6jsJsZfACuNHZMn28Li1jPMc/i3w+MQ2AM9wK5GBRq8GFeeJiQufwE6vBWPkyVdp/
         G1X/O+2oBgu+BSgCismFWHlroKUez5dyYuu8wM67/lOAOy4uf3hWwqRzYEfHqCvjo5
         K/aZvZFj7O7uwylTdATv9AEGwVgozQgfnzi1wAv7KEY31i1CWnCzNsPjiv+xYkQFVw
         I4gHqRm+o97zz7lHl1np9/0tG+wTImqghyetflA1X/tuMB8up4N/cMl+wLF/J3T0RR
         +Qqe8C6cSDEr9JBnvrRc05TE=
Date:   Thu, 27 Oct 2022 00:43:42 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-scsi@vger.kernel.org
Subject: [PATCH 14/15] scsi: ncr53c8xx: replace CCB_MAGIC with bool busy
Message-ID: <182906437bbf7597968cc68e0babe6f7ff772f79.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
References: <9a453437b5c3b4b1887c1bd84455b0cc3d1c40b2.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o6rx3c4yjvpe22rt"
Content-Disposition: inline
In-Reply-To: <9a453437b5c3b4b1887c1bd84455b0cc3d1c40b2.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        MISSING_HEADERS,PDS_OTHER_BAD_TLD,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o6rx3c4yjvpe22rt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The only non-boolean check might as well be,
since it just early-exits instead of of noting the bug:
lower it to a boolean and make it less confusing

As for magic numbers, we have largely moved away from this approach,
and we have better debugging instrumentation nowadays: kill it

Ref: https://lore.kernel.org/linux-doc/YyMlovoskUcHLEb7@kroah.com/
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/process/magic-number.rst        |  1 -
 .../it_IT/process/magic-number.rst            |  1 -
 .../zh_CN/process/magic-number.rst            |  1 -
 .../zh_TW/process/magic-number.rst            |  1 -
 drivers/scsi/ncr53c8xx.c                      | 25 ++++++-------------
 5 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
index 6e432917a5a8..5a8c2755ac9c 100644
--- a/Documentation/process/magic-number.rst
+++ b/Documentation/process/magic-number.rst
@@ -68,5 +68,4 @@ Changelog::
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
 Magic Name            Number           Structure                File
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
index 7d4c117ac626..2fbc1876534a 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -74,5 +74,4 @@ Registro dei cambiamenti::
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
 Nome magico           Numero           Struttura                File
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index c17e3f20440a..f8ec4767bc4e 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -57,5 +57,4 @@ Linux =E9=AD=94=E6=9C=AF=E6=95=B0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
 =E9=AD=94=E6=9C=AF=E6=95=B0=E5=90=8D              =E6=95=B0=E5=AD=97      =
       =E7=BB=93=E6=9E=84                     =E6=96=87=E4=BB=B6
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index e2eeb74e7192..0ccc60bee3d6 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -60,5 +60,4 @@ Linux =E9=AD=94=E8=A1=93=E6=95=B8
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
 =E9=AD=94=E8=A1=93=E6=95=B8=E5=90=8D              =E6=95=B8=E5=AD=97      =
       =E7=B5=90=E6=A7=8B                     =E6=96=87=E4=BB=B6
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
diff --git a/drivers/scsi/ncr53c8xx.c b/drivers/scsi/ncr53c8xx.c
index 4458449c960b..928417fca495 100644
--- a/drivers/scsi/ncr53c8xx.c
+++ b/drivers/scsi/ncr53c8xx.c
@@ -1095,15 +1095,6 @@ typedef u32 tagmap_t;
 #define NS_WIDE		(2)
 #define NS_PPR		(4)
=20
-/*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
-**
-**	Misc.
-**
-**=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
-*/
-
-#define CCB_MAGIC	(0xf2691ad2)
-
 /*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
 **
 **	Declaration of structs.
@@ -1567,7 +1558,7 @@ struct ccb {
 	struct ccb *	link_ccb;	/* Host adapter CCB chain	*/
 	struct list_head link_ccbq;	/* Link to unit CCB queue	*/
 	u32		startp;		/* Initial data pointer		*/
-	u_long		magic;		/* Free / busy  CCB flag	*/
+	bool		busy;
 };
=20
 #define CCB_PHYS(cp,lbl)	(cp->p_ccb + offsetof(struct ccb, lbl))
@@ -4356,7 +4347,7 @@ static int ncr_queue_command (struct ncb *np, struct =
scsi_cmnd *cmd)
 	*/
=20
 	/* activate this job.  */
-	cp->magic		=3D CCB_MAGIC;
+	cp->busy		=3D true;
=20
 	/*
 	**	insert next CCBs into start queue.
@@ -4667,7 +4658,7 @@ void ncr_complete (struct ncb *np, struct ccb *cp)
 	**	Sanity check
 	*/
=20
-	if (!cp || cp->magic !=3D CCB_MAGIC || !cp->cmd)
+	if (!cp || !cp->busy || !cp->cmd)
 		return;
=20
 	/*
@@ -6998,7 +6989,7 @@ static struct ccb *ncr_get_ccb(struct ncb *np, struct=
 scsi_cmnd *cmd)
 		qp =3D ncr_list_pop(&lp->free_ccbq);
 		if (qp) {
 			cp =3D list_entry(qp, struct ccb, link_ccbq);
-			if (cp->magic) {
+			if (cp->busy) {
 				PRINT_ADDR(cmd, "ccb free list corrupted "
 						"(@%p)\n", cp);
 				cp =3D NULL;
@@ -7030,17 +7021,17 @@ static struct ccb *ncr_get_ccb(struct ncb *np, stru=
ct scsi_cmnd *cmd)
 	**	Wait until available.
 	*/
 #if 0
-	while (cp->magic) {
+	while (cp->busy) {
 		if (flags & SCSI_NOSLEEP) break;
 		if (tsleep ((caddr_t)cp, PRIBIO|PCATCH, "ncr", 0))
 			break;
 	}
 #endif
=20
-	if (cp->magic)
+	if (cp->busy)
 		return NULL;
=20
-	cp->magic =3D 1;
+	cp->busy =3D true;
=20
 	/*
 	**	Move to next available tag if tag used.
@@ -7119,7 +7110,7 @@ static void ncr_free_ccb (struct ncb *np, struct ccb =
*cp)
 		}
 	}
 	cp -> host_status =3D HS_IDLE;
-	cp -> magic =3D 0;
+	cp -> busy =3D false;
 	if (cp->queued) {
 		--np->queuedccbs;
 		cp->queued =3D 0;
--=20
2.30.2

--o6rx3c4yjvpe22rt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmNZuB0ACgkQvP0LAY0m
WPHiAg/+L9QC6Bl0XGqH5HbiuvOgee8Jvd2OmYfbcK95JJGqq3EKk6CCOp+ntuWI
W+b9oOqggflc0u4AQZ5Fj6ifX6bCd7m4PraPLH0q1aAqTZTsDhwaYF2ELCv0+7co
IbA9jdVGXtTZAZ07LU9Us2f5yjg3KVlDxQSdUnOmYSEaJHjzFmCNKCh8rPaknyR9
OFBP98C/YK35qAmFkBMUPlNYMXHcbk5jKlL7lfr3W7+QJpNQpyzaFqSgQ0sLBSWW
U+1ccKdXxNRoFQrhn9tKOzdFQsrEUlKOkMtGfHQP3za42/+mMLLruM0DaxXBS5ed
oI84nYgMnVlkGFolMoz8LdRhA2JcmrS2xEdzwKskqLWQMmR6TnAH1T3L+yHNZoy6
fHq7AM42dYrgOJD6qoY9VDkoaHaOPki1aBb92guugR/pzuWuvZBhZ0XtC98r7fUU
+hf6MHKbznywXdKe4MEEFW2XfusUlnHl3URhD4PBJtSpOVIobG2NsgBAgGE7soge
iK9nPnceQ/fAoZAAvrp5qoMoaPJpgwg6sGLZKslmW4mxRKPlyo1ib+B34tyBkBv/
ttbiN/jv/+ToeHPdgmoSrm08imwF/JlgFQiFr3zbxCXYXowDjGWpo+Bjsp1i1/7I
v0T6munKcSPV6e/Qkf7zN4ZKZr1JXEzEoU/Dl1mCizu07x4cY5c=
=XRrY
-----END PGP SIGNATURE-----

--o6rx3c4yjvpe22rt--
