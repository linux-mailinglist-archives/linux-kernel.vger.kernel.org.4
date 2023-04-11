Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181F46DE7D6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 01:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjDKXMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 19:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjDKXM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 19:12:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD9819A0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 16:12:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB83562C63
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 23:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3528BC433D2;
        Tue, 11 Apr 2023 23:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681254747;
        bh=ZkqIMcJUIB+fxHHcCP61BxM5kbCEoYM8i2XiXvWyoI8=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=E1M7uvxCVy8RLH5TEIvQw/9s27H8jV4phJrveZgXyR8BdSBm8wBif+UMg2DmbLDo7
         fEiNgL7SWCKeVTjgTWexgE5/uHoPFl7uwWvYbHuLliZ9S1bOMjS0wh/ocHXohevjUe
         nfySPkrRkh6AEF0vpQyzMsZ9v5gYvizm310UHwAyYAaGsBUEJFS8/Qo+48qE61hjzR
         4E5YCpNVUwev6LjqgWPNsnXg8KgTUdGcxDio6yur+oMzMrwOYt0wbpvsOlk5xA0yYL
         jAuwlZMKkMP18BlmTUtZsFjpRjnMMleZWhqW96O3xLBjBc+M/g62Zq5geNuLiwyFmO
         rqhLTYxPYfcpw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C080E1540478; Tue, 11 Apr 2023 16:12:26 -0700 (PDT)
Date:   Tue, 11 Apr 2023 16:12:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        stern@rowland.harvard.edu, yangtiezhu@loongson.cn,
        parri.andrea@gmail.com
Subject: [GIT PULL] LKMM scripting changes for v6.4
Message-ID: <d5f5cb7e-312e-49d5-b6f7-ebbcec1e4d13@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Once the v6.4 merge window opens, please pull these LKMM scripting
changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm-scripting.2023.04.07a
  # HEAD: cc4a29819b0df9f3a2e7e0d5dee0830a3072d5aa: tools/memory-model: Remove out-of-date SRCU documentation (2023-03-24 10:24:48 -0700)

----------------------------------------------------------------
LKMM scripting updates for v6.4

This update improves litmus-test documentation and improves the ability
to do before/after tests on the https://github.com/paulmckrcu/litmus repo.

----------------------------------------------------------------
Andrea Parri (1):
      tools/memory-model: Remove out-of-date SRCU documentation

Paul E. McKenney (30):
      tools/memory-model:  Document locking corner cases
      tools/memory-model: Make judgelitmus.sh note timeouts
      tools/memory-model: Make cmplitmushist.sh note timeouts
      tools/memory-model: Make judgelitmus.sh identify bad macros
      tools/memory-model: Make judgelitmus.sh detect hard deadlocks
      tools/memory-model: Fix paulmck email address on pre-existing scripts
      tools/memory-model: Update parseargs.sh for hardware verification
      tools/memory-model: Make judgelitmus.sh handle hardware verifications
      tools/memory-model: Add simpletest.sh to check locking, RCU, and SRCU
      tools/memory-model: Fix checkalllitmus.sh comment
      tools/memory-model: Hardware checking for check{,all}litmus.sh
      tools/memory-model: Make judgelitmus.sh ransack .litmus.out files
      tools/memory-model: Split runlitmus.sh out of checklitmus.sh
      tools/memory-model: Make runlitmus.sh generate .litmus.out for --hw
      tools/memory-model: Move from .AArch64.litmus.out to .litmus.AArch.out
      tools/memory-model: Keep assembly-language litmus tests
      tools/memory-model: Allow herd to deduce CPU type
      tools/memory-model: Make runlitmus.sh check for jingle errors
      tools/memory-model: Add -v flag to jingle7 runs
      tools/memory-model: Implement --hw support for checkghlitmus.sh
      tools/memory-model: Fix scripting --jobs argument
      tools/memory-model: Make checkghlitmus.sh use mselect7
      tools/memory-model: Make history-check scripts use mselect7
      tools/memory-model:  Add "--" to parseargs.sh for additional arguments
      tools/memory-model: Repair parseargs.sh header comment
      tools/memory-model: Add checktheselitmus.sh to run specified litmus tests
      tools/memory-model: Add data-race capabilities to judgelitmus.sh
      tools/memory-model: Make judgelitmus.sh handle scripted Result: tag
      tools/memory-model: Use "-unroll 0" to keep --hw runs finite
      tools/memory-model: Document LKMM test procedure

Tiezhu Yang (1):
      tools/memory-model: Use "grep -E" instead of "egrep"

 .../litmus-tests/locking/DCL-broken.litmus         |  54 ++++
 .../litmus-tests/locking/DCL-fixed.litmus          |  55 ++++
 .../litmus-tests/locking/RM-broken.litmus          |  41 +++
 Documentation/litmus-tests/locking/RM-fixed.litmus |  41 +++
 tools/memory-model/Documentation/litmus-tests.txt  |  27 +-
 tools/memory-model/Documentation/locking.txt       | 298 +++++++++++++++++++++
 tools/memory-model/litmus-tests/.gitignore         |   2 +-
 tools/memory-model/scripts/README                  |  48 +++-
 tools/memory-model/scripts/checkalllitmus.sh       |  29 +-
 tools/memory-model/scripts/checkghlitmus.sh        |  15 +-
 tools/memory-model/scripts/checklitmus.sh          |  25 +-
 tools/memory-model/scripts/checklitmushist.sh      |   2 +-
 tools/memory-model/scripts/checktheselitmus.sh     |  43 +++
 tools/memory-model/scripts/cmplitmushist.sh        |  49 +++-
 tools/memory-model/scripts/hwfnseg.sh              |  20 ++
 tools/memory-model/scripts/initlitmushist.sh       |   2 +-
 tools/memory-model/scripts/judgelitmus.sh          | 120 +++++++--
 tools/memory-model/scripts/newlitmushist.sh        |   4 +-
 tools/memory-model/scripts/parseargs.sh            |  21 +-
 tools/memory-model/scripts/runlitmus.sh            |  80 ++++++
 tools/memory-model/scripts/runlitmushist.sh        |  29 +-
 tools/memory-model/scripts/simpletest.sh           |  35 +++
 22 files changed, 924 insertions(+), 116 deletions(-)
 create mode 100644 Documentation/litmus-tests/locking/DCL-broken.litmus
 create mode 100644 Documentation/litmus-tests/locking/DCL-fixed.litmus
 create mode 100644 Documentation/litmus-tests/locking/RM-broken.litmus
 create mode 100644 Documentation/litmus-tests/locking/RM-fixed.litmus
 create mode 100644 tools/memory-model/Documentation/locking.txt
 create mode 100755 tools/memory-model/scripts/checktheselitmus.sh
 create mode 100755 tools/memory-model/scripts/hwfnseg.sh
 create mode 100755 tools/memory-model/scripts/runlitmus.sh
 create mode 100755 tools/memory-model/scripts/simpletest.sh
