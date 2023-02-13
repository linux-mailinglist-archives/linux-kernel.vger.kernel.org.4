Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33634694832
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjBMOgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjBMOft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:35:49 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B601C313
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:35:44 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id qw12so32415308ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZJcfvCSvUtQxtItfdcJH8PeBiAB1ahPgwFkFtnDsas=;
        b=OcymAMpRYavlUNz7FEhzM9zQQSgj7BMch0z6rdIgDzfy/CHxgk3jIk9C9XCUvl5DFC
         HBWV/eJm67PgsYCDPFuDwcE35tAulEX0b1Xt6JBFhe5n5fTaoVTwFFrV7DPB5YNefjtM
         bQVUNtDPzNnp7Rca8Smk2Oz1xHAyvByRRmPn5CIfWlOmSCaeAZzhNSLnfVdCqbbBO97p
         6Ql3Ib4Nm550ZH4S+aJ6+JEDNaNKgvCxrel+1I1LyxTQw6z5/wFZlEYohkl6rx78BguF
         9dnU6r3WuW655iM1hsZ0HQEC2IZC7E6gY6McaPbsnU0HqZyAHLqcVxwkN6HCX8etl2i5
         58jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZJcfvCSvUtQxtItfdcJH8PeBiAB1ahPgwFkFtnDsas=;
        b=rK4PbeOKHWdRxN0rABKRIYxCnV5M9EUckn4F7ktkGZ+AAztscJHTGGB1J+r9nom8Yx
         Z1/YxLECTV0U90LmMPHuuFobBqPX8qaGtiJOqiooSXfntDMXNCc5muJoIoRPiVCNRUMz
         vmEwZ8tNltElor/Fuoh0grl24HGWXaj6xmWe7P3y8Zai+ne/iBfZYLpBivMsXvjU5vor
         1Yvx0ZzH8QwpVHySE1v9jghnnJHoyl61mrVl9LKqglctV8g+kiaW5YcuzrB5xYwMxY/t
         2W/xUuZNeQ3fWrUfo+GarCRSiGznENEYT9yzg9he4kVP4OaKa0DLawStFqDlpjPuDqiM
         Qxew==
X-Gm-Message-State: AO0yUKXb8czTHOw/awlx5tJ7F+aBec+NFRTINPNi0MsS0G06rGTxv5yx
        jfOQ3MkYz9v72vspkfiUkJxBmA==
X-Google-Smtp-Source: AK7set+YCk2E9ObqdTcG0kOHcJ+1M85kSGgcnIofOjofxE7nOebarhKvd+3NCL2ORy/orpG9gLRvPw==
X-Received: by 2002:a17:906:3686:b0:8a4:e0a2:e774 with SMTP id a6-20020a170906368600b008a4e0a2e774mr21359741ejc.29.1676298943227;
        Mon, 13 Feb 2023 06:35:43 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id uz6-20020a170907118600b0088a2397cb2csm6927186ejb.143.2023.02.13.06.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 06:35:42 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] soc: qcom: rpmpd: Remove useless comments
Date:   Mon, 13 Feb 2023 15:35:24 +0100
Message-Id: <20230213143524.1943754-10-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213143524.1943754-1-konrad.dybcio@linaro.org>
References: <20230213143524.1943754-1-konrad.dybcio@linaro.org>
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

It goes without saying that socname_rpmpds[] is the array of the RPM
power domains associated with socname. Remove these comments.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/rpmpd.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 2669c9210754..fe1eaf5c2979 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -513,7 +513,6 @@ static struct rpmpd ssc_mx_rwsm0_vfl = {
 	.key = KEY_FLOOR_LEVEL,
 };
 
