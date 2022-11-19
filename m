Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4116F6310AE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 21:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbiKSU1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 15:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbiKSU1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 15:27:37 -0500
Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch [185.70.40.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0197711A25
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 12:27:35 -0800 (PST)
Date:   Sat, 19 Nov 2022 20:27:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1668889652; x=1669148852;
        bh=67Cv/FauC3/ROtXr7R3r1RHfrn2CFgmEkwbkiRAF9BI=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=vGmHagUVd/7hfvamvU35bvy9zKqfsaPJLaKFzUa1/e6OAB79sDYZn1u2HDza5ngAG
         AFzVkl2i0qGx8FHYmpPsokN6DBPqJgWP419WQ24tzrbr9P/EHN8B5HHQXcC92E7snD
         a1ylV6wbJpdhVWxI2E93fVlpAi56G83YUypaPGj2nyiRNbwGsUr/nyv+yXzSDYMmBd
         yawK7FgU0BsWWiulvA43eVpGCDVLHmp9b/d/drT3VeR9wqktJHFKNV43gKR+Pc3lWq
         N9C9xsH22XBZvbsAqZ1js9uzkb51MRYonEyKx5/YuNlSNd3QxNewv6jturjMPzhAmu
         vybOForiZ4SHw==
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
Subject: [PATCH 1/5] dt-bindings: vendor-prefixes: Add GPLUS
Message-ID: <20221119202618.93451-1-linmengbo0689@protonmail.com>
In-Reply-To: <20221119202316.93142-1-linmengbo0689@protonmail.com>
References: <20221119202316.93142-1-linmengbo0689@protonmail.com>
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

Add vendor prefix for GPLUS.
https://www.gplus.com.tw

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docum=
entation/devicetree/bindings/vendor-prefixes.yaml
index 10c178d97b02..e3f5bb5bb3f4 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -510,6 +510,8 @@ patternProperties:
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


