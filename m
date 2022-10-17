Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB4C600FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiJQNJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiJQNJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:09:27 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB48CC3;
        Mon, 17 Oct 2022 06:09:21 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id z11-20020a05683020cb00b00661a95cf920so5725294otq.5;
        Mon, 17 Oct 2022 06:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7gIDtWIHqMTwWV4LzsKahvW+VVqbbSVkDc0k/BhZ2M=;
        b=czrn5SBzra+2vmL0/mlbIauObwnFQTqCJaEQpupceqA7PsF3Z3DY+Gg+RLYPvfgtqy
         yZlMnvj2YttPutzMJiywMITS3MORb1lQmTmnr/SFE2WSANfXP89Hubaq/LxllgxzDvJy
         /9Mse0S+bSSXRVqi5ByMyKIXFpjlMLqiWavHiVyugJJMj8SM8YytKo8VtQu8dJLwtluw
         aVxznfyR3xBptDMTA9vOSEw+rTAqK+Bno+Md/pe1igq9a48CQH0347EXb2W+dK7w6RO3
         H4LBp4nLqJqQXOsrEA41b0aLBrUlNSCgEE6ojLlvLot/UiDQGrEmUmvkx7yAf8RKk1Bb
         Hvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X7gIDtWIHqMTwWV4LzsKahvW+VVqbbSVkDc0k/BhZ2M=;
        b=1VK8EHso5WimoeHAmV2tfpRxsR/cV8FdRD6d4ulCfPBmAM0Fj503s92iRajQAM1sx9
         Y0BYK8DXrePB+ce5B7tCMdsmW6BAlzFLyviatvs3nNw9Ce+HF6piPYUiEI5p2y3xYl6z
         wmvxADgCMA9U8d9MCeETRo3b2rfhMh8HZENXPkq4GbNecoKgzvjcOnG+DT3tQzW2PL70
         YleP4NGFSAVLkSoUtS4cTXV9kCalOXSc9rwfIincZktA59j4+w5usPonQy0ZEn8EuSJj
         Qd2UGdjDFnQdsLkMyNMb056pcZH1SvcSuDKiPH2FboTK1uEGAZuwB9wtCYsXD95Hv4uY
         ARvg==
X-Gm-Message-State: ACrzQf3qggd06li9vKvizKdyC1oogcygYFGI4lb3ATxSNIHtl3/lo37I
        zn5VodP0U/bDkcGj3eymoutp6ZKUFQo=
X-Google-Smtp-Source: AMsMyM7I3eSkOaftJMZWj1OQmwlLXIhukk6su53pYrvNfJ6W82EKgEy8HYuSgBoO38qBuTlt9AWlEw==
X-Received: by 2002:a05:6830:314f:b0:661:ba49:d842 with SMTP id c15-20020a056830314f00b00661ba49d842mr5075426ots.129.1666012161013;
        Mon, 17 Oct 2022 06:09:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f4-20020a05680814c400b003458d346a60sm4241890oiw.25.2022.10.17.06.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 06:09:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5/9] thermal/core: Introduce locked version of thermal_zone_device_update
Date:   Mon, 17 Oct 2022 06:09:06 -0700
Message-Id: <20221017130910.2307118-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.36.2
In-Reply-To: <20221017130910.2307118-1-linux@roeck-us.net>
References: <20221017130910.2307118-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In thermal_zone_device_set_mode(), the thermal zone mutex is released only
to be reacquired in the subsequent call to thermal_zone_device_update().

Introduce __thermal_zone_device_update() as locked version of
thermal_zone_device_update() and call it from
thermal_zone_device_set_mode() without releasing the lock to avoid
the extra release/acuire sequence.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/thermal/thermal_core.c | 57 ++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 562ece8d16aa..9facd9c5b70f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -403,6 +403,34 @@ static void thermal_zone_device_init(struct thermal_zone_device *tz)
 		pos->initialized = false;
 }
 
+static void __thermal_zone_device_update(struct thermal_zone_device *tz,
+					 enum thermal_notify_event event)
+{
+	int count;
+
+	if (atomic_read(&in_suspend))
+		return;
+
+	if (WARN_ONCE(!tz->ops->get_temp,
+		      "'%s' must not be called without 'get_temp' ops set\n",
+		      __func__))
+		return;
+
+	if (!thermal_zone_device_is_enabled(tz))
+		return;
+
+	update_temperature(tz);
+
+	__thermal_zone_set_trips(tz);
+
+	tz->notify_event = event;
+
+	for (count = 0; count < tz->num_trips; count++)
+		handle_thermal_trip(tz, count);
+
+	monitor_thermal_zone(tz);
+}
+
 static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 					enum thermal_device_mode mode)
 {
@@ -423,9 +451,9 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 	if (!ret)
 		tz->mode = mode;
 
-	mutex_unlock(&tz->lock);
+	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+	mutex_unlock(&tz->lock);
 
 	if (mode == THERMAL_DEVICE_ENABLED)
 		thermal_notify_tz_enable(tz->id);
@@ -457,31 +485,8 @@ int thermal_zone_device_is_enabled(struct thermal_zone_device *tz)
 void thermal_zone_device_update(struct thermal_zone_device *tz,
 				enum thermal_notify_event event)
 {
-	int count;
-
-	if (atomic_read(&in_suspend))
-		return;
-
-	if (WARN_ONCE(!tz->ops->get_temp, "'%s' must not be called without "
-		      "'get_temp' ops set\n", __func__))
-		return;
-
 	mutex_lock(&tz->lock);
-
-	if (!thermal_zone_device_is_enabled(tz))
-		goto out;
-
-	update_temperature(tz);
-
-	__thermal_zone_set_trips(tz);
-
-	tz->notify_event = event;
-
-	for (count = 0; count < tz->num_trips; count++)
-		handle_thermal_trip(tz, count);
-
-	monitor_thermal_zone(tz);
-out:
+	__thermal_zone_device_update(tz, event);
 	mutex_unlock(&tz->lock);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
-- 
2.36.2

