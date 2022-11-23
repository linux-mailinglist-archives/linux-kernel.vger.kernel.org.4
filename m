Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0580636A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238260AbiKWTvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239070AbiKWTvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:51:02 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA490C2878
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:50:36 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bs21so31037050wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yRqldm/FdfNyFbQj65h6UroAtQ4UGZzHEB+lTVOfKUo=;
        b=zYdjxfGscIhxh6xArFzy4LgvKjYgl/BYqLtsSr8z/AagXcssbIObvxlx4mnbRdvMXs
         a74MMDvbjDzsZPDpvuU9TJxJNOk6STHL2rwUP/4FXwqmKiYOwfSDLqhkFRvhhAeIZCGL
         ejNswmM91mfKCJwtWp3HIX1bhNQp+Mq4jHedc4cAIRqMRGpEE9tHiUELY+viQ3+IzktB
         PAWmD2BCT/OIUgw/wwvNCY95RapbAh9jaJuvznHIxO6/8DwxH2Qe+TkUvOQpLKWWRJYn
         VBpAfpQh7d6j6OkeHLM/eAyCjkfPvkJdT1EVNY4Z06gq0cRpIZWdPj5lxloYIf15Rm8v
         95Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRqldm/FdfNyFbQj65h6UroAtQ4UGZzHEB+lTVOfKUo=;
        b=qIEWblwKkKsgw11WEppq2vUdmZxjyxjqiD2oLAzaBI6C4D9JoZUaYV9RMeogovQDKO
         YWv0fO/rivoLse+LtjziTI9gdFpW19JuI3gkMm3y7xARWz/3ROxKF4GZQxBwk3IJSnjr
         Gm6K2JlKn9GUowwOSfHaH3zK3nuYhumvKkvv9oEBk3WgPekPEzE/LVb8EHBVtaL5mFSn
         I1zoD4j3TjFzTYuyNwrKO0Zf8i7rUy+PGap5v20jDFLAR30FOJrzLXFs/oRUD06XVaJj
         N1aNQha4k/he16Mal2woAXsr5ZemdE8lkxRghoFtlxU92a59LH9bLawSeQ6a3CQRbJND
         cwew==
X-Gm-Message-State: ANoB5pllNnHL8782vQnmgy20X7QyH5giO5m34hMr+u3KiojkvawdreNw
        cux24OCftZ+DcNyFx3Y48oTucw==
X-Google-Smtp-Source: AA0mqf7TCodPPUK8zhWOAdzPfOYVd7M7RAfUC8tzK5A1ysBZc6lp33olazjEPyxpkpMAIXRiIWs+Mg==
X-Received: by 2002:a5d:66c8:0:b0:241:eabf:3b90 with SMTP id k8-20020a5d66c8000000b00241eabf3b90mr3444720wrw.31.1669233035185;
        Wed, 23 Nov 2022 11:50:35 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:fcbc:7b5d:8d6c:43a4])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d6805000000b002364c77bcacsm7267414wru.38.2022.11.23.11.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:50:34 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v6 13/14] coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID used for Trace ID
Date:   Wed, 23 Nov 2022 19:50:09 +0000
Message-Id: <20221123195010.6859-14-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221123195010.6859-1-mike.leach@linaro.org>
References: <20221123195010.6859-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the perf_report_aux_output_id() call to output the CoreSight trace ID
and associated CPU as a PERF_RECORD_AUX_OUTPUT_HW_ID record in the
perf.data file.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c |  7 +++++++
 include/linux/coresight-pmu.h                    | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index bdb9ab86173a..12fff661456e 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -4,6 +4,7 @@
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
 
+#include <linux/bitfield.h>
 #include <linux/coresight.h>
 #include <linux/coresight-pmu.h>
 #include <linux/cpumask.h>
@@ -448,6 +449,7 @@ static void etm_event_start(struct perf_event *event, int flags)
 	struct perf_output_handle *handle = &ctxt->handle;
 	struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
 	struct list_head *path;
+	u64 hw_id;
 
 	if (!csdev)
 		goto fail;
@@ -493,6 +495,11 @@ static void etm_event_start(struct perf_event *event, int flags)
 	if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF))
 		goto fail_disable_path;
 
+	/* output cpu / trace ID in perf record */
+	hw_id = FIELD_PREP(CS_AUX_HW_ID_VERSION_MASK, CS_AUX_HW_ID_CURR_VERSION);
+	hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK, coresight_trace_id_read_cpu_id(cpu));
+	perf_report_aux_output_id(event, hw_id);
+
 out:
 	/* Tell the perf core the event is alive */
 	event->hw.state = 0;
diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index 624f4843453e..51ac441a37c3 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
@@ -7,6 +7,8 @@
 #ifndef _LINUX_CORESIGHT_PMU_H
 #define _LINUX_CORESIGHT_PMU_H
 
+#include <linux/bits.h>
+
 #define CORESIGHT_ETM_PMU_NAME "cs_etm"
 
 /*
@@ -43,4 +45,16 @@
 #define ETM4_CFG_BIT_RETSTK	12
 #define ETM4_CFG_BIT_VMID_OPT	15
 
+/*
+ * Interpretation of the PERF_RECORD_AUX_OUTPUT_HW_ID payload.
+ * Used to associate a CPU with the CoreSight Trace ID.
+ * [07:00] - Trace ID - uses 8 bits to make value easy to read in file.
+ * [59:08] - Unused (SBZ)
+ * [63:60] - Version
+ */
+#define CS_AUX_HW_ID_TRACE_ID_MASK	GENMASK_ULL(7, 0)
+#define CS_AUX_HW_ID_VERSION_MASK	GENMASK_ULL(63, 60)
+
+#define CS_AUX_HW_ID_CURR_VERSION 0
+
 #endif
-- 
2.17.1

