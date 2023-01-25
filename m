Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EBF67A93D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 04:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbjAYD2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 22:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbjAYD1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 22:27:50 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF29CBB
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 19:27:42 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id os24so502092ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 19:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjBTcip9GugGxYq/eh5xnxoFH1qNNiynXAfWfYKtmlE=;
        b=IzN+R/YOb/lLRBYFmoiLAzqCSVueby8HK8EyqvEDw93fLI+pgRw89Jao3rXW29Qwe0
         APzltYeqYYiXkvjGBeg2rId0WZJQttyjCv66nNkvW+lYMJZFydFlMrMsuxcWBmgFY3Aa
         CWTd1mJ+HGVH+Zx/NfJwBRDbWq8dRlUrVqOc2yG5Y/4OXXdj+DYLXKvB0kxuo4yXGZcB
         9ENLFrD7rLgzQ6ZiplPDLb9275SuJSfk8EwPsmGIkY7IJ5jE4GBNNQ9sJMZy+TQvZO36
         YCyD4P3112OINV23yvvXZWBUm+azvWL3vOKc8s25kjEfagSitBmb6ZtBE3HJY2qDy+Yv
         x9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjBTcip9GugGxYq/eh5xnxoFH1qNNiynXAfWfYKtmlE=;
        b=2IagJo/rx8BcvjRfMeJ4IJjEOXGeOX9cEdElP4iL1qgnW6Sdw308QRx13syzUbn7Za
         cG4GvnQxzm9bYCsxjuiTYJo/DnB0g4fCXkQCTA144MVWDmsPOdZs3QAO0YwB66o5C/be
         ZUcxFyCUvehR6zkMs9faMeDIatCYztL2kU3S2YdHRBo5TF4aY4Lhqe0vqiZL6akyWH0+
         ePMZCxYzpkIB/CoVcD1VoX66T+gm5PvVEEIP9GnLF51OUVWp0WVKozMBYrvBHF5kOuq2
         fwu+w0vR8yN0z/SHaHhUnZmmdrFu7OnkkKLODxQeal2kGVgSIARqBCDXqAv6ubicFx3j
         n9rA==
X-Gm-Message-State: AFqh2krZqo2wHZZSvNwEg7UhkAHtvAlNxAJwiK7CPTE0yAooYP07CGN7
        vne3EFMqxfoXLbr+Ybei7A9aAA==
X-Google-Smtp-Source: AMrXdXuYa2NdOk7jPvsgBLy62PmFb42khwLLr9oSRlDgu13huuqf4UBwob++g/aL47O0RqCWrXrcWA==
X-Received: by 2002:a17:906:3f87:b0:809:c1f4:ea09 with SMTP id b7-20020a1709063f8700b00809c1f4ea09mr29747093ejj.69.1674617259535;
        Tue, 24 Jan 2023 19:27:39 -0800 (PST)
Received: from localhost.localdomain (abyl109.neoplus.adsl.tpnet.pl. [83.9.31.109])
        by smtp.gmail.com with ESMTPSA id if10-20020a170906df4a00b00738795e7d9bsm1742913ejc.2.2023.01.24.19.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 19:27:39 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] soc: qcom: rpmpd: Remove useless comments
