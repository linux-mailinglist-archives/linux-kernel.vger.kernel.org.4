Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9314D67FEF0
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 13:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbjA2MhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 07:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjA2MhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 07:37:23 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C2222017;
        Sun, 29 Jan 2023 04:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1674995834; bh=QRPsmyE9hY4+eTuGgSF7yy6Em/Ww1XWsbL3ob97mB58=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=EbGyLSd1N77q6W1eb+b/y8xQPeuTipZbvzP2VjHYJGv3CC/b9eEECECDI3y/vib/y
         B6ztV3BAR3+x0mRuyVDPKTCML0YC5MUkReVvimq+yEbYx5gCz5FKvBg4x9A1mDHgr4
         ucAMee2p7IMuhTsTtumqT47D8vTdRf92W5rc28JedF+ymc+wUsUczQ9GYWIc9Rt8wG
         N8CP1h97G0QsHWWZayFaJfXpR/dwRsONzuH3q9DawvY78ufgQgOt6XyBdRVYXBPnda
         cdlwGxhnzxPy11hhiTGj79qcCbptRgzhcmzaxoEHJLi4I4G4JXLu5aYhxqwm1zN5bo
         MCc3zKBGFNmXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlXA-1ouAlI2CIg-00jqxS; Sun, 29
 Jan 2023 13:37:14 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     devicetree@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: bus: moxtet: Fix reference to SPI peripheral DT properties
Date:   Sun, 29 Jan 2023 13:35:53 +0100
Message-Id: <20230129123553.1284503-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b/AImXyzfz4phEg81jcR9HxbORyzvoYrvw6O1tPrYE1fM4VYvt3
 ZvdXP1tEbXAa+c0ybjhpwdEr79xvHUrJNhp6bRPnrEC8QiPF6YTOsQc+lZD4pRYRIMiXC1y
 stVg7dyvpbQY7+r4JrORz8yPWxbyKgmfLSWjs0f42lWwAaBOoVxUxzg8LxRwnmrn4cVQN6W
 0CT6EUstm4CyawMPUE1pg==
UI-OutboundReport: notjunk:1;M01:P0:AMGUonl3rdA=;+R99m5j6S+PzYh/yIJ7Spq3tMqN
 6i9EKEnP5026bhc7V2PoeqYWWYjP+cnSPPkWMAPd13DzJCoyQZ2lqgepxn8ctdwDDi308w+rX
 Mt0BhoaA23OBv8f9zFH9AfareIVQEy/az1n7w+dVmMGxsdJ9t6AORD/fOTTwPjdb2nP+VfUNw
 f/0f+c4x8U0/2ht+wYQX3NpHeabxZodgC62fsc1oLRrdlrPIdmAYrSgQ/Ja2qJmOMpuQvjCQ0
 2gXhrPYRXPW2wFjwuWZvGcYZsUCkV5NCHGg0v6cgE15MlNRQAHYyrLSmZEQsyDSaIHiL4og/p
 kCvhz8ZB914+/No7ljVQeK7bZVQuKCe188XvWwJdvReGtKluvVxkxQj7tCc52P/A8kS5kGNJu
 dCJOPFQZA7lPYo8jUDIJOpu/+zSj1/PnSTutV5ublO6+iQ5EfsxMpbQDIE6246OhAPOY9L+VK
 cNWOWpkgkQ7d3WiVb6aiqIhBvfkm3zyZIh8377jrDYoULmNP0/g6vZZMxdaxEgKjqtTeP/UG5
 mVeGhxNf/wKcG12X3tUOf5Uag5WTix9zeRYlG3GpfzLW6ae7ivIdH4KYCKNN/0/D/Ms/j8oEt
 BJJ9Yj1N2JN9lX13MleoFNKXviFzVhgZX3mjf7Bsp1ybBL4eg5jib2jbObv86JHCTWwcL5t8y
 sdoOVeiycDbk8jsEYIzxZvr084evwV8AOqLYbrfH/x2F6hzoV7FbPtit53ni+fFEYJCYjOPhZ
 V2D1rtKpPLBLYp4HUoYJHN0GF6QMsg6QmbqQq4QINA9E3/7D8qGyEG0KbF5AvoiiPZdRKi1KQ
 MfRDv3jRJZoE2HJmFkVexCMuPWy1FHWEbBoYZP7lj9+d7eNx0yx7QeU7MrLnxCiOb+1B2hChH
 SzLciZUokIB5p6CJkCKlW7LrlK7xUR40z26OzQXjSTYKZVFB0Rmr8lnjlyC/UWQwJbjCNBEM2
 xV4kg3s/N5Zw4+3Y4RBxLlIOQAk=
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spi-bus.txt has been converted to YAML and the peripheral properties
have been moved to spi-controller.yaml.

Fixes: 0a1b929356830 ("spi: Add YAML schemas for the generic SPI options")
Fixes: 8762b07c95c18 ("spi: dt-bindings: add schema listing peripheral-spe=
cific properties")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/devicetree/bindings/bus/moxtet.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/bus/moxtet.txt b/Documentat=
ion/devicetree/bindings/bus/moxtet.txt
index fb50fc8653368..d6bf929c00c4e 100644
=2D-- a/Documentation/devicetree/bindings/bus/moxtet.txt
+++ b/Documentation/devicetree/bindings/bus/moxtet.txt
@@ -11,7 +11,7 @@ Required properties:
  - #interrupt-cells	: Has to be 1

 For other required and optional properties of SPI slave nodes please refe=
r to
-../spi/spi-bus.txt.
+../spi/spi-peripheral-props.yaml.

 Required properties of subnodes:
  - reg			: Should be position on the Moxtet bus (how many Moxtet
=2D-
2.39.0

