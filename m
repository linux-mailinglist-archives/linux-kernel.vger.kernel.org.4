Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950986A82BD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCBMxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjCBMw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:52:58 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8FB185;
        Thu,  2 Mar 2023 04:52:51 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id fa28so588506pfb.12;
        Thu, 02 Mar 2023 04:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElZGWPSn9CP8auAvlpdoQ6n2hX46C9RTZsGwRvPpbgc=;
        b=j1ZnY7zsbC4LN55GLsFmwo37igkQ1Frh7YGwQbrxCBLETkPpVs4xLHP7jJElOoRF5Z
         W16lxLUwEv9CN3gbz+MqtUhpEJvmdz9Y+0Q9H1Bqnvxlplu+c2DHQn8H1PA/uFFs1LIs
         ch7vraMDdDwZmpyWTB4pcG0aW7bcwMAM9xubomrnYbC3ng0u7rPq0cT6HDGOm+PQ0Jrd
         VgATUy+zWvGvg8uUh7aRivZK6Vi/21ZlfRU5PsUGDr0uBwnM8zuIQD1hBD+QOMjE+atv
         5/JLij+/uEPvdqGe/a5QwJ7byncaTfsjSdtJjx72ByOq31SsCRf2yik3mziwUH3re6Kc
         cyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElZGWPSn9CP8auAvlpdoQ6n2hX46C9RTZsGwRvPpbgc=;
        b=PQNSW4tXrf9V7itaZJRZLXhY5fhPNPevPAP1YGRGqo1QQf9vYtGUtK9K2eC8mVML2u
         YjqGI1vzPynpP2kpzp/eNOJbBeE5tcQF+/wbeLYErzYEjWtm4Nq24ZwPGL2yutbMBbpc
         +bMHnVSNU55OH6edkKpbueclGKpRLiduof9GLvWbj0yBXYcGU5qunNqBuYL8gOdsP4IN
         fZaCKHSP+7qr+aQSBAI7Z+aIgy7eySQaegHmTstMhRd2C6mmZj1wsEkNWCIRhnTlQ9IR
         oUEJblAEGunDhNPNQtVDggrfY2hxB4FJjFcSvBf932cSxeDqcZG6JathYQYv//PNeqcw
         2Htg==
X-Gm-Message-State: AO0yUKUe4PepHqFrWwur8yLmkxELHSJS37zX8lXBS3KZHuq3F7X358iC
        BjcOSujuEZ6tjZ60KSiK/r/htc/v9uIVtA==
X-Google-Smtp-Source: AK7set9H4ghe7mKOm/BayKDrHgPnByE6BRDQmXGKFazoPyey/+FSuVhsPQFWesTAOAXH8axBN5kJgw==
X-Received: by 2002:a62:1b51:0:b0:5a9:d0e6:6a85 with SMTP id b78-20020a621b51000000b005a9d0e66a85mr2266922pfb.7.1677761570646;
        Thu, 02 Mar 2023 04:52:50 -0800 (PST)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([223.85.203.147])
        by smtp.gmail.com with ESMTPSA id j7-20020a62e907000000b005aa60d8545esm9791955pfh.61.2023.03.02.04.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 04:52:50 -0800 (PST)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v2 2/5] gpio: loongson1: Use readl() & writel()
Date:   Thu,  2 Mar 2023 20:52:12 +0800
Message-Id: <20230302125215.214014-3-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230302125215.214014-1-keguang.zhang@gmail.com>
References: <20230302125215.214014-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replace __raw_readl() & __raw_writel() with readl() & writel().

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V1 -> V2: Split this change to a separate patch
---
 drivers/gpio/gpio-loongson1.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-loongson1.c b/drivers/gpio/gpio-loongson1.c
index 8862c9ea0d41..b6c11caa3ade 100644
--- a/drivers/gpio/gpio-loongson1.c
+++ b/drivers/gpio/gpio-loongson1.c
@@ -23,8 +23,8 @@ static int ls1x_gpio_request(struct gpio_chip *gc, unsigned int offset)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
-	__raw_writel(__raw_readl(gpio_reg_base + GPIO_CFG) | BIT(offset),
-		     gpio_reg_base + GPIO_CFG);
+	writel(readl(gpio_reg_base + GPIO_CFG) | BIT(offset),
+	       gpio_reg_base + GPIO_CFG);
 	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 
 	return 0;
@@ -35,8 +35,8 @@ static void ls1x_gpio_free(struct gpio_chip *gc, unsigned int offset)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
-	__raw_writel(__raw_readl(gpio_reg_base + GPIO_CFG) & ~BIT(offset),
-		     gpio_reg_base + GPIO_CFG);
+	writel(readl(gpio_reg_base + GPIO_CFG) & ~BIT(offset),
+	       gpio_reg_base + GPIO_CFG);
 	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
-- 
2.34.1

