Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C772708A85
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 23:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjERV17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 17:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjERV1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 17:27:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D104E45;
        Thu, 18 May 2023 14:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OWDpELemsND2h0o7cM9zQ1tXCQDiK45JkyNrhKbgfiU=; b=yXJilKCzhP+qKEKUWYQgi5COU/
        REFspkBMHZlTs52T7eNJR2cTv5n0ReiO94PuPWa592qd76xHat5H60NEgV3QEPPE4dUEZJXKWdFSW
        /ZgFdUPLizqNpo6NZow1IlG7ULRd3LrB0yLbkpSXfQ7c22VE7NUVf9lyvTHL+5DwaWSm5otoyaPO3
        H1v/YXcXWEnnIAd6mQNcwM9SLIAbVbrb90tJEqOEAK6bSvxf8maYzJaF+QT51B2Mm0SIKUsEa/EuL
        IdgeWgHegFuar6dQ+HqFG22JHvSVzKAQJE5+RiPIZBuidgngudDPtpKl+GTlV4fl2yyEMOfnDMSmJ
        xvRaPu+w==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzlAA-00EFRV-09;
        Thu, 18 May 2023 21:27:54 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 02/11] Docs/scsi: introduction: multiple cleanups
Date:   Thu, 18 May 2023 14:27:40 -0700
Message-Id: <20230518212749.18266-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518212749.18266-1-rdunlap@infradead.org>
References: <20230518212749.18266-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify URLs to use https instead of http.
Remove ancient URLs that don't work.
Change "scsi" in text to "SCSI".
Change "cdrom" in text to "CD-ROM".
Drop the reference to "autoclean" for modules since I can't
  find it in any current documentation.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/scsi/scsi.rst |   23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff -- a/Documentation/scsi/scsi.rst b/Documentation/scsi/scsi.rst
--- a/Documentation/scsi/scsi.rst
+++ b/Documentation/scsi/scsi.rst
@@ -6,30 +6,28 @@ SCSI subsystem documentation
 
 The Linux Documentation Project (LDP) maintains a document describing
 the SCSI subsystem in the Linux kernel (lk) 2.4 series. See:
-http://www.tldp.org/HOWTO/SCSI-2.4-HOWTO . The LDP has single
+https://www.tldp.org/HOWTO/SCSI-2.4-HOWTO . The LDP has single
 and multiple page HTML renderings as well as postscript and pdf.
-It can also be found at:
-http://web.archive.org/web/%2E/http://www.torque.net/scsi/SCSI-2.4-HOWTO
 
 Notes on using modules in the SCSI subsystem
 ============================================
-The scsi support in the linux kernel can be modularized in a number of
+The SCSI support in the Linux kernel can be modularized in a number of
 different ways depending upon the needs of the end user.  To understand
 your options, we should first define a few terms.
 
-The scsi-core (also known as the "mid level") contains the core of scsi
-support.  Without it you can do nothing with any of the other scsi drivers.
-The scsi core support can be a module (scsi_mod.o), or it can be built into
-the kernel. If the core is a module, it must be the first scsi module
+The scsi-core (also known as the "mid level") contains the core of SCSI
+support.  Without it you can do nothing with any of the other SCSI drivers.
+The SCSI core support can be a module (scsi_mod.o), or it can be built into
+the kernel. If the core is a module, it must be the first SCSI module
 loaded, and if you unload the modules, it will have to be the last one
-unloaded.  In practice the modprobe and rmmod commands (and "autoclean")
+unloaded.  In practice the modprobe and rmmod commands
 will enforce the correct ordering of loading and unloading modules in
 the SCSI subsystem.
 
 The individual upper and lower level drivers can be loaded in any order
-once the scsi core is present in the kernel (either compiled in or loaded
-as a module).  The disk driver (sd_mod.o), cdrom driver (sr_mod.o),
-tape driver [1]_ (st.o) and scsi generics driver (sg.o) represent the upper
+once the SCSI core is present in the kernel (either compiled in or loaded
+as a module).  The disk driver (sd_mod.o), CD-ROM driver (sr_mod.o),
+tape driver [1]_ (st.o) and SCSI generics driver (sg.o) represent the upper
 level drivers to support the various assorted devices which can be
 controlled.  You can for example load the tape driver to use the tape drive,
 and then unload it once you have no further need for the driver (and release
@@ -44,4 +42,3 @@ built into the kernel.
 
 .. [1] There is a variant of the st driver for controlling OnStream tape
        devices. Its module name is osst.o .
-
