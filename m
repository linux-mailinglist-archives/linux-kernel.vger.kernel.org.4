Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C736310B4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 21:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbiKSU2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 15:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbiKSU1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 15:27:54 -0500
Received: from mail-40132.protonmail.ch (mail-40132.protonmail.ch [185.70.40.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EE61A806
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 12:27:53 -0800 (PST)
Date:   Sat, 19 Nov 2022 20:27:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1668889671; x=1669148871;
        bh=2Yt7Phc5WaA3LcnEtcBrovWGjvE6aC7Nq8for3JJfDM=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=RrU6eZJVU+LakAVlVXz8To/ozyldvwAAts9Uw/sBEQa/MuRnV50NCUaacwMmANsuk
         GBLYjfZpEKz9802DO4H9/9TDAMLmByja8cOOvJhfnfIVCjGbNS4gnK6K+1rsnvqjUN
         ArDW6rY3krhKWWoZKg10dyHbpJDuS1q6gBUBFmAf7WfyWfBp6PbZDvx3kNH2okotAM
         OTJYJjvK+hIAXf80SXlZIjdwZdi8yGVGQsL8SsZgYbqW6KGCfWSejWX2Ud7GO7AHgz
         p5XhOK6uRb+HXKah+D045w4J11HyCjBR1ER9HM0QEB14h45enXPeu1bwaM96fmD7U+
         4E2hupOQrL1fw==
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
Subject: [PATCH 2/5] dt-bindings: qcom: Document bindings for new msm8916-gplus-fl8005a device
Message-ID: <20221119202629.93505-1-linmengbo0689@protonmail.com>
In-Reply-To: <20221119202316.93142-1-linmengbo0689@protonmail.com>
References: <20221119202316.93142-1-linmengbo0689@protonmail.com>
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


