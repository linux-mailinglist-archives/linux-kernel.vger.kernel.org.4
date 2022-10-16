Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBBD5FFEA3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 12:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiJPKgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 06:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiJPKf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 06:35:59 -0400
X-Greylist: delayed 442 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 Oct 2022 03:35:54 PDT
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE978367B5;
        Sun, 16 Oct 2022 03:35:54 -0700 (PDT)
Received: from smtp102.mailbox.org (unknown [91.198.250.119])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4MqxDJ5cTRz9tdL;
        Sun, 16 Oct 2022 12:28:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=noorman.info;
        s=MBO0001; t=1665916112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S9dcsqJ0RaWCdCguljfpy7EPjfO3aVZqXfHBh2syRzs=;
        b=PW6BcCOVvdRubT2MiVhayL4rxpCCYMisSOpA54cmnYgztUvLOH6cQgZZG1ZI2xNhZs5UMy
        lbR3NZbovfD61NazppymLDhnSHFElM82aO2+tFKoRLSabj+FgI5L9UoZIlgoEyO6EGTuDE
        NxFz6QE7OJd8Y/vOyjKEWxbnloHSKXgVsivypAGQaml17Rgm/s8UNIvOkA2OV27a2lWO4x
        jBmNGb6QgrF0eLP+PknfqCfihAY8u7MmwRNWBERy0UiyeteUc22JQYlOm1semTWxd2fOoe
        9GEadMAtBpZyYzvvUvVRZUUnb3LLieOqtKRPQZXzjkzil2TpzlkzB7YfqxJadg==
From:   Job Noorman <job@noorman.info>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>, Job Noorman <job@noorman.info>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] arm64: dts: qcom: sdm632: fairphone-fp3: add touchscreen
Date:   Sun, 16 Oct 2022 12:27:55 +0200
Message-Id: <20221016102756.40345-4-job@noorman.info>
In-Reply-To: <20221016102756.40345-1-job@noorman.info>
References: <20221016102756.40345-1-job@noorman.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4MqxDJ5cTRz9tdL
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Himax hx83112b touchscreen to the FP3 DT.

Signed-off-by: Job Noorman <job@noorman.info>
---
 arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
index 891e314bc782..2920504461d3 100644
--- a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
+++ b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
@@ -49,6 +49,20 @@ &hsusb_phy {
 	vdda-phy-dpdm-supply = <&pm8953_l13>;
 };
 
+&i2c_3 {
+	status = "okay";
+
+	touchscreen@48 {
+		compatible = "himax,hx83112b";
+		reg = <0x48>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <65 IRQ_TYPE_LEVEL_LOW>;
+		touchscreen-size-x = <1080>;
+		touchscreen-size-y = <2160>;
+		reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
+	};
+};
+
 &pm8953_resin {
 	status = "okay";
 	linux,code = <KEY_VOLUMEDOWN>;
-- 
2.38.0

