Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6AF639D68
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 22:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiK0VwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 16:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiK0VwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 16:52:16 -0500
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD692B7F0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 13:52:14 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id zPZLoGIZNzQOKzPZLocc9q; Sun, 27 Nov 2022 22:52:12 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 27 Nov 2022 22:52:12 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] gpio: Do not include <linux/kernel.h> when not really needed.
Date:   Sun, 27 Nov 2022 22:52:10 +0100
Message-Id: <3f75784c57dc0682b5e1758daddd93fee6bb4b27.1669585920.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<linux/kernel.h> is included only for using container_of().
Include <linux/container_of.h> instead, it is much lighter.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Not sure if the prefix should be gpio or gpiolib.

Let see if build-bots spot something which is inherit via kernel.h
---
 include/linux/of_gpio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index a5166eb93437..6db627257a7b 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -34,7 +34,7 @@ enum of_gpio_flags {
 
 #ifdef CONFIG_OF_GPIO
 
-#include <linux/kernel.h>
+#include <linux/container_of.h>
 
 /*
  * OF GPIO chip for memory mapped banks
-- 
2.34.1

