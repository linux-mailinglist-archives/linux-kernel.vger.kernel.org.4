Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B069B66BE25
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjAPMtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjAPMtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:49:43 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60A31E5E7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:49:37 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id k8so12878007wrc.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PCemn0i95mwoh/MU/VK1Wd9F6OgWQRZUEuH/awNPIM8=;
        b=Qxg0NcQqzwZhKCq1V/1nm71+DlVXBOIijj4vE97t6DY9t3fp3H8kMI9Z1nR8snKwyA
         ZN+mpvWayCFJq9mSPeg3txSeB2hkBOeZJGX9DA+XvofbyKp65MZxV4wTrLeOzi6E0ID1
         q5fZ9k1j5Q8N+pP8v2ExKmxRhdgSW+A3LWaJKWwjE4WdCKo8J+MQotIankgRl8vDdx06
         pbv2VRRJ4vIaVyoWwFaYUOwPwnxsUdwNycTjzHP0ZJT1UDFThf0tubQA/WMVIwDOCLTb
         1lr1qulz624xfILIJwQpMF10lbQWnsBWlSz0Ht7vVARnSqlJCVmGha6VuQ0vY9FxPSsJ
         erqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCemn0i95mwoh/MU/VK1Wd9F6OgWQRZUEuH/awNPIM8=;
        b=DbBUIWzIemZlaVjylpXXdoYpR7B8dFTIQjZdrC3RmenKr9QD3RYOm4AGQVCtkkcy7D
         ad6GtqQSzkhxz4bidsRN0BsiQ3iXVC7F4oFPt9BgyGPThlkpz0GAVcHsaQ4HUiWYUOqC
         MRv0z/HcqPsxFrUxMzRNu65hScJHUnQCFc2AGpsxqB9PUjbAtF/veosraMEPt2Py1qJK
         InmgUrDPptI25DCjHPCP4EwxReygqSfKsgH6kE8hA7H2CRz9trycyuvrXpYPlAqWoSA9
         dXUFBw2AlvPs61LgytM8sjGwQaiTsnOYGgzPFZ8IMygs1Qjm7cEtSCCxwHXM4G68T3Aa
         ePMA==
X-Gm-Message-State: AFqh2krhGBgt/hlwdsJJpaYkqzkpwn2d/YwKNr5qsqxCs83dYDY6RmtC
        wm/eGDZVgHs9Omyekw3SEac9uA==
X-Google-Smtp-Source: AMrXdXtX6u5D7OWA9FMGFgCq4+u+kHbx8Vp3c75YOf1j5mcStXb/qUYsmuRsX5N9P//OIcLvus4++g==
X-Received: by 2002:a05:6000:1250:b0:2bd:c581:293d with SMTP id j16-20020a056000125000b002bdc581293dmr6984405wrx.15.1673873376462;
        Mon, 16 Jan 2023 04:49:36 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:6c91:710d:9433:e868])
        by smtp.gmail.com with ESMTPSA id fl12-20020a05600c0b8c00b003dab40f9eafsm6896832wmb.35.2023.01.16.04.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:49:35 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v7 02/15] coresight: Remove obsolete Trace ID unniqueness checks
Date:   Mon, 16 Jan 2023 12:49:15 +0000
Message-Id: <20230116124928.5440-3-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230116124928.5440-1-mike.leach@linaro.org>
References: <20230116124928.5440-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The checks for sources to have unique IDs has been removed - this is now
guaranteed by the ID allocation mechanisms, and inappropriate where
multiple ID maps are in use in larger systems

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 45 --------------------
 1 file changed, 45 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index f3068175ca9d..ce3aa845ecc2 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -112,45 +112,6 @@ struct coresight_device *coresight_get_percpu_sink(int cpu)
 }
 EXPORT_SYMBOL_GPL(coresight_get_percpu_sink);
 
-static int coresight_id_match(struct device *dev, void *data)
-{
-	int trace_id, i_trace_id;
-	struct coresight_device *csdev, *i_csdev;
-
-	csdev = data;
-	i_csdev = to_coresight_device(dev);
-
-	/*
-	 * No need to care about oneself and components that are not
-	 * sources or not enabled
-	 */
-	if (i_csdev == csdev || !i_csdev->enable ||
-	    i_csdev->type != CORESIGHT_DEV_TYPE_SOURCE)
-		return 0;
-
-	/* Get the source ID for both components */
-	trace_id = source_ops(csdev)->trace_id(csdev);
-	i_trace_id = source_ops(i_csdev)->trace_id(i_csdev);
-
-	/* All you need is one */
-	if (trace_id == i_trace_id)
-		return 1;
-
-	return 0;
-}
-
-static int coresight_source_is_unique(struct coresight_device *csdev)
-{
-	int trace_id = source_ops(csdev)->trace_id(csdev);
-
-	/* this shouldn't happen */
-	if (trace_id < 0)
-		return 0;
-
-	return !bus_for_each_dev(&coresight_bustype, NULL,
-				 csdev, coresight_id_match);
-}
-
 static int coresight_find_link_inport(struct coresight_device *csdev,
 				      struct coresight_device *parent)
 {
@@ -459,12 +420,6 @@ static int coresight_enable_source(struct coresight_device *csdev, u32 mode)
 {
 	int ret;
 
-	if (!coresight_source_is_unique(csdev)) {
-		dev_warn(&csdev->dev, "traceID %d not unique\n",
-			 source_ops(csdev)->trace_id(csdev));
-		return -EINVAL;
-	}
-
 	if (!csdev->enable) {
 		if (source_ops(csdev)->enable) {
 			ret = coresight_control_assoc_ectdev(csdev, true);
-- 
2.17.1

