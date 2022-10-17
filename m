Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2B1600FF0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiJQNJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiJQNJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:09:27 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03A0D9F;
        Mon, 17 Oct 2022 06:09:22 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id g10so12002030oif.10;
        Mon, 17 Oct 2022 06:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxBO71YTPZQhAtFbi9nnTkRa58Zyh2hdgkHI+eeVMDA=;
        b=Nv1MpuRk8XWnN8W4oZzjLoBkpJ5NX7m02MZydTw5nLViCz9tGpw2b2AYNoMVJliJbn
         XEdocACuUheqF4g6XSJitDgrNFN3NV6KvWMp5Wf0VILlzmSoVgZfJK0QzizXNKE/VXYi
         EbYMuS3RGIYfhtYlMc2ffrBBPfcfM//IwKMhYAZtEVh6BToqsouD/BzaRdVHACxoqiYu
         Cs6CbFRCepQFdWkUOB4CsjjBuKmpaJjpLROH4FSlfth9mkmheVXgsInb89wiwfpvpsFD
         ZDUH+2RAsgxkvfXtM+HlGxQLkLx00R5hUNF5reGf1GNXNE6EHA3CQSixUHiHimbrKVXF
         sUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XxBO71YTPZQhAtFbi9nnTkRa58Zyh2hdgkHI+eeVMDA=;
        b=TrBsOt9pe5XWnkvmLK5FbSnbRvTubIqdE8nikDhbDOJiDZr/Mh/XFUTN7aBDwuj1zy
         2o/B1QBvqCtjupL6xLcRP+9DvHVJsaazQkRZjCRRaTLpP1fP5GXdtZ+2KBsqlW1q6VYh
         YA0+7iQvVfmqky92a6a67lqhuuJzY3h92+7oH0r96NeCg1cMcep5+7P3cC64+50ZeJ2o
         1IzmLPV9bIGJZqi9wGDx/ii60GKMBKcxwiRqYkOOSV44VYvpoGOTvRXaCrwoLB4BFKnk
         lU5hmr8IrSiWOkIwYcVnwaXm8CwHm7PlghIF4Ez/RDazFvNBlr3F/2A0F3KXujOddMs3
         CqHA==
X-Gm-Message-State: ACrzQf0csF0PUlrl3/LF4z5hqmRqvgV6ofY7xaxsziLroaKfCUDIXr/x
        UwS6GObMgT4i+YbWZsDwGXAEVai8lJw=
X-Google-Smtp-Source: AMsMyM7dG63zst9fYSZmyihBjW/G3Ap60X3rzYfxTQba2FliCFqvn2CeWqHcJY3rLakygccv4pYlqg==
X-Received: by 2002:a05:6808:16ac:b0:353:b7d7:5fef with SMTP id bb44-20020a05680816ac00b00353b7d75fefmr4952009oib.293.1666012162337;
        Mon, 17 Oct 2022 06:09:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d10-20020a4aaa8a000000b0047644a9b49asm4207865oon.19.2022.10.17.06.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 06:09:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6/9] thermal/core: Protect hwmon accesses to thermal operations with thermal zone mutex
Date:   Mon, 17 Oct 2022 06:09:07 -0700
Message-Id: <20221017130910.2307118-7-linux@roeck-us.net>
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

In preparation to protecting access to thermal operations against thermal
zone device removal, protect hwmon accesses to thermal zone operations
with the thermal zone mutex. After acquiring the mutex, ensure that the
thermal zone device is registered before proceeding.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/thermal/thermal_hwmon.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index f53f4ceb6a5d..33bfbaed4236 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -77,11 +77,19 @@ temp_crit_show(struct device *dev, struct device_attribute *attr, char *buf)
 	int temperature;
 	int ret;
 
+	mutex_lock(&tz->lock);
+
+	if (!device_is_registered(&tz->device)) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
 	ret = tz->ops->get_crit_temp(tz, &temperature);
-	if (ret)
-		return ret;
 
-	return sprintf(buf, "%d\n", temperature);
+unlock:
+	mutex_unlock(&tz->lock);
+
+	return ret ? ret : sprintf(buf, "%d\n", temperature);
 }
 
 
-- 
2.36.2

