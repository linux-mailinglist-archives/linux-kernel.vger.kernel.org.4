Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA1B6310F3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 21:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbiKSUqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 15:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbiKSUqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 15:46:16 -0500
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4590113D2D;
        Sat, 19 Nov 2022 12:46:16 -0800 (PST)
Date:   Sat, 19 Nov 2022 20:46:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1668890774; x=1669149974;
        bh=eIEl89I/FCcRoTqjgCQKLi93kH0LmWEm09LZk3oD43E=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=o9jdWtIzMRGBJEgsVnmuit/HdR3EJp5gPgs3+JEXIk6r6Glpm24NbJYu9brKu/oy6
         RO9hgmsgxNNAtdC+k/HthoX5SnPvrOOO0Tp9WG2yn2vzNOuU2D8rhLmuP7ewOy1WlM
         26U7zNYUk+/Vpm2GBAbfxw8UqrU8Nj7px4KQDeBFxBDr+7X8J1+gs4LplQ7nbAg+ia
         N8x2b0ObtNk11amTxf6cDwrSiBH7z8/VYcKBsEapIkPEJ03Wjge9mgn0MEjP91JG8R
         L/2UilzBWnSvY+MZ8UaVha//mXWSn2rkT7490G10kd5hCcYity9728MnoOzSBl9qey
         CnZftt6fDrmCg==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v2 1/3] dt-bindings: qcom: Document bindings for new msm8916-acer-a1-724 device
Message-ID: <20221119204405.94233-1-linmengbo0689@protonmail.com>
In-Reply-To: <20221119204209.94125-1-linmengbo0689@protonmail.com>
References: <20221119204209.94125-1-linmengbo0689@protonmail.com>
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

Document the new acer,a1-724 device tree bindings used in its device tree.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentatio=
n/devicetree/bindings/arm/qcom.yaml
index 463509f0f23a..83f6748979a9 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -180,6 +180,7 @@ properties:
=20
       - items:
           - enum:
+              - acer,a1-724
               - alcatel,idol347
               - asus,z00l
               - huawei,g7
--=20
2.30.2


