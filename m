Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BCA659A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 17:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbiL3QfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 11:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbiL3Qey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 11:34:54 -0500
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCF21C413;
        Fri, 30 Dec 2022 08:34:52 -0800 (PST)
Received: by mail-io1-f46.google.com with SMTP id q190so11329824iod.10;
        Fri, 30 Dec 2022 08:34:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZa9jFc0rYlW/9i71Z6myIIyNiNlltKYl5kYSw6SvQs=;
        b=W/K5zN95VhjSS6SB5s/k8+eVWfqx2bEOG940beJ1j469HdaGZ78WAxR2IHF5I+/FOf
         /K5GkFDiaYuNf2JmeUX9gAnvEh72nzlO5LHqkOFup8RkXXYgxcb37cpNhjT1odHxzqkL
         d0ikjRki135XKek9oGA3+3all4tsrgE7L5JRFFRYqOoM/vJqaPv6A291o45rUkGUaGP0
         i4gBuT8EPoYNAGJpVFKz4AvovDEZ7tLzO3z4fJZDzhkPAFDzScOkKAI7NVCh5f6+Z+jV
         QKGnirTQjQxqnBIX/Nkj4apuKMJJVDg1LAI0Wtc4F2iY69ZbpwkiDdV6uQBOtvTgjCox
         2blw==
X-Gm-Message-State: AFqh2koknlxMvnDDVPauxd9n0/kRq5tyKu3J1CEZ0/Bc3XblsJuDLFK3
        Suzd4kv6K+NQz8QDmarFT2vQJkdhETNcl6mlcXZ8beoKmOc=
X-Google-Smtp-Source: AMrXdXvEShAMrQSZAI4E82NI7DN4CJwEfGZ2mIXmEQ1/N4IDPgOFOJvUM/AjG3AhxajWllnwwmc0EkUyGkyFsXB+TJQ=
X-Received: by 2002:a5e:8808:0:b0:6e2:bed4:c2d5 with SMTP id
 l8-20020a5e8808000000b006e2bed4c2d5mr1850046ioj.177.1672418092227; Fri, 30
 Dec 2022 08:34:52 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Dec 2022 17:34:40 +0100
Message-ID: <CAJZ5v0iP4EgejNBO8EXejaSObSbpeuOh+vTz8CAvfu8bMXXTOQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.2-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
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
 acpi-6.2-rc2

with top-most commit 0948a9ef1d59d1bc7fae29f32058e463bbff4a6c

 Merge branches 'acpi-resource' and 'acpi-video'

on top of commit 057b40f43ce429a02e793adf3cfbf2446a19a38e

 Merge tag 'acpi-6.2-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive ACPI fixes for 6.2-rc2.

These are new ACPI IRQ override quirks, low-power S0 idle (S0ix) support
adjustments and ACPI backlight handling fixes, mostly for platforms
using AMD chips.

Specifics:

 - Add ACPI IRQ override quirks for Asus ExpertBook B2502, Lenovo
   14ALC7, and XMG Core 15 (Hans de Goede, Adrian Freund,  Erik
   Schumacher).

 - Adjust ACPI video detection fallback path to prevent non-operational
   ACPI backlight devices from being created on systems where the native
   driver does not detect a suitable panel (Mario Limonciello).

 - Fix Apple GMUX backlight detection (Hans de Goede).

 - Add a low-power S0 idle (S0ix) handling quirk for HP Elitebook 865
   and stop using AMD-specific low-power S0 idle code path for systems
   with Rembrandt chips and newer (Mario Limonciello).

Thanks!


---------------

Adrian Freund (1):
      ACPI: resource: do IRQ override on Lenovo 14ALC7

Erik Schumacher (1):
      ACPI: resource: do IRQ override on XMG Core 15

Hans de Goede (2):
      ACPI: resource: Add Asus ExpertBook B2502 to Asus quirks
      ACPI: video: Fix Apple GMUX backlight detection

Mario Limonciello (5):
      ACPI: video: Allow GPU drivers to report no panels
      drm/amd/display: Report to ACPI video if no panels were found
      ACPI: video: Don't enable fallback path for creating ACPI
backlight by default
      ACPI: x86: s2idle: Force AMD GUID/_REV 2 on HP Elitebook 865
      ACPI: x86: s2idle: Stop using AMD specific codepath for Rembrandt+

---------------

 drivers/acpi/acpi_video.c                         | 17 +++--
 drivers/acpi/resource.c                           | 32 ++++++++-
 drivers/acpi/video_detect.c                       | 23 +++++-
 drivers/acpi/x86/s2idle.c                         | 87 ++++-------------------
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 ++
 include/acpi/video.h                              |  2 +
 6 files changed, 82 insertions(+), 83 deletions(-)
