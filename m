Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09616C014A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 13:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjCSMED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 08:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjCSMEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 08:04:00 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C1DB18B0A;
        Sun, 19 Mar 2023 05:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=CAjC2
        KXD9coUh5ZlEYyrtxubbJSq42U8VQy4mXbUqMo=; b=G7N3Kvys0DklJD1xiVcNS
        dJmsyO9vAoJJHA9KSoHtkTYCmutnsGtU0//SB6b5k2gr/FfPLp1kv8XPN6FI2nEw
        5Ho0aoF5aExc8IZzI3hzTSTYgOlNpAWMYnyR1Iudb7V6Y9+jCCm/PSqm/g/VTD4n
        UL+Kxzo0vbfrbCaeSG0T1Y=
Received: from lizhe.. (unknown [120.245.132.192])
        by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wCnzB0g+RZkSwUUAg--.12080S4;
        Sun, 19 Mar 2023 19:59:59 +0800 (CST)
From:   Lizhe <sensor1010@163.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, geert+renesas@glider.be,
        info@metux.net, rjui@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        sbranden@broadcom.com, shc_work@mail.ru, j-keerthy@ti.com,
        hoan@os.amperecomputing.com, fancer.lancer@gmail.com,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kaloz@openwrt.org, khalasa@piap.pl, keguang.zhang@gmail.com,
        daniel@thingy.jp, romain.perier@gmail.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, grygorii.strashko@ti.com,
        ssantosh@kernel.org, khilman@kernel.org, mani@kernel.org,
        ludovic.desroches@microchip.com, andy@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, jonathanh@nvidia.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, michal.simek@xilinx.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-unisoc@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-tegra@vger.kernel.org,
        Lizhe <sensor1010@163.com>
Subject: [PATCH v2] drivers/gpio : Remove redundant platform_set_drvdata().
Date:   Sun, 19 Mar 2023 19:59:25 +0800
Message-Id: <20230319115925.1317654-1-sensor1010@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCnzB0g+RZkSwUUAg--.12080S4
X-Coremail-Antispam: 1Uf129KBjvAXoWfZry8KFWUWFy3Cw4kCw4UArb_yoW5JF17Xo
        WxJ3y3uF15Jw4xZwn8AFnrWF9xXanxAw13A3y3Aan0gFyDJw15tr1fWF1fCa4Yqw15trW8
        Zw12yw48GFZ7Ca48n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRltCrUUUUU
