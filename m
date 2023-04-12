Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1163F6DFDF7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjDLSvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjDLSvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:51:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4613461B6;
        Wed, 12 Apr 2023 11:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1681325454; i=j.neuschaefer@gmx.net;
        bh=GFR6pPBbyB1rO8q+jVeF1EaBvVI0oCUvnQvGxUKX0l0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=nnLio+lxptky58a/nb6w3pIFCfNPtD2JZ3ma8935KmFDjmGRpsva9jsmK47+3qM+w
         eGZPcf418TQ2VHEYK7u8/xTteu/WxiutCP21qDukLLFgq7xjWgIebUsG0w4P2G+2JB
         k4X6vmqz/qs2+Q5+LGOR7M73gNj1JbWVhQEJheXWw53U5DesHYewDyKRX4na/RDvjt
         9vDUOC7P2WWEic3pwoRlMDYNGs+h3G6sBKROVA0C3+pOr01NQlsOp1t7SQ4nDd8qvL
         I0CmOh3ZmruB5q3hO7C/YvN+inM2bvn56uwB4QI9JZJHOTaixCD97BoSvnkqdviOip
         1aPbfKjHGpJjw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([185.66.193.41]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmGP-1q6fHL3CLR-00K9qe; Wed, 12
 Apr 2023 20:50:54 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-gpio@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: wpcm450: select MFD_SYSCON
Date:   Wed, 12 Apr 2023 20:50:49 +0200
Message-Id: <20230412185049.3782842-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aggW3W45FTuN4BbpiHiKJOpl8E/pH2Nw2pHRIXGEteiRP2qyb4o
 ZyhMoPLfz7PlK1kuOzlS3YuDMQ+NajrA4m6jPt45xzmisUE684k9bQWawNXarn1ErNtVyuU
 1uqpo/u4CwbMb/Oq+9IlHadwNImVLUU6nmiJh8nIbQ6J16J+cSfskJSanUO++BvTPT7WlRe
 FdsiRSVS1rdtQNWjnz6Og==
UI-OutboundReport: notjunk:1;M01:P0:Bj0zO1cdLHQ=;CH5ZIGfiCO+AYHjYxM/PoShCwdT
 zG8A7k7SlLID4z1Gi6swYevzoe2cdJn4svjhdFaB1bFpltT6ZmuV4hbCphS1zN1XqJ9JolBW+
 qOvTvs6U8oWkCH/XxunZEcsPaDyyCs+lQsx5mvoJvnWoOpvCBR/2TIlrqxokfjzveUbgSPxSF
 yN0EeGBmocmyGrVbLp1uRKkSd0ZW1AVM9Ngug7JuC9Mr/jWWsHyqsEdcV7+skPMLysRyzd6Ap
 lYQODI2dqCih9clTwxkyLDT2wDvdfEoZmSl/SCG+vZO7CjmMeQBLSlw9Rn7QBOvp3VN/QQ3ks
 AiwdTHI0feETdO/HlAnNTEIbxVXgPp/yvgfHQzg8jl1GXx3DFdJ8MsypA2niM0qNEq3tveWg4
 ck3SjiATUwzJ22hpLcZ3BIsTB5X0gS/+XHbY+R7x83qMbfJpyO/33RWFMGjkUI2Pa2I/uFey8
 UN5QZV/lorl7iFHXUQLDfB/VCaU13SH74/fgHURdx/gEuMi1yZ9FPZ1j4A1sYQrNjlxt4p+XO
 ZVQBlFpOtkwggWUVePhwKHL3JIREIP6slrPCSPqbAMMFq9gJB0xVM2Iw1/LyujUIc6mSBjG2B
 Do7faSegLTqXkt1egs4Ia853Sg9yUAh6f+/wKi4bPFWKoPSrK2kIyl84g7SlH0bcC3Ay6klsv
 aao6qrbrnQEy3KwhVolFKjWsZLfrAOnawCRBhjll8PLtLaVULcd92FWcOll4JRhjT76q7wTOS
 8TnwpXKEIM67s5fMUcjjD9ArtIhbujLt1CefzQFeMlSzU177uaZt2d6tsdV+nR52fPLX2TYn6
 XsyJLu/hA18AxOrnLh4jp17V1Rctcrjpli6UHO1RwwRz3QOI/Bv5idkYAB3Qt/L4vspYH2b1D
 rik8J3IU0p5QAsfuQhW0rY0fOLW4ldPsF8rN0rjS/NwotSZxyYj1WzS2G9MzApVulgcTDem9N
 M0b9Ug==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pinctrl-wpcm450 driver relies on MFD_SYSCON functionality in order
to find some of its MMIO registers. Select MFD_SYSCON from
PINCTRL_WPCM450 to ensure that it's enabled.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/pinctrl/nuvoton/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/nuvoton/Kconfig b/drivers/pinctrl/nuvoton/Kco=
nfig
index 852b0d0eb08e0..8fe61b3481818 100644
=2D-- a/drivers/pinctrl/nuvoton/Kconfig
+++ b/drivers/pinctrl/nuvoton/Kconfig
@@ -11,6 +11,7 @@ config PINCTRL_WPCM450
 	select GPIOLIB
 	select GPIO_GENERIC
 	select GPIOLIB_IRQCHIP
+	select MFD_SYSCON
 	help
 	  Say Y or M here to enable pin controller and GPIO support for
 	  the Nuvoton WPCM450 SoC. This is strongly recommended when
=2D-
2.39.2