-/* mdm9607 RPM Power Domains */
 static struct rpmpd *mdm9607_rpmpds[] = {
 	[MDM9607_VDDCX] =	&cx_s3a_lvl,
 	[MDM9607_VDDCX_AO] =	&cx_s3a_lvl_ao,
@@ -529,7 +528,6 @@ static const struct rpmpd_desc mdm9607_desc = {
 	.max_state = RPM_SMD_LEVEL_TURBO,
 };
 
-/* msm8226 RPM Power Domains */
 static struct rpmpd *msm8226_rpmpds[] = {
 	[MSM8226_VDDCX] =	&cx_s1a_corner,
 	[MSM8226_VDDCX_AO] =	&cx_s1a_corner_ao,
@@ -542,7 +540,6 @@ static const struct rpmpd_desc msm8226_desc = {
 	.max_state = MAX_CORNER_RPMPD_STATE,
 };
 
-/* msm8939 RPM Power Domains */
 static struct rpmpd *msm8939_rpmpds[] = {
 	[MSM8939_VDDMDCX] =	&md_s1a_corner,
 	[MSM8939_VDDMDCX_AO] =	&md_s1a_corner_ao,
@@ -560,7 +557,6 @@ static const struct rpmpd_desc msm8939_desc = {
 	.max_state = MAX_CORNER_RPMPD_STATE,
 };
 
-/* msm8916 RPM Power Domains */
 static struct rpmpd *msm8916_rpmpds[] = {
 	[MSM8916_VDDCX] =	&cx_s1a_corner,
 	[MSM8916_VDDCX_AO] =	&cx_s1a_corner_ao,
@@ -575,7 +571,6 @@ static const struct rpmpd_desc msm8916_desc = {
 	.max_state = MAX_CORNER_RPMPD_STATE,
 };
 
-/* msm8953 RPM Power Domains */
 static struct rpmpd *msm8953_rpmpds[] = {
 	[MSM8953_VDDMD] =	&md_s1a_lvl,
 	[MSM8953_VDDMD_AO] =	&md_s1a_lvl_ao,
@@ -592,7 +587,6 @@ static const struct rpmpd_desc msm8953_desc = {
 	.max_state = RPM_SMD_LEVEL_TURBO,
 };
 
-/* msm8976 RPM Power Domains */
 static struct rpmpd *msm8976_rpmpds[] = {
 	[MSM8976_VDDCX] =	&cx_s2a_lvl,
 	[MSM8976_VDDCX_AO] =	&cx_s2a_lvl_ao,
@@ -608,7 +602,6 @@ static const struct rpmpd_desc msm8976_desc = {
 	.max_state = RPM_SMD_LEVEL_TURBO_HIGH,
 };
 
-/* msm8994 RPM Power domains */
 static struct rpmpd *msm8994_rpmpds[] = {
 	[MSM8994_VDDCX] =	&cx_s1a_corner,
 	[MSM8994_VDDCX_AO] =	&cx_s1a_corner_ao,
@@ -627,7 +620,6 @@ static const struct rpmpd_desc msm8994_desc = {
 	.max_state = MAX_CORNER_RPMPD_STATE,
 };
 
-/* msm8996 RPM Power domains */
 static struct rpmpd *msm8996_rpmpds[] = {
 	[MSM8996_VDDCX] =	&cx_s1a_corner,
 	[MSM8996_VDDCX_AO] =	&cx_s1a_corner_ao,
@@ -644,7 +636,6 @@ static const struct rpmpd_desc msm8996_desc = {
 	.max_state = MAX_CORNER_RPMPD_STATE,
 };
 
-/* msm8998 RPM Power domains */
 static struct rpmpd *msm8998_rpmpds[] = {
 	[MSM8998_VDDCX] =	&cx_rwcx0_lvl,
 	[MSM8998_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
@@ -664,7 +655,6 @@ static const struct rpmpd_desc msm8998_desc = {
 	.max_state = RPM_SMD_LEVEL_BINNING,
 };
 
-/* qcs404 RPM Power domains */
 static struct rpmpd *qcs404_rpmpds[] = {
 	[QCS404_VDDMX] =	&mx_rwmx0_lvl,
 	[QCS404_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
@@ -681,7 +671,6 @@ static const struct rpmpd_desc qcs404_desc = {
 	.max_state = RPM_SMD_LEVEL_BINNING,
 };
 
-/* sdm660 RPM Power domains */
 static struct rpmpd *sdm660_rpmpds[] = {
 	[SDM660_VDDCX] =	&cx_rwcx0_lvl,
 	[SDM660_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
@@ -701,7 +690,6 @@ static const struct rpmpd_desc sdm660_desc = {
 	.max_state = RPM_SMD_LEVEL_TURBO,
 };
 
-/* sm4250/6115 RPM Power domains */
 static struct rpmpd *sm6115_rpmpds[] = {
 	[SM6115_VDDCX] =	&cx_rwcx0_lvl,
 	[SM6115_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
@@ -719,7 +707,6 @@ static const struct rpmpd_desc sm6115_desc = {
 	.max_state = RPM_SMD_LEVEL_TURBO_NO_CPR,
 };
 
-/* sm6125 RPM Power domains */
 static struct rpmpd *sm6125_rpmpds[] = {
 	[SM6125_VDDCX] =	&cx_rwcx0_lvl,
 	[SM6125_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
-- 
2.39.1

