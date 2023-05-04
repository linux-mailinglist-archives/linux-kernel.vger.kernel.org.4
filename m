Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE336F0C51
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244654AbjD0TH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244593AbjD0THv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:07:51 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4FD46B7;
        Thu, 27 Apr 2023 12:07:43 -0700 (PDT)
Received: from ipservice-092-217-081-249.092.217.pools.vodafone-ip.de ([92.217.81.249] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ps6l6-0003RX-Nc; Thu, 27 Apr 2023 20:54:24 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/3] hwrng: imx-rngc - use BIT(x) for register bit defines
Date:   Thu, 27 Apr 2023 20:53:57 +0200
Message-Id: <20230427185357.923412-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230427185357.923412-1-martin@kaiser.cx>
References: <20230427185357.923412-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite the defines for register bits to use BIT(x) instead of writing
out the 32-bit number. This makes it easier to compare the code with the
register descriptions in the reference manual.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/imx-rngc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index 546dc3655e5b..6872d1c0060b 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -35,19 +35,19 @@
 #define RNGC_TYPE_RNGC			0x2
 
 
-#define RNGC_CMD_CLR_ERR		0x00000020
-#define RNGC_CMD_CLR_INT		0x00000010
-#define RNGC_CMD_SEED			0x00000002
-#define RNGC_CMD_SELF_TEST		0x00000001
+#define RNGC_CMD_CLR_ERR		BIT(5)
+#define RNGC_CMD_CLR_INT		BIT(4)
+#define RNGC_CMD_SEED			BIT(1)
+#define RNGC_CMD_SELF_TEST		BIT(0)
 
-#define RNGC_CTRL_MASK_ERROR		0x00000040
-#define RNGC_CTRL_MASK_DONE		0x00000020
-#define RNGC_CTRL_AUTO_SEED		0x00000010
+#define RNGC_CTRL_MASK_ERROR		BIT(6)
+#define RNGC_CTRL_MASK_DONE		BIT(5)
+#define RNGC_CTRL_AUTO_SEED		BIT(4)
 
-#define RNGC_STATUS_ERROR		0x00010000
+#define RNGC_STATUS_ERROR		BIT(16)
 #define RNGC_STATUS_FIFO_LEVEL		GENMASK(11, 8)
-#define RNGC_STATUS_SEED_DONE		0x00000020
-#define RNGC_STATUS_ST_DONE		0x00000010
+#define RNGC_STATUS_SEED_DONE		BIT(5)
+#define RNGC_STATUS_ST_DONE		BIT(4)
 
 #define RNGC_ERROR_STATUS_STAT_ERR	0x00000008
 
-- 
2.30.2

