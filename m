Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE56B669C38
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjAMPam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjAMP3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:29:50 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423F47EC97
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:22:38 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id f34so33576989lfv.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ANsyJifEncSP92lLk3miSuvqvxDpZXt5DLlwH0kSeYg=;
        b=WIXZCl3srJseLgQX9neHOCK7tyE77OWiZNrNYCUffzMHjMR1Ubr+HyPObwJ6K+l7th
         4YLcHeG1/m9TqNpnqCxbkoaN6ITL4NeRHYHZ4U8UNXg7qN+tniRChAW6BZgDVNCDqbre
         82Wke+fhJXldtTPBrUh4glO52u5jdprrihNBY5c+c2LzdyKeBqkxTceEZUYgVxtfCNKp
         nSZJNk/2tiztZSXnpVa4CmxIB4wEDOncttA1EqOn/1cuPBCUaL9XPCYFahgRi6GXMrKQ
         cadAwiKnKmU5v2Ph86s5TuH3oxfzbQC6/zDUHS+oZLEJKP6Jcr/MSWfsh0tYw3Fr1MoQ
         hANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANsyJifEncSP92lLk3miSuvqvxDpZXt5DLlwH0kSeYg=;
        b=5+qyle6dwrARl12PriF/2kIIGrN4OVth6eXuf93gpREyRIdiZdnyN+Y2i6BPgs1Hn2
         rgL55dDnGkx1IWV9EHXBfDRRriOpQPfPzel/robPqWRM53zs61Wls+nx4GLyZ+04fsD6
         q2ogQOL1VxyvTapO6+K2+jBPgwf6yAzQq/XtpNThXeLx1wvahqFR7lhQ3AsVfAarr+Sj
         zU2cH+s6Z2BfOz++Ah2MPrW8GIx9s/JfL3jUSF4VgHBF7zoFmmePJ9ftOvwzv6kyOA/f
         RA4kcDhV7U0H+GWn6nI8GP2ErWHPRjf33EdqD/z+IXQHl/Badb5abSjg2bBnds0kYoD0
         /6WA==
X-Gm-Message-State: AFqh2koTrcPcCJwpocUyfAnYVbIlINoSna7esPNhGCIxj3RCPNnDdzkI
        qybLzqO981jAQn3Clj0D60yyfA==
X-Google-Smtp-Source: AMrXdXuvRKKfnLv0K6fkFCJ+VqdzGZXYnnyMmAWDagBwdzXXeg47jDWiaaCTc9oqRgG8p7X7oLxWrA==
X-Received: by 2002:a05:6512:e86:b0:4b5:b87a:3262 with SMTP id bi6-20020a0565120e8600b004b5b87a3262mr25559492lfb.28.1673623356522;
        Fri, 13 Jan 2023 07:22:36 -0800 (PST)
Received: from localhost.localdomain (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id c19-20020a056512325300b004cb3d77a936sm3875440lfr.46.2023.01.13.07.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 07:22:35 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Revert "soc: qcom: rpmpd: Add SM4250 support"
Date:   Fri, 13 Jan 2023 16:22:31 +0100
Message-Id: <20230113152232.2624545-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM4250 and SM6115 use a shared device tree and the RPMPDs are
identical. There's no need for a separate entry, so remove it.

This reverts commit 5b617b1b10c1c6a4365d8f956032e95c53b8e388.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/rpmpd.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index f0db6a10cf4e..337b1ad1cd3b 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -471,23 +471,6 @@ static const struct rpmpd_desc qcm2290_desc = {
 	.max_state = RPM_SMD_LEVEL_TURBO_NO_CPR,
 };
 
-static struct rpmpd *sm4250_rpmpds[] = {
-	[SM4250_VDDCX] = &sm6115_vddcx,
-	[SM4250_VDDCX_AO] = &sm6115_vddcx_ao,
-	[SM4250_VDDCX_VFL] = &sm6115_vddcx_vfl,
-	[SM4250_VDDMX] = &sm6115_vddmx,
-	[SM4250_VDDMX_AO] = &sm6115_vddmx_ao,
-	[SM4250_VDDMX_VFL] = &sm6115_vddmx_vfl,
-	[SM4250_VDD_LPI_CX] = &sm6115_vdd_lpi_cx,
-	[SM4250_VDD_LPI_MX] = &sm6115_vdd_lpi_mx,
-};
-
-static const struct rpmpd_desc sm4250_desc = {
-	.rpmpds = sm4250_rpmpds,
-	.num_pds = ARRAY_SIZE(sm4250_rpmpds),
-	.max_state = RPM_SMD_LEVEL_TURBO_NO_CPR,
-};
-
 static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,mdm9607-rpmpd", .data = &mdm9607_desc },
 	{ .compatible = "qcom,msm8226-rpmpd", .data = &msm8226_desc },
@@ -502,7 +485,6 @@ static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,qcm2290-rpmpd", .data = &qcm2290_desc },
 	{ .compatible = "qcom,qcs404-rpmpd", .data = &qcs404_desc },
 	{ .compatible = "qcom,sdm660-rpmpd", .data = &sdm660_desc },
-	{ .compatible = "qcom,sm4250-rpmpd", .data = &sm4250_desc },
 	{ .compatible = "qcom,sm6115-rpmpd", .data = &sm6115_desc },
 	{ .compatible = "qcom,sm6125-rpmpd", .data = &sm6125_desc },
 	{ .compatible = "qcom,sm6375-rpmpd", .data = &sm6375_desc },
-- 
2.39.0

