Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B55273E64E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjFZRUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjFZRUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:20:18 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38962D42;
        Mon, 26 Jun 2023 10:19:02 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-98de322d11fso72464766b.1;
        Mon, 26 Jun 2023 10:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687799941; x=1690391941;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Scuo3RTSEy9HAbnvign3czok0NUjBI7Za32zNXoAwp8=;
        b=TV445XSr5gQYwQQOtPnnHMV1qW8vNzp1XB4ttcWndWOeimaAkhGxTJ79Fongrh/eeO
         xys0aJwXV1Eojyzz2l/+T9KgCmTv15LnPwq5OtRwyrM8wKZX/PC+StcL0x+3sQVkPBiB
         dy4Mj7r3/jNvjda+UxssPBsjwE/qJQ2Bgu6tO8pN5Qm2lxw9FjqrppdL27qqo+2sSfl/
         2L1EfA7E0kejzGxDgVnSHpCx6q+Y58NALDOy2EzZ03Kidykxut21li3Oz3BYkDLBJeAn
         DlxX2xLlkPBcW6xDyONO/p0SK2TdbRJCnvbkBcs85TQNJYINqfVd/jf26AI5rgaVSGys
         csmg==
X-Gm-Message-State: AC+VfDzxH61D/kmgVgQ0YvIDoL9GtEDtbXQy85mkzeYa+QsB4bEZpg4r
        zWxXH200JmdXx77xlpvJjoyAWOw3CYLTtzTrDJPi1pHrCmc=
X-Google-Smtp-Source: ACHHUZ4kmBybpxSgtBU4QAemlbYO/AHphe8tPbmVYZu6MxX7HRZN2Xtdl0nHiCnX8aUFoglzPVjFSatW+UzwREtYaF0=
X-Received: by 2002:a17:906:74da:b0:976:50a4:ac40 with SMTP id
 z26-20020a17090674da00b0097650a4ac40mr23910375ejl.0.1687799941326; Mon, 26
 Jun 2023 10:19:01 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 26 Jun 2023 19:18:50 +0200
Message-ID: <CAJZ5v0h88c==8MP7H98oJo1tzY-i1isuru-axwLpSQ0ouG_COA@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v6.5-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.5-rc1

with top-most commit 01fee479846bb13139d339b11e04bf327200cac9

 Merge branches 'acpi-apei', 'acpi-pad' and 'acpi-misc'

on top of commit e660abd551f1172e428b4e4003de887176a8a1fd

 Merge tag 'acpi-6.4-rc8' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive ACPI updates for 6.5-rc1.

These rework the handling of notifications in ACPI button drivers (to
enable future simplifications and cleanups), clean up the ACPI thermal
driver, update the ACPI backlight driver, add quirks working around AML
bugs on some systems, fix some assorted issues and clean up code.

Specifics:

 - Reduce ACPI device enumeration overhead related to devices with
   dependencies (Rafael Wysocki).

 - Fix the handling of Microsoft LPS0 _DSM for suspend-to-idle (Mario
   Limonciello).

 - Fix section mismatch warning in the ACPI suspend-to-idle code (Arnd
   Bergmann).

 - Drop several ACPI resource management quirks related to IRQ overrides
   on AMD "Zen" systems (Mario Limonciello).

 - Modify the ACPI EC driver to make it only clear the EC GPE status
   when handling the GPE (Jeremy Compostella).

 - Add quirks to work around ACPI tables defects on Lenovo Yoga Book
   yb1-x90f/l and Nextbook Ares 8A (Hans de Goede).

 - Add ACPi backlight quirks for Dell Studio 1569, Lenovo ThinkPad X131e
   (3371 AMD version) and Apple iMac11,3 and stop trying to use vendor
   backlight control on relatively recent systems (Hans de Goede).

 - Add pwm_lookup_table entry for second PWM on CHT/BSW devices in the
   ACPI LPSS (Intel SoC) driver (Hans de Goede).

 - Add nfit_intel_shutdown_status() declaration to a local header to
   avoid a "missing prototypes" build warning (Arnd Bergmann).

 - Clean up the ACPI thermal driver and drop some dead or otherwise
   unneeded code from it (Rafael Wysocki).

 - Rework the handling of notifications in the ACPI button drivers so
   as to allow the common notification handling code for devices to be
   simplified (Rafael Wysocki).

 - Make ghes_get_devices() return NULL to indicate that there are no
   GHES devices so as to allow vendor-specific EDAC drivers to probe
   then (Li Yang).

 - Mark bert_disable() as __initdata and drop an unused function from
   the APEI GHES code (Miaohe Lin).

 - Make the ACPI PAD (Processor Aggregator Device) driver realize that
   Zhaoxin CPUs support nonstop TSC (Tony W Wang-oc).

 - Drop the certainly unnecessary and likely incorrect inclusion of
   linux/arm-smccc.h from acpi_ffh.c (Sudeep Holla).

