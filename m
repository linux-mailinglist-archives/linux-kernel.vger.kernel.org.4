Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7772B683185
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjAaPay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjAaPax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:30:53 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FC315574;
        Tue, 31 Jan 2023 07:30:52 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id 6so4882747vko.7;
        Tue, 31 Jan 2023 07:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=05CdbpOqoGrOEIG4b3k+X8PMnyPV9J5EmvrRJwlTzJE=;
        b=KB5qyYhcw2U8EB8vxdcaZQuoWHs4Juru+hnt/Bb22wQ3H9hwXDjQNLeOCVBjuA7Dky
         q3ANqPPhAio6V/qk1RmYHkJlvJpPbQhWyh8L5TcJRAuJemQfOY9XjddLqMZGEZ5t9Vsn
         oMEmABSaRSZ4m59zoNE62ZhwP1UHcCs92C3Ljy06eEI9e0t3YplOp0/KLUYF+nv6Edi/
         6/eMUxJeFQjz83zs9fMLpS7g3PyDkXtqeGpdT0yXa7GgF66JjpxOYAFbvzAYjTofwZi6
         iVxUkYeY4YwbktTRQtlmANWLQ9M1OF1c6rt5OPozMmBcRhKGHb2gl53Cju1wli2/A0g1
         kR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05CdbpOqoGrOEIG4b3k+X8PMnyPV9J5EmvrRJwlTzJE=;
        b=MeXWOjZot9dZKiQlr7GpoCQiCd81cmOqK5u3FLyJu+huFOh3s40Oy4BSbQSI29QWos
         BbpKrKo83m8GGAW0EDmJxdzSi139E2y4RFkX9AhTRNsIWjvnf3ELTOil3gp1sfAl9ZO4
         X7MAY7JxcJVyWr0jbTXVWwcoLJNStNnhhMiKpxP2Fa1979hjD7lxS4ZT32iW0ZR6lQMu
         A6NMaUy0Wy3LNhVY4K0TaJ98ZNRWarSkgeB2x7MZdWZ4AZzexpl6+RfyhV/STK0tfJIk
         LHWRw7ZRFCO/ftFL5sGzO7lUHjLUIz0Q02P7kAcL0jdgs0dLNZYpyqDSlwbqF3JTdLXQ
         onYA==
X-Gm-Message-State: AO0yUKV2Tq3ZVT7Rjn1Zjb79g7SMijVPq2jRsnUSi058Hy3dOMEoTF6V
        1jmP6p8L4u8rHf4SkekGxIy6z50YVwil
X-Google-Smtp-Source: AK7set9GoHRTZr+u/kjtPf6JBVsoz9kNRA9btH76KfRDMlUU1Bd50cjazj9xn9sUli8aXH0EzAfwsg==
X-Received: by 2002:a05:6122:12e7:b0:3e9:12ee:b86d with SMTP id k7-20020a05612212e700b003e912eeb86dmr8646466vkp.8.1675179051140;
        Tue, 31 Jan 2023 07:30:51 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id eb10-20020a05620a480a00b0071323d3e37fsm9968963qkb.133.2023.01.31.07.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 07:30:50 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        tglx@linutronix.de, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v8 0/1] Checkpoint Support for Syscall User Dispatch
Date:   Tue, 31 Jan 2023 09:44:57 -0500
Message-Id: <20230131144458.1980891-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.0
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

 .../admin-guide/syscall-user-dispatch.rst     |  5 ++-
 include/linux/syscall_user_dispatch.h         | 18 +++++++++
 include/uapi/linux/ptrace.h                   |  9 +++++
 kernel/entry/syscall_user_dispatch.c          | 40 +++++++++++++++++++
 kernel/ptrace.c                               |  9 +++++
 5 files changed, 80 insertions(+), 1 deletion(-)

-- 
2.39.0

