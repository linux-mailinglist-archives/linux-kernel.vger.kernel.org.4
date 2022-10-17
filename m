Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04EC600A71
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiJQJWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiJQJWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:22:18 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC96F20BFD;
        Mon, 17 Oct 2022 02:22:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VSLPPPc_1665998521;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VSLPPPc_1665998521)
          by smtp.aliyun-inc.com;
          Mon, 17 Oct 2022 17:22:09 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     conor.dooley@microchip.com
Cc:     daire.mcnamara@microchip.com, broonie@kernel.org,
        linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] spi: microchip-core: Remove the unused function mchp_corespi_enable()
Date:   Mon, 17 Oct 2022 17:21:41 +0800
Message-Id: <20221017092141.9789-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function mchp_corespi_enable() is defined in the spi-microchip-core.c
file, but not called elsewhere, so delete this unused function.

drivers/spi/spi-microchip-core.c:122:20: warning: unused function 'mchp_corespi_enable'.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2418
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/spi/spi-microchip-core.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index d352844c798c..aeaa1da88f39 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -119,15 +119,6 @@ static inline void mchp_corespi_write(struct mchp_corespi *spi, unsigned int reg
 	writel(val, spi->regs + reg);
 }
 
-static inline void mchp_corespi_enable(struct mchp_corespi *spi)
-{
-	u32 control = mchp_corespi_read(spi, REG_CONTROL);
-
-	control |= CONTROL_ENABLE;
-
-	mchp_corespi_write(spi, REG_CONTROL, control);
-}
-
 static inline void mchp_corespi_disable(struct mchp_corespi *spi)
 {
 	u32 control = mchp_corespi_read(spi, REG_CONTROL);
-- 
2.20.1.7.g153144c

