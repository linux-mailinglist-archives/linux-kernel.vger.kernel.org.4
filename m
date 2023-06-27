Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628B373F2FA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 05:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjF0Dqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 23:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjF0DqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 23:46:16 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF7E19F;
        Mon, 26 Jun 2023 20:45:14 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-666e6541c98so3988281b3a.2;
        Mon, 26 Jun 2023 20:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687837514; x=1690429514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gyTcez2yTqccRNhfr9b2hTA6SJ0uuNDf85qf9nY0fzo=;
        b=LlT0XrMGaemVux7CDzIpLbiXMMdbFnPz96jzW++jIm+H+ay7BlQnOPi6XGD2mt+N6e
         XFjTbSlKMXfWPEu7E+4E0JV7BbjjirZ9TdWP1SwjzEtfLMcoLVbWzBAcXph1/r7RHVQF
         +rBtvmvzGguljjuVFa/CKgGV09RnBPbjuFciNNQQOcWvwj4iX7mob9GbfsAEqDfojEw8
         KHx3FY0lcqFgIADSEHahjJ8eSfVDdiz+fJDvnDF9epkev7sEvb/CqGDJi0SDpM6AHsLL
         2UDMnNEEaPH/8L9+v+XswPh6AaFD4bwqJAiEisqx2fsAlz6RGeHtUtiygTq8dhFu0OeF
         M5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687837514; x=1690429514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyTcez2yTqccRNhfr9b2hTA6SJ0uuNDf85qf9nY0fzo=;
        b=kuLjrkTPM6JR/jUVgVNNMRHHDu7IfBDsTiC82TH4rroaWaN1FkbFzvtyjyxMPkwSYv
         2jpCICONKndcg4lr/EGvOQz7W5t24UXAD6plksr9y2SILkyKKkxRt4qomUET/McF/r1i
         PZFFTMiJRxY8plsvBK1XbVo6VUaQ6/HN2a8FQsTaNDivYB+MGnJKAhCQJW/FerZjmAev
         /hIvYlFsPaiwWwIIIobHHjc/uImfyCkFs+w+xNuC3Vb8rUyLnrf72OP9aTlPW366X9rY
         BkZUXLvwzcAJSyl8UYHr1l7If5ivDgLWyZw+VrYwHE/VL+puRxigfzimpSJ5DjFkOfAt
         DzWw==
X-Gm-Message-State: AC+VfDwGyItQkBd9snvli2hIlZpkSFY06ZwSV7GWmjVwrde695VWauVc
        4P+6HOy4JbjLccBLsncTVLFFxviFtjQ=
X-Google-Smtp-Source: ACHHUZ6dANvuK6JHG5waui7PushRpPeWpXL6oA2kMsVIBifH0DnzPfGiXFLPP0AwgDPxm38Bf51lHw==
X-Received: by 2002:a05:6a00:1504:b0:668:7b5b:c1aa with SMTP id q4-20020a056a00150400b006687b5bc1aamr30108452pfu.20.1687837513953;
        Mon, 26 Jun 2023 20:45:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s1-20020aa78281000000b0065a1b05193asm4441866pfm.185.2023.06.26.20.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:45:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v6.5
Date:   Mon, 26 Jun 2023 20:45:11 -0700
Message-Id: <20230627034511.166918-1-linux@roeck-us.net>
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

Please pull hwmon updates for Linux v6.5 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.5

Thanks,
Guenter
------

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.5

for you to fetch changes up to 90fc660e8479c5da5bb99a4fb3e0d266fa041b15:

  hwmon: max31827: Switch back to use struct i2c_driver::probe (2023-06-26 06:45:54 -0700)

----------------------------------------------------------------
hwmon updates for v6.5

* New drivers

  - Driver for MAX31827

  - Driver to support HP WMI Sensors

* Added support to existing drivers

  - aht10: Support for AHT20

  - aquacomputer_d5next: Support for Aquacomputer Leakshield

  - asus-ec-sensors: Support for ROG Crosshair X670E Hero

  - corsair-psu: Cleanups and support for series 2022 and 2023

  - it87: Various improvements and support for IT8732F

  - nct6683: Support customer ID of some MSI boards.

  - nct6755: Support for NCT6799D

  - oxp-sensors: Various cleanups; support for AYANEO 2, Geek, OXP Mini,
    and AOKZOE A1 PRO

  - pmbus/max16601: Support for new revisions of MAX16508

  - pmbus/adm1275: Disable ADC while updating PMON_CONFIG, and fix problems
    with temperature monitoring on ADM1272

  - sht3x: Various cleanups; support for medium repeatability

