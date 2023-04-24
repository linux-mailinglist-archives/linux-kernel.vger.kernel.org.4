Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962616ECEF6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjDXNgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjDXNgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:36:20 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7017EE3;
        Mon, 24 Apr 2023 06:36:04 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-24736790966so3860558a91.2;
        Mon, 24 Apr 2023 06:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682343363; x=1684935363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uVyU9gOwOxOSqHm/6VTLnN93/D/8YFXY62jIfDl6u3U=;
        b=SwmO3ierAaCMXm35Qo+9IArimvae8EMW/5W/ziFz9giA0uZj6fHkGUvILAZtnWrSW1
         TSNvL+0+lt+af7SF/Ol9zkHMwYrnUb40M2O1GsAn64R9df0bosU9ZnbVNoeaPAM5ph6w
         BAjoaHwJfMINtsX6zgxBIo66ZkeqaUrpTjKC88Qr4Sjcz3QEBXyVeyI5l6FxKehRSTS/
         Sa4A0DGTPc7UnvAea6eKN59xjOFNdC7Xvx/4hSf20C2zuZAHu0vLOkCvB56yBaFjIRjv
         qkhd4owBRNi6p/9EwmbT02uFA5GzJ7kBQo9ISOfRTkhOkiO2gk/o1N4eBUqT99WqrpTM
         bnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682343363; x=1684935363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVyU9gOwOxOSqHm/6VTLnN93/D/8YFXY62jIfDl6u3U=;
        b=hLV0cibrL0vQW9hCJ8SaNR/ELdkff1IS4Sw6ZSPzLCH9X3DDBIsZZKHgftG2P6+nTh
         U5dOmsNJiZBXyf4+c8KSMsMiTuxAW6S44vr8fu5BEaqGfK7O9WrzHbx8UafC5YADh+6+
         BeSuMDTdO4ujpL0w6yfXJZLc3HvTlcMPjkrCocQ793/eRpnrKTfq1FtdmIPGofHc7XUa
         0YCoVID1QwrNfpVlsPQphD7WtKPT+fvagD56063p5/Y3FSrWuXobsRt0ONf/Z6DpR/wo
         pW5gzyiKVytpwjmGsnqQrc2rAHQqab0sZ3nvSRzQD8tRA5oOHTh658nG9elyyigR+/F7
         jd3g==
X-Gm-Message-State: AAQBX9fS7naTd3KOb+qifhrcLprj9SfC1X6oC04kaQB3HcmuCbL//vUj
        b5x4HPx4zShEs3XFWhUBWve2Tjznut4=
X-Google-Smtp-Source: AKy350aRVoddVFKIuu20g+zRmHIrt/Qh5TXTYunmwx1pqngASEiRfYgxgX7Xdwb/7aMuYErU/MDe7A==
X-Received: by 2002:a17:90b:1b0e:b0:24b:3dea:d922 with SMTP id nu14-20020a17090b1b0e00b0024b3dead922mr13655246pjb.20.1682343363255;
        Mon, 24 Apr 2023 06:36:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902eb0400b001960706141fsm6629453plb.149.2023.04.24.06.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 06:36:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v6.4
Date:   Mon, 24 Apr 2023 06:36:01 -0700
Message-Id: <20230424133601.567008-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon updates for Linux v6.4 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.4

Thanks,
Guenter
------

