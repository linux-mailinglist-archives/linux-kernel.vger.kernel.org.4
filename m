Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89FD618EAE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 04:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiKDDRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 23:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKDDQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 23:16:55 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C3125E81;
        Thu,  3 Nov 2022 20:16:55 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id q9so3401351pfg.5;
        Thu, 03 Nov 2022 20:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vESVsop4ZB+nxJMme9WqcQCG5NESqBZw6q6kC1WMIIw=;
        b=PZKdhoMLbT0Q3wcy5njb/+FOYlfWcqBjMzdoeLUeT8U5lV7KYOXsQiPt9Wj03zExMH
         vtBa9/PDAvfkik0KWRk0NEISIji91MpaRtHCekvMaGIlmVk05bBQr/cu6yb5HPZNCtAo
         y9vmjpRjg6PqjyBXReyMeKa4P6I1jVx397kWHUBrpfXeHPCVBOfnayoqjV9PsO4pKyvV
         nSN1Ey2unqmR25h5BAk2DwUdIWJwK0UpSKScksxLWI/JJUA+gtLONsgY9dh5ug91AgBl
         kUYqPZ4aKoUGvIZw0CJ7Wam9Yv2BgpWicqW0UvaTDXO5yf1+77D1R79HAZtM/lub/zpH
         Dihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vESVsop4ZB+nxJMme9WqcQCG5NESqBZw6q6kC1WMIIw=;
        b=uaNGuv0kCueUDyzXQZehYBzfpTnPi8wqe0Ey1AjFQPsvgtZe/oyu9Kv/bCXdpCDTq5
         HNDuv5pjeIEiBtiFvJle4y5X5CzmyRqw/lm2Ubj6i1bJtsJHCPhZndLOyNE1iFMM2qCS
         P5S2wnspocCc1s1m0qM7bEf/VNpph898nxSGN02oU1OPPpq9t9kc+uJxHvCUbtq5Fh3l
         03ENcSC7hze7cEB/IJriPgLwSfNLoB9IIjwoaNiWBsAHwpF3vcA/M5vblVhoZw+YH7K1
         uEQTAsxABflJ7eDZoAluqYzv6LZkb6HJBinJ9fv7GxLRa0p1yAV3EkUbq5hYBsKF/M+3
         B7VQ==
X-Gm-Message-State: ACrzQf3PTmgdlqAMd/SbVffsTBkIe+erRT24Km2/JjZTtSVNhJRT2sCR
        2cdWvCqMZU2OtLeSVLiypIs=
X-Google-Smtp-Source: AMsMyM6WTIZNRWCJ/EFiNOK59q4zh1HTLYptlZ44M+of4zld3TkEXXJt5pFrkW6rUJ77EohOyw+8pg==
X-Received: by 2002:a63:fc0b:0:b0:46f:87a8:97aa with SMTP id j11-20020a63fc0b000000b0046f87a897aamr27223139pgi.234.1667531814293;
        Thu, 03 Nov 2022 20:16:54 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id s3-20020a63ff43000000b004702eca61fcsm1078655pgk.36.2022.11.03.20.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 20:16:53 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Helge Deller <deller@gmx.de>, Tony Lindgren <tony@atomide.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH RESEND 04/13] omapfb: encoder-tfp410: switch to using gpiod API
Date:   Thu,  3 Nov 2022 20:16:33 -0700
Message-Id: <20221103-omapfb-gpiod-v1-4-cba1fae5a77c@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221103-omapfb-gpiod-v1-0-cba1fae5a77c@gmail.com>
References: <20221103-omapfb-gpiod-v1-0-cba1fae5a77c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.11.0-dev-28747
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

Switch the driver from legacy gpio API that is deprecated to the newer
gpiod API that respects line polarities described in ACPI/DT.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../fbdev/omap2/omapfb/displays/encoder-tfp410.c   | 67 +++++++---------------
 1 file changed, 22 insertions(+), 45 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/encoder-tfp410.c b/drivers/video/fbdev/omap2/omapfb/displays/encoder-tfp410.c
index 09a59bd93d61..7bac420169a6 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/encoder-tfp410.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/encoder-tfp410.c
@@ -6,11 +6,12 @@
  * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
  */
 
