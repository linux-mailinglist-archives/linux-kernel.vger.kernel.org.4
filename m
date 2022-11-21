Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8C96317F3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 01:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiKUAw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 19:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiKUAws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 19:52:48 -0500
Received: from mail-4027.protonmail.ch (mail-4027.protonmail.ch [185.70.40.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A8D1144C
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 16:52:47 -0800 (PST)
Date:   Mon, 21 Nov 2022 00:52:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1668991965; x=1669251165;
        bh=2Yt7Phc5WaA3LcnEtcBrovWGjvE6aC7Nq8for3JJfDM=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=NlxSVT17CFbqUCbtDe0TUA/IWwkSyFmTRn8aztuwnIbpmA3ZDcMl2dKx1XZQN0WCU
         +EYfAyV6jxVds37gDUxDd9y8lpIsN+L3mHH2fSttvsXc5f/tNVfbRsD17/bL+3ACSj
         1lRPByu2VE5nRKyH1ggNaoJBGG0W/dNHAhVcCWMoFjfAJUdv92BIADNJ3OdB4Z3DUB
         XAfBv7x5DC6IOb8DrPtrbgNdv+pFpoUlibcsUumCOm3E+aFbZkTI7z4T/oC2RM5+F0
         VCJWwYyxAAYbqLjZvHy2OLBz43kD19aF3tkqXqcTfNXK0VQ1eq0D/adAU5GPmKAHxy
         TAZ7vKJG/I0UA==
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
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v2 2/5] dt-bindings: qcom: Document msm8916-gplus-fl8005a
Message-ID: <20221121005128.4245-1-linmengbo0689@protonmail.com>
In-Reply-To: <20221121004813.3883-1-linmengbo0689@protonmail.com>
References: <20221121004813.3883-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new gplus,fl8005a device tree bindings used in its
device tree.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
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


