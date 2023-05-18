Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFDA708A81
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 23:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjERV2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 17:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjERV16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 17:27:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E0CE45;
        Thu, 18 May 2023 14:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nzqkKpMsvhFjKSzI82XRub2vq2oD7qyqUA1vZEh5v/Q=; b=3CK0Ku945/IfB+oNAb3qMZ8isi
        2Pnk7zG+CL2zMgInGOW4GvGOcT3q4hJ4ZGpTlrOLib/sUhgr1skHtLrZDDeNafZITtVURsEcieEVa
        L4RQDxrC5+qA2BdqDFiCUpBaekqHRT3FnqNwS44Ja5PvCKgm4h7NwBDBKoA4i6O2pLKr5qvYlmtoQ
        scz9Y1YA3MyA9ZEzrDpxjFELoGicgYwuotjfxM6+r4NqS3pAsZKv7ptRmlrCPDCaBHJhmTExo6UX1
        kcuDt3f+FFIrewXpEmJnxVY80FwYQW0fbm5HQhdPC9InDt8Lhb8uOgLgEzEv2ZnmJ2vuLUkWz0i4h
        Whw8NcDg==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzlAC-00EFRV-0H;
        Thu, 18 May 2023 21:27:56 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Doug Gilbert <dgilbert@interlog.com>
Subject: [PATCH 07/11] Docs/scsi: scsi-generic: multiple cleanups
Date:   Thu, 18 May 2023 14:27:45 -0700
Message-Id: <20230518212749.18266-8-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518212749.18266-1-rdunlap@infradead.org>
References: <20230518212749.18266-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_SBL_A autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the heading be concise yet still descriptive.
This makes the subsystem table of contents more readable (IMO).

Spell "CDROM" as "CD-ROM".
Capitalize "Linux".

Use https instead of http for URLs.

Drop the Linux Documenation Project URL for the SCSI generic HOWTO
since it hasn't been updated since 2002. Use Doug Gilbert's URL
for it instead.

Drop some outdated documentation & references.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Doug Gilbert <dgilbert@interlog.com>
---
Doug, if you have any specific changes that you would like to see
in this file, please let me know.

 Documentation/scsi/scsi-generic.rst |   53 ++++++++++----------------
 1 file changed, 21 insertions(+), 32 deletions(-)

diff -- a/Documentation/scsi/scsi-generic.rst b/Documentation/scsi/scsi-generic.rst
--- a/Documentation/scsi/scsi-generic.rst
+++ b/Documentation/scsi/scsi-generic.rst
@@ -1,15 +1,15 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-=======================================
-Notes on Linux SCSI Generic (sg) driver
-=======================================
+========================
+SCSI Generic (sg) driver
+========================
 
                                                         20020126
 
 Introduction
 ============
 The SCSI Generic driver (sg) is one of the four "high level" SCSI device
-drivers along with sd, st and sr (disk, tape and CDROM respectively). Sg
+drivers along with sd, st and sr (disk, tape and CD-ROM respectively). Sg
 is more generalized (but lower level) than its siblings and tends to be
 used on SCSI devices that don't fit into the already serviced categories.
 Thus sg is used for scanners, CD writers and reading audio CDs digitally
@@ -22,7 +22,7 @@ and examples.
 
 Major versions of the sg driver
 ===============================
-There are three major versions of sg found in the linux kernel (lk):
+There are three major versions of sg found in the Linux kernel (lk):
       - sg version 1 (original) from 1992 to early 1999 (lk 2.2.5) .
 	It is based in the sg_header interface structure.
       - sg version 2 from lk 2.2.6 in the 2.2 series. It is based on
@@ -33,34 +33,24 @@ There are three major versions of sg fou
 
 Sg driver documentation
 =======================
-The most recent documentation of the sg driver is kept at the Linux
-Documentation Project's (LDP) site:
+The most recent documentation of the sg driver is kept at
 
-- http://www.tldp.org/HOWTO/SCSI-Generic-HOWTO
+- https://sg.danny.cz/sg/
 
 This describes the sg version 3 driver found in the lk 2.4 series.
 
-The LDP renders documents in single and multiple page HTML, postscript
-and pdf. This document can also be found at:
+Documentation (large version) for the version 2 sg driver found in the
+lk 2.2 series can be found at
 
-- http://sg.danny.cz/sg/p/sg_v3_ho.html
-
-Documentation for the version 2 sg driver found in the lk 2.2 series can
-be found at http://sg.danny.cz/sg/. A larger version
-is at: http://sg.danny.cz/sg/p/scsi-generic_long.txt.
+- https://sg.danny.cz/sg/p/scsi-generic_long.txt.
 
 The original documentation for the sg driver (prior to lk 2.2.6) can be
-found at http://www.torque.net/sg/p/original/SCSI-Programming-HOWTO.txt
-and in the LDP archives.
+found in the LDP archives at
 
-A changelog with brief notes can be found in the
-/usr/src/linux/include/scsi/sg.h file. Note that the glibc maintainers copy
-and edit this file (removing its changelog for example) before placing it
-in /usr/include/scsi/sg.h . Driver debugging information and other notes
-can be found at the top of the /usr/src/linux/drivers/scsi/sg.c file.
+- https://tldp.org/HOWTO/archived/SCSI-Programming-HOWTO/index.html
 
 A more general description of the Linux SCSI subsystem of which sg is a
-part can be found at http://www.tldp.org/HOWTO/SCSI-2.4-HOWTO .
+part can be found at https://www.tldp.org/HOWTO/SCSI-2.4-HOWTO .
 
 
 Example code and utilities
@@ -73,8 +63,8 @@ There are two packages of sg utilities:
                 and earlier
     =========   ==========================================================
 
-Both packages will work in the lk 2.4 series however sg3_utils offers more
-capabilities. They can be found at: http://sg.danny.cz/sg/sg3_utils.html and
+Both packages will work in the lk 2.4 series. However, sg3_utils offers more
+capabilities. They can be found at: https://sg.danny.cz/sg/sg3_utils.html and
 freecode.com
 
 Another approach is to look at the applications that use the sg driver.
@@ -83,7 +73,7 @@ These include cdrecord, cdparanoia, SANE
 
 Mapping of Linux kernel versions to sg driver versions
 ======================================================
-Here is a list of linux kernels in the 2.4 series that had new version
+Here is a list of Linux kernels in the 2.4 series that had the new version
 of the sg driver:
 
      - lk 2.4.0 : sg version 3.1.17
@@ -92,10 +82,10 @@ of the sg driver:
      - lk 2.4.17 : sg version 3.1.22
 
 .. [#] There were 3 changes to sg version 3.1.20 by third parties in the
-       next six linux kernel versions.
+       next six Linux kernel versions.
 
-For reference here is a list of linux kernels in the 2.2 series that had
-new version of the sg driver:
+For reference here is a list of Linux kernels in the 2.2 series that had
+the new version of the sg driver:
 
      - lk 2.2.0 : original sg version [with no version number]
      - lk 2.2.6 : sg version 2.1.31
@@ -106,9 +96,8 @@ new version of the sg driver:
      - lk 2.2.17 : sg version 2.1.39
      - lk 2.2.20 : sg version 2.1.40
 
-The lk 2.5 development series has recently commenced and it currently
-contains sg version 3.5.23 which is functionally equivalent to sg
-version 3.1.22 found in lk 2.4.17.
+The lk 2.5 development series currently contains sg version 3.5.23
+which is functionally equivalent to sg version 3.1.22 found in lk 2.4.17.
 
 
 Douglas Gilbert
