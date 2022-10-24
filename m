Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B502B60B3F6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJXRWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbiJXRWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:22:01 -0400
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [IPv6:2001:67c:2050:103:465::209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7070419C058;
        Mon, 24 Oct 2022 08:56:40 -0700 (PDT)
Received: from smtp1.mailbox.org (unknown [91.198.250.123])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4MwxXz37PLz9tXK;
        Mon, 24 Oct 2022 16:00:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=noorman.info;
        s=MBO0001; t=1666620019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jwBbiiF+pKf0bcTgRsblZnn0hi/Wak5zHyTIoUTbsXg=;
        b=X9tiX3WtVJIGoT6Io4l77o5nM7sGiyP2NDU2lLNKA1lc58X1abNUvndGiAM2k7TgLlfIkE
        kwvGHv4g+T1hllgldThejlma9JjOR5KhDPL9LYRjWSzr7E7kjLO0UljYTlqRn2QyBX9lQg
        wg/fGUc1BRTbXLEvbxeCb6j1HN+eDro1n2De/CIXnpWL3jmlxn24lQrmsvYlTaOLMb2ic5
        LYNXk0Aa59+OSl/OoEOujYf0iNhGuyp++GrYYi9KtSGhpvIAI05QiiRsztxkUr1MXk8UUW
        Nd31b+DsTTonahKvjjx5mcUYzOGtTPlm8eUY5BkayKNBj5tAgJUT6h0rvS+jAQ==
From:   Job Noorman <job@noorman.info>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>, Job Noorman <job@noorman.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/3] arm64: dts: qcom: sdm632: fairphone-fp3: add touchscreen
Date:   Mon, 24 Oct 2022 15:59:59 +0200
Message-Id: <20221024140001.139111-4-job@noorman.info>
In-Reply-To: <20221024140001.139111-1-job@noorman.info>
References: <20221024140001.139111-1-job@noorman.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4MwxXz37PLz9tXK
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

