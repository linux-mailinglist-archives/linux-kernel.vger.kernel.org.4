Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F7A702A51
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239763AbjEOKQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241079AbjEOKQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:16:13 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B84010D1;
        Mon, 15 May 2023 03:15:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684145545; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DU5Ntx1GSrrExqV7mBRR58zNc4UWfZ5m5g1wcJ0Z3p9gFB5T+clYDwVlAxXeZEv60d
    KqMfzbhg4MAVvDDzVooTeZCSDOk4ZkNxXpzB/97yKXbb8pswpoE7DMONMW3BDdLz5F7y
    JB3jbrXT77ZdtcRylB+b6iGdzrU1y4FDI2R/IYSHH4sRbduV/rIAACFpcW7noWqUSEbb
    +/JRS8AXq5v3CdzDtmkU3od4JvgybIWrvQ3tdJ1crZqFzV3rXfLTU/l1mfxdZBLRwLUg
    V/2q9kP531H7bRpIa/oOc4SkMeuCVTsyXceZiuX+oQtjfCdMkW1wHwwUpcgbmzWjTRcG
    NSJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1684145545;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=3LlKTLyOPLCsMajuxocSXbDRZ9+pHs4RCOi8py6qtBg=;
    b=bX/y9U8+/itPfSzXWRkC483pv8zAPoih7A2WKW1YZoJ7CB7KI6NYj2TqgJFecSm6vS
    tAwSIFmg89VmzNqiT19UB144MyJvz0emSsrjLyT5ZEd9zNPzfLLWpjTmS/vwqEpBRC66
    hO51Un1ZCf/Qapr4GEIjptVnpKPGkgbF7yM8XStlbXW1jPLNmz8lu8uDyqbfSWWahsi3
    vrPzv5YYapF1CMnynFRztsaMM87QAxRS9KL5c6eoN+8P7B26AWE9TqmWCw5bTno5o78U
    IFj8oZfZNjkII8RHng46Ygm8jXVRval2rlbDDzvJ9IdaX/Jrem00ZaZySrxNYE1IevX5
    dd3A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1684145545;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=3LlKTLyOPLCsMajuxocSXbDRZ9+pHs4RCOi8py6qtBg=;
    b=kYuWwP8RTvUBZFdkPMyR485etSDWgsiFGYHAItORqhf3cW58TJfaLY2NZPDxSSWGRX
    wuAhoxb07970pDU05wpHpRB1Xed+NPnvCITpNNG+yDwND6DqD501jpbyrAhMJX1Pm5qz
    oCtmA3W573E3Fya9zW5h+cBghK/eB0x/D7sePbujdkFLGY2XUTAMo47xoperDLinX3EJ
    Xc0x4VQAAgP94wnC+VwSx6IpqqRGVFrNBsqzNYxh/EDgQ9LFvTWwSXNj0dV+VchPNypL
    QwfJWmDQAuo6DMmaGfwN+jItj70PXlG/VZmzhPlY19fc2NHAs7FkCT21S2gxE3q/ZR92
    Sapg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1684145545;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=3LlKTLyOPLCsMajuxocSXbDRZ9+pHs4RCOi8py6qtBg=;
    b=SoA2ZDBVnycnBaA/jyKIPH3jOB+OlGcurcQXn89npJE4BewPTk4p2DSSEdiVRV+/oN
    WQnkCGapzkf3VsdTVVCA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4ly9TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4FACO1JJ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 15 May 2023 12:12:24 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 15 May 2023 12:12:19 +0200
Subject: [PATCH RFC 4/5] arm64: dts: qcom: msm8916: Enable modem on two
 phones
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-dt-resv-bottom-up-v1-4-3bf68873dbed@gerhold.net>
References: <20230510-dt-resv-bottom-up-v1-0-3bf68873dbed@gerhold.net>
In-Reply-To: <20230510-dt-resv-bottom-up-v1-0-3bf68873dbed@gerhold.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, devicetree-spec@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DO NOT APPLY - this is just an example to show the motivation for the
patch series. For clarity only some of the device trees are updated.

On MSM8916 there are different independent firmware regions, e.g. for
the modem (mpss), WiFi/Bluetooth (wcnss) or video acceleration (venus).
They need a specific size but the address is relocatable within a
certain memory region as long as the necessary alignment is respected.

