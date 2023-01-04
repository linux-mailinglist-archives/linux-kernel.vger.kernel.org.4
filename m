Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B75565CC89
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 06:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjADFVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 00:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjADFU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 00:20:58 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05095DEC2
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 21:20:57 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 6so19333842pfz.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 21:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x6YKskugShgNtlmuvZE9iNBLytliO5KXjfz6TB5SwOM=;
        b=orh+A6fZc5yPKPtF2vxjko56PgjwmGz78OmAhhMOleFKvStI8nhIaX9ktwAWFkzWij
         y8Jn1VJiqnLpNIfPteyBYWx2v7gBXgtmN+5pmoiGLb9lF/zRboQciSPr6swU572Nco/0
         pQRh0uwf/drepMmVCzr3mU1K7chuFBWf18sW69Le10W8c/WejpguHSJ54v3PnUytqese
         K0ODbmSPwTJnYuZCmgjVWA1hSQzLxVKtz2FQHEglRXirf2ljURiiMgoI9K1Yyq2Wvs2X
         PHNb774lfXEU5DM87ZjatSLWP0ef9cwcmFTlImNj7EiGNAohO5BrkIyoVMpqIWF3eYoX
         DL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x6YKskugShgNtlmuvZE9iNBLytliO5KXjfz6TB5SwOM=;
        b=vQTp0vqxd7O060Tte/r1Y+s/81NGcmbIBszbCXelv9ol0TnZmzfRma9pbZkswsp4MN
         sjFuG1tTXQ/DdOfNbUz0klZJrAd58LgtZwApVDJlXDTmQMmZwt7JPhUYL77jmMZQopoh
         Fcqjws6hcrLB5YbaxFrlJcUgEqPuXKl87YtZjMiKMw2aQwwfHGnl22c/PV6IkerKEuLW
         zTpT7nZ4LlvWO0hUj4vQgi48ufH5pE+jpfCKTfMuTgHb1jwL4vCFxJ9ncVjAA4s9riuG
         q19IRNByaRLXtTvyPwOjstj4ddPuRlX3GXo13gtbWZqcNTw8k1IoqareR7zEXv+PswgN
         XqtQ==
X-Gm-Message-State: AFqh2kpDPMy/e4X0opi9iDZeZGiLzqEtSZxLsjAB9EOtAn8j2vurHQh5
        T5Cm6bMlfgR/s0YKcz6Al8QrSw==
X-Google-Smtp-Source: AMrXdXtVIrNfQMys15m/cCb4UXCy5JUnkJu/o5G6OM37xIz9aWosUkZtmHzXD0RXJ4xva2o7k1z2cA==
X-Received: by 2002:aa7:9559:0:b0:581:7b3a:198c with SMTP id w25-20020aa79559000000b005817b3a198cmr24641166pfq.13.1672809657263;
        Tue, 03 Jan 2023 21:20:57 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c5e:e3b5:c341:16de:ce17:b857])
        by smtp.gmail.com with ESMTPSA id a1-20020aa78e81000000b005811c4245c7sm16710342pfr.126.2023.01.03.21.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 21:20:56 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     quic_schowdhu@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, bhupesh.sharma@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2] arm64: dts: qcom: sm6115: Add EUD dt node and dwc3 connector
Date:   Wed,  4 Jan 2023 10:50:47 +0530
Message-Id: <20230104052047.3945983-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Embedded USB Debugger(EUD) device tree node for
SM6115 / SM4250 SoC.

The node contains EUD base register region, EUD mode manager
register region and TCSR Check register region along with the
interrupt entry.

Also add the typec connector node for EUD which is attached to
EUD node via port. EUD is also attached to DWC3 node via port.

To enable the role switch, we need to set dr_mode = "otg" property
for 'usb_dwc3' sub-node in the board dts file.

Also the EUD device can be enabled on a board once linux is boot'ed
by setting:
 $ echo 1 > /sys/bus/platform/drivers/qcom_eud/../enable

Cc: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
- v1 can be viewed here: https://lore.kernel.org/linux-arm-msm/20221231131945.3286639-1-bhupesh.sharma@linaro.org/
- v2 addresses the review comments from Konrad.
- This patch is based on my earlier sm6115 usb related changes, which can
  be seen here:
  https://lore.kernel.org/linux-arm-msm/20221215094532.589291-1-bhupesh.sharma@linaro.org/
- This patch is also dependent on my sm6115 eud dt-binding and driver changes
  (v2) sent earlier, which can be seen here:
  https://lore.kernel.org/linux-arm-msm/20230103150419.3923421-1-bhupesh.sharma@linaro.org/

 arch/arm64/boot/dts/qcom/sm6115.dtsi | 42 ++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 030763187cc3f..8e83bab3ed0f6 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -170,6 +170,18 @@ core3 {
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
 	firmware {
 		scm: scm {
 			compatible = "qcom,scm-sm6115", "qcom,scm";
@@ -565,6 +577,29 @@ gcc: clock-controller@1400000 {
 			#power-domain-cells = <1>;
 		};
 
+		eud: eud@1610000 {
+			compatible = "qcom,sm6115-eud", "qcom,eud";
+			reg = <0x01610000 0x2000>,
+			      <0x01612000 0x1000>,
+			      <0x003e5018 0x4>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+
+			ports {
+				port@0 {
+					eud_ep: endpoint {
+						remote-endpoint = <&usb2_role_switch>;
+					};
+				};
+
+				port@1 {
+					eud_con: endpoint {
+						remote-endpoint = <&con_eud>;
+					};
+				};
+			};
+		};
+
 		usb_hsphy: phy@1613000 {
 			compatible = "qcom,sm6115-qusb2-phy";
 			reg = <0x01613000 0x180>;
@@ -1064,6 +1099,13 @@ usb_dwc3: usb@4e00000 {
 				snps,has-lpm-erratum;
 				snps,hird-threshold = /bits/ 8 <0x10>;
 				snps,usb3_lpm_capable;
+				usb-role-switch;
+
+				port {
+					usb2_role_switch: endpoint {
+						remote-endpoint = <&eud_ep>;
+					};
+				};
 			};
 		};
 
-- 
2.38.1

