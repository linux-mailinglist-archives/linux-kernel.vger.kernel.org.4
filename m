Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5706B8209
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjCMUAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCMUAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:00:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12A484F7C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:00:15 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j11so17173639lfg.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678737614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AhUCHQPlRXS+mV3kTLelC8M+6kMoYMw8+TMBacyA8g8=;
        b=zzEoKuoR/hNIgJkosv298ADrIKONyEudV5DI9qd6JAQ+WE8eGpkncrxBIu12dsHK2R
         XaJDyGI0ccdCnHc6hBYqFOyi0m8KIDgDk5zsJ9aCkHmQ0dQBfP5H95g/tyH1Fx/XZRXo
         5SQi7twyOl4vTfx0N0k98kBMTWNOfU91RsypYQrSbbPXhRsdOyoIZUR5Tf29cOi5Mv/V
         TOToQa9vUcsYEVZZPO1t/Y0Iylu9ZR0GUdOFsxnmQ9kZ3byJgalDDGIvs7lntLg5dBjP
         7VWvJg9O3Jo3lGLt674FJmv8MllQ8Lsn9OcnveU2MhnWL8j9sFjbFQbs1Po+u2vuCe/V
         hZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678737614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhUCHQPlRXS+mV3kTLelC8M+6kMoYMw8+TMBacyA8g8=;
        b=kHL+ycyVeYJLJPYxU1Z9xqiZAUzHGHvMRWu52cKyk2TCwQ6xlid3xyEgx/bwHTWhOj
         4aiP9K1Khmv0Rdp8dqlYhirs44TUapi6EbbmMYiZEm3Hbwvk1s/puG0dXvA60HgLOyCX
         Lan3Y9GRxxIKPTc0LNx0Eg2I+RStcemNeYhNQKTAHUQACgL7EG+ebKT8yUXvPBwr5X7S
         nTm7DaOYJ8htfcMuxwv5fYbcakoEhwW+t32iAw6/bxWUvdSOSM9G2vpOW3yxZ7ZoNjG7
         sHWjB1bdQHsZpfcsdz7OSPJTuRsO5Nrf4VUoXNZKB6Xyu1GNnuVOLNtNvsF+ZgZDg1Gk
         q3Uw==
X-Gm-Message-State: AO0yUKUNuOFbFYP+jN+XuF7Jvych2nPJD6Z0dKZbZ0IabsQ0HYkUj7Du
        bYEvpG5AsWkjll7z43C6zPeieg==
X-Google-Smtp-Source: AK7set/sgSVSpkYhgllHoVdWvwIzGkqZzWjTqXHti8aC3Ok1etDnk5Nj8UZYxtiqpGnCzVMekeaPAg==
X-Received: by 2002:ac2:508e:0:b0:4d8:6540:a72c with SMTP id f14-20020ac2508e000000b004d86540a72cmr12057957lfm.46.1678737613957;
        Mon, 13 Mar 2023 13:00:13 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id w3-20020ac254a3000000b004cc800b1f2csm75431lfk.238.2023.03.13.13.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 13:00:13 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 13 Mar 2023 21:00:05 +0100
Subject: [PATCH v3 07/10] soc: qcom: rpmpd: Make bindings assignments
 consistent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230313-topic-rpmpd-v3-7-06a4f448ff90@linaro.org>
References: <20230313-topic-rpmpd-v3-0-06a4f448ff90@linaro.org>
In-Reply-To: <20230313-topic-rpmpd-v3-0-06a4f448ff90@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678737603; l=6724;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=cigtUdQxgWMxGG+FwC1vw++eB/ESgbd4f6sEt5LcGTI=;
 b=ChyDMZdCyiyexhSKe48uXnxKCh2GvDJ9HBtqBg6GaJwL75OUzBbUtoL/aMRCODGswDXR+42aLGsa
 ZtUfRDVoAkGzXqxKUUnuQEhFFtTPDigIAKZQc8ZNsAzsVJtx3mGA
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

