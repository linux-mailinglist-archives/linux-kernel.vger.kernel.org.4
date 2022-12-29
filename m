Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D70B6590C9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 20:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbiL2TQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 14:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiL2TQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 14:16:14 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3F026CD;
        Thu, 29 Dec 2022 11:16:12 -0800 (PST)
Received: from g550jk.. (2a02-8388-6582-fe80-0000-0000-0000-0005.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::5])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 9FC4FCB3E2;
        Thu, 29 Dec 2022 19:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1672341371; bh=BwmNfrnC9I+GiGR/3bg5Bb/Y5dTALbbsYRPeCuZ84Kc=;
        h=From:To:Cc:Subject:Date;
        b=EZ5eONgQx+0jLmVftvyyO310FabLq5KR5Rjm7lzfKvUyG+nG+WuFt5kP0lVQUQqY3
         noOLlzRSjRBHPfskW0gtiS+XYHOE/qOfomuQLK/I4LvEHostYkKZyR0cTvw7rCzINF
         dVuzoGv0/v4dz1JD6LxseJyyCZraYBBJe4Bm3kWc=
From:   luca@z3ntu.xyz
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Rob Herring <robh@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3] regulator: dt-bindings: qcom,usb-vbus-regulator: change node name
Date:   Thu, 29 Dec 2022 20:15:43 +0100
Message-Id: <20221229191542.123367-1-luca@z3ntu.xyz>
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

usb-vbus-regulator is a better generic node name than dcdc to change the
example to match.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v3:
- No change, resend since all other patches from series have been merged

 .../devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
index dbe78cd4adba..b1cff3adb21b 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
@@ -33,7 +33,7 @@ examples:
      pm8150b {
         #address-cells = <1>;
         #size-cells = <0>;
-        pm8150b_vbus: dcdc@1100 {
+        pm8150b_vbus: usb-vbus-regulator@1100 {
             compatible = "qcom,pm8150b-vbus-reg";
             reg = <0x1100>;
         };
-- 
2.39.0