-#include <linux/gpio.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-#include <linux/of_gpio.h>
 
 #include <video/omapfb_dss.h>
 
@@ -18,7 +19,8 @@ struct panel_drv_data {
 	struct omap_dss_device dssdev;
 	struct omap_dss_device *in;
 
-	int pd_gpio;
+	struct gpio_desc *pd_gpio;
+
 	int data_lines;
 
 	struct omap_video_timings timings;
@@ -86,8 +88,8 @@ static int tfp410_enable(struct omap_dss_device *dssdev)
 	if (r)
 		return r;
 
-	if (gpio_is_valid(ddata->pd_gpio))
-		gpio_set_value_cansleep(ddata->pd_gpio, 1);
+	if (ddata->pd_gpio)
+		gpiod_set_value_cansleep(ddata->pd_gpio, 0);
 
 	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 
@@ -102,8 +104,8 @@ static void tfp410_disable(struct omap_dss_device *dssdev)
 	if (!omapdss_device_is_enabled(dssdev))
 		return;
 
-	if (gpio_is_valid(ddata->pd_gpio))
-		gpio_set_value_cansleep(ddata->pd_gpio, 0);
+	if (ddata->pd_gpio)
+		gpiod_set_value_cansleep(ddata->pd_gpio, 1);
 
 	in->ops.dpi->disable(in);
 
@@ -162,33 +164,6 @@ static const struct omapdss_dvi_ops tfp410_dvi_ops = {
 	.get_timings	= tfp410_get_timings,
 };
 
-static int tfp410_probe_of(struct platform_device *pdev)
-{
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
-	struct device_node *node = pdev->dev.of_node;
-	struct omap_dss_device *in;
-	int gpio;
-
-	gpio = of_get_named_gpio(node, "powerdown-gpios", 0);
-
-	if (gpio_is_valid(gpio) || gpio == -ENOENT) {
-		ddata->pd_gpio = gpio;
-	} else {
-		dev_err(&pdev->dev, "failed to parse PD gpio\n");
-		return gpio;
-	}
-
-	in = omapdss_of_find_source_for_first_ep(node);
-	if (IS_ERR(in)) {
-		dev_err(&pdev->dev, "failed to find video source\n");
-		return PTR_ERR(in);
-	}
-
-	ddata->in = in;
-
-	return 0;
-}
-
 static int tfp410_probe(struct platform_device *pdev)
 {
 	struct panel_drv_data *ddata;
@@ -204,18 +179,21 @@ static int tfp410_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ddata);
 
-	r = tfp410_probe_of(pdev);
-	if (r)
+	ddata->pd_gpio = devm_gpiod_get_optional(&pdev->dev, "powerdown",
+						 GPIOD_OUT_HIGH);
+	r = PTR_ERR_OR_ZERO(ddata->pd_gpio);
+	if (r) {
+		dev_err(&pdev->dev, "Failed to request PD GPIO: %d\n", r);
 		return r;
+	}
+
+	gpiod_set_consumer_name(ddata->pd_gpio, "tfp410 PD");
 
-	if (gpio_is_valid(ddata->pd_gpio)) {
-		r = devm_gpio_request_one(&pdev->dev, ddata->pd_gpio,
-				GPIOF_OUT_INIT_LOW, "tfp410 PD");
-		if (r) {
-			dev_err(&pdev->dev, "Failed to request PD GPIO %d\n",
-					ddata->pd_gpio);
-			goto err_gpio;
-		}
+	ddata->in = omapdss_of_find_source_for_first_ep(pdev->dev.of_node);
+	r = PTR_ERR_OR_ZERO(ddata->in);
+	if (r) {
+		dev_err(&pdev->dev, "failed to find video source: %d\n", r);
+		return r;
 	}
 
 	dssdev = &ddata->dssdev;
@@ -235,7 +213,6 @@ static int tfp410_probe(struct platform_device *pdev)
 
 	return 0;
 err_reg:
-err_gpio:
 	omap_dss_put_device(ddata->in);
 	return r;
 }

-- 
b4 0.11.0-dev-28747
