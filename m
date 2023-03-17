Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BEC6BEDC4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjCQQLl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Mar 2023 12:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjCQQLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:11:39 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A4F3FBA1;
        Fri, 17 Mar 2023 09:11:38 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id x3so22337681edb.10;
        Fri, 17 Mar 2023 09:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679069496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+UuCf1PJrLrKxIyaFZnzsznvIqEjzKrZTS2+zfLkrvo=;
        b=OsjUPyKkLqc8ePxtbGuhJN1+e65dAUXglNyL6AqLweZgKNYfhFSiB2I/Dl7Cee1vLh
         EuAOtjVvN79QBGGZT0wedEuNegbVZkI3YYPyBZZfupQXGPYBH5ay/rENqF6zJvVIfNeJ
         ZQ8pyzuO2AhzHslqD5luDtdU+pIf08pqJ1NNqTdx98EJpWuC3ThGzJJYfaczqO8aLSnz
         Vb3FlrCIQV4DOLOKxFtfbo7eNSzh5wK+oTP6HPWunuOjePF23/eRGOV3HctN0OGEiDw6
         8osH4MGgH3GO6VgQMBXdgBbuzvBjIProvd0DaNZePD/1H/cfAkHHXvCn3yQb4H/bqC5G
         A/3Q==
X-Gm-Message-State: AO0yUKXiDoe7+NgY1+BAotUHQWo8K33hozZp5PnAYyiIiYTPrWD4uYYn
        DttLep4+p/CDgG24NUjfjcEvb8Nn20VjNMt6E9HaFx1HpQo=
X-Google-Smtp-Source: AK7set/XlV/hK+svbmdvfHJLFqE5tbYJnuPdfxiFpfDtsjGq+4WkW2g5cdrxn50qVpzpdKjZtUvhgHIObXZNKqjpUeo=
X-Received: by 2002:a50:9ecf:0:b0:4fa:b302:6168 with SMTP id
 a73-20020a509ecf000000b004fab3026168mr738078edf.3.1679069496484; Fri, 17 Mar
 2023 09:11:36 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Mar 2023 17:11:25 +0100
Message-ID: <CAJZ5v0gOXYVLXkPmk6_9r+Gwa+FXMdVXZBvjJsY--KW2MOC_tg@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.3-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.3-rc3

with top-most commit f36cc6cd65204352815640a34e37ef39e56fbd42

 Merge branches 'acpi-video', 'acpi-x86', 'acpi-tools' and 'acpi-docs'

on top of commit eeac8ede17557680855031c6f305ece2378af326

 Linux 6.3-rc2

to receive ACPI fixes for 6.3-rc3.

These add some new quirks, fix PPTT handling, fix an ACPI utility and correct a
mistake in the ACPI documentation.

Specifics:

 - Fix ACPI PPTT handling to avoid sleep in the atomic context when it
   is not present (Sudeep Holla).

 - Add backlight=native DMI quirk for Dell Vostro 15 3535 to the ACPI
   video driver (Chia-Lin Kao).

 - Add ACPI quirks for I2C device enumeration on Lenovo Yoga Book X90
   and Acer Iconia One 7 B1-750 (Hans de Goede).

 - Fix handling of invalid command line option values in the ACPI pfrut
   utility (Chen Yu).

 - Fix references to I2C device data type in the ACPI documentation for
   device enumeration (Andy Shevchenko).

Thanks!


---------------

Andy Shevchenko (1):
      ACPI: docs: enumeration: Correct reference to the I²C device data type

Chen Yu (1):
      ACPI: tools: pfrut: Check if the input of level and type is in
the right numeric range

Chia-Lin Kao (AceLan) (1):
      ACPI: video: Add backlight=native DMI quirk for Dell Vostro 15 3535

Hans de Goede (3):
      ACPI: x86: Introduce an acpi_quirk_skip_gpio_event_handlers() helper
      ACPI: x86: Add skip i2c clients quirk for Acer Iconia One 7 B1-750
      ACPI: x86: Add skip i2c clients quirk for Lenovo Yoga Book X90

Sudeep Holla (1):
      ACPI: PPTT: Fix to avoid sleep in the atomic context when PPTT is absent

---------------

 Documentation/firmware-guide/acpi/enumeration.rst |  2 +-
 drivers/acpi/pptt.c                               |  5 ++-
 drivers/acpi/video_detect.c                       |  7 ++++
 drivers/acpi/x86/utils.c                          | 45 +++++++++++++++++++++--
 drivers/gpio/gpiolib-acpi.c                       |  3 ++
 include/acpi/acpi_bus.h                           |  5 +++
 tools/power/acpi/tools/pfrut/pfrut.c              | 18 +++++++--
 7 files changed, 77 insertions(+), 8 deletions(-)
