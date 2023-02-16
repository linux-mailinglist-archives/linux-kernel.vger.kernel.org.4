Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F9569993C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 16:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjBPPuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 10:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjBPPtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 10:49:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A5C28237;
        Thu, 16 Feb 2023 07:49:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0AB6B82849;
        Thu, 16 Feb 2023 15:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D07CC4339E;
        Thu, 16 Feb 2023 15:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676562584;
        bh=mXPBbrv/+byIBcqr0ExbR9XtALJ6dxnDY7jyj6S6vj4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=eThQyGaSnesQJhn86p/k3Xytajmtp8jq40XlgYMrpjXAvWBlIvmtC9PJNDnYIwoVj
         fMbiw6/i6hjsxERXdF+ag1Zqo06mOR0nm9bTUqqgRmVOxuH8o1JR9owZed1qhn6+U/
         bxD4o1UE6QHgGPuAOg0tUO7uouH0qGS3HW/riUdsJGQzRRS2pLXvinjT9FznFvHvNg
         zK97azUXJV7aZ0Dcq2J6/IpDoO+T4Z6ocslRFeoFv+yHQqzrLN624yG64vRqbsb6eL
         VhjzwmqQQSUsOD8B55WM3k46YRfteYtIo5+wiHf1nAwqo8DiS5x3ZmXhj8wdlZLdub
         fUmnIBY/kIg5Q==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 16 Feb 2023 15:43:58 +0000
Subject: [PATCH 2/2] pinctrl: at91: Remove pioc_index from struct
 at91_gpio_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230216-gpio-at91-immutable-v1-2-44f52f148ab9@kernel.org>
References: <20230216-gpio-at91-immutable-v1-0-44f52f148ab9@kernel.org>
In-Reply-To: <20230216-gpio-at91-immutable-v1-0-44f52f148ab9@kernel.org>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1324; i=broonie@kernel.org;
 h=from:subject:message-id; bh=mXPBbrv/+byIBcqr0ExbR9XtALJ6dxnDY7jyj6S6vj4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj7lCQ0Qdo3jEHLrPAsR6GSZc0ioc0DJzf5BDbd9+7
 IMA9WuKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY+5QkAAKCRAk1otyXVSH0DE+B/
 4hxqbIfZS4LQDY5L6UMkzkA8oHYb3hQqj3Cy57wTmnrpWTmar3fvKlWhNCBvs4jZXNAmU2K1oLNeQa
 HfDeLEuhW5CpWyKS1yPVxza8Tpm+F3rCFxYVp/TY/CHWqWMX4+vIG4EvERcajflOb4As4hsmHNIAEd
 b1oVzBG2pAbGmq23Ww4KsBQ586Wr5L8ARhBFsLxeFr/tqTPSvtO+baFFI9lHm6F819afT71A/troiQ
 RNsiZvR/TmF+FDazfY3bh6geSQhLq337Yh25fad8DN9+AURqV5qzzCQignycBCCH342vRwMd9HyNsG
 ujo9N1mQDM2JjT47qfIL2iNkXUD3lB
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pioc_idx member of struct at91_gpio_chip is write only, just remove it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/pinctrl/pinctrl-at91.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 8ecf52ec9b9b..a1db6ac9bd2e 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -41,7 +41,6 @@ struct at91_pinctrl_mux_ops;
  * @next: bank sharing same clock
  * @pioc_hwirq: PIO bank interrupt identifier on AIC
  * @pioc_virq: PIO bank Linux virtual interrupt
- * @pioc_idx: PIO bank index
  * @regbase: PIO bank virtual address
  * @clock: associated clock
  * @ops: at91 pinctrl mux ops
@@ -55,7 +54,6 @@ struct at91_gpio_chip {
 	struct at91_gpio_chip	*next;
 	int			pioc_hwirq;
 	int			pioc_virq;
-	int			pioc_idx;
 	void __iomem		*regbase;
 	struct clk		*clock;
 	const struct at91_pinctrl_mux_ops *ops;
@@ -1867,7 +1865,6 @@ static int at91_gpio_probe(struct platform_device *pdev)
 	at91_chip->ops = (const struct at91_pinctrl_mux_ops *)
 		of_match_device(at91_gpio_of_match, &pdev->dev)->data;
 	at91_chip->pioc_virq = irq;
-	at91_chip->pioc_idx = alias_idx;
 
 	at91_chip->clock = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(at91_chip->clock)) {

-- 
2.34.1