X-Originating-IP: [120.245.132.192]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiKB03q17WMXLAZAAAsG
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_set_drvdata() is redundant in these functions.
the purpose of calling this function is to place data
in *driver_data. but the data is not retrieved in these
functions

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/gpio/gpio-74xx-mmio.c      | 2 --
 drivers/gpio/gpio-aggregator.c     | 1 -
 drivers/gpio/gpio-amd-fch.c        | 2 --
 drivers/gpio/gpio-bcm-kona.c       | 1 -
 drivers/gpio/gpio-clps711x.c       | 1 -
 drivers/gpio/gpio-davinci.c        | 1 -
 drivers/gpio/gpio-dwapb.c          | 2 --
 drivers/gpio/gpio-eic-sprd.c       | 1 -
 drivers/gpio/gpio-em.c             | 1 -
 drivers/gpio/gpio-exar.c           | 2 --
 drivers/gpio/gpio-f7188x.c         | 2 --
 drivers/gpio/gpio-htc-egpio.c      | 3 ---
 drivers/gpio/gpio-imx-scu.c        | 2 --
 drivers/gpio/gpio-ixp4xx.c         | 1 -
 drivers/gpio/gpio-janz-ttl.c       | 1 -
 drivers/gpio/gpio-kempld.c         | 2 --
 drivers/gpio/gpio-latch.c          | 2 --
 drivers/gpio/gpio-logicvc.c        | 2 --
 drivers/gpio/gpio-loongson1.c      | 1 -
 drivers/gpio/gpio-lp3943.c         | 2 --
 drivers/gpio/gpio-lp873x.c         | 2 --
 drivers/gpio/gpio-max77620.c       | 2 --
 drivers/gpio/gpio-mlxbf.c          | 1 -
 drivers/gpio/gpio-mlxbf2.c         | 2 --
 drivers/gpio/gpio-mmio.c           | 2 --
 drivers/gpio/gpio-msc313.c         | 2 --
 drivers/gpio/gpio-mt7621.c         | 1 -
 drivers/gpio/gpio-mvebu.c          | 2 --
 drivers/gpio/gpio-mxc.c            | 2 --
 drivers/gpio/gpio-omap.c           | 4 ----
 drivers/gpio/gpio-palmas.c         | 1 -
 drivers/gpio/gpio-pmic-eic-sprd.c  | 1 -
 drivers/gpio/gpio-rc5t583.c        | 2 --
 drivers/gpio/gpio-rcar.c           | 2 --
 drivers/gpio/gpio-rda.c            | 2 --
 drivers/gpio/gpio-rdc321x.c        | 2 --
 drivers/gpio/gpio-sama5d2-piobu.c  | 1 -
 drivers/gpio/gpio-sch.c            | 2 --
 drivers/gpio/gpio-sch311x.c        | 2 --
 drivers/gpio/gpio-sifive.c         | 1 -
 drivers/gpio/gpio-syscon.c         | 2 --
 drivers/gpio/gpio-tegra.c          | 2 --
 drivers/gpio/gpio-timberdale.c     | 2 --
 drivers/gpio/gpio-tqmx86.c         | 2 --
 drivers/gpio/gpio-ts4800.c         | 2 --
 drivers/gpio/gpio-vx855.c          | 2 --
 drivers/gpio/gpio-wcove.c          | 2 --
 drivers/gpio/gpio-xgene.c          | 2 --
 drivers/gpio/gpio-zevio.c          | 2 --
 drivers/gpio/gpio-zynqmp-modepin.c | 2 --
 50 files changed, 88 deletions(-)

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
 
diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index 70770429ba48..2e50a07a43e6 100644
--- a/drivers/gpio/gpio-bcm-kona.c
+++ b/drivers/gpio/gpio-bcm-kona.c
@@ -597,7 +597,6 @@ static int bcm_kona_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	kona_gpio->pdev = pdev;
-	platform_set_drvdata(pdev, kona_gpio);
 	chip->parent = dev;
 	chip->ngpio = kona_gpio->num_bank * GPIO_PER_BANK;
 
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
 
diff --git a/drivers/gpio/gpio-em.c b/drivers/gpio/gpio-em.c
index 858e6ebbb584..3707cb4c1b79 100644
--- a/drivers/gpio/gpio-em.c
+++ b/drivers/gpio/gpio-em.c
@@ -281,7 +281,6 @@ static int em_gio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	p->pdev = pdev;
-	platform_set_drvdata(pdev, p);
 	spin_lock_init(&p->sense_lock);
 
 	irq[0] = platform_get_irq(pdev, 0);
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
index a40bd56673fe..0938c0712732 100644
--- a/drivers/gpio/gpio-htc-egpio.c
+++ b/drivers/gpio/gpio-htc-egpio.c
@@ -299,9 +299,6 @@ static int __init egpio_probe(struct platform_device *pdev)
 	pr_debug("reg_shift = %d\n", ei->reg_shift);
 
 	ei->reg_mask = (1 << pdata->reg_width) - 1;
-
-	platform_set_drvdata(pdev, ei);
-
 	ei->nchips = pdata->num_chips;
 	ei->chip = devm_kcalloc(&pdev->dev,
 				ei->nchips, sizeof(struct egpio_chip),
diff --git a/drivers/gpio/gpio-imx-scu.c b/drivers/gpio/gpio-imx-scu.c
index 17be21b8f3b7..bcc12105878e 100644
--- a/drivers/gpio/gpio-imx-scu.c
+++ b/drivers/gpio/gpio-imx-scu.c
@@ -109,8 +109,6 @@ static int imx_scu_gpio_probe(struct platform_device *pdev)
 	gc->set = imx_scu_gpio_set;
 	gc->get_direction = imx_scu_gpio_get_direction;
 
-	platform_set_drvdata(pdev, priv);
-
 	return devm_gpiochip_add_data(dev, gc, priv);
 }
 
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
diff --git a/drivers/gpio/gpio-latch.c b/drivers/gpio/gpio-latch.c
index d7c3b20c8482..cf0f86b87c87 100644
--- a/drivers/gpio/gpio-latch.c
+++ b/drivers/gpio/gpio-latch.c
@@ -192,8 +192,6 @@ static int gpio_latch_probe(struct platform_device *pdev)
 	priv->gc.base = -1;
 	priv->gc.parent = &pdev->dev;
 
