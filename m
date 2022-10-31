Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62E9613C55
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbiJaRkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiJaRkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:40:19 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E1610554;
        Mon, 31 Oct 2022 10:40:19 -0700 (PDT)
Received: from g550jk.arnhem.chello.nl (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id ABBB2D01B5;
        Mon, 31 Oct 2022 17:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1667237987; bh=GDhGOeBuz53WBcObyjQCoYK9JeJOabBRag+IKc2FGBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JoSqj/1W/uDUg2GQrW5U0IcaduRAVV2IIybMw2Q0K3xncFjfNry+DXhvploM3T1rv
         UWIxFDcoV6w/He1lSk5Q17aA6t4PZd+Vs8SKDmlZ3Ma/2PZ0YzKsnKwlw8XDG+UBco
         2HmUxGqyUykXfbhXa7aJ8e09zxP0Q3CHmU6wRDlA=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afd@ti.com, Luca Weiss <luca@z3ntu.xyz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 2/3] regulator: dt-bindings: qcom,usb-vbus-regulator: change node name
Date:   Mon, 31 Oct 2022 18:39:32 +0100
Message-Id: <20221031173933.936147-2-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031173933.936147-1-luca@z3ntu.xyz>
References: <20221031173933.936147-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb-vbus-regulator is a better generic node name than dcdc to change the
example to match.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
* New patch

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
2.38.1

