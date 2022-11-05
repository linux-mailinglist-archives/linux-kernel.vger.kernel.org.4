Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E4F61DD6F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 19:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiKES7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 14:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiKES7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 14:59:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73A82AE1;
        Sat,  5 Nov 2022 11:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667674759; bh=+CeGzPHAiwTHslgTPBjflPOdmW6LTaHhl7ZUhW3vNP8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=qxOFkEZ6mRtOW6C0OtjPQyGgvkA05hjrWOCtJUZBCyskS27+Po3yB+UzY4c9ySMW/
         qkIkVsUS5JQ94Wf9wUH3K6qMzTsyggEh/SK763o7GhpE7/4dk73d4KjtF42VBlRcbq
         ozX8WEyPICLnYlaP5YxHVxVtwr8m0uvMaBblkOjOlOqhQ4Yu6gyuLVl0x4nx4rIxmB
         452sTLm48cN80OwffYIcpoeIxoDftx510bmNlXV0loQ9zyBSs0DkJrr8JT29tvZXvs
         lVJdUK8R6x940CoeNbTlEm/IVsc2S2wRIqGrivrGT/gav0wKHzb1v6Kp47HVVgG9Rc
         jbjJVw/zc+a3w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([87.78.44.193]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4hzj-1oyiVE1D79-011mod; Sat, 05
 Nov 2022 19:59:19 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH 0/8] Nuvoton WPCM450 FIU SPI flash controller
Date:   Sat,  5 Nov 2022 19:59:03 +0100
Message-Id: <20221105185911.1547847-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y0mXxM0HICmGnOuG0U8nVhTFBA1wLRp9aUB6oInA+MZotw3HwbL
 MShwnW6ykzM4la9QVqS3pNg87Ylm7TX9x+vFTrexZ4qyxW5iiKcd4QsFgx/kozKO+QJBtAO
 O2Q2N7P4t6y+TxxbBbNeEsJpR9Q1gseSRdCD7urms/mKvIY8DH7a8npqzLV5eXbAsC8uqbQ
 Ej/NQvaje6iIicYun9tbw==
UI-OutboundReport: notjunk:1;M01:P0:PW2MiMKEoQQ=;fObLh+9qyxrgamfZcR005K2qZ8L
 7k//slWMHPh8Hrq2gPzixGromD+zVzHkp+Uh2Ta/jGEb1GovCJ4oRYykLzoNt1iIWNxT4K2AB
 XdnYnRCykuUV7tKyOWvx9FaxIa0j4XJRU4cgku4av2uBUU2OrdgQqINuk7JLgtnu2tn/AEy/R
 erCmQrwGNPCH3jFxt8oJ7UmzUeAQjoM+Gj0DikK1Ib2gA98DNurrPxjne7HB7WH/Cg1Y+3DuI
 JV1rp9rcgR2K6L0Xh/ePjL8TExk5xVGxNrEQLxbjBBmaFJQ9i1apVzBmNB3x4IIViiTZH+ahJ
 R+d38ePanKsDlpGDu/Gn96J2jiv2NnIW29OdcaDKWrFu5p4riSXmNagpbqp+TdwGtfG6iDbQH
 FeFJODT4YTClALNh+i2hm8l2VLknbpMStd5oqHs+vhrU01NI8L2qVA4tl5IwyjJsmpiGWT54K
 NtrN2Ka33X30nfLTDeGC+KUO4oMJGDDcefxFbjjTgeKxpf25/vr87HO81NzN/7VNl40lcJ6xK
 RK3g1lTBLMygylo+UFuRUyRljQ3c3WZL4a/6wpMAipW3CBOCoTiSioDYqCKbs6redtLRYHdaN
 ZtLwpr2Q+GvCyMo4MfsDr8t0wokve/l3FRxJn72fdMCYJhVXdf9K+URF96ruuQeUp/Dd/oBpC
 4c5lvlsQeLJY91won9J3Lb7Gs4ZuMzZeiI7gU43I3xdcZr7c1asLaOVho+H91xK/uXqGtgv58
 8zM5k7sFygPcGdsSC/0Lue+nDlaxbiIl8rdeug+7pQrJkFn63hCwQULKV5swpWEMF+pg8ccJp
 sFpSPQNdnZYsamiCIgOePho4EeJRCUiqOQE6V1O/BUKwa6aXGDN53pWWMvEWo+gH7WmhpPQ3l
 9EdJlQQxIl/dMCXPL8Gx87ZZkayHNcHnBrfeK4qPPbZd/bBWibK4/AnAikp8aUH8NZFYSt8EI
 jg/s+rYmkweG1HffUj5Vj9l8eCE=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds DT bindings and a driver for the Flash Interface Unit
(FIU), the SPI flash controller in the Nuvoton WPCM450 BMC SoC. It
supports four chip selects, and direct (memory-mapped) access to 16 MiB
per chip. Larger flash chips can be accessed by software-defined SPI
transfers.

The existing NPCM7xx FIU driver is sufficitently incompatible with the
WPCM450 FIU that I decided to write a new driver.

This patchset depends on the WPCM450 clock support patchset,

	[PATCH v5 0/6] Nuvoton WPCM450 clock and reset driver


Jonathan


Jonathan Neusch=C3=A4fer (8):
  pinctrl: nuvoton: wpcm450: Refactor MFSEL setting code
  pinctrl: nuvoton: wpcm450: Fix handling of inverted MFSEL bits
  dt-bindings: spi: Add Nuvoton WPCM450 Flash Interface Unit (FIU)
  dt-bindings: mfd: syscon: Add nuvoton,wpcm450-shm
  ARM: dts: wpcm450: Add FIU SPI controller node
  ARM: dts: wpcm450-supermicro-x9sci-ln4f: Add SPI flash
  spi: wpcm-fiu: Add driver for Nuvoton WPCM450 Flash Interface Unit
    (FIU)
  spi: wpcm-fiu: Add direct map support

 .../devicetree/bindings/mfd/syscon.yaml       |   1 +
 .../bindings/spi/nuvoton,wpcm450-fiu.yaml     |  76 +++
 .../nuvoton-wpcm450-supermicro-x9sci-ln4f.dts |   9 +
 arch/arm/boot/dts/nuvoton-wpcm450.dtsi        |  16 +
 drivers/pinctrl/nuvoton/pinctrl-wpcm450.c     |  32 +-
 drivers/spi/Kconfig                           |  11 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-wpcm-fiu.c                    | 507 ++++++++++++++++++
 8 files changed, 644 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,wpcm450-=
fiu.yaml
 create mode 100644 drivers/spi/spi-wpcm-fiu.c

=2D-
2.35.1

