Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3A66A75AB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjCAU6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCAU6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:58:52 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408744DE1E;
        Wed,  1 Mar 2023 12:58:50 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id g73-20020a9d12cf000000b006943a7df072so126978otg.11;
        Wed, 01 Mar 2023 12:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677704329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WSPQ47Kos15ho2WRz4oPujm7UYDuuuPK0dwj6BbZaLA=;
        b=Hnknsni3bePlArjL4uYBR4neFTKq1h2VF6AQYSETv/UCPzjNhYgqjp4noBY0CVC2I8
         beTMS5AVR1Jpzksj1kGM2EAgLiapkLY+zEW40Rm+/CbEnJvlYo44vXqrpKMg4/hbnbet
         KDjv9ydZ+ceS3LZ+bql9v1PmYTxke6Bt0X75BCgKPNKyqP3xzRk0bUILsl1Sj0n/dWCQ
         eSMVC90agJxsEK7Op/wXB4ETtO6gAqf2G0/+a7H8GN9Op8bh99KqHc8Zdl2XjFD3Fgdw
         E5b/jZ++3UqE1wC4nsZWcG77xDZ8nJ4bTNoiwqFA8p41bbYdlfch8dQOdRhMDI18W3yl
         WuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677704329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSPQ47Kos15ho2WRz4oPujm7UYDuuuPK0dwj6BbZaLA=;
        b=frjgFqhpxk5+lY2EAFpaRPkrTQCBG394TjzT0NcTueoNgnW0d77RRS193hdJj1CRiw
         g+n9diJbGwwM9MPa4C+HXFy8thNnrgrJhqIL7S5i8uCkpjGyXetF8ufvaZ4FoTKbBy6P
         y8T7ZhfLkIMQ3L1V9wjf5PH0cPF9cNd6hL0/SgGXtzHl87tgkmnFA5WhDfSqbQUTEyjw
         B5NhPjwlwSZAdsLRgitZfz15PIaGpmJd1DrorwWel+oQYVwI/7JUbbBR2Dv0ItMCPAji
         ga/uT28+gGbkk8SreUwusMkTaCtYBPpYAeqiOhwQu2gIzWU8/TlmdftIT8vw8dYys0FA
         +LgA==
X-Gm-Message-State: AO0yUKVP4ZwJsNxwOArXk4Upv1mkem8bp+Mzx3YpujwwioG1UQY1wT7l
        Zw8CnJXj/u3RnVv76saslbkSYTmdmn5G
X-Google-Smtp-Source: AK7set9C/GEMbQ6Aoj/TvhFXbscbE7k7mr6sQfJS1KhKXkmIeTw7/SdzsmBKlXfsipff2BcP2O+uyg==
X-Received: by 2002:a9d:1e9:0:b0:68b:cdd3:3b93 with SMTP id e96-20020a9d01e9000000b0068bcdd33b93mr4358502ote.26.1677704329452;
        Wed, 01 Mar 2023 12:58:49 -0800 (PST)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id bt55-20020a05683039f700b0068abc8e786fsm5273899otb.10.2023.03.01.12.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 12:58:48 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        tglx@linutronix.de, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v13 0/3] Checkpoint Support for Syscall User Dispatch
Date:   Wed,  1 Mar 2023 15:58:40 -0500
Message-Id: <20230301205843.2164-1-gregory.price@memverge.com>
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

v13: sizeof consistency and cosmetic changes in patch 2

v12: split test into its own patch
     change from padding a u8 to using a u64
     casting issues
     checkpatch.pl

[truncated version history]

Syscall user dispatch makes it possible to cleanly intercept system
calls from user-land.  However, most transparent checkpoint software
presently leverages some combination of ptrace and system call
injection to place software in a ready-to-checkpoint state.

If Syscall User Dispatch is enabled at the time of being quiesced,
injected system calls will subsequently be interposed upon and
dispatched to the task's signal handler.

Patch summary:
- Refactor configuration setting interface to operate on a task
  rather than current, so the set and error paths can be consolidated

- Implement a getter interface for Syscall User Dispatch config info.
  To resume successfully, the checkpoint/resume software has to
  save and restore this information.  Presently this configuration
  is write-only, with no way for C/R software to save it.

  This was done in ptrace because syscall user dispatch is not part of
  uapi. The syscall_user_dispatch_config structure was added to the
  ptrace exports.

- Selftest for the new feature

Gregory Price (3):
  syscall_user_dispatch: helper function to operate on given task
  ptrace,syscall_user_dispatch: checkpoint/restore support for SUD
  selftest,ptrace: Add selftest for syscall user dispatch config api

 .../admin-guide/syscall-user-dispatch.rst     |  4 ++
 include/linux/syscall_user_dispatch.h         | 18 +++++
 include/uapi/linux/ptrace.h                   | 29 ++++++++
 kernel/entry/syscall_user_dispatch.c          | 65 ++++++++++++++---
 kernel/ptrace.c                               |  9 +++
 tools/testing/selftests/ptrace/.gitignore     |  1 +
 tools/testing/selftests/ptrace/Makefile       |  2 +-
 tools/testing/selftests/ptrace/get_set_sud.c  | 72 +++++++++++++++++++
 8 files changed, 191 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/ptrace/get_set_sud.c

-- 
2.39.1

