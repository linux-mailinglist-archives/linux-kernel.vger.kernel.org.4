Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DE77406A0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 00:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjF0Wsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 18:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjF0Wsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 18:48:32 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE1826AC;
        Tue, 27 Jun 2023 15:48:27 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b809354a15so16469685ad.1;
        Tue, 27 Jun 2023 15:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687906107; x=1690498107;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zco4ymyQaxN940qvnqvODVRApdG4nPle7qVt8obDEBo=;
        b=cvelLnVBOyKIQVaK9aBtBKrbZtWYUg0zbPHR6F5GEoZku+4SlZkWxhKQhVEmd82lgd
         +ctFvfyAMVZYDyDkZY1fNeLVXTXPgKinO53pRZjArcK4DUt1Bj6nUfs1I20+vSap94xJ
         KitKcisVqXJrSbm0neWRiS/RctmFGB+cMnuC4Y949FhLXd2GQnEHEQq2PHGZH6K/+TDq
         hRS2JqTwcPWIYJ0p6l8MxvA3W29GLYd7oYpw1SuiLpU/ymOFpyUAlTuTsyPtV+rniz0O
         cCLI6auE/HNRgUwrxqd/bvddYvQjm0y5InhnFJiqAWXAB+H18i5vKa1DJRqDAwKnS7Sh
         zUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687906107; x=1690498107;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zco4ymyQaxN940qvnqvODVRApdG4nPle7qVt8obDEBo=;
        b=PNUZ+j1jGd9i6iGwBK0SjaDn1+NbaQ8sYGVzvrFXQraT13PEjaUm3GDoPnnmBkSoEy
         3yMR94icZuqMbBVSbygGzrsn+nDAeYTNZeCBQdKNdp+HsNoLkIYpcehz0CkKKQ0sc/sB
         UJsQKqwDVxHA5ACx481PC5bt2PpWQvDPU8UjqG+SO4KZkltWusolBnt1MwSBJd4JORpH
         UJD/g/kwNBxvETFlG+gY6v5Sr7yrNiA86Ahed1N8ZvoM9tNFgOB7ifUemez+34IMX05Q
         MImyL6ItWIVaCh4KEmfpC93Tt6FZzgqLGSSn83IpwODsA0XKYj/CYkmuuou67SeWGINK
         nnfg==
X-Gm-Message-State: AC+VfDy/sBUOdHONjCnzZgevrSpDdlvzrhpQSI8KqaNdjm1xrzbd7Uzq
        2oAA9J4EKNexhDLKJIcy670=
X-Google-Smtp-Source: ACHHUZ6vxRZcDUNdOb5isFoxptG1Yg612ksL6PjTxvXVjzlWKYfQo3unhlUXDbSI7XERdwSBkqSrLw==
X-Received: by 2002:a17:902:d683:b0:1b7:eebc:884 with SMTP id v3-20020a170902d68300b001b7eebc0884mr5833519ply.64.1687906106706;
        Tue, 27 Jun 2023 15:48:26 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:eb71:7977:cb6e:6d32])
        by smtp.gmail.com with ESMTPSA id x3-20020a1709027c0300b001ae5d21f760sm6420527pll.146.2023.06.27.15.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 15:48:26 -0700 (PDT)
Date:   Tue, 27 Jun 2023 15:48:23 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v6.5-rc0
Message-ID: <ZJtnNxQjJ2yrpwIV@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.5-rc0

to receive updates for the input subsystem. You will get:

- improvements to PS/2 handling for case when EC has already latched a
  scancode in the data register, but the kernel expects to receive an ACK
  to a command it sent to a device (such as keyboard LED toggle)
- input drivers for devices connected over I2C bus have been switched back
  to using [new] .probe()
- uinput allows userspace to inject timestamps for input events
- support for capacitive keys in Atmel touch controller driver
- assorted fixes to drv260x, pwm-vibra, ili210x, adxl34x, and other
  drivers.

Changelog:
---------

