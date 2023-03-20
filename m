Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7006C1B5C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjCTQZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjCTQZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:25:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B6725B85;
        Mon, 20 Mar 2023 09:18:29 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o32so1514014wms.1;
        Mon, 20 Mar 2023 09:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679329107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IZ0QVsH9HEKdarKuMtmTbFTjEp0iLRbtuconCVoJf8I=;
        b=TZ/iLRsSEXCpTe82KusSMD08bbOfaKx8NZR+ATFKBI6WtbQNYdQACXYlVgOblmYZZb
         IQqaq4d4bG5w0EH8oJEGY9P9rocHxb2F6sBl2d44Mkl+eOw0Qb/SM9S+CEkxeaxMtS+d
         rNwpGt6XrE8U9LBHrEhgOXFgq4ol9TuGfgCGKXnNPQqzVYVnvlBTiluhz7j0O1QT7O8j
         lFSm3V0PHYCdcfAjCoYms4tGF5vCbM3bMzEs/AHD7a3wzDnjxHWEbRtPHdgDSRuvNY8b
         ZOLlze7IGBTQQk3Paq2VNtdE9V2rysATFQeaRrw7jKtFBq1Fxduh2qvn0C+OAJGtRdih
         VDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679329107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZ0QVsH9HEKdarKuMtmTbFTjEp0iLRbtuconCVoJf8I=;
        b=P6O++MKuKjNoWKZSI6jHuET4gY8DzrtTv/R4FA8QOUCOOJTYzwQLriDDn9ubathjFC
         ohaL1VeRhxEhNTU7qdTdSq1yCqpJzGpe5kWUwjUUgxO+/fBUZz367lkL6LKwIJBWYq8R
         RKNsN21pXvldlk1zcYTXi83KZoW+k3mtDTbHH48zm7B4fa8cnr/lGMKY1Ozn2hnZWYnx
         LdIYtG4duSgUUnc52tWf7mldTZ92OjukbEmF0ER2PJ2s3Jr2wXdV763bsMSNe61HQGEa
         9J4RNKK7QEAkQA6u9qwKobN3YUPpMqgWnQBz+dhhwQhuacd7BvzBjOWUF5/zvS7VyNBE
         didw==
X-Gm-Message-State: AO0yUKV+5vlFU4OFxsy0zP/mf8AlMBXhiuWaxfW1D3XDJnn9PocK9q6S
        X94vSc1YsVsIXJ5OvyQXjReArmusook=
X-Google-Smtp-Source: AK7set/H/OwhdtyFvEdzyRrZwmVZ/kSuOIQFNJAtbQhkjAqn+bHfabyr/Da8XO/ZQSlc5rueTcDEig==
X-Received: by 2002:a1c:ed0b:0:b0:3eb:966f:5811 with SMTP id l11-20020a1ced0b000000b003eb966f5811mr97126wmh.3.1679329106876;
        Mon, 20 Mar 2023 09:18:26 -0700 (PDT)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b003ee1acdaf95sm847776wmb.36.2023.03.20.09.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:18:26 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH 00/10] mips: ralink: add complete clock and reset driver for mtmips SoCs
Date:   Mon, 20 Mar 2023 17:18:13 +0100
Message-Id: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is a big effort to properly implement a clock and reset
driver for old ralink SoCs. This allow to properly define clocks in 
device tree and avoid to use fixed-clocks directly from 'arch/mips/ralink'
architecture directory code.

Device tree 'sysc' node will be both clock and reset provider using 
'clock-cells' and 'reset-cells' properties.

