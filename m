Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D10563C99D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbiK2UrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236354AbiK2UrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:47:03 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F39275EA;
        Tue, 29 Nov 2022 12:47:02 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id d3so18675637ljl.1;
        Tue, 29 Nov 2022 12:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krQiwNIU1oFRdpbjQQ+MleaQuhQqE8OwDSXusURqx9Y=;
        b=RdETuYO3X/KpK5+RBMsxnPqzsHiwNIa9vB/SnoG99t5NLaUm5jq6e9CnJINRRBgXr8
         QZJic4W2bIJbjmOGwnGY4NRiKpwaH2linOQwaspOjcT+2H3xzhV3ZvssIQZ0/h7nWnXk
         H3ZDySMz1tTWe7b9WtT2bEg9rdCvBrXO2GvO9cMRAnrQgFzCmamNF9tWc6cmstm9E0VT
         /KHlBGwoX4Qd87RPg2g+jKMDJ77sAKwqL2+wVR+dr96f4uvHzrAhWmhmAcXTCTiBRdZ1
         JQJBbE8MpIr6ji3iBi8p42KqMLYHFtygrXAagqYBSbi4P5a6nBnD6zzvpeMhnQp2dAuy
         WPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krQiwNIU1oFRdpbjQQ+MleaQuhQqE8OwDSXusURqx9Y=;
        b=Je9ZaivbenolOE6w8ABgQt+6nGMjJaXpP+sPE8tM4QRr4vF5wmWfjGmS9VD3oV7iP2
         hjd721ok+o15SaeTGP5OaDuuu9v/enIMGmOJL0ejZSEEzsPM4/XmezZJUziEj2Ji/ItK
         CMHFBe/P4njhHmpBzQ1Uz+JPo5uYWAPURL4Jkyk6NN+AXsyfzH8UzqQ9CZM4VWMNOG33
         q+xiDwa+Ec84Q70kPM7DIGaA3D9JGezw24+ZDPrKDUn/cPw1CJj70vHAoY1A9Pa1ULJF
         ofWiBEWeYUCmWsnM2WtT0vM1+G3YOI6cfHoTvf1DICdmdqqraHhVyVCGBB0zi7otpz0r
         DzWA==
X-Gm-Message-State: ANoB5plvv02zA79E9r+fg323EWWuK+YhSH9gb6VLCux7WF6LZsuWT9je
        1qCdn10j10fGpY0hBaT7DeKeTgYXC6c=
X-Google-Smtp-Source: AA0mqf5N0tM4H9nHiMIyzYDHGbwPtDomQY7QeoEp3WC+kPqU5HB8lUqyxzLX0IOMP7k5A4cEkHVzCQ==
X-Received: by 2002:a2e:a888:0:b0:277:794:cb84 with SMTP id m8-20020a2ea888000000b002770794cb84mr13023469ljq.7.1669754820922;
        Tue, 29 Nov 2022 12:47:00 -0800 (PST)
Received: from localhost.localdomain (ccy110.neoplus.adsl.tpnet.pl. [83.30.148.110])
        by smtp.gmail.com with ESMTPSA id o11-20020ac24e8b000000b004ae24368195sm2325620lfr.233.2022.11.29.12.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 12:47:00 -0800 (PST)
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
Subject: [PATCH 04/12] arm64: dts: qcom: sm6115: Add TSENS node
Date:   Tue, 29 Nov 2022 21:46:08 +0100
Message-Id: <20221129204616.47006-5-a39.skl@gmail.com>
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

Add nodes required for TSENS block using the common qcom,tsens-v2 binding.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 2003a2519a54..decbf7ca8a03 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -515,6 +515,17 @@ spmi_bus: spmi@1c40000 {
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

