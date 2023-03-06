Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C1A6AC4A6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjCFPSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCFPSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:18:13 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10444241C8;
        Mon,  6 Mar 2023 07:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=SHcUp
        svgcZPe8P352lV4erA+ycpq5uT1Gk16abIeYcY=; b=f5288em6renFj/P7/kPeY
        0rk1Rge6aFNM7878GwMSrJ21CemN47/si+W+TrFQHEQZv6idNm2Bhjk2qpX2/bJY
        W6m8vuUb0qWEQPGY88WRCrKqM4wdt7ppKHNcL+Cpn5xeLittc+0KQPiqZ2iSK/Un
        EllatwV1HhBnlwHS/mVyFk=
Received: from lizhe.. (unknown [120.245.132.120])
        by zwqz-smtp-mta-g0-3 (Coremail) with SMTP id _____wAXF7WWAwZkMTVDCQ--.5123S4;
        Mon, 06 Mar 2023 23:16:19 +0800 (CST)
From:   Lizhe <sensor1010@163.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, geert+renesas@glider.be,
        info@metux.net, shc_work@mail.ru, j-keerthy@ti.com,
        hoan@os.amperecomputing.com, fancer.lancer@gmail.com,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, kaloz@openwrt.org, khalasa@piap.pl,
        keguang.zhang@gmail.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        Lizhe <sensor1010@163.com>
Subject: [PATCH v1] drivers/gpio: remove redundant platform_set_drvdata()
Date:   Mon,  6 Mar 2023 23:15:32 +0800
Message-Id: <20230306151532.23246-1-sensor1010@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAXF7WWAwZkMTVDCQ--.5123S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3XFy7GF1kCw18XF1kAw1kKrg_yoW3tr1UpF
        4jqFy8Cr1UKF43try7A3WrZa4Yka47ta4jgFy7K395Zr1jqryDXFWrJFZ7Zr98tFWDWr43
        tFnrKr4Uua1Ivr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pNiiSbUUUUU=
X-Originating-IP: [120.245.132.120]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBdAQqq1gi5e7C4gAAsg
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove redundant platform_set_drvdata(),
Because there is no place to use the platform_get_drvdata

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/gpio/gpio-74xx-mmio.c  | 2 --
 drivers/gpio/gpio-aggregator.c | 1 -
 drivers/gpio/gpio-amd-fch.c    | 2 --
 drivers/gpio/gpio-clps711x.c   | 1 -
 drivers/gpio/gpio-davinci.c    | 1 -
 drivers/gpio/gpio-dwapb.c      | 2 --
 drivers/gpio/gpio-eic-sprd.c   | 1 -
 drivers/gpio/gpio-exar.c       | 2 --
 drivers/gpio/gpio-f7188x.c     | 2 --
 drivers/gpio/gpio-htc-egpio.c  | 2 --
 drivers/gpio/gpio-ixp4xx.c     | 1 -
 drivers/gpio/gpio-janz-ttl.c   | 1 -
 drivers/gpio/gpio-kempld.c     | 2 --
 drivers/gpio/gpio-logicvc.c    | 2 --
 drivers/gpio/gpio-loongson1.c  | 1 -
 drivers/gpio/gpio-lp3943.c     | 2 --
 drivers/gpio/gpio-lp873x.c     | 2 --
 17 files changed, 27 deletions(-)

diff --git a/drivers/gpio/gpio-74xx-mmio.c b/drivers/gpio/gpio-74xx-mmio.c
index 0464f1ecd20d..c7ac5a9ffb1f 100644
--- a/drivers/gpio/gpio-74xx-mmio.c
+++ b/drivers/gpio/gpio-74xx-mmio.c
@@ -135,8 +135,6 @@ static int mmio_74xx_gpio_probe(struct platform_device *pdev)
 	priv->gc.ngpio = MMIO_74XX_BIT_CNT(priv->flags);
 	priv->gc.owner = THIS_MODULE;
 
