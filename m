Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92E26140A7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 23:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJaW0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 18:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiJaW0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 18:26:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F2D140AA;
        Mon, 31 Oct 2022 15:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667255162; bh=r6pwDIsndUPkTAtntN5/yYnVsGNdoeotVVNZZIywG0M=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=eVIy/PWpgRCyI5llVCSt2bjm0Nau/IJEGXdGafTTAW4kToqCdg/6ap3iZKmtIX8vD
         evCc5KbascYUk+22i/FZmCqFUigWeU97DWmTgcHCnoXf3MuTdZGa6J92kppIHLt/Bu
         SZGTvbAVrIJzA5xQFMS9ABQ+fh2Ii/dgJf5rQw/H8bc0OLqn0P++UjTWUt2a25YuZA
         pOODCby/+LIxIRjkkXXeZrZ84+wMAbX+48TB/sUI5UBVpTuZV645aEd7Z9OfMi8IKY
         c+/h0IUb4ZlsjRrIu2zv6FffuY4A8lXZ2g4pjjE/CCGizEVFWKpzZj+om+4+VIGDcA
         IqD8FU4Ehu9Xw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([78.35.189.154]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrQEn-1pMXrJ1Nl1-00oSp5; Mon, 31
 Oct 2022 23:26:02 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: spi: nuvoton,npcm-fiu: Change spi-nor@0 name to flash@0
Date:   Mon, 31 Oct 2022 23:25:59 +0100
Message-Id: <20221031222559.199509-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2AF0SEBGIS3MpghBjrc7s5FUflRhnSWDb6LHrmFtpHwH1jh8/kt
 EgJlnTfBe3CoIWw08mO5+y7+cPsdF2T0JVHETUuennmkAgqCZhz/FSijZq5SveJ0pC4XzZW
 nHjUqkCqSgtVn0snGkXHzbN/0KQ6HYnsJGV3LlxgyxzYbsR5Sj+IQETSf9v/I//IgikJwAx
 MjVPS9+Ks43HqOPhBIceA==
UI-OutboundReport: notjunk:1;M01:P0:0Zu6cMD1Wpw=;cgUPTGQSfxNvJkNm3vAlX2cXq06
 K5YCbWQx/UHX+VEuB7NgH0i5ahdktnY20YDHjkkpjuPlBa1+KQ7CcZvckcpEoUqo+pVUhURB3
 VZBgMJ1+0K2eUyGxwDuKN+fg2RemCtbiB2REgkJPtv2MJ2jJYpUJ6wdCOah2EYNvT8+O1Y+Su
 dRnosBW3Kbv4qcA6emvfGtGqHOrqcldY2t7r8C3bTSI+dThY7AGai/viii0agw0GqxbOzYls4
 IU/uREmDOH7tRPjVDAL3qjUYV3x05QbcOL8dSy7FfMyb8BxV0pffZ7IwRFAFBkB2D8qmTBCeg
 LOr61A7r4bcks0cYtf6xM7WfgHVxh1Unwus9L2LjfVvejG18+Kdz0J3qx+ji0AgEcbFjwxHBy
 pWHjDc/ALYOH6lMPJltneEWPfi9xOPx8uDkWwRm9vbwCVZGFaIFyjtcVb4ybrFg6osaYHdQd5
 vYUL/usBC1c7hAUw56cA2w/e+G/FSijFt6ei6gQlsQxfXbwF+WzmFCAgHbE8xLv4SYhNXyq93
 qDeGuVK/uiX93DWMADRG0x8fveVGTmSlaASKApwuJKDVFTxm/FXFl/DpAJkxQFtMyCvGfMnjZ
 PLmjaG7Akv/F53T8r0vQ6OP2kkVAw2lkTuajrMuq8eMTiiueW3zq/7ShdZXWi3BOjfQXlAwp9
 sT8AzbF+FyQjF1Oa+FYoQZnwqnbdXF76u2dVVbatMK37+SAVFPvKNAfQRJTAbJNsGv30jhMCB
 ubWer+aGr4kOBGmacE8Zwfg4Nhwe/3zesfUL9xAGDUuetePchgyCOguMWHo1DVgJ8Q3Wm6XPj
 H+LWacaz679SZ1oMWmE5v2jVnTwj9xLGLxTVau9wSmObTmcn2W1n4rI2jXQrgQaGMGx7uPSR1
 fyybMhJt2w5MPSBDWYBeZWPnwYdPiFWwZrKWPKooV1+l/KRXSc7Wf80ifRFmpbvoxbwpWmPUp
 p1SANsoEj5cLwAVPqynGbk5Xq7g=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node name for flash memories has been standardized to "flash@...".
Fix the example in nuvoton,npcm-fiu.txt accordingly.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt b/=
Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt
index c63ce4cc0a80f..fb38e96d395fb 100644
=2D-- a/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt
+++ b/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt
@@ -51,7 +51,7 @@ fiu3: spi@c00000000 {
 	clocks =3D <&clk NPCM7XX_CLK_AHB>;
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&spi3_pins>;
-	spi-nor@0 {
+	flash@0 {
 			...
 	};
 };
=2D-
2.35.1

