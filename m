Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D18463E173
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiK3UMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiK3ULU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:11:20 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65189D83A;
        Wed, 30 Nov 2022 12:10:12 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id p8so28633777lfu.11;
        Wed, 30 Nov 2022 12:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjbRY6rd8FaKbUdJMDib6L2zePb+2secFfDnOJ1OhMQ=;
        b=S4NlJLu7Kc9c1YCCJnXGzDLUk8ADPQ7gJI0e+sUd5s/GpkA4GU8G8zBkoCQJdC8CcB
         znLbthkwC3cvPZnxlLpp5RNnjZyFQUGt3sjFp0cAk4Nqzl/rmsyoMMqHOBSS1QPMPdCg
         nS75VrVtlgjEelMpiaqnoFWuuJ4pk7hvqApAWKMGGitCA+C8bIWkUSUU9euw+BnbeNoW
         0WH0J73uRi2vXutY6mP3n3AaSHqf8pT5qSYQBVCStPbfSBu0kbU+KGhS/j85zCO12rF0
         Zzb+BxwmgymHXewGBq6Q0WtaCjXtlOJOmnk9kL+9KZ0NSIfD2pNqyvuQUJyv1MaJxWB9
         okXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjbRY6rd8FaKbUdJMDib6L2zePb+2secFfDnOJ1OhMQ=;
        b=TKyRrj9ltpkjeSuox+znQ4cbcGWRQ/YJxGiyv6Aayz7thFyhpWzEAE6q0euCxp9c9h
         jSuhRLefnbuJMMWucPQCu5F8L4ILyHbQzuzHvxXCP2sS9OpdgEGBCDXzz+BUQkh5ntl3
         7Nm1qgdXV2uyvefl60lIuCUOQxbhqWl0uMLEL57YMV1k69LOEETL9lmRncyKjY2C3M5t
         sDR7ErrDA9LxYG68Z3kfU0VtpiMLLooJLYz8kIXWHHAUzb8x82WJUX6yeQ1/7m2z1kHD
         TawC9ZVraK8CsHXkxPv4nAHqvHT8uSqWeluAzWOB/0sBv6Y3hKL1ne0HpD4sNQRzuHBB
         FoUQ==
X-Gm-Message-State: ANoB5pmna3av1ORBCauSJSpWZF3LrCRv45bfGhXEQxrQfSiqm3VMzsez
        aP+Ahok2mmUO4cM/HxXvPOvNqPnYEdg=
X-Google-Smtp-Source: AA0mqf4hBWIwa003WRRjczVmDE8qipVYmT9vidiXCDSEA3HNQpZvd20CNtMqv/6//p7atKR85IyFTw==
X-Received: by 2002:a19:4f14:0:b0:4b4:b20c:4b7 with SMTP id d20-20020a194f14000000b004b4b20c04b7mr15386197lfb.201.1669839012126;
        Wed, 30 Nov 2022 12:10:12 -0800 (PST)
Received: from localhost.localdomain (ccy110.neoplus.adsl.tpnet.pl. [83.30.148.110])
        by smtp.gmail.com with ESMTPSA id a25-20020a056512201900b004b4e9580b1asm369754lfb.66.2022.11.30.12.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 12:10:11 -0800 (PST)
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
Subject: [PATCH v2 07/12] arm64: dts: qcom: sm6115: Add dispcc node
Date:   Wed, 30 Nov 2022 21:09:45 +0100
Message-Id: <20221130200950.144618-8-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130200950.144618-1-a39.skl@gmail.com>
References: <20221130200950.144618-1-a39.skl@gmail.com>
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
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index d0928f19965f..6e0699649257 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/clock/qcom,gcc-sm6115.h>
+#include <dt-bindings/clock/qcom,sm6115-dispcc.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -725,6 +726,19 @@ usb_1_dwc3: usb@4e00000 {
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

