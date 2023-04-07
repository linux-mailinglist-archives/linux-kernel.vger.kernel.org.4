Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5826DB358
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjDGSs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjDGSsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:48:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A747CC24;
        Fri,  7 Apr 2023 11:47:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3312F6101E;
        Fri,  7 Apr 2023 18:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1279FC433A1;
        Fri,  7 Apr 2023 18:47:14 +0000 (UTC)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <me@iskren.info>,
        Martin Botka <martin.botka@somainline.org>,
        Danila Tikhonov <danila@jiaxyga.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 17/40] dt-bindings: pinctrl: qcom,msm8998: simplify with unevaluatedProperties
Date:   Fri,  7 Apr 2023 20:45:23 +0200
Message-Id: <20230407184546.161168-17-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407184546.161168-1-krzysztof.kozlowski@linaro.org>
References: <20230407184546.161168-1-krzysztof.kozlowski@linaro.org>
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

All Qualcomm SoC Top Level Mode Multiplexer pin controllers have similar
capabilities regarding pin properties, thus we can just accept entire
set provided by qcom,tlmm-common.yaml schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,msm8998-pinctrl.yaml        | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.yaml
index c07ee9868046..bd6d7caf499a 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.yaml
@@ -53,6 +53,7 @@ $defs:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
     $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
+    unevaluatedProperties: false
 
     properties:
       pins:
@@ -107,19 +108,9 @@ $defs:
                 vsense_clkout, vsense_data0, vsense_data1, vsense_mode,
                 wlan1_adc0, wlan1_adc1, wlan2_adc0, wlan2_adc1 ]
 
-      bias-pull-down: true
-      bias-pull-up: true
-      bias-disable: true
-      drive-strength: true
-      input-enable: true
-      output-high: true
-      output-low: true
-
     required:
       - pins
 
-    additionalProperties: false
-
 allOf:
   - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
 
-- 
2.34.1

