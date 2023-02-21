Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C3669E51E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbjBUQuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjBUQu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:50:29 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DCA2A140;
        Tue, 21 Feb 2023 08:50:27 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id i4so507058ils.1;
        Tue, 21 Feb 2023 08:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=W7SVKRswCGsOawSL5akwB56EAa9f7lRKr2lHZ3S8x7U=;
        b=ITBbzI8o0PDUL+MbLUPXQnW5O8FA8Gcl5V+EKARjL1LBHdXUn+27bwfQuQtSnuGHrR
         XNfC9ib+hlCtPRCmZ7W3PXH5GLyKGcptnw7vhfg+6AzJWv1bKISoZGm2qNb9jJOKBLqZ
         jcX16wcO3GmWAV1AaAW4Ijieqezo0hhTa81piT/4LfJOy/MhySXk4w3puAbrTsEO2OhF
         d2Dc1XnjTZvH+K2sZDZk+SShJrl/iwvTGszieuTOrJbFnkWWDekR1nKnFP3AzCXA2yHk
         TT3fL/SzfOUYnZ7NJ4ksVn+r/oLps7jGAaIy3/ZULwvLndr98wfRJv7wHxkZjaLhMwTV
         Nsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7SVKRswCGsOawSL5akwB56EAa9f7lRKr2lHZ3S8x7U=;
        b=rRnubuKyTrm8AR7VTsB4q/kg1xOdIjIg6n98iThYMFixcMvaa2HmVe6b3HV/tth1hB
         SUtKiEOsZZUhtTLNZCBAxB2JxPj8OQS8coLylCYOsWeweKAgE6wi3y1EjwylgAcfZ1FO
         MvOwmDS44XQulD118mgqgYzpeo0cw0HMn/7qvXfY+Yhd+g8orl1g+zHKI+1CMekm69KO
         iHcbYa5Bhj/NoDe5QR6GtNPMdkbtPKZwKv/gkAH1Cmw7BkzLqB/1De2VV7UZybCg8tws
         +13ZsOU4XRkZb/CH0udT7MmCY/wd4y4cBLokc0NJ34+CEEWf8Sa4QXWCQAMuiBbZyf+W
         Rycw==
X-Gm-Message-State: AO0yUKWukUoaUqDrzYxF0R/zk5v8lZcOKibe036fixGeRswIFzGZI+Eo
        as/ubz3JzpdGH9a1/kSu9ZXeBvh5mGE=
X-Google-Smtp-Source: AK7set/AoDh4HDzpLTCZNYXxZZwk7oubwxmfF0m1rlyahG0ac5VW6tIO7Nu8VQ1vMMZvdXYuIcjWig==
X-Received: by 2002:a92:cd89:0:b0:314:5aa:94b6 with SMTP id r9-20020a92cd89000000b0031405aa94b6mr6940690ilb.24.1676998226667;
        Tue, 21 Feb 2023 08:50:26 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o10-20020a056e02092a00b0030ef8f16056sm1420136ilt.72.2023.02.21.08.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 08:50:26 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v6.3
Date:   Tue, 21 Feb 2023 08:50:25 -0800
Message-Id: <20230221165025.1589365-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.1
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

[Trying again, this time with corretc tag. Sorry for the noise.]

Hi Linus,

Please pull hwmon updates for Linux v6.3 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.3

Expected conflicts:

- Documentation/hwmon/index.rst

  "Docs/hwmon/index: Add missing SPDX License Identifier"
  against
  "Docs/subsystem-apis: Remove '[The ]Linux' prefixes from titles of listed documents"

  Keep both changes.

- MAINTAINERS

  "MAINTAINERS: Add HPE GXP I2C Support"
  against
  "MAINTAINERS: add gxp fan controller and documents"

  Keep both changes.

Thanks,
Guenter
------

The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f98:

  Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.3

for you to fetch changes up to 5720a18baa4686d56d0a235e6ecbcc55f8d716d7:

  hwmon: Deprecate [devm_]hwmon_device_register_with_groups (2023-02-16 11:34:19 -0800)

----------------------------------------------------------------
hwmon updates for v6.3

- New drivers

  * Infineon TDA38640 Voltage Regulator

  * NXP MC34VR500 PMIC

  * GXP fan controller

  * MPQ7932 Power Management IC

