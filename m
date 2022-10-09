Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9775F8A20
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 10:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiJII26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 04:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJII2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 04:28:55 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA99F2CDE6
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 01:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=4eL9r
        8jw9Yc+LnW3t0PByM/D4ZUtGdkfbKKYzje1sCA=; b=clnd2V0pDxGd98xbfqBm5
        d9IpbX8HB9PqZS6420ndPFdvvR3edqgTSSTbQHgnMhkUffnTsBp0j70Fo1zHvUQH
        zYqUOrZD8BLGq1vt2CU3H4eQDcrcMLat36fUa96IVVfQbtKtmoUH2tIh/4eNgAuD
        0ZP5q8M/ZuZaeRBJqFTdDk=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp4 (Coremail) with SMTP id HNxpCgD3ba4whkJj26drjQ--.45619S2;
        Sun, 09 Oct 2022 16:28:33 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     srinivas.kandagatla@linaro.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] nvmem: stm32: fix spelling typo in comment
Date:   Sun,  9 Oct 2022 16:28:19 +0800
Message-Id: <20221009082819.2662964-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgD3ba4whkJj26drjQ--.45619S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrury7Jr47ZFy5Gw4xArWUArb_yoW3AFb_t3
        W0qrWDWr129asakr18Cr1avryYyFs8G3yDArn0grs5J3srZw4DX34DZrnaya47Ar4YgFZ3
        Wwn5tr9xGa9rJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbuOJ7UUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbiVxGV+1etohKRzAAAs-
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix spelling typo in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/nvmem/stm32-romem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
index 354be526897f..0c206ad05be7 100644
--- a/drivers/nvmem/stm32-romem.c
+++ b/drivers/nvmem/stm32-romem.c
@@ -19,7 +19,7 @@
 #define STM32_SMC_WRITE_SHADOW		0x03
 #define STM32_SMC_READ_OTP		0x04
 
-/* shadow registers offest */
+/* shadow registers offset */
 #define STM32MP15_BSEC_DATA0		0x200
 
 /* 32 (x 32-bits) lower shadow registers */
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

