Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0112B67E89C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjA0OtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbjA0OtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:49:01 -0500
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F5083956;
        Fri, 27 Jan 2023 06:48:55 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id v6so14352674ejg.6;
        Fri, 27 Jan 2023 06:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pDZSfvcweMhru3H4SpEh2Ne6HE/qZsteqzptlNMS+3M=;
        b=TrUDtI7E/XtzFMgv0zDmcFTHELihi3fEE/fH4OCturJM2Q4SrxNxQY0A0RbmmjQBBD
         8vZPi+onfcQuG3k9L3MoG5Lbef+inC0otweMlxwThdxQzxkVvnKhvwSd26voUiHieyAJ
         xs0pQC9dI6vh7CstQ23UQhed37yr1ykWO7K54WayDO2t2EfJIwYblqNNu9JEdvApWVYb
         SVL1+IgjpG7tDJxpY2O37OQ9Sb9Mr9nVCc1CK5dtkJyJ8DGuolizxeETJVRNz9NadoLG
         q+1OuYi0ecGrmnjXTjwXzhFLniZd66g5PX5GNAg16TdtePIE/SpV1uYWoOTKtngPPm5W
         oV8A==
X-Gm-Message-State: AFqh2koQHqDBYMi7ELhINnktrwXsM6hwP7x6rto6LU0Z3ki9ervuRTyK
        7dGoiCUMAQOhfF7534QSUDmQxKloa5T+Lmqc0FuaOJ8uiH4=
X-Google-Smtp-Source: AMrXdXvgbAnVMAmlLmX/wvyPnY+aujV2utm1wNw+PqU6ytWO/VEFWiY9drpmJ1iQxt1VdZSFknE91HHhNFi4xTKDoeM=
X-Received: by 2002:a17:907:c928:b0:85e:4218:c011 with SMTP id
 ui40-20020a170907c92800b0085e4218c011mr5227477ejc.258.1674830934217; Fri, 27
 Jan 2023 06:48:54 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 27 Jan 2023 15:48:43 +0100
Message-ID: <CAJZ5v0gPyShdVDECk=h6ouiqa5AsgV7sqvFC=DzJ3dhS_cw-Jw@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.2-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
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
 acpi-6.2-rc6

with top-most commit e6b3086fddc0065a5ffb947d4d29dd0e6efc327b

 ACPI: video: Add backlight=native DMI quirk for Asus U46E

on top of commit 2241ab53cbb5cdb08a6b2d4688feb13971058f65

 Linux 6.2-rc5

to receive ACPI fixes for 6.2-rc6.

These add ACPI backlight handling quirks for 3 machines (Hans de Goede).

Thanks!


---------------

Hans de Goede (3):
      ACPI: video: Add backlight=native DMI quirk for HP Pavilion g6-1d80nr
      ACPI: video: Add backlight=native DMI quirk for HP EliteBook 8460p
      ACPI: video: Add backlight=native DMI quirk for Asus U46E

---------------

 drivers/acpi/video_detect.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
