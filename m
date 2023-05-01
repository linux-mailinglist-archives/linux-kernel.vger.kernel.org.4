Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B4C6F3B06
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 01:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjEAXYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 19:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjEAXYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 19:24:21 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAC930D6;
        Mon,  1 May 2023 16:24:19 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b5ce4f069so3672886b3a.1;
        Mon, 01 May 2023 16:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682983459; x=1685575459;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37wjJ+t9Peo7GlT5iWpqp5Yq+wn31hxx/6euJ04tpws=;
        b=AxutNgviCJ7rZlbiih9yaqFeMnMS3VoIDDa/DbH6GHGFO2lJOdGNv4mO2Luacdr82D
         5D/8hrDaY2ydnZFJpK86svHSpzZTlrK60VNbwVB7DpVVwUtdQg1pO5ODrxRcyykl2fxi
         5vsMAP0df0SwRPmxWC3SegtqbGbtGBVnr8lrAPzuH9V2BbnNE3SRBe2JPERgEbHQVxTP
         LHyD6KrB/LJRzbg91xNpN9BkXf882+muJlwwGAlnnmVtkqBJP1mqZQQP/iPsXxOmql5P
         jKQ3Y5gDqEBecpfc2nNPpDbl9c5ekQwsH6GSItDKguKg31vuP70kYLhycPiywd2L15SN
         FBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682983459; x=1685575459;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37wjJ+t9Peo7GlT5iWpqp5Yq+wn31hxx/6euJ04tpws=;
        b=XCCsEXms0Q7snEKVGsffAA7N1CJYMf/uDxiP5xDKuhBGXhKjt8vq2Xo0E8cqJu8lja
         FdwduyxEfZz/dz3Bd76GQVTSaKv0+gOh35jBDEg1GsAf2j8+EAcmEIYYKVxbwMm/rMnh
         abjVTumz+6XoktgPAPFVpm2OnxBmTpB8E5AhoIzPpAIkr+shgWonj3DXbpXcfpGsMegO
         8Y/1EeSBfB2MdA2wYKcs8m6823+7Ais+5A6i1pP31Dc/o4Yhcjwi6bzlhXHTWx8DFs5w
         pmlEKoBXfEjMcapXhlW0neRjkqahc2ECvzRQyN6KZ7xiL3QycrBdKoB+A5UzsnsekuZF
         gHVQ==
X-Gm-Message-State: AC+VfDxtai0xLj5Gfaz8/GkTyzpNtgq/238oy/NK6uJmrMQmanbjAvcu
        6TWl8wnnr2ZiDFfOd3+Z4jTgQTStIek=
X-Google-Smtp-Source: ACHHUZ6fYtvZlMnpZ/WC0uPwhXizEpmZFapVFHWWmwErLSw03skFI6AyDE/xlX+4IKu+1/fcKLPK9g==
X-Received: by 2002:a05:6a00:2490:b0:63f:7663:3a3a with SMTP id c16-20020a056a00249000b0063f76633a3amr22167711pfv.32.1682983459236;
        Mon, 01 May 2023 16:24:19 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b6ce:736b:e4f7:adb])
        by smtp.gmail.com with ESMTPSA id w22-20020a63f516000000b0052873a7cecesm148102pgh.0.2023.05.01.16.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 16:24:18 -0700 (PDT)
Date:   Mon, 1 May 2023 16:24:15 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v6.4-rc0
Message-ID: <ZFBKHyTky9YhQv+s@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.4-rc0

to receive updates for the input subsystem. You will get:

- a new driver for Novatek touch controllers
- a new driver for power button for NXP BBNSM
- a skeleton KUnit tests for the input core
- improvements to Xpad game controller driver to support more devices
- improvements to edt-ft5x06, hideep and other drivers

Changelog:
---------

Andy Shevchenko (1):
      Input: matrix_keypad - replace header inclusions by forward declarations

Benjamin Bara (1):
      Input: tsc2007 - enable cansleep pendown GPIO

Daniel Golle (1):
      Input: edt-ft5x06 - select REGMAP_I2C

Dario Binacchi (9):
      Input: edt-ft5x06 - fix indentation
      Input: edt-ft5x06 - remove unnecessary blank lines
      Input: edt-ft5x06 - add spaces to ensure format specification
      Input: edt-ft5x06 - don't recalculate the CRC
      Input: edt-ft5x06 - remove code duplication
      Input: edt-ft5x06 - don't print error messages with dev_dbg()
      Input: edt-ft5x06 - convert to use regmap API
      Input: edt-ft5x06 - unify the crc check
      Input: edt-ft5x06 - calculate points data length only once

Dmitry Torokhov (2):
      ARM: spitz: include header defining input event codes
      Revert "Input: xpad - fix support for some third-party controllers"

Gergo Koteles (1):
      Input: gpio-keys - add support for linux,input-value DTS property

