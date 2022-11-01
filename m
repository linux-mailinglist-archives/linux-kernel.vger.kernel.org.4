Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAA4614F4A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiKAQb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiKAQbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:31:31 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654B31CFFC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 09:31:29 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so3768344wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 09:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fdNBgmLA0ARtvmJ0vN5Z/w6aKfYyu8s0U0URVnDv14o=;
        b=GmBttxW57q4eTxB+S/I89JTXG96fqaGKEX3+vysn28FpPRqw9ol3jkXM4Xe5wINmTf
         IGcsWtkLLUIXPUNEVtiqiq2ZFUJ2v5pvNs9aZzXdg88hYWdjrvDFSjN26E2pHza6T986
         +elzQiNRNdXLay3Jig/5ard3PSZzzYRo74dnyrDS8441jJLnH61N3aPVHLDTf+rTW7GU
         VzcNPftF3plhDka6AHNmZJmHmntfsZNjyDy+6hlK4L18eENgEkBXMy2kU5MgkSxuRTxI
         RQSSUfGwMQhe3JJF4kVbdnFhr3ZFAIvKdy9+69eQvdCeNsaFMK9PmtsGXQ9zdHUu8vI8
         HISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fdNBgmLA0ARtvmJ0vN5Z/w6aKfYyu8s0U0URVnDv14o=;
        b=GqxobomcOgxWMdrM0NTbeXieB4skMqA/8DRKNZjWHlS8KBJkw5KxWiJ2ljVhgl1WND
         ggntT2+/SjwyL/CY5CtI7L/aGTmUCewqc45PUsrEYUdiuMF1rJ9MpoUppdUx2PmlQMhp
         fPAQqsjtQunikLH2u3SxhqMtWTShqPxAzxHZgjo4bZetK5umPF5VWIPTznXFKWmE2Smb
         0k0dQhqu5PWSkdZd0iC7y4TFgUJ94PULVUcxSvtqwKS41x8NpROBHAyghFahVIT+wDRX
         WS/4FOTaqAz5b2cNrKhtIqkXcU+7IsjfXMZaGAmPTWSi91RVftdsIW0qLHPYpynzOaOc
         jF5Q==
X-Gm-Message-State: ACrzQf1Iv0uUUaV8WlI+IrsVeCl5LwGKgoQWp0cFH5tL3GYRZR5REevK
        dsn9PC9ngvMbBCbNUo8ICTAQvg==
X-Google-Smtp-Source: AMsMyM5TSEWjTx8x+xRblm1eFpK1faSNEwZCU48u8GG46iWu6Y9mu8PLqBH9P6FaCw59yn8vvjSygQ==
X-Received: by 2002:a05:600c:230d:b0:3c4:2975:321a with SMTP id 13-20020a05600c230d00b003c42975321amr22606104wmo.155.1667320287924;
        Tue, 01 Nov 2022 09:31:27 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:e844:18b6:fc5:bbc9])
        by smtp.gmail.com with ESMTPSA id bu15-20020a056000078f00b0022ac1be009esm8339844wrb.16.2022.11.01.09.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 09:31:27 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v5 06/14] coresight: etm3x: Update ETM3 driver to use Trace ID API
Date:   Tue,  1 Nov 2022 16:30:55 +0000
Message-Id: <20221101163103.17921-7-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221101163103.17921-1-mike.leach@linaro.org>
References: <20221101163103.17921-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the TraceID API to allocate ETM trace IDs dynamically.

As with the etm4x we allocate on enable / disable for perf,
allocate on enable / reset for sysfs.

Additionally we allocate on sysfs file read as both perf and sysfs
can read the ID before enabling the hardware.

Remove sysfs option to write trace ID - which is inconsistent with
both the dynamic allocation method and the fixed allocation method
previously used.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm.h   |  2 +
 .../coresight/coresight-etm3x-core.c          | 69 +++++++++++++++++--
 .../coresight/coresight-etm3x-sysfs.c         | 27 ++------
 3 files changed, 72 insertions(+), 26 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index f3ab96eaf44e..3667428d38b6 100644
--- a/drivers/hwtracing/coresight/coresight-etm.h
+++ b/drivers/hwtracing/coresight/coresight-etm.h
@@ -287,4 +287,6 @@ int etm_get_trace_id(struct etm_drvdata *drvdata);
 void etm_set_default(struct etm_config *config);
 void etm_config_trace_mode(struct etm_config *config);
 struct etm_config *get_etm_config(struct etm_drvdata *drvdata);
+int etm_read_alloc_trace_id(struct etm_drvdata *drvdata);
+void etm_release_trace_id(struct etm_drvdata *drvdata);
 #endif
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index d0ab9933472b..9a7a9e974d41 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -32,6 +32,7 @@
 
 #include "coresight-etm.h"
 #include "coresight-etm-perf.h"
