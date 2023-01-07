Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64C7660F22
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 14:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjAGNdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 08:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjAGNct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 08:32:49 -0500
Received: from mail-40141.protonmail.ch (mail-40141.protonmail.ch [185.70.40.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C545E676
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 05:32:45 -0800 (PST)
Date:   Sat, 07 Jan 2023 13:32:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1673098364; x=1673357564;
        bh=z02n7iWBNY344G8/xdaURdOpX/YJ6b0Mn2BC+M4sbts=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=DA+wkyyLwHi/BHIaWjh1FVs9qo8xMHEiRyBaVPpZS3nlIPXS58dS3gJm1/kKkyJkz
         qCJK5BDspDdmuc/VTDc2LaR/u1FE8yxa0yDILaLu2J4qMNG/smAAwCMIx+ylVnznje
         yapKAX53zw6UVYb7h1OkPUFTtm6KSW+K8RE7WeCNcImHoJvRwa+oEyQk1IUXx8mcPR
         hFq1qquWBNZ3+qDk4lDJk1TwQxd63tcl9Y7+MyoM/G9A2fgRv/vApYjLbmj9k1BOlv
         cmaweDeG97lZ8Z9mlYuO3tAoNu/ZZnb+oNIRUQJMx3b6FzMhgXOxB6VMgIVJ7LsQSY
         nLWDQdKWAAsHw==
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
Subject: [PATCH v6 1/5] dt-bindings: vendor-prefixes: Add GPLUS
Message-ID: <20230107133145.139731-1-linmengbo0689@protonmail.com>
In-Reply-To: <20230107132932.139669-1-linmengbo0689@protonmail.com>
References: <20230107132932.139669-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for GPLUS.
https://www.gplus.com.tw

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docum=
entation/devicetree/bindings/vendor-prefixes.yaml
index 49f6034d7b65..5ff38589eb79 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -514,6 +514,8 @@ patternProperties:
     description: Shenzhen Huiding Technology Co., Ltd.
   "^google,.*":
     description: Google, Inc.
+  "^gplus,.*":
+    description: GPLUS
   "^grinn,.*":
     description: Grinn
   "^grmn,.*":
--=20
2.30.2


