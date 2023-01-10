Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A4966436B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjAJOgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238568AbjAJOgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:36:50 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2897C431AB
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:36:48 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id d30so13835106lfv.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=093HGxT6kK1QzCS2QGIbQ7fTsuo/J9nz+14qeMtObLE=;
        b=nVdV/XoCNwttwqLoGVH7MM9i0VlTHoElwXCuFrvXPHpE8CY77kr44ETz68Mv382uSX
         naJjTAHcnvCcGG2mOzkHWuqeN3l1tupxxWPLEpl1QOuP+jtfdyFWHdlgcyLiyVk5p51t
         WKCeHnF+wqGFleFGXA/GgzH4rnJ1n9o5pa9vRTDuehtSqbpbuWXbPC4DsvKKhoKFbN1v
         KIEnqMjdxKZKYqhlQ/ij/zK+JDDc3ZB1aI1JtCR+5lZMWeY7bRqvPiLbbdtUd5i/vuEp
         i+AHeqFLpAbw6RAI2I/jfD93L63Sw9p2fTWkplQfWBPfsOZDaf8kMEA1x9NW0UfFxwl8
         2xQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=093HGxT6kK1QzCS2QGIbQ7fTsuo/J9nz+14qeMtObLE=;
        b=K2Dswd0KxvFtyfSN+PDYVgpZgzov2agoodrJLEazBLLV8Qm1cic5g1VdJnMoRtYEc1
         /ZrZmJWqg1EZbbC5C/e8FBFbGjCU8g8Knxs/P0iwza/SVQ4crLBsXPmKI5lR4kq2KBxB
         /DMQ845dVQBSQlU8FSwOxeuaUiHLDPtWU0jGWC2EtsWTTSCbq6PBUUL2LaLsLe3dTBbb
         kAUcdMC1q0L5nWzgRiZ9ewI/zHW0ZFSt/p1GXGgxAHabwpqQaUalNT6Kd4oTY1CINSE2
         eIaHAO9dMJgTxbmXK1ocW2qLKZWEXvuFDM8merzpMymNoZVogtjPOrfIPvLpYgf6mS3U
         5YBA==
X-Gm-Message-State: AFqh2krTkBBhz/Dhm7JfVkU7Sw5TO1V2LkC4LGS3xgN0cjsxbzu2wJYR
        kXlt0vi98D09gcBc7pIIOqqppA==
X-Google-Smtp-Source: AMrXdXsafxZsbdlOEbrmqK+20vrDozHu/BfovcYmL5qEy0vHwNVHtWEHyqO6qCRYRRzTrAW/zzMRXw==
X-Received: by 2002:a19:f001:0:b0:4b6:e4c8:8a48 with SMTP id p1-20020a19f001000000b004b6e4c88a48mr19602485lfc.63.1673361406396;
        Tue, 10 Jan 2023 06:36:46 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id p10-20020ac24eca000000b004cc87bea877sm637912lfr.65.2023.01.10.06.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 06:36:45 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: msm8998: Use RPM XO
Date:   Tue, 10 Jan 2023 15:36:42 +0100
Message-Id: <20230110143642.986799-1-konrad.dybcio@linaro.org>
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

Feed GCC and SDHC_2 with the RPM XO instead of the fixed-clock one.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 746f4e42a53f..4d59f4f8fc4a 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -809,7 +809,7 @@ gcc: clock-controller@100000 {
 			reg = <0x00100000 0xb0000>;
 
 			clock-names = "xo", "sleep_clk";
-			clocks = <&xo>, <&sleep_clk>;
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&sleep_clk>;
 
 			/*
 			 * The hypervisor typically configures the memory region where these clocks
@@ -2310,7 +2310,7 @@ sdhc2: mmc@c0a4900 {
 			clock-names = "iface", "core", "xo";
 			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
 				 <&gcc GCC_SDCC2_APPS_CLK>,
-				 <&xo>;
+				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
 			bus-width = <4>;
 			status = "disabled";
 		};
-- 
2.39.0

