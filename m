Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06456155E6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiKAXIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiKAXH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:07:57 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF45CDFA0;
        Tue,  1 Nov 2022 16:06:05 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 232CB511E;
        Wed,  2 Nov 2022 00:06:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1667343965;
        bh=oRx/tqbhEodcmennLfawsLB/b4V24e6OIzyts+HKR3U=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=hNnV2gpV5tHEDRRHoILgNh5IH420ewDM7/rhtqacniaYzRXfKf+20hKobmRsOCTAT
         VeCCPMIbW197OCnxWlu3ODYlg0g3PqiP0V0Hb8f2YQg7PGxhBXfCdhHOzupd05TeZp
         7fCMzBlsSN/L8gsDoNukSUje6tbudSpau8JxTtAdyHey8c8YVjn2fYeoVQuJcxcFGB
         KX99Up1ue7GGurneWtMCshmrOwF2W5Igb6tTXt3x2qoiMniE35t1TYbwM4GKxb+SUU
         L4N1s177lXYZuMs74UWXmBqPWrFEZ4fUzDGzU7jdqG34tAtRjhuEQUjfWEuPecBEDA
         b4IxtCR79F6t8SZ80gDxpG6yDyxQl4N2KxL58yyFvJuG5zE/EvcjuU/+yHpmT7BIvZ
         mTpiNfRsBTjx2m53taEt64Sy02FZHWc2yrlK79eWSg5ZGfwfp2+lmqOp15KocXFcm8
         Cob/qjXoRHHN/QHr9C/xPLM/PYe/Y2r7fSMXjUplJ6MScx31YZ7TEnavDvbiL87RUW
         S59mG/dXrFs5k2MpQtrBzZN1yqoBSz2YeerVhvulilEyOjb5knUThhRJtqsEv02dYm
         /L1wTlNJjdMGZ0BpGnaToAKF2aRen4sJeJLOVG9iO38tU70Or3DbQ3581SGshCsB4r
         t1DTSywO61Y1WTjqadmS023A=
Date:   Wed, 2 Nov 2022 00:06:04 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
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
Subject: [PATCH v2 14/15] scsi: ncr53c8xx: replace CCB_MAGIC with bool busy
Message-ID: <27cefe163e602f7d5b35ba2e966dccf9109798f9.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="udy4zt2nuoupmuc3"
Content-Disposition: inline
In-Reply-To: <cover.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        MISSING_HEADERS,PDS_OTHER_BAD_TLD,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--udy4zt2nuoupmuc3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The only non-boolean check might as well be, since it just early-exits
instead of noting the bug: lower it to a boolean and make it less
confusing.

As for magic numbers, we have largely moved away from this approach,
and we have better debugging instrumentation nowadays: kill it.

Link: https://lore.kernel.org/linux-doc/YyMlovoskUcHLEb7@kroah.com/
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

--udy4zt2nuoupmuc3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmNhplsACgkQvP0LAY0m
WPGldA//VKWs4jaWbnQHQ3NRIfoe8Eh1j0VwBnJxDDTEU5zr5xxu7J3QV5v5C97m
Eq3p3GaVxLmg3nQR+heWEv28X6FOdMeYk6+EYGcgNebyqIwHSFI67KSV0m87l3ft
XqoAPhU2UkP0XVtBgs+7fNnfo7ELFGNl9HW9CHEn6tCCD26ywVJZIKGUcD8rzqAT
bJV0XCzifDfsSuTyAa99JGFdMR44SjkfEaBLlOu9vCBzNHtetvWj6Ndr0Jbq9Evg
X2MK82wXmx+ORyA30YNlQnbLsmol9vjdYnNy74UurJh+sB3lP79IVhv6Uohx5tNI
PYs0MwInU3RdXNgj8+UrvJtvoU/N8MyyTjpOXP7J3mnKOYUxc4BvALTzotmICqOS
6TKJKD0gmcQZwi2FNQ1xvwbeOzUgckXzoNRJfTQQR504tLZmavndq/Npp3gs96Nr
xqTETLgQcR6n5SCQsgsupEm4QXxAb135a5oqb6pWFjpQDVyjX77RCDZy6D1xVIkm
+ovFOCJM3+xk2stsNMmMiTYshMUbYx8hmcEuaRe5cyw/m1W+WL31Da29bkbgigBx
gF6o85eWODHlM+sU9Dyhig4Iqh+HQ9YmENzJj+rZh3IU54O/P/m5q9FwiPe6pstt
roqgQsPGLjlTXA7ET14PWC0pq1HyWPbtsrlRT7S//dMoU4KNqts=
=T1f3
-----END PGP SIGNATURE-----

--udy4zt2nuoupmuc3--
