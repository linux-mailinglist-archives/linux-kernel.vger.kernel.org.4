Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB092715667
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjE3HQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjE3HPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:15:49 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB09F0;
        Tue, 30 May 2023 00:15:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685430935; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hIETjvfRUPcswSUT30nPl2XN6gPhnqkEFkDa1hC1TZ9u6L7IIf6tD/MPr4JAujMTKg
    1+c4RqO+X/PfTSDvHcEsJZ/hh/h+r3/SXwNJgJwUbGnyzN1qmdoCBsUchlr2Xo4LLPW8
    qJSubmwEgp6TvkJ94YxeNVzsIS7bc+h3ahUaNQyuvIkw8cT/w5QniLvH/fDCViLai/BK
    WnaOrLGSH9JwG7txSbHiF2v94lBLUdhrd9WJ2X+EIrT5zcg3ONDB0KRdc2WDRfkxZL4V
    w7IO8z7vheTv/xgNEdOFR7zJY+tqKVKNTKN0n9LLUfcqVMGzDPxWTCBRi03di1Ry+/dB
    a62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685430935;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=PfPd3rGtItY1EzPOTQrppdYvO+Tov4KyYOE0eHH/QQ4=;
    b=qkWjj3DJcYI2BEasgd8mUIWz7LhV6xiZXXGWAjFTfvmLFTa7d12q4HhSyk+qMPpyUG
    xCBm/Q2aWMjghxGwLJqPD+HWSFljzyC3QXpbXKmGOwO4M36VvePp/PfnObDLh5p1+0Bh
    JcTiGTe1LHfRZXu1VguZetVOJsDK1zfAs4CiPLSAdO+FZ1kl54/eSiMWzpLPcDVc91Co
    IBRwP7/0toFUD/0NR3TXkCubm1L+qYcGKR2/dEZu2WdlXbWjA4QRMIR+O1Rjhm37FuoA
    AurlmZqeMzR5i4k12QTuS5orrGyos9hCLx/yeYfxPUf1VFAfZqQ/3bch6UAFGFfkWMFW
    ljVg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685430935;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=PfPd3rGtItY1EzPOTQrppdYvO+Tov4KyYOE0eHH/QQ4=;
    b=fdMq8f4nZbbSkAWAPiRAjECSeMaEZEVpQdtKrOjbG07z63CajtShkcECVk3toYDnRY
    MtzAq5nhp/YuypAWP4uhfBRVWwVPFFlloxJSEFV+VCNPF+cLKNtsH+42x8iwd7ZSrk4D
    +5vz0aPlfk+8fJZCUl2Wqd7pVjOt5kWwIXqFhqG/u1WyaY7F1wKDBGQpuZ6og4EwBrmF
    JR+jc0Pn0mqduJpu143ia6CJG/mqJyXyfT+l+8zQU8nec5gSqgF+EQn8WEn2pwevyQ5d
    rqrmT4OKdIzncaF5drpf5YhBoK+OrsoHw5LK+Fm5uhEjm6WPb9bOCMbbbRi87DJkOYea
    +uBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685430935;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=PfPd3rGtItY1EzPOTQrppdYvO+Tov4KyYOE0eHH/QQ4=;
    b=tWfJyLhN2n06KlJgi2QOeK92m4yGgD48tkwUnRSZD/HzVMiOS0hAlTfExFPbbyzfSf
    dbnGkQQLamKy8ITdf6BA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4xxmw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4U7FZgY3
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 30 May 2023 09:15:35 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 30 May 2023 09:15:26 +0200
Subject: [PATCH 5/6] arm64: dts: qcom: msm8916/39: Rename wcnss pinctrl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230529-msm8916-pinctrl-v1-5-11f540b51c93@gerhold.net>
References: <20230529-msm8916-pinctrl-v1-0-11f540b51c93@gerhold.net>
In-Reply-To: <20230529-msm8916-pinctrl-v1-0-11f540b51c93@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the pinctrl now uses consistent _default/_sleep suffix so rename
the WCNSS pinctrl to be named consistently.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi      | 2 +-
 arch/arm64/boot/dts/qcom/msm8939.dtsi      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
index 2cfaed37cb59..bf7e664c8350 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
@@ -488,7 +488,7 @@ data-pins {
 		};
 	};
 
-	wcnss_pin_a: wcnss-active-state {
+	wcss_wlan_default: wcss-wlan-default-state {
 		pins = "gpio40", "gpio41", "gpio42", "gpio43", "gpio44";
 		function = "wcss_wlan";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index c0aa6a53fbca..e8e6181d4439 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1895,7 +1895,7 @@ wcnss: remoteproc@a204000 {
 			qcom,smem-state-names = "stop";
 
 			pinctrl-names = "default";
-			pinctrl-0 = <&wcnss_pin_a>;
+			pinctrl-0 = <&wcss_wlan_default>;
 
 			status = "disabled";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index de5f8681d18d..3c1505b69a6b 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -1151,7 +1151,7 @@ data-pins {
 				};
 			};
 
-			wcnss_pin_a: wcnss-active-state {
+			wcss_wlan_default: wcss-wlan-default-state {
 				pins = "gpio40", "gpio41", "gpio42", "gpio43", "gpio44";
 				function = "wcss_wlan";
 				drive-strength = <6>;
@@ -1963,7 +1963,7 @@ wcnss: remoteproc@a204000 {
 			qcom,smem-state-names = "stop";
 
 			pinctrl-names = "default";
-			pinctrl-0 = <&wcnss_pin_a>;
+			pinctrl-0 = <&wcss_wlan_default>;
 
 			status = "disabled";
 

-- 
2.40.1