André Apitzsch (2):
      dt-bindings: input: atmel,maxtouch: add linux,keycodes
      Input: atmel_mxt_ts - support capacitive keys

Biswarup Pal (1):
      Input: uinput - allow injecting event times

Caleb Connolly (2):
      MAINTAINERS: Adjust Qualcomm driver globbing
      Input: pm8941-powerkey - fix debounce on gen2+ PMICs

Dana Elfassy (1):
      Input: tests - add test to cover all input_grab_device() function

Dmitry Torokhov (10):
      Input: avoid calling input_set_abs_val() in the event handling core
      Input: tests - fix input_test_match_device_id test
      Input: libps2 - attach ps2dev instances as serio port's drvdata
      Input: libps2 - remove special handling of ACK for command byte
      Input: libps2 - rework handling of command response
      Input: libps2 - fix NAK handling
      Input: libps2 - fix aborting PS/2 commands
      Input: libps2 - introduce common interrupt handler
      Input: libps2 - do not discard non-ack bytes when controlling LEDs
      Input: gameport - provide default trigger() and read()

Duoming Zhou (1):
      Input: cyttsp4_core - change del_timer_sync() to timer_shutdown_sync()

Geert Uytterhoeven (3):
      Input: tests - fix use-after-free and refcount underflow in input_test_exit()
      Input: tests - modular KUnit tests should not depend on KUNIT=y
      Input: gpio-keys - use input_report_key()

Ismael Ferreras Morezuelas (1):
      Input: xpad - spelling fixes for "Xbox"

Krzysztof Kozlowski (1):
      dt-bindings: input: cypress,cyapa: convert to dtschema

Luca Weiss (7):
      Input: drv260x - fix typo in register value define
      Input: drv260x - sleep between polling GO bit
      Input: drv260x - remove unused .reg_defaults
      Input: drv260x - fix magnitude handling
      dt-bindings: input: pwm-vibrator: Add enable-gpio
      Input: pwm-vibra - add newline to dev_err prints
      Input: pwm-vibra - add support for enable GPIO

Marek Vasut (2):
      Input: ili210x - probe even if no resolution information
      Input: adxl34x - do not hardcode interrupt trigger type

Maximilian Weigand (3):
      Input: cyttsp5 - remove unused code
      dt-bindings: input: cypress,tt21000 - add wakeup-source entry to documentation
      Input: cyttsp5 - implement proper sleep and wakeup procedures

Michał Mirosław (1):
      Input: i8042 - add missing include

Niklas Schnelle (1):
      Input: add HAS_IOPORT dependencies

Philipp Puschmann (1):
      Input: edt-ft5x06 - add delay after waking up

Uwe Kleine-König (3):
      Input: Switch i2c drivers back to use .probe()
      Input: tps65219-pwrbutton - convert to .remove_new()
      Input: tps65219-pwrbutton - use regmap_set_bits()

