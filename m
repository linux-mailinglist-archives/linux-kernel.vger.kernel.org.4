Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03C667D50C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjAZTGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjAZTGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:06:49 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EF010D0;
        Thu, 26 Jan 2023 11:06:48 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id h10so2158265qvq.7;
        Thu, 26 Jan 2023 11:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vGkjepxz772w0WNJY1szRf1c02CHz0loVyy6M92sOVM=;
        b=d5V4d7i4dtO0z4Zn8uS5X4aov9oeISz0/26YE6sRyWlbstl5uCZ3MK62yaHslQHomU
         bhuCHszql94dHAZT3mi3F118JMGb/yK5FqQL6CDqXcfpAn8PL+mPVNb61ysO59BxeEfC
         ES67NkZZncnDILXnDAPbWQnGoComC1tiVoaVBEYa6p1vcVXSp1V1juF94qPJDlh5fIXo
         0QtwpjPR5GoueZ2h/YjF3F1lL+08/uJCtNzv/Yb+Y6zt3vGpXxXkWWDs4AVTYCX/G6qQ
         U3ExtPIpr5+MNsnvFC9Kl4u/oUlv9dq+cqA4sHVqSn1xXaZ/DWXpfZFK/X1evv/XQqJD
         r9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vGkjepxz772w0WNJY1szRf1c02CHz0loVyy6M92sOVM=;
        b=TJBbmw1zkcdUyaHo6PaRCDGxlQUELcEj8VgJAR6vqAvcVwVoaePk4i5m1VMrZfD2Fa
         tV+QFREnjiboDRTXtTcIU0kVQQIzjsqMH9rtD4wpeyYL99R8bXed2Spudrbs9Bh2mo0Y
         ZiDtZx4+DbDjqqs8jhSGLKzs5LxJFl/6/QB6xIVQUi/Ifmot3WHANJsW8H9jVIOuXt+5
         6wsO6mRrlw1/9gY8SmYHm07MUJpYNbWKn3K3GLsnXgRcbdcBBfGeGzTpcgtG+uhNemru
         G9oPEmKEh4C57N2ZNxTTDQpqWC7Eh0/itFe92gKqKai8GusdBCE8BwO1VVZCG3jzNSoS
         /zsw==
X-Gm-Message-State: AO0yUKVlwJIoTb9ROF+Xdje3jsZ0Aw6VqiGBj26yw/DfXVk0EOGpNgdO
        AIVvebDIqE0RRk6ItDDbIl+354vfb153
X-Google-Smtp-Source: AK7set899Mp+ZAXYmydygcpS1al3r1urualMXZhZTEmaumUw1tSX19GKURAKIAClz2fBGMP5x3dRXw==
X-Received: by 2002:a0c:e2c2:0:b0:537:7311:cf5a with SMTP id t2-20020a0ce2c2000000b005377311cf5amr13858846qvl.12.1674760007447;
        Thu, 26 Jan 2023 11:06:47 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id i7-20020a05620a0a0700b006fbbdc6c68fsm1411163qka.68.2023.01.26.11.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 11:06:47 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        tglx@linutronix.de, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v7 0/1] Checkpoint Support for Syscall User Dispatch
Date:   Thu, 26 Jan 2023 14:06:44 -0500
Message-Id: <20230126190645.18341-1-gregory.price@memverge.com>
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
 kernel/entry/syscall_user_dispatch.c          | 39 +++++++++++++++++++
 kernel/ptrace.c                               |  9 +++++
 5 files changed, 79 insertions(+), 1 deletion(-)

-- 
2.39.0