The following changes since commit 7e364e56293bb98cae1b55fd835f5991c4e96e7d:

  Linux 6.3-rc5 (2023-04-02 14:29:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.4

for you to fetch changes up to 1c19ac768b8eeb0304c4ed7db66c2bb89c6ad226:

  hwmon: lochnagar: Remove the unneeded include <linux/i2c.h> (2023-04-23 08:22:28 -0700)

----------------------------------------------------------------
hwmon updates for v6.4

- New drivers

  - Driver for Acbel FSB032 power supply

  - Driver for StarFive JH71x0 temperature sensor

- Added support to existing drivers

  - aquacomputer_d5next: Support for Aquacomputer Aquastream XT

  - nct6775: Added various ASUS boards to list of boards supporting WMI

  - asus-ec-sensors: ROG STRIX Z390-F GAMING, ProArt B550-Creator,

- Notable improvements

  - Regulator event and sysfs notification support for PMBus drivers

- Notable cleanup:

  - Constified pointers to hwmon_channel_info

- Various other minor bug fixes and improvements

----------------------------------------------------------------
Aleksa Savic (1):
      hwmon: (aquacomputer_d5next) Add support for Aquacomputer Aquastream XT

Aleksandr Mezin (1):
      hwmon: (nzxt-smart2) add another USB ID

Andy Shevchenko (1):
      hwmon: (nct6775) Drop unneeded casting and conjunction

Armin Wolf (1):
      hwmon: (ftsteutates) Update specifications website

Babu Moger (1):
      hwmon: (k10temp) Check range scale when CUR_TEMP register is read-write

Chris Packham (1):
      hwmon: (adt7475) Use device_property APIs when configuring polarity

Christophe JAILLET (2):
      hwmon: (sfctemp) Simplify error message
      hwmon: lochnagar: Remove the unneeded include <linux/i2c.h>

Cristian Ciocaltea (1):
      dt-bindings: hwmon: pwm-fan: Convert to DT schema

Denis Pauk (6):
      hwmon: (nct6775) Fix TUF GAMING B550M-E WIFI name
      hwmon: (nct6775) update ASUS WMI monitoring list A520/B360/B460/B550...
      hwmon: (nct6775) Sort ASUS board list
      hwmon: (nct6775) Fix ROG B550-XE WIFI and Pro B660M-C D4 names
      hwmon: (nct6775) update ASUS WMI monitoring list B360/H410/H610/Z390...
      hwmon: (nct6775) update ASUS WMI monitoring list A620/B760/W790

Eddie James (2):
      hwmon: (pmbus/core) Add lock and unlock functions
      hwmon: (pmbus/ibm-cffps) Use default debugfs attributes and lock function

Emil Renner Berthing (2):
      dt-bindings: hwmon: Add starfive,jh71x0-temp
      hwmon: (sfctemp) Add StarFive JH71x0 temperature sensor

Erik Ekman (1):
      hwmon: (nct6775) ASUS PRIME Z590 boards support

Eugene Shalygin (1):
      hwmon: (asus-ec-sensors) add ROG STRIX Z390-F GAMING

Frank Crawford (5):
      hwmon: (it87) Use voltage scaling macro where appropriate
      hwmon: (it87) Disable SMBus access for environmental controller registers.
      hwmon: (it87) Test for error in it87_update_device
      hwmon: (it87) Add calls to smbus_enable/smbus_disable as required
      hwmon: (it87) Disable/enable SMBus access for IT8622E chipset

Guenter Roeck (3):
      Merge branch 'hwmon-const' into HEAD
      Documentation/hwmon: Remove description of deprecated registration functions
      hwmon: (pmbus/core) Request threaded interrupt with IRQF_ONESHOT

Holger Kiehl (1):
      hwmon: (nct6775) add Asus Pro A520M-C II/CSM

James Seo (2):
      hwmon: remove trailing whitespace in Kconfig
      hwmon: fix typo in Makefile

Kang Chen (2):
      hwmon: (nzxt-smart2) handle failure of devm_add_action in nzxt_smart2_hid_probe
      hwmon: (g762) add a check of devm_add_action in g762_of_clock_enable

Krzysztof Kozlowski (70):
      hwmon: constify pointers to hwmon_channel_info
      hwmon: (gpio-fan) drop of_match_ptr for ID table
      MAINTAINERS: hwmon: drop Agathe Porte
      hwmon: adm1177: constify pointers to hwmon_channel_info
      hwmon: adm9240: constify pointers to hwmon_channel_info
      hwmon: adt7411: constify pointers to hwmon_channel_info
      hwmon: adt7470: constify pointers to hwmon_channel_info
      hwmon: adt7x10: constify pointers to hwmon_channel_info
      hwmon: aht10: constify pointers to hwmon_channel_info
      hwmon: aquacomputer: constify pointers to hwmon_channel_info
      hwmon: as370: constify pointers to hwmon_channel_info
      hwmon: axi-fan: constify pointers to hwmon_channel_info
      hwmon: bt1-pvt: constify pointers to hwmon_channel_info
      hwmon: corsair: constify pointers to hwmon_channel_info
      hwmon: dell-smm: constify pointers to hwmon_channel_info
      hwmon: drivetemp: constify pointers to hwmon_channel_info
      hwmon: emc2305: constify pointers to hwmon_channel_info
      hwmon: ftsteutates: constify pointers to hwmon_channel_info
      hwmon: gxp-fan: constify pointers to hwmon_channel_info
      hwmon: i5500_temp: constify pointers to hwmon_channel_info
      hwmon: ina238: constify pointers to hwmon_channel_info
      hwmon: ina3221: constify pointers to hwmon_channel_info
      hwmon: intel-m10-bmc: constify pointers to hwmon_channel_info
      hwmon: jc42: constify pointers to hwmon_channel_info
      hwmon: k10temp: constify pointers to hwmon_channel_info
      hwmon: k8temp: constify pointers to hwmon_channel_info
      hwmon: lan966x: constify pointers to hwmon_channel_info
      hwmon: lm75: constify pointers to hwmon_channel_info
      hwmon: lm83: constify pointers to hwmon_channel_info
      hwmon: lm95241: constify pointers to hwmon_channel_info
      hwmon: lm95245: constify pointers to hwmon_channel_info
      hwmon: lochnagar: constify pointers to hwmon_channel_info
      hwmon: ltc2947: constify pointers to hwmon_channel_info
      hwmon: ltc2992: constify pointers to hwmon_channel_info
      hwmon: ltc4245: constify pointers to hwmon_channel_info
      hwmon: ltq-cputemp: constify pointers to hwmon_channel_info
      hwmon: max127: constify pointers to hwmon_channel_info
      hwmon: max31730: constify pointers to hwmon_channel_info
      hwmon: max31760: constify pointers to hwmon_channel_info
      hwmon: max31790: constify pointers to hwmon_channel_info
      hwmon: max6620: constify pointers to hwmon_channel_info
      hwmon: max6621: constify pointers to hwmon_channel_info
      hwmon: max6650: constify pointers to hwmon_channel_info
      hwmon: mc34vr500: constify pointers to hwmon_channel_info
      hwmon: mcp3021: constify pointers to hwmon_channel_info
      hwmon: mlxreg: constify pointers to hwmon_channel_info
      hwmon: nct7904: constify pointers to hwmon_channel_info
      hwmon: npcm750-pwm: constify pointers to hwmon_channel_info
      hwmon: ntc_thermistor: constify pointers to hwmon_channel_info
      hwmon: nzxt: constify pointers to hwmon_channel_info
      hwmon: oxp-sensors: constify pointers to hwmon_channel_info
      hwmon: peci: constify pointers to hwmon_channel_info
      hwmon: powr1220: constify pointers to hwmon_channel_info
      hwmon: raspberrypi: constify pointers to hwmon_channel_info
      hwmon: sbrmi: constify pointers to hwmon_channel_info
      hwmon: sbtsi_temp: constify pointers to hwmon_channel_info
      hwmon: sch5627: constify pointers to hwmon_channel_info
      hwmon: sht4x: constify pointers to hwmon_channel_info
      hwmon: sl28cpld: constify pointers to hwmon_channel_info
      hwmon: smpro: constify pointers to hwmon_channel_info
      hwmon: sparx5-temp: constify pointers to hwmon_channel_info
      hwmon: sy7636a: constify pointers to hwmon_channel_info
      hwmon: tmp102: constify pointers to hwmon_channel_info
      hwmon: tmp103: constify pointers to hwmon_channel_info
      hwmon: tmp108: constify pointers to hwmon_channel_info
      hwmon: tmp464: constify pointers to hwmon_channel_info
      hwmon: tmp513: constify pointers to hwmon_channel_info
      hwmon: tps23861: constify pointers to hwmon_channel_info
      hwmon: w83627ehf: constify pointers to hwmon_channel_info
      hwmon: w83773g: constify pointers to hwmon_channel_info

Lakshmi Yadlapati (4):
      dt-bindings: vendor-prefixes: Add prefix for acbel
      dt-bindings: trivial-devices: Add acbel,fsg032
      hwmon: (pmbus/acbel-fsg032) Add Acbel power supply
      docs: hwmon: Add documentaion for acbel-fsg032 PSU

Leonard Anderweit (6):
      hwmon: (aquacomputer_d5next) Support one byte control values
      hwmon: (aquacomputer_d5next) Support writing multiple control values at once
      hwmon: (aquacomputer_d5next) Device dependent control report settings
      hwmon: (aquacomputer_d5next) Add infrastructure for Aquaero control reports
      hwmon: (aquacomputer_d5next) Add temperature offset control for Aquaero
      hwmon: (aquacomputer_d5next) Add fan PWM control for Aquaero

Lorenz Brun (1):
      hwmon: (pwm-fan) set usage_power on PWM state

Naresh Solanki (4):
      hwmon: (pmbus/core) Generalize pmbus status flag map
      hwmon: (pmbus/core) Generalise pmbus get status
      hwmon: (pmbus/core) Add rdev in pmbus_data struct
      hwmon: (pmbus/core) Notify regulator events

Patrick Rudolph (3):
      hwmon: (pmbus/core) Add interrupt support
      hwmon: (pmbus/core) Notify hwmon events
      hwmon: (pmbus/core) Add regulator event support

Rob Herring (2):
      hwmon: (ltc4245) Use of_property_read_bool() for boolean properties
      hwmon: (ibmpowernv, pwm-fan) Use of_property_present() for testing DT property presence

Stefan Wahren (1):
      docs: hwmon: sysfs-interface: Fix stray colon

Svyatoslav Ryhel (2):
      dt-bindings: hwmon: ina2xx: add supply property
      hwmon: ina2xx: add optional regulator support

Tom Rix (1):
      hwmon: remove unused superio_outb function

Tomáš Pecka (1):
      hwmon: (pmbus/fsp-3y) Fix functionality bitmask in FSP-3Y YM-2151E

Zhang Rui (2):
      hwmon: (coretemp) Delete tjmax debug message
      hwmon: (coretemp) Delete an obsolete comment

fireflame90051 (1):
      hwmon: (asus-ec-sensors) add ProArt B550-Creator

 .../devicetree/bindings/hwmon/pwm-fan.txt          |  68 +---
 .../devicetree/bindings/hwmon/pwm-fan.yaml         |  97 +++++
 .../bindings/hwmon/starfive,jh71x0-temp.yaml       |  70 ++++
 .../devicetree/bindings/hwmon/ti,ina2xx.yaml       |   5 +
 .../devicetree/bindings/hwmon/ti,tmp464.yaml       |   2 +-
 .../devicetree/bindings/trivial-devices.yaml       |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 Documentation/hwmon/acbel-fsg032.rst               |  80 +++++
 Documentation/hwmon/aquacomputer_d5next.rst        |  10 +-
 Documentation/hwmon/asus_ec_sensors.rst            |   2 +
 Documentation/hwmon/ftsteutates.rst                |   6 +-
 Documentation/hwmon/hwmon-kernel-api.rst           |  66 +---
 Documentation/hwmon/index.rst                      |   2 +
 Documentation/hwmon/sfctemp.rst                    |  33 ++
 Documentation/hwmon/sysfs-interface.rst            |   2 +-
 MAINTAINERS                                        |   9 +-
 drivers/accel/habanalabs/common/hwmon.c            |   2 +-
 drivers/hwmon/Kconfig                              |  12 +-
 drivers/hwmon/Makefile                             |   3 +-
 drivers/hwmon/adm1177.c                            |   2 +-
 drivers/hwmon/adm9240.c                            |   2 +-
 drivers/hwmon/adt7411.c                            |   2 +-
 drivers/hwmon/adt7470.c                            |   2 +-
 drivers/hwmon/adt7475.c                            |   6 +-
 drivers/hwmon/adt7x10.c                            |   2 +-
 drivers/hwmon/aht10.c                              |   2 +-
 drivers/hwmon/aquacomputer_d5next.c                | 299 ++++++++++++++--
 drivers/hwmon/as370-hwmon.c                        |   2 +-
 drivers/hwmon/asus-ec-sensors.c                    |  20 ++
 drivers/hwmon/axi-fan-control.c                    |   2 +-
 drivers/hwmon/bt1-pvt.c                            |   4 +-
 drivers/hwmon/coretemp.c                           |   8 +-
 drivers/hwmon/corsair-cpro.c                       |   2 +-
 drivers/hwmon/corsair-psu.c                        |   2 +-
 drivers/hwmon/dell-smm-hwmon.c                     |   2 +-
 drivers/hwmon/drivetemp.c                          |   2 +-
 drivers/hwmon/emc2305.c                            |   2 +-
 drivers/hwmon/ftsteutates.c                        |   2 +-
 drivers/hwmon/g762.c                               |   7 +-
 drivers/hwmon/gpio-fan.c                           |   2 +-
 drivers/hwmon/gxp-fan-ctrl.c                       |   2 +-
 drivers/hwmon/hwmon.c                              |   4 +-
 drivers/hwmon/i5500_temp.c                         |   2 +-
 drivers/hwmon/ibmpowernv.c                         |   4 +-
 drivers/hwmon/ina238.c                             |   2 +-
 drivers/hwmon/ina2xx.c                             |   4 +
 drivers/hwmon/ina3221.c                            |   2 +-
 drivers/hwmon/intel-m10-bmc-hwmon.c                |  10 +-
 drivers/hwmon/it87.c                               | 296 +++++++++++++---
 drivers/hwmon/jc42.c                               |   2 +-
 drivers/hwmon/k10temp.c                            |   6 +-
 drivers/hwmon/k8temp.c                             |   2 +-
 drivers/hwmon/lan966x-hwmon.c                      |   2 +-
 drivers/hwmon/lm75.c                               |   2 +-
 drivers/hwmon/lm83.c                               |   2 +-
 drivers/hwmon/lm95241.c                            |   2 +-
 drivers/hwmon/lm95245.c                            |   2 +-
 drivers/hwmon/lochnagar-hwmon.c                    |   3 +-
 drivers/hwmon/ltc2947-core.c                       |   2 +-
 drivers/hwmon/ltc2992.c                            |   2 +-
 drivers/hwmon/ltc4245.c                            |   4 +-
 drivers/hwmon/ltq-cputemp.c                        |   2 +-
 drivers/hwmon/max127.c                             |   2 +-
 drivers/hwmon/max31730.c                           |   2 +-
 drivers/hwmon/max31760.c                           |   2 +-
 drivers/hwmon/max31790.c                           |   2 +-
 drivers/hwmon/max6620.c                            |   2 +-
 drivers/hwmon/max6621.c                            |   2 +-
 drivers/hwmon/max6650.c                            |   2 +-
 drivers/hwmon/mc34vr500.c                          |   2 +-
 drivers/hwmon/mcp3021.c                            |   2 +-
 drivers/hwmon/mlxreg-fan.c                         |   2 +-
 drivers/hwmon/nct6775-platform.c                   | 293 ++++++++++++++-
 drivers/hwmon/nct7904.c                            |   2 +-
 drivers/hwmon/npcm750-pwm-fan.c                    |   2 +-
 drivers/hwmon/ntc_thermistor.c                     |   2 +-
 drivers/hwmon/nzxt-kraken2.c                       |   2 +-
 drivers/hwmon/nzxt-smart2.c                        |  15 +-
 drivers/hwmon/oxp-sensors.c                        |   2 +-
 drivers/hwmon/peci/cputemp.c                       |   2 +-
 drivers/hwmon/peci/dimmtemp.c                      |   2 +-
 drivers/hwmon/pmbus/Kconfig                        |   9 +
 drivers/hwmon/pmbus/Makefile                       |   1 +
 drivers/hwmon/pmbus/acbel-fsg032.c                 |  85 +++++
 drivers/hwmon/pmbus/fsp-3y.c                       |   1 -
 drivers/hwmon/pmbus/ibm-cffps.c                    | 272 +++++++-------
 drivers/hwmon/pmbus/pmbus.h                        |   4 +-
 drivers/hwmon/pmbus/pmbus_core.c                   | 393 ++++++++++++++++-----
 drivers/hwmon/powr1220.c                           |   2 +-
 drivers/hwmon/pwm-fan.c                            |  10 +-
 drivers/hwmon/raspberrypi-hwmon.c                  |   2 +-
 drivers/hwmon/sbrmi.c                              |   2 +-
 drivers/hwmon/sbtsi_temp.c                         |   2 +-
 drivers/hwmon/sch5627.c                            |   2 +-
 drivers/hwmon/sfctemp.c                            | 331 +++++++++++++++++
 drivers/hwmon/sht4x.c                              |   2 +-
 drivers/hwmon/sl28cpld-hwmon.c                     |   2 +-
 drivers/hwmon/smpro-hwmon.c                        |   2 +-
 drivers/hwmon/sparx5-temp.c                        |   2 +-
 drivers/hwmon/sy7636a-hwmon.c                      |   2 +-
 drivers/hwmon/tmp102.c                             |   2 +-
 drivers/hwmon/tmp103.c                             |   2 +-
 drivers/hwmon/tmp108.c                             |   2 +-
 drivers/hwmon/tmp464.c                             |   2 +-
 drivers/hwmon/tmp513.c                             |   2 +-
 drivers/hwmon/tps23861.c                           |   2 +-
 drivers/hwmon/vt1211.c                             |   6 -
 drivers/hwmon/w83627ehf.c                          |   2 +-
 drivers/hwmon/w83773g.c                            |   2 +-
 include/linux/hwmon.h                              |   2 +-
 110 files changed, 2126 insertions(+), 572 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/starfive,jh71x0-temp.yaml
 create mode 100644 Documentation/hwmon/acbel-fsg032.rst
 create mode 100644 Documentation/hwmon/sfctemp.rst
 create mode 100644 drivers/hwmon/pmbus/acbel-fsg032.c
 create mode 100644 drivers/hwmon/sfctemp.c
