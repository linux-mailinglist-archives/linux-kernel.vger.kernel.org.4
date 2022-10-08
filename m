Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6AD5F8571
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 15:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJHNTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 09:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiJHNT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 09:19:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D0A39111;
        Sat,  8 Oct 2022 06:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665235160;
        bh=jEHvMUCQRRCEO/jqzijoupUp1nOWB4b8v070TsC6ZPA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=gQfmBHOjuwRuPVS1JFywMk0QnjMZO3vt11lnuv5WmBT9qj1RiV3pwVnH2So3oUV1W
         9VF0+bRJYUDSuRd9dRCAuD3XY7rW9UgxBYAfNY1lvim6qoiIvNJCWhQVMlWFRIaViH
         N/ril2VIx4qAXd35esx5JpqoilFgK6ZIpwGrETd4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from probook ([78.35.76.13]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLQxX-1oPlZj13gJ-00IXTf; Sat, 08
 Oct 2022 15:19:20 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-leds@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: leds: Fix reference to definition of default-state
Date:   Sat,  8 Oct 2022 15:19:18 +0200
Message-Id: <20221008131918.1235397-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s2OreZEqHqiOMvR52Gp7PzIpv94IgqKuzVJIQfqB7hGdo4QhmfF
 q4BG6kY7T+lM6e1DDnGKRCyKuoRTyeu2JaBYmyKyV+S4NVHnt05kv0mgAkG8NJago+RbYaT
 gqGO8T4fG1Y4Q5CVCqPEP+g8jrqsE7INY1jkC7duiWO/u3msg97+B1gsbefK3XP69bEvFIs
 AGkyH87a4Z1oIG6KR9LLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7En4xnBQYcI=:G3XZOiCsbUGEZAtafFJTn+
 omyHygZ/s3E7pUrSGF4In6zkuWplArjZsssi75hsYdDL8nbqRxm1FA0X7UcLkf6hrXxKIvcNI
 goCs8VBhsdlJr6WSsf5LSEgW3Iv8jMc3YSKMwNSydE8OdeVOG1LS4QCQxu8JE/PlQecYakxGu
 KldDRTMwuLggnyy6+XeX2c3wrg7pnwljJaUIS+oabo32Xq5p4EItjPnauDx7EgLXDporLQ3LF
 OZ9WoahdxrHgl3gjupBxyvBcFxJhiRRxaKJktaOPucoC+XLIlUDV7CA3XwFSI1OXRhd5T0iPi
 PF1FsObDIczm4Gq42WCPaIr4GjD5xztMW/RNSzHUvUW1W5bccxMzdUZPPHQfnkqRQ9uNJsNw7
 O1A/DeD9UdLCWYjjHV3X7VaUeapbGXZcYDV9HNGijcUJWiEKCDoiASGBY72n6/Loj6mNTLHsF
 jT7mjGvePQ++AWzm31+7+6H82FIR5fTMTgUvPruaanc7zs0fimqtcejlHdDzcnfvC8Kd5JPsS
 JlfuuW5i6MdNi8RHNkMcqZzGBuL58pWjQwiAWBbrHzf4Ivg/aAP7kF8+lSHGAwEYXzBwQpBNq
 d3zhl/dTuxdb7Hr9nfp9ff71d23/fkDT/rHnEROlZUjq8uG7DrfA+VFobqBBqq+Rwk4Uxlg2R
 UDPnaOWdlW4TzEgZxTVfq+XbCVBj0tiOdwxOzrMOYWz2f6PNtPX+dm+BbROLBGf44dRvHCsGk
 lFpfk9ycjOFBoHBnNDgJkiQP+caZ1nqO5kECr3kaAgeZHSjTyI3g4Iex2U0d8RIeGwYlJ9Ea/
 aF3E1GvYKiZwij93qs+hM3mp+JPgn2z6kh+OR70oE12y4RHmwPuosAJ2N2nLscm9vDPKU2Fo4
 4bk9fs6kuOStyhGCcMo4ScLISQuEGnLt4tYNjzS6H199LS3V1uZvvVAb1Xf1oQRD83kjSGRQC
 1+/THjj+BzHD6T6GkERHbitmCD42PEXbXyqQygSF9pLrbiR02Mm688MzlnaBqMCDba33sP1VP
 jGC42kH4jV1MBbQsDnII9C1zphtS3QiMrehXVGEqKD1U2hd9W8Pi9nCyA/7Vi3s9cTbRurkFe
 7ZWJdv0KpulBqAPMEuMesCNZM/YLxuFWzf6GxnmmAiE9da6etjkieoIyIpNh99/HXmAtv74cd
 UhF7ek7MNni4kQ6uIGJ0UW+Ks1710n9TOJBd4ce+5+N3HNf6CldhHM0Ogz8iNAZmRbwoc+mhn
 EHPuXJ/jDP8EyfHcu2degpEW/bKm7/bXbHgv7kZp/8y1d6nRBe+W/aKelP3QsjVYF2C/zzTqK
 ORFlS/6lsd76xkkE2QgeX2+NcOGI11wNtoFmlKnG2K6fs/STxXV0jr6bKsKVXE7MDTRXwSvjo
 4iC1LX9cwjSqbKwst6fNVpkMStbITlCsKn9ZHjv7jDFDJrtufz2Yc0LL51KSglr5XhBb9A/O3
 q0Ly+m/edzvP5zUj+UvYHtVd8VJ/+Pwzb8OzLChny2/Ti7m5TpBbJwwl/rA750dRhXLR9Wuwr
 E59x89HwtqaR1kh8CCYpfWwJGxbZkPVd0gpEuA2y6i+0I
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least since the YAML conversion, the default-state property is
described in leds/common.yaml, so there's no need to point to another
file for its definition.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Acked-by: Rob Herring <robh@kernel.org>
=2D--

v2:
- Add Rob's ACK
- Rebase on Marek Vasut's patch in -next
=2D--
 Documentation/devicetree/bindings/leds/common.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Document=
ation/devicetree/bindings/leds/common.yaml
index 3c14a98430e19..75a9497a5ba1d 100644
=2D-- a/Documentation/devicetree/bindings/leds/common.yaml
+++ b/Documentation/devicetree/bindings/leds/common.yaml
@@ -83,8 +83,7 @@ properties:
       - enum:
             # LED will act as a back-light, controlled by the framebuffer=
 system
           - backlight
-            # LED will turn on (but for leds-gpio see "default-state" pro=
perty in
-            # Documentation/devicetree/bindings/leds/leds-gpio.yaml)
+            # LED will turn on (see also "default-state" property)
           - default-on
             # LED "double" flashes at a load average based rate
           - heartbeat
=2D-
2.35.1

