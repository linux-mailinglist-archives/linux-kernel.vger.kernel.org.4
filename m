Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5914C71EFFB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjFARA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjFARAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:00:23 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2629196;
        Thu,  1 Jun 2023 10:00:22 -0700 (PDT)
Received: from [192.168.122.1] (84-115-214-73.cable.dynamic.surfer.at [84.115.214.73])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 893EECFC8B;
        Thu,  1 Jun 2023 17:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1685638820; bh=liwsTCjCFh4bjc2tccmTcIdepPTZlH+GSHh7zUBFyD8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=AbIqqufT4U2JyvBx09ZBvo75XZHM4bIwgCyV3j9PFAIPzHhEZ4XZ6CYsQ38VaqFj7
         w/XwM6+vsw/85bUVuYYIk9JDUhQ3ECJ/myLFRLOIg8VjJmK6e0yPsVMd/UrfO7+lfA
         1arFyu7DJSzuM0/w8XRFkOeCgVtHgAh2pEaAfyCM=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Thu, 01 Jun 2023 19:00:08 +0200
Subject: [PATCH v3 1/7] dt-bindings: msm: dsi-phy-28nm: Document msm8226
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230308-msm8226-mdp-v3-1-b6284145d67a@z3ntu.xyz>
References: <20230308-msm8226-mdp-v3-0-b6284145d67a@z3ntu.xyz>
In-Reply-To: <20230308-msm8226-mdp-v3-0-b6284145d67a@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1755; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=liwsTCjCFh4bjc2tccmTcIdepPTZlH+GSHh7zUBFyD8=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkeM6c0sP+UId+y6wLfEJfVjt2h7jHBbz6Gk6jE
 sJE4cDlaJmJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZHjOnAAKCRBy2EO4nU3X
 VpHGD/9VT1CjSGY7weNbH6UOmol+5VjzWZKCzcHe9+j4peI3wQ7d6DOwDf3k4a1ebyxpgeSOjAz
 ttH1Qs6DPRfHK+u5D/73nqAJ8M+dh3fmXctEQb0tV4SOI9I69fEevpno3sltLIdEGxEVZAchtF+
 X/XVaKAVRm7S5syZqIZZ1+lVO98mVVOfg3+uJknd+Q/F/qtB4j1120hFEh8lRWeb2unbhvaq/mU
 xsn41+E9Faw7ChQ8AbPW5KI/vELcA7hZnkawh9UN8hz+ZNkIACaWzHlEdWKyUr0YR7LhWFJE1MY
 QfU7zs0MEMOQldL6Se/eoB7OdCyWi69UM67uGJVA3cir87m78Yj6BBJhj7fHbzOoCRwAo4cQiU7
 mRxUaGgpxET/dkpIvCePgl3Pcq1GrqiStLxWcvEVN9sBEfpJmD/HEZeeWsft8/Z09PEUNaibepq
 NvzpqKVbf3lz+yErUDWvIVGTDVhgCtGpBF0QvAtyY/l3Ax5XOzFFlzmeUurmx65tYPdlSsulqYK
 OUVkx5vBwWkS59zkFK0ByRKvsiT42mTTpHXSoGxGlVzo5EuDdDqXWMdNfZOhWrZZxgcAf+EBpn1
 2s6sAS4nMoXLFmQR8A/AOU6cgm//Ahy62XpxzFXkW+pt3Lzt+PL9w/CKJmmBjkpbHBruRluUcDN
 oIMGhmHvpIPLuWA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MSM8226 SoC uses a slightly different 28nm dsi phy. Add a new
compatible for it.

And while we're at it, in the dsi-phy-28nm.yaml move the 8960 compatible
to its correct place so its sorted alphabetically.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/display/msm/dsi-phy-28nm.yaml | 3 ++-
 Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml    | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-28nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-28nm.yaml
index cf4a338c4661..62fb3e484eb2 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-phy-28nm.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-28nm.yaml
@@ -15,10 +15,11 @@ allOf:
 properties:
   compatible:
     enum:
+      - qcom,dsi-phy-28nm-8226
+      - qcom,dsi-phy-28nm-8960
       - qcom,dsi-phy-28nm-hpm
       - qcom,dsi-phy-28nm-hpm-fam-b
       - qcom,dsi-phy-28nm-lp
-      - qcom,dsi-phy-28nm-8960
 
   reg:
     items:
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml
index b0100105e428..db9f07c6142d 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml
@@ -125,6 +125,7 @@ patternProperties:
           - qcom,dsi-phy-14nm-660
           - qcom,dsi-phy-14nm-8953
           - qcom,dsi-phy-20nm
+          - qcom,dsi-phy-28nm-8226
           - qcom,dsi-phy-28nm-hpm
           - qcom,dsi-phy-28nm-lp
           - qcom,hdmi-phy-8084

-- 
2.40.1