The modem firmware size varies from device to device depending on the
available functionality. Right now msm8916.dtsi specifies the firmware
sizes for the DragonBoard 410c SBC, which has smaller firmware because
the modem firmware only implements GPS but not LTE etc.

The modem firmware is much larger on actual smartphones. Unfortunately,
changing the modem/mpss reserved memory size requires shifting all
following reserved memory regions to new addresses as well, even though
the size for the wcnss/venus firmware is the same for all devices.

This introduces quite a lot of churn with many magic addresses and room
for errors. Only two devices are shown in the example below, but similar
diffs would need to be applied to 30+ more similar MSM8916 device trees.

Note that msm8916-longcheer-l8150 is a single exception where the wcnss
firmware is not relocatable and must be loaded at a specific address.
It is included here to show that the dynamic reserved memory allocation
in the next patch handles this automatically.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts      | 29 +++++++++++++++++++++-
 .../boot/dts/qcom/msm8916-samsung-serranove.dts    | 28 +++++++++++++++++++++
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
index f1dd625e1822..4a5eab06c18b 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
@@ -21,14 +21,37 @@ chosen {
 		stdout-path = "serial0";
 	};
 
+	/*
+	 * For some reason, the wcnss firmware is not relocatable, so it must be
+	 * loaded at 0x8b600000. Unfortunately this overlaps with the memory
+	 * region usually used for the modem firmware (0x86800000-0x8b800000).
+	 * However, the modem firmware is relocatable, so wcnss is placed at the
+	 * fixed address and all other firmware regions are moved to a fitting place.
+	 */
 	reserved-memory {
-		/* wcnss.mdt is not relocatable, so it must be loaded at 0x8b600000 */
+		/delete-node/ mpss@86800000;
 		/delete-node/ wcnss@89300000;
+		/delete-node/ venus@89900000;
 
 		wcnss_mem: wcnss@8b600000 {
 			reg = <0x0 0x8b600000 0x0 0x600000>;
 			no-map;
 		};
+
+		venus_mem: venus@8bc00000 {
+			reg = <0x0 0x8bc00000 0x0 0x500000>;
+			no-map;
+		};
+
+		mpss_mem: mpss@8ec00000 {
+			reg = <0x0 0x8ec00000 0x0 0x5000000>;
+			no-map;
+		};
+
+		gps_mem: gps@93c00000 {
+			reg = <0x0 0x93c00000 0x0 0x200000>;
+			no-map;
+		};
 	};
 
 	gpio-keys {
@@ -218,6 +241,10 @@ &blsp1_uart2 {
 	status = "okay";
 };
 
+&mpss {
+	status = "okay";
+};
+
 &pm8916_resin {
 	status = "okay";
 	linux,code = <KEY_VOLUMEDOWN>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
index 1a41a4db874d..25ad098b1503 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
@@ -36,11 +36,35 @@ chosen {
 	};
 
 	reserved-memory {
+		/delete-node/ mpss@86800000;
+		/delete-node/ wcnss@89300000;
+		/delete-node/ venus@89900000;
+
 		/* Additional memory used by Samsung firmware modifications */
 		tz-apps@85500000 {
 			reg = <0x0 0x85500000 0x0 0xb00000>;
 			no-map;
 		};
+
+		mpss_mem: mpss@86800000 {
+			reg = <0x0 0x86800000 0x0 0x5a00000>;
+			no-map;
+		};
+
+		gps_mem: gps@8c200000 {
+			reg = <0x0 0x8c200000 0x0 0x200000>;
+			no-map;
+		};
+
+		wcnss_mem: wcnss@8c400000 {
+			reg = <0x0 0x8c400000 0x0 0x600000>;
+			no-map;
+		};
+
+		venus_mem: venus@8ca00000 {
+			reg = <0x0 0x8ca00000 0x0 0x500000>;
+			no-map;
+		};
 	};
 
 	gpio-keys {
@@ -263,6 +287,10 @@ &blsp1_uart2 {
 	status = "okay";
 };
 
+&mpss {
+	status = "okay";
+};
+
 &pm8916_resin {
 	status = "okay";
 	linux,code = <KEY_VOLUMEDOWN>;

-- 
2.40.1