-	platform_set_drvdata(pdev, priv);
-
 	return devm_gpiochip_add_data(&pdev->dev, &priv->gc, priv);
 }
 
diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 6d17d262ad91..f67d1d46c093 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -495,7 +495,6 @@ static int gpio_aggregator_probe(struct platform_device *pdev)
 	if (IS_ERR(fwd))
 		return PTR_ERR(fwd);
 
-	platform_set_drvdata(pdev, fwd);
 	return 0;
 }
 
diff --git a/drivers/gpio/gpio-amd-fch.c b/drivers/gpio/gpio-amd-fch.c
index 2a21354ed6a0..8a7f861513eb 100644
--- a/drivers/gpio/gpio-amd-fch.c
+++ b/drivers/gpio/gpio-amd-fch.c
@@ -172,8 +172,6 @@ static int amd_fch_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	platform_set_drvdata(pdev, priv);
-
 	return devm_gpiochip_add_data(&pdev->dev, &priv->gc, priv);
 }
 
diff --git a/drivers/gpio/gpio-clps711x.c b/drivers/gpio/gpio-clps711x.c
index 75f6f8d4323e..b9ba85ef94b2 100644
--- a/drivers/gpio/gpio-clps711x.c
+++ b/drivers/gpio/gpio-clps711x.c
@@ -62,7 +62,6 @@ static int clps711x_gpio_probe(struct platform_device *pdev)
 
 	gc->base = -1;
 	gc->owner = THIS_MODULE;
-	platform_set_drvdata(pdev, gc);
 
 	return devm_gpiochip_add_data(&pdev->dev, gc, NULL);
 }
diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 26b1f7465e09..ec619c3fde90 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -266,7 +266,6 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(pdev, chips);
 	ret = davinci_gpio_irq_setup(pdev);
 	if (ret)
 		return ret;
diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index c22fcaa44a61..8db67674078e 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -734,8 +734,6 @@ static int dwapb_gpio_probe(struct platform_device *pdev)
 			return err;
 	}
 
-	platform_set_drvdata(pdev, gpio);
-
 	return 0;
 }
 
diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index 84352a6f4973..53db88ae2a20 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -653,7 +653,6 @@ static int sprd_eic_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, sprd_eic);
 	return 0;
 }
 
diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index df1bdaae441c..5170fe7599cd 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -217,8 +217,6 @@ static int gpio_exar_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(pdev, exar_gpio);
-
 	return 0;
 }
 
diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
index 9effa7769bef..5475614c1872 100644
--- a/drivers/gpio/gpio-f7188x.c
+++ b/drivers/gpio/gpio-f7188x.c
@@ -499,8 +499,6 @@ static int f7188x_gpio_probe(struct platform_device *pdev)
 	}
 	data->sio = sio;
 
-	platform_set_drvdata(pdev, data);
-
 	/* For each GPIO bank, register a GPIO chip. */
 	for (i = 0; i < data->nr_bank; i++) {
 		struct f7188x_gpio_bank *bank = &data->bank[i];
diff --git a/drivers/gpio/gpio-htc-egpio.c b/drivers/gpio/gpio-htc-egpio.c
index a40bd56673fe..e38352ee25ac 100644
--- a/drivers/gpio/gpio-htc-egpio.c
+++ b/drivers/gpio/gpio-htc-egpio.c
@@ -300,8 +300,6 @@ static int __init egpio_probe(struct platform_device *pdev)
 
 	ei->reg_mask = (1 << pdata->reg_width) - 1;
 
-	platform_set_drvdata(pdev, ei);
-
 	ei->nchips = pdata->num_chips;
 	ei->chip = devm_kcalloc(&pdev->dev,
 				ei->nchips, sizeof(struct egpio_chip),
diff --git a/drivers/gpio/gpio-ixp4xx.c b/drivers/gpio/gpio-ixp4xx.c
index 56656fb519f8..3f59658dd316 100644
--- a/drivers/gpio/gpio-ixp4xx.c
+++ b/drivers/gpio/gpio-ixp4xx.c
@@ -287,7 +287,6 @@ static int ixp4xx_gpio_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, g);
 	dev_info(dev, "IXP4 GPIO registered\n");
 
 	return 0;
diff --git a/drivers/gpio/gpio-janz-ttl.c b/drivers/gpio/gpio-janz-ttl.c
index cdf50e4ea165..ea68f49c1824 100644
--- a/drivers/gpio/gpio-janz-ttl.c
+++ b/drivers/gpio/gpio-janz-ttl.c
@@ -154,7 +154,6 @@ static int ttl_probe(struct platform_device *pdev)
 	if (!mod)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, mod);
 	spin_lock_init(&mod->lock);
 
 	/* get access to the MODULbus registers for this module */
