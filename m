Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2085F2753
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 02:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJCACh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 20:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJCACf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 20:02:35 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED35BCB1;
        Sun,  2 Oct 2022 17:02:33 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id a29so8836109pfk.5;
        Sun, 02 Oct 2022 17:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=K3/mUw4hWOCoOVfXrjM8txHogGLrsksHoHvPSUe8xFs=;
        b=paHogjTGB303fzzT3GOURqzlLD9gu46NQjfnfwjYRPmBnCHulc8Y8ts+KNwJjb+NGk
         anqbcgXXI6xZ4pXNVTAdQR6BCMt3beargNgKjtpPtmdJVnEr1AvyEBE5PfoaNPl7GfGz
         3ujlvXeJmiXRm5iohzTe7oy1HUYka2Yl+qbeSYQxDvXwYwyIdJiVDKrB1M0CHURJ0WSM
         D8wIvUfxeC7FRlehDq+iwLm5TfAK8JRVqfdlxWmKxNKdIWaLIFgdlKW+P6H8jjOAUnVq
         x6+ZKCop9SlZS3pd1/yuBV9usfxSy0X5a7HIHMtIbE+c2yti6KpG/Lnip5iohH0pgDc7
         im0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=K3/mUw4hWOCoOVfXrjM8txHogGLrsksHoHvPSUe8xFs=;
        b=NCiOxGW6NOu5320mOpJWzd7vdnzvwVq4EAP18W4MedkXEIHRkk5ROjtkpG1/R0Yb3K
         /KX0dnTAmgi2sPUt4jAC/LB0wetaTuqL3AfZcBEG9jnxAKwf6U/RkBi47cv1+ZztkPqO
         /M+bIrhUxHvSentfEGkv881vArsnRDWRzkvISowFaHzdzIxL+utYICPRABS7bMXLj7wX
         3iOD3Et/032cz2AXALFeWa/xNDNbURW59i6PRsE4B1yjpx9F0lUSqH3WnwWLP+ExusPS
         q1tXXYgYjD/qt1oKtaWDeFa695TpGX0RGZi5J/niaBAIfKem+dH451fAC0V/Cl44aIF0
         nDeA==
X-Gm-Message-State: ACrzQf3pyykGVHlXRFWE+L+dejhBp2ip4imRJtyLb/GSgfXoOpSh+AKJ
        ibdpDYg50+ayvGMsiULn9EjtfarhT8waLg==
X-Google-Smtp-Source: AMsMyM4rLZUx9jXn6bbPsGCHSvNfsVx86Mmf6dz0Agv+r2Yz0w3RXXC8E6EhTfqETVmKE+YgZzvySQ==
X-Received: by 2002:a63:1b0e:0:b0:44b:97e8:1020 with SMTP id b14-20020a631b0e000000b0044b97e81020mr5171288pgb.519.1664755353002;
        Sun, 02 Oct 2022 17:02:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l7-20020a170902f68700b00172f4835f53sm5881098plg.192.2022.10.02.17.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 17:02:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v6.1
Date:   Sun,  2 Oct 2022 17:02:30 -0700
Message-Id: <20221003000230.1008396-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.36.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon updates for Linux v6.1 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.1

Thanks,
Guenter
------

A build failure is expected after merging this series and the i2c series.
The problem is caused by commit "hwmon: (emc2305) add support for
EMC2301/2/3/5 RPM-based PWM Fan Speed Controller" in this tree interacting
with commit "i2c: Make remove callback return void" in the i2c tree.
To fix the problem, emc2305_remove() will have to be declared void,
and its return value will have to be removed.

