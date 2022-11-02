Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8E86163C2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiKBNSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiKBNSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:18:09 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057302AC71;
        Wed,  2 Nov 2022 06:18:07 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Lr0QH-1pThI82vyt-00ed8W;
 Wed, 02 Nov 2022 14:12:12 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Peter Chen <peter.chen@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/6] arm64: dts: verdin-imx8mp: usb dual-role switching et. al.
Date:   Wed,  2 Nov 2022 14:11:57 +0100
Message-Id: <20221102131203.35648-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QvXz3Icm2Ptr1VtiLwp0geZ+zH9109fsySwBGkQrAvNT/gLM7j9
 y4oNs6tIC9Hy6o18/vACKBomOlt/90QFUGs/c7563AVW0NzVTELj2GgE/T5S7oKkwrbk2ir
 zO7A3HIut63Fot8FH4SIHLCiZZsCeqoEgj042e8VGgVPIrD/wwzmHhAKY16NvEi6vZv2cWt
 BrPa5zlSB25drPBR078DA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ISAneY4YKFs=:LZUiO1jz/uvYI8T33anxDZ
 vxX3LFgwfYBoPgB1lo1iMO59qlSB3AqCmqi5phyBbtQsnQbC4rcXACdmcHuF+CB6fq2rIgbmc
 UBIEocDaWRUjuRo6/eUWa62/VxcV8s7QeihxteQmSRp7ADX2i4A0XiL7sbGKOfof1c2CHu/3C
 nsttMUX17jUzNUg4YkdqwM9LTbkasvYO8W6KWhg0do2BCHGENuK4V1s8o0jK97LcVXc3wP8qS
 eQ9soI8zi34XV4n34iqWis5IhpItt6CHUbePNtB2eZhDYdVeY/rESD2+63b2/4nWp5dCeBBEQ
 4bX8jxZzp5kwgAEbz5Xl+jX1TRUDXe/K82186ktuTrayLf2zWvuH4vdTnI1H6giIvU6l9wzJK
 oGpEQ/oZfYtwrC7AmY1nWZp8e6sxd56/YJkAg/VmL/Rkro6GUXTZ1hF8+hqPtugbFiUm6gJkl
 i0xrZGFol495bNO29LyQ1jGgyt2o8BjnrzUiLOOzo5o5ysr1vEKgwHobf+fAVOjVEKZXivIJx
 InxfoSNifTUWJFdlZdGQbqR85C0oDmAl1K3rib2IPFbyOzB2g7BfxHa1LRiBygfL7sCc1NXNG
 LfYipVlC3YECzDmlejqg+NFiJPsnwpPUVAj8UT8/Ws+mq1dvBEFWbYb5TRX3Xaq9u0dH0NF0S
 UMivPg/sKQU+Fs8t0mHiLiLsRnGiRtgmriIqs8fZNidFITlrkkc0mkKNpD2UJbFHqieGyp/cz
 lNxzzihhXgFDpDJBA75APVKHZziEMR3ZeDwfijh/bFGriuJDMwZM0309L3ssIIpZ5GMNg7Yv6
 kIG5Cy3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>


This series is an assortment of USB dual-role specific commits as
follows:

Improvement of pinctrl for vbus-supplies:
As we are using two fixed regulators for Verdin USB_1_EN (SODIMM 155)
and Verdin USB_2_EN (SODIMM 185), those should be muxed as GPIOs rather
than OTG_PWR.

Removal of USB_2 over-current detection disabling:
The disable-over-current property is only applicable for the
ci-hdrc-usb2 and dwc2 drivers while the i.MX 8M Plus integrates dwc3
IP. Therefore remove this property which does not really serve any
purpose here.

Addition of USB_1 over-current detection:
Add Verdin USB_1 over-current detection functionality via Verdin
USB_1_OC# (SODIMM 157) being active-low and removing its previous
gpio_hog3 mapping.

Disabling of USB port power controls:
Disable port power control on Verdin USB_1/2 as we use regular
fixed-regulators with Verdin USB_1/2_EN as enable GPIOs.

Addition of GPIO USB-B connector:
Add GPIO USB-B connector (gpio-usb-b-connector) functionality using
Verdin USB_1_ID.

Marking USB_2 as permanently attached:
As both Dahlia and the Verdin Development Board have on-carrier
permanently attached USB hubs mark Verdin USB_2 as such.

Note:
Currently, I am still seeing a rare race condition of sorts when booting
the system with Verdin USB_1 as a host port with a USB memory stick
plugged in. This exact patch series applied on top of NXP's latest
downstream 5.15.52_2.1.0 release (together with backporting a few more
dwc3-specific patches) actually makes this same use case work very
reliably. However, NXP also keeps further downstream-only patches which
I plan to further investigate and hopefully upstream a proper fix for
soon.


Marcel Ziswiler (6):
  arm64: dts: verdin-imx8mp: improve pinctrl for vbus-supplies
  arm64: dts: verdin-imx8mp: remove usb_2 over-current detection
    disabling
  arm64: dts: verdin-imx8mp: add usb_1 over-current detection
  arm64: dts: verdin-imx8mp: disable usb port power control
  arm64: dts: verdin-imx8mp: add gpio usb-b connector
  arm64: dts: verdin-imx8mp: dahlia: mark usb_2 permanently attached

 .../dts/freescale/imx8mp-verdin-dahlia.dtsi   |  1 +
 .../boot/dts/freescale/imx8mp-verdin.dtsi     | 40 ++++++++++++++-----
 2 files changed, 32 insertions(+), 9 deletions(-)

-- 
2.36.1

