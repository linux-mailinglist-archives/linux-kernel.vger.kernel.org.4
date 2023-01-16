Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C54066D088
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 21:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbjAPUtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 15:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbjAPUsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 15:48:10 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2FB2B086;
        Mon, 16 Jan 2023 12:48:05 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id n7so2552780wrx.5;
        Mon, 16 Jan 2023 12:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTQcxRSsDdNAmsWj8v2rraUSWcRmffK40pcDPX9MDPE=;
        b=eJpQMTL9DTzM8UbZ7Fl+3J41l5BqMK+iITIqr7Vz7af2vbVCPDNa19QOdYZZZvgq1K
         g0UbeXM4AukFSjsY012L9LEySpKHK7UX0o/En5pg+Mzuv6CTaxR0EcHOiVH4Jl9gO48z
         n2CmUgwHQuehcYK2/HaG8a5xlH/9T8v3awE8CN+PMMpO51/TPvKGqRC+bE4v35Cy9JLN
         6nba9f6ztZX5z0B4bZDwJ+hipWPOmmdX/x+L4pe9UfeO7oc0jNnXzldVz19OLZxGe+o0
         Jy+PikJJKvvn+HxP//daS1ZfyRfmdh9OPFJmD4631rfm/NBsKTnM4PZ7m224umUPCVki
         +llw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTQcxRSsDdNAmsWj8v2rraUSWcRmffK40pcDPX9MDPE=;
        b=YzzoDI3q0eh/oPBW4kPfo3+0ewNK4/iH7NGHnlzkZp/6hMjw75ys5uWIe7bVKiEny9
         ZIvP1QfpZ6m3BniTRNQO6tf/6hnvml8ue7TXpDhkighgO0TRjhvsVOjkPYVsOWBUczp6
         KLJv14PorDNrFHIchUorWPzqDyRgwZ/IYdQNTpSKscb9WjP+wH+Ili1MmkiX06kK70xO
         B3FmMlzRrNOWJWaLgUmv7rACJh0L6G9+ctOS1j+VQA1d1qM0pe+Dbn+NzJc1HZNj8xaA
         W0O0wfp39U2j3iyVgqr9P60sH5kfI3cdmft6zNuPlGPnhc9t32Bz3Z2tZFlRykM1RXRP
         H+jg==
X-Gm-Message-State: AFqh2krXtRyqyCdc2L7c7oQ5DptlCw5eXNOAD6vgMz5cxRaxb94L185x
        NbJS7Gq8khaeIJJV9Ks2/O6Y3usDKUE=
X-Google-Smtp-Source: AMrXdXuZI2PiJ9CAMQ8ZgFdZNgSImhtfa0M4kSb9rN6EwatsAe5QG768gV5TvnbTtTDhLdiaD8Uo/A==
X-Received: by 2002:adf:e109:0:b0:2bd:e547:943a with SMTP id t9-20020adfe109000000b002bde547943amr675272wrz.14.1673902084323;
        Mon, 16 Jan 2023 12:48:04 -0800 (PST)
Received: from localhost.localdomain (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.googlemail.com with ESMTPSA id k18-20020adfb352000000b00241fab5a296sm27785372wrd.40.2023.01.16.12.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 12:48:04 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v7 6/7] ARM: dts: qcom: add missing clock configuration for kpss-acc-v1
Date:   Mon, 16 Jan 2023 21:47:50 +0100
Message-Id: <20230116204751.23045-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230116204751.23045-1-ansuelsmth@gmail.com>
References: <20230116204751.23045-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing clock configuration by adding clocks, clock-names,
clock-output-names and #clock-cells bindings for each kpss-acc-v1
clock-controller to reflect Documentation schema.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 16 ++++++++++++++++
 arch/arm/boot/dts/qcom-ipq8064.dtsi |  8 ++++++++
 arch/arm/boot/dts/qcom-msm8960.dtsi |  8 ++++++++
 3 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 1e68b42acb91..af84f2d350ef 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -389,21 +389,37 @@ timer@200a000 {
 		acc0: clock-controller@2088000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			clock-output-names = "acpu0_aux";
+			#clock-cells = <0>;
 		};
 
 		acc1: clock-controller@2098000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			clock-output-names = "acpu1_aux";
+			#clock-cells = <0>;
 		};
 
 		acc2: clock-controller@20a8000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x020a8000 0x1000>, <0x02008000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			clock-output-names = "acpu2_aux";
+			#clock-cells = <0>;
 		};
 
 		acc3: clock-controller@20b8000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x020b8000 0x1000>, <0x02008000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			clock-output-names = "acpu3_aux";
+			#clock-cells = <0>;
 		};
 
 		saw0: power-controller@2089000 {
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index de87fcaaa836..e796094a7af5 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -580,6 +580,10 @@ l2cc: clock-controller@2011000 {
 		acc0: clock-controller@2088000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			clock-output-names = "acpu0_aux";
+			#clock-cells = <0>;
 		};
 
 		saw0: regulator@2089000 {
@@ -591,6 +595,10 @@ saw0: regulator@2089000 {
 		acc1: clock-controller@2098000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			clock-output-names = "acpu1_aux";
+			#clock-cells = <0>;
 		};
 
 		saw1: regulator@2099000 {
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 3bd07cac315b..4fd56d85be3f 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -208,11 +208,19 @@ regulators {
 		acc0: clock-controller@2088000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			clock-output-names = "acpu0_aux";
+			#clock-cells = <0>;
 		};
 
 		acc1: clock-controller@2098000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			clock-output-names = "acpu1_aux";
+			#clock-cells = <0>;
 		};
 
 		saw0: regulator@2089000 {
-- 
2.37.2

