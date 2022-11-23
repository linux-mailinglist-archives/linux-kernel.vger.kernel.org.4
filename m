Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65232634EC3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 05:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbiKWEPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 23:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbiKWEOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 23:14:43 -0500
Received: from mail-40140.protonmail.ch (mail-40140.protonmail.ch [185.70.40.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CAEEC0A6;
        Tue, 22 Nov 2022 20:13:33 -0800 (PST)
Date:   Wed, 23 Nov 2022 04:13:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1669176811; x=1669436011;
        bh=iZV4jMjwSd5s27CRv+6a+52wBdjGQm1GF/F0PZLQgpE=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=oLGFWtU6jzFN4TfvbUTBFPQuPJ/MPulT/sfaQoqltK0SKTOcX91jvtjKYJGdDS+9Z
         vDN310Kik05tdQdLz2ydqVUxBMTXU7p/ATCAuufTV8TwT1tLort0IxpqRmhipGpUEA
         cnS5uajxcQEY6fk2fPJTJ/oKauKuaMzIx5cMyO+ou6IBFIav5fjm4t4F5vUhmMXKhD
         BT9BSXNS5NPLFDm00rFY0/huleNkZle31XLXHoR7e2iNYjbpamTT3P0BjXpL43xvEa
         uzX107JK77kgDAqYBqJZ4nIFVrsZyAg9JFniQDaZ/Oqq77/zR98YDz2huBfz/SuVL6
         BtlN737Fhkfbw==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 2/5] dt-bindings: qcom: Document msm8916-gplus-fl8005a
Message-ID: <20221123041233.150947-1-linmengbo0689@protonmail.com>
In-Reply-To: <20221123041110.150837-1-linmengbo0689@protonmail.com>
References: <20221123041110.150837-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new gplus,fl8005a device tree bindings used in its
device tree.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentatio=
n/devicetree/bindings/arm/qcom.yaml
index 463509f0f23a..e19aee193c2b 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -182,6 +182,7 @@ properties:
           - enum:
               - alcatel,idol347
               - asus,z00l
+              - gplus,fl8005a
               - huawei,g7
               - longcheer,l8910
               - samsung,a3u-eur
--=20
2.30.2