diff --git a/drivers/gpio/gpio-kempld.c b/drivers/gpio/gpio-kempld.c
index 4ea15f08e0f4..2065a8a121b2 100644
--- a/drivers/gpio/gpio-kempld.c
+++ b/drivers/gpio/gpio-kempld.c
@@ -151,8 +151,6 @@ static int kempld_gpio_probe(struct platform_device *pdev)
 
 	gpio->pld = pld;
 
-	platform_set_drvdata(pdev, gpio);
-
 	chip = &gpio->chip;
 	chip->label = "gpio-kempld";
 	chip->owner = THIS_MODULE;
diff --git a/drivers/gpio/gpio-logicvc.c b/drivers/gpio/gpio-logicvc.c
index 992cc958a43f..9b4789deae45 100644
--- a/drivers/gpio/gpio-logicvc.c
+++ b/drivers/gpio/gpio-logicvc.c
@@ -139,8 +139,6 @@ static int logicvc_gpio_probe(struct platform_device *pdev)
 	logicvc->chip.set = logicvc_gpio_set;
 	logicvc->chip.direction_output = logicvc_gpio_direction_output;
 
-	platform_set_drvdata(pdev, logicvc);
-
 	return devm_gpiochip_add_data(dev, &logicvc->chip, logicvc);
 }
 
diff --git a/drivers/gpio/gpio-loongson1.c b/drivers/gpio/gpio-loongson1.c
index 5d90b3bc5a25..0ff4ea7af9c0 100644
--- a/drivers/gpio/gpio-loongson1.c
+++ b/drivers/gpio/gpio-loongson1.c
@@ -72,7 +72,6 @@ static int ls1x_gpio_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
-	platform_set_drvdata(pdev, gc);
 	dev_info(dev, "Loongson1 GPIO driver registered\n");
 
 	return 0;
diff --git a/drivers/gpio/gpio-lp3943.c b/drivers/gpio/gpio-lp3943.c
index 79edd5db49d2..8e58242f5123 100644
--- a/drivers/gpio/gpio-lp3943.c
+++ b/drivers/gpio/gpio-lp3943.c
@@ -199,8 +199,6 @@ static int lp3943_gpio_probe(struct platform_device *pdev)
 	lp3943_gpio->chip = lp3943_gpio_chip;
 	lp3943_gpio->chip.parent = &pdev->dev;
 
-	platform_set_drvdata(pdev, lp3943_gpio);
-
 	return devm_gpiochip_add_data(&pdev->dev, &lp3943_gpio->chip,
 				      lp3943_gpio);
 }
diff --git a/drivers/gpio/gpio-lp873x.c b/drivers/gpio/gpio-lp873x.c
index 5c79ba1f229c..7427a74ce4e2 100644
--- a/drivers/gpio/gpio-lp873x.c
+++ b/drivers/gpio/gpio-lp873x.c
@@ -140,8 +140,6 @@ static int lp873x_gpio_probe(struct platform_device *pdev)
 	if (!gpio)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, gpio);
-
 	gpio->lp873 = dev_get_drvdata(pdev->dev.parent);
 	gpio->chip = template_chip;
 	gpio->chip.parent = gpio->lp873->dev;
-- 
2.34.1

