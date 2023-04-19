Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE926E830F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjDSVIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjDSVIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:08:22 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FAE5FE9;
        Wed, 19 Apr 2023 14:08:19 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-2f27a9c7970so88747f8f.2;
        Wed, 19 Apr 2023 14:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681938497; x=1684530497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UWkT+7LRJWQ8bpRRwkMgFCGb6v8FL0qHRIWzFrJQLXk=;
        b=SMw5Ls8SSt+Wgz/35nbwRhrr1IRC9NCsVAgHqzId2Q2Q66ZwemapLVpc9xCIplBK7D
         ysKvz4LpgAcmZSWHFbyUuN9iTn2fw3KdXdkdWRD2U01gPom6ExvOUv7JJL2NWbLoqbNv
         aCYLiTGE8l+Fw6jji/nnVFb9UnX4/QoOBazFmahiwO0QxaPoKZa+VhE7x2dCQQKtVUxd
         Q/tcaX7g3CD6XUAprb0YMCNcQr3mys1Cj0kYe6OVAzvTu0UnDNhFA6bCO+PbeItDE5m5
         dLJT/j6+ixMW4ekAk9liEIUpQkaf1TZVdfHGu5iHAa49xXDWxg7WNa98OkfSim0yzTZz
         qhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681938497; x=1684530497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWkT+7LRJWQ8bpRRwkMgFCGb6v8FL0qHRIWzFrJQLXk=;
        b=RymRrdwrRBL5OA625DLAV7cA5dikjJdKj/8sai1jA618kanN6OzKtQoyUIaBVT2u+K
         1Q9PfXhmFEVb2S3WCwEdvNjoPw4TsoCyrLJtYc92VPPVXiHMTTVcoUxQD1zbMZDE6QEZ
         3vSv+xF14M13bXRVXlwJGXvDmttCvziYz8qCP9UnG9bUrjby0M+b9l1zYBBhcVchccri
         wM6XsJHyNKP7m295DT1PhEz7cKM+PwfYJ4z8gyROfYvnd/13UT4W5z5fsicC8A5p9phw
         N0RqkjPNY4g8gFQU+ltbnHq32LDBNHyox2o4HMjD/FQPOcJMg+eRPa9NiVKHFDL4OzkY
         MvVQ==
X-Gm-Message-State: AAQBX9cYTI0IGNsqwr/zSYPbRiBuqDZFYuhwGyG11Uw4cUscBPRzne7W
        O895dPQk8LfUVxVWQa54WTU=
X-Google-Smtp-Source: AKy350YM7Q6SguYMpI9RXs1IOc6yjOX3oNSYaa0Tqv5dZvv+eWrVVEpR7HNplAEcQ5tTueuUBUL1Rw==
X-Received: by 2002:adf:f787:0:b0:2fb:db79:748e with SMTP id q7-20020adff787000000b002fbdb79748emr6076779wrp.65.1681938497523;
        Wed, 19 Apr 2023 14:08:17 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id g3-20020a5d5543000000b002fe254f6c33sm81295wrw.92.2023.04.19.14.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:08:17 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Martin Schiller <ms@dev.tdt.de>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 3/5] leds: trigger: netdev: rename add namespace to netdev trigger enum modes
Date:   Wed, 19 Apr 2023 23:07:41 +0200
Message-Id: <20230419210743.3594-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230419210743.3594-1-ansuelsmth@gmail.com>
References: <20230419210743.3594-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename NETDEV trigger enum modes to a more symbolic name and add a
namespace to them.

Also add __TRIGGER_NETDEV_MAX to identify the max modes of the netdev
trigger.

This is a cleanup to drop the define and no behaviour change are
intended.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/leds/trigger/ledtrig-netdev.c | 58 ++++++++++++---------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index d5c4e72b8261..0d4649e7a84d 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -51,15 +51,15 @@ struct led_netdev_data {
 
 	unsigned long mode;
 	bool carrier_link_up;
-#define NETDEV_LED_LINK	0
-#define NETDEV_LED_TX	1
-#define NETDEV_LED_RX	2
 };
 
