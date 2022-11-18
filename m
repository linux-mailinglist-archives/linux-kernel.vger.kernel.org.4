Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5C562FC77
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242636AbiKRSVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242606AbiKRSVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:21:40 -0500
Received: from mail-40141.protonmail.ch (mail-40141.protonmail.ch [185.70.40.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFED92083
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 10:21:35 -0800 (PST)
Date:   Fri, 18 Nov 2022 18:21:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1668795693; x=1669054893;
        bh=nKZq4tmaBqgKx9awfbe4f1Daih6aVe8UbZ5zGA/hMz4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Pce44jgmteToADvrAXVbI07aA92l9gdqKYlzFvdEj9sSN9SPpMwSWqXEIl1DbR1Mj
         joc5vwOkadInRqwWSep31MasbvcVEETJMpEIUam/qcaBh5JBDdabekDAJERXUDDbXB
         8fctyIQ+uSjdUdXmIXAG1P9o8bMaZvwrXlklQ7rDBd9afiZuTRtBW1C5NX01KoGLlr
         Q5QIKWl9dbtYmPJltKpsjGHt5zY6ytevGYR1w6bQB8AvH1DHUl0TfO7wSKOVBcmmOr
         CVuMveIwjg7KkCxm+NpefO+B+IVMmwRELMq/FdaHqG0pBBlExChAUCsf+E07g13DOE
         8G6PlIbwiqHDg==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v2 1/3] dt-bindings: input/touchscreen: Add compatible for IST3038
Message-ID: <20221118182103.3405-2-linmengbo0689@protonmail.com>
In-Reply-To: <20221118182103.3405-1-linmengbo0689@protonmail.com>
References: <20221118182103.3405-1-linmengbo0689@protonmail.com>
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

From: Markuss Broks <markuss.broks@gmail.com>

Imagis IST3038 is a variant (firmware?) of Imagis IST3038 IC,
add the compatible for it to the IST3038C bindings.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
[Change from IST3038B to IST3038]
Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist=
3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist=
3038c.yaml
index e3a2b871e50c..a58c045d2ba1 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.y=
aml
+++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.y=
aml
@@ -18,6 +18,7 @@ properties:
=20
   compatible:
     enum:
+      - imagis,ist3038
       - imagis,ist3038c
=20
   reg:
--=20
2.30.2


