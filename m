Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8792367FF47
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 14:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbjA2NBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 08:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjA2NBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 08:01:34 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CF5B47F;
        Sun, 29 Jan 2023 05:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1674997271; bh=w56sESUq/A9zW6mJ3FqNY579EJHl07PnCK+2g0G+tlI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=FIcQalt4ZGsfTrzaycwzh3J0QLJW4aF9Z7evajQ2X67habqCeH5ycXdJxgQ+KYL9g
         YBk6swrlbMdpkqHigFlFLO2TXeUBvqTBjysrTF7LraDBIDIaTyeLdBU3jrGgBATvvj
         tMHu0ww5RW0jHj+mDr8DdWuCT9DXBaHHXRKxpW4gCwEtvs6ANjdIOdjd52oFtYOvdC
         8JWQBnvVEOxF6e772diCKzzle/Rsa0dku3y6d5MsI5KuiO5Gp3bu+hc/EiahQKGy9i
         u39KNc7C0OVFJD6HSdDHEtSJJ78e9VN23cVpf0uhbimEvATBs3rARdZlTTF63ghHVI
         9un6NxVpOPG8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgNct-1ojUAC2SPn-00hsOp; Sun, 29
 Jan 2023 14:01:11 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     devicetree@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: Improve grammar and fix a typo
Date:   Sun, 29 Jan 2023 14:00:59 +0100
Message-Id: <20230129130059.1322858-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gIZZ2EECX/uhdlaKjh3VjH6ZAkokhxs5Lh2T0WgO9mNzBXsFZju
 +Ysl0RE6b6gA1sOOHv+V9dCQnktTxTw1I3p3es9rcSpKBA4vnsT9thcrf8b1R5dXBLgXjWk
 QEvdAsJW6r7buS79eVh/Miq3G958F+9P0pRSi/mIRDm/CSZUMbL7bGPPrpPwk+/Tt9QvdOr
 z3Z7EZmnS8s52quzAp3+Q==
UI-OutboundReport: notjunk:1;M01:P0:cXVWC5ZRtBI=;DCcZ5VDLG2wDshwM2u2/ksIm8ec
 0QbKNXQXdf4lghdqfzYHdQrefjHzODMWJZn2m3OrQCmHESVLulb9v7MDtMZAEe0g9yXGKkYir
 IkwIZYKA0ROfijZTWWANcOhxZfFzYG0rDR26cwYREHv4kEajk0bnC4GHNcdunWc/fH30s2CSd
 QhzCOHUoZxti47Sk4VVbT+j+QHtDvcc4yKAPGHXHPMmibif6IHR0tyfaw/pAUiuXLWX+DJsCO
 tJXqPjTn/yFaaK32ZYOTzSWHNxb49gjt5/siMIjKLrTlrJYXHjNylM+SOdgwC9D5H0hKlbVU9
 7GVktbUY2EQrBgrK8vEx8wWxCNTFDsIude1Sp2UROU9tO2ILBvNoLtiy4wySIdmzdxQC2SjFJ
 B4kyvUn130j0LxhpNVzMhoYZxIq/GmJtzQCwkdl1gLm59BFXimBaSG5P7QloKKsvGlbaTzqeD
 eFagdq6Ym3QKz4Z5nKFtd/PoSdHPLQag31Pmry+5ATTlriS76Vsx0/QJ4u3cj2jS/bsdatsXF
 4Q7mH3ebzcHQf2jFozWRbK+y3FM5Qi5750z+1g69bkwsiy3smmWlA5RX9wF3JZG2AYtEL1ba2
 +K35xkCVWyfwZdym4quw2iyxml0Zw/VmHAvgk4SmRniWwHLekleWA7Fc4+ImlPyUAZRa1VFUi
 XOpwjb3bXygA6iik0CeHM0SfQPwnQ5fJlNbthMR7PrYXiX0QCOys0RVuzcr3iwTUhNaKrCBd3
 aKW7D7iEpUZbriG/WAVBIh2VozD/od+nIv2qxTz7Mxz8puifzxIVnfX5XEUA1uvjtqX8c/bZd
 RjaKiD50M9YIFpLGdDSEHITzbY7TQqhi29Nrvvu80ecjO7Ik8uN9Fdtpo+vbJG3ZoBm+3Uf1/
 d3m5oKC3hYinTWqxsK9gJjB5uBMAl2hhpanRKkk94csT08d3DbCbX++I1lcv+v1mBXLh8wYPY
 IK6dMXqI+y/1xU49QQk2mRk+zOo=
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the text read a little better.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Do=
cumentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index dc6256f04b423..1c79b68753da0 100644
=2D-- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -98,7 +98,7 @@ properties:
       Specify the number of delay cells for override mode.
       This is used to set the clock delay for DLL(Delay Line) on override=
 mode
       to select a proper data sampling window in case the clock quality i=
s not good
-      due to signal path is too long on the board. Please refer to eSDHC/=
uSDHC
+      because the signal path is too long on the board. Please refer to e=
SDHC/uSDHC
       chapter, DLL (Delay Line) section in RM for details.
     default: 0

@@ -127,7 +127,7 @@ properties:
       Specify the increasing delay cell steps in tuning procedure.
       The uSDHC use one delay cell as default increasing step to do tunin=
g process.
       This property allows user to change the tuning step to more than on=
e delay
-      cells which is useful for some special boards or cards when the def=
ault
+      cell which is useful for some special boards or cards when the defa=
ult
       tuning step can't find the proper delay window within limited tunin=
g retries.
     default: 0

=2D-
2.39.0