-	platform_set_drvdata(pdev, priv);
-
 	return devm_gpiochip_add_data(&pdev->dev, &priv->gc, priv);
 }
 
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
diff --git a/drivers/gpio/gpio-max77620.c b/drivers/gpio/gpio-max77620.c
index c18b60e39a94..8c2a5609161f 100644
--- a/drivers/gpio/gpio-max77620.c
+++ b/drivers/gpio/gpio-max77620.c
@@ -331,8 +331,6 @@ static int max77620_gpio_probe(struct platform_device *pdev)
 	girq->init_hw = max77620_gpio_irq_init_hw;
 	girq->threaded = true;
 
-	platform_set_drvdata(pdev, mgpio);
-
 	ret = devm_gpiochip_add_data(&pdev->dev, &mgpio->gpio_chip, mgpio);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "gpio_init: Failed to add max77620_gpio\n");
diff --git a/drivers/gpio/gpio-mlxbf.c b/drivers/gpio/gpio-mlxbf.c
index 1fa9973f55b9..f38faf40c92a 100644
--- a/drivers/gpio/gpio-mlxbf.c
+++ b/drivers/gpio/gpio-mlxbf.c
@@ -82,7 +82,6 @@ static int mlxbf_gpio_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, gs);
 	dev_info(&pdev->dev, "registered Mellanox BlueField GPIO");
 	return 0;
 }
diff --git a/drivers/gpio/gpio-mlxbf2.c b/drivers/gpio/gpio-mlxbf2.c
index 77a41151c921..fdc4e66eae12 100644
--- a/drivers/gpio/gpio-mlxbf2.c
+++ b/drivers/gpio/gpio-mlxbf2.c
@@ -402,8 +402,6 @@ mlxbf2_gpio_probe(struct platform_device *pdev)
 		}
 	}
 
-	platform_set_drvdata(pdev, gs);
-
 	ret = devm_gpiochip_add_data(dev, &gs->gc, gs);
 	if (ret) {
 		dev_err(dev, "Failed adding memory mapped gpiochip\n");
diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
index d9dff3dc92ae..c085c60584a8 100644
--- a/drivers/gpio/gpio-mmio.c
+++ b/drivers/gpio/gpio-mmio.c
@@ -787,8 +787,6 @@ static int bgpio_pdev_probe(struct platform_device *pdev)
 			gc->ngpio = pdata->ngpio;
 	}
 
-	platform_set_drvdata(pdev, gc);
-
 	return devm_gpiochip_add_data(&pdev->dev, gc, NULL);
 }
 
diff --git a/drivers/gpio/gpio-msc313.c b/drivers/gpio/gpio-msc313.c
index b0773e5652fa..0a12948defc0 100644
--- a/drivers/gpio/gpio-msc313.c
+++ b/drivers/gpio/gpio-msc313.c
@@ -625,8 +625,6 @@ static int msc313_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(gpio->base))
 		return PTR_ERR(gpio->base);
 
-	platform_set_drvdata(pdev, gpio);
-
 	gpiochip = devm_kzalloc(dev, sizeof(*gpiochip), GFP_KERNEL);
 	if (!gpiochip)
 		return -ENOMEM;
diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
index 93facbebb80e..c0c715167d9c 100644
--- a/drivers/gpio/gpio-mt7621.c
+++ b/drivers/gpio/gpio-mt7621.c
@@ -315,7 +315,6 @@ mediatek_gpio_probe(struct platform_device *pdev)
 		return mtk->gpio_irq;
 
 	mtk->dev = dev;
