Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F293646118
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 19:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiLGSbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 13:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiLGSbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 13:31:32 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0439E6C728;
        Wed,  7 Dec 2022 10:31:31 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 17F6BCA46D;
        Wed,  7 Dec 2022 18:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1670437859; bh=B+AM+CcfgTRFOdwUZ63j7q7vBTSNvVXCXcySWzAp1hM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=Mx4mU9BKB8YHc/pCCWTNpwjZwlu7khgaAy9Kf2Hleee930pwui9NL2JEWdiUKySz3
         i/OuIUPUDuLofPcmVLKcoFv2hf1K3zoM3ADYzgTIdrSitzdMoFMKFVhH/Fi5/kH0gW
         codKX8s7aLBMCgNXAEPK4+TXDBG8jJ+zAOvGjAOw=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Wed, 07 Dec 2022 19:30:39 +0100
Subject: [PATCH v3 2/9] arm64: dts: qcom: msm8953: Adjust reserved-memory nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221207-msm8953-6-1-next-dtbs-v3-v3-2-a64b3b0af0eb@z3ntu.xyz>
References: <20221207-msm8953-6-1-next-dtbs-v3-v3-0-a64b3b0af0eb@z3ntu.xyz>
In-Reply-To: <20221207-msm8953-6-1-next-dtbs-v3-v3-0-a64b3b0af0eb@z3ntu.xyz>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Tony Luck <tony.luck@intel.com>
Cc:     Gabriela David <ultracoolguy@disroot.org>,
        Eugene Lepshy <fekz115@gmail.com>,
        linux-hardening@vger.kernel.org,
        Anton Bambura <jenneron@protonmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Adam Skladowski <a39.skl@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        Danila Tikhonov <JIaxyga@protonmail.com>,
        Gianluca Boiano <morf3089@gmail.com>,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Julian Braha <julianbraha@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Alejandro Tafalla <atafalla@dnyon.com>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2417; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=B+AM+CcfgTRFOdwUZ63j7q7vBTSNvVXCXcySWzAp1hM=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBjkNvb8MkvoDCBCcRBiz6BD2Ywv5+8Tt+2/TenOAMP
 9fleJw+JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY5Db2wAKCRBy2EO4nU3XVgd8EA
 CiJhz7sSU4qDafwF0FGbFj13g+FFDaLxvmCLOzrLlvK7XrrmiwEb7Ii7Vx3x+CAbIApwerVAoY9Ibv
 5th5dGa/saNnV5qJ4BSbtHPFJSbto1tQ3F4tTzEGAM9m+o6GWEPMmXjocwKAY7AT93U14r3pAzYEVZ
 y1WBm7b+tsm5GVeFyxBoE8vofMK46A+6WZ+mG3sb7NprxArhPpbOCcaiyOWQCbCd0IIUG//doqDY4y
 1DOGN0CCE7wdNziNVEkKPCHpyswJKyufCPegR82ry9rMhuDZpnqBTse/+d4oN/hMnjXjw5E76b1AZi
 OU/PmBja55IpXfUxwFWPABIwQJeZcl9M1+brOUQDFdU0T6L/eBCmhRMkcOeU24OilPSXuCXPtTMYen
 Bw0ogjyZvsD1eOVHX9nUfNOwWj+Ik5/rZaHeEkuZoJAYEtWTWQCN1hzXBgCEGB/B4/diMG89d48oXM
 JFSxhUy2KdX4jMyevo9nHintjlmm4HIwsDCpneV0EYAX5BSss/qEyS+WV6MnPVLeFC0Hm7gYPVGYw+
 6iRGwrIsbPo9J6x5AVReaiRvDCE4KplmRChaFXkM6a5lp9LgHdt1LKf5sdNQAbS/h3kJ5729ujOeOr
 Zcwg/LktIR6/UtFA48yeSUuNKYBR9tRqSeQOYHUUhiD5DgKrCgFkP5ZWj2xg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust node names so they're not just memory@ but actually show what
they're used for. Also add labels to most nodes so we can easily
reference them from devices.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index 32349174c4bd..62d2ae30711b 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -245,18 +245,18 @@ reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
-		zap_shader_region: memory@81800000 {
+		zap_shader_region: zap@81800000 {
 			compatible = "shared-dma-pool";
 			reg = <0x0 0x81800000 0x0 0x2000>;
 			no-map;
 		};
 
-		memory@85b00000 {
+		qseecom_mem: qseecom@85b00000 {
 			reg = <0x0 0x85b00000 0x0 0x800000>;
 			no-map;
 		};
 
-		smem_mem: memory@86300000 {
+		smem_mem: smem@86300000 {
 			compatible = "qcom,smem";
 			reg = <0x0 0x86300000 0x0 0x100000>;
 			qcom,rpm-msg-ram = <&rpm_msg_ram>;
@@ -264,47 +264,47 @@ smem_mem: memory@86300000 {
 			no-map;
 		};
 
-		memory@86400000 {
+		reserved@86400000 {
 			reg = <0x0 0x86400000 0x0 0x400000>;
 			no-map;
 		};
 
-		mpss_mem: memory@86c00000 {
+		mpss_mem: mpss@86c00000 {
 			reg = <0x0 0x86c00000 0x0 0x6a00000>;
 			no-map;
 		};
 
-		adsp_fw_mem: memory@8d600000 {
+		adsp_fw_mem: adsp@8d600000 {
 			reg = <0x0 0x8d600000 0x0 0x1100000>;
 			no-map;
 		};
 
-		wcnss_fw_mem: memory@8e700000 {
+		wcnss_fw_mem: wcnss@8e700000 {
 			reg = <0x0 0x8e700000 0x0 0x700000>;
 			no-map;
 		};
 
-		memory@90000000 {
+		dfps_data_mem: dfps-data@90000000 {
 			reg = <0 0x90000000 0 0x1000>;
 			no-map;
 		};
 
-		memory@90001000 {
+		cont_splash_mem: cont-splash@90001000 {
 			reg = <0x0 0x90001000 0x0 0x13ff000>;
 			no-map;
 		};
 
-		venus_mem: memory@91400000 {
+		venus_mem: venus@91400000 {
 			reg = <0x0 0x91400000 0x0 0x700000>;
 			no-map;
 		};
 
-		mba_mem: memory@92000000 {
+		mba_mem: mba@92000000 {
 			reg = <0x0 0x92000000 0x0 0x100000>;
 			no-map;
 		};
 
-		memory@f2d00000 {
+		rmtfs@f2d00000 {
 			compatible = "qcom,rmtfs-mem";
 			reg = <0x0 0xf2d00000 0x0 0x180000>;
 			no-map;

-- 
b4 0.10.1
