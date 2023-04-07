Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6F06DAC3D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjDGLcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjDGLcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:32:42 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4AF98;
        Fri,  7 Apr 2023 04:32:41 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-93071f06a9fso194953766b.2;
        Fri, 07 Apr 2023 04:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680867159;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EPck9/RMxy4jyPiJYGjTgAHCPnx6IvyaRc0h3FaEPYY=;
        b=S/xTdJcvkFud0aloQyZKLXhsbn9bCtf830CSppPjFNVrPObG1q0tyj6GknOlGBl2hF
         /lPOMjyqv8DzklZjb3gPluSYv9P5KMt5rlPvlBd6ZPJH/txG8x6pebIZ9rBJ3BRNMrji
         r8YdQy2v36/OC9xzL8nFHfnDKE425HX/BhnS9ArepmE8+U3IHa8TlsMk291dUZDuNFnO
         38jbCznJx/mRcYk+E2SxCRlWk6nAC1W/HhRYhMFISaZI+S+PSmtaCU1iukK5IvGDPy/A
         xemQOx2sd9CULJ+mHE8lCVKc+JzwckKjCGB1kQ5RQmnoJmJovQwf1gXkst53Yg1pwy/Z
         xaAg==
X-Gm-Message-State: AAQBX9fi0rE4YT/TfaK89zKo8fgL+3y+CRHsIAKQNWsbxU5C0QRW10SV
        sIPpT0lljb6XPQTYrM6i3cRDXB0Z+/cTyCsxjRpqdiPqcWo=
X-Google-Smtp-Source: AKy350aE6nCEVttNGDDJhwpXMd1FBOzc0QIyCs7EoCDmbZyd8PnCdvZkzeH6A7NlIz9OFmsn0mXtiMFzuioSTZAUdog=
X-Received: by 2002:a50:a6d5:0:b0:4fb:c8e3:1ae2 with SMTP id
 f21-20020a50a6d5000000b004fbc8e31ae2mr1326676edc.3.1680867159654; Fri, 07 Apr
 2023 04:32:39 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 7 Apr 2023 13:32:28 +0200
Message-ID: <CAJZ5v0hE_eVO0S_MSfB=X287XZR+Cisa1f5nKU5VAEwTtxdnOA@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.3-rc6
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
 acpi-6.3-rc6

with top-most commit a5b2781dcab2c77979a4b8adda781d2543580901

 ACPI: video: Add acpi_backlight=video quirk for Lenovo ThinkPad W530

on top of commit 7e364e56293bb98cae1b55fd835f5991c4e96e7d

 Linux 6.3-rc5

to receive ACPI fixes for 6.3-rc6.

These fix the ACPI backlight override mechanism for the cases when
acpi_backlight=video is set through the kernel command line or a DMI
quirk and add backlight quirks for Apple iMac14,1 and iMac14,2 and
Lenovo ThinkPad W530 (Hans de Goede).

Thanks!


---------------

Hans de Goede (4):
      ACPI: video: Add auto_detect arg to __acpi_video_get_backlight_type()
      ACPI: video: Make acpi_backlight=video work independent from GPU driver
      ACPI: video: Add acpi_backlight=video quirk for Apple iMac14,1
and iMac14,2
      ACPI: video: Add acpi_backlight=video quirk for Lenovo ThinkPad W530

---------------

 drivers/acpi/acpi_video.c   | 15 ++++++++++--
 drivers/acpi/video_detect.c | 58 +++++++++++++++++++++++++++++++++++----------
 include/acpi/video.h        | 15 ++++++++++--
 3 files changed, 71 insertions(+), 17 deletions(-)
