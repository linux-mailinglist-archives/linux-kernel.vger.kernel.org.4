Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECD567A940
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 04:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbjAYD2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 22:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbjAYD1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 22:27:51 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDB483D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 19:27:44 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id vw16so44169436ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 19:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cief22734797WLDji2/FiBHV81HsLlTLIjX7CLjaTOI=;
        b=qr3JfmufZtzlwaTKlB6fcSo6b305UALGQXcBhxrKzE+ijkP3z/S6yLySjSqUKw0MEv
         P9ue8Hf4a0tWL2TKPmjHGF79Zc4sZvSl/sHqFhPgWGmompy1UP0mm9ptAfiJz7imQR7V
         9OHHCe4XC61N93JA2XRSLy6voxA4DHR279bxy2gwfym5B0uJ9+zfGoxYBUFC582f59Zs
         34ezuR4SICD3FFtqk77VTxpYk+vzJNMGStw/mlDNp4VACPLyh8M5wlAWEDcGJ2kXR5sz
         +gf6oJqoIgEkPfwnEiA+0fbtnoWb31ZBztxgy9cRlPJg8HdiK3Yj9J0ixGeZ9CyKqYhK
         64sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cief22734797WLDji2/FiBHV81HsLlTLIjX7CLjaTOI=;
        b=pxJrx61AdmABKNODNAadO+mjznma5nwTBLmf00ynG0DAPSG7wOjguF1hh4b84jYhPD
         1BNzycbbkbxWrWnvkQfxruw9oSk6wAcFP1yFuNkLNo+vSeF7303PrC+FY/2UDb3rkW4d
         /icnF8XJZ/9+tKsb3tW4tLRY1oXTpiitv8NOl6Fd4uVL/3/O8E1LqeIdDJLMDRD4Wohd
         mkddvROMUmQOEfUtZwhFaTyTFP7u8gNWpwgDINiCeJQmwD8yT9+joG47FSMnjcisTiE9
         hMH8RyC0ETW+p/NjeUDOQe8akTwL7Firo7Y3lyImd+EwSmJJuOUQP9MyoMWp1EcZTyAN
         uzVg==
X-Gm-Message-State: AFqh2kreA0rtRyowX+Qxw9kkBs4Ett1J5Lgc1cNvIcL39nAKA80dXm/y
        Z6ru7G1hjNUsUKD+DfLGHD3O8g==
X-Google-Smtp-Source: AMrXdXurwtd5M69j9S698o4730diroz1ESxFgNbeO/qFNQau/6JuTJA9T6LXZlNxx3VKMVClhakhCg==
X-Received: by 2002:a17:907:d401:b0:872:1b27:1a43 with SMTP id vi1-20020a170907d40100b008721b271a43mr35217202ejc.31.1674617262730;
        Tue, 24 Jan 2023 19:27:42 -0800 (PST)
Received: from localhost.localdomain (abyl109.neoplus.adsl.tpnet.pl. [83.9.31.109])
        by smtp.gmail.com with ESMTPSA id if10-20020a170906df4a00b00738795e7d9bsm1742913ejc.2.2023.01.24.19.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 19:27:42 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] soc: qcom: rpmpd: Make bindings assignments consistent
Date:   Wed, 25 Jan 2023 04:27:28 +0100
Message-Id: <20230125032728.611640-8-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125032728.611640-1-konrad.dybcio@linaro.org>
References: <20230125032728.611640-1-konrad.dybcio@linaro.org>
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

