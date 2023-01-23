Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523A8677C81
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjAWNaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjAWNa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:30:29 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0779322A21
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:30:27 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id az20so30529060ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h5S864SLj/0AmsHaYUn1BE0q0L7hH55z4J1jnk56j5Y=;
        b=SXQti/6ztuAnC5KrsM38OFA0Fl6IohIBjIRzPaMChs03xmgAbfg7A0bBZ94KVjQoy1
         nWpQ7MDiJYxlCyIihMtd35Fhh63nPB3gcx2h0+g8Bj03DsC0Mj7ZDKBJuStlekU0NElh
         uZADboZbyZ7Hxa9xu+c0wLj3qfT9rPDwHEVRE2EppJUUHnmdYUoqcSKjnI8DJCDq+3vK
         +Xoqnk3LKvXxT6rC+OzCewsF55Di8pG1qJWYHwqj0NKrRThHgcr630VWS8DN709TZXPk
         pNYhZk4zzvxTnLgpSvh58nLbOCkJ+fIPk2ettwNqZxhg76id0QPmMKpyMh//jgVGth0L
         uG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5S864SLj/0AmsHaYUn1BE0q0L7hH55z4J1jnk56j5Y=;
        b=C4H3Y+x28rOCFWlifq49ED28coI8F/MzHWyDBQkdUzhd3HAqO1NJ7+SCg79C6J63uz
         ZITO8dd1weoQfukW9krxd2WcKxxs5SBxHrwNZS49a7P0N+gAaoTtZmTN/BdIhves9HPP
         kKrLYwcO8CeXyhpNt08kMJ8ocNmCNwhd+/x/Z/+OPX8BXOxGdleHBzcFJpE1WkRwj/jE
         35QelfZHX2sshBnntCB2fDxfbXjcda6xvFp0W4YuLGaMG6Ryj8p+C5UTzncTQ033vFaa
         27YUga7LqPJUroCpynexC4a04GpgF/QWNbhGfqtEs4WyRkU3PipyLqVE1xqYnfcgHk5a
         sqng==
X-Gm-Message-State: AFqh2kqabUyWNasUMR7c88EyfBnjzgEw9lsKpLuKCtH/lCF6vzQ3hKkb
        59HhvrLsjuxpPKBqF0nflnoHUQ==
X-Google-Smtp-Source: AMrXdXuJwq4DokcrqrcjPAVHUF+BBk8hTFZqS+4PEtDUB9U1TQrK5YO0nyRdmtPdcT/DcOBym2VYQw==
X-Received: by 2002:a17:906:f49:b0:864:8c78:e7ff with SMTP id h9-20020a1709060f4900b008648c78e7ffmr20730884ejj.23.1674480625601;
        Mon, 23 Jan 2023 05:30:25 -0800 (PST)
Received: from [172.16.220.87] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id s5-20020a170906c30500b008552bc8399dsm18410066ejz.172.2023.01.23.05.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 05:30:25 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Mon, 23 Jan 2023 14:29:51 +0100
Subject: [PATCH v4 3/3] arm64: dts: qcom: sm6350: Use specific qmpphy
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230120-sm6350-usbphy-v4-3-4d700a90ba16@fairphone.com>
References: <20230120-sm6350-usbphy-v4-0-4d700a90ba16@fairphone.com>
In-Reply-To: <20230120-sm6350-usbphy-v4-0-4d700a90ba16@fairphone.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Johan Hovold <johan+linaro@kernel.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sc7180 phy compatible works fine for some cases, but it turns out
sm6350 does need proper phy configuration in the driver, so use the
newly added sm6350 compatible.

Because the sm6350 compatible is using the new binding, we need to
change the node quite a bit to match it.

This fixes qmpphy init when no USB cable is plugged in during bootloader
stage.

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 54 +++++++++++-------------------------
 1 file changed, 16 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 8224adb99948..128dbbe23ef5 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/interconnect/qcom,sm6350.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
+#include <dt-bindings/phy/phy-qcom-qmp.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
@@ -1314,49 +1315,26 @@ usb_1_hsphy: phy@88e3000 {
 			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
 		};
 
-		usb_1_qmpphy: phy@88e9000 {
-			compatible = "qcom,sc7180-qmp-usb3-dp-phy";
-			reg = <0 0x088e9000 0 0x200>,
-			      <0 0x088e8000 0 0x40>,
-			      <0 0x088ea000 0 0x200>;
-			status = "disabled";
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+		usb_1_qmpphy: phy@88e8000 {
+			compatible = "qcom,sm6350-qmp-usb3-dp-phy";
+			reg = <0 0x088e8000 0 0x3000>;
 
 			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
-				 <&xo_board>,
-				 <&rpmhcc RPMH_QLINK_CLK>,
-				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
-			clock-names = "aux", "cfg_ahb", "ref", "com_aux";
+				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
+			clock-names = "aux", "ref", "com_aux", "usb3_pipe";
+
+			power-domains = <&gcc USB30_PRIM_GDSC>;
 
-			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
-				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
+			resets = <&gcc GCC_USB3_PHY_PRIM_BCR>,
+				 <&gcc GCC_USB3_DP_PHY_PRIM_BCR>;
 			reset-names = "phy", "common";
 
-			usb_1_ssphy: usb3-phy@88e9200 {
-				reg = <0 0x088e9200 0 0x200>,
-				      <0 0x088e9400 0 0x200>,
-				      <0 0x088e9c00 0 0x400>,
-				      <0 0x088e9600 0 0x200>,
-				      <0 0x088e9800 0 0x200>,
-				      <0 0x088e9a00 0 0x100>;
-				#clock-cells = <0>;
-				#phy-cells = <0>;
-				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
-				clock-names = "pipe0";
-				clock-output-names = "usb3_phy_pipe_clk_src";
-			};
+			#clock-cells = <1>;
+			#phy-cells = <1>;
 
-			dp_phy: dp-phy@88ea200 {
-				reg = <0 0x088ea200 0 0x200>,
-				      <0 0x088ea400 0 0x200>,
-				      <0 0x088eaa00 0 0x200>,
-				      <0 0x088ea600 0 0x200>,
-				      <0 0x088ea800 0 0x200>;
-				#phy-cells = <0>;
-				#clock-cells = <1>;
-			};
+			status = "disabled";
 		};
 
 		dc_noc: interconnect@9160000 {
@@ -1430,7 +1408,7 @@ usb_1_dwc3: usb@a600000 {
 				snps,dis_enblslpm_quirk;
 				snps,has-lpm-erratum;
 				snps,hird-threshold = /bits/ 8 <0x10>;
-				phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
+				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
 			};
 		};

-- 
2.39.1