-	platform_set_drvdata(pdev, mtk);
 
 	for (i = 0; i < MTK_BANK_CNT; i++) {
 		ret = mediatek_gpio_bank_probe(dev, i);
diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index a68f682aec01..699c9378bda7 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -1143,8 +1143,6 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	if (!mvchip)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, mvchip);
-
 	if (of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpios)) {
 		dev_err(&pdev->dev, "Missing ngpios OF property\n");
 		return -ENODEV;
diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 9d0cec4b82a3..ac8b12606eae 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -489,8 +489,6 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 
 	list_add_tail(&port->node, &mxc_gpio_ports);
 
-	platform_set_drvdata(pdev, port);
-
 	return 0;
 
 out_irqdomain_remove:
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index f5f3d4b22452..acbdb4fd922e 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -762,8 +762,6 @@ static struct platform_device omap_mpuio_device = {
 
 static inline void omap_mpuio_init(struct gpio_bank *bank)
 {
-	platform_set_drvdata(&omap_mpuio_device, bank);
-
 	if (platform_driver_register(&omap_mpuio_driver) == 0)
 		(void) platform_device_register(&omap_mpuio_device);
 }
@@ -1457,8 +1455,6 @@ static int omap_gpio_probe(struct platform_device *pdev)
 		}
 	}
 
-	platform_set_drvdata(pdev, bank);
-
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
diff --git a/drivers/gpio/gpio-palmas.c b/drivers/gpio/gpio-palmas.c
index bac10c2faf56..dd8a287ff6d0 100644
--- a/drivers/gpio/gpio-palmas.c
+++ b/drivers/gpio/gpio-palmas.c
@@ -184,7 +184,6 @@ static int palmas_gpio_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, palmas_gpio);
 	return ret;
 }
 
diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
index c3e4d90f6b18..bfb003ccbd99 100644
--- a/drivers/gpio/gpio-pmic-eic-sprd.c
+++ b/drivers/gpio/gpio-pmic-eic-sprd.c
@@ -363,7 +363,6 @@ static int sprd_pmic_eic_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, pmic_eic);
 	return 0;
 }
 
diff --git a/drivers/gpio/gpio-rc5t583.c b/drivers/gpio/gpio-rc5t583.c
index 4fae3ebea790..c34dcadaee36 100644
--- a/drivers/gpio/gpio-rc5t583.c
+++ b/drivers/gpio/gpio-rc5t583.c
@@ -121,8 +121,6 @@ static int rc5t583_gpio_probe(struct platform_device *pdev)
 	if (pdata && pdata->gpio_base)
 		rc5t583_gpio->gpio_chip.base = pdata->gpio_base;
 
-	platform_set_drvdata(pdev, rc5t583_gpio);
-
 	return devm_gpiochip_add_data(&pdev->dev, &rc5t583_gpio->gpio_chip,
 				      rc5t583_gpio);
 }
diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 5b117f3bd322..f00a0c2f9dc1 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -513,8 +513,6 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	platform_set_drvdata(pdev, p);
-
 	pm_runtime_enable(dev);
 
 	ret = platform_get_irq(pdev, 0);
diff --git a/drivers/gpio/gpio-rda.c b/drivers/gpio/gpio-rda.c
index 62ba18b3a602..04059c5b3d9e 100644
--- a/drivers/gpio/gpio-rda.c
+++ b/drivers/gpio/gpio-rda.c
@@ -263,8 +263,6 @@ static int rda_gpio_probe(struct platform_device *pdev)
 		girq->parents[0] = rda_gpio->irq;
 	}
 
-	platform_set_drvdata(pdev, rda_gpio);
-
 	return devm_gpiochip_add_data(dev, &rda_gpio->chip, rda_gpio);
 }
 
diff --git a/drivers/gpio/gpio-rdc321x.c b/drivers/gpio/gpio-rdc321x.c
index 01ed2517e9fd..4d3c6c9adfcd 100644
--- a/drivers/gpio/gpio-rdc321x.c
+++ b/drivers/gpio/gpio-rdc321x.c
@@ -161,8 +161,6 @@ static int rdc321x_gpio_probe(struct platform_device *pdev)
 	rdc321x_gpio_dev->chip.base = 0;
 	rdc321x_gpio_dev->chip.ngpio = pdata->max_gpios;
 
-	platform_set_drvdata(pdev, rdc321x_gpio_dev);
-
 	/* This might not be, what others (BIOS, bootloader, etc.)
 	   wrote to these registers before, but it's a good guess. Still
 	   better than just using 0xffffffff. */
