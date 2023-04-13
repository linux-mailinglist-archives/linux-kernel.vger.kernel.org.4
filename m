Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F786E1833
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjDMXTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjDMXTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:19:24 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5225524E;
        Thu, 13 Apr 2023 16:18:57 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id D6DB9D0C4C;
        Thu, 13 Apr 2023 23:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1681427894; bh=LYMz5iebgYMxB7UcMUwq1v4MGuY1Nk+HgQvJiW6S+gI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=Ou2g/TGI2qMapQZNPTM/dD//+2PFxhAmJ8zzWvxnf1u5EYrcjO2/itRX+luAb8aaN
         tX3TBCFkAxp7m4pyQrv3TnP6IgzSdV8QlOD9HQzNm6kUqsSXZl3Hc2wFlDmKBaIwRH
         iUjo3LdqkjIpid/EOznYpT9k01qsxC51D29xvnvU=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Fri, 14 Apr 2023 01:17:47 +0200
Subject: [PATCH 3/8] dt-bindings: leds: qcom-lpg: Add compatible for PMI632
 LPG block
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-pmi632-v1-3-fe94dc414832@z3ntu.xyz>
References: <20230414-pmi632-v1-0-fe94dc414832@z3ntu.xyz>
In-Reply-To: <20230414-pmi632-v1-0-fe94dc414832@z3ntu.xyz>
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
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=782; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=LYMz5iebgYMxB7UcMUwq1v4MGuY1Nk+HgQvJiW6S+gI=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkOI2vPwkTy84ABrMChLCwmp8kCLbunVi+cqQxP
 3jMBTnLLyGJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZDiNrwAKCRBy2EO4nU3X
 VjCFD/99xYzu+0uiAPIjuLt9KGf5Ppw1hQ+AwEYAt8Z4WHAyfjjV9l0ZygDZ9vJTiwGSguvLVjK
 2m1zkMSKUqoBrmHGOEhXVNtxCg+tjfs3KVLBlOq4XpvqUfvDy0ABA5keSThBHhTX8MkkbAf9S+w
 r5sowliKsjQo0NQ4b5cwpKxFyWcvDzeZ2/d+5NNCt+NU67/XYQBwqc1y9ZEKduE7Cb8kcWsnmdV
 evMgzjplEzkELJKaUOdN/29bYU2R3sFUHLdu7zUehwNwuSTRnKMZScjIceuvUojWv1JxLa9zBCd
 kjiBTlLsYCAvKbtMx8pfx6vrvCsDqcZvzX3AFYO2gdN+vno03V9odvOHarkHWsfmYoHRL7XikOv
 daa1YU3vbN2YiEYfBJ/XBRjYeqimMHvgIeXPA5Laut0Cwd/VxH1f3C8vUV+CuotmgtuclZ3dC3n
 Fxm6vfrJCsuJRoABM7+UiV+bkfXEAhQlR/OPDvDYqY24ioyheYdXhiJ/FAjmFVptzhCjcNNb9GE
 Cg8CBU6Zx1XM3QH7AwmFlVYuk9KBQcc9CU8NJ/v6b7W4IL11N7O3lqpaf0CuIupWP0Vw/R2Moid
 RNik5qTYzUwnAU/Fiu+8ILO4akLBHwfj37SPHfO1+1prB1IN3YKXqkURhs/m8TZ2lCDgHgQhlYC
 mimWQqzjJFQpGjA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the availability of an LPG configuration for the PMI632 PMIC in
the Qualcomm Light Pulse Generator driver.

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