---
The following changes since commit 80e78fcce86de0288793a0ef0f6acf37656ee4cf:

  Linux 6.0-rc5 (2022-09-11 16:22:01 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.1

for you to fetch changes up to 0cf46a653bdae56683fece68dc50340f7520e6c4:

  hwmon: (corsair-psu) add USB id of new revision of the HX1000i psu (2022-10-02 14:38:55 -0700)

----------------------------------------------------------------
hwmon updates for v6.1

* New drivers

  - Driver for MAX31760 fan speed controller

  - Driver for TEXAS TPS546D24 Buck Converter

  - Driver for EMC2301/2/3/5 RPM-based PWM Fan Speed Controller

* Removed drivers

  - Drop obsolete asus_wmi_ec_sensors driver

* Cleanups, affecting various drivers

  - Use DEFINE_SIMPLE_DEV_PM_OPS where appropriate

  - Remove forward declarations

  - Move from strlcpy with unused retval to strscpy

  - Make use of devm_clk_get_enabled()

  - Drop devm_of_pwm_get()

* Other notable cleanup and improvements

  - Support for additional USB devide ID and support for reporting
    of rail mode via debugfs added to corsair-psu driver

  - Support for aditional USB ID in nzxt-smart2 driver

  - Support for Aquacomputer High Flow Next in aquacomputer_d5next driver

  -  Major cleanup of pwm-fan driver

  -  Major cleanup of mr75203 driver, and added support for new device revision

* Various other minor fixes and cleanups

----------------------------------------------------------------
Aleksa Savic (3):
      hwmon: (aquacomputer_d5next) Fix Quadro fan speed offsets
      hwmon: (aquacomputer_d5next) Add support for reading virtual temp sensors
      hwmon: (aquacomputer_d5next) Add support for Aquacomputer High Flow Next

Aleksandr Mezin (1):
      hwmon: (nzxt-smart2) add another USB ID

Alexander Stein (5):
      hwmon: (pwm-fan) Refactor fan power on/off
      hwmon: (pwm-fan) Simplify enable/disable check
      hwmon: (pwm-fan) Add dedicated power switch function
      hwmon: (pwm-fan) split __set_pwm into locked/unlocked functions
      hwmon: (pwm-fan) Switch regulator dynamically

Alexandru Gagniuc (2):
      hwmon: (tps23861) reduce count of i2c transactions for port_status
      hwmon: (tps23861) create unique debugfs directory per device

Andy Shevchenko (4):
      hwmon: (iio_hwmon) Make use of device properties
      hwmon: (pwm-fan) Replace OF specific call to PWM by plain one
      pwm: core: Get rid of unused devm_of_pwm_get()
      pwm: core: Make of_pwm_get() static

Armin Wolf (1):
      hwmon: (dell-smm) Improve warning messages

Christophe JAILLET (1):
      hwmon: (sparx5) Use devm_clk_get_enabled() helper

Colin Ian King (1):
      dt-bindings: hwmon: sensirion,shtc1: Clean up spelling mistakes and grammar

Duke Du (1):
      hwmon: (pmbus) Add driver for the TEXAS TPS546D24 Buck Converter.

Eliav Farber (16):
      dt-bindings: hwmon: (mr75203) add description for Moortec's PVT controller
      dt-bindings: hwmon: (mr75203) change "resets" property to be optional
      hwmon: (mr75203) skip reset-control deassert for SOCs that don't support it
      dt-bindings: vendor-prefixes: add vendor prefix for Moortec
      dt-bindings: hwmon: (mr75203) add "moortec,vm-active-channels" property
      hwmon: (mr75203) add VM active channel support
      dt-bindings: hwmon: (mr75203) add "moortec,vm-pre-scaler-x2" property
      hwmon: (mr75203) add VM pre-scaler x2 support
      hwmon: (mr75203) modify the temperature equation according to series 5 datasheet
      dt-bindings: hwmon: (mr75203) add "moortec,ts-series" property
      hwmon: (mr75203) add support for series 6 temperature equation
      dt-bindings: hwmon: (mr75203) add coefficient properties for the thermal equation
      hwmon: (mr75203) parse temperature coefficients from device-tree
      hwmon: (mr75203) add debugfs to read and write temperature coefficients
      hwmon: (mr75203) fix coding style space errors
      hwmon: (mr75203) fix undefined reference to `__divdi3'

Eugene Shalygin (1):
      hwmon: (asus_wmi_ec_sensors) remove driver

Guenter Roeck (1):
      hwmon: (emc2305) Remove unnecessary range check

Ibrahim Tilki (4):
      drivers: hwmon: Add max31760 fan speed controller driver
      docs: hwmon: add max31760 documentation
      dt-bindings: hwmon: Add bindings for max31760
      MAINTAINERS: Add maintainer for hwmon/max31760

Jason A. Donenfeld (1):
      hwmon: (sht4x) do not overflow clamping operation on 32-bit platforms

Jiapeng Chong (1):
      hwmon: (emc2305) Remove unused including <linux/version.h>

Jonathan Cameron (18):
      hwmon: (abitguru) Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      hwmon: (abitguru3) Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      hwmon: (acpi_power_meter) Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      hwmon: (adt7x10) Switch to EXPORT_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      hwmon: (gpio-fan) Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      hwmon: (it87) Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      hwmon: (lm90) Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      hwmon: (ltc2947) Switch to EXPORT_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      hwmon: (max31722) Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      hwmon: (max31730) witch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      hwmon: (max6639) Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      hwmon: (nct6775) Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      hwmon: (pwm-fan) Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      hwmon: (tmp102) Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      hwmon: (tmp103) Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      hwmon: (tmp108) Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      hwmon: (w83627ehf) Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      hwmon: (ina3221) Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr()

Juerg Haefliger (1):
      MAINTAINERS: Update Juerg Haefliger's email address

Justin Ledford (1):
      hwmon: (max31790) add fanN_enable

Li Zhong (1):
      hwmon: (adm9240) fix data race in adm9240_fan_read

Liang He (1):
      hwmon: (gsc-hwmon) Call of_node_get() before of_find_xxx API

Michael Shych (3):
      platform_data/emc2305: define platform data for EMC2305 driver
      hwmon: (emc2305) add support for EMC2301/2/3/5 RPM-based PWM Fan Speed Controller.
      docs: hwmon: add emc2305.rst to docs

Oleksandr Shamray (1):
      hwmon: (pmbus/mp2888) Fix sensors readouts for MPS Multi-phase mp2888 controller

Peter Robinson (1):
      hwmon: (aspeed-pwm-tacho) Add dependency on ARCH_ASPEED

Robert Marko (1):
      dt-bindings: hwmon: sparx5: use correct clock

Uwe Kleine-König (11):
      hwmon: (pc87360) Introduce a #define for the driver name and use it
      hwmon: (pc87360) Reorder symbols to get rid of a few forward declarations
      hwmon: (vt8231) Introduce a #define for the driver name and use it
      hwmon: (vt8231) Reorder symbols to get rid of a few forward declarations
      hwmon: Make use of devm_clk_get_enabled()
      hwmon: (sis5595) Introduce a #define for the driver name and use it
      hwmon: (sis5595) Reorder symbols to get rid of a few forward declarations
      hwmon: (via686a) Introduce a #define for the driver name and use it
      hwmon: (via686a) Reorder symbols to get rid of a few forward declarations
      hwmon: (f71882fg) Reorder symbols to get rid of a few forward declarations
      hwmon: w83627hf: Reorder symbols to get rid of a few forward declarations

Wilken Gottwalt (2):
      hwmon: (corsair-psu) add reporting of rail mode via debugfs
      hwmon: (corsair-psu) add USB id of new revision of the HX1000i psu

Wolfram Sang (1):
      hwmon: move from strlcpy with unused retval to strscpy

Zeng Heng (1):
      hwmon: (nct6683) remove unused variable in nct6683_create_attr_group

 .../devicetree/bindings/hwmon/adi,max31760.yaml    |   42 +
 .../bindings/hwmon/microchip,sparx5-temp.yaml      |    4 +-
 .../devicetree/bindings/hwmon/moortec,mr75203.yaml |   96 +-
 .../devicetree/bindings/hwmon/sensirion,shtc1.yaml |    8 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 Documentation/driver-api/driver-model/devres.rst   |    1 -
 Documentation/driver-api/pwm.rst                   |    3 +-
 Documentation/hwmon/aquacomputer_d5next.rst        |   37 +-
 Documentation/hwmon/asus_wmi_ec_sensors.rst        |   38 -
 Documentation/hwmon/corsair-psu.rst                |    7 +-
 Documentation/hwmon/emc2305.rst                    |   37 +
 Documentation/hwmon/index.rst                      |    4 +-
 Documentation/hwmon/max31760.rst                   |   77 +
 Documentation/hwmon/max31790.rst                   |    1 +
 Documentation/hwmon/pwm-fan.rst                    |   12 +
 Documentation/hwmon/tps546d24.rst                  |   35 +
 MAINTAINERS                                        |   27 +-
 drivers/hwmon/Kconfig                              |   47 +-
 drivers/hwmon/Makefile                             |    3 +-
 drivers/hwmon/abituguru.c                          |    9 +-
 drivers/hwmon/abituguru3.c                         |    9 +-
 drivers/hwmon/acpi_power_meter.c                   |    9 +-
 drivers/hwmon/adc128d818.c                         |    2 +-
 drivers/hwmon/adm1021.c                            |    2 +-
 drivers/hwmon/adm1025.c                            |    2 +-
 drivers/hwmon/adm1026.c                            |    2 +-
 drivers/hwmon/adm1029.c                            |    2 +-
 drivers/hwmon/adm1031.c                            |    2 +-
 drivers/hwmon/adm9240.c                            |   10 +-
 drivers/hwmon/adt7310.c                            |    2 +-
 drivers/hwmon/adt7410.c                            |    2 +-
 drivers/hwmon/adt7411.c                            |    2 +-
 drivers/hwmon/adt7462.c                            |    2 +-
 drivers/hwmon/adt7475.c                            |    2 +-
 drivers/hwmon/adt7x10.c                            |    7 +-
 drivers/hwmon/adt7x10.h                            |    5 -
 drivers/hwmon/amc6821.c                            |    2 +-
 drivers/hwmon/aquacomputer_d5next.c                |  181 +-
 drivers/hwmon/asb100.c                             |    2 +-
 drivers/hwmon/asc7621.c                            |    2 +-
 drivers/hwmon/asus_wmi_ec_sensors.c                |  622 ----
 drivers/hwmon/axi-fan-control.c                    |   15 +-
 drivers/hwmon/corsair-psu.c                        |   32 +-
 drivers/hwmon/dell-smm-hwmon.c                     |   14 +-
 drivers/hwmon/dme1737.c                            |    2 +-
 drivers/hwmon/emc1403.c                            |   12 +-
 drivers/hwmon/emc2103.c                            |    2 +-
 drivers/hwmon/emc2305.c                            |  621 ++++
 drivers/hwmon/emc6w201.c                           |    2 +-
 drivers/hwmon/f71882fg.c                           | 3039 ++++++++++----------
 drivers/hwmon/f75375s.c                            |    2 +-
 drivers/hwmon/fschmd.c                             |    2 +-
 drivers/hwmon/ftsteutates.c                        |    2 +-
 drivers/hwmon/gl518sm.c                            |    2 +-
 drivers/hwmon/gl520sm.c                            |    2 +-
 drivers/hwmon/gpio-fan.c                           |   11 +-
 drivers/hwmon/gsc-hwmon.c                          |    1 +
 drivers/hwmon/iio_hwmon.c                          |    8 +-
 drivers/hwmon/ina3221.c                            |   13 +-
 drivers/hwmon/it87.c                               |    8 +-
 drivers/hwmon/jc42.c                               |    2 +-
 drivers/hwmon/lm63.c                               |    6 +-
 drivers/hwmon/lm73.c                               |    2 +-
 drivers/hwmon/lm75.c                               |    2 +-
 drivers/hwmon/lm77.c                               |    2 +-
 drivers/hwmon/lm78.c                               |    2 +-
 drivers/hwmon/lm80.c                               |    2 +-
 drivers/hwmon/lm83.c                               |    2 +-
 drivers/hwmon/lm85.c                               |    2 +-
 drivers/hwmon/lm87.c                               |    2 +-
 drivers/hwmon/lm90.c                               |   10 +-
 drivers/hwmon/lm92.c                               |    2 +-
 drivers/hwmon/lm93.c                               |    2 +-
 drivers/hwmon/lm95234.c                            |    2 +-
 drivers/hwmon/lm95241.c                            |    2 +-
 drivers/hwmon/lm95245.c                            |    2 +-
 drivers/hwmon/ltc2947-core.c                       |   24 +-
 drivers/hwmon/ltc2947-i2c.c                        |    2 +-
 drivers/hwmon/ltc2947-spi.c                        |    2 +-
 drivers/hwmon/max1619.c                            |    2 +-
 drivers/hwmon/max1668.c                            |    2 +-
 drivers/hwmon/max31722.c                           |    8 +-
 drivers/hwmon/max31730.c                           |   10 +-
 drivers/hwmon/max31760.c                           |  596 ++++
 drivers/hwmon/max31790.c                           |   38 +-
 drivers/hwmon/max6639.c                            |    8 +-
 drivers/hwmon/max6642.c                            |    2 +-
 drivers/hwmon/mr75203.c                            |  403 ++-
 drivers/hwmon/nct6683.c                            |    4 +-
 drivers/hwmon/nct6775-platform.c                   |    8 +-
 drivers/hwmon/nct7802.c                            |    2 +-
 drivers/hwmon/nct7904.c                            |    2 +-
 drivers/hwmon/nzxt-smart2.c                        |    1 +
 drivers/hwmon/pc87360.c                            | 1535 +++++-----
 drivers/hwmon/pmbus/Kconfig                        |    9 +
 drivers/hwmon/pmbus/Makefile                       |    1 +
 drivers/hwmon/pmbus/mp2888.c                       |   13 +-
 drivers/hwmon/pmbus/tps546d24.c                    |   71 +
 drivers/hwmon/pwm-fan.c                            |  320 ++-
 drivers/hwmon/sht4x.c                              |    2 +-
 drivers/hwmon/sis5595.c                            |  187 +-
 drivers/hwmon/smsc47m192.c                         |    2 +-
 drivers/hwmon/sparx5-temp.c                        |   19 +-
 drivers/hwmon/stts751.c                            |    2 +-
 drivers/hwmon/thmc50.c                             |    2 +-
 drivers/hwmon/tmp102.c                             |    6 +-
 drivers/hwmon/tmp103.c                             |    8 +-
 drivers/hwmon/tmp108.c                             |    8 +-
 drivers/hwmon/tmp401.c                             |    2 +-
 drivers/hwmon/tmp421.c                             |    2 +-
 drivers/hwmon/tps23861.c                           |   93 +-
 drivers/hwmon/via686a.c                            |  206 +-
 drivers/hwmon/vt8231.c                             |  198 +-
 drivers/hwmon/w83627ehf.c                          |    8 +-
 drivers/hwmon/w83627hf.c                           | 1788 ++++++------
 drivers/hwmon/w83781d.c                            |    2 +-
 drivers/hwmon/w83791d.c                            |    2 +-
 drivers/hwmon/w83792d.c                            |    2 +-
 drivers/hwmon/w83793.c                             |    2 +-
 drivers/hwmon/w83795.c                             |    2 +-
 drivers/hwmon/w83l785ts.c                          |    2 +-
 drivers/hwmon/w83l786ng.c                          |    2 +-
 drivers/pwm/core.c                                 |   35 +-
 include/linux/platform_data/emc2305.h              |   22 +
 include/linux/pwm.h                                |   20 -
 125 files changed, 6123 insertions(+), 4759 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,max31760.yaml
 delete mode 100644 Documentation/hwmon/asus_wmi_ec_sensors.rst
 create mode 100644 Documentation/hwmon/emc2305.rst
 create mode 100644 Documentation/hwmon/max31760.rst
 create mode 100644 Documentation/hwmon/tps546d24.rst
 delete mode 100644 drivers/hwmon/asus_wmi_ec_sensors.c
 create mode 100644 drivers/hwmon/emc2305.c
 create mode 100644 drivers/hwmon/max31760.c
 create mode 100644 drivers/hwmon/pmbus/tps546d24.c
 create mode 100644 include/linux/platform_data/emc2305.h
