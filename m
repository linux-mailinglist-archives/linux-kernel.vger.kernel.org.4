Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC3769962A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjBPNpe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Feb 2023 08:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBPNp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:45:29 -0500
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2F9497CE;
        Thu, 16 Feb 2023 05:45:05 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id cq19so2932372edb.5;
        Thu, 16 Feb 2023 05:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPonWqFXsekuucGX5b5eF6m2+CDmK7DqRteKQPPcqmU=;
        b=Oeci1ZQo3/mnxTiCcDIv2poMcSYgfzqgyBmXO+Qe1SOHRdufG/uaQMgBkFufv6Dl8F
         3L03q6PfSZFplMPqWdPnXXxLts3GAdyb15prWKblA3aTbIBpRKLWWNSTs00ZBNRRXeRd
         2tOZ1KNmPTPYgz7ovvBSkyQuTIyQtudNagvgdVvSXuBZkez6KW7pgWomnvSQxXIBA/ug
         PP2duNipEijRjVcMJNr9p3q5hzh72ceUnbR8euVcJ8u+zwk0IAWILhXN6o8igZAj593n
         2Wv0rU8wHWGme8n2GYcXP3/BBJF/L8TnYbziz6XrDrZCXqaO/sDSrXFGCWlv0dywme1a
         zvVw==
X-Gm-Message-State: AO0yUKXvQ5e9isT+K5xNjtYy5uzKNiOSCvb8bjeyFLR7BeTiPJhUw7+q
        VZUolxgcQITevtURVC2ML4pzxMLHYI1s0b0qdRmH6GD0nzE=
X-Google-Smtp-Source: AK7set/yCshiRuwwdi0hvn0f2M6idbDrjchYN3ktvkVwRc5O+9X6toKkkFymIxryNkjjpkM70AxwQ2ybGg3BNw83/bk=
X-Received: by 2002:a50:9b5e:0:b0:4ac:ce87:3e5a with SMTP id
 a30-20020a509b5e000000b004acce873e5amr2936047edj.3.1676555027544; Thu, 16 Feb
 2023 05:43:47 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 16 Feb 2023 14:43:36 +0100
Message-ID: <CAJZ5v0gvSyhzfvqSZk3qFMMPJ66dJOyk_1Ti-1cMgZFKBtzVbA@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v6.3-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I'm sending this ahead of time, because I will be traveling next week
and I don't want to delay the integration of the changes below just
because of my absence.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.3-rc1

with top-most commit f32309c4d08dbac74d3253ac8310bfcad4e21606

 Merge branches 'acpi-video', 'acpi-misc' and 'acpi-docs'

on top of commit 4ec5183ec48656cec489c49f989c508b68b518e3

 Linux 6.2-rc7

to receive ACPI updates for 6.3-rc1.

These fix a frequency limit issue in the ACPI processor performance
library code, fix a few issues in the ACPICA code, improve Crystal Cove
support in the ACPI PMIC driver, fix string handling in the ACPI battery
driver, add IRQ override quirks for a few machines more, fix other
assorted problems and clean up code and documentation.

Specifics:

 - Drop port I/O validation for some regions to avoid AML failures due
   to rejections of legitimate port I/O writes (Mario Limonciello).

 - Constify acpi_get_handle() pathname argument to allow its callers to
   pass const pathnames to it (Sakari Ailus).

 - Prevent acpi_ns_simple_repair() from crashing in some cases when
   AE_AML_NO_RETURN_VALUE should be returned (Daniil Tatianin).

 - Fix typo in CDAT DSMAS struct definition (Lukas Wunner).

 - Drop an unnecessary (void *) conversion from the ACPI processor
   driver (Zhou jie).

 - Modify the ACPI processor performance library code to use the "no
   limit" frequency QoS as appropriate and adjust the intel_pstate
   driver accordingly (Rafael Wysocki).

 - Add support for NBFT to the ACPI table parser (Stuart Hayes).

 - Introduce a list of known non-PNP devices to avoid enumerating some of
   them as PNP devices (Rafael Wysocki).

 - Add x86 ACPI paths to the ACPI entry in MAINTAINERS to allow scripts
   to report the actual maintainers information (Rafael Wysocki).

 - Add two more entries to the ACPI IRQ override quirk list (Adam
   Niederer, Werner Sembach).

 - Add a pmic_i2c_address entry for Intel Bay Trail Crystal Cove to
   allow intel_soc_pmic_exec_mipi_pmic_seq_element() to be used with
   the Bay Trail Crystal Cove PMIC OpRegion driver (Hans de Goede).

 - Add comments with DSDT power OpRegion field names to the ACPI PMIC
   driver (Hans de Goede).

 - Fix string termination handling in the ACPI battery driver (Armin
   Wolf).

 - Limit error type to 32-bit width in the ACPI APEI error injection
   code (Shuai Xue).

 - Fix Lenovo Ideapad Z570 DMI match in the ACPI backlight driver (Hans
   de Goede).

 - Silence missing prototype warnings in some places in the ACPI-related
   code (Ammar Faizi).

 - Make kobj_type structures used in the ACPI code constant (Thomas
   Weißschuh).

 - Correct spelling in firmware-guide/ACPI (Randy Dunlap).

 - Clarify the meaning of Explicit and Implicit in the _DSD GPIO
   properties documentation (Andy Shevchenko).

 - Fix some kernel-doc comments in the ACPI CPPC library code (Yang Li).