-enum netdev_led_attr {
-	NETDEV_ATTR_LINK,
-	NETDEV_ATTR_TX,
-	NETDEV_ATTR_RX
+enum led_trigger_netdev_modes {
+	TRIGGER_NETDEV_LINK = 0,
+	TRIGGER_NETDEV_TX,
+	TRIGGER_NETDEV_RX,
+
+	/* keep last */
+	__TRIGGER_NETDEV_MAX,
 };
 
 static void set_baseline_state(struct led_netdev_data *trigger_data)
@@ -76,7 +76,7 @@ static void set_baseline_state(struct led_netdev_data *trigger_data)
 	if (!trigger_data->carrier_link_up) {
 		led_set_brightness(led_cdev, LED_OFF);
 	} else {
-		if (test_bit(NETDEV_LED_LINK, &trigger_data->mode))
+		if (test_bit(TRIGGER_NETDEV_LINK, &trigger_data->mode))
 			led_set_brightness(led_cdev,
 					   led_cdev->blink_brightness);
 		else
@@ -85,8 +85,8 @@ static void set_baseline_state(struct led_netdev_data *trigger_data)
 		/* If we are looking for RX/TX start periodically
 		 * checking stats
 		 */
-		if (test_bit(NETDEV_LED_TX, &trigger_data->mode) ||
-		    test_bit(NETDEV_LED_RX, &trigger_data->mode))
+		if (test_bit(TRIGGER_NETDEV_TX, &trigger_data->mode) ||
+		    test_bit(TRIGGER_NETDEV_RX, &trigger_data->mode))
 			schedule_delayed_work(&trigger_data->work, 0);
 	}
 }
@@ -146,20 +146,16 @@ static ssize_t device_name_store(struct device *dev,
 static DEVICE_ATTR_RW(device_name);
 
 static ssize_t netdev_led_attr_show(struct device *dev, char *buf,
-	enum netdev_led_attr attr)
+				    enum led_trigger_netdev_modes attr)
 {
 	struct led_netdev_data *trigger_data = led_trigger_get_drvdata(dev);
 	int bit;
 
 	switch (attr) {
-	case NETDEV_ATTR_LINK:
-		bit = NETDEV_LED_LINK;
-		break;
-	case NETDEV_ATTR_TX:
-		bit = NETDEV_LED_TX;
-		break;
-	case NETDEV_ATTR_RX:
-		bit = NETDEV_LED_RX;
+	case TRIGGER_NETDEV_LINK:
+	case TRIGGER_NETDEV_TX:
+	case TRIGGER_NETDEV_RX:
+		bit = attr;
 		break;
 	default:
 		return -EINVAL;
@@ -169,7 +165,7 @@ static ssize_t netdev_led_attr_show(struct device *dev, char *buf,
 }
 
 static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
-	size_t size, enum netdev_led_attr attr)
+				     size_t size, enum led_trigger_netdev_modes attr)
 {
 	struct led_netdev_data *trigger_data = led_trigger_get_drvdata(dev);
 	unsigned long state;
@@ -181,14 +177,10 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 		return ret;
 
 	switch (attr) {
-	case NETDEV_ATTR_LINK:
-		bit = NETDEV_LED_LINK;
-		break;
-	case NETDEV_ATTR_TX:
-		bit = NETDEV_LED_TX;
-		break;
-	case NETDEV_ATTR_RX:
-		bit = NETDEV_LED_RX;
+	case TRIGGER_NETDEV_LINK:
+	case TRIGGER_NETDEV_TX:
+	case TRIGGER_NETDEV_RX:
+		bit = attr;
 		break;
 	default:
 		return -EINVAL;
@@ -360,21 +352,21 @@ static void netdev_trig_work(struct work_struct *work)
 	}
 
 	/* If we are not looking for RX/TX then return  */
-	if (!test_bit(NETDEV_LED_TX, &trigger_data->mode) &&
-	    !test_bit(NETDEV_LED_RX, &trigger_data->mode))
+	if (!test_bit(TRIGGER_NETDEV_TX, &trigger_data->mode) &&
+	    !test_bit(TRIGGER_NETDEV_RX, &trigger_data->mode))
 		return;
 
 	dev_stats = dev_get_stats(trigger_data->net_dev, &temp);
 	new_activity =
-	    (test_bit(NETDEV_LED_TX, &trigger_data->mode) ?
+	    (test_bit(TRIGGER_NETDEV_TX, &trigger_data->mode) ?
 		dev_stats->tx_packets : 0) +
-	    (test_bit(NETDEV_LED_RX, &trigger_data->mode) ?
+	    (test_bit(TRIGGER_NETDEV_RX, &trigger_data->mode) ?
 		dev_stats->rx_packets : 0);
 
 	if (trigger_data->last_activity != new_activity) {
 		led_stop_software_blink(trigger_data->led_cdev);
 
-		invert = test_bit(NETDEV_LED_LINK, &trigger_data->mode);
+		invert = test_bit(TRIGGER_NETDEV_LINK, &trigger_data->mode);
 		interval = jiffies_to_msecs(
 				atomic_read(&trigger_data->interval));
 		/* base state is ON (link present) */
-- 
2.39.2

