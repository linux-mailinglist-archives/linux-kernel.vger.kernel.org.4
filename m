Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04759610BA9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiJ1HyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJ1HyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:54:18 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988801C0701
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:54:16 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i21so6700828edj.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PEh7we78H3C504Ey8uKXhsNpfv9vdx7UebnqIo2Gcv8=;
        b=j0ZZLooRH9i9GWkWCy4Id9RJsOEpEieKVgmJ0bYLgtpvSr+uP1BDaJaW86SWD/akod
         MWsD6O6z/CWvALagOqHG72vqxQuwYD4z7rNO1YS2hS6aDL45Hi1uQ1PrSWgFQREPdjqE
         16pruyrm7v7dIrWy0SV6dfnprMt7mN61HMUdmmi4+7XBQD2dWjL+5oEx5p1PUpi40tiW
         mbHqETFGJfY2wRVlFtnppwbN4yxdmPgvZmz5uPF0PvI6GqFHrLtXV0EXOWKpHx9iRtKP
         GVl1kKE6qKgoxOjC+Ec3qjn2zVm0y9JTswKeFIrvp1ZxptVg2Qhi0IWfWYHIVgYGghvd
         nKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEh7we78H3C504Ey8uKXhsNpfv9vdx7UebnqIo2Gcv8=;
        b=aHko95dB9PKQ5TSG4gW8180ZZRw1qVlsctss7R0fK8oy2HiX0KYE7Z2glP9vrvjuKu
         yems2g9nP0BkDhs+myt2cWBmIA1aomawrgBj+mA7hSlSrgsWCWi/zpzrfQAiZASVJG7T
         PUGASGaZRKfOX/kmPaaMG7j/2Xep+K3MsqhEzoBt5EveM+RF9KiPVTRDjM4YlkXSOpDo
         Gts25NdN2qyVgg7LeySKDPCa4DjRhPeg3CAAz0TA5j5MWkBz4KvO6onUiHGWIAppDYeI
         v7hsUFcV2+WAfccZGnt+X9ven5Xf8Wqj40b4hmRDcIFiRIjuW8Qthv3r/VrWH3KI3lB0
         wVfw==
X-Gm-Message-State: ACrzQf2jdfdpkPBuMk6R3yTa6cml8l0IHuX4sbZIY2v36cRVYMiq0e1e
        jnOIGwFNIsxsyOFMYyhzEjX4FA==
X-Google-Smtp-Source: AMsMyM6ElPrCWCp47BFYHByQwW0VRG8TQjVnN9IB3snxFHTB2FGWQd0k0zG2bArqCSDOleJlzFDXTw==
X-Received: by 2002:a05:6402:3408:b0:43c:2dd3:d86b with SMTP id k8-20020a056402340800b0043c2dd3d86bmr49507591edc.108.1666943655226;
        Fri, 28 Oct 2022 00:54:15 -0700 (PDT)
Received: from otso.. (31-151-115-246.dynamic.upc.nl. [31.151.115.246])
        by smtp.gmail.com with ESMTPSA id v8-20020a170906b00800b0078dce9984afsm1776009ejy.220.2022.10.28.00.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 00:54:14 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: qcom: pm6350: add temp sensor and thermal zone config
Date:   Fri, 28 Oct 2022 09:54:04 +0200
Message-Id: <20221028075405.124809-1-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add temp-alarm device tree node and a default configuration for the
corresponding thermal zone for this PMIC. Temperatures are based on
downstream values, except for trip2 where 125°C is used instead of 145°C
due to limitations without a configured ADC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
* Decrease trip2 temp to 125degC from 145degC after discussion with
  Matthias

 arch/arm64/boot/dts/qcom/pm6350.dtsi | 38 ++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm6350.dtsi b/arch/arm64/boot/dts/qcom/pm6350.dtsi
index ecf9b9919182..c9575cf0f518 100644
--- a/arch/arm64/boot/dts/qcom/pm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6350.dtsi
@@ -5,6 +5,37 @@
 
 #include <dt-bindings/spmi/spmi.h>
 
+/ {
+	thermal-zones {
+		pm6350-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pm6350_temp>;
+
+			trips {
+				trip0 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "hot";
+				};
+
+				trip2 {
+					temperature = <125000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
+
 &spmi_bus {
 	pmic@0 {
 		compatible = "qcom,pm6350", "qcom,spmi-pmic";
@@ -35,6 +66,13 @@ pm6350_resin: resin {
 			};
 		};
 
+		pm6350_temp: temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
 		pm6350_gpios: gpios@c000 {
 			compatible = "qcom,pm6350-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
-- 
2.38.1

