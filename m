Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5672663F02
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjAJLJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238169AbjAJLHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:07:54 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613013C71C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 03:07:17 -0800 (PST)
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 30AB79JR069112;
        Tue, 10 Jan 2023 20:07:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Tue, 10 Jan 2023 20:07:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.20] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 30AB79hJ069109
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 10 Jan 2023 20:07:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <bc4f8b87-101b-381e-debf-6ed87bfec9f3@I-love.SAKURA.ne.jp>
Date:   Tue, 10 Jan 2023 20:07:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [GIT PULL] tomoyo update and hung task update for v6.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit cf3b3d6e3a0bb6dddc06f1b548b459a3f2e3fc16:

  locking/lockdep: add debug_show_all_lock_holders() (2023-01-09 21:47:11 +0900)

are available in the git repository at:

  git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git tags/tomoyo-pr-20230110

for you to fetch changes up to cf3b3d6e3a0bb6dddc06f1b548b459a3f2e3fc16:

  locking/lockdep: add debug_show_all_lock_holders() (2023-01-09 21:47:11 +0900)

----------------------------------------------------------------
A Makefile update for making it possible to remove scripts/bin2c program, and
an improvement for making it easier to understand syzbot's hung task reports.

 include/linux/debug_locks.h |   17 ++++++++++++++++-
 kernel/hung_task.c          |    2 +-
 kernel/locking/lockdep.c    |   14 +++++++++++---
 security/tomoyo/Kconfig     |    1 -
 security/tomoyo/Makefile    |   19 +++++++++++--------
 5 files changed, 39 insertions(+), 14 deletions(-)

----------------------------------------------------------------
