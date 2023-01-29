Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FC767FF05
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 13:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbjA2MnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 07:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbjA2MnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 07:43:10 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D034B126C1;
        Sun, 29 Jan 2023 04:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1674996183; bh=9fz4xL5G7vsXInxpDkUGRVGvDGpzYQnWOzaC+5JEBTs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=n6m/cqeG3XzHmL9G0YAqZAmlElFYKw1S1b78nQku4K4p4vmTYU2MBDip1Iinj+X55
         so6gxLqvS/eS7qDpcXnnORKv2C0MsVZ8sNkZoBwUtrWLb9iZrK2rIKxKk0ZbItRXGP
         4Y5udD/XgHuKlZAvUdwN9w1Dlrt5DWdzmZEEMVBVX9rz4CncdrytXGGeK5WKbLMPVM
         qIewoFGJUhhKDhDuYEgAYFNn9KF2f6ENn3yvKNq/G0Z8aFf/4MKwOKYlH1t/znXAq2
         mc0G1wLTzdhoheDgYlVVwMwtbFrnMsG0da/uCKWq1nZpFRJSwBqin6+2hEX4VUSvIl
         +5vBZT2DPb/dw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5GE1-1odKL40QEP-0117hr; Sun, 29
 Jan 2023 13:43:03 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     devicetree@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: usb: phy: nop: Fix a typo ("specifiy")
Date:   Sun, 29 Jan 2023 13:42:58 +0100
Message-Id: <20230129124258.1295503-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zHsQwgpM2Z+0Eg0oMK+ANH/cRXMlp6tk0QIf/ZQVQzuwJTQa3A7
 1lGx91ypYIDskOgxiE+gCxZ76fcm1xcB6BxDUFvqRGM3pGZMpxB/sZLwJ8+eyp6r2dZ32kC
 gKQLS51jLmEHQVC07K0veAF2KYB5Y3rGyM7KOD6zFCNkuWo8wH66MVyXpFT9N6ZbtiD5KvI
 hagCaGjxoSCaxuJX3VDlQ==
UI-OutboundReport: notjunk:1;M01:P0:bQnWwKzea9A=;4GqUWPFs7Rxokjhxrb3SuQFz7P3
 P+Lgdd9ASs2gV09av6uOlx8hqjcSDO7JrFqhwtY6ElyEuB8ao7LBvHcxDppwDQ8kTKDpfMoFz
 YzJNkUjeb9I2B15Q+Q8Rde0+JzT0rLvAa1q+6dRrBHTYXWrri3jhGLjcX6+Pa8RHW2i+pV0r0
 ebMKY4aB1zRiIKCQ5/E+IpfatLKtoBXlaBR+4N6ZLSrOXLt7YfWm68drQU7WDk2ZwOfAe4zqP
 +l4yLq0f28QegryhT86SGzzxXClQyRR7TZ+NVQvFIniqxCKxAjGWou1iQpY6rfjez3p90Y/Dr
 sTXxIwxBzbEXOCmkSnl/5BDRNAOWvONFKyzW+TZ1dzo0MuvkOzMg6k4tyQ/Yk9RO/IPioyL1+
 qQtCkoNbS/G+vRSepSExMkwiKc6YgPPkUOp5EB9f0Ay5wOVoIsx/VutQPFWKlpz1Vjl4QyA20
 mN8kL6gaE/2eGo1mJtqv9FILfHdXTANOQk8mhia+omCWJonfcxWLczGMspAhM0PULp76WKoUu
 rSTlNlijkabj2pbS7SMhjxELri3oswXakaLKOzZH8GiDzGOoGqAU2siAIcD8YV89aTLereDhq
 yO0X26QW74q/Jr0f7+FHctRDmnEdIbcmDGhoR9L6RDHAIyQYLEPJqWpI+K1CF6TICoWkj01Oc
 LQpmAIc5OIf0Dvo9t/O2hc49PUKK2EvpBlw0+ygWaJy2jqOawr2GpIChK4Ey9ChWIVwMKJaWB
 GI7iRYvhCRwK66gTgQ48+GNvZn6seL9dmFTGIebPMQb5FiYxhFJZIKvl2yVt944/edu1HRGZA
 Or7et6KHDFJdYGMczXGzRe70qgBFk9nnv1BNwYees0ku6VhMcO4E1A+SJL35pqAoK58QMRtuO
 cmH7nXPzGRCz9Y3WNLCFRoTm/0MM6Nq8MmJigsHFlKq48vBO/nnZXQC0uacse6DiNsHD7mAHE
 6ouhUw==
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spell it correctly as "specify".

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml b/Do=
cumentation/devicetree/bindings/usb/usb-nop-xceiv.yaml
index 326131dcf14d7..921b986adc477 100644
=2D-- a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml
+++ b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml
@@ -35,7 +35,7 @@ properties:
     maxItems: 1

   vbus-regulator:
-    description: Should specifiy the regulator supplying current drawn fr=
om
+    description: Should specify the regulator supplying current drawn fro=
m
       the VBus line.
     $ref: /schemas/types.yaml#/definitions/phandle

=2D-
2.39.0

