Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D0262E519
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 20:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240338AbiKQTPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 14:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240490AbiKQTPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 14:15:11 -0500
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EFD85176;
        Thu, 17 Nov 2022 11:15:11 -0800 (PST)
Date:   Thu, 17 Nov 2022 19:15:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1668712509; x=1668971709;
        bh=j/4kwDCI6yUOY0rbKjZzBAtwpPVlmEC4din4OfwGdS4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=CJDc7oygEkDlrA6vQ80GDRkx64s9ExmX1IZv8s+RnCEmjjShUFqdmdTdDa7+jbIDu
         /s/i3QGL1W6J2Xn4nhiFfoaUtc9wxQeDK4n8AaNq81VdwXOWpMS+LodnwK44B3AxYh
         JrqpQFvBSJUkeaH15guRUYomvuCJN6eJK2b+xyiCWN/2MWxhCG87QAbw4Udi8pBXP8
         YZE3QzyEOxCdGTsVWu9aSgQBLDwKoTwkFvM4qNenfj2A7MV2dZU9P8lf1iBfCf2SUK
         Nu70d1yIx1W44SLQ3rZ1LQB0BEmNbAKt9giilwBQC+buWnTtNz1o1J1sIkYEUNDBSm
         rUmU7IHwGxp3Q==
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
Subject: [RESNED PATCH 1/3] dt-bindings: input/touchscreen: Add compatible for IST3038 and IST30XXB
Message-ID: <20221117191436.87938-2-linmengbo0689@protonmail.com>
In-Reply-To: <20221117191436.87938-1-linmengbo0689@protonmail.com>
References: <20221117191436.87938-1-linmengbo0689@protonmail.com>
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

From: Markuss Broks <markuss.broks@gmail.com>

Imagis IST3038 and IST30XXB are variants (firmware?) of Imagis IST3038 IC,
add the compatible for them to the IST3038C bindings.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
[Change from IST3038B to IST3038 and IST30XXB]
Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml  | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist=
3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist=
3038c.yaml
index e3a2b871e50c..85390f6ffe36 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.y=
aml
+++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.y=
aml
@@ -18,7 +18,9 @@ properties:
=20
   compatible:
     enum:
+      - imagis,ist3038
       - imagis,ist3038c
+      - imagis,ist30xxb
=20
   reg:
     maxItems: 1
--=20
2.30.2


