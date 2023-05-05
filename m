Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B556F8806
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjEERwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjEERwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:52:15 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8341E9A3;
        Fri,  5 May 2023 10:51:35 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-94f9cd65b1aso50990766b.0;
        Fri, 05 May 2023 10:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683309033; x=1685901033;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fuIYc8Q9ZCYldazhXdfoactw4bpodSOUC9LmY7berb4=;
        b=LzgPzKOFB1jPGKCKEPwh8Bz6wGEUj99diPAPB8G0u98+CiJ8/FhQBhD9t5AB7kuP+7
         mFvBDEMNZL+aHdSrmLZK60BOcB7yIf6z4yAi4cMMdkqBkuckgDm3LcUbTLZ9bUDA2BbT
         /evgyJM6M/c/LukDmqn8LJrqtmFdGsTIM1+RC5WE+8+ydvOvUmxl+hebmf0rKo+5nrs4
         sZwbsLn2KBIfah6BNqusaP/yxm1oe8iUArv41Fh72Fl+jptQKzidRo8qebCEkOjTGy6d
         ZSkLhxILQvW1f7DHr1v+rd7lW19vT59udxOdVx3mxEuGAh62xt0lGK4nDPwo8jLmMvCx
         AGnw==
X-Gm-Message-State: AC+VfDzUV5XUyEp2aNSVqkzb8bvBItYXcVy5Zw9gR/eF6GVIVwLzBiwg
        kvbFR2UUjNyIRDUhULoAAxIeMly2YGOlCIDJlm7LzTcH9zI=
X-Google-Smtp-Source: ACHHUZ7eZJQw6jWHAIUzvdaLK23TfmKvMBuoltA1ZneYT/v/SxEXpDlqG/I+H+AXdOo6k4gY8+7udIs/gz0QOnxOfk8=
X-Received: by 2002:a17:906:7a45:b0:92e:f520:7762 with SMTP id
 i5-20020a1709067a4500b0092ef5207762mr1897065ejo.6.1683309033175; Fri, 05 May
 2023 10:50:33 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 May 2023 19:50:22 +0200
Message-ID: <CAJZ5v0gKvM670zp0WtTV1nYgQuUiJVzOC6bRo9Lv8DRY4cdG+Q@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v6.4-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.4-rc1-3

with top-most commit 3db66620ea90b0fd4134b31eabfec16d7b07d7e3

 ACPI: video: Remove acpi_backlight=video quirk for Lenovo ThinkPad W530

on top of commit 0153d8e695255cdf3faa5cfa9f18b57158dc2764

 Merge tag 'acpi-6.4-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive an ACPI fix for 6.4-rc1.

This removes an ACPI backlight quirk for Lenovo ThinkPad W530, added
during the 6.3 cycle, that turned out to do more harm than help (Hans
de Goede).

Thanks!


---------------

Hans de Goede (1):
      ACPI: video: Remove acpi_backlight=video quirk for Lenovo ThinkPad W530

---------------

 drivers/acpi/video_detect.c | 14 --------------
 1 file changed, 14 deletions(-)