* Other notable changes

  - Switched regmap drivers to Maple tree support where appropriate

* Various other minor fixes and improvements

----------------------------------------------------------------
Aleksa Savic (2):
      hwmon: (aquacomputer_d5next) Rename AQC_TEMP_SENSOR_DISCONNECTED
      hwmon: (aquacomputer_d5next) Add support for Aquacomputer Leakshield

Arnd Bergmann (1):
      hwmon: (hp-wmi-sensors) fix debugfs check

Chris Packham (1):
      hwmon: (adt7475) Convert to use device_property APIs

Daniel Matyas (2):
      dt-bindings: hwmon: add MAX31827
      hwmon: Add MAX31827 driver

Frank Crawford (5):
      hwmon: (it87) Add controls for chips with only 4 fans
      hwmon: (it87) Add controls for chips with only 4 PWMs
      hwmon: (it87) Update IT8732F chip for 4 fans and PWMs
      hwmon: (it87) Allow for chips with only 4 temp sensors
      hwmon: (it87) Generalise support for FAN_CTL ON/OFF

Gopal Prasad (1):
      hwmon: (nct6683) Add another customer ID for NCT6687D sensor chip on some MSI boards.

Guenter Roeck (5):
      hwmon: (pmbus/adm1275) Fix problems with temperature monitoring on ADM1272
      hwmon: (pmbus/max16601) Add support for new revisions of MAX16508
      hwmon: (nct6755) Add support for NCT6799D
      hwmon: (pmbus/adm1275) Prepare for protected write to PMON_CONFIG
      hwmon: (pmbus/adm1275) Disable ADC while updating PMON_CONFIG

James Seo (4):
      Documentation/hwmon: Move misplaced entry in hwmon docs index
      hwmon: (core) Add missing beep-related standard attributes
      hwmon: (core) Finish renaming groups parameter in API to extra_groups
      hwmon: add HP WMI Sensors driver

Jerrod Frost (1):
      hwmon: (oxp-sensors) Add support for AOKZOE A1 PRO

Joaquín Ignacio Aramendía (7):
      hwmon: (oxp-sensors) Add AYANEO 2 and Geek models
      hwmon: (oxp-sensors) Use less convoluted enum cast
      hwmon: (oxp-sensors) Add new DMI match for OXP Mini
      hwmon: (oxp-sensors) Stop passing device structure
      hwmon: (oxp-sensors) Add tt_toggle attribute on supported boards
      hwmon: (oxp-sensors) Remove unused header
      hwmon: (oxp-sensors) Simplify logic of error return

JuenKit Yip (6):
      hwmon: (sht3x) remove sht3x_platform_data
      hwmon: (sht3x) remove blocking_io property
      hwmon: (sht3x)replace "high-precision" property to "repeatability"
      hwmon: (sht3x) add medium repeatability support
      hwmon: (sht3x) Add new non-stardard sysfs attribute
      hwmon: (sht3x) complement sysfs interface for sts3x

Kirill Yatsenko (3):
      hwmon: (aht10) Fix typos in comments
      hwmon: (aht10) Refactor aht10_read_values function
      hwmon: (aht10) Add support for compatible aht20

Mark Brown (5):
      hwmon: (lm75) Use maple tree register cache
      hwmon: (lm95245) Use maple tree register cache
      hwmon: (tmp102) Use maple tree register cache
      hwmon: (tmp108) Use maple tree register cache
      hwmon: (tmp464) Use maple tree register cache

Michael Carns (1):
      hwmon: (asus-ec-sensors) add ROG Crosshair X670E Hero.

Nikita Zhandarovich (1):
      hwmon: (f71882fg) prevent possible division by zero

Osama Muhammad (2):
      hwmon: (pmbus/ucd9000) Drop unnecessary error check for debugfs_create_dir
      hwmon: (pmbus/adm1266) Drop unnecessary error check for debugfs_create_dir

Tim Harvey (1):
      hwmon: (gsc-hwmon) fix fan pwm temperature scaling

Uwe Kleine-König (2):
      hwmon: Switch i2c drivers back to use .probe()
      hwmon: max31827: Switch back to use struct i2c_driver::probe

Wilken Gottwalt (3):
      hwmon: (corsair-psu) add support for reading PWM values and mode
      hwmon: (corsair-psu) various cleanups
      hwmon: (corsair-psu) update Series 2022 and 2023 support

