Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF3B5B80FD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiINFbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiINFbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:31:23 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F7F6FA05;
        Tue, 13 Sep 2022 22:31:13 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 953565C006A;
        Wed, 14 Sep 2022 01:31:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 14 Sep 2022 01:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1663133472; x=
        1663219872; bh=APxc/mSmgwWOZvUwfXzsxNO8MT7v2MA9SqTEW8ZVVuI=; b=d
        Yx67sL465KSfwtsLGjd+N3XPhUi8e053DdlMuQao5aUkdhFikxdnVUj2+lTNGkfC
        suLNSMG4SxQz1p+dSfrrh9mF3GNEMRg1gnth1YRw4ERJ+5q21hQ+Y5c076hNM8an
        /9e5DAesU3HnJ197S4NDnGsE06ZxY/GCOYkJ1yxexReZBOFOUcvTLk66N3nOuVl/
        mv7N9om2OBJpOhFJMM59sU8KeozCY/IDSGfatzMgytxcoAS6tC5LpUqScUFAeQrQ
        ZhW9e7VgN7/man79/DxAIoMLxMLvwPDMCMjwQ5CtcMtHiL63hnHjafl3cNur7U4X
        yvWkk3RwMjav7ecPjq4Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1663133472; x=1663219872; bh=APxc/mSmgwWOZ
        vUwfXzsxNO8MT7v2MA9SqTEW8ZVVuI=; b=eC8TLuaym//VGKA7JMfz/yPn9Gk9F
        +Lxw1ImHQB8AqcWdEHbso/vJT1TsoksScuPxXVJymdpTGI+aadfUvswrRjAWo8lT
        AVBPEMqBof7W4q52Eou5bDtndWHN80Ic2X9d2Pfk8b24qB3ywaE+nvuPR2lwZRPr
        yegZb/tp1k6rk7yY0GUri5Ko6rddGXwX4ZJXnkZ80VsFf7ujX75GHWp4DX9r40jx
        y8lWN7rj+5Ih4Z69QKke2AEQt4tsZtpO0VkA4e6ypF3rxqbxyIYVXHatDyDWascq
        ILZluQBaaJp2VI4l72X1P1BB0dtRhIyhYgnda/62kHqSClQ/3RpXuPMnA==
X-ME-Sender: <xms:IGchY0TCAFc6WYn2v5edC8fblOUNZDau8_r2K3TmnwX_Nvgs8xebRA>
    <xme:IGchYxzrgRD7y8sddyQCcGoewQ5ciHccvX9pJy2BSGEyg8RMLTACijlRp5ImOPwMM
    MGyHbJKG8Hbb37bXFo>
X-ME-Received: <xmr:IGchYx2bvL0VcXUJUEraF262PongCmQD8pZfYcbp9AYcn8p7s35c1UYlVNkHxwMbKXJqaIli3Z-JBa6HcrhlNYlKH_lnmkqRay6lovfoNXp2U5XMbKMzppv7Bah2NEI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeduhedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeforghthhgvficuofgtuehrihguvgcuoehmrghtthesthhr
    rghvvghrshgvrdgtohhmrdgruheqnecuggftrfgrthhtvghrnhephfffueehtedukeevje
    dvieevffehjeeiteehhfefkeehgeffleefleejudekgfevnecuffhomhgrihhnpehtrhgr
    vhgvrhhsvgdrtghomhdrrghunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepmhgrthhtsehtrhgrvhgvrhhsvgdrtghomhdrrghu
X-ME-Proxy: <xmx:IGchY4CFSaY1FH1So4XWsLQKT0-A_OQzwpTEomr2pe5hd01-ZLeOjQ>
    <xmx:IGchY9ibgimoE-bzfQYxsXIZLtEoEd8JVAcl6IlysvehEBOTDy-Agg>
    <xmx:IGchY0oHp4C9lDxv5EYlVlm60FTQEugrqwUV8kXOwm4MxeF6EKDm8Q>
    <xmx:IGchY-WE7AbEtYaNHluRlqJXND1sJaCCvi5b3RA1t8EVM_4L7fYYsg>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Sep 2022 01:31:09 -0400 (EDT)
From:   Mathew McBride <matt@traverse.com.au>
To:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mathew McBride <matt@traverse.com.au>
Subject: [PATCH 3/3] arm64: dts: ten64: add configuration for fan controller
Date:   Wed, 14 Sep 2022 05:30:30 +0000
Message-Id: <20220914053030.8929-4-matt@traverse.com.au>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20220914053030.8929-1-matt@traverse.com.au>
References: <20220914053030.8929-1-matt@traverse.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Ten64 desktop appliance has a Noctua NF-A4x20 PWM fan,
controlled by a Microchip EMC2301 PWM fan controller.

This binding allows the fan speed to be slowed to a
quieter level when the system is not busy.

Reference: https://ten64doc.traverse.com.au/hardware/fan-control/

Signed-off-by: Mathew McBride <matt@traverse.com.au>
---
 .../boot/dts/freescale/fsl-ls1088a-ten64.dts  | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
index ef6c8967533e..fd8261c9a186 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
@@ -87,6 +87,35 @@ sfp_xg1: dpmac1-sfp {
 		los-gpios = <&sfpgpio 7 GPIO_ACTIVE_HIGH>;
 		maximum-power-milliwatt = <2000>;
 	};
+
+	thermal-zones {
+		soc {
+			trips {
+				fanmid0: fanmid0 {
+					temperature = <60000>;
+					hysteresis = <2000>;
+					type = "active";
+				};
+
+				fanmax0: fanmax0 {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "active";
+				};
+			};
+
+			cooling-maps {
+				map2 {
+					trip = <&fanmid0>;
+					cooling-device = <&case_fan 0 6>;
+				};
+				map3 {
+					trip = <&fanmax0>;
+					cooling-device = <&case_fan 7 THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
 };
 
 /* XG1 - Upper SFP */
@@ -231,6 +260,20 @@ at97sc: tpm@29 {
 		compatible = "atmel,at97sc3204t";
 		reg = <0x29>;
 	};
+
+	fanctrl: emc2301@2f {
+		reg = <0x2f>;
+		compatible = "microchip,emc2301";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		case_fan: fan@0 {
+			reg = <0>;
+			min-rpm = /bits/ 16 <3000>;
+			max-rpm = /bits/ 16 <5500>;
+			#cooling-cells = <2>;
+		};
+	};
 };
 
 &i2c2 {
-- 
2.30.1

