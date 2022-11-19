Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B7D630F8E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 17:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiKSQoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 11:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiKSQoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 11:44:37 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335882631
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 08:44:32 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id i12so9982203wrb.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 08:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpg2aVlJ1WFUczvXwULfPFs1K+cORox9hiymDZK8ezk=;
        b=xfSlAJxnYlmQa7mjrrt/Tl9ka/LqCla+dlVedT3ZJ98OAdrWs66XX70qBulIa8S40g
         QAjJ5mT0wUAgHqb7geysUT8CRmjIOY0tVx/np6yuJsn0aJEkRL3bYvupzxW4Qs8DG6Xq
         GwnpFuwn0Q/5Tg6F/FMiI195LCJ0bjnTXqLTKGLL9R3V80aZSNHyFD6zruHyLhRZPKyC
         rXf+KUcAR5mTuZ0flsLW2GUAcb7uEwuuYAEMDsvZvvPq/4eJAFHyEq1ynSMY5whm66DO
         QsJ8hJ33wwaDmUdSPbO9dv/n049Clwjgq5Eos2pQoak+tKZFIv11yoW/y7j0Z+SIgmVH
         1lGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpg2aVlJ1WFUczvXwULfPFs1K+cORox9hiymDZK8ezk=;
        b=f3qpQBVhmvMMhwty3699aOAef+W0N910kLcLm1gn8hYhe0ao+FzM7WGaCapDiSGhjC
         cm/bd7iqst4b36C0sxtnG61vRkYmd5fj2fF1Pj9nM7lC5cKfsuMPeQunTlTmorFJ4KiI
         TdR8JPmX//4D9NRz5ViUlqz8u/uSzXmE9bJXxfbI6pDsSw6A3n6grNwjYxGiGHtXr1p8
         dgnixbTMwxZRI/l24hUJsV46PuvTi9rP7wZeM+8zu3+6/wtPKoJ2HOD0RRnWl5JqhxqA
         VC327mSt/gcvCLCTpL30yYOp9LLcFkNIEFu1VqUVCXZNLtp8EebJM5RGXao4jbrEFUJD
         BLrg==
X-Gm-Message-State: ANoB5pmN7YPLQRx6WUKk7GRko9Sa5x8wsXOFS4InrxvSBwHfh8i3Yh38
        hue8EeNUojo9NYppFP9UV0f5AA==
X-Google-Smtp-Source: AA0mqf7HzAJDF1KWTDkzgXtiIc590uVIHVWgDrLBnNi6oH0wtpleZWPcY1LWVQ0Vlh5rjGFc7k3h2A==
X-Received: by 2002:a05:6000:501:b0:22c:d27d:12e4 with SMTP id a1-20020a056000050100b0022cd27d12e4mr6839585wrf.546.1668876270529;
        Sat, 19 Nov 2022 08:44:30 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c229700b003cf75213bb9sm12312220wmf.8.2022.11.19.08.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 08:44:29 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     agross@kernel.org, andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/3] arm64: dts: qcom: sc8280xp/sa8540p: add gpr node
Date:   Sat, 19 Nov 2022 16:44:23 +0000
Message-Id: <20221119164425.86014-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221119164425.86014-1-srinivas.kandagatla@linaro.org>
References: <20221119164425.86014-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GPR node along with APM(Audio Process Manager) and PRM(Proxy
resource Manager) audio services.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 40 ++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index c32bcded2aef..a610c12103bf 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/thermal/thermal.h>
+#include <dt-bindings/soc/qcom,gpr.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -1152,9 +1153,48 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 
 				label = "lpass";
 				qcom,remote-pid = <2>;
+
+				gpr {
+					compatible = "qcom,gpr";
+					qcom,glink-channels = "adsp_apps";
+					qcom,domain = <GPR_DOMAIN_ID_ADSP>;
+					qcom,intents = <512 20>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					q6apm: service@1 {
+						compatible = "qcom,q6apm";
+						reg = <GPR_APM_MODULE_IID>;
+						#sound-dai-cells = <0>;
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+						q6apmdai: dais {
+							compatible = "qcom,q6apm-dais";
+							iommus = <&apps_smmu 0x0c01 0x0>;
+						};
+
+						q6apmbedai: bedais {
+							compatible = "qcom,q6apm-lpass-dais";
+							#sound-dai-cells = <1>;
+						};
+					};
+
+					q6prm: service@2 {
+						compatible = "qcom,q6prm";
+						reg = <GPR_PRM_MODULE_IID>;
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+						q6prmcc: clock-controller {
+							compatible = "qcom,q6prm-lpass-clocks";
+							clock-controller;
+							#clock-cells = <2>;
+						};
+					};
+				};
 			};
 		};
 
+
 		usb_0_qmpphy: phy-wrapper@88ec000 {
 			compatible = "qcom,sc8280xp-qmp-usb43dp-phy";
 			reg = <0 0x088ec000 0 0x1e4>,
-- 
2.25.1

