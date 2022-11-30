Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A138C63E16A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiK3ULp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiK3ULI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:11:08 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1539B7BA;
        Wed, 30 Nov 2022 12:10:07 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id f13so28619933lfa.6;
        Wed, 30 Nov 2022 12:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hbF3gZ7kPvhXmdkKwDqNUnpoPNqBtEugPC+3rCNF/M=;
        b=UfLONb8EyGAqcc9/JHngFeCMpe5K1TtJ2QUC+LzT+ytubcXUjVy5P5YG1mv3sl5XBA
         JYzxhEY4chT0YFVe1YlX4o5frzK/7O43CsCLnMHrSmP2LS/PiWr7JnpCmxTbXSTib3r8
         X9GoOZ5VRCQ1x1KaJXAu2QEFm6S1BQ30rZXbPmA8kU2P4dohvq1nlQ8N8OevstO4q2DU
         g2iUnMzsZdlcyHlcI8fPWRvAmNb9Rv8IH/4ega0IaGd9Gx4Z0yYpYSQC13tEAaWWTOkt
         crrXobk1bnqOtwrv0Lyw0T+e2JqvSqrCKYfEeoPDjRDaVtiS8TrQGxS0DA02YTelaNFF
         Diwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hbF3gZ7kPvhXmdkKwDqNUnpoPNqBtEugPC+3rCNF/M=;
        b=FF7VJM5Urit54yysL94w+54tNOjb7LGELd7GUZZ3le4pZXsJ27LUXBpZc/qzedUekX
         gvvHR3d7JTl3hDYY7iBQDT/rJYMfIIdzzs7XqTSFBGByRlpcqdCq9nhAPWatRtysnrz/
         chUUiBBQpVB6QwbNG6HN3FWM0Il4NbDONk2U1RRZhX3OTw+wEdRSQKRPWGcyStxw7iKE
         P9eiuQRu/B9T4HTBpjEEsd3K3E0kuZC5+x4ZEA7e+/zxHuNe5m0Y3W7ceEO6/ZiF3taM
         RWtxoJC12kSAn0anxWQqg8ggMt8zWXuYbEmuvo9JaqZ76dIdf1RNkXfIVcUvzf2zfZb6
         jwAA==
X-Gm-Message-State: ANoB5pmGPer8dfJLDR97UKkGc965+od0+2BRWuOnLmTINBTIv+VjlqgY
        3MfmnAa6A4bd6VpL/IKTXSA/xXK5ql4=
X-Google-Smtp-Source: AA0mqf4UT8S7EhO1mnlZSwwZpalSw7bUYoEnFAfBQs5kQ2jOZ9T8Zn1lX/HJJv/f953zpWAAhpBIxQ==
X-Received: by 2002:a05:6512:2a98:b0:4b1:4612:6d06 with SMTP id dt24-20020a0565122a9800b004b146126d06mr20173084lfb.683.1669839005450;
        Wed, 30 Nov 2022 12:10:05 -0800 (PST)
Received: from localhost.localdomain (ccy110.neoplus.adsl.tpnet.pl. [83.30.148.110])
        by smtp.gmail.com with ESMTPSA id a25-20020a056512201900b004b4e9580b1asm369754lfb.66.2022.11.30.12.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 12:10:05 -0800 (PST)
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
Subject: [PATCH v2 04/12] arm64: dts: qcom: sm6115: Add TSENS node
Date:   Wed, 30 Nov 2022 21:09:42 +0100
Message-Id: <20221130200950.144618-5-a39.skl@gmail.com>
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

Add nodes required for TSENS block using the common qcom,tsens-v2 binding.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 2a55087b103e..a2ac06f4693b 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -523,6 +523,17 @@ spmi_bus: spmi@1c40000 {
 			#interrupt-cells = <4>;
 		};
 
+		tsens0: thermal-sensor@4410000 {
+			compatible = "qcom,sm6115-tsens", "qcom,tsens-v2";
+			reg = <0x04411000 0x1ff>, /* TM */
+			      <0x04410000 0x8>; /* SROT */
+			#qcom,sensors = <16>;
+			interrupts = <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow", "critical";
+			#thermal-sensor-cells = <1>;
+		};
+
 		rpm_msg_ram: sram@45f0000 {
 			compatible = "qcom,rpm-msg-ram";
 			reg = <0x045f0000 0x7000>;
-- 
2.25.1

