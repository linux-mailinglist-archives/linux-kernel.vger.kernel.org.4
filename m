Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1731F6DCA7E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjDJSKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjDJSKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:10:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA361BD1;
        Mon, 10 Apr 2023 11:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6867061CDE;
        Mon, 10 Apr 2023 18:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BC5C433A0;
        Mon, 10 Apr 2023 18:10:12 +0000 (UTC)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] ARM: dts: qcom: mdm9615: remove superfluous "input-enable"
Date:   Mon, 10 Apr 2023 20:10:04 +0200
Message-Id: <20230410181005.25853-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410181005.25853-1-krzysztof.kozlowski@linaro.org>
References: <20230410181005.25853-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pin configuration property "input-enable" was used with the intention to
disable the output, but this is done by default by Linux drivers.  Since
patch ("dt-bindings: pinctrl: qcom: tlmm should use output-disable, not
input-enable") the property is not accepted anymore.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts b/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
index a8304769b509..b269fdca1460 100644
--- a/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
+++ b/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
@@ -49,7 +49,6 @@ gpioext1_pins: gpioext1-state {
 		gpioext1-pins {
 			pins = "gpio2";
 			function = "gpio";
-			input-enable;
 			bias-disable;
 		};
 	};
-- 
2.34.1

