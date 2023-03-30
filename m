Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2316D0BF7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjC3QyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjC3Qx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:53:56 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7A4EC58;
        Thu, 30 Mar 2023 09:53:44 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4PnTyY2c4Hz9sSK;
        Thu, 30 Mar 2023 18:53:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1680195221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ii3vQ4PmnknxwthxZgNTHiVuAEdqpO2ETRYpvK0GqeI=;
        b=cPdZFgZiAsX+wVexQkxMHa2aPlYWFBd7mZuAwDlnwW5LL+Lfw+C+cFLFF6O2TwatG+qKv4
        yYe7TOVve+4iLU6ipyCl+0tlNXAlDujzUjMPTebvQTylROBo/tS9wmUD+8JSvXid4Yu9Na
        AGS9ZaqSfj+2aFMjC41ILeHGaec+EnvaeJYgxuGAyZmO6+h7eItwisiZz+JyA15U7PPw6K
        lY9P7u5MOLCqKKKa+NSWiQTtgjEgB62sX68vrNBJTlhYHlUheh3S8DePc2PAwbxO8zrF3W
        srqahIhJlm3X956Hgs5q7a6AZ8XWh7QsmKqZF3pIjDMO9gb8mUgwDeAB6Ss+yw==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH v3 3/4] dts: arm64: qcom: sdm845-oneplus: enable SLPI
Date:   Thu, 30 Mar 2023 18:53:21 +0200
Message-Id: <20230330165322.118279-4-me@dylanvanassche.be>
In-Reply-To: <20230330165322.118279-1-me@dylanvanassche.be>
References: <20230330165322.118279-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4PnTyY2c4Hz9sSK
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

