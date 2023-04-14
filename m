Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EED6E24D7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDNNzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjDNNzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:55:17 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F09E56;
        Fri, 14 Apr 2023 06:55:16 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id q23so36270950ejz.3;
        Fri, 14 Apr 2023 06:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681480515; x=1684072515;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E29rUimY6KHJCkSPS7CK4bBCLE3cMI8/M2AydXqPWoI=;
        b=NeR82GZZabXuc3GPH1/eMO6cqPc/PtzqRbYdPfrShii7afOrzLb7EGcj/3tMtAElM6
         SZdgcmH/OPTOZeeUY23ejFYrrLiQqxMSwofupu9SMj1KGu9EgXo/e+i3wHFoq/IsHKI2
         342+M/rWlPwGwbqjUG0jZ0AiDT/w9Ml8UwJPbZ4a9706hWVHMPjpMFViSL9DCIybAJOi
         HB4Be0yPzTMSRW6AIHhuFE8/Vq8TYiBXkFaKUgjJsi3j6wvUJXIcwRhV2CgD7Yk4u4IC
         Ee9jZNGNRTW/2z/AeqNKjojFQXnEtNqurdB4s12wf8v/MKvImix4lU/crU5nY1EhQ4ZU
         kGbw==
X-Gm-Message-State: AAQBX9cPQjXjmOZHj3NpIsPc4oFPczNgNjbPRnPQXAq1ljbtyNYtTpEZ
        lQ6XL3BK1VU84q0t2IPnk2XebUA4wbqf8YqoHbekZ6OGPF0=
X-Google-Smtp-Source: AKy350aNsfNFxe6baQpYHFWdqtN2faHb0Y/dkSnmf8jKHylwMnYDnR8DPOanMX9nzReVZlfkdVoIlgv6BO2mUXeqvBo=
X-Received: by 2002:a17:907:a409:b0:94e:7ce:4d1f with SMTP id
 sg9-20020a170907a40900b0094e07ce4d1fmr3159577ejc.2.1681480514929; Fri, 14 Apr
 2023 06:55:14 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Apr 2023 15:55:04 +0200
Message-ID: <CAJZ5v0jfYRyiMzu2S3KXueGvrux=5082SAsz81pN6zwDVvFDUA@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.3-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
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
 acpi-6.3-rc7

with top-most commit a3babdb7a8f73c3d8965b245fe1b758b87538912

 Merge branch 'acpi-x86'

on top of commit 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d

 Linux 6.3-rc6

to receive ACPI fixes for 6.3-rc7.

These add two ACPI-related quirks:

 - Add a quirk to force StorageD3Enable on AMD Picasso systems (Mario
   Limonciello).

 - Add an ACPI IRQ override quirk for ASUS ExpertBook B1502CBA (Paul
   Menzel).

Thanks!


---------------

Mario Limonciello (1):
      ACPI: x86: utils: Add Picasso to the list for forcing StorageD3Enable

Paul Menzel (1):
      ACPI: resource: Skip IRQ override on ASUS ExpertBook B1502CBA

---------------

 drivers/acpi/resource.c  | 7 +++++++
 drivers/acpi/x86/utils.c | 1 +
 2 files changed, 8 insertions(+)
