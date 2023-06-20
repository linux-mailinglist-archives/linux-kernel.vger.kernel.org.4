Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FD0737138
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjFTQNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjFTQNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:13:17 -0400
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C61F4;
        Tue, 20 Jun 2023 09:13:12 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4f8f86fd7b9so273991e87.1;
        Tue, 20 Jun 2023 09:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687277588; x=1689869588;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nCgTqghRbrJhuh+9RX224RAvBbp1ljjN9HxHevt6TQ0=;
        b=LMkMzQsdMImdQt04xu+mHIWWGQcvlWu4UcMqoFvf9KhXQR9RREM0TUNzO/VovnowgN
         0W0ADL12wWdwdBdI0pxxLIz/ubO+A4LGJAaggT/LoRWEh8qCAjDnzf4LAXTXtTV/2psg
         RQVNtMVC0UHMic7M1yynB/wzlB6ny3oKK7uLa9Xs0gZXJkgqPSk5y13gQnuG5iEbgNie
         WLQpSUMh703nAkCL5vfuOHl+54K2oJjek7mqwc8FBTACMW+bfrf9xvzEDjCUZJCoXtpD
         8bGVf+95PIOxWTJOQiNUmCdNMBW9ao/Lp29a5AZL7g3CwVVKyo50v/aDmvaC/zY7A7Vy
         WN4Q==
X-Gm-Message-State: AC+VfDxXZ2zu6GDKG9D7EXdcbvHO4zK57y9oR1DZJwLYBJQyQ9qgQLPa
        avAQBsaO/KkrtyYTjOw7nhEE+UOFxXySfMfSU2oSI+MdF14=
X-Google-Smtp-Source: ACHHUZ7O1AfL37JSNK2T8KUbAInOwTabX5mGBA5NL6112kp2MYUJxLIIL9AuMsH6Dultmz6nrmz1Gw7MGcXyrRPnE8k=
X-Received: by 2002:a2e:b54a:0:b0:2b4:6cd3:43be with SMTP id
 a10-20020a2eb54a000000b002b46cd343bemr4155549ljn.3.1687277588396; Tue, 20 Jun
 2023 09:13:08 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 20 Jun 2023 18:12:57 +0200
Message-ID: <CAJZ5v0h7dfsyHq14pYkgWAq=chG6WWWEjU1fwe_7OCbyjKKVqA@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v6.4-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
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
 acpi-6.4-rc8

with top-most commit 22db06337f590d01d79f60f181d8dfe5a9ef9085

 ACPI: sleep: Avoid breaking S3 wakeup due to might_sleep()

on top of commit 858fd168a95c5b9669aac8db6c14a9aeab446375

 Linux 6.4-rc6

to receive an ACPI fix for 6.4-rc8.

This fixes a kernel crash during early resume from ACPI S3 that has
been present since the 5.15 cycle when might_sleep() was added to
down_timeout(), which in some configurations of the kernel caused an
implicit preemption point to trigger at a wrong time.

Thanks!


---------------

Rafael J. Wysocki (1):
      ACPI: sleep: Avoid breaking S3 wakeup due to might_sleep()

---------------

 drivers/acpi/acpica/achware.h |  2 --
 drivers/acpi/sleep.c          | 16 ++++++++++++----
 include/acpi/acpixf.h         |  1 +
 3 files changed, 13 insertions(+), 6 deletions(-)
