Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D67649E73
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 13:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiLLMLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 07:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiLLMLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 07:11:00 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B706167
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:10:59 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id cf42so18234371lfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ArZdgDUPTxxyHH9qYlQrCbZtI7IOKmLLf9ZbqR0krVg=;
        b=euJoDwYFzbm62Z2MoNPWwEh0uYkbDZZY5Ge2FXxsFmGKf8k35Tw5IyBCfaFR3xIuYW
         i5KD9wihfj0XjGvieZjDZneMohCZyhVsSmdu4QN++NKWb1Lz0uRB9c78yrNzGnG/qW8q
         BvdNUFd19wjl+xz3oHZanWNyR3v6Gf2DAl8vkURtOXaXTdr94MtUzuBECLaIuFUtrEB3
         KXgCzDdg+XG3SAN+esCfhrlOmynUDQfs7fvg+lCGvV3LIlcFTDLKsPNj7S07Rzix6AmV
         OwSHjBBTC62wSdr9InzccDj5Jlvcvfwj6vpq36jK901X3dRl3U13gK6zxHfckMI/uADH
         5pJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ArZdgDUPTxxyHH9qYlQrCbZtI7IOKmLLf9ZbqR0krVg=;
        b=YPIX4Vbs+uiyLoJ24jJlEfxGLSzbP8S0TXcn+DgRdBDEKn4YfLsOqZ4kcn6IXG7cQ+
         TiehYSx9Dz/DwTodpo5GDrwRc22DdGHlO7i7BhMJc+g9Dbvw4Et2jKuEhLhr/DG9PGdV
         XHE4VdMs36zyOYaXaiY8CE+RobpJTchmAcOEkrE9a/ztO6sr4HBTloaexiWLqGJyFHMs
         GKEnaWM6sOxC+dmntbcWfK0vxGaw0nn7NmcAqcKoyjsdGM0dhmBWcxT+C/jRQWsdGcpk
         krtuC+U6IstcLICESJbnE3puyLwUKbCEiDmjbNyC7L91THUNcdhmAPr2AZwrYUsjQbhh
         Fg0g==
X-Gm-Message-State: ANoB5pkIo/kIn6+I6hzUIDfGfbyNBPv7wgLgAgD6Oy1+g+sNwCKPtddt
        pC3CvfCbcKleaK265MRQdSmMaQ==
X-Google-Smtp-Source: AA0mqf4UwVm2QNGEWhCr8AWM3w7xJopx1vjnQH10HOcb31DgqEYIDHUbF+ieDqBsnWDwIh7npmW6Gw==
X-Received: by 2002:a05:6512:224a:b0:4a4:68b9:19fc with SMTP id i10-20020a056512224a00b004a468b919fcmr6308665lfu.36.1670847057942;
        Mon, 12 Dec 2022 04:10:57 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id c7-20020ac25f67000000b004b55ef84338sm1604592lfc.305.2022.12.12.04.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 04:10:57 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Emma Anholt <emma@anholt.net>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] iommu/arm-smmu-qcom: Add SM8150 DPU compatible
Date:   Mon, 12 Dec 2022 13:10:53 +0100
Message-Id: <20221212121054.193059-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.38.1
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

From: Marijn Suijten <marijn.suijten@somainline.org>

Add the SM8150 DPU compatible to clients compatible list, as it also
needs the workarounds.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes since v1:
- rebase on clean -next

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 91d404deb115..ed884c85e262 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -250,6 +250,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sc7280-mdss" },
 	{ .compatible = "qcom,sc7280-mss-pil" },
 	{ .compatible = "qcom,sc8180x-mdss" },
+	{ .compatible = "qcom,sm8150-mdss" },
 	{ .compatible = "qcom,sm8250-mdss" },
 	{ .compatible = "qcom,sdm845-mdss" },
 	{ .compatible = "qcom,sdm845-mss-pil" },
-- 
2.38.1

