Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAB05ED643
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbiI1Hg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbiI1Hfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:35:41 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EC2106F74
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:35:27 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Levc1-1p1j6f3LEV-00qeuZ;
 Wed, 28 Sep 2022 09:33:59 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alistair Francis <alistair@alistair23.me>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Johann Neuhauser <jneuhauser@dh-electronics.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] ARM: imx_v6_v7_defconfig: Enable USB GPIO extcon support
Date:   Wed, 28 Sep 2022 09:33:36 +0200
Message-Id: <20220928073336.63881-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220928073336.63881-1-marcel@ziswiler.com>
References: <20220928073336.63881-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:09IfoeEfYuPX4M/ygwUsTQumHNCtQ2Eurq9jeCAYjPWUYOfuAsI
 EAe/T6y5iGJdC3UYS/pqQ8hsNO5wdaeAaM7SMZ/X7XkLu0AsDtRGVN3Qy5xNA5xEKOSJ0ok
 DgHF/EKta4NXez0bhbcwSqKeqqKQ+wiomuCr+iAmp8Z3yPwAhQEgHOJnaI/IVXvqx5vUQKd
 RS89xPSL/TaPqdTmP9FlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MQCacF2tG+8=:/z7hVaun6aKSB0Xd4dUYgR
 m4/NuQwNipGfMiI653tMuHv3FGV80tv8M5RgUS/TvMHmPXlwsG/M3cu0PbZ+NMnB/WSkhbpp1
 Xp+iYJZubHZQYy5Acor1a0JH2ZUMgpTrQbvKHtuTat2y6r5gYBkjetWhDI+TLvRA4OWQWaZK/
 33Uarh6rLca9I0T0T2a/vox2VIZrUJGMLl5ng8xzjr/+mcTgF742EKvWCrY5OZu3BHop4O269
 /EEsgFW5odBewO7m69TbESfL3H4nZmQPwLbHED1BOE69wc3Ah0zQw5gu6XZteX88YlDlW3uZb
 /A0b7PpCHlRV49v/dVA2NoSqoLM1Cpjr12I3xg7XQb55R11Wl8qh5Ha1BlK+Nl8iCB8doKHnn
 Yn/efOXkzYnObq31wzv7xpio9n8FAEwoKkWW2bulARhHInAT1euYfTSlA+6+zptnS7qXq/KwA
 lewokm+sLKYztjM7VwXlyKi4FZzGzkrft334Ga/fktJy6olEiqTL4DwR+Hm6STLLFgKy6fz2r
 BSdQdaeg+L7R2GuMqZiMCcFMIK6lymuE446AAo15zyuDSVGzgF/g0M41ECCkd6VSgw0we0v47
 OzZT6NxmNm65wqbJ4LX8CtTxWEOl5COBznXAFi+2nDUFGiqOm2Z9IPYoKQvnbcIEIo0Vszfnm
 +pLZr77AJjrxj4srntWxJPK/LbsaSKRKBm2Hm2oJupEAkj/XwuL6nC5tKaazs5L2HQYaWktf+
 15DRnAZukTHszDECjPd8/rEXSvMVHGPt/HcqRVC+6TCmQWc1nidkucjHSeyySXFolhgLY6aYe
 uiJkzDW
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Enable USB GPIO extcon support aka CONFIG_EXTCON_USB_GPIO as e.g. used
on Colibri iMX6 and Colibri iMX7 for USB device/host role switching.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Add new commit also actually enabling CONFIG_EXTCON_USB_GPIO.

 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 01012537a9b9..bd4b132cb049 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -397,6 +397,7 @@ CONFIG_CLK_IMX8MN=y
 CONFIG_CLK_IMX8MP=y
 CONFIG_CLK_IMX8MQ=y
 CONFIG_SOC_IMX8M=y
+CONFIG_EXTCON_USB_GPIO=y
 CONFIG_IIO=y
 CONFIG_MMA8452=y
 CONFIG_IMX7D_ADC=y
-- 
2.36.1