Yongsheng Yang (1):
      Documentation/hwmon: Fix description of devm_hwmon_device_unregister()

 .../devicetree/bindings/hwmon/adi,max31827.yaml    |   54 +
 Documentation/hwmon/aht10.rst                      |   20 +-
 Documentation/hwmon/aquacomputer_d5next.rst        |    9 +
 Documentation/hwmon/asus_ec_sensors.rst            |    1 +
 Documentation/hwmon/corsair-psu.rst                |   15 +-
 Documentation/hwmon/hp-wmi-sensors.rst             |  140 ++
 Documentation/hwmon/hwmon-kernel-api.rst           |    2 +-
 Documentation/hwmon/index.rst                      |    4 +-
 Documentation/hwmon/max31827.rst                   |   90 +
 Documentation/hwmon/oxp-sensors.rst                |   21 +
 Documentation/hwmon/sht3x.rst                      |   18 +-
 MAINTAINERS                                        |   16 +
 drivers/hwmon/Kconfig                              |   28 +-
 drivers/hwmon/Makefile                             |    3 +-
 drivers/hwmon/ad7414.c                             |    2 +-
 drivers/hwmon/ad7418.c                             |    2 +-
 drivers/hwmon/adc128d818.c                         |    2 +-
 drivers/hwmon/adm1021.c                            |    2 +-
 drivers/hwmon/adm1025.c                            |    2 +-
 drivers/hwmon/adm1026.c                            |    2 +-
 drivers/hwmon/adm1029.c                            |    2 +-
 drivers/hwmon/adm1031.c                            |    2 +-
 drivers/hwmon/adm1177.c                            |    2 +-
 drivers/hwmon/adm9240.c                            |    2 +-
 drivers/hwmon/ads7828.c                            |    2 +-
 drivers/hwmon/adt7410.c                            |    2 +-
 drivers/hwmon/adt7411.c                            |    2 +-
 drivers/hwmon/adt7462.c                            |    2 +-
 drivers/hwmon/adt7470.c                            |    2 +-
 drivers/hwmon/adt7475.c                            |   10 +-
 drivers/hwmon/aht10.c                              |  154 +-
 drivers/hwmon/amc6821.c                            |    2 +-
 drivers/hwmon/aquacomputer_d5next.c                |  117 +-
 drivers/hwmon/asb100.c                             |    2 +-
 drivers/hwmon/asc7621.c                            |    2 +-
 drivers/hwmon/asus-ec-sensors.c                    |   30 +
 drivers/hwmon/atxp1.c                              |    2 +-
 drivers/hwmon/corsair-psu.c                        |   90 +-
 drivers/hwmon/dme1737.c                            |    2 +-
 drivers/hwmon/ds1621.c                             |    2 +-
 drivers/hwmon/ds620.c                              |    2 +-
 drivers/hwmon/emc1403.c                            |    2 +-
 drivers/hwmon/emc2103.c                            |    2 +-
 drivers/hwmon/emc2305.c                            |    2 +-
 drivers/hwmon/emc6w201.c                           |    2 +-
 drivers/hwmon/f71882fg.c                           |    7 +-
 drivers/hwmon/f75375s.c                            |    2 +-
 drivers/hwmon/fschmd.c                             |    2 +-
 drivers/hwmon/ftsteutates.c                        |    2 +-
 drivers/hwmon/g760a.c                              |    2 +-
 drivers/hwmon/g762.c                               |    2 +-
 drivers/hwmon/gl518sm.c                            |    2 +-
 drivers/hwmon/gl520sm.c                            |    2 +-
 drivers/hwmon/gsc-hwmon.c                          |    6 +-
 drivers/hwmon/hih6130.c                            |    2 +-
 drivers/hwmon/hp-wmi-sensors.c                     | 2004 ++++++++++++++++++++
 drivers/hwmon/hwmon.c                              |   11 +-
 drivers/hwmon/ina209.c                             |    2 +-
 drivers/hwmon/ina238.c                             |    2 +-
 drivers/hwmon/ina2xx.c                             |    2 +-
 drivers/hwmon/ina3221.c                            |    2 +-
 drivers/hwmon/it87.c                               |  134 +-
 drivers/hwmon/jc42.c                               |    2 +-
 drivers/hwmon/lineage-pem.c                        |    2 +-
 drivers/hwmon/lm63.c                               |    2 +-
 drivers/hwmon/lm73.c                               |    2 +-
 drivers/hwmon/lm75.c                               |    4 +-
 drivers/hwmon/lm77.c                               |    2 +-
 drivers/hwmon/lm78.c                               |    2 +-
 drivers/hwmon/lm80.c                               |    2 +-
 drivers/hwmon/lm83.c                               |    2 +-
 drivers/hwmon/lm85.c                               |    2 +-
 drivers/hwmon/lm87.c                               |    2 +-
 drivers/hwmon/lm90.c                               |    2 +-
 drivers/hwmon/lm92.c                               |    2 +-
 drivers/hwmon/lm93.c                               |    2 +-
 drivers/hwmon/lm95234.c                            |    2 +-
 drivers/hwmon/lm95241.c                            |    2 +-
 drivers/hwmon/lm95245.c                            |    4 +-
 drivers/hwmon/ltc2945.c                            |    2 +-
 drivers/hwmon/ltc2947-i2c.c                        |    2 +-
 drivers/hwmon/ltc2990.c                            |    2 +-
 drivers/hwmon/ltc2992.c                            |    2 +-
 drivers/hwmon/ltc4151.c                            |    2 +-
 drivers/hwmon/ltc4215.c                            |    2 +-
 drivers/hwmon/ltc4222.c                            |    2 +-
 drivers/hwmon/ltc4245.c                            |    2 +-
 drivers/hwmon/ltc4260.c                            |    2 +-
 drivers/hwmon/ltc4261.c                            |    2 +-
 drivers/hwmon/max127.c                             |    2 +-
 drivers/hwmon/max16065.c                           |    2 +-
 drivers/hwmon/max1619.c                            |    2 +-
 drivers/hwmon/max1668.c                            |    2 +-
 drivers/hwmon/max31730.c                           |    2 +-
 drivers/hwmon/max31760.c                           |    2 +-
 drivers/hwmon/max31790.c                           |    2 +-
 drivers/hwmon/max31827.c                           |  466 +++++
 drivers/hwmon/max6620.c                            |    2 +-
 drivers/hwmon/max6621.c                            |    2 +-
 drivers/hwmon/max6639.c                            |    2 +-
 drivers/hwmon/max6642.c                            |    2 +-
 drivers/hwmon/max6650.c                            |    2 +-
 drivers/hwmon/max6697.c                            |    2 +-
 drivers/hwmon/mc34vr500.c                          |    2 +-
 drivers/hwmon/mcp3021.c                            |    2 +-
 drivers/hwmon/nct6683.c                            |    3 +
 drivers/hwmon/nct6775-core.c                       |   55 +-
 drivers/hwmon/nct6775-i2c.c                        |    4 +-
 drivers/hwmon/nct6775-platform.c                   |   41 +-
 drivers/hwmon/nct6775.h                            |    2 +-
 drivers/hwmon/nct7802.c                            |    2 +-
 drivers/hwmon/nct7904.c                            |    2 +-
 drivers/hwmon/occ/p8_i2c.c                         |    2 +-
 drivers/hwmon/oxp-sensors.c                        |  194 +-
 drivers/hwmon/pcf8591.c                            |    2 +-
 drivers/hwmon/pmbus/acbel-fsg032.c                 |    2 +-
 drivers/hwmon/pmbus/adm1266.c                      |    4 +-
 drivers/hwmon/pmbus/adm1275.c                      |  118 +-
 drivers/hwmon/pmbus/bel-pfe.c                      |    2 +-
 drivers/hwmon/pmbus/bpa-rs600.c                    |    2 +-
 drivers/hwmon/pmbus/delta-ahe50dc-fan.c            |    2 +-
 drivers/hwmon/pmbus/dps920ab.c                     |    2 +-
 drivers/hwmon/pmbus/fsp-3y.c                       |    2 +-
 drivers/hwmon/pmbus/ibm-cffps.c                    |    2 +-
 drivers/hwmon/pmbus/inspur-ipsps.c                 |    2 +-
 drivers/hwmon/pmbus/ir35221.c                      |    2 +-
 drivers/hwmon/pmbus/ir36021.c                      |    2 +-
 drivers/hwmon/pmbus/ir38064.c                      |    2 +-
 drivers/hwmon/pmbus/irps5401.c                     |    2 +-
 drivers/hwmon/pmbus/isl68137.c                     |    2 +-
 drivers/hwmon/pmbus/lm25066.c                      |    2 +-
 drivers/hwmon/pmbus/lt7182s.c                      |    2 +-
 drivers/hwmon/pmbus/ltc2978.c                      |    2 +-
 drivers/hwmon/pmbus/ltc3815.c                      |    2 +-
 drivers/hwmon/pmbus/max15301.c                     |    2 +-
 drivers/hwmon/pmbus/max16064.c                     |    2 +-
 drivers/hwmon/pmbus/max16601.c                     |    8 +-
 drivers/hwmon/pmbus/max20730.c                     |    2 +-
 drivers/hwmon/pmbus/max20751.c                     |    2 +-
 drivers/hwmon/pmbus/max31785.c                     |    2 +-
 drivers/hwmon/pmbus/max34440.c                     |    2 +-
 drivers/hwmon/pmbus/max8688.c                      |    2 +-
 drivers/hwmon/pmbus/mp2888.c                       |    2 +-
 drivers/hwmon/pmbus/mp2975.c                       |    2 +-
 drivers/hwmon/pmbus/mp5023.c                       |    2 +-
 drivers/hwmon/pmbus/mpq7932.c                      |    2 +-
 drivers/hwmon/pmbus/pim4328.c                      |    2 +-
 drivers/hwmon/pmbus/pli1209bc.c                    |    2 +-
 drivers/hwmon/pmbus/pm6764tr.c                     |    2 +-
 drivers/hwmon/pmbus/pmbus.c                        |    2 +-
 drivers/hwmon/pmbus/pxe1610.c                      |    2 +-
 drivers/hwmon/pmbus/q54sj108a2.c                   |    2 +-
 drivers/hwmon/pmbus/stpddc60.c                     |    2 +-
 drivers/hwmon/pmbus/tda38640.c                     |    2 +-
 drivers/hwmon/pmbus/tps40422.c                     |    2 +-
 drivers/hwmon/pmbus/tps53679.c                     |    2 +-
 drivers/hwmon/pmbus/tps546d24.c                    |    2 +-
 drivers/hwmon/pmbus/ucd9000.c                      |    4 +-
 drivers/hwmon/pmbus/ucd9200.c                      |    2 +-
 drivers/hwmon/pmbus/xdpe12284.c                    |    2 +-
 drivers/hwmon/pmbus/xdpe152c4.c                    |    2 +-
 drivers/hwmon/pmbus/zl6100.c                       |    2 +-
 drivers/hwmon/powr1220.c                           |    2 +-
 drivers/hwmon/sbrmi.c                              |    2 +-
 drivers/hwmon/sbtsi_temp.c                         |    2 +-
 drivers/hwmon/sht21.c                              |    2 +-
 drivers/hwmon/sht3x.c                              |  125 +-
 drivers/hwmon/sht4x.c                              |    2 +-
 drivers/hwmon/shtc1.c                              |    2 +-
 drivers/hwmon/smm665.c                             |    2 +-
 drivers/hwmon/smsc47m192.c                         |    2 +-
 drivers/hwmon/stts751.c                            |    2 +-
 drivers/hwmon/tc654.c                              |    2 +-
 drivers/hwmon/tc74.c                               |    2 +-
 drivers/hwmon/thmc50.c                             |    2 +-
 drivers/hwmon/tmp102.c                             |    4 +-
 drivers/hwmon/tmp103.c                             |    2 +-
 drivers/hwmon/tmp108.c                             |    4 +-
 drivers/hwmon/tmp401.c                             |    2 +-
 drivers/hwmon/tmp421.c                             |    2 +-
 drivers/hwmon/tmp464.c                             |    4 +-
 drivers/hwmon/tmp513.c                             |    2 +-
 drivers/hwmon/tps23861.c                           |    2 +-
 drivers/hwmon/w83773g.c                            |    2 +-
 drivers/hwmon/w83781d.c                            |    2 +-
 drivers/hwmon/w83791d.c                            |    2 +-
 drivers/hwmon/w83792d.c                            |    2 +-
 drivers/hwmon/w83793.c                             |    2 +-
 drivers/hwmon/w83795.c                             |    2 +-
 drivers/hwmon/w83l785ts.c                          |    2 +-
 drivers/hwmon/w83l786ng.c                          |    2 +-
 include/linux/hwmon.h                              |   10 +
 include/linux/platform_data/sht3x.h                |   15 -
 193 files changed, 3910 insertions(+), 443 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
 create mode 100644 Documentation/hwmon/hp-wmi-sensors.rst
 create mode 100644 Documentation/hwmon/max31827.rst
 create mode 100644 drivers/hwmon/hp-wmi-sensors.c
 create mode 100644 drivers/hwmon/max31827.c
 delete mode 100644 include/linux/platform_data/sht3x.h
