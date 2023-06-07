Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5985A72623E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240919AbjFGOGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240912AbjFGOGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:06:01 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883001BD6;
        Wed,  7 Jun 2023 07:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=C4s13bc5F5oqYqvLGak07p0slhBoOLAKH4c4bmBI5jA=; b=RZZuOAThcZme93BhfB00Z3U7qC
        QTnwHu+cIlIYsSeeUFcoMOl5iLkPUKNDnm0c2P+HJRFO7fcjR32XYz/V+I/8Vlv31tVyamjX9bd06
        4iJjF4erxKF16LZ0v2ckdbrN2L1/R4RoaHvHPiipEq4OfIuLpTEXMfrGlA7heZbTaqX8=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:57832 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q6tnG-0005dF-Tw; Wed, 07 Jun 2023 10:05:47 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        jesse.sung@canonical.com, isaac.true@canonical.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Lech Perczak <lech.perczak@camlingroup.com>
Date:   Wed,  7 Jun 2023 10:05:24 -0400
Message-Id: <20230607140525.833982-11-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230607140525.833982-1-hugo@hugovil.com>
References: <20230607140525.833982-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH v8 10/10] serial: sc16is7xx: improve comments about variants
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Replace 740/750/760 with generic terms like 74x/75x/76x to account for
variants like 741, 752 and 762.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
---
 drivers/tty/serial/sc16is7xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 7616703f7438..c9edc51870ca 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -223,7 +223,7 @@
  * trigger levels. Trigger levels from 4 characters to 60 characters are
  * available with a granularity of four.
  *
- * When the trigger level setting in TLR is zero, the SC16IS740/750/760 uses the
+ * When the trigger level setting in TLR is zero, the SC16IS74x/75x/76x uses the
  * trigger level setting defined in FCR. If TLR has non-zero trigger level value
  * the trigger level defined in FCR is discarded. This applies to both transmit
  * FIFO and receive FIFO trigger level setting.
@@ -234,7 +234,7 @@
 #define SC16IS7XX_TLR_TX_TRIGGER(words)	((((words) / 4) & 0x0f) << 0)
 #define SC16IS7XX_TLR_RX_TRIGGER(words)	((((words) / 4) & 0x0f) << 4)
 
-/* IOControl register bits (Only 750/760) */
+/* IOControl register bits (Only 75x/76x) */
 #define SC16IS7XX_IOCONTROL_LATCH_BIT	(1 << 0) /* Enable input latching */
 #define SC16IS7XX_IOCONTROL_MODEM_A_BIT	(1 << 1) /* Enable GPIO[7:4] as modem A pins */
 #define SC16IS7XX_IOCONTROL_MODEM_B_BIT	(1 << 2) /* Enable GPIO[3:0] as modem B pins */
@@ -249,9 +249,9 @@
 #define SC16IS7XX_EFCR_RTS_INVERT_BIT	(1 << 5) /* RTS output inversion */
 #define SC16IS7XX_EFCR_IRDA_MODE_BIT	(1 << 7) /* IrDA mode
 						  * 0 = rate upto 115.2 kbit/s
-						  *   - Only 750/760
+						  *   - Only 75x/76x
 						  * 1 = rate upto 1.152 Mbit/s
-						  *   - Only 760
+						  *   - Only 76x
 						  */
 
 /* EFR register bits */
-- 
2.30.2