The ralink SoCs we are taking about are RT2880, RT3050, RT3052, RT3350,
RT3352, RT3883, RT5350, MT7620, MT7628 and MT7688. Mostly the code in
this new driver has been extracted from 'arch/mips/ralink' and cleanly
put using kernel clock and reset driver APIs. The clock plans for this
SoCs only talks about relation between CPU frequency and BUS frequency.
This relation is different depending on the particular SoC. CPU clock is
derived from XTAL frequencies.

 Depending on the SoC we have the following frequencies:
 * RT2880 SoC:
     - XTAL: 40 MHz.
     - CPU: 250, 266, 280 or 300 MHz.
     - BUS: CPU / 2 MHz.
  * RT3050, RT3052, RT3350:
     - XTAL: 40 MHz.
     - CPU: 320 or 384 MHz.
     - BUS: CPU / 3 MHz.
  * RT3352:
     - XTAL: 40 MHz.
     - CPU: 384 or 400 MHz.
     - BUS: CPU / 3 MHz.
     - PERIPH: 40 MHz.
  * RT3383:
     - XTAL: 40 MHz.
     - CPU: 250, 384, 480 or 500 MHz.
     - BUS: Depends on RAM Type and CPU:
       + RAM DDR2: 125. ELSE 83 MHz.
       + RAM DDR2: 128. ELSE 96 MHz.
       + RAM DDR2: 160. ELSE 120 MHz.
       + RAM DDR2: 166. ELSE 125 MHz.
  * RT5350:
      - XTAL: 40 MHz.
      - CPU: 300, 320 or 360 MHz.
      - BUS: CPU / 3, CPU / 4, CPU / 3 MHz.
      - PERIPH: 40 MHz.
  * MT7628 and MT7688:
     - XTAL: 20 MHz or 40 MHz.
     - CPU: 575 or 580 MHz.
     - BUS: CPU / 3.
     - PCMI2S: 480 MHz.
     - PERIPH: 40 MHz.
  * MT7620:
     - XTAL: 20 MHz or 40 MHz.
     - PLL: XTAL, 480, 600 MHz.
     - CPU: depends on PLL and some mult and dividers.
     - BUS: depends on PLL and some mult and dividers.
     - PERIPH: 40 or XTAL MHz.

MT7620 is a bit more complex deriving CPU clock from a PLL and an bunch of
register reads and predividers. To derive CPU and BUS frequencies in the
MT7620 SoC 'mt7620_calc_rate()' helper is used.
In the case XTAL can have different frequencies and we need a different
clock frequency for peripherals 'periph' clock in introduced.
The rest of the peripherals present in the SoC just follow their parent
frequencies.

I am using 'mtmips' inside for ralink clock driver. This is aligned with
pinctrl series recently merged through pinctrl git tree [0].

Changes have been compile tested for:
- RT2880
- RT3883
- MT7620

Changes have been properly tested in RT5350 SoC based board (ALL5003 board)
resulting in a working platform.

Dts files for these SoCs in-tree except MT7621 are incomplete. We are
planning to align with openWRT files at some point and add extra needed
changes. Hence I am not touching them at all in these series. If this is
a problem, please let me know and I will update them.

Talking about merging this series I'd like all of the patches going through
the MIPS tree if possible.

Thanks in advance for your time.

Best regards,
    Sergio Paracuellos

[0]: https://lore.kernel.org/linux-gpio/e9e6ad87-2db5-9767-ff39-64a302b06185@arinc9.com/T/#t

Sergio Paracuellos (10):
  dt: bindings: clock: add mtmips SoCs clock device tree binding
    documentation
  clk: ralink: add clock and reset driver for MTMIPS SoCs
  mips: ralink: rt288x: remove clock related code
  mips: ralink: rt305x: remove clock related code
  mips: ralink: rt3883: remove clock related code
  mips: ralink: mt7620: remove clock related code
  mips: ralink: remove clock related function prototypes
  mips: ralink: remove reset related code
  mips: ralink: get cpu rate from new driver code
  MAINTAINERS: add Mediatek MTMIPS Clock maintainer

 .../bindings/clock/mtmips-clock.yaml          |  68 ++
 MAINTAINERS                                   |   6 +
 arch/mips/include/asm/mach-ralink/mt7620.h    |  35 -
 arch/mips/include/asm/mach-ralink/rt288x.h    |  10 -
 arch/mips/include/asm/mach-ralink/rt305x.h    |  21 -
 arch/mips/include/asm/mach-ralink/rt3883.h    |   8 -
 arch/mips/ralink/clk.c                        |  26 +-
 arch/mips/ralink/common.h                     |   5 -
 arch/mips/ralink/mt7620.c                     | 226 ----
 arch/mips/ralink/of.c                         |   4 -
 arch/mips/ralink/reset.c                      |  61 --
 arch/mips/ralink/rt288x.c                     |  31 -
 arch/mips/ralink/rt305x.c                     |  78 --
 arch/mips/ralink/rt3883.c                     |  44 -
 drivers/clk/ralink/Kconfig                    |   7 +
 drivers/clk/ralink/Makefile                   |   1 +
 drivers/clk/ralink/clk-mtmips.c               | 985 ++++++++++++++++++
 17 files changed, 1086 insertions(+), 530 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mtmips-clock.yaml
 create mode 100644 drivers/clk/ralink/clk-mtmips.c

-- 
2.25.1

