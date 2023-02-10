Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A24A691915
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 08:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjBJHZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 02:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjBJHZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 02:25:12 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86C2474C7;
        Thu,  9 Feb 2023 23:25:11 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id f15-20020a17090ac28f00b00230a32f0c9eso4700659pjt.4;
        Thu, 09 Feb 2023 23:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hwa0TcxW2V9hamSEUdvEiLW9tA4QAzrfiZncOZPEgjc=;
        b=BLrkNPoP2qUG0jFQV7QSta//HY76OpK0SLT7Pq3rwauvDtDhWZAg9LwQUne1Ik6ut7
         VNGM684n3ztiGOOByeNwhXOrIkcHjf8HEioOc3hueB3K+MqCSfPDWQGKIMzPg1XoVvcg
         x5Hxa7G+kTJwTnmG1XtaoYjo7tQg7ofxYuqGa1K1htcqFf0llMoVH3wqUdw9Ee35MyW8
         CiwBBesKIMWG4BkLHSG6865bcZFRwD9xtxNgjI+hXsfgvWiHnIW9UfibsCVClz30wVK5
         kXKemToAoxnIZcEEqa7ddUTdkeFqvLerNa0lnG4Yb6VlTc+V5rKTKbiEucDxvRK2z8Dq
         EdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hwa0TcxW2V9hamSEUdvEiLW9tA4QAzrfiZncOZPEgjc=;
        b=24EYiVXE6LUSm9u+1T+Ot2sgFmEnE/wJIoNR38h9v50jGspjPy36xD+shmWLew43kf
         NN5IIRz2R/YdsqwyrfRCJV5Zb1HV7xb5p8TKjxeMlnLABI4nWv67Zi7vmi0oRmgX0zDM
         dLTVTHsF9+egN6hYp2GrgZIyGgdOUTlPBBmJREsU3Pp126IJR2K74WZD4kHYiU6+JkbU
         DPteDio16ctEb/68BVSyNB/OC7LMblnBal/7D/usW7TKkjd4ec5tlzJ0AKQcXhM99Z8r
         pC1k1INrGS0L4Mh8XeQtk9uTOY6E8LZRbzchTrvLc5ihX/YUHptik2ebN2E4n+tPACV6
         1VVQ==
X-Gm-Message-State: AO0yUKU7Nvf2jKg6FbTKEaGUVakEsNnqQdwXU8dWyhb5O7lZY5+ozTGy
        RNq8Hmw68A1VUtjcFHmiz6uzbtOKEP8E
X-Google-Smtp-Source: AK7set/ZuRAUkFUwKfJqYpDqUN2NahhOsm2ZrXOw6x4n0SFGPyOLZ/5IrM8RcnrsbETSP7y8Ft1apQ==
X-Received: by 2002:a17:903:4111:b0:199:19af:c4f5 with SMTP id r17-20020a170903411100b0019919afc4f5mr11620609pld.32.1676013911072;
        Thu, 09 Feb 2023 23:25:11 -0800 (PST)
Received: from fedora.mshome.net ([172.56.184.138])
        by smtp.gmail.com with ESMTPSA id k22-20020a170902761600b00196217f1219sm2705658pll.70.2023.02.09.23.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 23:25:10 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        tglx@linutronix.de, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v9 0/1] Checkpoint Support for Syscall User Dispatch
Date:   Fri, 10 Feb 2023 02:25:02 -0500
Message-Id: <20230210072503.1808-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v9: tglx feedback
    whitespace
    documentation of ptrace struct
    shorten struct name
    helper function for set_syscall_user_dispatch
    use task variant of set/clear_syscall_work 
    use task variant of test_syscall_work in getter
    selftest

v8: fix include issue   Reported-by: kernel test robot <lkp@intel.com>
    summary:
    +++ b/kernel/entry/syscall_user_dispatch.c
    + include <linux/ptrace.h>

v7: drop ptrace suspend flag, not required
    hanging unreferenced variable
                whitespace

v6: drop fs/proc/array update, it's not needed
    drop on_dispatch field exposure in config structure, it's not
    checkpoint relevant.
    (Thank you for the reviews Oleg and Andrei)

v5: automated test for !defined(GENERIC_ENTRY) failed, fix fs/proc
    use ifdef for GENERIC_ENTRY || TIF_SYSCALL_USER_DISPATCH
    note: syscall user dispatch is not presently supported for
          non-generic entry, but could be implemented. question is
          whether the TIF_ define should be carved out now or then

v4: Whitespace
    s/CHECKPOINT_RESTART/CHECKPOINT_RESUME
    check test_syscall_work(SYSCALL_USER_DISPATCH) to determine if it's
    turned on or not in fs/proc/array and getter interface

v3: Kernel test robot static function fix
    Whitespace nitpicks

v2: Implements the getter/setter interface in ptrace rather than prctl

Syscall user dispatch makes it possible to cleanly intercept system
calls from user-land.  However, most transparent checkpoint software
presently leverages some combination of ptrace and system call
injection to place software in a ready-to-checkpoint state.

If Syscall User Dispatch is enabled at the time of being quiesced,
injected system calls will subsequently be interposed upon and
dispatched to the task's signal handler.

Patch summary:
- Implement a getter interface for Syscall User Dispatch config info.
  To resume successfully, the checkpoint/resume software has to
  save and restore this information.  Presently this configuration
  is write-only, with no way for C/R software to save it.

  This was done in ptrace because syscall user dispatch is not part of
  uapi. The syscall_user_dispatch_config structure was added to the
  ptrace exports.


Gregory Price (1):
  ptrace,syscall_user_dispatch: checkpoint/restore support for SUD

 .../admin-guide/syscall-user-dispatch.rst     |  5 +-
 include/linux/syscall_user_dispatch.h         | 18 +++++
 include/uapi/linux/ptrace.h                   | 29 +++++++
 kernel/entry/syscall_user_dispatch.c          | 63 +++++++++++++--
 kernel/ptrace.c                               |  9 +++
 tools/testing/selftests/ptrace/.gitignore     |  1 +
 tools/testing/selftests/ptrace/Makefile       |  2 +-
 tools/testing/selftests/ptrace/get_set_sud.c  | 80 +++++++++++++++++++
 8 files changed, 197 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/ptrace/get_set_sud.c

-- 
2.39.1

