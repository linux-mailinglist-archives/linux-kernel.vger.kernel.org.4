Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB25603810
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 04:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiJSC1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 22:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiJSC0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 22:26:52 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB56E4C10;
        Tue, 18 Oct 2022 19:26:35 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id z20so15584080plb.10;
        Tue, 18 Oct 2022 19:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4eDabs5ds3HN+Dw1AO0a7/aaQbz0TURtGiXRDiwDf/c=;
        b=PCzeVBDwLTM7hLK6S5F54unWpYpaq5tpRmZOEvUeCsc9p990aR18peUX6VII6nsYhT
         +Bvdnq55ERrSRtEEJ9zFqdtvngRrq1VNrF7AmpRe8uv/6j1JlXGizaFL5XE+6eFBTye8
         cB1A158SnFNgN6cIqxxkhVzVcEQWS93CRGn9pbrvwtirhVg2HKYlHbxOnNI6BzoB8TY/
         HIgqBp+90Q1fXDMgtDo8bCJNwy/YeDQR2IFP5IWiGqKzE+/WiyrPSy3fgE1sqAbrWjvX
         6TA1PTX6oIStp2UJc+J/TUVU9DW2s56llXJ56wpCctWBZmIodKuivsHRvpYfjvAht1w/
         asew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4eDabs5ds3HN+Dw1AO0a7/aaQbz0TURtGiXRDiwDf/c=;
        b=aSSc7bUzH9rTSDIW6fWRvjYsYfnazOQv9MkVAU0UqX3G2OHCzyC/9K/MR7oS2aRoV5
         4/HbqWO260TXC7xAg7zQ+JsUaCzC6wgMa5THOo/nzF0+SfxfQwYXMlkhOnZNRDdIcl+w
         9ck5JqStI73Wi7xoWfesjQ1i58GmCqv27HsZrb0wwwqf4AS5X9TudzriA7ESAjEAjzJ2
         GqMbMgMfjOiIs+fBi8GsHiyVqMNbwU2aLGqJaCY+AQNEc6/nHdwTtzKwgMonoRiGtL6M
         r5fYmrmnk6xxvuaT20d4K9KDTHY9hOgLeJjCy/cGXVx24AnO/WDArSwNWa9O4FCcvLZk
         1S8g==
X-Gm-Message-State: ACrzQf3pq6HbkwC/ma8h/Lb0AA1t+LRWKMraSs9Xgr4INRvT6j2wlHLg
        GWYIea6oY4X2LbamTnzoRQ==
X-Google-Smtp-Source: AMsMyM4r9BTHgqjCZHSZKmIKp31Mei7r0gr8CHYAoMHUo2zYKARogePbh21KC3V/n6xwjmwPCWDKlw==
X-Received: by 2002:a17:90b:1c0a:b0:20d:823b:dfd3 with SMTP id oc10-20020a17090b1c0a00b0020d823bdfd3mr43116513pjb.81.1666146393672;
        Tue, 18 Oct 2022 19:26:33 -0700 (PDT)
Received: from localhost.localdomain ([106.104.115.142])
        by smtp.gmail.com with ESMTPSA id x185-20020a6263c2000000b00562a526cd2esm9855880pfb.55.2022.10.18.19.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 19:26:33 -0700 (PDT)
From:   chengwei <foxfly.lai.tw@gmail.com>
X-Google-Original-From: chengwei <larry.lai@yunjingtech.com>
To:     lee@kernel.org, broonie@kernel.org, rafael@kernel.org,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        chengwei <larry.lai@yunjingtech.com>
Subject: [PATCH 4/5] GPIO ACPI: Add support to map GPIO resources to ranges
Date:   Wed, 19 Oct 2022 10:24:49 +0800
Message-Id: <20221019022450.16851-5-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221019022450.16851-1-larry.lai@yunjingtech.com>
References: <20221019022450.16851-1-larry.lai@yunjingtech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function to gpiolib to facilitate registering a pin controller for
a range of GPIO pins, but using ACPI resource references and without
claiming the GPIO resource.

Signed-off-by: chengwei <larry.lai@yunjingtech.com>
---
 drivers/gpio/gpiolib-acpi.c | 88 ++++++++++++++++++++++++++++++-------
 1 file changed, 71 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 9be1376f9a62..d25c6cb610e3 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1385,6 +1385,32 @@ static int acpi_find_gpio_count(struct acpi_resource *ares, void *data)
 	return 1;
 }
 
