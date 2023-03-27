Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3296CADD8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjC0Ss7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbjC0Ssn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:48:43 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0751709;
        Mon, 27 Mar 2023 11:48:37 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4PlhfV0gPdz9sWt;
        Mon, 27 Mar 2023 20:48:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1679942914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ii3vQ4PmnknxwthxZgNTHiVuAEdqpO2ETRYpvK0GqeI=;
        b=qgcLO3rXxr6WGYorpbydnhnNKgMXxhN8Wba0T5qlN+YUHZsXr9R9/M7bbNxyM9T7LafN8m
        KHUcFJrygNfJu6kErxDD6SUnRh2bd84nC8MTlie4IcFNuWJzVeRf9VY0NqIWXX7reA7kIY
        rL7Co7rsYr/rXfvUWijnyg33kTAfcJVRjhEH3i5JL/VxCdQCpaId1IoH2Awl+pzrj0ph60
        p7UyyB1M728SvY2JzCqU+5UMvMmvXDShInuzjTYhapuPGYZ0M1cARjlTLG+gMXRlBR23ax
        poD41vGBXJzq5oy9xD3HyiwunddzOkrM7cmkXkQcRrdhKLml+UZtQuqAYtecaw==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH v2 4/5] dts: arm64: qcom: sdm845-oneplus: enable SLPI
Date:   Mon, 27 Mar 2023 20:48:10 +0200
Message-Id: <20230327184811.499553-5-me@dylanvanassche.be>
In-Reply-To: <20230327184811.499553-1-me@dylanvanassche.be>
References: <20230327184811.499553-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4PlhfV0gPdz9sWt
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

