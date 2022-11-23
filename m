Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144E1636A26
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiKWTvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239233AbiKWTvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:51:03 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA900C4954
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:50:36 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i12so27160545wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7MmfeWQlT78drM8G0hOv804O+RJ2l1J7iO54NF0OyN8=;
        b=d4J+ppIOHgyeqnxekrWs1BAsBbFYXo7FQ3YKAYqZ9zwh09K1atWEboy3oixlH3exb3
         Vffbqcgwx419G4Ufl8i4zTkPeDc+Ho9vliUX/DJsnajCj8HO1uPIGUQGbZCoBOvO3Ysg
         /ilXf4+QraCj2qFwnkL0AsN4qC94j6Q4se1F+/te+fVrYuThorSkRLMPmikPE+tIDqc/
         Uthn9Jy5wjKs3yV7ncE2PlubGv/5rywAnRNyt6iS+qXVtJm5xigZCK9ek9mUfqEVOl7J
         vyftoTpyy/eCv1niCPq9XIqkD/Ps1ZGVpZVeG2ac793A3WcJhOEwRCCNobm7TCfuPZLg
         4Ipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7MmfeWQlT78drM8G0hOv804O+RJ2l1J7iO54NF0OyN8=;
        b=lwnmwa5Jla6SgbSEsxeaUOtkkce7rnaEJicCEOS+T1ho8E7f1mtUzxoZv3uin2q9/S
         e3Feb7NsXRw9+5vFNao9GsNNOkbu/x80UXzzfiVux7RobFe+LoxT8uXFrv+lPBu7QAg/
         LD0RGzkrQm/le1jTdeBovcgRob3dJgn4ywJRxiZ+khi6+63kcm6e+pt7jV2cmnY9Srhd
         jQVjjg4219op1fnbihx3pfpUaS6yRfwipd4aS5k5jQQcEITL386tMSj3fWtrgYHP8sfR
         VJh4tT4p4BLRlN5No7RTgCIbJj7FKFc3FegEhb+0fCfLqr1Cmd9ZlJBTKjZfcMJ/qfR2
         loiw==
X-Gm-Message-State: ANoB5pn6p9sqEkujlXlmOEk891fhHs8OBDVyTclCilH3BPuBYbXThlor
        rdSqdm1nJXseMOno052TufpS6g==
X-Google-Smtp-Source: AA0mqf6RruZzVFpXN6h4KCkZZ95lJIotI25/WuGySzSv0FbAsvAMxS7Zbc7Yzk2LkDSt4vRbUXbHhQ==
X-Received: by 2002:a5d:5b19:0:b0:241:dea3:ad48 with SMTP id bx25-20020a5d5b19000000b00241dea3ad48mr8019020wrb.357.1669233036374;
        Wed, 23 Nov 2022 11:50:36 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:fcbc:7b5d:8d6c:43a4])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d6805000000b002364c77bcacsm7267414wru.38.2022.11.23.11.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:50:35 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v6 14/14] coresight: trace-id: Add debug & test macros to Trace ID allocation
Date:   Wed, 23 Nov 2022 19:50:10 +0000
Message-Id: <20221123195010.6859-15-mike.leach@linaro.org>
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

Adds in a number of pr_debug macros to allow the debugging and test of
the trace ID allocation system.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../hwtracing/coresight/coresight-trace-id.c  | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
index 9b85c376cb12..367bbfb4c213 100644
--- a/drivers/hwtracing/coresight/coresight-trace-id.c
+++ b/drivers/hwtracing/coresight/coresight-trace-id.c
@@ -24,6 +24,27 @@ static atomic_t perf_cs_etm_session_active = ATOMIC_INIT(0);
 /* lock to protect id_map and cpu data  */
 static DEFINE_SPINLOCK(id_map_lock);
 
+/* #define TRACE_ID_DEBUG 1 */
+#if defined(TRACE_ID_DEBUG) || defined(CONFIG_COMPILE_TEST)
+
+static void coresight_trace_id_dump_table(struct coresight_trace_id_map *id_map,
+					  const char *func_name)
+{
+	pr_debug("%s id_map::\n", func_name);
+	pr_debug("Used = %*pb\n", CORESIGHT_TRACE_IDS_MAX, id_map->used_ids);
+	pr_debug("Pend = %*pb\n", CORESIGHT_TRACE_IDS_MAX, id_map->pend_rel_ids);
+}
+#define DUMP_ID_MAP(map)   coresight_trace_id_dump_table(map, __func__)
+#define DUMP_ID_CPU(cpu, id) pr_debug("%s called;  cpu=%d, id=%d\n", __func__, cpu, id)
+#define DUMP_ID(id)   pr_debug("%s called; id=%d\n", __func__, id)
+#define PERF_SESSION(n) pr_debug("%s perf count %d\n", __func__, n)
+#else
+#define DUMP_ID_MAP(map)
+#define DUMP_ID(id)
+#define DUMP_ID_CPU(cpu, id)
+#define PERF_SESSION(n)
+#endif
+
 /* unlocked read of current trace ID value for given CPU */
 static int _coresight_trace_id_read_cpu_id(int cpu)
 {
@@ -127,6 +148,7 @@ static void coresight_trace_id_release_all_pending(void)
 		cpumask_clear_cpu(cpu, &cpu_id_release_pending);
 	}
 	spin_unlock_irqrestore(&id_map_lock, flags);
+	DUMP_ID_MAP(id_map);
 }
 
 static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
@@ -168,6 +190,8 @@ static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_
 get_cpu_id_out_unlock:
 	spin_unlock_irqrestore(&id_map_lock, flags);
 
+	DUMP_ID_CPU(cpu, id);
+	DUMP_ID_MAP(id_map);
 	return id;
 }
 
@@ -194,6 +218,8 @@ static void coresight_trace_id_map_put_cpu_id(int cpu, struct coresight_trace_id
 	}
 
 	spin_unlock_irqrestore(&id_map_lock, flags);
+	DUMP_ID_CPU(cpu, id);
+	DUMP_ID_MAP(id_map);
 }
 
 static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *id_map)
@@ -206,6 +232,8 @@ static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *i
 	id = coresight_trace_id_alloc_new_id(id_map, 0, true);
 	spin_unlock_irqrestore(&id_map_lock, flags);
 
+	DUMP_ID(id);
+	DUMP_ID_MAP(id_map);
 	return id;
 }
 
@@ -216,6 +244,9 @@ static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *
 	spin_lock_irqsave(&id_map_lock, flags);
 	coresight_trace_id_free(id, id_map);
 	spin_unlock_irqrestore(&id_map_lock, flags);
+
+	DUMP_ID(id);
+	DUMP_ID_MAP(id_map);
 }
 
 /* API functions */
@@ -253,6 +284,7 @@ EXPORT_SYMBOL_GPL(coresight_trace_id_put_system_id);
 void coresight_trace_id_perf_start(void)
 {
 	atomic_inc(&perf_cs_etm_session_active);
+	PERF_SESSION(atomic_read(&perf_cs_etm_session_active));
 }
 EXPORT_SYMBOL_GPL(coresight_trace_id_perf_start);
 
@@ -260,6 +292,7 @@ void coresight_trace_id_perf_stop(void)
 {
 	if (!atomic_dec_return(&perf_cs_etm_session_active))
 		coresight_trace_id_release_all_pending();
+	PERF_SESSION(atomic_read(&perf_cs_etm_session_active));
 }
 EXPORT_SYMBOL_GPL(coresight_trace_id_perf_stop);
 
-- 
2.17.1

