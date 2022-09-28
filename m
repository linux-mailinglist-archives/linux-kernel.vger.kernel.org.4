Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338E65EE484
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 20:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbiI1SoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 14:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiI1SoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:44:20 -0400
Received: from mail-4324.protonmail.ch (mail-4324.protonmail.ch [185.70.43.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B529C7C4;
        Wed, 28 Sep 2022 11:44:19 -0700 (PDT)
Date:   Wed, 28 Sep 2022 18:44:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1664390658; x=1664649858;
        bh=bx6LkYA6tSEHnMC6YQRX0QPXJeIZTYibdxAR1z0B574=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=w9dsfzQwEO276D6FEKsnvmWdEg6TrXvVGXWJKEq0Mp2IbzDoyo8fB+92f7UomDyzV
         ZBEAK+cZI44zTw9tcmcqRPu86yV1/uiZqumDQ9iJjadfYdPDwfCAhN2+3b1bu1L0PU
         0DGm3B0WheQ66pzFeyGkXTxoDm9W4Tr4qbZ6HhtYBbMaZky3GaW7MgahPWYrEP94wC
         nRSp7pkFrj7iZkIM9Rk657YdDbTl5JNKioCZR/FMhbDjIpLRzpSbb6ApUCgv4GPqsX
         CDyH1l7BLjlpIakLLLqD/uKoQ4WkUspzVH0qjI+xZpZKbdNOfcuwQaLy/EVF42qb5i
         Qdu+uLZgQ/PNg==
To:     devicetree@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>,
        Julian Ribbeck <julian.ribbeck@gmx.de>,
        Josef W Menad <JosefWMenad@protonmail.ch>,
        Markuss Broks <markuss.broks@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v5 1/4] dt-bindings: qcom: Document bindings for new msm8916-samsung-j5 devices
Message-ID: <20220928184251.186687-1-linmengbo0689@protonmail.com>
In-Reply-To: <20220928184155.186632-1-linmengbo0689@protonmail.com>
References: <20220928184155.186632-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new samsung-j3/j5x device tree bindings used in their
device trees.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentatio=
n/devicetree/bindings/arm/qcom.yaml
index fb1d00bcc847..b1c69d4d9a9a 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -176,7 +176,9 @@ properties:
               - longcheer,l8910
               - samsung,a3u-eur
               - samsung,a5u-eur
+              - samsung,j3
               - samsung,j5
+              - samsung,j5x
               - samsung,serranove
               - wingtech,wt88047
           - const: qcom,msm8916
--=20
2.30.2


