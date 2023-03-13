Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C7C6B7E07
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjCMQsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjCMQr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:47:57 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDEA4ECB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:47:55 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id r27so16507587lfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678726074;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x1uoGKzLAXBUkyNmRs0A2xTpan5M4G0tgCrVSoJtpBc=;
        b=cG+ViNLH/d0+n9qEk/2TFGM3YeXdUGZ+hApT39zxPV5MzDigN3W8qXwjUyf6pcricB
         iyMLAw8hs5ct8H9xgFyPWSWZvia9QMHuEXSfa3s+pi1xKW4I4orKqlSTxvCBM4lvgc1f
         D7bqlrhit81YpWiZWtv16SzuVRcDvpBx/W9K4Fia0qtJGfIqIFWWObtojN8cDaMfSTEg
         RH1lDqyVjDsm3Zs85o6qJILMtjcMOdMVCs2q2McFWUkJDfTq7kp5+HnIDOJ55b4rfS+B
         TR5F5L+nsbgi3qgXv8ZY61qT233pr+7+G75IcQ8NKAPwIh2c99/E2zooNJuEpNgxS2js
         /kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678726074;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1uoGKzLAXBUkyNmRs0A2xTpan5M4G0tgCrVSoJtpBc=;
        b=0qAptpvbchLpXtMB7K+bw3z02tVSCRfQr2DgAhIyFU4Zk622+zStKLrW6k72aNtWOc
         dLXD8iPFaTWBin8Gtex1nmNySB5ywFPRg4JHbTZZ+9kFCbu1fApWGqNWyAkOhMao48DR
         7HreVz2hNVTYluYc4m8+6nNRD6r2/kMSC+OIjQuC3lxKuVSqtUvJ+m9DNsPtZONi2JEo
         owrkzR+fZs6Ss2qUnAAKch98mHT0ovrW5uy3G+3EX5pYjeBLg5JIYmUQQ/VcQ9hFLJtU
         d+GV0C5zAxTjWhfIUoGKaX7Pca89VK/qdfVfT5LCJ9A1xLjKgESGUrJ3CxYcJQBqMozx
         vhBw==
X-Gm-Message-State: AO0yUKUkAZT4LkGSNc5jEqPImjxZE78fTyjSdNU5FXaBvq6kukB2InTE
        L0KaWB0fBhQYlor4xUmkA3kJXpwqY2ybZBJtR/c=
X-Google-Smtp-Source: AK7set/WwGydMFFPJwmA/CpovW7BQowLubLv6owjSYZJBVvhQ+y/QDqvC1gWxaK7q2/eSJw3B1moVQ==
X-Received: by 2002:ac2:4c06:0:b0:4dd:a73f:aede with SMTP id t6-20020ac24c06000000b004dda73faedemr9283626lfq.10.1678726074571;
        Mon, 13 Mar 2023 09:47:54 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id o9-20020a05651238a900b004db48ae69cbsm18134lft.206.2023.03.13.09.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 09:47:54 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 13 Mar 2023 17:44:19 +0100
Subject: [PATCH v3 4/6] arm64: dts: qcom: sm8150: Add qcom,smmu-500 to
 Adreno SMMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230313-topic-gpu_smmu_bindings-v3-4-66ab655fbfd5@linaro.org>
References: <20230313-topic-gpu_smmu_bindings-v3-0-66ab655fbfd5@linaro.org>
In-Reply-To: <20230313-topic-gpu_smmu_bindings-v3-0-66ab655fbfd5@linaro.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678726067; l=837;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=KEsliZlOIcDQaV+cqniF+0sHSB9mJmRUzLY9Wt6vcmU=;
 b=h6sOjJYcZqDh3xbHkwfILJ6nbDmG50BUEdrbvG8Am5IIj1fWh78gsqz9DJ2DLcY6GcYMsXLNXEGA
 Fe31hEAZCv3F1xGn7/BD+/+PfrB8boPVfv5xp9G/h9eWGazcjxZo
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

Add the fallback Qualcomm SMMU500 compatible to the Adreno SMMU.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 13e0ce828606..c94765302f1b 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -2249,7 +2249,8 @@ gpucc: clock-controller@2c90000 {
 		};
 
 		adreno_smmu: iommu@2ca0000 {
-			compatible = "qcom,sm8150-smmu-500", "qcom,adreno-smmu", "arm,mmu-500";
+			compatible = "qcom,sm8150-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
 			reg = <0 0x02ca0000 0 0x10000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <1>;

-- 
2.39.2

