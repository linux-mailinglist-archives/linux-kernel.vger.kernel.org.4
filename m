Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44CB63C9CE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbiK2Urh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbiK2UrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:47:14 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333A12D750;
        Tue, 29 Nov 2022 12:47:09 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bp15so23824805lfb.13;
        Tue, 29 Nov 2022 12:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+igg1gFuxyIK8r4AnuQnEHqMeR4rDkdTFliuJlyj0JM=;
        b=lRwYr9F0Zw7I3YQ0P9z9pp1EX9rne1nUteWkaBxGAC87U1MVYlEKocHFExnO83ZiIX
         n9PmIULoYTL6zFHiWYRJLhbOt9ZRxPmu1wQqA9Y02l1GMZkHV1SV/k3rMeL06ipx//+l
         LydoEVTbtDB4vui/RdCx+G+EaBysE2VMUGAVzcW+k92swDZwYHU4DwCSeFspBxX3L5Ns
         TPTCRW842OTLdpUncNgKezqpZOsdDK6XqOZLs6IZpJUDbQTcytlFFocihSTgnlDvOhhP
         lnKwMk/5+gbFuw1t35naeNeR3m/q/Lrf/hVRFxGUMR/qzVsRvYsxjRoAuWC90r1q1MRX
         JbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+igg1gFuxyIK8r4AnuQnEHqMeR4rDkdTFliuJlyj0JM=;
        b=3yfiLvxyhMEOX7hL7rYTTuF9udBOctWXe+QDv5+aesSF3EcnvZQK1HaQ8qSebq+7Kc
         oeyaU/RRaR6kEoMU00Px47o5G0I+BPzKVRoZufa0DxMJju7fh7Fj6EX/cmHywO95jBir
         ytdRi6HkTlFI0BUdoPXgYrFH4EU2ReCCLmEb1lrG6WzWhvjbm4TcUNjpkkBq+FJ+81Nk
         22tTPciDg6F+HunZFmY9k2Ig0VUpCWmZNXl6w1FWaiTonBMaZGTL6oJb7AesEYW9fjrP
         rXXkDBVjb2uPCQiVbI64gry5uXarb/3mTP4vwfHHHWy+AsdXnfAkltUJhue7yPfg84VS
         0ZYg==
X-Gm-Message-State: ANoB5plk3kBoBnmXesxuU/R9S+iD88H1uQPXAa0+VmxQ8uRyFlsOXzwL
        7OuqrFgSuzZfLEJhaIgHO06R/TeKsqc=
X-Google-Smtp-Source: AA0mqf5qYiLSLg45KeZgp/qeZDddSwrnn3Urj3rngk0Idy5+JbkuX+KEXzDkZD0uvEVUUBOMSQxyHQ==
X-Received: by 2002:ac2:5f6d:0:b0:4b4:f9df:c6a4 with SMTP id c13-20020ac25f6d000000b004b4f9dfc6a4mr8544566lfc.19.1669754827578;
        Tue, 29 Nov 2022 12:47:07 -0800 (PST)
Received: from localhost.localdomain (ccy110.neoplus.adsl.tpnet.pl. [83.30.148.110])
        by smtp.gmail.com with ESMTPSA id o11-20020ac24e8b000000b004ae24368195sm2325620lfr.233.2022.11.29.12.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 12:47:07 -0800 (PST)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 07/12] arm64: dts: qcom: sm6115: Add dispcc node
Date:   Tue, 29 Nov 2022 21:46:11 +0100
Message-Id: <20221129204616.47006-8-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221129204616.47006-1-a39.skl@gmail.com>
References: <20221129204616.47006-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add display clock controller to allow controlling display related clocks.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 6d14bbcda9d3..ea0e0b3c5d84 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/clock/qcom,gcc-sm6115.h>
+#include <dt-bindings/clock/qcom,sm6115-dispcc.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -717,6 +718,19 @@ usb_1_dwc3: usb@4e00000 {
 			};
 		};
 
+		dispcc: clock-controller@5f00000 {
+			compatible = "qcom,sm6115-dispcc";
+			reg = <0x05f00000 0x20000>;
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+				 <&sleep_clk>,
+				 <&dsi0_phy 0>,
+				 <&dsi0_phy 1>,
+				 <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		apps_smmu: iommu@c600000 {
 			compatible = "qcom,sm6115-smmu-500", "arm,mmu-500";
 			reg = <0x0c600000 0x80000>;
-- 
2.25.1