+#include "coresight-trace-id.h"
 
 /*
  * Not really modular but using module_param is the easiest way to
@@ -490,16 +491,59 @@ static int etm_trace_id(struct coresight_device *csdev)
 	return etm_get_trace_id(drvdata);
 }
 
+int etm_read_alloc_trace_id(struct etm_drvdata *drvdata)
+{
+	int trace_id;
+
+	/*
+	 * This will allocate a trace ID to the cpu,
+	 * or return the one currently allocated.
+	 *
+	 * trace id function has its own lock
+	 */
+	trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu);
+	if (IS_VALID_ID(trace_id))
+		drvdata->traceid = (u8)trace_id;
+	else
+		dev_err(&drvdata->csdev->dev,
+			"Failed to allocate trace ID for %s on CPU%d\n",
+			dev_name(&drvdata->csdev->dev), drvdata->cpu);
+	return trace_id;
+}
+
+void etm_release_trace_id(struct etm_drvdata *drvdata)
+{
+	coresight_trace_id_put_cpu_id(drvdata->cpu);
+}
+
 static int etm_enable_perf(struct coresight_device *csdev,
 			   struct perf_event *event)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	int trace_id;
 
 	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id()))
 		return -EINVAL;
 
 	/* Configure the tracer based on the session's specifics */
 	etm_parse_event_config(drvdata, event);
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
+		return -EINVAL;
+	}
+	drvdata->traceid = (u8)trace_id;
+
 	/* And enable it */
 	return etm_enable_hw(drvdata);
 }
@@ -512,6 +556,11 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
 
 	spin_lock(&drvdata->spinlock);
 
+	/* sysfs needs to allocate and set a trace ID */
+	ret = etm_read_alloc_trace_id(drvdata);
+	if (ret < 0)
+		goto unlock_enable_sysfs;
+
 	/*
 	 * Configure the ETM only if the CPU is online.  If it isn't online
 	 * hw configuration will take place on the local CPU during bring up.
@@ -528,6 +577,10 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
 		ret = -ENODEV;
 	}
 
+	if (ret)
+		etm_release_trace_id(drvdata);
+
+unlock_enable_sysfs:
 	spin_unlock(&drvdata->spinlock);
 
 	if (!ret)
@@ -611,6 +664,9 @@ static void etm_disable_perf(struct coresight_device *csdev)
 	coresight_disclaim_device_unlocked(csdev);
 
 	CS_LOCK(drvdata->base);
+
+	/* perf will release trace ids when _free_aux() is called at the end of the session */
+
 }
 
 static void etm_disable_sysfs(struct coresight_device *csdev)
@@ -635,6 +691,13 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
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
 
@@ -781,11 +844,6 @@ static void etm_init_arch_data(void *info)
 	CS_LOCK(drvdata->base);
 }
 
-static void etm_init_trace_id(struct etm_drvdata *drvdata)
-{
-	drvdata->traceid = coresight_get_trace_id(drvdata->cpu);
-}
-
 static int __init etm_hp_setup(void)
 {
 	int ret;
@@ -871,7 +929,6 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	if (etm_arch_supported(drvdata->arch) == false)
 		return -EINVAL;
 
-	etm_init_trace_id(drvdata);
 	etm_set_default(&drvdata->config);
 
 	pdata = coresight_get_platform_data(dev);
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index fd81eca3ec18..2f271b7fb048 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -85,6 +85,7 @@ static ssize_t reset_store(struct device *dev,
 		}
 
 		etm_set_default(config);
+		etm_release_trace_id(drvdata);
 		spin_unlock(&drvdata->spinlock);
 	}
 
@@ -1189,30 +1190,16 @@ static DEVICE_ATTR_RO(cpu);
 static ssize_t traceid_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	unsigned long val;
-	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-
-	val = etm_get_trace_id(drvdata);
-
-	return sprintf(buf, "%#lx\n", val);
-}
-
-static ssize_t traceid_store(struct device *dev,
-			     struct device_attribute *attr,
-			     const char *buf, size_t size)
-{
-	int ret;
-	unsigned long val;
+	int trace_id;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
-	ret = kstrtoul(buf, 16, &val);
-	if (ret)
-		return ret;
+	trace_id = etm_read_alloc_trace_id(drvdata);
+	if (trace_id < 0)
+		return trace_id;
 
-	drvdata->traceid = val & ETM_TRACEID_MASK;
-	return size;
+	return sysfs_emit(buf, "%#x\n", trace_id);
 }
-static DEVICE_ATTR_RW(traceid);
+static DEVICE_ATTR_RO(traceid);
 
 static struct attribute *coresight_etm_attrs[] = {
 	&dev_attr_nr_addr_cmp.attr,
-- 
2.17.1

