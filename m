Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255667082C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 15:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjERNbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 09:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjERNbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 09:31:42 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BA1125;
        Thu, 18 May 2023 06:31:41 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4QMW8p0Rp4z9skj;
        Thu, 18 May 2023 15:31:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1684416698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Bf15UF6wzUaFEfbGD587CDG2X37fx7pxZEHgq3jWng=;
        b=foNd2LZCjoFMcjUKq5Qv++XfRw+INCTlE8wsMNR9nSx3Ohfain0+CaSbXajowYz6NkQHBk
        9lg9anXsaVe3KtQ78+F+YSpIrmIKDRwD+kgb/DVfLnKJUrvLarWjzsodTc5D1f7oSaPGUW
        mKGvN32nb99M9HonSsYuOzIBmQv3i13FgjUm/UdKspixxYbMBt2aHaz3B183jLoz2Uyqw3
        MMl9QsprxVtLH8S1uhV4Dd3GxwN1JZnV+ui821WnnXJNGWS9/PXtG7aoxKUG9TtZBwN15b
        iUIK/UaUgS3/wIR5i9Kx0lAGX0OR2aQg5ZvDIYyVJD1H00z1fQrr1CT2dQbKcg==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        pavel@ucw.cz, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_fenglinw@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        amartinz@shiftphones.com, Dylan Van Assche <me@dylanvanassche.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/3] arm64: dts: qcom: pmi8998: add flash LED controller
Date:   Thu, 18 May 2023 15:31:12 +0200
Message-Id: <20230518133113.273880-3-me@dylanvanassche.be>
In-Reply-To: <20230518133113.273880-1-me@dylanvanassche.be>
References: <20230518133113.273880-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm PMIC PMI8998 has a 3 channel flash LED driver which is used
by many phones for 1 or 2 flash LEDs. Each LED can be used in flash mode
or torch mode. Add the flash LED controller node to PMI8998 DTS.

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmi8998.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
index ffe587f281d8..08e00819b39d 100644
--- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
@@ -60,6 +60,12 @@ pmi8998_lpg: pwm {
 			status = "disabled";
 		};
 
+		pmi8998_flash: led-controller@d300 {
+			compatible = "qcom,pmi8998-flash-led", "qcom,spmi-flash-led";
+			reg = <0xd300>;
+			status = "disabled";
+		};
+
 		pmi8998_wled: leds@d800 {
 			compatible = "qcom,pmi8998-wled";
 			reg = <0xd800>, <0xd900>;
-- 
2.40.1

