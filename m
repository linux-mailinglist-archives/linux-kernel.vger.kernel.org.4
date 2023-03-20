Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6DC6C2388
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjCTVWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjCTVWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:22:07 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5F62CC41;
        Mon, 20 Mar 2023 14:22:02 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w9so52282514edc.3;
        Mon, 20 Mar 2023 14:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1679347321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JKZyZ9UtP1ZZ748rC6wje4ZjvZJKdAV8kDbH4x8qqR8=;
        b=fOB38sbMMg7Xpl15jekHcEJ9v8TQ8siGqWnC9c3X7uj6+6zlhsGZjTasrkL8MsS8mC
         NRGmE3o6J9eIQBSoY/Gm/L5qD/B363AagucxmVfmmEUd4NG+LWtzX5lgzB0B5BaNCo6D
         RqxANucCnq42gDZoqhjJWauCKoNv4Te6+2Co4w9/vsVp2sD8kGip0qu4I93WUcc0vb8N
         cxda3Nf6t8vCHlinxft3VJmbJkthM8eynrqLX5zB44nYj4P8au3+4PHWVeiSVDP9WPqw
         mM6VEInnCGg/f0zR+rlARDJOkgIl/Uge9NZEZSPG53S+SeYuYn77fTekdIjEixoBYm/q
         r2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679347321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JKZyZ9UtP1ZZ748rC6wje4ZjvZJKdAV8kDbH4x8qqR8=;
        b=p7W2r3A2BsD+7JEm9/fR3eW2zDgeZRGQ0bfF0iIVcy1/4yKvPUabQ1sxFZ9raexf5f
         7x4D2jkHmq+uvBudoOCd0SEPSWCu9X43aecJYntFF798ohjXp54+lk2+OzEC5NqTIb60
         ZxGegAq9ssrcXXACYOL+V9MR6av/5LubXMrgdWvEYwfK8SRvxF1YW96eXNLZlacn6rhS
         hHT1jKTe3eEEv3muHxfNUa8LQWbKUYVc/zQHMP3Pu/Kd9xmX3T8cKOsiWYPG9mJyx2ip
         WOO1AWpVuGSXyUNs3/+uUGiY0nVmIsc3ZeqlAdBIcTjM/9L+87JTj4AD0PfzlTvadgW6
         HDrA==
X-Gm-Message-State: AO0yUKXjKUdkwV9qi5r6bwRcOZ22ZW2IhLa8bqAOvK0RxMDueWon032n
        Oz3juiVFeNiR8mgDjiEK/s9n/IomS1Q=
X-Google-Smtp-Source: AK7set8AX5IQmx37Co1yuIMYxkdQKuukCk7qo9qZ3nFRwvxpknx1JxVBWM/utdYOKjq3h+SSzncEOw==
X-Received: by 2002:a17:906:b845:b0:931:c6ba:8619 with SMTP id ga5-20020a170906b84500b00931c6ba8619mr495101ejb.72.1679347320677;
        Mon, 20 Mar 2023 14:22:00 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-73dd-8200-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:73dd:8200::e63])
        by smtp.googlemail.com with ESMTPSA id j30-20020a508a9e000000b004af5968cb3bsm5346622edj.17.2023.03.20.14.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 14:22:00 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-rtc@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 RFC] rtc: meson-vrtc: Use ktime_get_real_ts64() to get the current time
Date:   Mon, 20 Mar 2023 22:21:42 +0100
Message-Id: <20230320212142.2355062-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.40.0
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

The VRTC alarm register can be programmed with an amount of seconds
after which the SoC will be woken up by the VRTC timer again. We are
already converting the alarm time from meson_vrtc_set_alarm() to
"seconds since 1970". This means we also need to use "seconds since
1970" for the current time.

This fixes a problem where setting the alarm to one minute in the future
results in the firmware (which handles wakeup) to output (on the serial
console) that the system will be woken up in billions of seconds.
ktime_get_raw_ts64() returns the time since boot, not since 1970. Switch
to ktime_get_real_ts64() to fix the calculation of the alarm time and to
make the SoC wake up at the specified date/time. Also the firmware
(which manages suspend) now prints either 59 or 60 seconds until wakeup
(depending on how long it takes for the system to enter suspend).

Fixes: 6ef35398e827 ("rtc: Add Amlogic Virtual Wake RTC")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/rtc/rtc-meson-vrtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-meson-vrtc.c b/drivers/rtc/rtc-meson-vrtc.c
index 1463c8621561..648fa362ec44 100644
--- a/drivers/rtc/rtc-meson-vrtc.c
+++ b/drivers/rtc/rtc-meson-vrtc.c
@@ -23,7 +23,7 @@ static int meson_vrtc_read_time(struct device *dev, struct rtc_time *tm)
 	struct timespec64 time;
 
 	dev_dbg(dev, "%s\n", __func__);
-	ktime_get_raw_ts64(&time);
+	ktime_get_real_ts64(&time);
 	rtc_time64_to_tm(time.tv_sec, tm);
 
 	return 0;
@@ -96,7 +96,7 @@ static int __maybe_unused meson_vrtc_suspend(struct device *dev)
 		long alarm_secs;
 		struct timespec64 time;
 
-		ktime_get_raw_ts64(&time);
+		ktime_get_real_ts64(&time);
 		local_time = time.tv_sec;
 
 		dev_dbg(dev, "alarm_time = %lus, local_time=%lus\n",
-- 
2.40.0