- New chip or board support added to existing drivers

  * it87: IT87952E; also other cleanup/improvements

  * intel-m10-bmc-hwmon: N6000

  * pmbus/max16601: MAX16600

  * aquacomputer_d5next: Aquacomputer Aquastream Ultimate, Aquacomputer Poweradjust 3,
    Aquacomputer Aquaero

  * nct6775: Support for B650/B660/X670 ASUS boards

  * oxp-sensors: AYANEO AIR and AIR Pro

- Other notable changes

  * Various kernel documentation fixes

  * Various devicetree bindings fixes

  * Explicitly deprecated [devm_]hwmon_device_register_with_groups

  * ftsteutates: Support for fanX_fault and other cleanup

  * ltc2945: Support for setting shunt resistor and other cleanup/fixes

  * coretemp: Avoid RDMSR interrupts to isolated CPUs,
    and simplify platform device handling

- Vaious other minoc cleanups and fixes

----------------------------------------------------------------
Aleksa Savic (3):
      hwmon: (aquacomputer_d5next) Add support for reading calculated Aquaero sensors
      hwmon: (aquacomputer_d5next) Add support for Aquacomputer Poweradjust 3
      hwmon: (aquacomputer_d5next) Add support for Aquacomputer Aquastream Ultimate

Alexander Stein (1):
      hwmon: (iio_hwmon) use dev_err_probe

Armin Wolf (5):
      hwmon: (ftsteutates) Fix scaling of measurements
      hwmon: (ftsteutates) Use devm_watchdog_register_device()
      hwmon: (ftsteutates) Convert to devm_hwmon_device_register_with_info()
      hwmon: (ftsteutates) Replace fanX_source with pwmX_auto_channels_temp
      hwmon: (ftsteutates) Add support for fanX_fault attributes

Denis Pauk (2):
      hwmon: (nct6775) Directly call ASUS ACPI WMI method
      hwmon: (nct6775) B650/B660/X670 ASUS boards support

Derek J. Clark (1):
      hwmon: (oxp-sensors) Add AYANEO AIR and AIR Pro

Eric Nguyen (1):
      hwmon: (asus-ec-sensors) add zenith ii extreme alpha

Eugene Shalygin (1):
      hwmon: (asus-ec-sensors) add missing mutex path

Frank Crawford (10):
      hwmon: (it87) Allow calling __superio_enter outside muxed region
      hwmon: (it87) Set second Super-IO chip in configuration mode
      hwmon: (it87) Group all related MODULE_PARM definitions together
      hwmon: (it87) Allow disabling exiting of configuration mode
      hwmon: (it87) Disable configuration exit for certain chips
      hwmon: (it87) List full chip model name
      hwmon: (it87) Add chip_id in some info message
      hwmon: (it87) Allow multiple chip IDs for force_id
      hwmon: (it87) Add new chipset IT87952E
      hwmon: (it87) Updated documentation for recent updates to it87

Guenter Roeck (2):
      hwmon: (pmbus/max16601) Add support for MAX16600
      hwmon: Deprecate [devm_]hwmon_device_register_with_groups

Herman Fries (1):
      hwmon: (nzxt-smart2) Add device id

Joaquín Ignacio Aramendía (1):
      docs: hwmon: Use file modes explicitly

John Pruitt (1):
      hwmon: (ltc2945) Allow setting shunt resistor

Jonathan Cormier (3):
      dt-bindings: hwmon: adi,ltc2945: Add binding
      hwmon: (ltc2945) Add devicetree match table
      hwmon: (ltc2945) Handle error case in ltc2945_value_store

Krzysztof Kozlowski (2):
      dt-bindings: hwmon: adi,ltc2992: correct unit address in example
      dt-bindings: hwmon: correct indentation and style in examples

Leonard Anderweit (6):
      hwmon: (aquacomputer_d5next) Rename AQC_TEMP_SENSOR_SIZE to AQC_SENSOR_SIZE
      hwmon: (aquacomputer_d5next) Restructure flow sensor reading
      hwmon: (aquacomputer_d5next) Add structure for fan layout
      hwmon: (aquacomputer_d5next) Device dependent serial number and firmware offsets
      hwmon: (aquacomputer_d5next) Make fan sensor offsets u16
      hwmon: (aquacomputer_d5next) Support sensors for Aquacomputer Aquaero

