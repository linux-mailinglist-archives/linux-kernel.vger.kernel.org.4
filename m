Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A8773B45F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjFWKDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjFWKCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:02:43 -0400
Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch [185.70.40.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2656D2696;
        Fri, 23 Jun 2023 03:02:40 -0700 (PDT)
Date:   Fri, 23 Jun 2023 10:02:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687514559; x=1687773759;
        bh=k4KksBbq8/McHxGjtb+NZJ5FCx67fpjWTiSPHulPdtE=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=SET9IKh2nCqm41H5rmr1dsBs05p9CZUXAB8/2IUaNoMXOyscJw8r//TnXIWGQFSHl
         /LQX9kza2pYksRdSdihfuLD5cvGYMTAD0VLTaa54YY60J4T6s5Z38kk3ghb0MtYqBZ
         enOWwk1Y8g5r5HgIC68TQq0Sd9FxuKupoBgYQVlkzT0kSaCChtSILu/OyF0LVg4aus
         W4LQ3WZUScIm7NKtIdJ3dT8dZrDJjzWyXjSZaxkNRJWNL0y5kEVjFoEB00oyyCOizR
         JZq/pTPx6i5GWTpOBy0F2P431zVbqtiwnEhv3dOJxOApiEVkUzm3pARIwep+P0ONsf
         tP6YGLLr6RLuA==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: qcom: Document msm8939,a7
Message-ID: <20230623100220.5284-1-linmengbo0689@protonmail.com>
In-Reply-To: <20230623100135.5269-1-linmengbo0689@protonmail.com>
References: <20230623100135.5269-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document samsung,a7 bindings used in its device tree.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentatio=
n/devicetree/bindings/arm/qcom.yaml
index 450f616774e0..a6f7ef4f0830 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -186,6 +186,7 @@ properties:
=20
       - items:
           - enum:
+              - samsung,a7
               - sony,kanuti-tulip
               - square,apq8039-t2
           - const: qcom,msm8939
--=20
2.39.2


