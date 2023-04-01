Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3866F6D32E8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 19:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjDARgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 13:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjDARft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 13:35:49 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02B525477;
        Sat,  1 Apr 2023 10:35:48 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Ppkp93Lknz9sk8;
        Sat,  1 Apr 2023 19:35:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1680370545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RjQywl0qasOi8g9t9JlZMByy/hpTTSMy1fxXvskHBnU=;
        b=su4zcFVqp3GBMh9nSiDgCcxB/rSOUSjEVt/odsoSfU09XyiANA/VLO1XcRkL6Yh8vbwTr/
        rab3Mqq0VhIXN9IYiadqpRbC5vc7Z+r+T5GUNUR5rVXwniL5dM/KJ/Vpi4P51a95NAb6HP
        bfLuIPs2abghGQlNaEpU/xm+N2VZv6xA1pnnrS3EU1wD3LEoKbtOu6S8N7FSxpdjaFDwSM
        mK4FQgNmFiPnj/6d9gAHABayT5IDBCnqdKcbkg6bwCt35k+TMF85pxdIgYTO1EY+swspnY
        c+NjMwkDznzbBFX4U6U817wT5jBDUdnYjl6XqPcYNpysnwBBdQZshKpeZP5K/g==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 5/6] dts: arm64: qcom: sdm845-oneplus: enable SLPI
Date:   Sat,  1 Apr 2023 19:35:22 +0200
Message-Id: <20230401173523.15244-6-me@dylanvanassche.be>
In-Reply-To: <20230401173523.15244-1-me@dylanvanassche.be>
References: <20230401173523.15244-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the SLPI DSP on the Oneplus 6 phone with a Qualcomm SDM845 SoC.

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index b01542d79ae2..3bd15984990c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -552,6 +552,11 @@ &qup_uart9_tx {
 	bias-disable;
 };
 
+&slpi_pas {
+	firmware-name = "qcom/sdm845/oneplus6/slpi.mbn";
+	status = "okay";
+};
+
 &sound {
 	compatible = "qcom,sdm845-sndcard";
 	pinctrl-0 = <&quat_mi2s_active &quat_mi2s_sd0_active &quat_mi2s_sd1_active>;
-- 
2.39.2

