Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C152736D08
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjFTNTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjFTNSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:18:33 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FD419BB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:18:09 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b46d270ea1so43752851fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687267084; x=1689859084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsrvnT9T0p/qV1sujN7cDQwrqF3l8gVITHQcDojMsfQ=;
        b=B7jJXdLbFY6JiGjClHRSSf6DZiVKMmjOXV5SnBGF5ad7z7XqKxtc+yQVNYmCN78BEi
         Ghzhgr9+YdfVBd/soZOVY3txRA9zpaNgqoEHkdis+Y5YQY0P949nAxsoeCMSWnARow+m
         4h2cRedBOkHvRTZM3yt9zJTnooNZRICnMHa4F2FNT/qiQFLeLCdbKfT5xdDtsxUz+2uB
         w03xwn71stvluKNY+JLoa/ImThQ9NIMCkaBD5p19DMwdVcOGtHCZZjOmQbgL63loguPy
         qrzqyUMZWuspDDGSmIPHREYKKAgQm1SWWPbJjHb6SaUZyEsTqy1PW9c47zY4dEHNMCej
         yLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687267084; x=1689859084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsrvnT9T0p/qV1sujN7cDQwrqF3l8gVITHQcDojMsfQ=;
        b=Cy/KYtJgzBzzNsI4ekWbPRQJHjTctbq9LccT3up0S+IEmkpP5Ggv8x6tWVfKXo6dun
         IZhmyeD+iwgcbxPa7J0lRvuUZWlp4xSAJjZuyaRolx440fyHVBKx3VYf+PZbIJbpoZJB
         xyRhprR8csXUmPFAXn9Omo2kKlTjigSuY60l2/PnVTVgVaoOPF9F0iyx+oWkCmfRY/Be
         J05Y6jRCKxqTYwmNTleWDCl98dM9ohimJZBEAb9l3x5LuXVqE8fq+pZfZXuypLW2KNB1
         OMTin0AV+fVFzdeP1fJlmCE0x/kucpYwhfR7F/Z+B4ylu0gK6akqY3164uRR/0ttRL/+
         55mA==
X-Gm-Message-State: AC+VfDwlyNxK1EPlohrj2A2e0QmRQShVl1aIJqo+VyUZVCSdtPw86bdq
        nGJ5dScZXnxzECH4k5IWnoFf9Q==
X-Google-Smtp-Source: ACHHUZ4O93uhD9+Mj+NzZ+ELe/fBncbOUow7CyQrPsnk+x1A/Gm8tSYuWZS+WVV1vla4p/R7pM4I4A==
X-Received: by 2002:a2e:300f:0:b0:2b4:7da2:bd8 with SMTP id w15-20020a2e300f000000b002b47da20bd8mr3486877ljw.12.1687267084397;
        Tue, 20 Jun 2023 06:18:04 -0700 (PDT)
Received: from [192.168.1.101] (abxj193.neoplus.adsl.tpnet.pl. [83.9.3.193])
        by smtp.gmail.com with ESMTPSA id h19-20020a2eb0f3000000b002b3318c8d6fsm414433ljl.28.2023.06.20.06.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 06:18:04 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 20 Jun 2023 15:17:46 +0200
Subject: [PATCH 2/4] arm64: dts: qcom: sm6115p-j606f: Hook up display
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-topic-gpu_tablet_disp-v1-2-7bb02bec8dc0@linaro.org>
References: <20230620-topic-gpu_tablet_disp-v1-0-7bb02bec8dc0@linaro.org>
In-Reply-To: <20230620-topic-gpu_tablet_disp-v1-0-7bb02bec8dc0@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687267079; l=2332;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=zXpZVR1TGXql/mDZqvA9lCv4wOWep3YlYHv/GTPOx3A=;
 b=b8fOgcNhr6+pt9Mtgh02NY9s7QIx71BMaKS1KwfeVpAr5zsO+0lqv8OmYA1ruqfOGKh01glFk
 VAvS6XYVTiOCSBNqRrXOznP35sQvFLzmba1El2FVJgSTRpRdN0Qnq7u
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the required nodes, add the required pins and tweak a
regulator to enable non-simplefb display on the Tab P11.

Do note that there exists a second SKU with a different panel+touch
combo, but due to insufficient information, that will need to be
handled separately.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts | 57 +++++++++++++++++++++--
 1 file changed, 52 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
index 81fdcaf48926..a10ce676bd44 100644
--- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
+++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
@@ -65,9 +65,41 @@ ramoops@ffc00000 {
 	};
 };
 
-&dispcc {
-	/* HACK: disable until a panel driver is ready to retain simplefb */
-	status = "disabled";
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&pm6125_l18>;
+	status = "okay";
+
+	panel: panel@0 {
+		compatible = "lenovo,j606f-boe-nt36523w", "novatek,nt36523w";
+		reg = <0>;
+
+		reset-gpios = <&tlmm 82 GPIO_ACTIVE_LOW>;
+		vddio-supply = <&pm6125_l9>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&te_active &sde_dsi_active>;
+
+		rotation = <180>; /* Yep, it's mounted upside down! */
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&mdss_dsi0_out>;
+			};
+		};
+	};
+};
+
+&mdss_dsi0_out {
+	data-lanes = <0 1 2 3>;
+	remote-endpoint = <&panel_in>;
+};
+
+&mdss_dsi0_phy {
+	status = "okay";
 };
 
 &pm6125_gpios {
@@ -212,8 +244,9 @@ pm6125_l17: l17 {
 		};
 
 		pm6125_l18: l18 {
-			regulator-min-microvolt = <1104000>;
-			regulator-max-microvolt = <1312000>;
+			/* 1.104V-1.312V fixed @ 1.232V for DSIPHY */
+			regulator-min-microvolt = <1232000>;
+			regulator-max-microvolt = <1232000>;
 		};
 
 		pm6125_l19: l19 {
@@ -282,6 +315,20 @@ sdc2_gate_pin: sdc2-gate-state {
 		bias-pull-up;
 		output-high;
 	};
+
+	te_active: te-active-state {
+		pins = "gpio81";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	sde_dsi_active: te-active-state {
+		pins = "gpio82";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
 };
 
 &ufs_mem_hc {

-- 
2.41.0

