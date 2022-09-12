Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08645B570B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 11:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiILJRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 05:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiILJRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 05:17:06 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5CE1EEE4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 02:17:04 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id iw17so8020573plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 02:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=wMFwbaQNDV7fyV08xyNqt987JasnWhOt1fyT+HqZ0No=;
        b=M6ecABta248gbIp9gbGPf7/WCErLkCQ+xKNpAfgvCeVpiGi88RdAhtyb3u0MtxQ+Qs
         CFbnR83W6v4cQMDwEgUjyhrzXCaWsPQY0GiLaJ0S3vWYkbEEvSK0N1VDuXuf7qTwtOae
         9dJhaevzfmhx7BIUisMzYkwjFbRjXW04L7YSIBT8NgJAvvJruzh14vysF74Z0m0PYemL
         ZfxuhZjFE4xyPxS7Et7ooQRUCWz1N6yEVbgD5txoHKV7DAD9fsJWIm0mLVfWPozsd2vt
         IkRR0qfTYrXHDRJWEW+LvCUjIAh6gZTUMj6K2FHlu5IcgXjGTXDCwmIoLFaiO8Yfeov6
         3YRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wMFwbaQNDV7fyV08xyNqt987JasnWhOt1fyT+HqZ0No=;
        b=TCDd9aOxzqjYdj5aJCBOlb1fQqIhZBWXVyCk7XbDxACWzr+8uKfyufyNkAazjuc5GB
         uOB7OMwcWXIibEI2llcn2qs1Gtkx50YbSCj8Xc7Sgy7eoP19xs3B/FSLGQVHCU1gQiWn
         ffJnRhpEDLziOBeEHk7wPIGq7edmBxaJzxbQUQ4LyzRsOLA36ZHKbAOSPrYP2hHrRTxd
         5sL8R/wfnbo7z87ToaoT7nxXnstLgDlPlzKTq1n7HfzIcUqVhRQ/5RKJJASliBmXyA8j
         kKOj4OkPbR6sclhcStk2uguv8NxKyApC2lsa/xBcjGk8MpbiH7qlFVYU5uoehyzEEGdy
         tDyw==
X-Gm-Message-State: ACgBeo22kq0Gzp5xyJkkwVdPk1ozNPjZV+k92m4MSSoVkRnTkazoDBeP
        hlP6Z6iZeeNMW+5+rRkpQ4oq3A==
X-Google-Smtp-Source: AA6agR5+q+3R1+5hl3m6E+SuwBNKWxItiOEdxBLC0nrkzWFifadO3JSYl30WrJlB3F8r0jZU48o9Kg==
X-Received: by 2002:a17:902:b415:b0:178:2835:29e7 with SMTP id x21-20020a170902b41500b00178283529e7mr7620683plr.86.1662974224400;
        Mon, 12 Sep 2022 02:17:04 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:5362:9d7f:2354:1d0a:78e3])
        by smtp.gmail.com with ESMTPSA id o65-20020a62cd44000000b0052dbad1ea2esm4857026pfg.6.2022.09.12.02.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 02:17:04 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, robh@kernel.org, andersson@kernel.org,
        rafael@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/3] arm64: dts: qcom: sm8150: Add qmi cooling device nodes
Date:   Mon, 12 Sep 2022 14:46:41 +0530
Message-Id: <20220912091643.3537857-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220912091643.3537857-1-bhupesh.sharma@linaro.org>
References: <20220912091643.3537857-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add qmi cooling nodes to sm8150 dts file. This node
describes the various qmi thermal mitigation devices
(tmd) which are available on remote processor subsystems.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: andersson@kernel.org
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 62 ++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index cef8c4f4f0ff..6aa270ebbd3f 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/clock/qcom,gpucc-sm8150.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sm8150.h>
+#include <dt-bindings/thermal/qcom,tmd.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -3444,6 +3445,67 @@ compute-cb@8 {
 			};
 		};
 
+		qmi_tmd_devices: qmi-tmd-devices {
+			compatible = "qcom,qmi-tmd-devices";
+			status = "disabled";
+
+			modem0 {
+				qcom,instance-id = <MODEM0_INSTANCE_ID>;
+
+				modem0_pa: tmd-device0 {
+					label = "pa";
+					#cooling-cells = <2>;
+				};
+
+				modem0_proc: tmd-device1 {
+					label = "modem";
+					#cooling-cells = <2>;
+				};
+
+				modem0_current: tmd-device2 {
+					label = "modem_current";
+					#cooling-cells = <2>;
+				};
+
+				modem0_skin: tmd-device3 {
+					label = "modem_skin";
+					#cooling-cells = <2>;
+				};
+
+				modem0_vdd: tmd-device4 {
+					label = "cpuv_restriction_cold";
+					#cooling-cells = <2>;
+				};
+			};
+
+			adsp {
+				qcom,instance-id = <ADSP_INSTANCE_ID>;
+
+				adsp_vdd: tmd-device0 {
+					label = "cpuv_restriction_cold";
+					#cooling-cells = <2>;
+				};
+			};
+
+			cdsp {
+				qcom,instance-id = <CDSP_INSTANCE_ID>;
+
+				cdsp_vdd: tmd-device0 {
+					label = "cpuv_restriction_cold";
+					#cooling-cells = <2>;
+				};
+			};
+
+			slpi {
+				qcom,instance-id = <SLPI_INSTANCE_ID>;
+
+				slpi_vdd: tmd-device0 {
+					label = "cpuv_restriction_cold";
+					#cooling-cells = <2>;
+				};
+			};
+		};
+
 		usb_1_hsphy: phy@88e2000 {
 			compatible = "qcom,sm8150-usb-hs-phy",
 				     "qcom,usb-snps-hs-7nm-phy";
-- 
2.37.1

