Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231586C8276
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjCXQgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjCXQgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:36:15 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA31A1ADE5;
        Fri, 24 Mar 2023 09:35:55 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id w9so10278034edc.3;
        Fri, 24 Mar 2023 09:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679675753;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MrnVY7/JvbPqM6S2QNIaAO6FxZevsd4diMztBpYJlLU=;
        b=mHpBQ1G5eprQRwSzwrwz3W0KK8/D1fh/rMMWIehNcO9FFYunZcb4i6pA2e6cH0xWhj
         /apEHZs+5fiUCeJ2X3YTpxLZQdtvbhyL1tICbdxX8dz5hI1ovP8KLDDDY57y7gKHbBj7
         Wv5Pi/8OOwTpDsxa//p58hNN5Wn3jgkr4aE+SQ+fxmpdEt3wgBv+vrdjowfp3vubWEiE
         3Jvhnpm7YyEeZiqjxPhk1NKHiO68wWHhBKZFehQBbPYoeWqFv68+3IcOCN1ngpfkVOEy
         Q3GH5GEQEN1j2FEfblNVwlruW0C6zz4QMhFdSqFu7RHdbPRsw2OwysChLCjunAAC2+aK
         9deQ==
X-Gm-Message-State: AAQBX9cvd41u4PVWIRK9LVvuQTjGYxu8llct5lk19mlm+lhCNMZCd4y0
        ymzOk8Jp4oWVgzqjG0jLQloP1kF/czEtldTEd9nqe36FlyY=
X-Google-Smtp-Source: AKy350bNkSHhwx2cbeDDe2roSx62l83DEWCfBLdnkVQ8HBwziYqo1eNVsJ+2YUorFLRaCht11FzjGydAHLizy4JLsBI=
X-Received: by 2002:a17:907:d687:b0:93d:a14f:c9b4 with SMTP id
 wf7-20020a170907d68700b0093da14fc9b4mr1756331ejc.2.1679675753447; Fri, 24 Mar
 2023 09:35:53 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Mar 2023 17:35:42 +0100
Message-ID: <CAJZ5v0iQq07J-DPcwFWndfASgQdb1dgm=3buJ9cDYer9rJ4Cug@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for v6.3-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.3-rc4

with top-most commit 6babf38d894bec696761c10fbfccafceae76f4eb

 Merge branch 'thermal-acpi'

on top of commit e8d018dd0257f744ca50a729e3d042cf2ec9da65

 Linux 6.3-rc3

to receive thermal control fixes for 6.3-rc4.

These address two recent regressions related to thermal control.

Specifics:

 - Restore the thermal core behavior regarding zero-temperature trip
   points to avoid a driver regression (Ido Schimmel).

 - Fix a recent regression in the ACPI processor driver preventing it
   from changing the number of CPU cooling device states exposed via
   sysfs after the given CPU cooling device has been registered (Rafael
   Wysocki).

Thanks!


---------------

Ido Schimmel (1):
      thermal: core: Restore behavior regarding invalid trip points

Rafael J. Wysocki (4):
      ACPI: processor: Reorder acpi_processor_driver_init()
      thermal: core: Introduce thermal_cooling_device_present()
      thermal: core: Introduce thermal_cooling_device_update()
      ACPI: processor: thermal: Update CPU cooling devices on cpufreq
policy changes

---------------

 drivers/acpi/processor_driver.c  |  12 ++---
 drivers/acpi/processor_thermal.c |  14 ++++--
 drivers/thermal/thermal_core.c   | 106 ++++++++++++++++++++++++++++++++++++---
 drivers/thermal/thermal_core.h   |   2 +
 drivers/thermal/thermal_sysfs.c  |  74 +++++++++++++++++++++++----
 include/linux/thermal.h          |   1 +
 6 files changed, 183 insertions(+), 26 deletions(-)