Marcelo Tosatti (1):
      hwmon: (coretemp) avoid RDMSR interrupts to isolated CPUs

Mario Kicherer (3):
      dt-bindings: hwmon: add nxp,mc34vr500
      docs: hwmon: add docs for the NXP MC34VR500 PMIC
      hwmon: add initial NXP MC34VR500 PMIC monitoring support

Naresh Solanki (1):
      dt-bindings: trivial-devices: Add Infineon TDA38640 Voltage Regulator

Nick Hawkins (4):
      ABI: sysfs-class-hwmon: add a description for fanY_fault
      hwmon: (gxp-fan-ctrl) Add GXP fan controller
      dt-bindings: hwmon: Add hpe,gxp-fan-ctrl
      MAINTAINERS: add gxp fan controller and documents

Patrick Rudolph (1):
      hwmon: (pmbus/tda38640) Add driver for Infineon TDA38640 Voltage Regulator

Randy Dunlap (4):
      hwmon: (emc2305) fix kernel-doc warnings
      hwmon: (sht15,sht21) fix kernel-doc warnings
      hwmon: (hih6130) fix kernel-doc warnings
      Documentation: hwmon: correct spelling

Robin Murphy (1):
      hwmon: (coretemp) Simplify platform device handling

Saravanan Sekar (3):
      hwmon: (pmbus/core) Add min_uV in pmbus regulator helper macro
      hwmon: (pmbus/mpq7932) Add a support for mpq7932 Power Management IC
      MAINTAINERS: Update the entry for MPQ7932 PMIC driver

SeongJae Park (1):
      Docs/hwmon/index: Add missing SPDX License Identifier

Tianfei zhang (1):
      hwmon: intel-m10-bmc-hwmon: Add N6000 sensors

Vadim Pasternak (1):
      hwmon: (mlxreg-fan) Return zero speed for broken fan

XU pengfei (1):
      hwmon: ibmpex: remove unnecessary (void*) conversions

Yang Li (1):
      hwmon: (aht10) Fix some kernel-doc comments

Ye Xingchen (1):
      hwmon: (gxp-fan-ctrl) use devm_platform_get_and_ioremap_resource()

