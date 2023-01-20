Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D1F675C63
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjATSEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjATSEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:04:40 -0500
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF564ED21;
        Fri, 20 Jan 2023 10:04:39 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id mp20so15928274ejc.7;
        Fri, 20 Jan 2023 10:04:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4yUiTs4/I96zb6GeOJNt6u1+rMYoVnhmy+Iw64l4AV4=;
        b=yZfu33l/GY1Ry/yjpeYrTQmjWaZZdaHdofJc/SbuSuER/bH6a0ziVRzZ8kPYKP0K27
         YUoM0HVEI8iPVHQLWpAyRwLeI28QtPKmfXZtwqE9Hiw4khtqFQRdLFj8KGqxpoYruPlh
         hGon6GAU4fl9lajz8oClPT32S5CrzqNAtyZIL2/6u847An83WglGioagDZmKHn8Cq77h
         qQS3JbxYMfILgfh8t7Q9JZqvut7iBQ3ZYUx2qSa1vcDnfRzmuA+O0JyIEuWIt/itGmBt
         FOV0PBtQxrjjo0U3qqJuafLUUCmY9BMYa74kVEtOSafpXVb/jDRKnhsXQCvQYiYAW83l
         P8QQ==
X-Gm-Message-State: AFqh2kpuuFUo3Y8ehZ9w9kS7rIblklUnIAh6zonRPQ2kZL2Q92aWsbPP
        qXKD9W90eR6uvqHfI3rbUynHVHAcXv5LAeqv31dB1HWaWM4=
X-Google-Smtp-Source: AMrXdXvhmyM3zFN5s6ugW5DuMGqITWftkHw/6I1QsQUJZDv0Z5/op/Z5pH0Uwsmjgwa2UlPbTGD/U3Kpc1p4bOMtPR8=
X-Received: by 2002:a17:907:8b88:b0:872:dae4:1ef7 with SMTP id
 tb8-20020a1709078b8800b00872dae41ef7mr1366576ejc.84.1674237878556; Fri, 20
 Jan 2023 10:04:38 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Jan 2023 19:04:27 +0100
Message-ID: <CAJZ5v0gFO1nANyUZG9TPiRBNTN8hOJNmgSDb6LE8JtCF5K4+=Q@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.2-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
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
 acpi-6.2-rc5

with top-most commit 3bdd346ebda37f4cb12461d5e83a5b9d575afc63

 Merge branches 'acpi-prm' and 'acpi-video'

on top of commit 5dc4c995db9eb45f6373a956eb1f69460e69e6d4

 Linux 6.2-rc4

to receive ACPI fixes for 6.2-rc5.

These update the ACPICA entry in MAINTAINERS, add a backlight handling
quirk and fix the ACPI PRM (platform runtime) mechanism support.

Specifics:

 - Update the ACPICA development list address in MAINTAINERS to the new
   one that does not bounce (Rafael Wysocki).

 - Check whether EFI runtime is available when registering the ACPI PRM
   address space handler and when running it (Ard Biesheuvel).

 - Add backlight=native DMI quirk for Acer Aspire 4810T to the ACPI
   video driver (Hans de Goede).

Thanks!


---------------

Ard Biesheuvel (1):
      ACPI: PRM: Check whether EFI runtime is available

Hans de Goede (1):
      ACPI: video: Add backlight=native DMI quirk for Acer Aspire 4810T

Rafael J. Wysocki (1):
      MAINTAINERS: Update the ACPICA development list address

---------------

 MAINTAINERS                 |  2 +-
 drivers/acpi/prmt.c         | 10 ++++++++++
 drivers/acpi/video_detect.c |  8 ++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)
