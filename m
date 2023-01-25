Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE7F67A8FF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 03:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbjAYCvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 21:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjAYCvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 21:51:35 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62F830288;
        Tue, 24 Jan 2023 18:51:33 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id p12so8287145ilq.10;
        Tue, 24 Jan 2023 18:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TU58h35XRxb7co6c01lARxtF0FVRm+LFEZuUsbxAK/k=;
        b=O6n4VVODt/w5XFECKba6TdLlSE1RbISaQ03kzuYuqPk/ocEAF/JCyNCZhGHMCrl8sV
         h22G3AHh5nS1vYyYltVDJDFdhs43hy6mO6oCaRYfhaNyfx/mfvAvlOjbh4HR0Of3VYJ3
         LvVhLn21VKPx/2waUDIryfniNY7ZvVjLN3zo3YU+gWFeZW2bRvP87TEMJZzGvkRIZ911
         v9O2YNNse/QiviBL2JAAUW8gMhAUaEfnoH4uo3lgtGX2haykf57twHZT157pZCyTwfj6
         bEe1julmHQ0nf3vQUBGeR9xY9EwCYRmpZIrSa4XE08UxdYhz0b6iHOmANUaSC4DPKSGN
         U2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TU58h35XRxb7co6c01lARxtF0FVRm+LFEZuUsbxAK/k=;
        b=3/N9Zv36gDT9yhaB+jgnyp5g7IH7z0d6sbw+b3n9PlCsUGJ+NYx5pEcUc3bwRNxQAW
         Yrt3luXmA2WUtpBFTlftILepppTNVKLx/pjVuvmvQK70p1ySqPeqqEKzaor+1Kgmdo8b
         2TYm6YmvWwUKwPn8RJ6bZvVWzH6xKhugIIYQ65mPhhIZ4o7pTJv8yFaaAIiYBpoFauBM
         saqQ0TysAyn0VWIDIRNp1aAzEuBTbIFG5sYi0P5yF4tZVmD/G52u726EI9lqH4aLLkO/
         H2nYRY8UpNUMvO18ITohMjdokVBo1rwArCdMh0TPd3Wrw5V2KLv+520JpXVDvHJ6SWM9
         9CsQ==
X-Gm-Message-State: AFqh2krComHAk2ayNgRAIPDpa7grji6IzvS5ROQF1MCBwFNVv0kgDC+K
        /kPMf0rhXHTNL7IJkGjfYluwGlNuNYSE
X-Google-Smtp-Source: AMrXdXuefzXhtpv6QTKOltVwlHxYDayDVMCkwxB1v2S5WzEoieqFW7+1Xeqdx47fS2fPH386+15R7Q==
X-Received: by 2002:a05:6e02:1a45:b0:302:392c:5878 with SMTP id u5-20020a056e021a4500b00302392c5878mr28612992ilv.13.1674615093048;
        Tue, 24 Jan 2023 18:51:33 -0800 (PST)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id v5-20020a023845000000b0038a13e116a1sm1265722jae.61.2023.01.24.18.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 18:51:32 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        tglx@linutronix.de, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v6 0/2] 
Date:   Tue, 24 Jan 2023 21:51:24 -0500
Message-Id: <20230125025126.787431-1-gregory.price@memverge.com>
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

This patch set implements 2 features to enable software such as CRIU
to cleanly interpose upon software leveraging syscall user dispatch.

- Implement PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH, akin to a similar
  feature for SECCOMP.  This allows a ptracer to temporarily disable
  syscall user dispatch, making syscall injection possible.

- Implement a getter interface for Syscall User Dispatch config info.
  To resume successfully, the checkpoint/resume software has to
  save and restore this information.  Presently this configuration
  is write-only, with no way for C/R software to save it.

  This was done in ptrace because syscall user dispatch is not part of
  uapi. The syscall_user_dispatch_config structure was added to the
  ptrace exports.

Gregory Price (2):
  ptrace,syscall_user_dispatch: Implement Syscall User Dispatch
    Suspension
  ptrace,syscall_user_dispatch: add a getter/setter for sud
    configuration

 .../admin-guide/syscall-user-dispatch.rst     |  5 ++-
 include/linux/ptrace.h                        |  2 +
 include/linux/syscall_user_dispatch.h         | 19 ++++++++
 include/uapi/linux/ptrace.h                   | 15 ++++++-
 kernel/entry/syscall_user_dispatch.c          | 45 +++++++++++++++++++
 kernel/ptrace.c                               | 13 ++++++
 6 files changed, 97 insertions(+), 2 deletions(-)

-- 
2.39.0

