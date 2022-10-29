Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA35611ED1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 02:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJ2AyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 20:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJ2AyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 20:54:06 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35901AFA97;
        Fri, 28 Oct 2022 17:54:05 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id x13so5151959qvn.6;
        Fri, 28 Oct 2022 17:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=EusSo/p3BKtiGbC/ZHm4yuPM5rgXDVCJOfRp7hcyVL0=;
        b=BjPRGbJrXrkI4GSls3ex8AXtwiUAz475vrmRxv8lGZQIwmABkLry0KqaI3pxTnuR9F
         o79kt2zbH2I6UmaMIh0eBbBg3CWR3ONnAdIscLIf4SeY5ahqOCr3AwXybYVLACi2MhX/
         VqKhWgVgyyx/Ajxp801awIN/2PEuRO6LPfRLYkoKmEjG+NCoQIYST2wGkFm+wadQDt0n
         DWZDu3GWgAE+HWKW0AWYy3y+uzPOGwKsHfZBgsgDa9j3lqHH0HpfKUXD1vVix4e2iZPA
         xDyW10LzZVLKE72o5hxswTjvQzu34Y+IJRg4SNWuopC+TfRUyhPAmOME6GIHq0hdOYL0
         qkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EusSo/p3BKtiGbC/ZHm4yuPM5rgXDVCJOfRp7hcyVL0=;
        b=IPaOb3SUGp2BEDcFSnp2Kah921c5DmkQ9SATQxQk+KNS8Tvj/RxaEmdQWZB+iGdcUb
         OKcowxgjyIMfbNjMWwwJxfOEE5Sz6SBcbrVy3WoveJ60GoDIPWJwte5cMVPaRAwLE0la
         J+uvHxLAV6lU/y7kDIeMjG6d0v+TnvDgXmmMCx3lQO4cTxC1H3iRTwn9qWU7GzyHk9Ut
         2dFHktS3mjGQTHQGKM+rpnoezIxy8TP8TmuMkAqwQQrE1U19kG5j/ZFGjDRI1YYdQC6k
         FFWBvVGrBQzH6gofTO+tMWD48np4MfpxH8uXpDvdVst8bYv8qTLHjcqmK0ZwGhITD9qd
         Bh/A==
X-Gm-Message-State: ACrzQf1e7WQftJePkf2Mojy0E+04hIUoD1zHQ2FyXmRYJjSmWPbYRJ9q
        2YiOymAQX6khlSoMVKB3APZ6A98jxRA=
X-Google-Smtp-Source: AMsMyM5yLnEPfW3W9rizu5gbKqgGEVmNI+R8PFCSBTnddUgw09TPfDCbXM+5kstLxKKQ9rQHZyAzNw==
X-Received: by 2002:ad4:5b8b:0:b0:4bb:a86e:d7b4 with SMTP id 11-20020ad45b8b000000b004bba86ed7b4mr1951782qvp.108.1667004844848;
        Fri, 28 Oct 2022 17:54:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x18-20020a05620a259200b006bc192d277csm163388qko.10.2022.10.28.17.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 17:54:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Benson Leung <bleung@chromium.org>, linux-rtc@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] rtc: cros-ec: Limit RTC alarm range if needed
Date:   Fri, 28 Oct 2022 17:54:00 -0700
Message-Id: <20221029005400.2712577-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.36.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RTC chips on some older Chromebooks can only handle alarms less than 24
hours in the future. Attempts to set an alarm beyond that range fails.
The most severe impact of this limitation is that suspend requests fail
if alarmtimer_suspend() tries to set an alarm for more than 24 hours
in the future.

Try to set the real-time alarm to just below 24 hours if setting it to
a larger value fails to work around the problem. While not perfect, it
is better than just failing the call. A similar workaround is already
implemented in the rtc-tps6586x driver.

Drop error messages in cros_ec_rtc_get() and cros_ec_rtc_set() since the
calling code also logs an error and to avoid spurious error messages if
setting the alarm ultimately succeeds.

Cc: Brian Norris <briannorris@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/rtc/rtc-cros-ec.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/rtc/rtc-cros-ec.c b/drivers/rtc/rtc-cros-ec.c
index 887f5193e253..a3ec066d8066 100644
--- a/drivers/rtc/rtc-cros-ec.c
+++ b/drivers/rtc/rtc-cros-ec.c
@@ -14,6 +14,8 @@
 
 #define DRV_NAME	"cros-ec-rtc"
 
+#define SECS_PER_DAY	(24 * 60 * 60)
+
 /**
  * struct cros_ec_rtc - Driver data for EC RTC
  *
@@ -43,13 +45,8 @@ static int cros_ec_rtc_get(struct cros_ec_device *cros_ec, u32 command,
 	msg.msg.insize = sizeof(msg.data);
 
 	ret = cros_ec_cmd_xfer_status(cros_ec, &msg.msg);
-	if (ret < 0) {
-		dev_err(cros_ec->dev,
-			"error getting %s from EC: %d\n",
-			command == EC_CMD_RTC_GET_VALUE ? "time" : "alarm",
-			ret);
+	if (ret < 0)
 		return ret;
-	}
 
 	*response = msg.data.time;
 
@@ -59,7 +56,7 @@ static int cros_ec_rtc_get(struct cros_ec_device *cros_ec, u32 command,
 static int cros_ec_rtc_set(struct cros_ec_device *cros_ec, u32 command,
 			   u32 param)
 {
-	int ret = 0;
+	int ret;
 	struct {
 		struct cros_ec_command msg;
 		struct ec_response_rtc data;
@@ -71,13 +68,8 @@ static int cros_ec_rtc_set(struct cros_ec_device *cros_ec, u32 command,
 	msg.data.time = param;
 
 	ret = cros_ec_cmd_xfer_status(cros_ec, &msg.msg);
-	if (ret < 0) {
-		dev_err(cros_ec->dev, "error setting %s on EC: %d\n",
-			command == EC_CMD_RTC_SET_VALUE ? "time" : "alarm",
-			ret);
+	if (ret < 0)
 		return ret;
-	}
-
 	return 0;
 }
 
@@ -190,8 +182,21 @@ static int cros_ec_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	ret = cros_ec_rtc_set(cros_ec, EC_CMD_RTC_SET_ALARM, alarm_offset);
 	if (ret < 0) {
-		dev_err(dev, "error setting alarm: %d\n", ret);
-		return ret;
+		if (ret == -EINVAL && alarm_offset >= SECS_PER_DAY) {
+			/*
+			 * RTC chips on some older Chromebooks can only handle
+			 * alarms up to 24h in the future. Try to set an alarm
+			 * below that limit to avoid suspend failures.
+			 */
+			ret = cros_ec_rtc_set(cros_ec, EC_CMD_RTC_SET_ALARM,
+					      SECS_PER_DAY - 1);
+		}
+
+		if (ret < 0) {
+			dev_err(dev, "error setting alarm in %u seconds: %d\n",
+				alarm_offset, ret);
+			return ret;
+		}
 	}
 
 	return 0;
-- 
2.36.2

