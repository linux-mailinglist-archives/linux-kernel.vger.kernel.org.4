Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AED06DFE34
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjDLS7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjDLS7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:59:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24AE40F9;
        Wed, 12 Apr 2023 11:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1681325925; i=j.neuschaefer@gmx.net;
        bh=arIfURks3B5Vf0o5lhr2f1M0B+uljezROcQ5CKR6D/E=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=eWiyNxmoZOwn4VwHHTvzv4fpyPOqxFCOIcHOYZvrFaeq1IgeGafY+jvDDR0meDtmj
         8Zv+0oaRuFibuDC11bFwo8x5/Sf3HJ02wpA/svSnjaE7CWZHsiym96z5xGpwgctTab
         HEGqShUa3I/P/a7SlK1cPSrb0RVJoeHMlznjXPpI0Bi8UKsQaE08UN6MeyCW84vtie
         hmrjH2RrD2Ql7b29gb9tTs9KvxRy9BBX05fY6pDGbsCi9xFMKsklq4oQS0CeA7qtPP
         U8WkrszAi2x0d62SIh8HupyCdCF3qsXGJp8qL8xs6DiIr8jy2gj4qNW5muwY1YgwR4
         UgXsdC9hxt3qg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([185.66.193.41]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5fMY-1pjtSp1GKA-007AXT; Wed, 12
 Apr 2023 20:58:45 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     devicetree@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: leds: Fix reference to definition of default-state
Date:   Wed, 12 Apr 2023 20:58:31 +0200
Message-Id: <20230412185831.3788056-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wM6RI3iIKG+IrVeFv3Ib4KMo0RqAbtrXYms789K8O8DPkDGwkUa
 tIspzwJ2UF1UmTzqzHiTD5ROVW8PmZml6UR4uBliT2bkFukQlynH2+XvadcK6hFzi74loO1
 GRYqxJc9HCKcM1j+0U6hbmRoLmioTFP9UD9wZXA62RTKz2VtE3Np8O9Be4xAg3lzwcf2UQf
 sB5JQZ0RHdMKKVJdenx6Q==
UI-OutboundReport: notjunk:1;M01:P0:ODxp1wdoa4Y=;WAS43g9EzKnP9KcfgqGL4hLnuz7
 PqRCXyNktVwpi1w18L5VPf2astLGQHzolRNZG72Dc9c5mY3nD6/O7IhjDb6qyd9Qp5TeoFpE4
 taoZlT5B55VuVdzmwf1CtfjhS3qSBSfpmLikpmU8UoR+mx4JbF1/2sPAkxVeevubpzvVHBKjI
 Vie1DCTAAzGIToekyfBx5ri20ZbjDi86kMqLcva5J1I0UXmFr5ByRfJ0mSOntxf6Fz+f7jx2r
 r+pF+gWdfAGUHO2xCQxjEhanLDm/C/advY2ar94iHD0maSw1rVGSfyBB1uuijsY8L39UH7mL1
 xV86pxx6oo/K+RU4Hk6x/Ez67XWJj4yTP2nZWKf+ihF4s/8GMOEwd1pGcbsQlw6Oh3W8DjMkb
 qIk6HGdFONDJR3KD/E9xf/ZiwNhA4e7UXKUwTZjImk/mmsByRbfr5YBkWqgTnXkqlTm2Y2CHl
 ibrTVO03wOuesPbPNqNVQCrh4Wq8Fvu9NzDf4AZc5qmUq/w5H8uX03/MQmgrzNqJK0+jznd6L
 IVDgs45HQsBFAVfAe3Nxqft+/+Z3M4iAae5geJsUFSNOf7e0kJ+gjtCGfFBmJzFg6csW6TLFX
 u35/E7CcWsv35hGTYTnFDGeNYaxPoIrBb8usJzWPFbOCyU7lVYvbhJSxXkzX8hBTfIy/jfNRU
 IbuYHfVMo/e8PYcjA3hmiI6DlZwNlXZPvZ3eMnoEcRGgGXZiakYoSLoCtAh+vYBFA5y6VcCxb
 oEFrpOGKFHP3c0emLd8wiivljJWhjRIeVNfJvTNYt8Ng+LWouJaF1K1FBhnRrcOqjGnUx/kEi
 aH4xl4g6QN4w2nxNz37ubxB2DG0Gfb/mJfylADgF2vpIz5o6ucO+03tyPBwaCTQAAjRfEuQ1K
 gAjVYxE/AYvDBj4o004zqR7H0iTbQ2jr4L1RYgVqZNTP5WXFc3XhNVS4oB7Tikl34J+2O6qso
 OZU+rA==
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

v3:
- Rebase on v6.3-rc6

v2:
- https://lore.kernel.org/lkml/20221008131918.1235397-1-j.neuschaefer@gmx.=
net/
- Add Rob's ACK
- Rebase on Marek Vasut's patch in -next
=2D--
 Documentation/devicetree/bindings/leds/common.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Document=
ation/devicetree/bindings/leds/common.yaml
index 15e3f6645682e..c9b0dde44986c 100644
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
2.39.2

