Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDCC6F59F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 16:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjECO1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 10:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjECO1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 10:27:00 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0112310E7;
        Wed,  3 May 2023 07:26:58 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-959a626b686so147891466b.0;
        Wed, 03 May 2023 07:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683124017; x=1685716017;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GOUZ1l7PqnUNfLHRGuDlP9LtNGxsx55N7JG1rV683EI=;
        b=dArtxGj6RCB7pNQCf3cx67X81k2iZMXgP6UVrqUuFkHZsC1A+nM38BxT4NbM/R7g0r
         itu+AAIRaSEAUOV1yirvhTRnuzblOcSJNutjtvaERqDmqNdXEieaTBBzNRyNLa92pGlE
         8XO/a3amgIhudzWepauJDTAcQhsUytyPD0wtlljEoG4RN2u9ZwMDmGAdR1Vs3VxzgY6N
         59TpLTQcZenkTD2o+kOD+tcTw7Zleb7Ycthb5rfcytOrv2nyvtBzIti/XQC1Q6rNlrLf
         XiNEqKXFXZzC7uSAq++EerHrVQogQhNVznNxDHkmVpT+9Zt58jIQn6p86og9hMhqylQR
         bdig==
X-Gm-Message-State: AC+VfDxws3HxyUKM37R2mcjwTO7qTXdj/GkZO/t7xbjzcB1Q2tNV80TO
        BOrOUtGAELsXCi2GpXobngESDueHnfLa9XzHQyY=
X-Google-Smtp-Source: ACHHUZ5z7VaxxSRQ7wF497gu+dZFu88TvZjHaV21KH7C2HdF54cvIqK4OJ796mQT4BiEOunw003TMK3AGt45jDQDXLk=
X-Received: by 2002:a17:906:74cc:b0:963:2f13:8808 with SMTP id
 z12-20020a17090674cc00b009632f138808mr4699541ejl.3.1683124017168; Wed, 03 May
 2023 07:26:57 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 May 2023 16:26:46 +0200
Message-ID: <CAJZ5v0h5B_eC5_2RwWTeD4_y29GDh-aoJmwk7oWQxNJA7GzGBg@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v6.4-rc1
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
 acpi-6.4-rc1-2

with top-most commit 2e70a47ceafe4d71a4a402b2f7c5123cb4bf33f6

 Merge branches 'acpi-pm' and 'acpi-properties'

on top of commit 793582ff47f8b73be8d3d925d750bf3ef79f33c7

 Merge tag 'acpi-6.4-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more ACPI updates for 6.4-rc1.

These add two ACPI-related quirks and extend support for Apple device
properties supplied via ACPI _DSM.

Specifics:

 - Do not turn off unused power resources during initialization on the
   Toshiba Click Mini (Hans de Goede).

 - Support strings in device properties supplied by ACPI _DSM on Apple
   platforms (Hector Martin).

 - Add an ACPI device ID quirk for Lenovo Yoga Tablet 2 (Marius Hoch).

Thanks!


---------------

Hans de Goede (1):
      ACPI: PM: Do not turn of unused power resources on the Toshiba Click Mini

Hector Martin (1):
      ACPI: property: Support strings in Apple _DSM props

Marius Hoch (1):
      ACPI: x86: utils: Remove Lenovo Yoga Tablet 2's MAGN0001

---------------

 drivers/acpi/power.c     | 19 +++++++++++++++++++
 drivers/acpi/x86/apple.c | 11 ++++++++++-
 drivers/acpi/x86/utils.c | 10 ++++++++++
 3 files changed, 39 insertions(+), 1 deletion(-)
