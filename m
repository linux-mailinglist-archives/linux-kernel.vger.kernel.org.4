Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B13632276
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiKUMkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiKUMjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:39:40 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80F629C9E;
        Mon, 21 Nov 2022 04:39:32 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 793355FD0A;
        Mon, 21 Nov 2022 15:39:30 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669034370;
        bh=Rj/rYCPzREnMvfpm/+WyfOnp58T9LOfDCyiLf96HgW8=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=Tc+QqEUNAGf3MphsbdlqbV7Kf1uvvSL8AcCZCm1Lg/kCHMuCzY2sV/IrJDSXlPHkn
         cA0JSrnMCMBzj77wHzH3gcpEzbGCb8mwZQQa9nc54BXlBLwEd7lFzNUeHclclylw0Q
         dl1q2f4IMIhbElj8UVu8dVqv846svZHSNa7NsCYfqSHAISQZRt6aRu+h0aKz+vSsiv
         zBbISmm5uT5jcyNislHdUXlm1AGduBnUM5iRCysuobvPSAY6d8JBiQp2NeCcm2sECd
         LJ3vnOznTHhj4mq5AO68hOLAOHcluWsDT/N6FPBAu7vDc7Dkq1w3g/l+5k3QRXwieo
         XqGnPcQqe3c0w==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 21 Nov 2022 15:39:30 +0300 (MSK)
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
To:     Pavel Machek <pavel@ucw.cz>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <kernel@sberdevices.ru>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: [PATCH v2 1/2] leds: trigger: pattern: minor code style changes
Date:   Mon, 21 Nov 2022 15:38:32 +0300
Message-ID: <20221121123833.164614-2-mmkurbanov@sberdevices.ru>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221121123833.164614-1-mmkurbanov@sberdevices.ru>
References: <20221121123833.164614-1-mmkurbanov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/11/21 03:43:00 #20593185
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds some minor code style changes:
    - remove a blank line before DEVICE_ATTR_RW declarations
    - convert sysfs scnprintf() to sysfs_emit()/sysfs_emit_at()
    - use module_led_trigger instead of pattern_trig_init/exit

Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
---
 drivers/leds/trigger/ledtrig-pattern.c | 29 +++++++-------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
index 43a265dc4696..354304b404aa 100644
--- a/drivers/leds/trigger/ledtrig-pattern.c
+++ b/drivers/leds/trigger/ledtrig-pattern.c
@@ -155,7 +155,7 @@ static ssize_t repeat_show(struct device *dev, struct device_attribute *attr,
 
 	mutex_unlock(&data->lock);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", repeat);
+	return sysfs_emit(buf, "%d\n", repeat);
 }
 
 static ssize_t repeat_store(struct device *dev, struct device_attribute *attr,
@@ -192,7 +192,6 @@ static ssize_t repeat_store(struct device *dev, struct device_attribute *attr,
 	mutex_unlock(&data->lock);
 	return err < 0 ? err : count;
 }
-
 static DEVICE_ATTR_RW(repeat);
 
 static ssize_t pattern_trig_show_patterns(struct pattern_trig_data *data,
@@ -207,13 +206,13 @@ static ssize_t pattern_trig_show_patterns(struct pattern_trig_data *data,
 		goto out;
 
 	for (i = 0; i < data->npatterns; i++) {
-		count += scnprintf(buf + count, PAGE_SIZE - count,
-				   "%d %u ",
-				   data->patterns[i].brightness,
-				   data->patterns[i].delta_t);
+		count += sysfs_emit_at(buf, count,
+				       "%d %u ",
+				       data->patterns[i].brightness,
+				       data->patterns[i].delta_t);
 	}
 
-	buf[count - 1] = '\n';
+	sysfs_emit_at(buf, count - 1, "\n");
 
 out:
 	mutex_unlock(&data->lock);
@@ -307,7 +306,6 @@ static ssize_t pattern_store(struct device *dev, struct device_attribute *attr,
 
 	return pattern_trig_store_patterns(led_cdev, buf, NULL, count, false);
 }
-
 static DEVICE_ATTR_RW(pattern);
 
 static ssize_t hw_pattern_show(struct device *dev,
@@ -327,7 +325,6 @@ static ssize_t hw_pattern_store(struct device *dev,
 
 	return pattern_trig_store_patterns(led_cdev, buf, NULL, count, true);
 }
-
 static DEVICE_ATTR_RW(hw_pattern);
 
 static umode_t pattern_trig_attrs_mode(struct kobject *kobj,
@@ -443,19 +440,7 @@ static struct led_trigger pattern_led_trigger = {
 	.deactivate = pattern_trig_deactivate,
 	.groups = pattern_trig_groups,
 };
-
-static int __init pattern_trig_init(void)
-{
-	return led_trigger_register(&pattern_led_trigger);
-}
-
-static void __exit pattern_trig_exit(void)
-{
-	led_trigger_unregister(&pattern_led_trigger);
-}
-
-module_init(pattern_trig_init);
-module_exit(pattern_trig_exit);
+module_led_trigger(pattern_led_trigger);
 
 MODULE_AUTHOR("Raphael Teysseyre <rteysseyre@gmail.com>");
 MODULE_AUTHOR("Baolin Wang <baolin.wang@linaro.org>");
-- 
2.38.1

