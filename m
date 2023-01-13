Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447B0669526
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241396AbjAMLNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240690AbjAMLMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:12:39 -0500
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2404175BF;
        Fri, 13 Jan 2023 03:06:36 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id tz12so51502326ejc.9;
        Fri, 13 Jan 2023 03:06:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sRZeMtjUCAHe3DkHzl3hYIUz9GOxQ9jJ2UHCUwleMtc=;
        b=ZCYDDRkP84pltSFvgaa7OSZ+RlpC1HZ4CrVCRJiNGYd4QxgTYrPNTgN20s5Us0lFVH
         5Zkhhxg4A7CHuksF8NCGDV53ahzt4NDplsigf74Z0q+WlWcflg9/Vtlu61uUR4EM6tGn
         aO9DNBoK/YJLgYm3p4gyQKYrI1QXld4togdVBNDluLFkfj1wjkTeRZngwBS1mf7RNAp7
         9ejPxYdxytfqW/CJ2k1/Pajv6Dq1HbpYQciK+f2xCWewJpvDRkk/JPtuow0LpS0cTt7X
         mkPszxIL0DlWwRV+3AH9hoEMLcP7fMnR6uDZ3DX0nmvMSoXsf76EpK26xhDKeiPV6vSB
         0r0w==
X-Gm-Message-State: AFqh2kqGtZVtjqq52D4JRzcmNWEPz0YNRJlOhjVEEZpCjms78QNoNTIU
        kTUc/DX9wJqb+xzsS+4Tapi5F8cnglnpwCJU0GtqU2ym2uM=
X-Google-Smtp-Source: AMrXdXuPhSTRstadzE/DvnXUNnyniMZpcSm8Z7Dbbs8iHqiTJ84KNeuXCmAWP3QEczTk11HMiCRymvGYDARSw37MTkI=
X-Received: by 2002:a17:907:8c85:b0:86a:edd1:29da with SMTP id
 td5-20020a1709078c8500b0086aedd129damr77190ejc.478.1673607995118; Fri, 13 Jan
 2023 03:06:35 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 13 Jan 2023 12:06:23 +0100
Message-ID: <CAJZ5v0hTgcWELD7-4SUZdMpm+CQHS+CRfzshjsHL9iAerE98mw@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.2-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.2-rc4

with top-most commit df3a71aba40fbe4bbd0842170e70c236eaed7c40

 Merge branches 'acpi-resource' and 'acpi-video'

on top of commit b7bfaa761d760e72a969d116517eaa12e404c262

 Linux 6.2-rc3

to receive ACPI fixes for 6.2-rc4.

These add one more ACPI IRQ override quirk, improve ACPI companion
lookup for backlight devices and add missing kernel command line
option values for backlight detection.

Specifics:

 - Improve ACPI companion lookup for backlight devices in the cases when
   there is more than one candidate ACPI device object (Hans de Goede).

 - Add missing support for manual selection of NVidia-WMI-EC or Apple
   GMUX backlight in the kernel command line to the ACPI backlight
   driver (Hans de Goede).

 - Skip ACPI  IRQ override on Asus Expertbook B2402CBA (Tamim Khan).

Thanks!


---------------

Hans de Goede (2):
      ACPI: video: Allow selecting NVidia-WMI-EC or Apple GMUX
backlight from the cmdline
      ACPI: Fix selecting wrong ACPI fwnode for the iGPU on some Dell laptops

Tamim Khan (1):
      ACPI: resource: Skip IRQ override on Asus Expertbook B2402CBA

---------------

 drivers/acpi/glue.c         | 14 ++++++++++++--
 drivers/acpi/resource.c     |  7 +++++++
 drivers/acpi/scan.c         |  7 +++++--
 drivers/acpi/video_detect.c |  4 ++++
 include/acpi/acpi_bus.h     |  3 ++-
 5 files changed, 30 insertions(+), 5 deletions(-)
