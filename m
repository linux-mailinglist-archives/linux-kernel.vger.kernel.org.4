Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1145B70A726
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 12:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjETKWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 06:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjETKWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 06:22:09 -0400
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33FF1A5
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 03:22:04 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 0Jipqvr6aKkqR0JipqDWcb; Sat, 20 May 2023 12:22:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684578122;
        bh=ngf/sPwJeij1NeBPQTwg+KDLxc9Kn0BOhnZCL74zemE=;
        h=From:To:Cc:Subject:Date;
        b=lIHs/qpRBklVl9lwMU7hCKGV8eG7apemlX21mk6804HvKXRTSLfkIH8NHCpRE4dQZ
         DZI/UVBbYqVbNPXtLhELkmaGehZcNdySgPNZ7GjZozm98FyQq8LLIaJ9lvJnv+vTI/
         znqr+toEQWEimCa8GNS16prIL6n3Mued3XLGtLi8MIfS37W/xz4j7R7Rujd24OiwFF
         oTKurFEa48uXmUjGzVl6BHQSuqXXRBfok6skHw/ohYqaDF+/x4bNMFZku0cp1o/BHD
         6q1q2rdZS8A4Dk8tf0GZoFoiZ7O0m6j6TtiiCLuaPifDpQ9CVRKV7U/82awVzN6jqu
         TC1DhVdN/ybiQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 May 2023 12:22:02 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ASoC: atmel: sam9g20_wm8731: Remove the unneeded include <linux/i2c.h>
Date:   Sat, 20 May 2023 12:21:58 +0200
Message-Id: <9b39a59f5829d200d7d1fac4e993dbf8ce05836d.1684578051.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver does not use i2c, so there is no point in including
<linux/i2c.h>

Remove it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Based on one of my scripts, this reduce the number of included files from
589 to 498
---
 sound/soc/atmel/sam9g20_wm8731.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index baf38964b491..0405e9e49140 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -23,7 +23,6 @@
 #include <linux/timer.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
-#include <linux/i2c.h>
 #include <linux/of.h>
 
 #include <linux/atmel-ssc.h>
-- 
2.34.1

