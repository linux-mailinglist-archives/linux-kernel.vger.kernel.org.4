Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3544469F1FA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjBVJkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjBVJjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:39:35 -0500
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF863C78B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:36:43 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id j2so6858108wrh.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ur7NODyMI3yB9K4FVWy3kzrmoIy3eUHtEG1RhKVZclw=;
        b=1442mxYyQeE4//14AHVDAYvVFdXdqTPssK0Ew/khTqcVW/tcGeJbf+Ctyk9Qd5dKDB
         5rMTvbvy5je4ti6owmSLq4vGvqKdOBP0co6M/ao6fPeJBqxWj9TgYa2BcsMthZm8ano4
         3iDyFepLYvmnWqaIDga9+inSOyH5mTKzju+VPHBMxheY/STJ2FmyyD/frdLc7k6BRSHY
         z/iTU2j5OcOR6vhXqUYZDXjF8/+9MHpxlBEChQiMX0LXu/KPOCDqU61aWTWAnwdJVOuJ
         1GxE5aoDa4lFtubTKP2GiTvrZbl+6/Kx4f7ccZWujcfF786GbIbr61zCyDGou4R2KQjM
         yfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ur7NODyMI3yB9K4FVWy3kzrmoIy3eUHtEG1RhKVZclw=;
        b=UzF5qvZrcCVX1uT3bGWHOa1oVaUQab1iyBKKNJOM+FxB7o94UgpYomHYpK4ybJlqXM
         s+wkU1OjemxETzExyBM0SofALZOJKoS2M3A7xjimTvUV2jeIVGlAHyOyREqE+Brlw0A1
         ZD37REY4wbUJ8i+sWxQH/PB2hqqmu88xao5/6H9viKHXolqPIFV4fIf4NHh3zaamF+Yz
         Lu7TnYCSb2QyUKTXDZcjC6KnJif0gj4QROjzCF2cbmR0XB391K0+Njq2Of83p7b8jX6Z
         XvsQ1+Kq5EomB0vzHDHvSvrUQMg6QHTySuNGYa0acxdSo4+VviKUpF5xrUhWRUXCPttY
         kREw==
X-Gm-Message-State: AO0yUKV447196tBZP7dWxr1ZJgdy4SeSXS9S3hFphVj+Y3Q8jYht8aq1
        Q5opF6fGVCKtUArciFdbQCn30w==
X-Google-Smtp-Source: AK7set8kF9ZiaY0v8kv/5rO1iVgr+LaSptPAdC2yjaMn9jP6jE7oI4bR6AgMW03MBmLjfppxHPO4dA==
X-Received: by 2002:a05:6000:61e:b0:2c5:5916:e902 with SMTP id bn30-20020a056000061e00b002c55916e902mr6985386wrb.17.1677058200465;
        Wed, 22 Feb 2023 01:30:00 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:35a:84fc:b1c8:d833])
        by smtp.gmail.com with ESMTPSA id o18-20020a5d4752000000b002c3f9404c45sm5706761wrs.7.2023.02.22.01.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 01:30:00 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: updates for v6.3
Date:   Wed, 22 Feb 2023 10:29:58 +0100
Message-Id: <20230222092958.18493-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Here are the GPIO updates for this release cycle. It's a rather small one,
there are no new drivers, just improvements and refactoring in existing ones.
Thanks to migrating of several drivers to using generalized APIs and dropping
of OF interfaces in favor of using software nodes we're actually removing more
code than we're adding.

Details are in the signed tag and everything has been in next for at least two
weeks (most much more than that).

Please pull,
Bartosz

