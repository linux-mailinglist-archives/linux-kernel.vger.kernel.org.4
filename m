Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987C06317E0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 01:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiKUArC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 19:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiKUAqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 19:46:48 -0500
Received: from mail-40132.protonmail.ch (mail-40132.protonmail.ch [185.70.40.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC106D105
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 16:46:47 -0800 (PST)
Date:   Mon, 21 Nov 2022 00:46:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1668991606; x=1669250806;
        bh=jfqqTP5BWjnX4gaBhfE4ZQlDKqyMGBo+E5+/v+guTYs=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=UU/wmmb5IV9S1hqFyI1b7kbP0tPIEaT+7I9PLm2U1kvjxH+lGbyWMGXJEJ6ijYHi1
         L8VsHGQHvUL/RbhtAH1lDGuMWAgohCj9YT9CAtgeRIeV0Quriw0rRHME3uDvZwDzSw
         22YRr2RB3d3UCSliHbeAtlId1Oywy0SU5ytPgaMdG4IgEnd4SkLUdCAX7/A57ervg3
         4fBoUl4SvaZC9YfnN4TMGQw+xiVGVZ/1DZUv6FjSt8ltO07f5lIfxVMAYkemLBrg6f
         WazVkPI1H4Q8nAzpI1X6amXWOjea4hjEdJhQpDVO4ko2003IVwSce35UuUjfRFpbvW
         wIRhkXtP9Abfg==
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
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/3] dt-bindings: qcom: Document msm8916-acer-a1-724
Message-ID: <20221121004539.3670-1-linmengbo0689@protonmail.com>
In-Reply-To: <20221121004116.3458-1-linmengbo0689@protonmail.com>
References: <20221121004116.3458-1-linmengbo0689@protonmail.com>
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

Document the new acer,a1-724 device tree bindings used in its device tree.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


