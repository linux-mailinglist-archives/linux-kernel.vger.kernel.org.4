Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6257A6B820E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjCMUAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjCMUAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:00:18 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3B5848ED
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:00:17 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id s22so17198068lfi.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678737617;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pPJGmyWSQOR8Kw09B8Mt5WVgya5iFa+bc4j8CO+ggz0=;
        b=mvShdL4yBYq3XhrQ/GdtbIB+BcS1zqacbkjifgw2EkH2AFU22aywn6htkZqlw9UwGN
         ufIAkuvRXx3Jj2gC77V+imQ3c7RIYzOYMHGJaF4Y/DATt/T2+LPTNsPHSNo3nUH8P4Yr
         MacCYhvmwetNm2ok8IpSA8kyBDL2gzfSsFq1Ok/C31y871Waj58qoDpXuS4Sz1+ovhv6
         Ns/D92cZK3EcHwXXTj5kg+dAZ3312r6+K7AkZ+eej7+w3Q41qIcZ9+JqfvuA4CrFDqEY
         YFFJ36O4axm0tJEMbYn8iOQCtx5LefMMQYPvrvJknb7FzUiqJIszpMDEHu4sn19BHkxf
         bI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678737617;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPJGmyWSQOR8Kw09B8Mt5WVgya5iFa+bc4j8CO+ggz0=;
        b=DkXK+gTDg0imjitd/Emn7+MRevBGc/wXG8V367RHvrtqmmoBSBWmcgyqLaRp5CifvY
         7CcMP4B7RyqLUhrBoMwdQKr9EBPnrQj5naXYXagtWjzTdpAG1wDERBdR2z4ljXfc+zZl
         KFxAczYkSbWtLsFo/XUiCWIth2GpcFYMMYDSnZXvCrmn9yVaw16vOyjiOwRj/vrd7iq5
         u6fgF/KLXU04mVXB8v7qenFJIVPVI97/2wuRYSWAK59vfsEveNqgNUQN6OLXpMWzAKlB
         AneaixPKl7uGQmcY9tGKUvkrAG9XFXT2V8o00ewaQ/KRWKRZJPhyhGHiz4oq5gZ29Dtb
         2QFA==
X-Gm-Message-State: AO0yUKWbkj/3Q6RWtyofafr/RxF3bhRf18wEkYBXemFRuk8rXLMDuZXX
        qmyTdondGF3RL4iQ4ktBesQGFQ==
X-Google-Smtp-Source: AK7set8VLIGQmRJ6bzAhX79qPSYOmRtGAHzXCIFZA+GKP1EESmU41oQxnJC2V3ep+cxHbfMRTgjPqg==
X-Received: by 2002:a19:7516:0:b0:4dc:8215:5531 with SMTP id y22-20020a197516000000b004dc82155531mr10488291lfe.6.1678737617071;
        Mon, 13 Mar 2023 13:00:17 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id w3-20020ac254a3000000b004cc800b1f2csm75431lfk.238.2023.03.13.13.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 13:00:16 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 13 Mar 2023 21:00:08 +0100
Subject: [PATCH v3 10/10] soc: qcom: rpmpd: Remove useless comments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230313-topic-rpmpd-v3-10-06a4f448ff90@linaro.org>
References: <20230313-topic-rpmpd-v3-0-06a4f448ff90@linaro.org>
In-Reply-To: <20230313-topic-rpmpd-v3-0-06a4f448ff90@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678737603; l=3977;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=bOHyvIQlgUtTwAbq7sTRhqnwQEdIyL2gK1RO1F45Xro=;
 b=W4lHZVIWj64yHXpeNN4lxidb0hTaZz7y23XGHt7ll/VMQk+KxQB8/RcsngW0CcjspDzIe2auTizT
 d4Eai3dRD5tWVpBbN8RDD6J96WLtiOHy71Xw70wl/G8ihk4ds/F2
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It goes without saying that socname_rpmpds[] is the array of the RPM
power domains associated with socname. Remove these comments.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/rpmpd.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 84283719853c..f8397dcb146c 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -514,7 +514,6 @@ static struct rpmpd ssc_mx_rwsm0_vfl = {
 	.key = KEY_FLOOR_LEVEL,
 };
 
