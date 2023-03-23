Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871BC6C5B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 01:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCWA7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 20:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjCWA7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 20:59:40 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C16C8A54;
        Wed, 22 Mar 2023 17:59:39 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id d22so11664758pgw.2;
        Wed, 22 Mar 2023 17:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679533178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxGGiLKXubBYw0ERFs/+twKaoJRyIzgQ61OdEdQSRO0=;
        b=pA3zE/vSVFFkV+RZ/tdS6wVzvQrTeF4/ytargeYmjxi6JbcFkbfa00XnEdsPsUMqCO
         cZAmDhB6jAcgR4JrIy7dNueAvRUTDU74d7RnCISOLQzQ2SP1OXrhaReIC6bF11oYbH7T
         gqdqgd4f1lwMZz/HmtndaBRi6QcrYUBArZlTKufsEfvaXpiJxnMY6wOb0zeQIoUx6YDJ
         8zzrk1mGLyVSppjxU+Kodpyq/FcPTfBw0brL6rzLnbCcUFn+0ORoWx7zDp0AdG+bMch1
         oNgyMLzY3w1QYE6rtSPsHGgWiL8ofUa2lJsEHpuvnfS00lpuPC+WpkQQYcCpoVTzblEk
         lR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679533178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxGGiLKXubBYw0ERFs/+twKaoJRyIzgQ61OdEdQSRO0=;
        b=CW7zwgkXalIObmQlR/PIg9dP6Do06d/iNICHyy4mbOt/9vMm5ZnSJ9yiIuXFgSnQs4
         Mzb6SevQIHR57ai1gn3zo7IfpOiMQgYSc7f2H4lES/Cz37RM1Al7Xuk49XVo6C4se+2i
         ec8qsGWa34udXop9gfJK4ESsTvzAEz8l7iZ39hrLZoFyvMD0/tYZdV0aLJsWcwh4xmeE
         GCoQntlOHFHw71hFF/GQqYWf+qOmbA/9w2B4K9P4hmDpFeCDkB8a69y2va2Gwab7WWqJ
         8TiIvOA1wyR2I23b8S8cq3BwjgvWoh34PvZP1tCekCl+sQSxgtUBU5MUrZVcwZNOJMnL
         Py7w==
X-Gm-Message-State: AO0yUKX62SsFyVpndFvdIBFWLOfTeM5fP8i5C+gjbHFVRGgQSUGhWEQs
        OiZOG/0eSjXCheix+IMJ5W4=
X-Google-Smtp-Source: AK7set/qJL81QHkC8xwZdSZlA0oGtIkcQAH/2YKyb4ZDF1JidsHtHXNKNV2yvFgACTdUDEAHaSDivw==
X-Received: by 2002:aa7:8f3c:0:b0:625:cb74:9e01 with SMTP id y28-20020aa78f3c000000b00625cb749e01mr4236872pfr.25.1679533178496;
        Wed, 22 Mar 2023 17:59:38 -0700 (PDT)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id s10-20020aa7828a000000b006288ca3cadfsm2114579pfm.35.2023.03.22.17.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 17:59:38 -0700 (PDT)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH v3 2/3] arm64: dts: qcom: sm8250-xiaomi-elish-boe: Add mdss and dsi panel
Date:   Thu, 23 Mar 2023 08:59:24 +0800
Message-Id: <20230323005925.23179-2-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323005925.23179-1-lujianhua000@gmail.com>
References: <20230323005925.23179-1-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for BOE NT36523 panel found in xiaomi-elish. This panel
is a dual dsi mode panel and the dsi phy type is cphy.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
Changes in v2:
  - Include missing <dt-bindings/phy/phy.h> for phy-type property.

Changes in v3:
  - Sort include header.
  - Move qcom,sync-dual-dsi to the front of qcom,master-dsi 
  - Add newline before subnode.

 .../boot/dts/qcom/sm8250-xiaomi-elish-boe.dts |  5 ++
 .../dts/qcom/sm8250-xiaomi-elish-common.dtsi  | 75 +++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts
index bd9ad109daf9..8b2ae39950ff 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts
@@ -11,3 +11,8 @@ / {
 	model = "Xiaomi Mi Pad 5 Pro (BOE)";
 	compatible = "xiaomi,elish", "qcom,sm8250";
 };
+
+&display_panel {
+	compatible = "xiaomi,elish-boe-nt36523";
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
index a43d4b73ffca..4585f61781f1 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/arm/qcom,ids.h>
+#include <dt-bindings/phy/phy.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sm8250.dtsi"
 #include "pm8150.dtsi"
@@ -469,6 +470,76 @@ &cdsp {
 	status = "okay";
 };
 
+&dsi0 {
+	vdda-supply = <&vreg_l9a_1p2>;
+	qcom,dual-dsi-mode;
+	qcom,sync-dual-dsi;
+	qcom,master-dsi;
+	status = "okay";
+
+	display_panel: panel@0 {
+		reg = <0>;
+		vddio-supply = <&vreg_l14a_1p88>;
+		reset-gpios = <&tlmm 75 GPIO_ACTIVE_LOW>;
+		backlight = <&backlight>;
+
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				panel_in_0: endpoint {
+					remote-endpoint = <&dsi0_out>;
+				};
+			};
+
+			port@1{
+				reg = <1>;
+
+				panel_in_1: endpoint {
+					remote-endpoint = <&dsi1_out>;
+				};
+			};
+
+		};
+	};
+};
+
+&dsi0_out {
+	data-lanes = <0 1 2>;
+	remote-endpoint = <&panel_in_0>;
+};
+
+&dsi0_phy {
+	vdds-supply = <&vreg_l5a_0p88>;
+	phy-type = <PHY_TYPE_CPHY>;
+	status = "okay";
+};
+
+&dsi1 {
+	vdda-supply = <&vreg_l9a_1p2>;
+	qcom,dual-dsi-mode;
+	qcom,sync-dual-dsi;
+	/* DSI1 is slave, so use DSI0 clocks */
+	assigned-clock-parents = <&dsi0_phy 0>, <&dsi0_phy 1>;
+	status = "okay";
+};
+
+&dsi1_out {
+	data-lanes = <0 1 2>;
+	remote-endpoint = <&panel_in_1>;
+};
+
+&dsi1_phy {
+	vdds-supply = <&vreg_l5a_0p88>;
+	phy-type = <PHY_TYPE_CPHY>;
+	status = "okay";
+};
+
 &gmu {
 	status = "okay";
 };
@@ -533,6 +604,10 @@ fuel-gauge@55 {
 	};
 };
 
+&mdss {
+	status = "okay";
+};
+
 &pcie0 {
 	status = "okay";
 };
-- 
2.39.2

