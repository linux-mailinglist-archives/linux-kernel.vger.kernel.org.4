Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E49708A8A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 23:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjERV2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 17:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjERV16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 17:27:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFC1E6E;
        Thu, 18 May 2023 14:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4GbP8ntWjcqloYHUsOyUIC0EO2KKE3UnCyF/mX15l2Q=; b=DDyqIBDMbtXK1kxAx9wVq554jS
        kec90gqUVv7pHD3iunz3lbpAMt0HOB0pBXodnQ4snV0V7jF8nJGjcmqPHjn/ICYDa0Gr9Zqxxefww
        SVKZdF/CuQimGdKrGxAgBbNZ9/p0/VOkzsr6aAlkGGDFRCTSOe9qf8cxa31ifobwfjHYXxp73654d
        VBFjWhgHKdTHRWxXG2Me81UmeMoFjMEkJNTI2DjS4+mOzyWixdW2wTr+7ZdNKyqqhWJyOP3V+0bL4
        q6puiqPFnfk9JB2mCCpJHHTYztbFQFT1bvc3bfCWu/rzrfUd6Y31JAg7JVQVQm97u3yLNzA6kzsXb
        Si9pKuEw==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzlAC-00EFRV-1f;
        Thu, 18 May 2023 21:27:56 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH 08/11] Docs/scsi: g_NCR5380: shorten chapter heading
Date:   Thu, 18 May 2023 14:27:46 -0700
Message-Id: <20230518212749.18266-9-rdunlap@infradead.org>
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

Make the chapter heading be concise yet still descriptive.
This makes the subsystem table of contents more readable (IMO).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Finn Thain <fthain@linux-m68k.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>
---
 Documentation/scsi/g_NCR5380.rst |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -- a/Documentation/scsi/g_NCR5380.rst b/Documentation/scsi/g_NCR5380.rst
--- a/Documentation/scsi/g_NCR5380.rst
+++ b/Documentation/scsi/g_NCR5380.rst
@@ -1,9 +1,9 @@
 .. SPDX-License-Identifier: GPL-2.0
 .. include:: <isonum.txt>
 
-==========================================
-README file for the Linux g_NCR5380 driver
-==========================================
+================
+g_NCR5380 driver
+================
 
 Copyright |copy| 1993 Drew Eckhard
 