diff --git a/drivers/gpio/gpio-sama5d2-piobu.c b/drivers/gpio/gpio-sama5d2-piobu.c
index 3e95da717fc9..7c3f4a268829 100644
--- a/drivers/gpio/gpio-sama5d2-piobu.c
+++ b/drivers/gpio/gpio-sama5d2-piobu.c
@@ -189,7 +189,6 @@ static int sama5d2_piobu_probe(struct platform_device *pdev)
 	if (!piobu)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, piobu);
 	piobu->chip.label = pdev->name;
 	piobu->chip.parent = &pdev->dev;
 	piobu->chip.owner = THIS_MODULE,
diff --git a/drivers/gpio/gpio-sch.c b/drivers/gpio/gpio-sch.c
index 8a83f7bf4382..e48392074e4b 100644
--- a/drivers/gpio/gpio-sch.c
+++ b/drivers/gpio/gpio-sch.c
@@ -380,8 +380,6 @@ static int sch_gpio_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	platform_set_drvdata(pdev, sch);
-
 	girq = &sch->chip.irq;
 	gpio_irq_chip_set_chip(girq, &sch_irqchip);
 	girq->num_parents = 0;
diff --git a/drivers/gpio/gpio-sch311x.c b/drivers/gpio/gpio-sch311x.c
index da01e1cad7cb..63b757e7e507 100644
--- a/drivers/gpio/gpio-sch311x.c
+++ b/drivers/gpio/gpio-sch311x.c
@@ -281,8 +281,6 @@ static int sch311x_gpio_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, priv);
-
 	for (i = 0; i < ARRAY_SIZE(priv->blocks); i++) {
 		block = &priv->blocks[i];
 
diff --git a/drivers/gpio/gpio-sifive.c b/drivers/gpio/gpio-sifive.c
index bc5660f61c57..65d1b6437136 100644
--- a/drivers/gpio/gpio-sifive.c
+++ b/drivers/gpio/gpio-sifive.c
@@ -256,7 +256,6 @@ static int sifive_gpio_probe(struct platform_device *pdev)
 	girq->handler = handle_bad_irq;
 	girq->default_type = IRQ_TYPE_NONE;
 
-	platform_set_drvdata(pdev, chip);
 	return gpiochip_add_data(&chip->gc, chip);
 }
 
diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
index 6076937b18e7..afceb7e17ad8 100644
--- a/drivers/gpio/gpio-syscon.c
+++ b/drivers/gpio/gpio-syscon.c
@@ -249,8 +249,6 @@ static int syscon_gpio_probe(struct platform_device *pdev)
 		priv->chip.direction_output = syscon_gpio_dir_out;
 	}
 
-	platform_set_drvdata(pdev, priv);
-
 	return devm_gpiochip_add_data(&pdev->dev, &priv->chip, priv);
 }
 
diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 5b265a6fd3c1..8a1731a13b5a 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -728,8 +728,6 @@ static int tegra_gpio_probe(struct platform_device *pdev)
 	tgi->gc.ngpio			= tgi->bank_count * 32;
 	tgi->gc.parent			= &pdev->dev;
 
-	platform_set_drvdata(pdev, tgi);
-
 	if (tgi->soc->debounce_supported)
 		tgi->gc.set_config = tegra_gpio_set_config;
 
diff --git a/drivers/gpio/gpio-timberdale.c b/drivers/gpio/gpio-timberdale.c
index de14949a3fe5..bbd9e9191199 100644
--- a/drivers/gpio/gpio-timberdale.c
+++ b/drivers/gpio/gpio-timberdale.c
@@ -256,8 +256,6 @@ static int timbgpio_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	platform_set_drvdata(pdev, tgpio);
-
 	/* make sure to disable interrupts */
 	iowrite32(0x0, tgpio->membase + TGPIO_IER);
 
