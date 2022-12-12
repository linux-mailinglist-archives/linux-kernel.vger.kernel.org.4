Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6E264A0AD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbiLLN2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbiLLN2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:28:18 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25123F08;
        Mon, 12 Dec 2022 05:28:16 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id s186so11185603oia.5;
        Mon, 12 Dec 2022 05:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CjFXPlGZowJgMV8nnTYwn9x6IUXRk0DZC30EumVqm7c=;
        b=HRC75xduVh0IxwE/vLNwnveLZ1A3QU3pyoIUFjphBfVHojaCrrRpaeiFAn7+/7D05u
         H56yE69W1Wz/S1BOMFN2GrCic1JXFQPSLotEjyAc257sup3qZ2xWTWT8DHsPAqdAFQrP
         FX35skfIhAkliIZ1RU6F11amUliD/PTyuRYxXWSED1Z21EzSF5qVAXB5S/PY4/FuBN95
         f51xmAkkkfCZBJTk8I1yAbrEAaqBB7i24Hxo2m6QSc3tHlNAIYRTY2/rXBXpLMwiA6M1
         LeXevrWDsKRswp0RGH1dNm6XkqGa3GWQQEgZYQQD4v5hCL+a+iq3kB3KLijkHS9p4JV3
         F0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjFXPlGZowJgMV8nnTYwn9x6IUXRk0DZC30EumVqm7c=;
        b=mH9ZQfcYgzQihB0m5CTJlgdFyrFNGavJonh8EQat0qWqLpKfnNZpnfRxOXjZjjsSP3
         d5/eVUTPFkvIq0hdwjMikj++70sb3ECqoNrMn29drWTz8v/HDyQRgqyJHtf48OLi6O+h
         s9JsDzLE2PIIFLEcnYveVBvprVk6vEK1tTGmVqINBXaDe1CA9N4MHeWqn7WBLOzHwJGR
         b9c23hZgHI7aI+hsQvmBcy04h/RKadk7VLq/oUC1sC0iIscC9viVY/iOeoatN/4C5d1s
         PD6UkIkf2+7Pqu88f5u9ivMeHGfbiUiz0975junlCGIZbyZAvnbAmu1OazPe778zciYS
         Gz7A==
X-Gm-Message-State: ANoB5pkxjRpk3Wi19s3XD4D1D60nl06VlzX4Exhdv3EGeZ0nKSt7ddIq
        RjkjRMCJ+lzDDZ68JZ6vrmsTATWDEvg=
X-Google-Smtp-Source: AA0mqf5K5koWOxiO/t5jVIFTyPF9c8rqgKYnn6kO1/19sjuCv7d8ttB9kS3bCOLK24duqMp9FXngGw==
X-Received: by 2002:a05:6808:199f:b0:35e:a4fa:ede6 with SMTP id bj31-20020a056808199f00b0035ea4faede6mr189983oib.40.1670851695345;
        Mon, 12 Dec 2022 05:28:15 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h10-20020a05683040ca00b00670679748f9sm4129037otu.49.2022.12.12.05.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 05:28:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v6.2-rc1
Date:   Mon, 12 Dec 2022 05:28:13 -0800
Message-Id: <20221212132813.3627306-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.36.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

Please pull hwmon fixes for Linux v6.2-rc1 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.2-rc1

Thanks,
Guenter
------