+static int acpi_gpio_count_from_property(struct acpi_device *adev,
+					 const char *propname)
+{
+	const struct acpi_gpio_mapping *gm;
+	const union acpi_object *obj;
+	int count = -ENOENT;
+	int ret;
+
+	ret = acpi_dev_get_property(adev, propname, ACPI_TYPE_ANY,
+				    &obj);
+	if (ret == 0) {
+		if (obj->type == ACPI_TYPE_LOCAL_REFERENCE)
+			count = 1;
+		else if (obj->type == ACPI_TYPE_PACKAGE)
+			count = acpi_gpio_package_count(obj);
+	} else if (adev->driver_gpios) {
+		for (gm = adev->driver_gpios; gm->name; gm++)
+			if (strcmp(propname, gm->name) == 0) {
+				count = gm->size;
+				break;
+			}
+	}
+
+	return count;
+}
+
 /**
  * acpi_gpio_count - count the GPIOs associated with a device / function
  * @dev:	GPIO consumer, can be %NULL for system-global GPIOs
@@ -1397,10 +1423,7 @@ static int acpi_find_gpio_count(struct acpi_resource *ares, void *data)
 int acpi_gpio_count(struct device *dev, const char *con_id)
 {
 	struct acpi_device *adev = ACPI_COMPANION(dev);
-	const union acpi_object *obj;
-	const struct acpi_gpio_mapping *gm;
 	int count = -ENOENT;
-	int ret;
 	char propname[32];
 	unsigned int i;
 
@@ -1413,20 +1436,7 @@ int acpi_gpio_count(struct device *dev, const char *con_id)
 			snprintf(propname, sizeof(propname), "%s",
 				 gpio_suffixes[i]);
 
-		ret = acpi_dev_get_property(adev, propname, ACPI_TYPE_ANY,
-					    &obj);
-		if (ret == 0) {
-			if (obj->type == ACPI_TYPE_LOCAL_REFERENCE)
-				count = 1;
-			else if (obj->type == ACPI_TYPE_PACKAGE)
-				count = acpi_gpio_package_count(obj);
-		} else if (adev->driver_gpios) {
-			for (gm = adev->driver_gpios; gm->name; gm++)
-				if (strcmp(propname, gm->name) == 0) {
-					count = gm->size;
-					break;
-				}
-		}
+		count = acpi_gpio_count_from_property(adev, propname);
 		if (count > 0)
 			break;
 	}
@@ -1449,6 +1459,50 @@ int acpi_gpio_count(struct device *dev, const char *con_id)
 	return count ? count : -ENOENT;
 }
 
+/**
+ * acpi_node_add_pin_mapping - add a pin mapping for named GPIO resources
+ * @fwnode: pointer to an ACPI firmware node to get the GPIO information from
+ * @propname: Property name of the GPIO
+ * @pinctrl_name: the dev_name() of the pin controller to map to
+ * @pin_offset: the start offset in the pin controller number space
+ * @npins: the maximum number of pins from the offset of each pin space (GPIO
+ *         and pin controller) to map
+ *
+ * Lookup the GPIO resources and map them individually to the specified pins.
+ */
+int acpi_node_add_pin_mapping(struct fwnode_handle *fwnode,
+			      const char *propname,
+			      const char *pinctl_name,
+			      unsigned int pin_offset,
+			      unsigned int npins)
+{
+	struct acpi_device *adev = to_acpi_device_node(fwnode);
+	int count, i;
+
+	count = acpi_gpio_count_from_property(adev, propname);
+	if (count < 0)
+		return count;
+
+	for (i = 0; i < count && i < npins; i++) {
+		struct gpio_desc *desc;
+		int ret;
+
+		desc = acpi_node_get_gpiod(fwnode, propname, i, NULL);
+		if (IS_ERR(desc))
+			return PTR_ERR(desc);
+
+		/* The GPIOs may not be contiguous, so add them 1-by-1 */
+		ret = gpiochip_add_pin_range(gpiod_to_chip(desc), pinctl_name,
+					     gpio_chip_hwgpio(desc),
+					     pin_offset + i, 1);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(acpi_node_add_pin_mapping);
+
 /* Run deferred acpi_gpiochip_request_irqs() */
 static int __init acpi_gpio_handle_deferred_request_irqs(void)
 {
-- 
2.17.1

