Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AEF614F4E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiKAQcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiKAQba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:31:30 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A981CFF7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 09:31:28 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l32so9177607wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 09:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jbkw4FiHpe9WvP+c1c+jQ4hmFyTe7g3DYVUX3geH+Ng=;
        b=XbUH4tpB7EvlUiFmSZ6ZL81NJTV8/Xyme4qIFlHBlzlaVl/PmRJUnyKzwYIOBURe2e
         EQwqmn/i1XHdX6gjdqFuPdQ6rdZZgoDdWgaX6R+TZn4iDde/UFRK7FEEV4ks98cn5e/H
         rNxl6R3yU1MgbxkQph+KrW1lG8M94kKwYZ6QadcTkFUeqpb14mFdYBTOw3voiFTeMH/B
         izkwu7aT250LxJ+0bUG+4VBj5yCpXQDi8/LZnnWC+82rH2YAkhAfyqEN1MjaZHhFy2Cl
         +HiYs6n50K5k7XzpqWxoVcRkDTmO6svthCmi571s5rMWSl6xK6bXXG37OoOvZOktVPC4
         Ii4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jbkw4FiHpe9WvP+c1c+jQ4hmFyTe7g3DYVUX3geH+Ng=;
        b=PoLI8mOiuofEysqYHXb9FDA1MtlXhCfC2lSWUm1/SOZJwxI9j66j7BeV6rU+sA01k2
         fhnPCR/7i0wUkhjTy/MlxOMyUUPf+AC7OnfHW4A5IdXz58Q1Ava+ZGtLrvgGifARg5RM
         ernyhs5s5Nck+3CrEAirm0zWG6x9/Zf0f9C0A+zYmk6GxJMaTMqhGmZoShtJE9yhjn3U
         p3uNZ5w6gT1mbtrEbNmGQ17tlzvvSDEUO/9Q1G3SoWYjrrzbtsagpO/llBNw5Du8iAze
         N/M7UYI0nfVD1p7wXCHIznwgwlMTAldJh268mJOitjelruNZ7uFavPluW1+mmc2jE1OV
         cnxg==
X-Gm-Message-State: ACrzQf39dbkPHX77KmKPNtiBUHm+l5nrWwKXg6yjjzh/BF5ANe+6OVvi
        UT7v354daQ3quenb3gPU1AOidQ==
X-Google-Smtp-Source: AMsMyM58h831FJtpmk4ntE5YBlR4F4xlzxSn7nhcSMD37JZmIUj1NOJ+7CWVDst898s8Uaq4TvTIig==
X-Received: by 2002:a7b:c30a:0:b0:3c1:bf95:e17b with SMTP id k10-20020a7bc30a000000b003c1bf95e17bmr13053842wmj.31.1667320286690;
        Tue, 01 Nov 2022 09:31:26 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:e844:18b6:fc5:bbc9])
        by smtp.gmail.com with ESMTPSA id bu15-20020a056000078f00b0022ac1be009esm8339844wrb.16.2022.11.01.09.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 09:31:26 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v5 05/14] coresight: etm4x: Update ETM4 driver to use Trace ID API
Date:   Tue,  1 Nov 2022 16:30:54 +0000
Message-Id: <20221101163103.17921-6-mike.leach@linaro.org>
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

The trace ID API is now used to allocate trace IDs for ETM4.x / ETE
devices.

For perf sessions, these will be allocated on enable, and released on
disable.

For sysfs sessions, these will be allocated on enable, but only released
on reset. This allows the sysfs session to interrogate the Trace ID used
after the session is over - maintaining functional consistency with the
previous allocation scheme.

The trace ID will also be allocated on read of the mgmt/trctraceid file.
This ensures that if perf or sysfs read this before enabling trace, the
value will be the one used for the trace session.

Trace ID initialisation is removed from the _probe() function.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../coresight/coresight-etm4x-core.c          | 70 +++++++++++++++++--
 .../coresight/coresight-etm4x-sysfs.c         | 27 ++++++-
 drivers/hwtracing/coresight/coresight-etm4x.h |  3 +
 3 files changed, 90 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 80fefaba58ee..0e361d35c611 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -42,6 +42,7 @@
 #include "coresight-etm4x-cfg.h"
 #include "coresight-self-hosted-trace.h"
 #include "coresight-syscfg.h"
+#include "coresight-trace-id.h"
 
 static int boot_enable;
 module_param(boot_enable, int, 0444);
@@ -234,6 +235,30 @@ static int etm4_trace_id(struct coresight_device *csdev)
 	return drvdata->trcid;
 }
 
