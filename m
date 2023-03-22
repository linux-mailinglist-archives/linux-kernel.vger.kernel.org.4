Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33416C5220
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjCVRQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjCVRQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:16:34 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0AC637C3;
        Wed, 22 Mar 2023 10:16:10 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id l14so11547460pfc.11;
        Wed, 22 Mar 2023 10:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679505368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Du2gZbCSXVQqxOtZS8hq0dQKJr+nACUyNNRAcUml5+k=;
        b=RgPE0jTp0JRZH8DcWVA5RmODpy2pHSxJtZ7edzKBtuMTf0w1YAOckK/2YFJLY0lL1x
         3UXgsvBF5DBh7FBHMA7TD1rkLCXvOEf87e+re0H7maYc/M7pvSFp0ZED9e/qBzVoMID1
         4MXsYE8WStE6Ebig1fjM0g7S1H6inQwcboICRVcA6NueKORXeS2s2Uqkj0dLDybRDkte
         HHHNvzmG0e0pCXwLIZ5GLNhmhPY5HSe2HAmg1OPguNGKuWYaziFU8ui2a2LQGt71A7h0
         GpSy4d/Avh8COx9iKtbK8kvhiEcBKpdVFI21HdDzdNB1U6zo5bAL7Zgozgag8PskclWf
         cfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679505368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Du2gZbCSXVQqxOtZS8hq0dQKJr+nACUyNNRAcUml5+k=;
        b=cC/1bgeuQoUd69W73pkjYcJFu/1vQinjZAsaKEc4I/nYVqhFqhDClEkyopICiCZROn
         YS0GMk5IPF90hKVbavbE+Ml4bz68cGYBI9/jyDlWDt6Zb5bwGr8/zUBqMx6pvVe/OaRI
         TiNXTLcrijeCCNqQT5zBaKXkWR0NLE0tOQ/hmicXyrjsEfIxaHBS1v6AgPHZeFEhZw4v
         /GczYPXTqEIi/uSQ8ZfdCT3BHd86SM7XKElFPvey472npWN6WRgSEUVOdcWKAy9XdOem
         8/WJYayT5j/mRFTkxMfM94UMIxN+ZcogwcL6gieU/vqk8YypdGRWxIJNMeHzSp+UyhWh
         lolg==
X-Gm-Message-State: AO0yUKVBPGBRqONBmNbcFyD1WFuXasFUG66QsTapQXa+FUydIIu2F8X6
        1rx2ypfeE4Gq2rPurJRqu2Q=
X-Google-Smtp-Source: AK7set+yVjp7rXBfNZ5QJ3BudfvvnBtue/CnsqKBVotLaCL7qd9dcr+RiYEm3UluY9tViaWgwoJEjA==
X-Received: by 2002:aa7:958f:0:b0:626:7e73:2f44 with SMTP id z15-20020aa7958f000000b006267e732f44mr3296262pfj.9.1679505368430;
        Wed, 22 Mar 2023 10:16:08 -0700 (PDT)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id b1-20020a6567c1000000b005023496e339sm10097353pgs.63.2023.03.22.10.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:16:08 -0700 (PDT)
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
Subject: [PATCH v2 2/4] arm64: dts: qcom: sm8250-xiaomi-elish: Add mdss and dsi node
Date:   Thu, 23 Mar 2023 01:15:53 +0800
Message-Id: <20230322171555.2154-2-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322171555.2154-1-lujianhua000@gmail.com>
References: <20230322171555.2154-1-lujianhua000@gmail.com>
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

xiaomi-elish uses dual dsi mode panel and dsi phy type is cphy.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
Changes in v2:
  - Include missing <dt-bindings/phy/phy.h> for phy-type property.

 .../dts/qcom/sm8250-xiaomi-elish-common.dtsi  | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
index a43d4b73ffca..4ff8454d4abe 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/arm/qcom,ids.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/phy/phy.h>
 #include "sm8250.dtsi"
 #include "pm8150.dtsi"
 #include "pm8150b.dtsi"
@@ -469,6 +470,74 @@ &cdsp {
 	status = "okay";
 };
 
+&dsi0 {
+	vdda-supply = <&vreg_l9a_1p2>;
+	qcom,dual-dsi-mode;
+	qcom,master-dsi;
+	qcom,sync-dual-dsi;
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
+				panel_in_0: endpoint {
+					remote-endpoint = <&dsi0_out>;
+				};
+			};
+
+			port@1{
+				reg = <1>;
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
@@ -533,6 +602,10 @@ fuel-gauge@55 {
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

