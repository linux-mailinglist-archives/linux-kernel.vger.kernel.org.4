Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F098F619CFE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiKDQT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiKDQTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:19:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F129F2AC7B;
        Fri,  4 Nov 2022 09:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667578743; bh=Pw4CakiY0E1l+i7XqKoO2ReaXNSJlyEur6HQ6/k4BHs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QctwYSynsohZyjY1O+iFjG/VhtoyEF2KswIA8ztlXiaJJVToNlAdm98TXLeemI1v3
         n24p0xasgRuE22cEs1q5OYAtYNb2zmSQXT8q1zfRNCJaPhT9oEeecI21ELoMigKbFV
         FVkHlq5aMk/AtZ57fDWIjqwSkr9Uvo4aU8nT/7VM/Q8G8BJThH6tspmXV6TYeCIvWt
         CFWCT0iCvITgZTD6tDIKpFNpeuRmr8/oqi2peNIVrTu84awV6wmLGRGZC9lJTdDi1H
         qYk0OWza4Axjx28ChmMpMHK4sZpDQoNlLKrzDJtw9wweG1EKwBUXXKCZHzNzPf7e55
         14sSVtAVyCWQw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mr9Bu-1pLKGe41mo-00oCsy; Fri, 04
 Nov 2022 17:19:03 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v5 1/6] dt-bindings: timer: nuvoton,npcm7xx-timer: Allow specifying all clocks
Date:   Fri,  4 Nov 2022 17:18:45 +0100
Message-Id: <20221104161850.2889894-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221104161850.2889894-1-j.neuschaefer@gmx.net>
References: <20221104161850.2889894-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u1a9x+P0LGwj/elnlSQC4Rx5lPLQ1qTTs5cfZngE+CoU5yTyC87
 7y2UAeUNkYVbkXUH3J5qmFUhmm/US72SI74GTLRukaxtFj619WmIARkln8jqocyFcmOefg0
 veZ1EcslZPz4kOWtZCF5IiFFD2YiVSCNEZBnynlWavbkCnuxxNLA2oUeL1xiOixqcrMIvRO
 9kvRgOBKnMDxzk9jCkzgg==
UI-OutboundReport: notjunk:1;M01:P0:HXBfJJuJpek=;Vm/3v2yoTR9tvTyf0zQzVJ6mr7g
 j9qBisOmMdmJ78+KVTgWkso50NZ7euWq87LZyndvDulxwFk8ZKvXhJK94tk+8LqmqEgyUyEPF
 dwFZEWVwytLaO5nSmqhfU3ZC/Pzi0SymaNvxe6ONpHTja+stmYFFMALAK0wrri3OpDP2KQz4i
 IeWln6TbekfMqjSbYVFwqz0HHP8eB2vtzF6PT3/lF3oQt+6chmQIJ6rMFfgXigvnwbr0i3U4P
 2axe9fzKRkQJbApO2qEK/6g52Qwwy2E4WLEahIH+PKJ007QqRcCKet76uKWnry7R88WodjYY5
 CGG2sDyrbw2q93Yzik+kHnt29/come56auSrCeNstBieHsSA1ts2tOlfT4UCD8AJebwVfg1/d
 UI2NdxW6GvDP/L3zwt/8/UYqearH5tB8Q/s53T7IpRQRbPhJqtWm3c6+ZQ+MEjuCY2vv0KM+x
 VdtSOpoM9rssXV9WRwDCAM1B5uQ+qyXWcKWQeTefTs7IKYvyOeqTvNO9sIXxkkuJpOr4gHXB2
 ExWZFCdkFo9EidrS3oxopvH5DUI/+XFxJ0z8PQmDutv6lQei0WE6DybaCtZaYBRo+T/IlAnKB
 e5N73REVdWFrUx1+g9x1ItP9WET53VWnDMtzD78ogdZc4iUYmiJ18p7/mg4fpcUHWTTMnmJcA
 3U2K3zcv20AqjZQlP3qyMlWOaMFcMk48cXxozTP7YvAnuimjIed2s3bQVU3Zlz3Y2dXwL+Y6u
 cvva90QXYRiN0bex+7rC32WbNeguxbMNt7llLrll+7ZDKmywLX+XNKHtk+/8IfsHyP9PdotL3
 VpgzVuE2h9V/RHtog6XxG+sRRdsZuySV9C1+tImGmhqtUaHnroFk2Wkj4Hai+cePV5YCCgy5i
 pO31LZWpQ7CIGF7lchSyZs3AyN/3XvyeYvAX4c5N8LE4na/4k3+80MIiA6cPR8UPQorBXyUzp
 jDzRqMex2oUPwWxigspAiI7cKvE=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timer module contains multiple timers. In the WPCM450 SoC, each timer
runs off a clock can be gated individually. To model this correctly, the
timer node in the devicetree needs to take multiple clock inputs.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Rob Herring <robh@kernel.org>
=2D--

v4-5:
- no changes

v3:
- Add R-b tag

v2:
- no changes
=2D--
 .../devicetree/bindings/timer/nuvoton,npcm7xx-timer.yaml  | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer=
.yaml b/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.yaml
index 737af78ad70c3..d53e1bb98b8a6 100644
=2D-- a/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.yaml
@@ -25,7 +25,13 @@ properties:
       - description: The timer interrupt of timer 0

   clocks:
-    maxItems: 1
+    items:
+      - description: The reference clock for timer 0
+      - description: The reference clock for timer 1
+      - description: The reference clock for timer 2
+      - description: The reference clock for timer 3
+      - description: The reference clock for timer 4
+    minItems: 1

 required:
   - compatible
=2D-
2.35.1

