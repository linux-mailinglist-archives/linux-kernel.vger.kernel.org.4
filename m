Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033A163B47E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbiK1Vtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbiK1Vts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:49:48 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E841A2F678;
        Mon, 28 Nov 2022 13:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1669672171; bh=lH8rj/PzzAAs6cBknBhgzV8qtb5kk+LHlemkd1M6aM4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Jw3M37RMVoQiQVVzhAUGEayKnSJtz5guI8IWe0tc6AOQcuuXy+grv5stwPt/MlqZa
         J5lObmPX+pZLwCXVcjnHdbXDf3PD1O2GWEAIE06hG4B/yLhOl969ZAyIOLJqOQzkM5
         sGlwBSY9h+wqIDF9oiZlJGWXMUn/ETwSp1xsV5srIkmQpKmVQbNC9Dr/AZn0msQE0a
         5d9eUHhnAOv+GnNtq0zNE6fbvv6p4r6mVMPssqlEZZob54kBlLEuHHW4ZkGP5UBc9G
         WylYAr1skaHPR13LJPlxwZbmda52Zsm9nh4UUvcJffl0qCBDlNRY8B92+B3xhb+nCi
         pAMxQ8pR8jxOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvLB-1pOpMU2ev7-00Rntr; Mon, 28
 Nov 2022 22:49:31 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH 1/2] spi: dt-bindings: nuvoton,wpcm450-fiu: Fix error in example (bogus include)
Date:   Mon, 28 Nov 2022 22:49:27 +0100
Message-Id: <20221128214928.3531463-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221128214928.3531463-1-j.neuschaefer@gmx.net>
References: <20221128214928.3531463-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZxiiSYcKe9SD3dVmC9CIDRxkAd39KYYm5qOuk04iC/meHTJ9VU4
 g2lwB5G75noaBcFrfaa0lC2YAjKUssmycJZMeLxgNYQUKWMXaMAHh4sSSDhzq0KJpIW6PTg
 NaHtUwuAN3uxEgbzAKd5N+jehroqIVfnvDj9JyI/P7xJmOdZcP5n26yOG5ONX9X17heCG9P
 J0ZA0SYI6ZBIXJrW6eEsA==
UI-OutboundReport: notjunk:1;M01:P0:w0K/LiT7FVc=;epT6TlpjEkDgo25kECZyvEPb8Lp
 +6Zmp/myYrDDQ9HKJgIG2f1xkXCW7vix3/LUnR3QIpp24Y4BLhxgNfKmUiV6tryRxkb0y6P7Z
 8DZv2sgACQCP7bOkJ3biqXvWeHR8B7U/5CT2cSrBgBOIUyL/y3UBF9P5s+4ts1ZByc8fVErQr
 5zbBN/9kDyHGhleaaJL7t9lu87qKZqDAdPWSHp5yvohrL7A+7wnTp+HO/6Fv4GlVtJouxluFB
 4hNEJx1ak1Dx8aSXzPcjkLqt1G7Q7PqTVSTQvdYIJApkQYc58ezefqIHAvrF0Oj39ffs53H4/
 23Xl5ML4W4gqDPhUx/Bm5HT9/i0Ym+I2getfGtYTXJFnCSUN+jsRcgthvz1t6mUynygAfGdU5
 VYPWbFpBZ/kHVfChbm7+EF2UHAGCUFh4EX61Z38PmMvd+wC4dI2j1AuusfzMpzAnkdrDEXfcc
 x32CoHIxiv6rGnAPqQUenWS4YIJjqCxfGkstFKkxOk38oW2gAVK8V+W/dw4aNGatSJO8kZaxq
 Jtj4D2GK5KUDhOMOpKMm46w1zrcXVMOV20NVGZPFAjwDk6o+lp79b2Q9iDNRzBrzd91vZPCoc
 ed3ZDPIhewMDYAC7IrPSC/kwpBZ2WVKgZJS1A+VI0lXyUsVLcOwvXgbCx6SjUxeT+C/OPZUcd
 EjltANfgbA2o0S51ICUjWtO1fu0Jz8JAlh8qrmW5FbGwMbuSnddmOBc6a3fGSSCsOxSCWELfu
 xVM7bAnZIwMJ2HlP/zoFkPDQxb05dwl9sjRlgmvmyh+OhOvzPpM2+U9WQ/2SlzGtHQDwJaozg
 bpYAl7vwV37tThbFxOqnnsYrKfLYp7ELZ0YR2GB+sgJVlEF+vN3eEiWMa3ewrlLGkCV4+4DLP
 5pmKKY3a9fCFSpSJG8vQQyVKCIz84mhibEKAH4YaJNSeJdW59uYiKy8YKY9JpWtn159ZBEvT/
 Hoz14f2V9RTwf91NJHW9WlNUePU=
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
Reported-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
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

