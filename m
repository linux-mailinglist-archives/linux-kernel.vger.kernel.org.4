Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C647477DD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 19:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjGDRdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 13:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjGDRdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:33:51 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF6D10D7;
        Tue,  4 Jul 2023 10:33:50 -0700 (PDT)
Received: from ipservice-092-217-072-126.092.217.pools.vodafone-ip.de ([92.217.72.126] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qGjuN-0000yT-KH; Tue, 04 Jul 2023 19:33:47 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Joshua Henderson <joshua.henderson@microchip.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/4] hwrng: pic32 - enable compile-testing
Date:   Tue,  4 Jul 2023 19:32:00 +0200
Message-Id: <20230704173203.70706-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230704173203.70706-1-martin@kaiser.cx>
References: <20230704173203.70706-1-martin@kaiser.cx>
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

Enable compile testing for the pic32 driver.

Remove the dependency on HW_RANDOM. The pic32 config section is under
"if HW_RANDOM".

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index e0b3786ca51b..1aeba12391a1 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -385,7 +385,7 @@ config HW_RANDOM_STM32
 
 config HW_RANDOM_PIC32
 	tristate "Microchip PIC32 Random Number Generator support"
-	depends on HW_RANDOM && MACH_PIC32
+	depends on MACH_PIC32 || COMPILE_TEST
 	default y
 	help
 	  This driver provides kernel-side support for the Random Number
-- 
2.30.2