Date:   Wed, 25 Jan 2023 04:27:26 +0100
Message-Id: <20230125032728.611640-6-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125032728.611640-1-konrad.dybcio@linaro.org>
References: <20230125032728.611640-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 9fff40527f9e..38a85a07fa67 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -68,7 +68,6 @@ struct rpmpd_desc {
 
 static DEFINE_MUTEX(rpmpd_lock);
 
-/* mdm9607 RPM Power Domains */
 static struct rpmpd cx_s3a_lvl_ao;
 static struct rpmpd cx_s3a_lvl = {
 	.pd = { .name = "vddcx", },
@@ -134,7 +133,6 @@ static const struct rpmpd_desc mdm9607_desc = {
 	.max_state = RPM_SMD_LEVEL_TURBO,
 };
 
-/* msm8226 RPM Power Domains */
 static struct rpmpd cx_s1a_corner_ao;
 static struct rpmpd cx_s1a_corner = {
 	.pd = { .name = "vddcx", },
@@ -172,7 +170,6 @@ static const struct rpmpd_desc msm8226_desc = {
 	.max_state = MAX_CORNER_RPMPD_STATE,
 };
 
-/* msm8939 RPM Power Domains */
 static struct rpmpd md_s1a_corner_ao;
 static struct rpmpd md_s1a_corner = {
 	.pd = { .name = "vddmd", },
@@ -258,7 +255,6 @@ static const struct rpmpd_desc msm8939_desc = {
 	.max_state = MAX_CORNER_RPMPD_STATE,
 };
 
-/* msm8916 RPM Power Domains */
 static struct rpmpd *msm8916_rpmpds[] = {
 	[MSM8916_VDDCX] =	&cx_s1a_corner,
 	[MSM8916_VDDCX_AO] =	&cx_s1a_corner_ao,
@@ -273,7 +269,6 @@ static const struct rpmpd_desc msm8916_desc = {
 	.max_state = MAX_CORNER_RPMPD_STATE,
 };
 
-/* msm8953 RPM Power Domains */
 static struct rpmpd md_s1a_lvl_ao;
 static struct rpmpd md_s1a_lvl = {
 	.pd = { .name = "vddmd", },
@@ -351,7 +346,6 @@ static const struct rpmpd_desc msm8953_desc = {
 	.max_state = RPM_SMD_LEVEL_TURBO,
 };
 
-/* msm8976 RPM Power Domains */
 static struct rpmpd mx_s6a_lvl_ao;
 static struct rpmpd mx_s6a_lvl = {
 	.pd = { .name = "vddmx", },
@@ -392,7 +386,6 @@ static const struct rpmpd_desc msm8976_desc = {
 	.max_state = RPM_SMD_LEVEL_TURBO_HIGH,
 };
 
-/* msm8994 RPM Power domains */
 static struct rpmpd mx_s2a_corner_ao;
 static struct rpmpd mx_s2a_corner = {
 	.pd = { .name = "vddmx", },
@@ -442,7 +435,6 @@ static const struct rpmpd_desc msm8994_desc = {
 	.max_state = MAX_CORNER_RPMPD_STATE,
 };
 
-/* msm8996 RPM Power domains */
 static struct rpmpd sscx_l26a_corner = {
 	.pd = { .name = "vddsscx", },
 	.res_type = RPMPD_LDOA,
@@ -473,7 +465,6 @@ static const struct rpmpd_desc msm8996_desc = {
 	.max_state = MAX_CORNER_RPMPD_STATE,
 };
 
-/* msm8998 RPM Power domains */
 static struct rpmpd rwcx0_lvl_ao;
 static struct rpmpd rwcx0_lvl = {
 	.pd = { .name = "vddcx", },
@@ -571,7 +562,6 @@ static const struct rpmpd_desc msm8998_desc = {
 	.max_state = RPM_SMD_LEVEL_BINNING,
 };
 
-/* qcs404 RPM Power domains */
 static struct rpmpd rwlc0_lvl = {
 	.pd = { .name = "vdd_lpi_cx", },
 	.res_type = RPMPD_RWLC,
@@ -616,7 +606,6 @@ static const struct rpmpd_desc qcs404_desc = {
 	.max_state = RPM_SMD_LEVEL_BINNING,
 };
 
-/* sdm660 RPM Power domains */
 static struct rpmpd *sdm660_rpmpds[] = {
 	[SDM660_VDDCX] =		&rwcx0_lvl,
 	[SDM660_VDDCX_AO] =		&rwcx0_lvl_ao,
@@ -636,7 +625,6 @@ static const struct rpmpd_desc sdm660_desc = {
 	.max_state = RPM_SMD_LEVEL_TURBO,
 };
 
-/* sm4250/6115 RPM Power domains */
 static struct rpmpd *sm6115_rpmpds[] = {
 	[SM6115_VDDCX] =		&rwcx0_lvl,
 	[SM6115_VDDCX_AO] =		&rwcx0_lvl_ao,
@@ -654,7 +642,6 @@ static const struct rpmpd_desc sm6115_desc = {
 	.max_state = RPM_SMD_LEVEL_TURBO_NO_CPR,
 };
 
-/* sm6125 RPM Power domains */
 static struct rpmpd *sm6125_rpmpds[] = {
 	[SM6125_VDDCX] =		&rwcx0_lvl,
 	[SM6125_VDDCX_AO] =		&rwcx0_lvl_ao,
-- 
2.39.1