The following changes since commit 6d796c50f84ca79f1722bb131799e5a5710c4700:

  Linux 6.2-rc6 (2023-01-29 13:59:43 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v6.3

for you to fetch changes up to 4827aae061337251bb91801b316157a78b845ec7:

  gpio: sim: Use %pfwP specifier instead of calling fwnode API directly (2023-02-13 14:48:35 +0100)

----------------------------------------------------------------
gpio updates for v6.3

Core GPIOLIB:
- drop several OF interfaces after moving a significant part of the code to
  using software nodes
- remove more interfaces referring to the global GPIO numberspace that we're
  getting rid of
- improvements in the gpio-regmap library
- add helper for GPIO device reference counting
- remove unused APIs
- minor tweaks like sorting headers alphabetically

Extended support in existing drivers:
- add support for Tegra 234 PMC to gpio-tegra186

Driver improvements:
- migrate the 104-dio/idi family of drivers to using the regmap-irq API
- migrate gpio-i8255 and gpio-mm to the GPIO regmap API
- clean-ups in gpio-pca953x
- remove duplicate assignments of of_gpio_n_cells in gpio-davinci, gpio-ge,
  gpio-xilinx, gpio-zevio and gpio-wcd934x
- improvements to gpio-pcf857x: implement get/set_multiple callbacks, use
  generic device properties instead of OF + minor tweaks
- fix OF-related header includes and Kconfig dependencies in gpio-zevio
- dynamically allocate the GPIO base in gpio-omap
- use a dedicated printf specifier for printing fwnode info in gpio-sim
- use dev_name() for the GPIO chip label in gpio-vf610
- other minor tweaks and fixes

Documentation:
- remove mentions of legacy API from comments in various places
- convert the DT binding documents to YAML schema for Fujitsu MB86S7x, Unisoc
  GPIO and Unisoc EIC
- document the Unisoc UMS512 controller in DT bindings

----------------------------------------------------------------
Andreas Kemnade (1):
      gpio: omap: use dynamic allocation of base

Andy Shevchenko (23):
      gpio: pca953x: Clean up pcal6534_check_register()
      gpio: pca953x: Remove unused PCAL953X_OUT_CONF from pcal6534_recalc_addr()
      gpio: Remove unused and obsoleted gpio_export_link()
      gpiolib: Introduce gpio_device_get() and gpio_device_put()
      gpiolib: Get rid of not used of_node member
      gpiolib: sort header inclusion alphabetically
      gpiolib: Do not mention legacy API in the code
      gpiolib: Remove unused of_mm_gpiochip_add()
      gpio: davinci: Do not mention legacy API in the code
      gpio: Remove unused and obsoleted irq_to_gpio()
      gpio: davinci: Remove duplicate assignment of of_gpio_n_cells
      gpio: ge: Remove duplicate assignment of of_gpio_n_cells
      gpio: xilinx: Remove duplicate assignment of of_gpio_n_cells
      gpio: zevio: Remove duplicate assignment of of_gpio_n_cells
      gpio: zevio: Use proper headers and drop OF_GPIO dependency
      gpio: wcd934x: Remove duplicate assignment of of_gpio_n_cells
      gpio: rockchip: Do not mention legacy API in the code
      gpio: pcf857x: Get rid of legacy platform data
      gpio: pcf857x: Make use of device properties
      gpio: pcf857x: Drop unneeded explicit casting
      gpio: zevio: Add missing header
      gpiolib: of: Move enum of_gpio_flags to its only user
      gpio: sim: Use %pfwP specifier instead of calling fwnode API directly

Bartosz Golaszewski (1):
      gpio: pca9570: rename platform_data to chip_data

Chunyan Zhang (3):
      dt-bindings: gpio: Convert Unisoc GPIO controller binding to yaml
      dt-bindings: gpio: Convert Unisoc EIC controller binding to yaml
      dt-bindings: gpio: Add compatible string for Unisoc UMS512

Dmitry Torokhov (5):
      gpiolib: of: remove of_gpio_count()
      gpiolib: of: stop exporting of_gpio_named_count()
      gpiolib: of: remove obsolete comment for of_gpio_get_count()
      gpiolib: of: remove of_get_gpio[_flags]() and of_get_named_gpio_flags()
      gpiolib: of: remove [devm_]gpiod_get_from_of_node() APIs

Haibo Chen (2):
      gpio: pca953x: avoid logically dead code
      gpio: vf610: connect GPIO label to dev name

Johan Hovold (1):
      gpiolib: use irq_domain_alloc_irqs()

Linus Walleij (1):
      gpio: Get rid of gpio_to_chip()

Michael Walle (1):
      gpio: regmap: use new regmap_might_sleep()

Prathamesh Shete (1):
      gpio: tegra186: add Tegra234 PMC compatible in GPIO driver

Radu Rendec (3):
      gpio: pcf857x: Replace 'unsigned' with 'unsigned int'
      gpio: pcf857x: Fix indentation of variable declarations
      gpio: pcf857x: Implement get_multiple/set_multiple methods

Rob Herring (1):
      dt-bindings: gpio: Convert Fujitsu MB86S7x GPIO to DT schema

Tom Rix (1):
      gpio: tegra186: remove unneeded loop in tegra186_gpio_init_route_mapping()

Uwe Kleine-König (2):
      gpio: msc313: Drop empty platform remove function
      gpio: mvebu: Use IS_REACHABLE instead of IS_ENABLED for CONFIG_PWM

William Breathitt Gray (8):
      gpio: regmap: Always set gpio_chip get_direction
      gpio: 104-dio-48e: Migrate to the regmap-irq API
      gpio: 104-idi-48: Migrate to the regmap-irq API
      gpio: 104-idi-48: Migrate to gpio-regmap API
      gpio: i8255: Migrate to gpio-regmap API
      gpio: 104-dio-48e: Migrate to regmap API
      gpio: gpio-mm: Migrate to regmap API
      gpio: i8255: Remove unused legacy interface

 .../bindings/gpio/fujitsu,mb86s70-gpio.txt         |  20 --
 .../bindings/gpio/fujitsu,mb86s70-gpio.yaml        |  50 +++
 .../devicetree/bindings/gpio/gpio-eic-sprd.txt     |  97 -----
 .../devicetree/bindings/gpio/gpio-sprd.txt         |  28 --
 .../devicetree/bindings/gpio/sprd,gpio-eic.yaml    | 124 +++++++
 .../devicetree/bindings/gpio/sprd,gpio.yaml        |  75 ++++
 Documentation/driver-api/gpio/legacy.rst           |  17 -
 .../translations/zh_CN/driver-api/gpio/legacy.rst  |  15 -
 Documentation/translations/zh_TW/gpio.txt          |  16 -
 arch/m68k/include/asm/gpio.h                       |   7 -
 arch/sh/include/asm/gpio.h                         |   5 -
 drivers/gpio/Kconfig                               |  10 +-
 drivers/gpio/TODO                                  |   4 +-
 drivers/gpio/gpio-104-dio-48e.c                    | 398 +++++++--------------
 drivers/gpio/gpio-104-idi-48.c                     | 336 ++++++-----------
 drivers/gpio/gpio-davinci.c                        |   3 +-
 drivers/gpio/gpio-ge.c                             |   1 -
 drivers/gpio/gpio-gpio-mm.c                        | 154 ++------
 drivers/gpio/gpio-i8255.c                          | 320 +++++------------
 drivers/gpio/gpio-i8255.h                          |  54 ++-
 drivers/gpio/gpio-msc313.c                         |   6 -
 drivers/gpio/gpio-mvebu.c                          |   6 +-
 drivers/gpio/gpio-omap.c                           |   2 +-
 drivers/gpio/gpio-pca953x.c                        |  34 +-
 drivers/gpio/gpio-pca9570.c                        |  24 +-
 drivers/gpio/gpio-pcf857x.c                        | 118 +++---
 drivers/gpio/gpio-regmap.c                         |  17 +-
 drivers/gpio/gpio-rockchip.c                       |   2 +-
 drivers/gpio/gpio-sim.c                            |   9 +-
 drivers/gpio/gpio-tegra186.c                       |  41 +--
 drivers/gpio/gpio-vf610.c                          |   2 +-
 drivers/gpio/gpio-wcd934x.c                        |   1 -
 drivers/gpio/gpio-xilinx.c                         |  11 -
 drivers/gpio/gpio-zevio.c                          |   9 +-
 drivers/gpio/gpiolib-acpi.c                        |  10 -
 drivers/gpio/gpiolib-acpi.h                        |   4 -
 drivers/gpio/gpiolib-cdev.c                        |  21 +-
 drivers/gpio/gpiolib-devres.c                      |  55 ---
 drivers/gpio/gpiolib-of.c                          | 135 +++----
 drivers/gpio/gpiolib-of.h                          |   5 -
 drivers/gpio/gpiolib.c                             |  70 ++--
 drivers/gpio/gpiolib.h                             |  10 +
 drivers/pinctrl/core.c                             |  14 +-
 include/asm-generic/gpio.h                         |  12 -
 include/linux/gpio.h                               |  20 --
 include/linux/gpio/consumer.h                      |  48 ---
 include/linux/gpio/driver.h                        |   9 +-
 include/linux/of_gpio.h                            | 102 +-----
 include/linux/platform_data/pcf857x.h              |  45 ---
 49 files changed, 886 insertions(+), 1690 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/fujitsu,mb86s70-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/fujitsu,mb86s70-gpio.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-sprd.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
 create mode 100644 Documentation/devicetree/bindings/gpio/sprd,gpio.yaml
 delete mode 100644 include/linux/platform_data/pcf857x.h
