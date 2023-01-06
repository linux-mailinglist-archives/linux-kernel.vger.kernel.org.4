Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B0165FC75
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 09:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjAFIKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 03:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjAFIKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 03:10:06 -0500
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B670C78E80;
        Fri,  6 Jan 2023 00:10:05 -0800 (PST)
Date:   Fri, 06 Jan 2023 08:09:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1672992602; x=1673251802;
        bh=qsD3j527/4RZYV9cwpzXQRnrBZ/z2yvxDwVwQyYcLbA=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=AR7yfnRt8Mu/0AfiMauvyDQ8kQJKzClA/CKWvc7O0dG1If0+NnMT/cICsEc8PvB34
         T83YHEnd5gImWg3+OnVMoC1TJ7ob1U6Si3h4OSOuRMQyFm8KIp0AhOqzUWb453iQ0p
         wYtqyEi36DiBoDXtwL2CHgUUuSo9ECr2FHrouwQHGAspjjV+lXoJ7l3mFE7s4OfZV5
         wue/dG5LYNxLHK4u8PLkGFgcAOA4/6dIyRhPEE/DfFm+Svr4HwGO0KVZfOGewk0BTs
         LbhDVOB8mTLeeUg6h2dQsIgBTrCMkoGM9QWKbmL4D/R9+fedMxvZr8OefGVwvD/eUr
         owu0D54lUUcaA==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 2/5] dt-bindings: qcom: Document msm8916-gplus-fl8005a
Message-ID: <20230106080858.256048-1-linmengbo0689@protonmail.com>
In-Reply-To: <20230106080644.255940-1-linmengbo0689@protonmail.com>
References: <20230106080644.255940-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 27063a045bd0..f12876889b22 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -196,6 +196,7 @@ properties:
           - enum:
               - alcatel,idol347
               - asus,z00l
+              - gplus,fl8005a
               - huawei,g7
               - longcheer,l8910
               - samsung,a3u-eur
--=20
2.30.2