-/* mdm9607 RPM Power Domains */
 static struct rpmpd *mdm9607_rpmpds[] = {
 	[MDM9607_VDDCX] =	&cx_s3a_lvl,
 	[MDM9607_VDDCX_AO] =	&cx_s3a_lvl_ao,
@@ -530,7 +529,6 @@ static const struct rpmpd_desc mdm9607_desc = {
 	.max_state = RPM_SMD_LEVEL_TURBO,
 };
 
-/* msm8226 RPM Power Domains */
 static struct rpmpd *msm8226_rpmpds[] = {
 	[MSM8226_VDDCX] =	&cx_s1a_corner,
 	[MSM8226_VDDCX_AO] =	&cx_s1a_corner_ao,
@@ -543,7 +541,6 @@ static const struct rpmpd_desc msm8226_desc = {
 	.max_state = MAX_CORNER_RPMPD_STATE,
 };
 
-/* msm8939 RPM Power Domains */
 static struct rpmpd *msm8939_rpmpds[] = {
 	[MSM8939_VDDMDCX] =	&md_s1a_corner,
 	[MSM8939_VDDMDCX_AO] =	&md_s1a_corner_ao,
@@ -561,7 +558,6 @@ static const struct rpmpd_desc msm8939_desc = {
 	.max_state = MAX_CORNER_RPMPD_STATE,
 };
 
-/* msm8916 RPM Power Domains */
 static struct rpmpd *msm8916_rpmpds[] = {
 	[MSM8916_VDDCX] =	&cx_s1a_corner,
 	[MSM8916_VDDCX_AO] =	&cx_s1a_corner_ao,
@@ -576,7 +572,6 @@ static const struct rpmpd_desc msm8916_desc = {
 	.max_state = MAX_CORNER_RPMPD_STATE,
 };
 
-/* msm8953 RPM Power Domains */
 static struct rpmpd *msm8953_rpmpds[] = {
 	[MSM8953_VDDMD] =	&md_s1a_lvl,
 	[MSM8953_VDDMD_AO] =	&md_s1a_lvl_ao,
@@ -593,7 +588,6 @@ static const struct rpmpd_desc msm8953_desc = {
 	.max_state = RPM_SMD_LEVEL_TURBO,
 };
 
-/* msm8976 RPM Power Domains */
 static struct rpmpd *msm8976_rpmpds[] = {
 	[MSM8976_VDDCX] =	&cx_s2a_lvl,
 	[MSM8976_VDDCX_AO] =	&cx_s2a_lvl_ao,
@@ -609,7 +603,6 @@ static const struct rpmpd_desc msm8976_desc = {
 	.max_state = RPM_SMD_LEVEL_TURBO_HIGH,
 };
 
-/* msm8994 RPM Power domains */
 static struct rpmpd *msm8994_rpmpds[] = {
 	[MSM8994_VDDCX] =	&cx_s1a_corner,
 	[MSM8994_VDDCX_AO] =	&cx_s1a_corner_ao,
@@ -628,7 +621,6 @@ static const struct rpmpd_desc msm8994_desc = {
 	.max_state = MAX_CORNER_RPMPD_STATE,
 };
 
-/* msm8996 RPM Power domains */
 static struct rpmpd *msm8996_rpmpds[] = {
 	[MSM8996_VDDCX] =	&cx_s1a_corner,
 	[MSM8996_VDDCX_AO] =	&cx_s1a_corner_ao,
@@ -645,7 +637,6 @@ static const struct rpmpd_desc msm8996_desc = {
 	.max_state = MAX_CORNER_RPMPD_STATE,
 };
 
-/* msm8998 RPM Power domains */
 static struct rpmpd *msm8998_rpmpds[] = {
 	[MSM8998_VDDCX] =	&cx_rwcx0_lvl,
 	[MSM8998_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
@@ -665,7 +656,6 @@ static const struct rpmpd_desc msm8998_desc = {
 	.max_state = RPM_SMD_LEVEL_BINNING,
 };
 
-/* qcs404 RPM Power domains */
 static struct rpmpd *qcs404_rpmpds[] = {
 	[QCS404_VDDMX] =	&mx_rwmx0_lvl,
 	[QCS404_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
@@ -682,7 +672,6 @@ static const struct rpmpd_desc qcs404_desc = {
 	.max_state = RPM_SMD_LEVEL_BINNING,
 };
 
-/* sdm660 RPM Power domains */
 static struct rpmpd *sdm660_rpmpds[] = {
 	[SDM660_VDDCX] =	&cx_rwcx0_lvl,
 	[SDM660_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
@@ -702,7 +691,6 @@ static const struct rpmpd_desc sdm660_desc = {
 	.max_state = RPM_SMD_LEVEL_TURBO,
 };
 
-/* sm4250/6115 RPM Power domains */
 static struct rpmpd *sm6115_rpmpds[] = {
 	[SM6115_VDDCX] =	&cx_rwcx0_lvl,
 	[SM6115_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
@@ -720,7 +708,6 @@ static const struct rpmpd_desc sm6115_desc = {
 	.max_state = RPM_SMD_LEVEL_TURBO_NO_CPR,
 };
 
-/* sm6125 RPM Power domains */
 static struct rpmpd *sm6125_rpmpds[] = {
 	[SM6125_VDDCX] =	&cx_rwcx0_lvl,
 	[SM6125_VDDCX_AO] =	&cx_rwcx0_lvl_ao,

-- 
2.39.2