Thanks!


---------------

Adam Niederer (1):
      ACPI: resource: Add IRQ overrides for MAINGEAR Vector Pro 2 models

Ammar Faizi (1):
      ACPI: Silence missing prototype warnings

Andy Shevchenko (1):
      Documentation: firmware-guide: gpio-properties: Clarify Explicit
and Implicit

Armin Wolf (3):
      ACPI: battery: Fix missing NUL-termination with large strings
      ACPI: battery: Fix buffer overread if not NUL-terminated
      ACPI: battery: Increase maximum string length

Daniil Tatianin (1):
      ACPICA: nsrepair: handle cases without a return value correctly

Hans de Goede (3):
      ACPI: PMIC: Add pmic_i2c_address to BYT Crystal Cove support
      ACPI: PMIC: Add comments with DSDT power opregion field names
      ACPI: video: Fix Lenovo Ideapad Z570 DMI match

Lukas Wunner (1):
      ACPICA: Fix typo in CDAT DSMAS struct definition

Mario Limonciello (1):
      ACPICA: Drop port I/O validation for some regions

Rafael J. Wysocki (5):
      ACPI: processor: perflib: Use the "no limit" frequency QoS
      ACPI: processor: perflib: Avoid updating frequency QoS unnecessarily
      cpufreq: intel_pstate: Drop ACPI _PSS states table patching
      ACPI: PNP: Introduce list of known non-PNP devices
      MAINTAINERS: Add x86 ACPI paths to the ACPI entry

Randy Dunlap (1):
      Documentation: firmware-guide/ACPI: correct spelling

Sakari Ailus (1):
      ACPICA: Constify pathname argument for acpi_get_handle()

Shuai Xue (1):
      ACPI: APEI: EINJ: Limit error type to 32-bit width

Stuart Hayes (1):
      ACPI: tables: Add support for NBFT

Thomas Weißschuh (1):
      ACPI: make kobj_type structures constant

Werner Sembach (1):
      ACPI: resource: Do IRQ override on all TongFang GMxRGxx

Yang Li (1):
      ACPI: CPPC: Fix some kernel-doc comments

Zhou jie (1):
      ACPI: processor: idle: Drop unnecessary (void *) conversion

---------------

 Documentation/firmware-guide/acpi/acpi-lid.rst     |  2 +-
 .../firmware-guide/acpi/gpio-properties.rst        | 35 +++++++++++++-------
 Documentation/firmware-guide/acpi/namespace.rst    |  2 +-
 MAINTAINERS                                        |  5 ++-
 drivers/acpi/acpi_lpit.c                           |  1 +
 drivers/acpi/acpi_pnp.c                            | 14 +++++++-
 drivers/acpi/acpica/hwvalid.c                      |  7 ++--
 drivers/acpi/acpica/nsrepair.c                     | 12 ++++---
 drivers/acpi/acpica/nsxfname.c                     |  2 +-
 drivers/acpi/apei/einj.c                           |  4 +++
 drivers/acpi/battery.c                             | 35 +++++++++++++-------
 drivers/acpi/cppc_acpi.c                           |  4 ++-
 drivers/acpi/device_sysfs.c                        |  2 +-
 drivers/acpi/ioapic.c                              |  1 +
 drivers/acpi/pmic/intel_pmic_bytcrc.c              |  1 +
 drivers/acpi/pmic/intel_pmic_chtdc_ti.c            | 26 +++++++--------
 drivers/acpi/processor_idle.c                      |  2 +-
 drivers/acpi/processor_perflib.c                   | 38 +++++++++++++++++-----
 drivers/acpi/resource.c                            | 26 ++++++++++++---
 drivers/acpi/sysfs.c                               |  2 +-
 drivers/acpi/tables.c                              |  3 +-
 drivers/acpi/video_detect.c                        |  2 +-
 drivers/cpufreq/intel_pstate.c                     | 14 --------
 include/acpi/acpixf.h                              |  2 +-
 include/acpi/actbl1.h                              |  4 ++-
 25 files changed, 163 insertions(+), 83 deletions(-)
