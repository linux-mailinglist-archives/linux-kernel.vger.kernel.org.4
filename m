Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA07465CF6F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbjADJUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239099AbjADJTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:19:39 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26B61DDF0
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 01:19:36 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id k137so17601331pfd.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 01:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIS8WxqeTpJ/Hb9V5wgA31o+L5mO3ZUQH0XmBEAll1Y=;
        b=UqwdSRMIhvS3VGWkfLRpPU5LOvLcyybpZ2u3QNbwiBoFK1yai5T2OFfGZ4ikwefeuu
         mvIPfUmt+Xtyiu8MwlxaYUhASFWfDCUBUmhGMY/KvznZE//fUogRdlW9WBV1Cb2n/1WL
         3/CglqVin7v8VhMI8ZfrBIM8xJpE2K4Kq0mT/B1qhgU3pEnrpOQL3LloI1w8Zwf6Z4ua
         k2+cZy6o2fp2InqUFtzK62zWpusQ0E3wiwOE29pJMnNyJmPKbJsNc3Ol0+tejkazb6qW
         mK0RkSCZBRXi3UuRdPdQIhFnHxddNX7DmjjeEsmSn4e7ozqEbeI43Y3Ltq21I4Nybm6Q
         IdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIS8WxqeTpJ/Hb9V5wgA31o+L5mO3ZUQH0XmBEAll1Y=;
        b=hklm8LKYxH+gFkez7zp1NmvNbHvjp387xk+ac5motVRsq02cox9fTTDOFab5k6P51I
         fymwMrhLyi17cJXOg+YVu80sTnQHfYXtpu9taW2bOACvZovgjgy3ZphAFpLGw3DsLNaw
         e/sRUkjNSCdbjI2KhM18oBlxN6S0m+vI4Tn7OljpLopcR476QJiLCSeR6P/qrm4pOJ/I
         TcWnrIEQOKWe8S1t69cqBZpMxKDIqsu7o2O213YOsnRPog+xNu5MUZbQxoldS3lcaYHO
         qO1F7lFNLtrC0pdZTjIEksEhHTBPCynu8T7y0U7pAGRqgIRkhVQriCcZFojiLeRHn0g5
         p8fw==
X-Gm-Message-State: AFqh2krXwyLy4iz0gP1sAC9Sj1WftgxbsgWfTVOKVAYnIPoKoBSN6j9X
        KD97YAdqFzxJTC/BzVKsUAf0cg==
X-Google-Smtp-Source: AMrXdXulMYNKm6hmQhZqyEVnE5o8T6dZlXuPVisWXa5DTaSXYoyLuRhXkAFbFJ4CUDFKDhEHrV2E5g==
X-Received: by 2002:aa7:804c:0:b0:576:cd93:2b06 with SMTP id y12-20020aa7804c000000b00576cd932b06mr43685798pfm.6.1672823976038;
        Wed, 04 Jan 2023 01:19:36 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c5e:e3b5:c341:16de:ce17:b857])
        by smtp.gmail.com with ESMTPSA id b189-20020a621bc6000000b00580d877a50fsm19205877pfb.55.2023.01.04.01.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 01:19:35 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     quic_schowdhu@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH 1/2] arm64: dts: qcom: sc7280: Fix EUD dt node syntax
Date:   Wed,  4 Jan 2023 14:49:21 +0530
Message-Id: <20230104091922.3959602-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230104091922.3959602-1-bhupesh.sharma@linaro.org>
References: <20230104091922.3959602-1-bhupesh.sharma@linaro.org>
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

As noted by Konrad while reviewing [1], fix the EUD and DWC3
node syntax in sc7280 dtsi file.

While at it also fix the errors reported by '$ make dtbs_check'
for the EUD node:

 arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb: eud@88e0000: ports:
    'oneOf' conditional failed, one must be fixed:
	'port' is a required property
	'#address-cells' is a required property
	'#size-cells' is a required property
  From schema: Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml

[1]. https://lore.kernel.org/linux-arm-msm/20221231131945.3286639-1-bhupesh.sharma@linaro.org

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 32 +++++++++++++++++-----------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 0adf13399e649..f4c87059919e4 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -623,6 +623,18 @@ cpu7_opp_3014mhz: opp-3014400000 {
 		};
 	};
 
+	eud_typec: connector {
+		compatible = "usb-c-connector";
+
+		ports {
+			port@0 {
+				con_eud: endpoint {
+					remote-endpoint = <&eud_con>;
+				};
+			};
+		};
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		/* We expect the bootloader to fill in the size */
@@ -3411,6 +3423,7 @@ usb_2_dwc3: usb@8c00000 {
 				phy-names = "usb2-phy";
 				maximum-speed = "high-speed";
 				usb-role-switch;
+
 				port {
 					usb2_role_switch: endpoint {
 						remote-endpoint = <&eud_ep>;
@@ -3585,17 +3598,23 @@ system-cache-controller@9200000 {
 		};
 
 		eud: eud@88e0000 {
-			compatible = "qcom,sc7280-eud","qcom,eud";
+			compatible = "qcom,sc7280-eud", "qcom,eud";
 			reg = <0 0x88e0000 0 0x2000>,
 			      <0 0x88e2000 0 0x1000>;
 			interrupts-extended = <&pdc 11 IRQ_TYPE_LEVEL_HIGH>;
+
 			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
 				port@0 {
+					reg = <0>;
 					eud_ep: endpoint {
 						remote-endpoint = <&usb2_role_switch>;
 					};
 				};
+
 				port@1 {
+					reg = <1>;
 					eud_con: endpoint {
 						remote-endpoint = <&con_eud>;
 					};
@@ -3603,17 +3622,6 @@ eud_con: endpoint {
 			};
 		};
 
-		eud_typec: connector {
-			compatible = "usb-c-connector";
-			ports {
-				port@0 {
-					con_eud: endpoint {
-						remote-endpoint = <&eud_con>;
-					};
-				};
-			};
-		};
-
 		nsp_noc: interconnect@a0c0000 {
 			reg = <0 0x0a0c0000 0 0x10000>;
 			compatible = "qcom,sc7280-nsp-noc";
-- 
2.38.1

