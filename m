Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0929B6C1495
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjCTOWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjCTOWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:22:41 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3232203D;
        Mon, 20 Mar 2023 07:22:38 -0700 (PDT)
Date:   Mon, 20 Mar 2023 14:22:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1679322154; x=1679581354;
        bh=PyBkroZpp5Idh5EiLvqP12MWQHI/I6jk1Thl/HtlRy0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=q2mL4lvgqq6/UT0kzVkGmepQtIBR6RAoGnxho6bvKGLlC4mnjndRTyRybHHjkrQG9
         o3/KldHRayXXuqnvLQWQNJEuS0hX722OevRqQksAJ7Dj/Tmv+UBcmjjJGSsvjb+e3B
         BSxTABGUPWgHtLcgChRVgth7FvhxLgwf2ncmf7YSw8UzuXN9Jvh1WSJwKjF7yeST21
         kEp1TTmxo/zZXvjexnHrXq1SHs9pnpKn5CohBY9Kv6UrGQ3FPDWfhux0OCQlaCh++l
         QhR+Jgad6PLbRbBq0pY6wyQ4myRQT7qygFd3qNEo2fOvu8OHbgecHZpMEyw8N1gBW5
         hpXXhAuZahOpw==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Travkin <nikita@trvn.ru>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 1/2] dt-bindings: leds: aw2013: Document vdd-supply
Message-ID: <20230320142103.3440-1-linmengbo0689@protonmail.com>
In-Reply-To: <20230320141638.3378-1-linmengbo0689@protonmail.com>
References: <20230320141638.3378-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document vdd-supply, a regulator providing power to the "VDD" pin.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 Documentation/devicetree/bindings/leds/leds-aw2013.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-aw2013.yaml b/Docu=
mentation/devicetree/bindings/leds/leds-aw2013.yaml
index 08f3e1cfc1b1..51a58f4b8ed6 100644
--- a/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
@@ -23,6 +23,9 @@ properties:
   vcc-supply:
     description: Regulator providing power to the "VCC" pin.
=20
+  vdd-supply:
+    description: Regulator providing power to the "VDD" pin.
+
   "#address-cells":
     const: 1
=20
--=20
2.30.2