Currently the whitespace between [DT_BINDING] = &struct is all over
the place.. some SoC structs have a space, others have a tab, others
have N tabs.. Make that a single space for everybody to keep things
coherent.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/rpmpd.c | 164 +++++++++++++++++++--------------------
 1 file changed, 82 insertions(+), 82 deletions(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index ca4e18cb9e84..8f34fd826cbb 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -474,12 +474,12 @@ static struct rpmpd sscx_l26a_corner_vfc = {
 };
 
 static struct rpmpd *mdm9607_rpmpds[] = {
-	[MDM9607_VDDCX] =	&cx_s3a_lvl,
-	[MDM9607_VDDCX_AO] =	&cx_s3a_lvl_ao,
-	[MDM9607_VDDCX_VFL] =	&cx_s3a_lvl_vfl,
-	[MDM9607_VDDMX] =		&mx_l12a_lvl,
-	[MDM9607_VDDMX_AO] =	&mx_l12a_lvl_ao,
-	[MDM9607_VDDMX_VFL] =	&mx_l12a_lvl_vfl,
+	[MDM9607_VDDCX] = &cx_s3a_lvl,
+	[MDM9607_VDDCX_AO] = &cx_s3a_lvl_ao,
+	[MDM9607_VDDCX_VFL] = &cx_s3a_lvl_vfl,
+	[MDM9607_VDDMX] = &mx_l12a_lvl,
+	[MDM9607_VDDMX_AO] = &mx_l12a_lvl_ao,
+	[MDM9607_VDDMX_VFL] = &mx_l12a_lvl_vfl,
 };
 
 static const struct rpmpd_desc mdm9607_desc = {
@@ -489,9 +489,9 @@ static const struct rpmpd_desc mdm9607_desc = {
 };
 
 static struct rpmpd *msm8226_rpmpds[] = {
-	[MSM8226_VDDCX] =	&cx_s1a_corner,
-	[MSM8226_VDDCX_AO] =	&cx_s1a_corner_ao,
-	[MSM8226_VDDCX_VFC] =	&cx_s1a_corner_vfc,
+	[MSM8226_VDDCX] = &cx_s1a_corner,
+	[MSM8226_VDDCX_AO] = &cx_s1a_corner_ao,
+	[MSM8226_VDDCX_VFC] = &cx_s1a_corner_vfc,
 };
 
 static const struct rpmpd_desc msm8226_desc = {
@@ -501,14 +501,14 @@ static const struct rpmpd_desc msm8226_desc = {
 };
 
 static struct rpmpd *msm8939_rpmpds[] = {
-	[MSM8939_VDDMDCX] =	&md_s1a_corner,
-	[MSM8939_VDDMDCX_AO] =	&md_s1a_corner_ao,
-	[MSM8939_VDDMDCX_VFC] =	&md_s1a_corner_vfc,
-	[MSM8939_VDDCX] =	&cx_s2a_corner,
-	[MSM8939_VDDCX_AO] =	&cx_s2a_corner_ao,
-	[MSM8939_VDDCX_VFC] =	&cx_s2a_corner_vfc,
-	[MSM8939_VDDMX] =	&mx_l3a_corner,
-	[MSM8939_VDDMX_AO] =	&mx_l3a_corner_ao,
+	[MSM8939_VDDMDCX] = &md_s1a_corner,
+	[MSM8939_VDDMDCX_AO] = &md_s1a_corner_ao,
+	[MSM8939_VDDMDCX_VFC] = &md_s1a_corner_vfc,
+	[MSM8939_VDDCX] = &cx_s2a_corner,
+	[MSM8939_VDDCX_AO] = &cx_s2a_corner_ao,
+	[MSM8939_VDDCX_VFC] = &cx_s2a_corner_vfc,
+	[MSM8939_VDDMX] = &mx_l3a_corner,
+	[MSM8939_VDDMX_AO] = &mx_l3a_corner_ao,
 };
 
 static const struct rpmpd_desc msm8939_desc = {
@@ -518,11 +518,11 @@ static const struct rpmpd_desc msm8939_desc = {
 };
 
 static struct rpmpd *msm8916_rpmpds[] = {
-	[MSM8916_VDDCX] =	&cx_s1a_corner,
-	[MSM8916_VDDCX_AO] =	&cx_s1a_corner_ao,
-	[MSM8916_VDDCX_VFC] =	&cx_s1a_corner_vfc,
-	[MSM8916_VDDMX] =	&mx_l3a_corner,
-	[MSM8916_VDDMX_AO] =	&mx_l3a_corner_ao,
+	[MSM8916_VDDCX] = &cx_s1a_corner,
+	[MSM8916_VDDCX_AO] = &cx_s1a_corner_ao,
+	[MSM8916_VDDCX_VFC] = &cx_s1a_corner_vfc,
+	[MSM8916_VDDMX] = &mx_l3a_corner,
+	[MSM8916_VDDMX_AO] = &mx_l3a_corner_ao,
 };
 
 static const struct rpmpd_desc msm8916_desc = {
@@ -532,13 +532,13 @@ static const struct rpmpd_desc msm8916_desc = {
 };
 
 static struct rpmpd *msm8953_rpmpds[] = {
-	[MSM8953_VDDMD] =	&md_s1a_lvl,
-	[MSM8953_VDDMD_AO] =	&md_s1a_lvl_ao,
-	[MSM8953_VDDCX] =	&cx_s2a_lvl,
-	[MSM8953_VDDCX_AO] =	&cx_s2a_lvl_ao,
-	[MSM8953_VDDCX_VFL] =	&cx_s2a_lvl_vfl,
-	[MSM8953_VDDMX] =	&mx_s7a_lvl,
-	[MSM8953_VDDMX_AO] =	&mx_s7a_lvl_ao,
+	[MSM8953_VDDMD] = &md_s1a_lvl,
+	[MSM8953_VDDMD_AO] = &md_s1a_lvl_ao,
+	[MSM8953_VDDCX] = &cx_s2a_lvl,
+	[MSM8953_VDDCX_AO] = &cx_s2a_lvl_ao,
+	[MSM8953_VDDCX_VFL] = &cx_s2a_lvl_vfl,
+	[MSM8953_VDDMX] = &mx_s7a_lvl,
+	[MSM8953_VDDMX_AO] = &mx_s7a_lvl_ao,
 };
 
 static const struct rpmpd_desc msm8953_desc = {
@@ -548,12 +548,12 @@ static const struct rpmpd_desc msm8953_desc = {
 };
 
 static struct rpmpd *msm8976_rpmpds[] = {
-	[MSM8976_VDDCX] =	&cx_s2a_lvl,
-	[MSM8976_VDDCX_AO] =	&cx_s2a_lvl_ao,
-	[MSM8976_VDDCX_VFL] =	&cx_s2a_lvl_vfl,
-	[MSM8976_VDDMX] =	&mx_s6a_lvl,
-	[MSM8976_VDDMX_AO] =	&mx_s6a_lvl_ao,
-	[MSM8976_VDDMX_VFL] =	&mx_s6a_lvl_vfl,
+	[MSM8976_VDDCX] = &cx_s2a_lvl,
+	[MSM8976_VDDCX_AO] = &cx_s2a_lvl_ao,
+	[MSM8976_VDDCX_VFL] = &cx_s2a_lvl_vfl,
+	[MSM8976_VDDMX] = &mx_s6a_lvl,
+	[MSM8976_VDDMX_AO] = &mx_s6a_lvl_ao,
+	[MSM8976_VDDMX_VFL] = &mx_s6a_lvl_vfl,
 };
 
 static const struct rpmpd_desc msm8976_desc = {
@@ -563,13 +563,13 @@ static const struct rpmpd_desc msm8976_desc = {
 };
 
 static struct rpmpd *msm8994_rpmpds[] = {
-	[MSM8994_VDDCX] =	&cx_s1a_corner,
-	[MSM8994_VDDCX_AO] =	&cx_s1a_corner_ao,
-	[MSM8994_VDDCX_VFC] =	&cx_s1a_corner_vfc,
-	[MSM8994_VDDMX] =	&mx_s2a_corner,
-	[MSM8994_VDDMX_AO] =	&mx_s2a_corner_ao,
-	[MSM8994_VDDGFX] =	&gfx_s2b_corner,
-	[MSM8994_VDDGFX_VFC] =	&gfx_s2b_corner_vfc,
+	[MSM8994_VDDCX] = &cx_s1a_corner,
+	[MSM8994_VDDCX_AO] = &cx_s1a_corner_ao,
+	[MSM8994_VDDCX_VFC] = &cx_s1a_corner_vfc,
+	[MSM8994_VDDMX] = &mx_s2a_corner,
+	[MSM8994_VDDMX_AO] = &mx_s2a_corner_ao,
+	[MSM8994_VDDGFX] = &gfx_s2b_corner,
+	[MSM8994_VDDGFX_VFC] = &gfx_s2b_corner_vfc,
 };
 
 static const struct rpmpd_desc msm8994_desc = {
@@ -579,12 +579,12 @@ static const struct rpmpd_desc msm8994_desc = {
 };
 
 static struct rpmpd *msm8996_rpmpds[] = {
-	[MSM8996_VDDCX] =	&cx_s1a_corner,
-	[MSM8996_VDDCX_AO] =	&cx_s1a_corner_ao,
-	[MSM8996_VDDCX_VFC] =	&cx_s1a_corner_vfc,
-	[MSM8996_VDDMX] =	&mx_s2a_corner,
-	[MSM8996_VDDMX_AO] =	&mx_s2a_corner_ao,
-	[MSM8996_VDDSSCX] =	&sscx_l26a_corner,
+	[MSM8996_VDDCX] = &cx_s1a_corner,
+	[MSM8996_VDDCX_AO] = &cx_s1a_corner_ao,
+	[MSM8996_VDDCX_VFC] = &cx_s1a_corner_vfc,
+	[MSM8996_VDDMX] = &mx_s2a_corner,
+	[MSM8996_VDDMX_AO] = &mx_s2a_corner_ao,
+	[MSM8996_VDDSSCX] = &sscx_l26a_corner,
 	[MSM8996_VDDSSCX_VFC] =	&sscx_l26a_corner_vfc,
 };
 
@@ -595,16 +595,16 @@ static const struct rpmpd_desc msm8996_desc = {
 };
 
 static struct rpmpd *msm8998_rpmpds[] = {
-	[MSM8998_VDDCX] =		&rwcx0_lvl,
-	[MSM8998_VDDCX_AO] =		&rwcx0_lvl_ao,
-	[MSM8998_VDDCX_VFL] =		&rwcx0_lvl_vfl,
-	[MSM8998_VDDMX] =		&rwmx0_lvl,
-	[MSM8998_VDDMX_AO] =		&rwmx0_lvl_ao,
-	[MSM8998_VDDMX_VFL] =		&rwmx0_lvl_vfl,
-	[MSM8998_SSCCX] =		&rwsc0_lvl,
-	[MSM8998_SSCCX_VFL] =		&rwsc0_lvl_vfl,
-	[MSM8998_SSCMX] =		&rwsm0_lvl,
-	[MSM8998_SSCMX_VFL] =		&rwsm0_lvl_vfl,
+	[MSM8998_VDDCX] = &rwcx0_lvl,
+	[MSM8998_VDDCX_AO] = &rwcx0_lvl_ao,
+	[MSM8998_VDDCX_VFL] = &rwcx0_lvl_vfl,
+	[MSM8998_VDDMX] = &rwmx0_lvl,
+	[MSM8998_VDDMX_AO] = &rwmx0_lvl_ao,
+	[MSM8998_VDDMX_VFL] = &rwmx0_lvl_vfl,
+	[MSM8998_SSCCX] = &rwsc0_lvl,
+	[MSM8998_SSCCX_VFL] = &rwsc0_lvl_vfl,
+	[MSM8998_SSCMX] = &rwsm0_lvl,
+	[MSM8998_SSCMX_VFL] = &rwsm0_lvl_vfl,
 };
 
 static const struct rpmpd_desc msm8998_desc = {
@@ -630,16 +630,16 @@ static const struct rpmpd_desc qcs404_desc = {
 };
 
 static struct rpmpd *sdm660_rpmpds[] = {
-	[SDM660_VDDCX] =		&rwcx0_lvl,
-	[SDM660_VDDCX_AO] =		&rwcx0_lvl_ao,
-	[SDM660_VDDCX_VFL] =		&rwcx0_lvl_vfl,
-	[SDM660_VDDMX] =		&rwmx0_lvl,
-	[SDM660_VDDMX_AO] =		&rwmx0_lvl_ao,
-	[SDM660_VDDMX_VFL] =		&rwmx0_lvl_vfl,
-	[SDM660_SSCCX] =		&rwlc0_lvl,
-	[SDM660_SSCCX_VFL] =		&rwlc0_lvl_vfl,
-	[SDM660_SSCMX] =		&rwlm0_lvl,
-	[SDM660_SSCMX_VFL] =		&rwlm0_lvl_vfl,
+	[SDM660_VDDCX] = &rwcx0_lvl,
+	[SDM660_VDDCX_AO] = &rwcx0_lvl_ao,
+	[SDM660_VDDCX_VFL] = &rwcx0_lvl_vfl,
+	[SDM660_VDDMX] = &rwmx0_lvl,
+	[SDM660_VDDMX_AO] = &rwmx0_lvl_ao,
+	[SDM660_VDDMX_VFL] = &rwmx0_lvl_vfl,
+	[SDM660_SSCCX] = &rwlc0_lvl,
+	[SDM660_SSCCX_VFL] = &rwlc0_lvl_vfl,
+	[SDM660_SSCMX] = &rwlm0_lvl,
+	[SDM660_SSCMX_VFL] = &rwlm0_lvl_vfl,
 };
 
 static const struct rpmpd_desc sdm660_desc = {
@@ -649,14 +649,14 @@ static const struct rpmpd_desc sdm660_desc = {
 };
 
 static struct rpmpd *sm6115_rpmpds[] = {
-	[SM6115_VDDCX] =		&rwcx0_lvl,
-	[SM6115_VDDCX_AO] =		&rwcx0_lvl_ao,
-	[SM6115_VDDCX_VFL] =		&rwcx0_lvl_vfl,
-	[SM6115_VDDMX] =		&rwmx0_lvl,
-	[SM6115_VDDMX_AO] =		&rwmx0_lvl_ao,
-	[SM6115_VDDMX_VFL] =		&rwmx0_lvl_vfl,
-	[SM6115_VDD_LPI_CX] =		&rwlc0_lvl,
-	[SM6115_VDD_LPI_MX] =		&rwlm0_lvl,
+	[SM6115_VDDCX] = &rwcx0_lvl,
+	[SM6115_VDDCX_AO] = &rwcx0_lvl_ao,
+	[SM6115_VDDCX_VFL] = &rwcx0_lvl_vfl,
+	[SM6115_VDDMX] = &rwmx0_lvl,
+	[SM6115_VDDMX_AO] = &rwmx0_lvl_ao,
+	[SM6115_VDDMX_VFL] = &rwmx0_lvl_vfl,
+	[SM6115_VDD_LPI_CX] = &rwlc0_lvl,
+	[SM6115_VDD_LPI_MX] = &rwlm0_lvl,
 };
 
 static const struct rpmpd_desc sm6115_desc = {
@@ -666,12 +666,12 @@ static const struct rpmpd_desc sm6115_desc = {
 };
 
 static struct rpmpd *sm6125_rpmpds[] = {
-	[SM6125_VDDCX] =		&rwcx0_lvl,
-	[SM6125_VDDCX_AO] =		&rwcx0_lvl_ao,
-	[SM6125_VDDCX_VFL] =		&rwcx0_lvl_vfl,
-	[SM6125_VDDMX] =		&rwmx0_lvl,
-	[SM6125_VDDMX_AO] =		&rwmx0_lvl_ao,
-	[SM6125_VDDMX_VFL] =		&rwmx0_lvl_vfl,
+	[SM6125_VDDCX] = &rwcx0_lvl,
+	[SM6125_VDDCX_AO] = &rwcx0_lvl_ao,
+	[SM6125_VDDCX_VFL] = &rwcx0_lvl_vfl,
+	[SM6125_VDDMX] = &rwmx0_lvl,
+	[SM6125_VDDMX_AO] = &rwmx0_lvl_ao,
+	[SM6125_VDDMX_VFL] = &rwmx0_lvl_vfl,
 };
 
 static const struct rpmpd_desc sm6125_desc = {
-- 
2.39.1