The following changes since commit 76dcd734eca23168cb008912c0f69ff408905235:

  Linux 6.1-rc8 (2022-12-04 14:48:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.2-rc1

for you to fetch changes up to 364ffd2537c44cb6914ff5669153f4a86fffad29:

  hwmon: (emc2305) fix pwm never being able to set lower (2022-12-06 14:45:19 -0800)

----------------------------------------------------------------
hwmon updates for v6.2 merge window

New drivers

- Driver for OneXPlayer mini AMD sensors

- Ampere's Altra smpro-hwmon driver

New chip and attribute support in existing drivers

- nct6775: Support for ASUS CROSSHAIR VIII/TUF/ProArt B550M

- pmbus/ltc2978: Support for LTC7132

- aquacomputer_d5next: Support for temperature sensor offsets
  and flow sensor pulses

- coretemp: Support for dynamic ttarget and tjmax

Improvements

- Use devm_regulator_get_enable() where appropriate

- Use sysfs_emit() instead of scnprintf()

- Remove some useless #include <linux/hwmon-vid.h>

- Include <linux/kstrtox.h> when appropriate

- Use simple i2c probe

- it87: Check for a valid chip before using force_id, and new
  new module parameter to ignore ACPI resource conflicts

- jc42: Use regmap, and restore min/max/critical temperatures on resume

- Add reporting power good and status to PMBus based regulators

Last minute fixes

- emc2305: Fix probing of emc2301/2/3, and fix setting pwm values
  manually if THERMAL is enabled

Various other minor fixes and improvements

----------------------------------------------------------------
Ahmad Khalifa (2):
      hwmon: (it87) Add param to ignore ACPI resource conflicts
      hwmon: (it87) Check for a valid chip before using force_id

Aleksa Savic (3):
      hwmon: (aquacomputer_d5next) Add support for temperature sensor offsets
      hwmon: (aquacomputer_d5next) Clear up macros and comments
      hwmon: (aquacomputer_d5next) Add support for Quadro flow sensor pulses

Armin Wolf (1):
      hwmon: (dell-smm) Move error message to make probing silent

Christophe JAILLET (3):
      hwmon: Include <linux/kstrtox.h> when appropriate
      hwmon: Remove some useless #include <linux/hwmon-vid.h>
      hwmon: (gsc-hwmon) Switch to flexible array to simplify code

Colin Ian King (1):
      hwmon: (fschmd) Make const arrays static const

Denis Pauk (1):
      hwmon: (nct6775) add ASUS CROSSHAIR VIII/TUF/ProArt B550M

Felix Nieuwenhuizen (1):
      hwmon: (pmbus/ltc2978) add support for LTC7132

Frank Crawford (1):
      hwmon: (it87) Add DMI table for future extensions

Jeremy Kerr (1):
      hwmon: (occ) OCC sensors aren't arch-specific

Joaquín Ignacio Aramendía (3):
      hwmon: add OneXPlayer mini AMD sensors driver
      hwmon: (oxp-sensors) Add AOK ZOE and Mini PRO
      hwmon: (oxp-sensors) Fix pwm reading

Martin Blumenstingl (3):
      hwmon: (jc42) Convert register access and caching to regmap/regcache
      hwmon: (jc42) Restore the min/max/critical temperatures on resume
      hwmon: (jc42) Consistently use bit and bitfield macros in the driver

Matti Vaittinen (2):
      hwmon: (lm90) simplify using devm_regulator_get_enable()
      hwmon: (adm1177) simplify using devm_regulator_get_enable()

Nathan Chancellor (1):
      hwmon: (smpro-hwmon) Improve switch statments in smpro_is_visible()

Patrick Rudolph (2):
      hwmon: (pmbus) Add power good support
      hwmon: (pmbus/core) Implement regulator get_status

Quan Nguyen (3):
      hwmon: Add Ampere's Altra smpro-hwmon driver
      docs: hwmon: (smpro-hwmon) Add documentation
      docs: hwmon: (smpro-hwmon) Improve grammar and formatting

Stephen Kitt (1):
      hwmon: use simple i2c probe

Xingjiang Qiao (2):
      hwmon: (emc2305) fix unable to probe emc2301/2/3
      hwmon: (emc2305) fix pwm never being able to set lower

Yang Yingliang (1):
      hwmon: (jc42) Fix missing unlock on error in jc42_write()

Zhang Rui (4):
      hwmon: (coretemp) Remove obsolete temp_data->valid
      hwmon: (coretemp) rearrange tjmax handing code
      hwmon: (coretemp) Add support for dynamic tjmax
      hwmon: (coretemp) Add support for dynamic ttarget

ye xingchen (1):
      hwmon: use sysfs_emit() to instead of scnprintf()

 Documentation/hwmon/aquacomputer_d5next.rst |   4 +-
 Documentation/hwmon/index.rst               |   2 +
 Documentation/hwmon/oxp-sensors.rst         |  44 +++
 Documentation/hwmon/smpro-hwmon.rst         | 102 ++++++
 MAINTAINERS                                 |   6 +
 drivers/hwmon/Kconfig                       |  20 ++
 drivers/hwmon/Makefile                      |   2 +
 drivers/hwmon/adm1177.c                     |  27 +-
 drivers/hwmon/aht10.c                       |   5 +-
 drivers/hwmon/aquacomputer_d5next.c         | 233 ++++++++++----
 drivers/hwmon/atxp1.c                       |   1 +
 drivers/hwmon/coretemp.c                    | 242 +++++++++------
 drivers/hwmon/dell-smm-hwmon.c              |   3 +-
 drivers/hwmon/ds1621.c                      |   2 +-
 drivers/hwmon/emc2305.c                     |  48 +--
 drivers/hwmon/fschmd.c                      |   4 +-
 drivers/hwmon/gpio-fan.c                    |   1 +
 drivers/hwmon/gsc-hwmon.c                   |   6 +-
 drivers/hwmon/hwmon.c                       |   1 +
 drivers/hwmon/it87.c                        |  90 ++++--
 drivers/hwmon/jc42.c                        | 273 +++++++++-------
 drivers/hwmon/lm73.c                        |   6 +-
 drivers/hwmon/lm90.c                        |  21 +-
 drivers/hwmon/ltc2992.c                     |   4 +-
 drivers/hwmon/max127.c                      |   5 +-
 drivers/hwmon/mr75203.c                     |   1 +
 drivers/hwmon/nct6775-platform.c            |   7 +
 drivers/hwmon/occ/Kconfig                   |   2 -
 drivers/hwmon/oxp-sensors.c                 | 284 +++++++++++++++++
 drivers/hwmon/pcf8591.c                     |   1 +
 drivers/hwmon/pmbus/ltc2978.c               |  17 +-
 drivers/hwmon/pmbus/pmbus_core.c            |  52 +++-
 drivers/hwmon/pmbus/q54sj108a2.c            |   1 +
 drivers/hwmon/sbrmi.c                       |   5 +-
 drivers/hwmon/sbtsi_temp.c                  |   5 +-
 drivers/hwmon/sht3x.c                       |  12 +-
 drivers/hwmon/sht4x.c                       |   5 +-
 drivers/hwmon/smpro-hwmon.c                 | 466 ++++++++++++++++++++++++++++
 drivers/hwmon/vt8231.c                      |   1 -
 drivers/hwmon/w83l786ng.c                   |   1 -
 include/linux/hwmon-sysfs.h                 |   1 +
 include/linux/platform_data/gsc_hwmon.h     |   5 +-
 42 files changed, 1611 insertions(+), 407 deletions(-)
 create mode 100644 Documentation/hwmon/oxp-sensors.rst
 create mode 100644 Documentation/hwmon/smpro-hwmon.rst
 create mode 100644 drivers/hwmon/oxp-sensors.c
 create mode 100644 drivers/hwmon/smpro-hwmon.c
