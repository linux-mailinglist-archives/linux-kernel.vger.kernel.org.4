Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071F761F149
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiKGK4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiKGK4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:56:24 -0500
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00DD193D7;
        Mon,  7 Nov 2022 02:56:22 -0800 (PST)
Received: from smtp202.mailbox.org (unknown [91.198.250.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4N5SpC2YDYz9t0s;
        Mon,  7 Nov 2022 11:56:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=noorman.info;
        s=MBO0001; t=1667818579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jwBbiiF+pKf0bcTgRsblZnn0hi/Wak5zHyTIoUTbsXg=;
        b=ECBpJHIDrHCy5IPgt0z2M9lc3msvjKZOFXvQZniblR/G+hL77pgc4swcYdA5v0kqcFbOKz
        oNb4NOvPk796Ll16ZHvZPXDqoUSd/Zl30QtONoev04jhZCfz6W1fVcZF5G4XISkubYpa0R
        f4/AA1uusLnGrHFU3T5V2Fhl6YcbqI7RcGxdoIXar9lCR9q8wq70DChDgTYNy9rJN2BqPK
        sDFvi6OMvBHWAA9LNPaQkqoRNGYscV3JYyK1xNPZ+YuUilwjSV36DTIVzQSgs8zOWLRkf/
        4XfsmAmo2JT6ocbWFFpbb1bxXTqTAWDrFq9mqd1Cdyx8G2GYLx5YqQYAdpBxdw==
From:   Job Noorman <job@noorman.info>
To:     Job Noorman <job@noorman.info>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH RESEND v6 3/3] arm64: dts: qcom: sdm632: fairphone-fp3: add touchscreen
Date:   Mon,  7 Nov 2022 11:56:04 +0100
Message-Id: <20221107105604.26541-4-job@noorman.info>
In-Reply-To: <20221107105604.26541-1-job@noorman.info>
References: <20221107105604.26541-1-job@noorman.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4N5SpC2YDYz9t0s
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
2.38.1

