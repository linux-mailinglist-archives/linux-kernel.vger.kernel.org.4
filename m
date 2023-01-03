Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F5F65C1C6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237591AbjACOVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237235AbjACOV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:21:28 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13361090
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:21:26 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id f34so45800703lfv.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 06:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NAMOnkH/hQzTqE2MEDKvDzak0AhyVO2rIspP4ZVIx1U=;
        b=AWL8XwbP8Pmxp9hMQgrwXSiH3RMRxVYE5wa4qgt3cHCEljppJ4b1N9CadaKq1pIb29
         racj8FkVZf8Jdcmwp/w1gAwLz8LXc+/pxV4ifyqdgOBLSONcD4sFEMTsebRx/DdSV2I9
         n0bOwE9wF/lk5X4K5LlQmCjh0paMTNjZeQAzOfLt5ZSGxAbqlardWE/kZBsGWVaEr41v
         DDcF+H2gEP3d/x8sx+dymYH85phQi58XutJ5URyYmJY3MGbU2bNM/uecIv0sNVLi5qPS
         KhyGnbY2Pd7Rx/GL4JdqsmewNoUdTSpm445cjczSrJAQOtlr6vPsqajyDMNJ2EombkcC
         Vpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NAMOnkH/hQzTqE2MEDKvDzak0AhyVO2rIspP4ZVIx1U=;
        b=anrNW261tOcewAh7MwhgVIPxdTJtvhAmsf+h16Ib1BwLR6+IV6ayw72ETIfnRQDV+u
         ChZ1wqXE1SE/7L46VA3b8R9P89Xc/PmX37EQo1RmMuSlhIGWkgFunBEppkkVb4fXCL9F
         kl/UIesJGs6WJ/ZrnNUctV1fnqb7yKBVjPivuyY+4ffr99td8c0U1lLW5VruKD7p4cvf
         xessP6Z2GqWBl7+jqAp1Si47RxSBVMrUocZzzpq5oMAt4Jou+ZlIn0L0xx0vXUbzxCHl
         NOKBIksg17q5AJakDnuq/DIDXT/o+e0GR3LmyS1hx0RPqoP7yGVXgYXj8UN+oaQgnp3W
         FP+Q==
X-Gm-Message-State: AFqh2kpgeR8H1kXb/jf5YksAmJnmv1jI01lk4Mmy7Rn7x7cRk8K8eniq
        wbWgQqMlsVv/gYn9BEpe7I//8dLGhSJJnOm8
X-Google-Smtp-Source: AMrXdXucwvVajwPhn+nT7Ms1H/CJ6Va7ZJ9v1yD9UacHT3y0jbqCzm9IDH9ypHCd4URCuy1DE6OlyA==
X-Received: by 2002:ac2:5142:0:b0:4cb:2260:8553 with SMTP id q2-20020ac25142000000b004cb22608553mr4942442lfd.30.1672755685378;
        Tue, 03 Jan 2023 06:21:25 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id bi2-20020a0565120e8200b004b543f38b7csm4864965lfb.21.2023.01.03.06.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 06:21:24 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] interconnect: qcom: qcm2290: Fix MASTER_SNOC_BIMC_NRT
Date:   Tue,  3 Jan 2023 15:21:20 +0100
Message-Id: <20230103142120.15605-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to what seems to be a copy-paste error, the _NRT master was
identical to the _RT master, which should not be the case.. Fix it
using the values available from the downstream kernel [1].

[1] https://android.googlesource.com/kernel/msm-extra/devicetree/+/refs/heads/android-msm-bramble-4.19-android11-qpr1/qcom/scuba-bus.dtsi#127
Fixes: 1a14b1ac3935 ("interconnect: qcom: Add QCM2290 driver support")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Not tested on real hw.

 drivers/interconnect/qcom/qcm2290.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index 0da612d6398c..a29cdb4fac03 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -147,9 +147,9 @@ static struct qcom_icc_node mas_snoc_bimc_nrt = {
 	.name = "mas_snoc_bimc_nrt",
 	.buswidth = 16,
 	.qos.ap_owned = true,
-	.qos.qos_port = 2,
+	.qos.qos_port = 3,
 	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.mas_rpm_id = 163,
+	.mas_rpm_id = 164,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_snoc_bimc_nrt_links),
 	.links = mas_snoc_bimc_nrt_links,
-- 
2.39.0

