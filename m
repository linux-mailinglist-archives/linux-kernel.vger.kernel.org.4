Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D216D92C8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 11:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbjDFJdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 05:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbjDFJdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:33:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA822D43
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 02:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1680773596; i=hfdevel@gmx.net;
        bh=Eyd5ldDDh7/F6sZBDzNlf9GYxZJqmkw5bVpX5rn9GKo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=miq7O7dk0LSmiQ3c9QRIoSmrv4Gbdue3DEuuEWQChqGFHU06P/XE+QPQjyHbAy2tn
         1kiA2QZxCdLlt3RA57m83KXQyXFIhJingPlKALH62mXs+CZNFDgmLay/8lniuuf/a+
         3couBlr2HdnnwDS0erDoI2Yt+wf2qjnN6+Rmx6WxbnJv94wkSna3XE8evHgIvRpfVD
         KwwFRajqukKB6E4cArJ2Q+tQ7QqEQffhiMF9fr/lqML8t63UbtG6Qor/CZuRkcCB9V
         cPKfTIBzoiMQj46AYXBr+wL1iAAoNv3CxQDgBgic3El1GVjV0DC5iLatrCtLgJPxF/
         PshPHS2bYrVJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [77.33.175.73] ([77.33.175.73]) by web-mail.gmx.net
 (3c-app-gmx-bap56.server.lan [172.19.172.126]) (via HTTP); Thu, 6 Apr 2023
 11:33:16 +0200
MIME-Version: 1.0
Message-ID: <trinity-3aa9784a-714a-47cd-866b-3ae77ecca0fb-1680773596235@3c-app-gmx-bap56>
From:   hfdevel@gmx.net
To:     neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] correct uart_B and uart_C clock references for meson8b
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 6 Apr 2023 11:33:16 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:JT6dzrFFvtrBliElcqL9Qn15/ALY7j1famJVkytZ5JZc7icHvrmZLv0cB6mnO9lZNeYCt
 oAxdvFTYZsXf+R465th/TP8Tng957atjdWjnWNyKV4STgTDZ49TSEqi9W27fzV5xxXqpoTbTg0Ss
 Bjyo9Ano49ig4PR6y8twSqWHjjyJodSUgsBWKSkJY8mt5w6Wmv9IJ5HSX3cF0HHnZwInsFue8t61
 26hT/kRLVJ8c7gS9pkASB82RAMdmvNp8T8fnQawsYe+235ZYY7UqyI9e+WB7yDtDW9X4nEosFr8O
 1s=
UI-OutboundReport: notjunk:1;M01:P0:Z9HBvtFP5/Q=;Hlzgvn6YOlvHvQpCp4eIO0GtrpE
 wH7gTkHqeM8wOMf/pxgJOeoCtH259Ua3DTMjrCMiMD+PVaRe5fBhzdimYPGp2nQPfIGTipKil
 w0tEtgMW1qUaPSXwE4Olp2HFd6wybsn+Z6S1/b5Ob5PNnPOgYeypX2CLUk4Pz5t04jyKnCDza
 UvT3xyr+ga6qLob0o3Rs400YT6hp27uvyhvnyonBoBnO7FN3ELpImMIrWIOd84R83oXD/4taU
 gqDoIcgxxn5qams2pLQsyx05hWr/GE93XCP/gxxc8WEAeSkOwC5jOVqpNRM2KM4O1jkFegFCb
 bwyMFTwZRPWGfBH15/gev3eO3qb7OpH4sB2T+br5c2h1nzXZbaVauLmFAYJiR76P75Gh4AAl8
 NTaYNwZRb+RBNjox3rRYMTAlg+aRycnTnD6b/AKLcCseDny+qDk6kQo8LO7iir4W9IusN8G/g
 wFwtvijdTw8WF9+C8klm1SZdhHSy7OJgQgfra5JMlju4wUCWBa36BNAAK3A/63/5+D8VSWMQD
 xnIJMy2K49gy0ymZXr+ziyBGh4Y4D6gJpVFuxx19v3vP5r5Bh4sTLZkMkQVwgqQYL/lfFWdbR
 P5RcgIYYsMv2k+G5iVE+mAEXPPkd2ysszgav10Sp2quftfUBK5AOoyfCw3L7a+ElljrsyUTTu
 BjFwLAgBTqLpfk2HJlIXkDNKrlqCbGWF6m9MY283Pn9LFbK/QN1cwF8p42hrMRmhNojlALSPG
 cCdqUat4ALVJjXXqkGh3SyIcByo0OYSLr8F1nWLLwuucFGdKqD6lwucvwLc5jBttx2VsOSZox
 AcUQtv1nk0+qIPHLasMff3XA==
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

commit b3b6a88d2347d2ec9075603920e616836cb46750
Author: Hans-Frieder Vogt <hfdevel@gmx.net>
Date:   Thu Apr 6 10:21:49 2023 +0200

    [PATCH] correct uart_B and uart_C clock references for meson8b

with the current device tree for meson8b, uarts B (e.g. available on pins =
8/10 on Odroid-C1) and C (pins 3/5 on Odroid-C1) do not work, because they=
 are relying on incorrect clocks.
This trivial patch changes the references of pclk to the correct CLKID, wh=
ich allows to use the two uarts.

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