+int etm4_read_alloc_trace_id(struct etmv4_drvdata *drvdata)
+{
+	int trace_id;
+
+	/*
+	 * This will allocate a trace ID to the cpu,
+	 * or return the one currently allocated.
+	 * The trace id function has its own lock
+	 */
+	trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu);
+	if (IS_VALID_ID(trace_id))
+		drvdata->trcid = (u8)trace_id;
+	else
+		dev_err(&drvdata->csdev->dev,
+			"Failed to allocate trace ID for %s on CPU%d\n",
+			dev_name(&drvdata->csdev->dev), drvdata->cpu);
+	return trace_id;
+}
+
+void etm4_release_trace_id(struct etmv4_drvdata *drvdata)
+{
+	coresight_trace_id_put_cpu_id(drvdata->cpu);
+}
+
 struct etm4_enable_arg {
 	struct etmv4_drvdata *drvdata;
 	int rc;
@@ -717,7 +742,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 static int etm4_enable_perf(struct coresight_device *csdev,
 			    struct perf_event *event)
 {
-	int ret = 0;
+	int ret = 0, trace_id;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id())) {
@@ -729,6 +754,24 @@ static int etm4_enable_perf(struct coresight_device *csdev,
 	ret = etm4_parse_event_config(csdev, event);
 	if (ret)
 		goto out;
+
+	/*
+	 * perf allocates cpu ids as part of _setup_aux() - device needs to use
+	 * the allocated ID. This reads the current version without allocation.
+	 *
+	 * This does not use the trace id lock to prevent lock_dep issues
+	 * with perf locks - we know the ID cannot change until perf shuts down
+	 * the session
+	 */
+	trace_id = coresight_trace_id_read_cpu_id(drvdata->cpu);
+	if (!IS_VALID_ID(trace_id)) {
+		dev_err(&drvdata->csdev->dev, "Failed to set trace ID for %s on CPU%d\n",
+			dev_name(&drvdata->csdev->dev), drvdata->cpu);
+		ret = -EINVAL;
+		goto out;
+	}
+	drvdata->trcid = (u8)trace_id;
+
 	/* And enable it */
 	ret = etm4_enable_hw(drvdata);
 
@@ -753,6 +796,11 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
 
 	spin_lock(&drvdata->spinlock);
 
+	/* sysfs needs to read and allocate a trace ID */
+	ret = etm4_read_alloc_trace_id(drvdata);
+	if (ret < 0)
+		goto unlock_sysfs_enable;
+
 	/*
 	 * Executing etm4_enable_hw on the cpu whose ETM is being enabled
 	 * ensures that register writes occur when cpu is powered.
@@ -764,6 +812,11 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
 		ret = arg.rc;
 	if (!ret)
 		drvdata->sticky_enable = true;
+
+	if (ret)
+		etm4_release_trace_id(drvdata);
+
+unlock_sysfs_enable:
 	spin_unlock(&drvdata->spinlock);
 
 	if (!ret)
@@ -895,6 +948,8 @@ static int etm4_disable_perf(struct coresight_device *csdev,
 	/* TRCVICTLR::SSSTATUS, bit[9] */
 	filters->ssstatus = (control & BIT(9));
 
+	/* perf will release trace ids when _free_aux() is called at the end of the session */
+
 	return 0;
 }
 
@@ -920,6 +975,13 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
 	spin_unlock(&drvdata->spinlock);
 	cpus_read_unlock();
 
+	/*
+	 * we only release trace IDs when resetting sysfs.
+	 * This permits sysfs users to read the trace ID after the trace
+	 * session has completed. This maintains operational behaviour with
+	 * prior trace id allocation method
+	 */
+
 	dev_dbg(&csdev->dev, "ETM tracing disabled\n");
 }
 
@@ -1562,11 +1624,6 @@ static int etm4_dying_cpu(unsigned int cpu)
 	return 0;
 }
 
-static void etm4_init_trace_id(struct etmv4_drvdata *drvdata)
-{
-	drvdata->trcid = coresight_get_trace_id(drvdata->cpu);
-}
-
 static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
 {
 	int i, ret = 0;
@@ -1971,7 +2028,6 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 	if (!desc.name)
 		return -ENOMEM;
 
-	etm4_init_trace_id(drvdata);
 	etm4_set_default(&drvdata->config);
 
 	pdata = coresight_get_platform_data(dev);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 9cac848cffaf..5e62aa40ecd0 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -266,10 +266,11 @@ static ssize_t reset_store(struct device *dev,
 	config->vmid_mask0 = 0x0;
 	config->vmid_mask1 = 0x0;
 
-	drvdata->trcid = drvdata->cpu + 1;
-
 	spin_unlock(&drvdata->spinlock);
 
+	/* for sysfs - only release trace id when resetting */
+	etm4_release_trace_id(drvdata);
+
 	cscfg_csdev_reset_feats(to_coresight_device(dev));
 
 	return size;
@@ -2392,6 +2393,26 @@ static struct attribute *coresight_etmv4_attrs[] = {
 	NULL,
 };
 
+/*
+ * Trace ID allocated dynamically on enable - but also allocate on read
+ * in case sysfs or perf read before enable to ensure consistent metadata
+ * information for trace decode
+ */
+static ssize_t trctraceid_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	int trace_id;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	trace_id = etm4_read_alloc_trace_id(drvdata);
+	if (trace_id < 0)
+		return trace_id;
+
+	return sysfs_emit(buf, "0x%x\n", trace_id);
+}
+static DEVICE_ATTR_RO(trctraceid);
+
 struct etmv4_reg {
 	struct coresight_device *csdev;
 	u32 offset;
@@ -2528,7 +2549,7 @@ static struct attribute *coresight_etmv4_mgmt_attrs[] = {
 	coresight_etm4x_reg(trcpidr3, TRCPIDR3),
 	coresight_etm4x_reg(trcoslsr, TRCOSLSR),
 	coresight_etm4x_reg(trcconfig, TRCCONFIGR),
-	coresight_etm4x_reg(trctraceid, TRCTRACEIDR),
+	&dev_attr_trctraceid.attr,
 	coresight_etm4x_reg(trcdevarch, TRCDEVARCH),
 	NULL,
 };
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 4b21bb79f168..434f4e95ee17 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -1095,4 +1095,7 @@ static inline bool etm4x_is_ete(struct etmv4_drvdata *drvdata)
 {
 	return drvdata->arch >= ETM_ARCH_ETE;
 }
+
+int etm4_read_alloc_trace_id(struct etmv4_drvdata *drvdata);
+void etm4_release_trace_id(struct etmv4_drvdata *drvdata);
 #endif
-- 
2.17.1

