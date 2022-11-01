Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110DA614F48
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiKAQbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiKAQb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:31:29 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F60D1CFF0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 09:31:27 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id p16so3608665wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 09:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Msiba57uIoQyW0yBXGfGPLCUUWKUrx8bYCzahjs4eQE=;
        b=xkyBzfZ/qvkEPYtJJ/tFUtt+SWB31CHZL+J6ISL9W6kDJX8DVF3+em0wRmakkx6MuM
         WmwIvJYHGsHMWupgFn7jAboL8vHCQY6RnelTi0f4yTtVWVcvcm22Bc8O5lJt90WGWAsw
         2FP5qpprfmQFsZiffssNrcgM7tk8enOExuCMgahoXQNUZh79ZfcSpcuZVPpY/fmXqjOI
         ANTd3DjQXD/IUkO0l938KH2H3QBjNjvO2pyJGTb2fGL3qvpZJUgED/ImvnLknz/R+22N
         nUfhxy9EosSi+aoslQVGlRFn7N15w+SmF2WnF1DAakF91VB1a1pq42qcjM0tauX0r0Xq
         M02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Msiba57uIoQyW0yBXGfGPLCUUWKUrx8bYCzahjs4eQE=;
        b=SuOBSkGMdDvpddivmchBZRePlKq3eaE/A5ENhTUJ97Wu6PIqrhSxriccIht7hsWZax
         Qw4fBQ4JQK4mOml+M4NO08zXmGaJO4kFnVwm5zB5ZDfHzdWQPu5FF3r8z995tgGJosK7
         /bRlo9F0jFEawSaQ5c9i+FVZWdLUrR9hU+Op7PpWpAqpm482KjK5rjleEAx8J7NJzjDc
         vjowFdIeszRqEpc1NTqnUAggy+s7ketOttFjERRB50iUK2wtZ3ovXukTj1MUBlKwmkAv
         mfM9j7lHUx+0vYzifyvJOC/ngLl/KiDVzp6bWi0/hiIG0Xgq87JjT10YoR7SFIoVPEsj
         fnGg==
X-Gm-Message-State: ACrzQf1iJyeNSBcjH8CAFF2Y4kwUt/B1HtAIkd/zvkGNdzzO+2V2gx/j
        ekErrEAMzgVdqSv9c05kL9ukBg==
X-Google-Smtp-Source: AMsMyM7grgGro5gge+919nXbiGqekcFAHp1UnOzkqrFAXyKsjkMilBLOMtfANRNkXVrpvkyH0qY2IQ==
X-Received: by 2002:a05:600c:4252:b0:3cf:678a:d189 with SMTP id r18-20020a05600c425200b003cf678ad189mr11653758wmm.51.1667320285595;
        Tue, 01 Nov 2022 09:31:25 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:e844:18b6:fc5:bbc9])
        by smtp.gmail.com with ESMTPSA id bu15-20020a056000078f00b0022ac1be009esm8339844wrb.16.2022.11.01.09.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 09:31:24 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v5 04/14] coresight: stm: Update STM driver to use Trace ID API
Date:   Tue,  1 Nov 2022 16:30:53 +0000
Message-Id: <20221101163103.17921-5-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221101163103.17921-1-mike.leach@linaro.org>
References: <20221101163103.17921-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates the STM driver to use the trace ID allocation API.
This uses the _system_id calls to allocate an ID on device poll,
and release on device remove.

The sysfs access to the STMTRACEIDR register has been changed from RW
to RO. Having this value as writable is not appropriate for the new
Trace ID scheme - and had potential to cause errors in the previous
scheme if values clashed with other sources.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-stm.c | 41 +++++++--------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 463f449cfb79..6af1b996af6f 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -31,6 +31,7 @@
 #include <linux/stm.h>
 
 #include "coresight-priv.h"
+#include "coresight-trace-id.h"
 
 #define STMDMASTARTR			0xc04
 #define STMDMASTOPR			0xc08
@@ -615,24 +616,7 @@ static ssize_t traceid_show(struct device *dev,
 	val = drvdata->traceid;
 	return sprintf(buf, "%#lx\n", val);
 }
-
-static ssize_t traceid_store(struct device *dev,
-			     struct device_attribute *attr,
-			     const char *buf, size_t size)
-{
-	int ret;
-	unsigned long val;
-	struct stm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-
-	ret = kstrtoul(buf, 16, &val);
-	if (ret)
-		return ret;
-
-	/* traceid field is 7bit wide on STM32 */
-	drvdata->traceid = val & 0x7f;
-	return size;
-}
-static DEVICE_ATTR_RW(traceid);
+static DEVICE_ATTR_RO(traceid);
 
 static struct attribute *coresight_stm_attrs[] = {
 	&dev_attr_hwevent_enable.attr,
@@ -803,14 +787,6 @@ static void stm_init_default_data(struct stm_drvdata *drvdata)
 	 */
 	drvdata->stmsper = ~0x0;
 
-	/*
-	 * The trace ID value for *ETM* tracers start at CPU_ID * 2 + 0x10 and
-	 * anything equal to or higher than 0x70 is reserved.  Since 0x00 is
-	 * also reserved the STM trace ID needs to be higher than 0x00 and
-	 * lowner than 0x10.
-	 */
-	drvdata->traceid = 0x1;
-
 	/* Set invariant transaction timing on all channels */
 	bitmap_clear(drvdata->chs.guaranteed, 0, drvdata->numsp);
 }
@@ -838,7 +814,7 @@ static void stm_init_generic_data(struct stm_drvdata *drvdata,
 
 static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 {
-	int ret;
+	int ret, trace_id;
 	void __iomem *base;
 	struct device *dev = &adev->dev;
 	struct coresight_platform_data *pdata = NULL;
@@ -922,12 +898,22 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 		goto stm_unregister;
 	}
 
+	trace_id = coresight_trace_id_get_system_id();
+	if (trace_id < 0) {
+		ret = trace_id;
+		goto cs_unregister;
+	}
+	drvdata->traceid = (u8)trace_id;
+
 	pm_runtime_put(&adev->dev);
 
 	dev_info(&drvdata->csdev->dev, "%s initialized\n",
 		 (char *)coresight_get_uci_data(id));
 	return 0;
 
+cs_unregister:
+	coresight_unregister(drvdata->csdev);
+
 stm_unregister:
 	stm_unregister_device(&drvdata->stm);
 	return ret;
@@ -937,6 +923,7 @@ static void stm_remove(struct amba_device *adev)
 {
 	struct stm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
 
+	coresight_trace_id_put_system_id(drvdata->traceid);
 	coresight_unregister(drvdata->csdev);
 
 	stm_unregister_device(&drvdata->stm);
-- 
2.17.1