Zev Weiss (2):
      hwmon: (nct6775) Fix incorrect parenthesization in nct6775_write_fan_div()
      hwmon: (peci/cputemp) Fix off-by-one in coretemp_label allocation

 Documentation/ABI/testing/sysfs-class-hwmon        |   9 +
 .../devicetree/bindings/hwmon/adi,adm1177.yaml     |  12 +-
 .../devicetree/bindings/hwmon/adi,adm1266.yaml     |   6 +-
 .../bindings/hwmon/adi,axi-fan-control.yaml        |  20 +-
 .../devicetree/bindings/hwmon/adi,ltc2945.yaml     |  49 ++
 .../devicetree/bindings/hwmon/adi,ltc2947.yaml     |  20 +-
 .../devicetree/bindings/hwmon/adi,ltc2992.yaml     |  28 +-
 .../devicetree/bindings/hwmon/amd,sbrmi.yaml       |   6 +-
 .../devicetree/bindings/hwmon/amd,sbtsi.yaml       |   6 +-
 .../bindings/hwmon/hpe,gxp-fan-ctrl.yaml           |  45 ++
 .../devicetree/bindings/hwmon/iio-hwmon.yaml       |   8 +-
 .../devicetree/bindings/hwmon/national,lm90.yaml   |  44 +-
 .../devicetree/bindings/hwmon/ntc-thermistor.yaml  |   2 +-
 .../devicetree/bindings/hwmon/nuvoton,nct7802.yaml |  16 +-
 .../devicetree/bindings/hwmon/nxp,mc34vr500.yaml   |  36 ++
 .../devicetree/bindings/hwmon/ti,tmp513.yaml       |  22 +-
 .../devicetree/bindings/hwmon/ti,tps23861.yaml     |  16 +-
 .../devicetree/bindings/trivial-devices.yaml       |   2 +
 Documentation/hwmon/aht10.rst                      |   2 +-
 Documentation/hwmon/aquacomputer_d5next.rst        |  13 +
 Documentation/hwmon/aspeed-pwm-tacho.rst           |   2 +-
 Documentation/hwmon/asus_ec_sensors.rst            |   1 +
 Documentation/hwmon/corsair-psu.rst                |   2 +-
 Documentation/hwmon/ftsteutates.rst                |   9 +
 Documentation/hwmon/gsc-hwmon.rst                  |   6 +-
 Documentation/hwmon/gxp-fan-ctrl.rst               |  28 ++
 Documentation/hwmon/hwmon-kernel-api.rst           |   6 +-
 Documentation/hwmon/index.rst                      |   4 +
 Documentation/hwmon/it87.rst                       |  47 +-
 Documentation/hwmon/ltc2978.rst                    |   2 +-
 Documentation/hwmon/max16601.rst                   |  11 +-
 Documentation/hwmon/max6697.rst                    |   2 +-
 Documentation/hwmon/mc34vr500.rst                  |  32 ++
 Documentation/hwmon/menf21bmc.rst                  |   2 +-
 Documentation/hwmon/oxp-sensors.rst                |  17 +-
 Documentation/hwmon/pmbus-core.rst                 |   2 +-
 Documentation/hwmon/sht4x.rst                      |   2 +-
 Documentation/hwmon/smm665.rst                     |   2 +-
 Documentation/hwmon/stpddc60.rst                   |   2 +-
 Documentation/hwmon/submitting-patches.rst         |   2 +-
 Documentation/hwmon/vexpress.rst                   |   2 +-
 Documentation/hwmon/via686a.rst                    |   2 +-
 MAINTAINERS                                        |   5 +
 drivers/hwmon/Kconfig                              |  18 +-
 drivers/hwmon/Makefile                             |   2 +
 drivers/hwmon/aht10.c                              |   3 +-
 drivers/hwmon/aquacomputer_d5next.c                | 444 +++++++++++++++--
 drivers/hwmon/asus-ec-sensors.c                    |   3 +
 drivers/hwmon/coretemp.c                           | 132 +++--
 drivers/hwmon/emc2305.c                            |  24 +-
 drivers/hwmon/ftsteutates.c                        | 555 ++++++++-------------
 drivers/hwmon/gxp-fan-ctrl.c                       | 253 ++++++++++
 drivers/hwmon/hih6130.c                            |   4 +-
 drivers/hwmon/ibmpex.c                             |   2 +-
 drivers/hwmon/iio_hwmon.c                          |   8 +-
 drivers/hwmon/intel-m10-bmc-hwmon.c                | 229 +++++++++
 drivers/hwmon/it87.c                               | 195 ++++++--
 drivers/hwmon/ltc2945.c                            | 132 +++--
 drivers/hwmon/mc34vr500.c                          | 263 ++++++++++
 drivers/hwmon/mlxreg-fan.c                         |   6 +
 drivers/hwmon/nct6775-core.c                       |   2 +-
 drivers/hwmon/nct6775-platform.c                   | 150 ++++--
 drivers/hwmon/nzxt-smart2.c                        |   1 +
 drivers/hwmon/oxp-sensors.c                        |  52 +-
 drivers/hwmon/peci/cputemp.c                       |   2 +-
 drivers/hwmon/pmbus/Kconfig                        |  36 +-
 drivers/hwmon/pmbus/Makefile                       |   2 +
 drivers/hwmon/pmbus/ltc2978.c                      |  16 +-
 drivers/hwmon/pmbus/max16601.c                     |  14 +-
 drivers/hwmon/pmbus/mpq7932.c                      | 156 ++++++
 drivers/hwmon/pmbus/pmbus.h                        |   5 +-
 drivers/hwmon/pmbus/tda38640.c                     |  74 +++
 drivers/hwmon/sht15.c                              |   8 +-
 drivers/hwmon/sht21.c                              |   4 +-
 include/linux/hwmon.h                              |   4 +
 75 files changed, 2574 insertions(+), 777 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/nxp,mc34vr500.yaml
 create mode 100644 Documentation/hwmon/gxp-fan-ctrl.rst
 create mode 100644 Documentation/hwmon/mc34vr500.rst
 create mode 100644 drivers/hwmon/gxp-fan-ctrl.c
 create mode 100644 drivers/hwmon/mc34vr500.c
 create mode 100644 drivers/hwmon/pmbus/mpq7932.c
 create mode 100644 drivers/hwmon/pmbus/tda38640.c
