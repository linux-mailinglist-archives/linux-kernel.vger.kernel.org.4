Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD6B6802D5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 00:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjA2XLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 18:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbjA2XLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 18:11:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A01B18B20;
        Sun, 29 Jan 2023 15:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MJzgPWsHtZ4MIJfYRUmeJ5lXOh2fWwSP5NQ3iYV5t0E=; b=wOyrw/GlBVKvhMZc65XnR8/tha
        3X6umCwLj2m37DWnX9MplK6kTJsCiBkWggIO3qoapxG40ZDFLBp0DdLmwq4eoMzNsLMYeLTbmrbmb
        8a7gf1gR7hdg3MeEZ6pjKp2+uOmjiQAzQIndsQm1fyZkWYzCCxE7zCKwMGKyBW46X7gBcwV0kZRZG
        BmNWvBQpJtcic4EVS+56qPDKaLs7smB4/2uGWsMn4Qt+NbLRRYCVNbOU8ff/GE5Qy303/98rSkZrV
        fTXmlNIQPVZ8p/50aumMHDRdQLK99rptR0PimgiIVy2HKa2+mEUPsbcYgyqbZy08Xyk40NF5nf+oR
        H6xNTnOg==;
Received: from [2601:1c2:d00:6a60::9526] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMGpB-0020M2-NV; Sun, 29 Jan 2023 23:11:02 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 7/9] Documentation: scsi: correct spelling
Date:   Sun, 29 Jan 2023 15:10:51 -0800
Message-Id: <20230129231053.20863-8-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230129231053.20863-1-rdunlap@infradead.org>
References: <20230129231053.20863-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling problems for Documentation/scsi/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
---
 Documentation/scsi/ncr53c8xx.rst   |    4 ++--
 Documentation/scsi/sym53c8xx_2.rst |    2 +-
 Documentation/scsi/tcm_qla2xxx.rst |    2 +-
 Documentation/scsi/ufs.rst         |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff -- a/Documentation/scsi/ncr53c8xx.rst b/Documentation/scsi/ncr53c8xx.rst
--- a/Documentation/scsi/ncr53c8xx.rst
+++ b/Documentation/scsi/ncr53c8xx.rst
@@ -906,7 +906,7 @@ burst:#x   burst enabled (1<<#x burst tr
         led:0      disable LED support
         =====      ===================
 
-  Donnot enable LED support if your scsi board does not use SDMS BIOS.
+  Do not enable LED support if your scsi board does not use SDMS BIOS.
   (See 'Configuration parameters')
 
 10.2.13 Max wide
@@ -1222,7 +1222,7 @@ Unfortunately, the following common SCSI
 - Bad quality terminators.
 
 On the other hand, either bad cabling, broken devices, not conformant
-devices, ... may cause a SCSI signal to be wrong when te driver reads it.
+devices, ... may cause a SCSI signal to be wrong when the driver reads it.
 
 10.7 IMMEDIATE ARBITRATION boot option
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
diff -- a/Documentation/scsi/sym53c8xx_2.rst b/Documentation/scsi/sym53c8xx_2.rst
--- a/Documentation/scsi/sym53c8xx_2.rst
+++ b/Documentation/scsi/sym53c8xx_2.rst
@@ -703,7 +703,7 @@ Unfortunately, the following common SCSI
 - Bad quality terminators.
 
 On the other hand, either bad cabling, broken devices, not conformant
-devices, ... may cause a SCSI signal to be wrong when te driver reads it.
+devices, ... may cause a SCSI signal to be wrong when the driver reads it.
 
 15. SCSI problem troubleshooting
 ================================
diff -- a/Documentation/scsi/tcm_qla2xxx.rst b/Documentation/scsi/tcm_qla2xxx.rst
--- a/Documentation/scsi/tcm_qla2xxx.rst
+++ b/Documentation/scsi/tcm_qla2xxx.rst
@@ -6,7 +6,7 @@ tcm_qla2xxx Driver Notes
 
 tcm_qla2xxx jam_host attribute
 ------------------------------
-There is now a new module endpoint atribute called jam_host
+There is now a new module endpoint attribute called jam_host
 attribute::
 
 	jam_host: boolean=0/1
diff -- a/Documentation/scsi/ufs.rst b/Documentation/scsi/ufs.rst
--- a/Documentation/scsi/ufs.rst
+++ b/Documentation/scsi/ufs.rst
@@ -206,5 +206,5 @@ Device-Specific Data property named "ref
 is interpreted as frequency in Hz and must match one of the values given in
 the UFS specification. UFS subsystem will attempt to read the value when
 executing common controller initialization. If the value is available, UFS
-subsytem will ensure the bRefClkFreq attribute of the UFS storage device is
+subsystem will ensure the bRefClkFreq attribute of the UFS storage device is
 set accordingly and will modify it if there is a mismatch.
