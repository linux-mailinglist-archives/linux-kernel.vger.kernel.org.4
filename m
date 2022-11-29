Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF17F63BDE3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 11:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiK2KXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 05:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiK2KWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 05:22:50 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BC9D2E4;
        Tue, 29 Nov 2022 02:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1669717357; bh=8eefIejhUZKP3XYAMhDZQ9H9WglhQ79OVnj3c0fFmiY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=oBqKylsECYq5I/2GmpcEaQr7dFLmoSqFYFiZsA+Y82BFJrhIsCVRFa1txdK/v5+w7
         KCfZD54Xs0BJ+j9H9qfp37KGsg0ok4h/CmuvsfKiiNTvUotnyPuGiyC9ll6cCkfEBn
         k4V4jhWoWSmNs4gB9W90kdNdlys4ALK5xD/nRK5g/IqsQA9Hk7KHDxqIzhqyS8Qk7k
         t4kaCFvz4ktgG0tpWZ2QGD9cr0F4MaQM9f/lJJWrvqqC1GSCKfXzqE7lTKyehbq1qV
         xZpZzt8D14zEwi16CtzZKwosZudWSIksdyzBSLWWkpYvrJFqutm4KoeZkMJLHcgOYq
         66jvxrTRckXJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAOJV-1pBGQ22lhL-00BqtP; Tue, 29
 Nov 2022 11:22:37 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v2 1/2] spi: dt-bindings: nuvoton,wpcm450-fiu: Fix error in example (bogus include)
Date:   Tue, 29 Nov 2022 11:22:24 +0100
Message-Id: <20221129102225.3598044-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221129102225.3598044-1-j.neuschaefer@gmx.net>
References: <20221129102225.3598044-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9za5dH/0RwJN5d2RNLYIj1wTXHmsiB+J0vGP2W6X/NkSTy4TFsp
 lC6QGNuTYTV/9e792Neiw6YjBKPdniYotzWZsbuKyoZvLGIWHfNhcVziFfiaW0acvYjfyj6
 h1Ovo7xUL/1VtK0hUi0ELJlrGArj2xfRp77ZIzy/QriV4zEUFxfDCegm+wA/i9/S8tadYtM
 rsgob02qh64gdgH8P8tsw==
UI-OutboundReport: notjunk:1;M01:P0:Amp4+tBHQOU=;bAc4SX+oNM+4Kk5rS+Vwx4oysl8
 /c3i2QiGBs/P2msp5IJoCrfdqi0SV5/t+01e7M4GMjQKd6VSYKFPrIoQNJYZ2ZffKq6F3SRAI
 PYzttaKMHfbUoNG79CDU8NY8gOYArs7xLuWMXAaiGWqv42rLPomHKETwP7WTVBUJb4eCt292W
 voZe6uR/XFifrRuBJMgBvoQRIX0mkIVilZp23Cmk8e0/niq2HzCMVHS2i8d0H7g2P+f/L0urB
 juiQz6IPBmYhiPDAQ8Eyjn7OSIgx6/gQRDzoxYKr9ufrPJj5YCAnBILdKzXdDbw3LM9g8N/V5
 PmHV+RbiiGaMK3QENU806lRBxgSTB98dw5990MRuEnvs2/qdWCOkYDfBg0nlpi6bHJ5/6K9CL
 Sq/4Hf2grLS+gPy35NRAFdadIvMIwHqL1KEfEKneMnr4T9GS6JSr1BjWU9kRJjFTmqoEB2SJo
 FZuqTV5O/p7/EV+AwjuqzMghyOPYTQLbnNyVlfqitE7jIJH1XISPPA4IYbREoUUu85FZohMye
 nXVeDPP2otoGpZ+etdtoKwT6lYqeQg98tKDWHSXSS96k/NYqC1Fo+zUEwJ7nx6yWrg+EZe+Sh
 pZmsBKGn5MJyqjJuBTHWEdMDfkgQQ1AVkZFxDIXjb3KGBOehFZI9Uawy0K55Yhsz9Q1NsYCuY
 LCRGueC5c14G+BXY7px+9iihAnbB0PNSLklM8FXv2wZOUD9dCBsEGbkAe/ho8uHNbjOOsc4X8
 Cwtran2SMSuQKoUWLWDVFBMFgP340bKL6JqeLYT6sViBwR9j8bUyEnDh9vKHtdfGkcLy560ls
 BRH+kTJjjlMk75w41uiCsMbmrUFlnDa0uM5k6xoP67tugAcItmGNB7APco3qP+SXNd+O2PpV5
 blRwnBoLF9rFqmt3pwrlavtvJLIp1XLvOZn7S3Hf9XKoSpgAtCmSVkU+QA9l3Rs8DZlmt02/f
 lPTIiRp+HLvV8qnxOa8nltwYMKs=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nuvoton,wpcm450-fiu binding's example includes
nuvoton,wpcm450-clk.h, which has not been merged yet,
thus causing a dt_binding_check error on -next.

Fix this error by simply hardcoding the clock index in the example,
before the breakage spreads any further.

Fixes: dd71cd4dd6c9b ("spi: Add Nuvoton WPCM450 Flash Interface Unit (FIU)=
 bindings")
Reported-by: Rob Herring <robh@kernel.org>
Reported-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
=2D--

v2:
- Credit Rob Herring as well (Rob's bot reported the issue, Conor made
  me aware that it is a problem that has found its way into linux-next)
=2D--
 Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yam=
l b/Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml
index ef94803e75d90..e4162845fcc1d 100644
=2D-- a/Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml
+++ b/Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml
@@ -45,14 +45,13 @@ unevaluatedProperties: false

 examples:
   - |
-    #include <dt-bindings/clock/nuvoton,wpcm450-clk.h>
     spi@c8000000 {
       compatible =3D "nuvoton,wpcm450-fiu";
       reg =3D <0xc8000000 0x1000>, <0xc0000000 0x4000000>;
       #address-cells =3D <1>;
       #size-cells =3D <0>;
       reg-names =3D "control", "memory";
-      clocks =3D <&clk WPCM450_CLK_FIU>;
+      clocks =3D <&clk 0>;
       nuvoton,shm =3D <&shm>;

       flash@0 {
=2D-
2.35.1

