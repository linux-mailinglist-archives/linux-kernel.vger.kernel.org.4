Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AC9658722
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 22:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiL1Vre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 16:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiL1Vrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 16:47:31 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70201658F;
        Wed, 28 Dec 2022 13:47:30 -0800 (PST)
Received: from g550jk.. (2a02-8388-6582-fe80-0000-0000-0000-0005.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::5])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id D21C8CC385;
        Wed, 28 Dec 2022 21:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1672264019; bh=8mSUR/0fBny0hhP/llInCi7BMyWBrCqvctJvF+6ru2U=;
        h=From:To:Cc:Subject:Date;
        b=sXfgbIeURVK5vXwvCygeTbOaXzeq4Tb48WWJVtjniEwLmvL0XQIW3hlekOmitaCQx
         nyUzuvca1/b+I8voEVZSuzxsgC5gdKSx47ZqOM2Six9m+HCqMPmKajCi1u6hKo7sF2
         6Qqx0vWdWKvTBCULVt0dZeNOvgZtiExYIpfR3++A=
From:   luca@z3ntu.xyz
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Rob Herring <robh@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2] dt-bindings: pm8941-misc: rename misc node name
Date:   Wed, 28 Dec 2022 22:46:37 +0100
Message-Id: <20221228214636.6292-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Weiss <luca@z3ntu.xyz>

The spmi-pmic bindings is now using usb-detect@ for this node, so adjust
the example to match.

Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml b/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
index 6a9c96f0352a..fbda899fd260 100644
--- a/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
+++ b/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
@@ -49,7 +49,7 @@ examples:
             interrupt-controller;
             #interrupt-cells = <4>;
 
-            usb_id: misc@900 {
+            usb_id: usb-detect@900 {
                     compatible = "qcom,pm8941-misc";
                     reg = <0x900>;
                     interrupts = <0x0 0x9 0 IRQ_TYPE_EDGE_BOTH>;
-- 
2.39.0

