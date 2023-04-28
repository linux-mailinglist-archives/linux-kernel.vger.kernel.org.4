Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8307A6F1E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 21:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346582AbjD1TDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 15:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346461AbjD1TDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 15:03:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4008940E4;
        Fri, 28 Apr 2023 12:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1682708555; i=j.neuschaefer@gmx.net;
        bh=CF1sZz4k02QBYfgP0eXXL7Vnco7PO6Xo/WIy5gteZNg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=gxQGLql0UO32aR/fayGJyyJG34yeGaU3BgFp8KPOK9BuvAr4esK/8G+0dosUz0lDA
         GFC5CjWxzZz6CvelhNRw9G5NPAeiT+aafWjjNg0GeG5E8BeZmdgpQDrkhI9ppMgdjE
         wucdaF8MVTW4kWU/HAM00OhqBcxypUKyyev35jM9IlnQ9UIrW3TyMhg5foEtnJieCJ
         UN/KrjbQV+jV+QXpLNhfZrYP1ytO6Ht7RxjXUMTVmjko7U3Uhgt9iQ3S3TevXs/zGJ
         HfSz5TwZS/O3kB28S+SLovA8OfHlM/rWWOJFv+IoJwJH05+gtytdHcVQ8X4KB5KNx4
         70tyK7f7YTAXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([87.78.41.149]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mzyya-1qE7Js3YIA-00x1DS; Fri, 28
 Apr 2023 21:02:34 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v8 0/2] Nuvoton WPCM450 clock and reset driver
Date:   Fri, 28 Apr 2023 21:02:24 +0200
Message-Id: <20230428190226.1304326-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wZTKlMlvr8MURaloy/YrVGLiLLZde8R5/fNsaUu9vm9S0L/O5Lo
 TWvjUFoxXbdneU/gfEioYGwkhrcBE39X2xRHtThROq5sjsoc98PqlfZCnPcYhTKPMUveSdA
 BZIduuv40QXtWWbQpDiVnVqnIExZzWmoIgu8oMScvX5v76dQNllRuZyL6cNegGJrXLvIsjI
 Hz00laEJ15UrvkwcKinVw==
UI-OutboundReport: notjunk:1;M01:P0:hK/VS9yiUgg=;bXepyBgIkaLm4FvnsH2jSDzoNYo
 w7h+kaFOnKAFRI5yZVrczC8qfOVrfUcI0o1JhwH0UfoZNA60e8u63qJhldz8mnJpRtQub0IBe
 H2ajjZXGYSazTy18shkdIrZWVEQ8x83YEGZHW/tORAqKIAQE7dMBLdpnPZWij+/IndI1Zc8B4
 dxWE8sQFz0KQjBuMVg+ZsLZJ+zDL7bdDZZk+gkcLNk3vzHVorA0/SAB5T3PKSFQlUf4YBZ7i7
 BOnj0LRvSTlBnT5qJ6btIlbEiMrLRBXvqU1ROv2sgR2R/DukQK0vQ8YJBW+bl4h5jvOQb4TnI
 XRHqrnMeBeYusFpiaij+MQNxPyViDqxFagmjqFBP+/7F8hKqFv0850GNXZWUhiKNCiWPpi4z8
 s/EQ0pklmMs86xj3ne+rGHRImDP4iQ3A+dFjwwrK59QLBZjFJBCMmdTG2S/cDzNS9cEL6hqVi
 rNhO6tdQPOcf1wYWxUiEbL8svYQmnIQHJQuZLARemNlFQrlSh6jxmAo8EB4cVUdh5aCpQ07RV
 SZRMgBytx2UlsXS1tC/otvqgHSf1595eS9SntJxf0Pi/QbKOSBzIzx/YsZVWVSM/5ZZx10Qi0
 6pw1fDkfRtzpEE4GzR4MEMOJ/vb83aLDVjOphMIPFtx6yisKnvRe6iGNQt11saT97kgrO7edm
 6E2AWvKsKiCb3ZUAao30/S33t1El8w+7upUoqlfeKv0b9M+Avy2Dfep3wuaVs1nFVFDSJN7AA
 KJ5Sgd5Et4RdmnmxCiUIdtOwDoD+YFI/Lgft6sWC/gZpxt+0MXkRwproXmnR+RsUaKlaVCyIb
 vS5rGI7fWdv9XRaV9C5UNDQR3HPjuPj2maJcK/9ejOXlhwLAsr2Lz8O1W4Jir0NmeUiflPRFa
 q5F8QdMgdztYg9ROW6BztI+vw5tnq+W34CB8KGxnOX8mDrAypfGSYnbMAMrkFcCfkc8XCT45i
 JjRs6MpNsi3aTqub4MY1Z+BZCQ0=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the clock and reset controller in the Nuvoton
WPCM450 SoC. This means that the clock rates for peripherals will be calcu=
lated
automatically based on the clock tree as it was preconfigured by the bootl=
oader.
The 24 MHz dummy clock, that is currently in the devicetree, is no longer =
needed.
Somewhat unfortunately, this also means that there is a breaking change on=
ce
the devicetree starts relying on the clock driver, but I find it acceptabl=
e in
this case, because WPCM450 is still at a somewhat early stage.

v8:
- Use %pe throughout the driver

v7:
- Simplified the error handling, by largely removing resource
  deallocation, which:
  - was already incomplete
  - would only happen in a case when the system is in pretty bad state
    because the clock driver didn't initialize correctly (in other
    words, the clock driver isn't optional enough that complex error
    handling really pays off)

v6:
- Dropped all patches except the clock binding and the clock driver, becau=
se
  they have mostly been merged
- Minor correction to how RESET_SIMPLE is selected

v5:
- Dropped patch 2 (watchdog: npcm: Enable clock if provided), which
  was since merged upstream
- Added patch 2 (clocksource: timer-npcm7xx: Enable timer 1 clock before u=
se) again,
  because I wasn't able to find it in linux-next
- Switched the driver to using struct clk_parent_data
- Rebased on 6.1-rc3

v4:
- Leave WDT clock running during after restart handler
- Fix reset controller initialization
- Dropped patch 2/7 (clocksource: timer-npcm7xx: Enable timer 1 clock befo=
re use),
  as it was applied by Daniel Lezcano

v3:
- https://lore.kernel.org/lkml/20220508194333.2170161-1-j.neuschaefer@gmx.=
net/
- Changed "refclk" string to "ref"
- Fixed some dead code in the driver
- Added clk_prepare_enable call to the watchdog restart handler
- Added a few review tags

v2:
- https://lore.kernel.org/lkml/20220429172030.398011-1-j.neuschaefer@gmx.n=
et/
- various small improvements

v1:
- https://lore.kernel.org/lkml/20220422183012.444674-1-j.neuschaefer@gmx.n=
et/

Jonathan Neusch=C3=A4fer (2):
  dt-bindings: clock: Add Nuvoton WPCM450 clock/reset controller
  clk: wpcm450: Add Nuvoton WPCM450 clock/reset controller driver

 .../bindings/clock/nuvoton,wpcm450-clk.yaml   |  66 ++++
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-wpcm450.c                     | 374 ++++++++++++++++++
 drivers/reset/Kconfig                         |   2 +-
 .../dt-bindings/clock/nuvoton,wpcm450-clk.h   |  67 ++++
 5 files changed, 509 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,wpcm45=
0-clk.yaml
 create mode 100644 drivers/clk/clk-wpcm450.c
 create mode 100644 include/dt-bindings/clock/nuvoton,wpcm450-clk.h

=2D-
2.39.2