Currently the whitespace between [DT_BINDING] = &struct is all over
the place.. some SoC structs have a space, others have a tab, others
have N tabs.. Make that a single tab for everybody to keep things
coherent.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/rpmpd.c | 118 +++++++++++++++++++++++------------------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 695b2fc56f40..946630d82b3d 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -642,16 +642,16 @@ static const struct rpmpd_desc msm8996_desc = {
 
 /* msm8998 RPM Power domains */
 static struct rpmpd *msm8998_rpmpds[] = {
-	[MSM8998_VDDCX] =		&cx_rwcx0_lvl,
-	[MSM8998_VDDCX_AO] =		&cx_rwcx0_lvl_ao,
-	[MSM8998_VDDCX_VFL] =		&cx_rwcx0_vfl,
-	[MSM8998_VDDMX] =		&mx_rwmx0_lvl,
-	[MSM8998_VDDMX_AO] =		&mx_rwmx0_lvl_ao,
-	[MSM8998_VDDMX_VFL] =		&mx_rwmx0_vfl,
-	[MSM8998_SSCCX] =		&ssc_cx_rwsc0_lvl,
-	[MSM8998_SSCCX_VFL] =		&ssc_cx_rwsc0_vfl,
-	[MSM8998_SSCMX] =		&ssc_mx_rwsm0_lvl,
-	[MSM8998_SSCMX_VFL] =		&ssc_mx_rwsm0_vfl,
+	[MSM8998_VDDCX] =	&cx_rwcx0_lvl,
+	[MSM8998_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
+	[MSM8998_VDDCX_VFL] =	&cx_rwcx0_vfl,
+	[MSM8998_VDDMX] =	&mx_rwmx0_lvl,
+	[MSM8998_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
+	[MSM8998_VDDMX_VFL] =	&mx_rwmx0_vfl,
+	[MSM8998_SSCCX] =	&ssc_cx_rwsc0_lvl,
+	[MSM8998_SSCCX_VFL] =	&ssc_cx_rwsc0_vfl,
+	[MSM8998_SSCMX] =	&ssc_mx_rwsm0_lvl,
+	[MSM8998_SSCMX_VFL] =	&ssc_mx_rwsm0_vfl,
 };
 
 static const struct rpmpd_desc msm8998_desc = {
@@ -662,13 +662,13 @@ static const struct rpmpd_desc msm8998_desc = {
 
 /* qcs404 RPM Power domains */
 static struct rpmpd *qcs404_rpmpds[] = {
-	[QCS404_VDDMX] = &mx_rwmx0_lvl,
-	[QCS404_VDDMX_AO] = &mx_rwmx0_lvl_ao,
-	[QCS404_VDDMX_VFL] = &mx_rwmx0_vfl,
-	[QCS404_LPICX] = &lpi_cx_rwlc0_lvl,
-	[QCS404_LPICX_VFL] = &lpi_cx_rwlc0_vfl,
-	[QCS404_LPIMX] = &lpi_mx_rwlm0_lvl,
-	[QCS404_LPIMX_VFL] = &lpi_mx_rwlm0_vfl,
+	[QCS404_VDDMX] =	&mx_rwmx0_lvl,
+	[QCS404_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
+	[QCS404_VDDMX_VFL] =	&mx_rwmx0_vfl,
+	[QCS404_LPICX] =	&lpi_cx_rwlc0_lvl,
+	[QCS404_LPICX_VFL] =	&lpi_cx_rwlc0_vfl,
+	[QCS404_LPIMX] =	&lpi_mx_rwlm0_lvl,
+	[QCS404_LPIMX_VFL] =	&lpi_mx_rwlm0_vfl,
 };
 
 static const struct rpmpd_desc qcs404_desc = {
@@ -679,16 +679,16 @@ static const struct rpmpd_desc qcs404_desc = {
 
 /* sdm660 RPM Power domains */
 static struct rpmpd *sdm660_rpmpds[] = {
-	[SDM660_VDDCX] =		&cx_rwcx0_lvl,
-	[SDM660_VDDCX_AO] =		&cx_rwcx0_lvl_ao,
-	[SDM660_VDDCX_VFL] =		&cx_rwcx0_vfl,
-	[SDM660_VDDMX] =		&mx_rwmx0_lvl,
-	[SDM660_VDDMX_AO] =		&mx_rwmx0_lvl_ao,
-	[SDM660_VDDMX_VFL] =		&mx_rwmx0_vfl,
-	[SDM660_SSCCX] =		&ssc_cx_rwlc0_lvl,
-	[SDM660_SSCCX_VFL] =		&ssc_cx_rwlc0_vfl,
-	[SDM660_SSCMX] =		&ssc_mx_rwlm0_lvl,
-	[SDM660_SSCMX_VFL] =		&ssc_mx_rwlm0_vfl,
+	[SDM660_VDDCX] =	&cx_rwcx0_lvl,
+	[SDM660_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
+	[SDM660_VDDCX_VFL] =	&cx_rwcx0_vfl,
+	[SDM660_VDDMX] =	&mx_rwmx0_lvl,
+	[SDM660_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
+	[SDM660_VDDMX_VFL] =	&mx_rwmx0_vfl,
+	[SDM660_SSCCX] =	&ssc_cx_rwlc0_lvl,
+	[SDM660_SSCCX_VFL] =	&ssc_cx_rwlc0_vfl,
+	[SDM660_SSCMX] =	&ssc_mx_rwlm0_lvl,
+	[SDM660_SSCMX_VFL] =	&ssc_mx_rwlm0_vfl,
 };
 
 static const struct rpmpd_desc sdm660_desc = {
@@ -699,14 +699,14 @@ static const struct rpmpd_desc sdm660_desc = {
 
 /* sm4250/6115 RPM Power domains */
 static struct rpmpd *sm6115_rpmpds[] = {
-	[SM6115_VDDCX] =		&cx_rwcx0_lvl,
-	[SM6115_VDDCX_AO] =		&cx_rwcx0_lvl_ao,
-	[SM6115_VDDCX_VFL] =		&cx_rwcx0_vfl,
-	[SM6115_VDDMX] =		&mx_rwmx0_lvl,
-	[SM6115_VDDMX_AO] =		&mx_rwmx0_lvl_ao,
-	[SM6115_VDDMX_VFL] =		&mx_rwmx0_vfl,
-	[SM6115_VDD_LPI_CX] =		&lpi_cx_rwlc0_lvl,
-	[SM6115_VDD_LPI_MX] =		&lpi_mx_rwlm0_lvl,
+	[SM6115_VDDCX] =	&cx_rwcx0_lvl,
+	[SM6115_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
+	[SM6115_VDDCX_VFL] =	&cx_rwcx0_vfl,
+	[SM6115_VDDMX] =	&mx_rwmx0_lvl,
+	[SM6115_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
+	[SM6115_VDDMX_VFL] =	&mx_rwmx0_vfl,
+	[SM6115_VDD_LPI_CX] =	&lpi_cx_rwlc0_lvl,
+	[SM6115_VDD_LPI_MX] =	&lpi_mx_rwlm0_lvl,
 };
 
 static const struct rpmpd_desc sm6115_desc = {
@@ -717,12 +717,12 @@ static const struct rpmpd_desc sm6115_desc = {
 
 /* sm6125 RPM Power domains */
 static struct rpmpd *sm6125_rpmpds[] = {
-	[SM6125_VDDCX] =		&cx_rwcx0_lvl,
-	[SM6125_VDDCX_AO] =		&cx_rwcx0_lvl_ao,
-	[SM6125_VDDCX_VFL] =		&cx_rwcx0_vfl,
-	[SM6125_VDDMX] =		&mx_rwmx0_lvl,
-	[SM6125_VDDMX_AO] =		&mx_rwmx0_lvl_ao,
-	[SM6125_VDDMX_VFL] =		&mx_rwmx0_vfl,
+	[SM6125_VDDCX] =	&cx_rwcx0_lvl,
+	[SM6125_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
+	[SM6125_VDDCX_VFL] =	&cx_rwcx0_vfl,
+	[SM6125_VDDMX] =	&mx_rwmx0_lvl,
+	[SM6125_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
+	[SM6125_VDDMX_VFL] =	&mx_rwmx0_vfl,
 };
 
 static const struct rpmpd_desc sm6125_desc = {
@@ -732,16 +732,16 @@ static const struct rpmpd_desc sm6125_desc = {
 };
 
 static struct rpmpd *sm6375_rpmpds[] = {
-	[SM6375_VDDCX] = &cx_rwcx0_lvl,
-	[SM6375_VDDCX_AO] = &cx_rwcx0_lvl_ao,
-	[SM6375_VDDCX_VFL] = &cx_rwcx0_vfl,
-	[SM6375_VDDMX] = &mx_rwmx0_lvl,
-	[SM6375_VDDMX_AO] = &mx_rwmx0_lvl_ao,
-	[SM6375_VDDMX_VFL] = &mx_rwmx0_vfl,
-	[SM6375_VDDGX] = &gx_rwgx0_lvl,
-	[SM6375_VDDGX_AO] = &gx_rwgx0_lvl_ao,
-	[SM6375_VDD_LPI_CX] = &lpi_cx_rwlc0_lvl,
-	[SM6375_VDD_LPI_MX] = &lpi_mx_rwlm0_lvl,
+	[SM6375_VDDCX] =	&cx_rwcx0_lvl,
+	[SM6375_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
+	[SM6375_VDDCX_VFL] =	&cx_rwcx0_vfl,
+	[SM6375_VDDMX] =	&mx_rwmx0_lvl,
+	[SM6375_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
+	[SM6375_VDDMX_VFL] =	&mx_rwmx0_vfl,
+	[SM6375_VDDGX] =	&gx_rwgx0_lvl,
+	[SM6375_VDDGX_AO] =	&gx_rwgx0_lvl_ao,
+	[SM6375_VDD_LPI_CX] =	&lpi_cx_rwlc0_lvl,
+	[SM6375_VDD_LPI_MX] =	&lpi_mx_rwlm0_lvl,
 };
 
 static const struct rpmpd_desc sm6375_desc = {
@@ -751,14 +751,14 @@ static const struct rpmpd_desc sm6375_desc = {
 };
 
 static struct rpmpd *qcm2290_rpmpds[] = {
-	[QCM2290_VDDCX] = &cx_rwcx0_lvl,
-	[QCM2290_VDDCX_AO] = &cx_rwcx0_lvl_ao,
-	[QCM2290_VDDCX_VFL] = &cx_rwcx0_vfl,
-	[QCM2290_VDDMX] = &mx_rwmx0_lvl,
-	[QCM2290_VDDMX_AO] = &mx_rwmx0_lvl_ao,
-	[QCM2290_VDDMX_VFL] = &mx_rwmx0_vfl,
-	[QCM2290_VDD_LPI_CX] = &lpi_cx_rwlc0_lvl,
-	[QCM2290_VDD_LPI_MX] = &lpi_mx_rwlm0_lvl,
+	[QCM2290_VDDCX] =	&cx_rwcx0_lvl,
+	[QCM2290_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
+	[QCM2290_VDDCX_VFL] =	&cx_rwcx0_vfl,
+	[QCM2290_VDDMX] =	&mx_rwmx0_lvl,
+	[QCM2290_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
+	[QCM2290_VDDMX_VFL] =	&mx_rwmx0_vfl,
+	[QCM2290_VDD_LPI_CX] =	&lpi_cx_rwlc0_lvl,
+	[QCM2290_VDD_LPI_MX] =	&lpi_mx_rwlm0_lvl,
 };
 
 static const struct rpmpd_desc qcm2290_desc = {

-- 
2.39.2

