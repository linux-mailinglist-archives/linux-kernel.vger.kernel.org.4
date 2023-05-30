Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25716717092
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 00:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbjE3WRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 18:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjE3WRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 18:17:38 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8540E93;
        Tue, 30 May 2023 15:17:34 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 3BA15E0DE7;
        Wed, 31 May 2023 01:17:32 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:message-id
        :mime-version:reply-to:subject:subject:to:to; s=post; bh=G1jtgpu
        uA/MblAOe6VlMN6ViduCS+VMfEUc9VRJz1hw=; b=YXYPSbhboYAT58RMcm/Pcme
        IUMjpBn2nhlOJM1mo1P9DpQvLbRqCnv4+513yp8YZKfMDKAh/DlUVUOs8tmGpwaq
        XSRt4LGCzbR0l+CZc1D3HMBiMPDD6UsKTrDDBUi59//I4T7GeoQ1QGMQ4W9lrZhw
        ZmJKuYzjkVfISl2PcSOI=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 151B5E0DE6;
        Wed, 31 May 2023 01:17:32 +0300 (MSK)
Received: from localhost (10.8.30.14) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Wed, 31 May 2023 01:17:31 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Osama Muhammad <osmtendev@gmail.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] spi: dw: Drop empty line from DebugFS init function
Date:   Wed, 31 May 2023 01:17:25 +0300
Message-ID: <20230530221725.26319-1-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.14]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just drop a redundant empty line from the dw_spi_debugfs_init() function
left in the framework of the commit 0178f1e5d984 ("spi-dw-core.c: Fix
error checking for debugfs_create_dir") after removing the last return
statement.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 071a7604a8ab..a8ba41ad4541 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -68,7 +68,6 @@ static void dw_spi_debugfs_init(struct dw_spi *dws)
 	dws->regset.nregs = ARRAY_SIZE(dw_spi_dbgfs_regs);
 	dws->regset.base = dws->regs;
 	debugfs_create_regset32("registers", 0400, dws->debugfs, &dws->regset);
-
 }
 
 static void dw_spi_debugfs_remove(struct dw_spi *dws)
-- 
2.40.0


