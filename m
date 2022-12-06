Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F906439F8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 01:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiLFAag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 19:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiLFAac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 19:30:32 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183CC20352
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 16:30:26 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id b11so12858675pjp.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 16:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QYk1MQ5FJfgw7FRsKHcSZtBgbryqFBZ1S1oRpmpo1EY=;
        b=cJBqiLWdExkt5LCbZlx3ew1gToYW1ffmNqHgYAu0LZiI5gzxsnGVeJzT0tQu4jBGSZ
         cXjdF4j/mWwOHkkYE4Hgb9SHqH06mBwmmdOQVnt0gV7w0YzgjtrOYLxm0O2muoAev6qG
         LePo9G+ro6+cmEkw2glm8UHo0lCw8ZKiH7MdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QYk1MQ5FJfgw7FRsKHcSZtBgbryqFBZ1S1oRpmpo1EY=;
        b=DZnLDdv8253+DQx0YbaV7g9Q+7pjXyA1W4/LOM5vAQTaBac8Yniu5+lZxAnZfKmEic
         jzOc292nKNB7vUOpLWBG21lzE2ExWwlq0N1kWT1qZDWVp67VMPbD7NU9hkkn1SGQDbKq
         YQpo7QhrBD5wfUHQU5GT5qvQ2HDimew7HOEMZQA4FwKZDqUni/4BN9APFNyCUeEuBSU+
         Y/E7dxdYzCQ8OT8haN37e5ZoGD65ErclK8nx9/czzrveRxwqiqXqMSB3cUhSSmImRALD
         B5hleB0fUM8KATQ2ib2dayVk+3KCmZ2X14gowwtxdlRhU8QXvQ1BNWg4z0lVBNNluwrE
         r73w==
X-Gm-Message-State: ANoB5plulYZDLRA/PD2XOJOVc5iFP//+z3iOBHnrZoonV/Rb6A78UYAU
        HRkiUJIenvMzFd+BwV7xBlQnrQ==
X-Google-Smtp-Source: AA0mqf63ZR/enrGgsn9loPI5M12W+PJYBTJmqstK2wMXOVG5J8/4C4Qce0z7zPm2XKeEqWMguZ9mpg==
X-Received: by 2002:a17:902:ccd1:b0:189:2370:7f6a with SMTP id z17-20020a170902ccd100b0018923707f6amr73612353ple.158.1670286625592;
        Mon, 05 Dec 2022 16:30:25 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u17-20020a170902e81100b001897bfc9800sm202550plg.53.2022.12.05.16.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 16:30:25 -0800 (PST)
Date:   Mon, 5 Dec 2022 16:30:24 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ayushman Dutta <ayudutta@amazon.com>,
        Christian Brauner <brauner@kernel.org>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        syzbot+ab17848fe269b573eb71@syzkaller.appspotmail.com
Subject: [GIT PULL] seccomp updates for v6.2-rc1
Message-ID: <202212051629.61BD1239E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these 3 seccomp updates for v6.2-rc1.

Thanks!

-Kees

The following changes since commit 247f34f7b80357943234f93f247a1ae6b6c3a740:

  Linux 6.1-rc2 (2022-10-23 15:27:33 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v6.2-rc1

for you to fetch changes up to b9069728a70c23dad00684eb994a3f5295f127cf:

  seccomp: document the "filter_count" field (2022-12-02 11:33:48 -0800)

----------------------------------------------------------------
seccomp updates for v6.2-rc1

- Add missing kerndoc parameter (Randy Dunlap).

- Improve seccomp selftest to check CAP_SYS_ADMIN (Gautam Menghani).

- Fix allocation leak when cloned thread immediately dies (Kuniyuki Iwashima).

----------------------------------------------------------------
Gautam Menghani (1):
      selftests/seccomp: Check CAP_SYS_ADMIN capability in the test mode_filter_without_nnp

Kuniyuki Iwashima (1):
      seccomp: Move copy_seccomp() to no failure path.

Randy Dunlap (1):
      seccomp: document the "filter_count" field

 include/linux/seccomp.h                       |  1 +
 kernel/fork.c                                 | 17 +++++++++++------
 tools/testing/selftests/seccomp/seccomp_bpf.c |  6 ++++--
 3 files changed, 16 insertions(+), 8 deletions(-)

-- 
Kees Cook
