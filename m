Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE09663C99B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236384AbiK2UrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235138AbiK2UrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:47:01 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E15A27B3C;
        Tue, 29 Nov 2022 12:47:00 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id b9so18648634ljr.5;
        Tue, 29 Nov 2022 12:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSu1txevdRDvf+sjHpSwkWYMoyBAXs2clWWE081Dl98=;
        b=k4BZ95Py3bK6fYlB1MFLHgwl9yftQvPDe7FUCSwJx9NQx9uYWGh2Nziw+P2NhPKGya
         Z5zHfkIB9YbpADkcqcowkrxPJ+oVd6yHlvjUDbqEhDjUi8jzfVIm/jfrFBK7mNs5aTHC
         9meg/WDqrTCZO+Ty6MprnrssnMy5RcK/VSagXAMtMMgo/df0Sr4c8K4+sWZ0lLuOTqQS
         gm4gyRPHU7Zg7wwfZzG+7BCxrh3M2Vf+8P+MXZPOQiHNy1Gcrj689hKYVCLHs9qyeT+s
         KaeVmMq8JTxedXK3T5f0Pw7SqhuZJeNUYfiMQw7hYzf5I35gbXmU3OXMmRcOI1qeVq0j
         D10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tSu1txevdRDvf+sjHpSwkWYMoyBAXs2clWWE081Dl98=;
        b=wb/YoZnxnvrBPu7EFmYfFpGGzxAe2SIfowX1ktIcjiPQN+jw+MmVnXYGnoBodVioQG
         zFkA5Qq5pwvh7RmTxiGxRsoYL9+39FxBxDeUpIka8pSkVYZv1VASeLIKUHlvJ0e6obuo
         w+3qgovJykWnUY4tPoQ+P4NIHFlsJIVBubFvMAz/3IzGbmDMvu/ErgbCRHGrTZJes3x4
         IJi3A1aLhWdywtQsn54mP4/5mi+qZfAsOFPiDxsKMlf67cbYGlFyS/nRm6Nlr8o7Ag4R
         mviqG0Mb6NVCNgJ6qAeyVeASJbc1QvYD36fHb3uF50u0BLRKqbhpG1qZuwb4igXCeP5V
         Pieg==
X-Gm-Message-State: ANoB5plL/UyYoN/9IlVVdkoZZjE5DpXu5kRv5Xt8MlnEEZI5PqWpKE+l
        ckw3+8MfI33PiIhv1JKMeG/03kEIPLA=
X-Google-Smtp-Source: AA0mqf6b4m0gfYTm1LbzzS6QI5kunJ/QHByp8GuyhrqWdvKwvyEVcGMVdWoL+KA45eTUcnkhZEpDGA==
X-Received: by 2002:a2e:8619:0:b0:279:88ce:468f with SMTP id a25-20020a2e8619000000b0027988ce468fmr9177924lji.312.1669754818712;
        Tue, 29 Nov 2022 12:46:58 -0800 (PST)
Received: from localhost.localdomain (ccy110.neoplus.adsl.tpnet.pl. [83.30.148.110])
        by smtp.gmail.com with ESMTPSA id o11-20020ac24e8b000000b004ae24368195sm2325620lfr.233.2022.11.29.12.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 12:46:58 -0800 (PST)
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
Subject: [PATCH 03/12] arm64: dts: qcom: sm6115: Add cpufreq-hw support
Date:   Tue, 29 Nov 2022 21:46:07 +0100
Message-Id: <20221129204616.47006-4-a39.skl@gmail.com>
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

Add cpufreq-hw node and assign qcom,freq-domain properties
to CPUs to enable CPU clock scaling.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 0340ed21be05..2003a2519a54 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -842,6 +842,17 @@ intc: interrupt-controller@f200000 {
 			redistributor-stride = <0x0 0x20000>;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		cpufreq_hw: cpufreq@f521000 {
+			compatible = "qcom,cpufreq-hw";
+			reg = <0x0f521000 0x1000>, <0x0f523000 0x1000>;
+
+			reg-names = "freq-domain0", "freq-domain1";
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
+
+			#freq-domain-cells = <1>;
+		};
 	};
 
 	timer {
-- 
2.25.1

