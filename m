Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457A26C8263
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjCXQbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjCXQbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:31:21 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113C01F5DE;
        Fri, 24 Mar 2023 09:31:19 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id ek18so10165708edb.6;
        Fri, 24 Mar 2023 09:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679675478;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RK97WHvnbSxeF31vPM+iWGsfGGAagPtgVuDMTujX4W8=;
        b=uEDzyF6n4IVDWKksAD0DCtv/kVd3EmnDFrMAV7uyMUkB5Hd5RQg2KbtCpJY7NImEqh
         j5FRQ61ph5xlyO1zWZMEEvGVORGV5LHQom+rM3B8Yuk5ruR+nJ+Nom0aa4Yv6eJVbQsm
         EbeEl2wQixD1+/s+kAZUJfUYL+PRcMfhO+Oel6Xe1IQU/dW0sLJ0dl5qo6/BpD/aruYR
         xrIJ4Y/V4qbsknIPPSSOwGRHc4Q8ZcMsUSwHNU4ooVkW3UboSyMWM5gmUeqfZuzdy/OS
         N6RS7Dl5G2lB4S1xTSDAJcSxO+nX0pi9i6ZgNkolpzIsQJ0bY/X47ICFzE3LPHkx5nSj
         gL4w==
X-Gm-Message-State: AAQBX9eFpvAFE634ano9ce5/U3SKnL4OQHL+upwUbeNr9KrF6CwA6O9x
        GJhU4DUWWd6Q1Qdp0xo5vKkRB3lFRXDXy6yy/OOtjfSq8fY=
X-Google-Smtp-Source: AKy350ZbkphKyXdA397q1rltyqMH2ly45EQFFhEEWmOtxkpsRskS2kMgaGRycE1AmZFe8ADEYTWWqB+AXSVubQt8Od4=
X-Received: by 2002:a17:907:d687:b0:93d:a14f:c9b4 with SMTP id
 wf7-20020a170907d68700b0093da14fc9b4mr1749567ejc.2.1679675478193; Fri, 24 Mar
 2023 09:31:18 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Mar 2023 17:31:07 +0100
Message-ID: <CAJZ5v0i6K644j=JzU+uDcreEzv6KxFHav_MHw1TZvQNzvyoU1w@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.3-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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
 acpi-6.3-rc4

with top-most commit 8dbfa057b3f8e8402f639c0bf5fcbc4e43a8b3da

 Merge branch 'acpi-video'

on top of commit e8d018dd0257f744ca50a729e3d042cf2ec9da65

 Linux 6.3-rc3

to receive ACPI fixes for 6.3-rc4.

These add new ACPI IRQ override and backlight detection quirks.

Specifics:

 - Add backlight=native DMI quirk for Acer Aspire 3830TG to the ACPI
   backlight driver (Hans de Goede).

 - Add an ACPI IRQ override quirk for Medion S17413 (Aymeric Wibo).

Thanks!


---------------

Hans de Goede (1):
      ACPI: video: Add backlight=native DMI quirk for Acer Aspire 3830TG

Aymeric Wibo (1):
      ACPI: resource: Add Medion S17413 to IRQ override quirk

---------------

 drivers/acpi/resource.c     | 7 +++++++
 drivers/acpi/video_detect.c | 8 ++++++++
 2 files changed, 15 insertions(+)
