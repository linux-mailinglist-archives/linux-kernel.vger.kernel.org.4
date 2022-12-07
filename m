Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9085564610C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 19:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiLGSbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 13:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiLGSbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 13:31:02 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2296C728;
        Wed,  7 Dec 2022 10:31:00 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 9A931CA469;
        Wed,  7 Dec 2022 18:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1670437859; bh=CL5KW81BJDK7GvVQuSAfITYvbryePD8pkoaJleSZyVs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=lqUvmB3H+zcRLd76BEXcRmo5w2kxggk7jGL3w/QqnJdSi7BeJLlNZ2xLgxVBaPR+l
         UtWwCaB1wmhRqTWZ1rgkDDRYUdGNk/MW7rHHhEDuZizYY/nJ5YJI+iI4C6mpOxMm4i
         zAOX+L1j/duJJ6U4FISia+GtIrISLVDoKiTA0wtw=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Wed, 07 Dec 2022 19:30:38 +0100
Subject: [PATCH v3 1/9] dt-bindings: arm: qcom: document new msm8953-family devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221207-msm8953-6-1-next-dtbs-v3-v3-1-a64b3b0af0eb@z3ntu.xyz>
References: <20221207-msm8953-6-1-next-dtbs-v3-v3-0-a64b3b0af0eb@z3ntu.xyz>
In-Reply-To: <20221207-msm8953-6-1-next-dtbs-v3-v3-0-a64b3b0af0eb@z3ntu.xyz>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Tony Luck <tony.luck@intel.com>
Cc:     Gabriela David <ultracoolguy@disroot.org>,
        Eugene Lepshy <fekz115@gmail.com>,
        linux-hardening@vger.kernel.org,
        Anton Bambura <jenneron@protonmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Adam Skladowski <a39.skl@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        Danila Tikhonov <JIaxyga@protonmail.com>,
        Gianluca Boiano <morf3089@gmail.com>,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Julian Braha <julianbraha@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Alejandro Tafalla <atafalla@dnyon.com>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2237; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=CL5KW81BJDK7GvVQuSAfITYvbryePD8pkoaJleSZyVs=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBjkNva3qghZA5biCuXwpgh6lMoB7b4T0KPile+mQOF
 f8vGFkmJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY5Db2gAKCRBy2EO4nU3XVmnED/
 4gzcuAprln2W+j1EjLWFNbGWy9nN9sEUhLG1US94QGYE4tVTJpQtYWvYx2PRXBrJwKdpw/D7GctwKe
 TRfNtaT4mRzmWaz8vDygAi+LygXuj7cZMPtXFOVORnzf8Rj9+PsFz++kU/qYUykPSeEfzWqZdzGboG
 Gp/+u71MsYKFcZyP7iKigvMy7L/FqOUWULJp3HJrHD/ZaJyFhyWUrzlrdNkVD7wi/ziSHbzhzeVmwG
 BQkkp4Bciw2saPod8opDibMB630eMdH6ffFo/N9RZgotx3s0ErWU4oC4IBqODJUUFBPdb4ejNMv0gN
 kJKwaIOp9GCbff4mmZcqOt7Gu/pmpIUggm4Igg15wZvULKfSvZrQnObKBYHEgNyYO3sIjezcEodeqA
 5e28e6yVPItdNfFy+po4eUWsNvV/l7EJeYNLiZRMShsyGZl3GSo6gr6krS1s5EL1yQS5n1o0UE0xc8
 GT+DXJXZItMKcY93+vCaPBssk336u+pohj6H18D5tB2yIlRATcFGzPCzWqdtyCNDh5PvmXsBJkJsv4
 8hRCPSsGeFnLa7HRqN7zZ7JNdMAvlEVLdrkYdrsbJ0J3aaMsoBAme+NO4ku15DEz60SaWz8HF7urM/
 hG2M258N0X2nM1kkNPUeJF67LUMWxJSFI7S+jRvHtTEl4H2c1O+j2BUAbYAA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the various phones added in upcoming patches. Also allow
qcom,msm-id and qcom,board-id for msm8953 and sdm450.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 27063a045bd0..aa83ef0e8ac1 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -35,6 +35,7 @@ description: |
         mdm9615
         msm8226
         msm8916
+        msm8953
         msm8956
         msm8974
         msm8976
@@ -52,6 +53,7 @@ description: |
         sc8180x
         sc8280xp
         sda660
+        sdm450
         sdm630
         sdm632
         sdm636
@@ -213,6 +215,15 @@ properties:
           - const: qcom,msm8916-v1-qrd/9-v1
           - const: qcom,msm8916
 
+      - items:
+          - enum:
+              - motorola,potter
+              - xiaomi,daisy
+              - xiaomi,mido
+              - xiaomi,tissot
+              - xiaomi,vince
+          - const: qcom,msm8953
+
       - items:
           - enum:
               - lg,bullhead
@@ -693,6 +704,11 @@ properties:
               - qcom,sc8280xp-qrd
           - const: qcom,sc8280xp
 
+      - items:
+          - enum:
+              - motorola,ali
+          - const: qcom,sdm450
+
       - items:
           - enum:
               - sony,discovery-row
@@ -709,6 +725,7 @@ properties:
       - items:
           - enum:
               - fairphone,fp3
+              - motorola,ocean
           - const: qcom,sdm632
 
       - items:
@@ -922,10 +939,12 @@ allOf:
               - qcom,apq8026
               - qcom,apq8094
               - qcom,apq8096
+              - qcom,msm8953
               - qcom,msm8992
               - qcom,msm8994
               - qcom,msm8996
               - qcom,msm8998
+              - qcom,sdm450
               - qcom,sdm630
               - qcom,sdm632
               - qcom,sdm845

-- 
b4 0.10.1
