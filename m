Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F655ED640
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbiI1HgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiI1HfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:35:25 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88554100A86;
        Wed, 28 Sep 2022 00:35:13 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LwsP8-1pIyRf06OG-016PRc;
 Wed, 28 Sep 2022 09:33:47 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alistair Francis <alistair@alistair23.me>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Johann Neuhauser <jneuhauser@dh-electronics.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] arm: dts: colibri-imx6: usb dual-role switching et. al.
Date:   Wed, 28 Sep 2022 09:33:31 +0200
Message-Id: <20220928073336.63881-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yn/lVTArrd6dZK/MMBnSp6uwkGmPiaHm0T/Zvch33TBfsm1S2Sf
 kF43qe8cHF8J+e8cXXq3p9omOfNS9x/u7J9SCu903/XskzK9gCUB/0Tnc7Np8N1Sh1+1nCQ
 3X9JjvIdVsnmkl69WncaEyaokW44hT4reOPRP6Zf49l7+ug8rQpCFQMRQFrnD7OhmZbsCYT
 1iAqSeFj2ktTBMU6oVbiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ayf3aOcxwOI=:nCz07pTGQ0FUa+X7m8NVh2
 1HSpfSW2qB8P+IenLRWnyJCLyBsid5tVSm80Y6b/IApTRWoSiaH8s0n4yp/T/btJAJyZDUvuG
 g3Tg+6EgcPPuQvVxmq7N/wDVZAv8xlB3/elDjLyJrbFeyj7hlH05tKDvh4tmkpjPD3V6BUpiT
 OveMjsBwvMbSNWgJwT6oTLZXyOfvUkLMxvA4yTXNayOdwJfrHEZLOt+KxUQmzDEmUBuPGDz1I
 oa/abOfpljpq2a2Le5mm5/i74Ub56GXg8FkdiCe0/hk5xagxDztTPl+33la4D+V33Gc2rQIG6
 K1hdrA9IcpKoxG27X9G0xos4/LOI1aQPK0sZm9qoRfyXESNFBC05IZ7jtcDTI1jXjATk7fjAF
 a8XlVgjbQ1alaS89C5mda/gpM6MrOpxermiSyCiaMBalJiVBQPBM1MKT4EmoiDrk+YJmZIOdR
 VFN76gEchlz9RpIg3SW7MhV8OKV5+6ajxZkn/gsfnYPxolxgoXK5QOEVm6T1tswq3k4UuI1BB
 SxM7gw1BVaG++sPW6dggEXrCECdWGzMfW0qQg3RSAEw9p/QwKLHH+8w3LDyeyzHLlhngGeNqJ
 bveSOv4ta+2jglQnb3Z1fUv6fkfek9nwU3Cqm3Wx4ziwt/Nnl7RfoHR+0d5EP5Pex8XTFrud9
 g84yEXLQ4Z0+2dqifz9elestvFAZliN0KMawIKzLNgGsqEnQzrIcCIieCmem4juMiWZYkLCSv
 lT3STgPP1yvpQNDshYPCPGd3p+rM3DZGMZlMFLA1Azb7f2YNl9k2+b9ee6mtvg/Cy4qAnnSC/
 ZMmHhm5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>


This series is an assortment of USB dual-role specific commits as
follows:

Introduce USBC_DET GPIO based USB dual-role aka device/host switching.

Move USB VBUS supply from single carrier board to module level device
tree. This pin is as per Colibri module family standard.

Specify USBH_PEN GPIO being active-low rather than active-high
(cosmetic only).

Remove spurious debounce property from linux,extcon-usb-gpio. That
commit is actually for Colibri iMX7.

Changes in v2:
- Dropped fixes tag as this change is rather cosmetic.
- Add new commit also actually enabling CONFIG_EXTCON_USB_GPIO.

Marcel Ziswiler (4):
  arm: dts: colibri-imx6: move vbus-supply to module level device tree
  arm: dts: colibri-imx6: specify usbh_pen gpio being active-low
  arm: dts: imx7-colibri: remove spurious debounce property
  ARM: imx_v6_v7_defconfig: Enable USB GPIO extcon support

Philippe Schenker (1):
  arm: dts: colibri-imx6: usb dual-role switching

 arch/arm/boot/dts/imx6dl-colibri-aster.dts   |  1 -
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts |  1 -
 arch/arm/boot/dts/imx6dl-colibri-iris.dts    |  1 -
 arch/arm/boot/dts/imx6qdl-colibri.dtsi       | 22 ++++++++++++++++----
 arch/arm/boot/dts/imx7-colibri.dtsi          |  1 -
 arch/arm/configs/imx_v6_v7_defconfig         |  1 +
 6 files changed, 19 insertions(+), 8 deletions(-)

-- 
2.36.1

