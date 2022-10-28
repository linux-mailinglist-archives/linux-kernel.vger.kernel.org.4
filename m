Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F546115BE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJ1PVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJ1PVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:21:10 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3D71C8414;
        Fri, 28 Oct 2022 08:21:09 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id a27so334734qtw.10;
        Fri, 28 Oct 2022 08:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fR0avFJtESrO2UUZidpnOLkQYHbKzlKykWc0OtSP9FI=;
        b=y91xoRGE3FXIfpMI76o5tH4dix1Hk5fvBp1ov5L9v/87oJImfXlKXD0bV5Lj7zjGcj
         +lDxJUNUCh6LBiVXbri/LFeAjAeHv3Afvt39QyyqMEOq7B0Fk38MWHcBmWoC96R+P1Ke
         k3p/cvAZd9BcLHYh/x0A/4AxZN233dEHTUbK/yAqd1HURWi/sd9n+IPf25H4XJNFV78r
         1ZdpxMANyjuBwzmCQG5yLKG9MER6iomGn2zG+3KZreuE2U7TS0LIbIo1SkD+SCR6RoCU
         wyRIshVWs9i6CvtfEeEyiCEZ9LIiyUJ5DS7xMO+zzxwroHo9Kdi0vULocB2uTL3LnS7Z
         7ZUg==
X-Gm-Message-State: ACrzQf1otXkOXdIsKeRIwJ/asmqE5uzeF0ufD96hpcrr3NgTS+ZRfwsS
        TbSDFOIqmS2/oKb1XNE5HbiapdMnP8SWVwYuGeE=
X-Google-Smtp-Source: AMsMyM6xHZA90ceAZZwBD0H/LHehpL/S2ACINPkzJRp+Lz3UyAKdTdVK66B9WuFFcfFox454I2JMmGOZJYoLdUKBNQA=
X-Received: by 2002:a05:622a:1750:b0:39a:82aa:f4ab with SMTP id
 l16-20020a05622a175000b0039a82aaf4abmr46121071qtk.411.1666970468627; Fri, 28
 Oct 2022 08:21:08 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Oct 2022 17:20:57 +0200
Message-ID: <CAJZ5v0hUPC_+d71tWx5S-sQQS3oc59mqmNFxhpiqozfMn44i4A@mail.gmail.com>
Subject: [GIT PULL] ACPI and device properties fixes for v6.1-rc3
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
 acpi-6.1-rc3

with top-most commit dd183e320524f076a765ec441193deb90bd53836

 Merge branches 'acpi-resource', 'acpi-pcc' and 'devprop'

on top of commit 247f34f7b80357943234f93f247a1ae6b6c3a740

 Linux 6.1-rc2

to receive ACPI and device properties fixes for 6.1-rc3.

These fix device properties documentation and the ACPI PCC code, add a
new IRQ override quirk for resource handling and add one more item to
the list of device IDs to be ignored when returned by _DEP.

Specifics:

 - Fix the documentation of the *_match_string() family of functions to
   properly cover the return value (Andy Shevchenko).

 - Fix a possible integer overflow during multiplication in the ACPI
   PCC code (Manank Patel).

 - Make the ACPI device resources code skip IRQ override on Asus
   Vivobook S5602ZA (Tamim Khan).

 - Add LATT2021 to the list of device IDs that are ignored when
   returned by _DEP, because there are no drivers for them in the
   kernel and no plans to add such drivers (Hans de Goede).

Thanks!


---------------

Andy Shevchenko (1):
      device property: Fix documentation for *_match_string() APIs

Hans de Goede (1):
      ACPI: scan: Add LATT2021 to acpi_ignore_dep_ids[]

Manank Patel (1):
      ACPI: PCC: Fix unintentional integer overflow

Tamim Khan (1):
      ACPI: resource: Skip IRQ override on Asus Vivobook S5602ZA

---------------

 drivers/acpi/acpi_pcc.c | 2 +-
 drivers/acpi/resource.c | 7 +++++++
 drivers/acpi/scan.c     | 1 +
 drivers/base/property.c | 4 ++--
 4 files changed, 11 insertions(+), 3 deletions(-)
