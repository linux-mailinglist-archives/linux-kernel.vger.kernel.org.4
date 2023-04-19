Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC7C6E830D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjDSVI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjDSVIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:08:21 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561AC5B92;
        Wed, 19 Apr 2023 14:08:18 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f09b9ac51dso5342585e9.0;
        Wed, 19 Apr 2023 14:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681938497; x=1684530497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zdLjBTspN0RuBhnqah0NEHAUrMQQgvoP610DrLOri+g=;
        b=XY52PUvumH0PTZvaEV1/fr7g1UkVMtC05AIAq5eHMV5LFD/xgcMRBNeHpY6ASPaLSZ
         BHtzcKU8v50KIpRELZO3PhdrKAe600n956MhFEorvW/Ce3qUWhAdc31XJ0H4TBSEf/Zd
         XTgCyqW58Ca9sTJ6kDJplJzF0zM8THj8gTCLB56DvpK1Pf4BxZxCUb99mzMOU64iM3X7
         7l1mRXsLT7UgmfHo1W8YS8fUG91bTm8HNUDe8qzyZOcbw8kwc8vSXHO0yNhZxMWLM1eb
         u1+UjfBtC7JNOdZxhIkIosOO3M2b03D0Idsx/BzasRrUlyxL/toBykuONZ6Cks6X7g6e
         Hm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681938497; x=1684530497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdLjBTspN0RuBhnqah0NEHAUrMQQgvoP610DrLOri+g=;
        b=Yjk5NMWESRoA2h+5uFWUDAe4B9wAoLE0p0o59mlu7o1a+NUKrgrm8jNGzhreQMKlri
         131oQ0dvb4mO/YFAQYc8pTla/F2r+dGcF06q7P3NZtwHDC729+vhdY4h1fDR78iGxgLp
         S36RLI6Yn1LUV6IxjfS0to7fWGTIMrUu9bKZfjsxa32NdjrGP8vz3mFnuLCHpQCSMHgT
         fSSvZkZNzr2986htMV6mKk/BxhI8Zr7CxUkkdm2hqk2Qy1YLPSBxozawoXuQiuL7W/XU
         XbbprZVAvl3B7waZfGkpVcwUWLZCVIkWrBhfiAjavEMQvpIvcVZ64h4IPCDk5A+XP8lF
         CW9Q==
X-Gm-Message-State: AAQBX9fWM+RYxf2duF8pUsm/xTuSI0q3qcWVRWq5J6/3+08B+gulUNHu
        Jp7oH6s/PU4VBJt8Dkpq4Xw=
X-Google-Smtp-Source: AKy350bEaaOSLvCz7G8pUpiENdyOyibaPzB42vQURZAC51z7wjE2TQeLyyfxmONkxz6YIliU02Tfrw==
X-Received: by 2002:adf:ec4e:0:b0:2fd:c315:bb2c with SMTP id w14-20020adfec4e000000b002fdc315bb2cmr2673603wrn.22.1681938496496;
        Wed, 19 Apr 2023 14:08:16 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id g3-20020a5d5543000000b002fe254f6c33sm81295wrw.92.2023.04.19.14.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:08:16 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Martin Schiller <ms@dev.tdt.de>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 2/5] leds: trigger: netdev: drop NETDEV_LED_MODE_LINKUP from mode
Date:   Wed, 19 Apr 2023 23:07:40 +0200
Message-Id: <20230419210743.3594-3-ansuelsmth@gmail.com>
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

Putting NETDEV_LED_MODE_LINKUP in the same list of the netdev trigger
modes is wrong as it's used to set the link state of the device and not
to set a blink mode as it's done by NETDEV_LED_LINK, NETDEV_LED_TX and
NETDEV_LED_RX. It's also wrong to put this state in the same bitmap of the
netdev trigger mode and should be external to it.

Drop NETDEV_LED_MODE_LINKUP from mode list and convert to a simple bool
that will be true or false based on the carrier link. No functional
change intended.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/leds/trigger/ledtrig-netdev.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index f4d670ec30bc..d5c4e72b8261 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -50,10 +50,10 @@ struct led_netdev_data {
 	unsigned int last_activity;
 
 	unsigned long mode;
+	bool carrier_link_up;
 #define NETDEV_LED_LINK	0
 #define NETDEV_LED_TX	1
 #define NETDEV_LED_RX	2
-#define NETDEV_LED_MODE_LINKUP	3
 };
 
 enum netdev_led_attr {
@@ -73,9 +73,9 @@ static void set_baseline_state(struct led_netdev_data *trigger_data)
 	if (!led_cdev->blink_brightness)
 		led_cdev->blink_brightness = led_cdev->max_brightness;
 
-	if (!test_bit(NETDEV_LED_MODE_LINKUP, &trigger_data->mode))
+	if (!trigger_data->carrier_link_up) {
 		led_set_brightness(led_cdev, LED_OFF);
-	else {
+	} else {
 		if (test_bit(NETDEV_LED_LINK, &trigger_data->mode))
 			led_set_brightness(led_cdev,
 					   led_cdev->blink_brightness);
@@ -131,10 +131,9 @@ static ssize_t device_name_store(struct device *dev,
 		trigger_data->net_dev =
 		    dev_get_by_name(&init_net, trigger_data->device_name);
 
-	clear_bit(NETDEV_LED_MODE_LINKUP, &trigger_data->mode);
+	trigger_data->carrier_link_up = false;
 	if (trigger_data->net_dev != NULL)
-		if (netif_carrier_ok(trigger_data->net_dev))
-			set_bit(NETDEV_LED_MODE_LINKUP, &trigger_data->mode);
+		trigger_data->carrier_link_up = netif_carrier_ok(trigger_data->net_dev);
 
 	trigger_data->last_activity = 0;
 
@@ -315,11 +314,10 @@ static int netdev_trig_notify(struct notifier_block *nb,
 
 	spin_lock_bh(&trigger_data->lock);
 
-	clear_bit(NETDEV_LED_MODE_LINKUP, &trigger_data->mode);
+	trigger_data->carrier_link_up = false;
 	switch (evt) {
 	case NETDEV_CHANGENAME:
-		if (netif_carrier_ok(dev))
-			set_bit(NETDEV_LED_MODE_LINKUP, &trigger_data->mode);
+		trigger_data->carrier_link_up = netif_carrier_ok(dev);
 		fallthrough;
 	case NETDEV_REGISTER:
 		if (trigger_data->net_dev)
@@ -333,8 +331,7 @@ static int netdev_trig_notify(struct notifier_block *nb,
 		break;
 	case NETDEV_UP:
 	case NETDEV_CHANGE:
-		if (netif_carrier_ok(dev))
-			set_bit(NETDEV_LED_MODE_LINKUP, &trigger_data->mode);
+		trigger_data->carrier_link_up = netif_carrier_ok(dev);
 		break;
 	}
 
-- 
2.39.2