Diffstat:
--------

 .../devicetree/bindings/input/atmel,maxtouch.yaml  |   7 +
 .../devicetree/bindings/input/cypress,cyapa.txt    |  42 ---
 .../devicetree/bindings/input/cypress,cyapa.yaml   |  49 ++++
 .../devicetree/bindings/input/pwm-vibrator.yaml    |   2 +
 .../input/touchscreen/cypress,tt21000.yaml         |   2 +
 Documentation/input/devices/xpad.rst               |  10 +-
 Documentation/input/gamepad.rst                    |   2 +-
 MAINTAINERS                                        |   2 +-
 drivers/input/Kconfig                              |   2 +-
 drivers/input/gameport/gameport.c                  |  18 +-
 drivers/input/input.c                              |   6 +-
 drivers/input/joystick/Kconfig                     |  14 +-
 drivers/input/joystick/as5011.c                    |   2 +-
 drivers/input/joystick/qwiic-joystick.c            |   2 +-
 drivers/input/joystick/xpad.c                      |  64 ++---
 drivers/input/keyboard/adp5588-keys.c              |   2 +-
 drivers/input/keyboard/adp5589-keys.c              |   2 +-
 drivers/input/keyboard/atkbd.c                     | 102 ++++---
 drivers/input/keyboard/cap11xx.c                   |   2 +-
 drivers/input/keyboard/cypress-sf.c                |   2 +-
 drivers/input/keyboard/dlink-dir685-touchkeys.c    |   2 +-
 drivers/input/keyboard/gpio_keys.c                 |   6 +-
 drivers/input/keyboard/lm8323.c                    |   2 +-
 drivers/input/keyboard/lm8333.c                    |   2 +-
 drivers/input/keyboard/max7359_keypad.c            |   2 +-
 drivers/input/keyboard/mcs_touchkey.c              |   2 +-
 drivers/input/keyboard/mpr121_touchkey.c           |   2 +-
 drivers/input/keyboard/pinephone-keyboard.c        |   2 +-
 drivers/input/keyboard/qt1050.c                    |   2 +-
 drivers/input/keyboard/qt1070.c                    |   2 +-
 drivers/input/keyboard/qt2160.c                    |   2 +-
 drivers/input/keyboard/tca6416-keypad.c            |   2 +-
 drivers/input/keyboard/tca8418_keypad.c            |   2 +-
 drivers/input/keyboard/tm2-touchkey.c              |   2 +-
 drivers/input/misc/ad714x-i2c.c                    |   2 +-
 drivers/input/misc/adxl34x-i2c.c                   |   2 +-
 drivers/input/misc/adxl34x.c                       |   3 +-
 drivers/input/misc/apanel.c                        |   2 +-
 drivers/input/misc/atmel_captouch.c                |   2 +-
 drivers/input/misc/bma150.c                        |   2 +-
 drivers/input/misc/cma3000_d0x_i2c.c               |   2 +-
 drivers/input/misc/da7280.c                        |   2 +-
 drivers/input/misc/drv260x.c                       |  58 +---
 drivers/input/misc/drv2665.c                       |   2 +-
 drivers/input/misc/drv2667.c                       |   2 +-
 drivers/input/misc/ibm-panel.c                     |   2 +-
 drivers/input/misc/iqs269a.c                       |   2 +-
 drivers/input/misc/iqs626a.c                       |   2 +-
 drivers/input/misc/iqs7222.c                       |   2 +-
 drivers/input/misc/kxtj9.c                         |   2 +-
 drivers/input/misc/mma8450.c                       |   2 +-
 drivers/input/misc/pcf8574_keypad.c                |   2 +-
 drivers/input/misc/pm8941-pwrkey.c                 |  19 +-
 drivers/input/misc/pwm-vibra.c                     |  36 ++-
 drivers/input/misc/tps65219-pwrbutton.c            |  12 +-
 drivers/input/misc/uinput.c                        |  34 +++
 drivers/input/mouse/cyapa.c                        |   2 +-
 drivers/input/mouse/elan_i2c_core.c                |   2 +-
 drivers/input/mouse/psmouse-base.c                 |  86 +++---
 drivers/input/mouse/psmouse.h                      |   2 +
 drivers/input/mouse/synaptics.c                    |  10 +-
 drivers/input/mouse/synaptics_i2c.c                |   2 +-
 drivers/input/mouse/trackpoint.c                   |   2 +-
 drivers/input/rmi4/rmi_i2c.c                       |   2 +-
 drivers/input/rmi4/rmi_smbus.c                     |   2 +-
 drivers/input/serio/Kconfig                        |   1 +
 drivers/input/serio/libps2.c                       | 293 +++++++++++++++------
 drivers/input/tests/input_test.c                   |  38 ++-
 drivers/input/touchscreen/Kconfig                  |   1 +
 drivers/input/touchscreen/ad7879-i2c.c             |   2 +-
 drivers/input/touchscreen/ar1021_i2c.c             |   2 +-
 drivers/input/touchscreen/atmel_mxt_ts.c           |  87 +++++-
 drivers/input/touchscreen/auo-pixcir-ts.c          |   2 +-
 drivers/input/touchscreen/bu21013_ts.c             |   2 +-
 drivers/input/touchscreen/bu21029_ts.c             |   2 +-
 drivers/input/touchscreen/chipone_icn8318.c        |   2 +-
 drivers/input/touchscreen/chipone_icn8505.c        |   2 +-
 drivers/input/touchscreen/cy8ctma140.c             |   2 +-
 drivers/input/touchscreen/cy8ctmg110_ts.c          |   2 +-
 drivers/input/touchscreen/cyttsp4_core.c           |   3 +-
 drivers/input/touchscreen/cyttsp4_i2c.c            |   2 +-
 drivers/input/touchscreen/cyttsp5.c                |  84 +++++-
 drivers/input/touchscreen/cyttsp_i2c.c             |   2 +-
 drivers/input/touchscreen/edt-ft5x06.c             |   3 +-
 drivers/input/touchscreen/eeti_ts.c                |   2 +-
 drivers/input/touchscreen/egalax_ts.c              |   2 +-
 drivers/input/touchscreen/ektf2127.c               |   2 +-
 drivers/input/touchscreen/elants_i2c.c             |   2 +-
 drivers/input/touchscreen/exc3000.c                |   2 +-
 drivers/input/touchscreen/goodix.c                 |   2 +-
 drivers/input/touchscreen/hideep.c                 |   2 +-
 drivers/input/touchscreen/himax_hx83112b.c         |   2 +-
 drivers/input/touchscreen/hycon-hy46xx.c           |   2 +-
 drivers/input/touchscreen/hynitron_cstxxx.c        |   2 +-
 drivers/input/touchscreen/ili210x.c                |  38 ++-
 drivers/input/touchscreen/ilitek_ts_i2c.c          |   2 +-
 drivers/input/touchscreen/imagis.c                 |   2 +-
 drivers/input/touchscreen/iqs5xx.c                 |   2 +-
 drivers/input/touchscreen/max11801_ts.c            |   2 +-
 drivers/input/touchscreen/mcs5000_ts.c             |   2 +-
 drivers/input/touchscreen/melfas_mip4.c            |   2 +-
 drivers/input/touchscreen/migor_ts.c               |   2 +-
 drivers/input/touchscreen/mms114.c                 |   2 +-
 drivers/input/touchscreen/msg2638.c                |   2 +-
 drivers/input/touchscreen/novatek-nvt-ts.c         |   2 +-
 drivers/input/touchscreen/pixcir_i2c_ts.c          |   2 +-
 drivers/input/touchscreen/raydium_i2c_ts.c         |   2 +-
 drivers/input/touchscreen/rohm_bu21023.c           |   2 +-
 drivers/input/touchscreen/s6sy761.c                |   2 +-
 drivers/input/touchscreen/silead.c                 |   2 +-
 drivers/input/touchscreen/sis_i2c.c                |   2 +-
 drivers/input/touchscreen/st1232.c                 |   2 +-
 drivers/input/touchscreen/stmfts.c                 |   2 +-
 drivers/input/touchscreen/sx8654.c                 |   2 +-
 drivers/input/touchscreen/tsc2004.c                |   2 +-
 drivers/input/touchscreen/tsc2007_core.c           |   2 +-
 drivers/input/touchscreen/wacom_i2c.c              |   2 +-
 drivers/input/touchscreen/wdt87xx_i2c.c            |   2 +-
 drivers/input/touchscreen/zet6223.c                |   2 +-
 drivers/input/touchscreen/zforce_ts.c              |   2 +-
 drivers/input/touchscreen/zinitix.c                |   2 +-
 include/linux/gameport.h                           |  11 +-
 include/linux/i8042.h                              |   1 +
 include/linux/libps2.h                             |  62 +++--
 124 files changed, 901 insertions(+), 485 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/cypress,cyapa.txt
 create mode 100644 Documentation/devicetree/bindings/input/cypress,cyapa.yaml

Thanks.


-- 
Dmitry
