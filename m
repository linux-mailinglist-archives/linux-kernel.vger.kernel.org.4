Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCAD6E6A02
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbjDRQoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjDRQoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:44:16 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD941726;
        Tue, 18 Apr 2023 09:44:15 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 0113DCA68E;
        Tue, 18 Apr 2023 16:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1681836223; bh=u1CBeB9oqqUFBQOBq+X+7/lai41Mv4Q6YL0vIaDk/lA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=jcHgu5Hrt0HE6b4Aj5/JAfYiqHx5O2b15i5QpJK8gV4/A+rbEgsWtDWz6JxdCdrJ9
         F0W8b8FwifLoTpKbv9D4sb3N2A8leU4FoJjlCoK8Y/dK0UfjcfUEgsBVKNd0VXK9Xz
         SLtK6D3KQJQKrQmvkgE6nHcqCbKfl2ZMyVQgZZYw=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 18 Apr 2023 18:43:19 +0200
Subject: [PATCH v2 3/8] dt-bindings: leds: qcom-lpg: Add compatible for
 PMI632 LPG block
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-pmi632-v2-3-98bafa909c36@z3ntu.xyz>
References: <20230414-pmi632-v2-0-98bafa909c36@z3ntu.xyz>
In-Reply-To: <20230414-pmi632-v2-0-98bafa909c36@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=846; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=u1CBeB9oqqUFBQOBq+X+7/lai41Mv4Q6YL0vIaDk/lA=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkPsi4kAjUlTtFxKwJrfVRmOrub1QmOv1sjYvuO
 6UdtvwzY/qJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZD7IuAAKCRBy2EO4nU3X
 VnPzEACHYYswejDMm0bO7D5u0DNUD/yxIdqtQnb3/jNBe5zGUvaivZL1BoEbQBRGM/IlrbhEqaC
 d3CzlCgOwDUxfcnDlRMbCnyH+lBWraP0i6WLmsO/V4y5HbK1SuKXilK73+y1h820StMNel1mUKu
 ljR/CF/XNsfFUBTDAjOvh04zGBFSMxmttb5FF8OhMYRuahViJN6uQIcov5j9ffmiFxkM7USCb0f
 R/Yrcgb8syGhVQXDH80JIyEpIkjEVe0HbJGyxPP3vZU+fobaye2JvdzgboN22Dxu5sst+iC+0fu
 TTy8Pg1OWBhRTXnGgESgu8hGYt0VGtgp8isiTyPzyo7YEeRQF36viNepbBxqeRgXpfnuw5e7Z/1
 TRcnmpZQMS3NSDf7xL2tNQwM1sILnNjrEPeq+UbEgnsYCvOgXCQNSQGOqJzCC1Uovj+ZoGHtJKB
 uAVeWKT+Od8nRvzuAL3gV3DEMtbGfEnEHJwek5KCWsuVhEl2VBPTXdVrdCK0MQvPD72XuW3r/AP
 WUSBhhomZlF6LDred2obnGTd3yndwRVrdmu5c4nn7YbRS+r58/TzP/SUO3OK0BNom1FJsY9p2Bi
 qKuLKmhefn20NhkOAtZvahewrP+gdGDY8zgZqOnpBPEZbZP+OZuBKcB3p9AU8AG+7cBflLkr04S
 AJoA15L3gy/gY7w==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the availability of an LPG configuration for the PMI632 PMIC in
the Qualcomm Light Pulse Generator driver.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
index 1df837798249..2e4426894bed 100644
--- a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
@@ -25,6 +25,7 @@ properties:
       - qcom,pm8941-lpg
       - qcom,pm8994-lpg
       - qcom,pmc8180c-lpg
+      - qcom,pmi632-lpg
       - qcom,pmi8994-lpg
       - qcom,pmi8998-lpg
 

-- 
2.40.0

