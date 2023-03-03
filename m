Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0CD6A9E42
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjCCSQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjCCSQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:16:32 -0500
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B8C11146;
        Fri,  3 Mar 2023 10:16:31 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id da10so13856184edb.3;
        Fri, 03 Mar 2023 10:16:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677867389;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VMX1t05T7QSbYg8k7aZKELcNeVeqU+8hDYgRPVnIUM8=;
        b=vBgj5rAARjLgRwc3fevhIpYhTmOQR/iDkDE7ETCnTEDxhDZJJqQ0wbrvyJXLOMR+ym
         nMVjix8KqtruwG+qdjCV70QB0rX6Biy0ul9yGgDVwjOCZ7MNfdtgHpxyz6V6Js5p16z7
         2fxFercN1rWmvsjStOwz66di1pGqJi2k7Lt5Kw9+wELbbpU9f8JamCf7KvOcDNp0U3Zv
         PAt/m+3FaRsTwcfxDqrEhKSRDW7FRokAMmEXG7XLz7R24nqGclJp13NxOOC3c/yP+agj
         IQkFGxXNNpd6V6yV401V/QRmtiM2FLXboRK6sCbmResalS9pyHFa4WS/0icpPuh3w6J7
         TX9w==
X-Gm-Message-State: AO0yUKVpBb3B25ZmDF5eCaflrmOYCCukjRVp/zr3kJrx5MFKv3056l0a
        xtkBdk3ikyHVUQP23y32uSh2TNPl9yu71gsq/CKqw0tPc9s=
X-Google-Smtp-Source: AK7set8xKLjlEoqACTsPVfVhpc7x6npRrpqzgKZ4vpEajmCtWNfJ40R6hrT1lFbbaZFuX5TWjnSz5ebtNBlVaVFG/Z0=
X-Received: by 2002:a17:906:618:b0:8a6:91d9:c7ac with SMTP id
 s24-20020a170906061800b008a691d9c7acmr1338676ejb.5.1677867389474; Fri, 03 Mar
 2023 10:16:29 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 3 Mar 2023 19:16:18 +0100
Message-ID: <CAJZ5v0jwa5wpitjs+wf--ndk4k5zpM4iuXV6gzxAoB4UmnKUfQ@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v6.3-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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
 acpi-6.3-rc1-2

with top-most commit 57b76324c2a03b7b75d2d93f5c83f4340fd9b621

 Merge branches 'acpi-pm' and 'acpi-x86'

on top of commit 88af9b164c7a25a71b1a1a699872b869e2e84c77

 Merge tag 'acpi-6.3-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more ACPI updates for 6.3-rc1.

These update ACPI quirks for some x86 platforms and add an IRQ override
quirk for one more system.

Specifics:

 - Add an ACPI IRQ override quirk for Asus Expertbook B2402FBA (Vojtech
   Hejsek).

 - Drop a suspend-to-idle quirk for HP Elitebook G9 that is not needed
   any more after a firmware update (Mario Limonciello).

 - Add all Cezanne systems to the list for forcing StorageD3Enable,
   because they all need the same quirk (Mario Limonciello).

Thanks!


---------------

Mario Limonciello (2):
      ACPI: x86: Drop quirk for HP Elitebook
      ACPI: x86: utils: Add Cezanne to the list for forcing StorageD3Enable

Vojtech Hejsek (1):
      ACPI: resource: Skip IRQ override on Asus Expertbook B2402FBA

---------------

 drivers/acpi/resource.c   |  7 +++++++
 drivers/acpi/x86/s2idle.c | 24 ------------------------
 drivers/acpi/x86/utils.c  | 37 +++++++++++++------------------------
 3 files changed, 20 insertions(+), 48 deletions(-)