diff --git a/drivers/gpio/gpio-tqmx86.c b/drivers/gpio/gpio-tqmx86.c
index e739dcea61b2..f0a2cf4b0679 100644
--- a/drivers/gpio/gpio-tqmx86.c
+++ b/drivers/gpio/gpio-tqmx86.c
@@ -259,8 +259,6 @@ static int tqmx86_gpio_probe(struct platform_device *pdev)
 
 	tqmx86_gpio_write(gpio, (u8)~TQMX86_DIR_INPUT_MASK, TQMX86_GPIODD);
 
-	platform_set_drvdata(pdev, gpio);
-
 	chip = &gpio->chip;
 	chip->label = "gpio-tqmx86";
 	chip->owner = THIS_MODULE;
diff --git a/drivers/gpio/gpio-ts4800.c b/drivers/gpio/gpio-ts4800.c
index 95d80ba14bee..b0b338480516 100644
--- a/drivers/gpio/gpio-ts4800.c
+++ b/drivers/gpio/gpio-ts4800.c
@@ -52,8 +52,6 @@ static int ts4800_gpio_probe(struct platform_device *pdev)
 
 	chip->ngpio = ngpios;
 
-	platform_set_drvdata(pdev, chip);
-
 	return devm_gpiochip_add_data(&pdev->dev, chip, NULL);
 }
 
diff --git a/drivers/gpio/gpio-vx855.c b/drivers/gpio/gpio-vx855.c
index 69713fd5485b..8fd6c3913d69 100644
--- a/drivers/gpio/gpio-vx855.c
+++ b/drivers/gpio/gpio-vx855.c
@@ -240,8 +240,6 @@ static int vx855gpio_probe(struct platform_device *pdev)
 	if (!vg)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, vg);
-
 	dev_info(&pdev->dev, "found VX855 GPIO controller\n");
 	vg->io_gpi = res_gpi->start;
 	vg->io_gpo = res_gpo->start;
diff --git a/drivers/gpio/gpio-wcove.c b/drivers/gpio/gpio-wcove.c
index c18b6b47384f..15e59f95b8d0 100644
--- a/drivers/gpio/gpio-wcove.c
+++ b/drivers/gpio/gpio-wcove.c
@@ -433,8 +433,6 @@ static int wcove_gpio_probe(struct platform_device *pdev)
 
 	wg->regmap_irq_chip = pmic->irq_chip_data;
 
-	platform_set_drvdata(pdev, wg);
-
 	mutex_init(&wg->buslock);
 	wg->chip.label = KBUILD_MODNAME;
 	wg->chip.direction_input = wcove_gpio_dir_in;
diff --git a/drivers/gpio/gpio-xgene.c b/drivers/gpio/gpio-xgene.c
index fb4b0c67aeef..f2702065dae6 100644
--- a/drivers/gpio/gpio-xgene.c
+++ b/drivers/gpio/gpio-xgene.c
@@ -180,8 +180,6 @@ static int xgene_gpio_probe(struct platform_device *pdev)
 	gpio->chip.label = dev_name(&pdev->dev);
 	gpio->chip.base = -1;
 
-	platform_set_drvdata(pdev, gpio);
-
 	return devm_gpiochip_add_data(&pdev->dev, &gpio->chip, gpio);
 }
 
diff --git a/drivers/gpio/gpio-zevio.c b/drivers/gpio/gpio-zevio.c
index f0f571b323f2..2de61337ad3b 100644
--- a/drivers/gpio/gpio-zevio.c
+++ b/drivers/gpio/gpio-zevio.c
@@ -176,8 +176,6 @@ static int zevio_gpio_probe(struct platform_device *pdev)
 	if (!controller)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, controller);
-
 	/* Copy our reference */
 	controller->chip = zevio_gpio_chip;
 	controller->chip.parent = &pdev->dev;
diff --git a/drivers/gpio/gpio-zynqmp-modepin.c b/drivers/gpio/gpio-zynqmp-modepin.c
index a0d69387c153..cfe540a3cfb4 100644
--- a/drivers/gpio/gpio-zynqmp-modepin.c
+++ b/drivers/gpio/gpio-zynqmp-modepin.c
@@ -120,8 +120,6 @@ static int modepin_gpio_probe(struct platform_device *pdev)
 	if (!chip)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, chip);
-
 	/* configure the gpio chip */
 	chip->base = -1;
 	chip->ngpio = MODE_PINS;
-- 
2.34.1