Hans de Goede (3):
      Input: hideep - silence error in SW_RESET()
      Input: hideep - optionally reset controller work mode to native HiDeep protocol
      Input: add a new Novatek NVT-ts driver

Jacky Bai (1):
      Input: bbnsm_pwrkey - add bbnsm power key support

Javier Martinez Canillas (1):
      Input: Add KUnit tests for some of the input core helper functions

Jiapeng Chong (2):
      Input: cma3000_d0x - remove unneeded code
      Input: synaptics-rmi4 - fix function name in kerneldoc

JungHoon Hyun (1):
      Input: melfas_mip4 - report palm touches

Krzysztof Kozlowski (4):
      Input: st-keyscan - drop of_match_ptr for ID table
      Input: tm2-touchkey - drop of_match_ptr for ID table
      Input: sun4i-ts - drop of_match_ptr for ID table
      Input: bcm_iproc_tsc - drop of_match_ptr for ID table

Linus Walleij (1):
      dt-bindings: google,cros-ec-keyb: Fix spelling error

Miaoqian Lin (1):
      Input: raspberrypi-ts - fix refcount leak in rpi_ts_probe

Peng Fan (1):
      dt-bindings: input: pwm-beeper: convert to dt schema

Pierre-Loup A. Griffais (1):
      Input: xpad - treat Qanba controllers as Xbox360 controllers

Randy Dunlap (1):
      Input: hp_sdc_rtc - mark an unused function as __maybe_unused

Rob Herring (3):
      Input: Use of_property_read_bool() for boolean properties
      Input: zinitix - use of_property_present() for testing DT property presence
      dt-bindings: input: Drop unneeded quotes

Uwe Kleine-König (1):
      Input: iqs62x-keys - suppress duplicated error message in .remove()

Vicki Pfau (5):
      Input: xpad - remove unused field in VID/PID table
      Input: xpad - add VID for Turtle Beach controllers
      Input: xpad - fix support for some third-party controllers
      Input: xpad - add constants for GIP interface numbers
      Input: xpad - fix PowerA EnWired Controller guide button

Yang Li (1):
      Input: hideep - clean up some inconsistent indenting

Diffstat:
--------

 .../bindings/input/google,cros-ec-keyb.yaml        |   2 +-
 .../devicetree/bindings/input/pwm-beeper.txt       |  24 -
 .../devicetree/bindings/input/pwm-beeper.yaml      |  41 ++
 MAINTAINERS                                        |   6 +
 arch/arm/mach-pxa/spitz.c                          |   1 +
 drivers/input/Kconfig                              |  10 +
 drivers/input/Makefile                             |   1 +
 drivers/input/joystick/xpad.c                      |  23 +-
 drivers/input/keyboard/gpio_keys.c                 |   3 +
 drivers/input/keyboard/iqs62x-keys.c               |   2 +-
 drivers/input/keyboard/matrix_keypad.c             |   6 +-
 drivers/input/keyboard/omap4-keypad.c              |   3 +-
 drivers/input/keyboard/samsung-keypad.c            |   3 +-
 drivers/input/keyboard/st-keyscan.c                |   2 +-
 drivers/input/keyboard/tegra-kbc.c                 |   3 +-
 drivers/input/keyboard/tm2-touchkey.c              |   2 +-
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/cma3000_d0x.c                   |   2 -
 drivers/input/misc/hp_sdc_rtc.c                    |   2 +-
 drivers/input/misc/nxp-bbnsm-pwrkey.c              | 193 ++++++++
 drivers/input/rmi4/rmi_bus.c                       |   2 +-
 drivers/input/tests/.kunitconfig                   |   3 +
 drivers/input/tests/Makefile                       |   3 +
 drivers/input/tests/input_test.c                   | 150 +++++++
 drivers/input/touchscreen/Kconfig                  |  11 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/bcm_iproc_tsc.c          |   2 +-
 drivers/input/touchscreen/edt-ft5x06.c             | 496 +++++++++++----------
 drivers/input/touchscreen/hideep.c                 |  33 +-
 drivers/input/touchscreen/melfas_mip4.c            |  19 +-
 drivers/input/touchscreen/novatek-nvt-ts.c         | 301 +++++++++++++
 drivers/input/touchscreen/raspberrypi-ts.c         |   3 +-
 drivers/input/touchscreen/sun4i-ts.c               |   2 +-
 drivers/input/touchscreen/tsc2007_core.c           |  17 +-
 drivers/input/touchscreen/zinitix.c                |   2 +-
 include/linux/input/matrix_keypad.h                |   5 +-
 37 files changed, 1067 insertions(+), 324 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.txt
 create mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.yaml
 create mode 100644 drivers/input/misc/nxp-bbnsm-pwrkey.c
 create mode 100644 drivers/input/tests/.kunitconfig
 create mode 100644 drivers/input/tests/Makefile
 create mode 100644 drivers/input/tests/input_test.c
 create mode 100644 drivers/input/touchscreen/novatek-nvt-ts.c

Thanks.


-- 
Dmitry
