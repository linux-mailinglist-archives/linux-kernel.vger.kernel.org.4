Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29726AF987
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjCGWtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjCGWrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:47:45 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EEF7A0B29;
        Tue,  7 Mar 2023 14:47:08 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 074197A077A;
        Tue,  7 Mar 2023 23:46:51 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 31/32] pata_parport-bpck6: delete ppc6lnx.c
Date:   Tue,  7 Mar 2023 23:46:26 +0100
Message-Id: <20230307224627.28011-32-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230307224627.28011-1-linux@zary.sk>
References: <20230307224627.28011-1-linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove now empty ppc6lnx.c.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck6.c   |  1 -
 drivers/ata/pata_parport/ppc6lnx.c | 17 -----------------
 2 files changed, 18 deletions(-)
 delete mode 100644 drivers/ata/pata_parport/ppc6lnx.c

diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index 0ed6a97ab04f..53d0ad1d6e89 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -17,7 +17,6 @@
 #include <linux/types.h>
 #include <linux/parport.h>
 #include "pata_parport.h"
-#include "ppc6lnx.c"
 
 /* 60772 Commands */
 #define ACCESS_REG		0x00
diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
deleted file mode 100644
index e72b1842adda..000000000000
--- a/drivers/ata/pata_parport/ppc6lnx.c
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
-	ppc6lnx.c (c) 2001 Micro Solutions Inc.
-		Released under the terms of the GNU General Public license
-
-	ppc6lnx.c  is a par of the protocol driver for the Micro Solutions
-		"BACKPACK" parallel port IDE adapter
-		(Works on Series 6 drives)
-
-*/
-
-//***************************************************************************
-
-// PPC 6 Code in C sanitized for LINUX
-// Original x86 ASM by Ron, Converted to C by Clive
-
-//***************************************************************************
-
-- 
Ondrej Zary

