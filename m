Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F1C65D076
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjADKM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbjADKMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:12:39 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9AE1DDF1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:12:37 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id w3so3785827ply.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 02:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nqnewyxXuFgx6aFOSnyu8Lg+p/BpJpnIHJgfiwboYTU=;
        b=wqzXRakzCYXuOuBzq9wrJDs0yfvEG+8PL8896UM5cRPULN9jOxR6Em8hX7qRESQIer
         r9MESwQQvBtc7sU6PKoU2H3D2gkFE0jYehKl57AFxBLLUy2zCY/97VSuLsb881O2rgKw
         fhsR4WbhRTssPLdnghuvE/yV//BH9e/N5mDTH2Dz3SA5VMve5ShxWluFzldn4a9SJ8mj
         xbkIguIyr2QI7D7sumV/pPGIW3L14JZOX8mZYquRYSUD3U3j2fhXXLbSNLRnJS96tSnL
         nVKc4SctevAoSjLj0pNBPx2Dsnb35y40OggMoCFSaQklSoQk3xw4qyjZFPq133TY+7Wd
         jPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nqnewyxXuFgx6aFOSnyu8Lg+p/BpJpnIHJgfiwboYTU=;
        b=YNM6w0af7z6mrjyPqCj5X8sQTLurmMvYPNdZnW94Xq4O0jdoW9G4TmMEr/ioW6xQKw
         cQt+FJtGkwXPFqvZ9D8bsXySNBwfp7Tjy/UXnlP6oBduhIGQYsbta+zWcr+r9TIj6vxk
         F/ZsuKPNOxEiA0MC6eIQCjx6w3p6yS006kVvIpPzXwFK1VZ/BOSk0AT9jkFLJirlSrgc
         COVm+YhlkYqsQhptHaFU7Rw1e8u7xEhJM1b7qAEImMIU/6mfQ8PKq6bL5O4NG4WhNOQR
         37iMcpG3un1YJOU325+gi1TNIVIAg+JajpTC6a0Uztkw2DrpVzpAfsrvv+0QySlb3vSv
         kwZw==
X-Gm-Message-State: AFqh2koydD1rQHiRhUMQGYFrl12cDH72LaXa80J6YP9uh+ANxD8smxa3
        nvRWBd6ub4B+XcPvxB8s4KgXrkc2j7kNa5B/t7w=
X-Google-Smtp-Source: AMrXdXtFfijPdwvIfl2vtSGo5cWGIU+y1TAks0PR3m/liBZQ8D7Lke4KR2fQNwceCg4zNUFpcBq6yw==
X-Received: by 2002:a17:902:f604:b0:192:55ab:88fe with SMTP id n4-20020a170902f60400b0019255ab88femr53042837plg.56.1672827157133;
        Wed, 04 Jan 2023 02:12:37 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c5e:e3b5:c341:16de:ce17:b857])
        by smtp.gmail.com with ESMTPSA id l6-20020a170903244600b001869f2120absm23737615pls.294.2023.01.04.02.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 02:12:36 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     quic_schowdhu@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, bhupesh.sharma@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3] arm64: dts: qcom: sm6115: Add EUD dt node and dwc3 connector
Date:   Wed,  4 Jan 2023 15:42:28 +0530
Message-Id: <20230104101228.3964304-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
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
- v2 can be viewed here: https://lore.kernel.org/linux-arm-msm/20230104052047.3945983-1-bhupesh.sharma@linaro.org
- In v3, fix the errors reported by '$ make dtbs_check' for the port sub node:
  ports:
    'oneOf' conditional failed, one must be fixed:
        'port' is a required property
        '#address-cells' is a required property
        '#size-cells' is a required property
- This patch is based on my earlier sm6115 usb related changes, which can
  be seen here:
  https://lore.kernel.org/linux-arm-msm/20221215094532.589291-1-bhupesh.sharma@linaro.org/
- This patch is also dependent on my sm6115 eud dt-binding and driver changes
  (v2) sent earlier, which can be seen here:
  https://lore.kernel.org/linux-arm-msm/20230103150419.3923421-1-bhupesh.sharma@linaro.org/

 arch/arm64/boot/dts/qcom/sm6115.dtsi | 46 ++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 030763187cc3f..a1a4f659587f3 100644
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
@@ -565,6 +577,33 @@ gcc: clock-controller@1400000 {
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
+				#address-cells = <1>;
+				#size-cells = <0>;
+				port@0 {
+					reg = <0>;
+					eud_ep: endpoint {
+						remote-endpoint = <&usb2_role_switch>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
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
@@ -1064,6 +1103,13 @@ usb_dwc3: usb@4e00000 {
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

