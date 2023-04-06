Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524DD6DA22E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbjDFUGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjDFUGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:06:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904CA6A44;
        Thu,  6 Apr 2023 13:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1680811577; i=hfdevel@gmx.net;
        bh=67pFJdfqDYYvQBqDd/g8dxqcjx/f2Mnl6F5+9ZBNfIs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=KMPl9gQxCIlie0kF4Jeod5kaBGlVS91Nl0uVxP1B1mTYl9SVhm7G9I94es6xxt55j
         tewi+7SmHpCpwvxEjtXiwwn3B0UUrs/vUo6gVGYGelz+vUyZ4Iaa9BbJuqs/fyLJg1
         uSyUIIfIyKbEHZPaiGqmLcO8y41acsHjtnprkGaXtn0NFXK1KwHP/2MSqOuX21k7+N
         dxg+I9veaO+dNFZo4VZ4MvVUYGNowTmjtZIogTe9Ew2ta81susf7JJiXN0zUq17rKA
         hZhHABEEJeicE4uiaialVtlpp3HqLhPEKkQjzgrHyjO0E+ZPe6cUTGp+xlVfasdrDW
         mmgJkhdkmdxuA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [77.33.175.73] ([77.33.175.73]) by web-mail.gmx.net
 (3c-app-gmx-bap69.server.lan [172.19.172.69]) (via HTTP); Thu, 6 Apr 2023
 22:06:17 +0200
MIME-Version: 1.0
Message-ID: <trinity-76c5c0b4-a6f7-4679-a1ef-74e745649355-1680811577008@3c-app-gmx-bap69>
From:   hfdevel@gmx.net
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] ARM: dts: meson8b: correct uart_B and uart_C clock
 references
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 6 Apr 2023 22:06:17 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:a51ftcmkLmRTtxhKSYJ3QixxCEl3MdhJIa+kXPujRNJiQoHHsMFRQ0pdZ4ArBUwRfqLUy
 BgQteuF7/dWbrOM4lOe/SmXQJ4s5ealx+JXyU4JsiuS+CSi8IkZX+znjKOpynNErfYFExunP7VDx
 PhAbTtyGDEQbXEM2qhPsgpLsYdZbfjjXQAlAalEMjeUBonbjR8m4bLg/s4DvafY/f/HBw1pomSH4
 MMi1qQmzNxdFK4XL/x7KgmTiSM2vLJQ8w9vvSKp4+IS3hPvK0IzoiDkrEJ3Zr/eB9sJemFR5XtvJ
 Q4=
UI-OutboundReport: notjunk:1;M01:P0:hezBSe3RdSw=;vFFS5p7owHpyUbL9jwv/mwW2NaV
 +IOJWekYhxHN7eAa5xWdjrn6zvRKrMci4vpjv5s19rSJ6hgV6uq4xwa703rMsRFFgjeiZQW26
 PmMX05NlkJDQV/WNIB8ZI9HHSGx1qn4WjpFWiIOcQdGE6u9jsp8lJ54PNeaYCLrHTmzReAtNY
 oR8tKz8gE2w1V1RrYnZYO9e2WiL3N/AuavKMu817sLKhXkrFZZ7a5eFNZ9FilVQ5EBmhOJKhz
 0tJJMF1hfp/nRBushqpprlWZKg9df+585Dj6/xg21kQ4bjx+qELnSgfFV0qlaK0U8z55CzZbl
 P6g0nLyD0iNXBvdV2I5DkUqshB18B7Atqo62vfQQkvthGj9XOIBCmo1qzUT8GgIU3ow/NOLDi
 TKfK0yskBkdB6KWG16LuYFbLGtRE7marYkx3GnQMtOW2I62pum1sOOc+Wg9mxhAclEY1Upb/e
 8xM4DL8UOuIHcF6cR6EKnXw6JJS1s9zXwtyJm2qfi691LIp486dtrF5BUmdQI/o9y84a4cocL
 7q6E53D15aBgQSpSQ0oP9TSQDjz3xAAWqoKSCj/ohB+WRp2BpFKiCWlm7ixDVCLSLxYxMBA3i
 4o0/hR+l7ff+ZMVMPDWZmlhXtMarFjax2l3Vkwwy7zy2KzLIGok6IVPTpk/0CqkbYACYMziQA
 G5yuW7teleXiAh0QY8IhpUg0+Vs6mO4etppIeGHAuTQ1E31dnWkIryByGHNdnHUNTb7yRKunu
 0iOH2OSXHaCuWvIYLRg4p4Ak8f50dlMMOZl5R1qFuJV3U3KVRC10LqrWo0merhw1943/pi+A+
 XuL0s8FrTsx754dSNvAkHiUg==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending this patch with proper subject line, corrected distribution and =
reference to what the patch fixes. Thanks, Neil and Martin, for your guida=
nce!

commit b3b6a88d2347d2ec9075603920e616836cb46750
Author: Hans-Frieder Vogt <hfdevel@gmx.net>
Date:   Thu Apr 6 10:21:49 2023 +0200

    [PATCH] correct uart_B and uart_C clock references for meson8b

with the current device tree for meson8b, uarts B (e.g. available on pins =
8/10 on Odroid-C1) and C (pins 3/5 on Odroid-C1) do not work, because they=
 are relying on incorrect clocks.
This trivial patch changes the references of pclk to the correct CLKID, wh=
ich allows to use the two uarts.

Fixes: 3375aa77135f ("ARM: dts: meson8b: Fix the UART device-tree schema v=
alidation")

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
=2D--
 meson8b.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dt=
si
index d5a3fe21e8e7..25f7c985f9ea 100644
=2D-- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -740,13 +740,13 @@ &uart_A {

 &uart_B {
 	compatible =3D "amlogic,meson8b-uart";
-	clocks =3D <&xtal>, <&clkc CLKID_UART0>, <&clkc CLKID_CLK81>;
+	clocks =3D <&xtal>, <&clkc CLKID_UART1>, <&clkc CLKID_CLK81>;
 	clock-names =3D "xtal", "pclk", "baud";
 };

 &uart_C {
 	compatible =3D "amlogic,meson8b-uart";
-	clocks =3D <&xtal>, <&clkc CLKID_UART0>, <&clkc CLKID_CLK81>;
+	clocks =3D <&xtal>, <&clkc CLKID_UART2>, <&clkc CLKID_CLK81>;
 	clock-names =3D "xtal", "pclk", "baud";
 };