Thanks!


---------------

Arnd Bergmann (2):
      ACPI: NFIT: Add declaration in a local header
      ACPI: PM: s2idle: fix section mismatch warning

Compostella, Jeremy (1):
      ACPI: EC: Clear GPE on interrupt handling only

Hans de Goede (8):
      ACPI: x86: Add skip i2c clients quirk for Nextbook Ares 8A
      ACPI: button: Add lid disable DMI quirk for Nextbook Ares 8A
      ACPI: x86: Add ACPI_QUIRK_UART1_SKIP for Lenovo Yoga Book yb1-x90f/l
      ACPI: video: Add backlight=native DMI quirk for Apple iMac11,3
      ACPI: video: Add backlight=native DMI quirk for Lenovo ThinkPad
X131e (3371 AMD version)
      ACPI: LPSS: Add pwm_lookup_table entry for second PWM on CHT/BSW devices
      ACPI: video: Stop trying to use vendor backlight control on
laptops from after ~2012
      ACPI: video: Add backlight=native DMI quirk for Dell Studio 1569

Li Yang (1):
      APEI: GHES: correctly return NULL for ghes_get_devices()

Mario Limonciello (2):
      ACPI: resource: Remove "Zen" specific match and quirks
      ACPI: x86: s2idle: Adjust Microsoft LPS0 _DSM handling sequence

Miaohe Lin (2):
      ACPI: APEI: GHES: Remove unused ghes_estatus_pool_size_request()
      ACPI: APEI: mark bert_disable as __initdata

Rafael J. Wysocki (12):
      ACPI: scan: Reduce overhead related to devices with dependencies
      ACPI: thermal: Use BIT() macro for defining flags
      ACPI: thermal: Drop redundant ACPI_TRIPS_REFRESH_DEVICES symbol
      ACPI: thermal: Move symbol definitions to one place
      ACPI: thermal: Move acpi_thermal_driver definition
      ACPI: thermal: Eliminate struct acpi_thermal_state_flags
      ACPI: button: Eliminate the driver notify callback
      ACPI: button: Use different notify handlers for lid and buttons
      ACPI: tiny-power-button: Eliminate the driver notify callback
      ACPI: bus: Simplify installation and removal of notify callback
      ACPI: thermal: Drop struct acpi_thermal_state
      ACPI: thermal: Drop struct acpi_thermal_flags

Sudeep Holla (1):
      ACPI: FFH: Drop the inclusion of linux/arm-smccc.h

Tony W Wang-oc (1):
      ACPI: PAD: mark Zhaoxin CPUs NONSTOP TSC correctly

---------------

 drivers/acpi/acpi_ffh.c          |   2 -
 drivers/acpi/acpi_lpss.c         |  10 +-
 drivers/acpi/acpi_pad.c          |   1 +
 drivers/acpi/apei/bert.c         |   2 +-
 drivers/acpi/apei/ghes.c         |   4 +-
 drivers/acpi/bus.c               |  53 ++------
 drivers/acpi/button.c            | 164 ++++++++++++++++------
 drivers/acpi/ec.c                |  31 +++--
 drivers/acpi/nfit/nfit.h         |   2 +
 drivers/acpi/resource.c          |  60 --------
 drivers/acpi/scan.c              |  81 ++++++++---
 drivers/acpi/sleep.c             |   2 +-
 drivers/acpi/thermal.c           | 287 +++++++++++++++++----------------------
 drivers/acpi/tiny-power-button.c |  49 +++++--
 drivers/acpi/video_detect.c      |  45 ++++++
 drivers/acpi/x86/s2idle.c        |  14 +-
 drivers/acpi/x86/utils.c         |  26 +++-
 include/acpi/acpi_bus.h          |   2 +
 18 files changed, 459 insertions(+), 376 deletions(-)
