Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB076DAEE1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 16:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239568AbjDGOgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 10:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjDGOgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 10:36:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A29D6EAB;
        Fri,  7 Apr 2023 07:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1680878185; i=hfdevel@gmx.net;
        bh=XJ0Yc4cr0JnDef9Jw24TvKlWj64iwV/S922I5QT4uoY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=rs8NppMMZWYrmjQSdvRBwBZj5M4YGBcXXaAnwFHdSulaEqq4LsEVPx0phkBBoKjqY
         105Vak7bST17BsoywdH3G3UEGfjRckP3kLCFlQhyqAGqk1Ez937C5JNk6NWRFndiUE
         pfYl5EZRLCUl6GvSnh1TFIznr4upDQZa6hfCvm+KA3BMHFwhirUeNou9x1tr7p7VW1
         R86BkYbASp1+NpbV+lLuL+4v5XA6eX3FWq2hXioYUJObJsf9qtGkC0iJt3usOOIRuD
         TZRgSMWq+jWc7OCWOXgS/cIClG7HUcRlvqjMtATOJsRLfNfZSkbUzxvFs2sL+YqmvI
         xpZbx50ybThPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [77.33.175.73] ([77.33.175.73]) by web-mail.gmx.net
 (3c-app-gmx-bap55.server.lan [172.19.172.125]) (via HTTP); Fri, 7 Apr 2023
 16:36:25 +0200
MIME-Version: 1.0
Message-ID: <trinity-bf20bcb9-790b-4ab9-99e3-0831ef8257f4-1680878185420@3c-app-gmx-bap55>
From:   hfdevel@gmx.net
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: meson8b: correct uart_B and uart_C clock
 references
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 7 Apr 2023 16:36:25 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:zyvGPj6hqLDunDW98Qsb8UOVKhijpOy22cS5iLkrBlCZFle/h5hyf7T6xFmm6uJ+/CHQc
 hIV2yxHj1PQKJ4enNouXhSLdBH/x2M1jy4srq+POvRP6HhzUiPLxQ8h0JMqQ3Kf9QgGqhEKWNoJP
 eJfe8idCDGeTM2e3zk2SrhjvFIvGvTkfpceWy/xEUJuahkM5h2OEkXIbwVJYtkxGZbTQ0iBqj1s/
 WPcYq933K3VfXckkK5Tv77Z1KKYnXEcDl804ismx78ue9yLX+o0e5syy8ZIUGx3ezlU1lhy5BB3X
 oY=
UI-OutboundReport: notjunk:1;M01:P0:25iDbh0m2mo=;pmEOWd/uz3CFqVgh6DJH4C0YOB5
 9OFw2C85CfDcB9beW7ALHLVfH/9PJN12EaDSIATpIJhjxMPVDF43khA2FJX6GXCe7IaH687EX
 o3YCOOtOkwPydfP27Sm6TTsTf+XL6v4yGNWyeNfRE3QiKepBEq4SyLQBIZEJfDDwjDC90q8Jb
 fJtnDn1zQW/R6LQDxxmrMooIyV3XNgwlYMt/rECnwLRz8cQ2slcvSPl3fmUGS7bMiWxNwCGvS
 RObhE1hDOC0NJGMd6gY2pU+TqfSksH9tgtzUQZ+SfqPvhnCsgdwc1ka7fFwWp/hBhXXIhV93l
 IZWaVyG+CPIeF5QWZvs/TbRRsC8AGzz42BzFobtU0G60mA7UZ/miPE7ltuImqzOW+uUB6xAI/
 f2dqEdMkjAw7y4y5aw1hWnvVmoXBu9lWLPxufzqpuhKXTEhOIb2CBG7Qx7TSTQbSLOUGR6baa
 iQa4qGg5eXiE6hJ8jOgCx1a6bHW8M7Vo49QJd4b2htsPsMRsWwlfNJDVLHm5qc0VVg3n2niPE
 nzhaXw8hCEiKvQgNcA50t2pYuYXtjmv8vsAxA9YCAk1Wmp7Ks/vfGBKPldEltye4SkNVyjIsS
 iDh0gckJJfy5BByKZB09SfI+OqGglmWwNLuTbyJ8hQgXl1/lJEMHhyYxUW6ahAH0CeHjikFkw
 NHbps0jh6Q4M0gsWTZyTA2RNX3jjthZbQNla5ORlLnxFAZuWaiQKDOFhZNpqPiWRxWImvCXyz
 AqWyvvZtnHyhvk31qg+2bguEtNUAE0Ta4ptTgMPOX9eA8k6Wr9EdAVqKN1ssLcLUkRPRw/sGm
 0QXV4vfm4MwgunnXurKsbb9Q==
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

With the current device tree for meson8b, uarts B (e.g. available on pins
8/10 on Odroid-C1) and C (pins 3/5 on Odroid-C1) do not work, because they
are relying on incorrect clocks. Change the references of pclk to the
correct CLKID, to allow use of the two uarts.

Fixes: 3375aa77135f ("ARM: dts: meson8b: Fix the UART device-tree schema v=
alidation")
Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
=2D--
v1->v2: Addressed review comments with respect to patch style.

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

