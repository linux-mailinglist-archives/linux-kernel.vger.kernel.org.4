Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7669E6B4D87
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjCJQuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjCJQt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:49:57 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8725C59FD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:46:48 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id v11so6196537plz.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678466807;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35SjvhjPtwHw5aEHQu1svgOUWOsHT5bfGA8ICnLpgS0=;
        b=Frmb0DH0lR3tnkefvDrjEiHvj48brgx4ocJyvkv+ZWM5o93Nxl46kUxYUsXMG3rOyH
         raHF5S46G6Io33YTqHOJ2RNmhz4qVVhFBvJ0JteR4fJU+jY8aAjQ51DEBvjAEvn2CbFf
         bnslfJtzWcZu+3/9pMpyo1p6ML/cLa8Kfzxva1ahneZcdCjm/pyudbNozRSEIKPCK7lv
         Ty7VCxY6+aRtsEb10zRArfqmfFmejvhMTixiWHQjqPlDyRFYAXMA5iRBnt9CHgbRyHHD
         jHzAbmJMh5f26kLYW2RIbtKyelkhV+M6GzDKsJasYEZRv6AdICk8JmKFU83P9dugLmiA
         PjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678466807;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35SjvhjPtwHw5aEHQu1svgOUWOsHT5bfGA8ICnLpgS0=;
        b=HVf8n8UN/6gvPsi4csYHBvC9rVu1GhcmnMT98ZnzhmzkXEhjMKaXvN0Bqm/LZ1Z1mU
         j13v2zVFtgxP3mvqmd615wg+DzU1JZev+aTJbleLR/SmV5+w4AlASoba0cIkIna9Lik4
         MPs7s+HzHSSvCnZrZKj1LmiQ8o6VxXMOxsyTEuhWMTGzX6VvWCdQ8VFomPiXZ73cKd7H
         dtvIKMZBsLuNWP9bL/is5AXmTgSyRfQcCMenXZ6WKi5Hr+Kqv5b0z34VE9ddCHwtgrXh
         6XFf2jxKuoJ+i6lN31hZXgZb0IlWAl37rdnQFYUgEHBrCir2ILXrJs4mljau8JakqxEh
         4OOg==
X-Gm-Message-State: AO0yUKWv380AzznMChhFBIz1fl0eLcM/WKgtMnG4jpe6iQhqsk+4nZuA
        1SGMUwtfkG/5PpAdO5VU26GEbg==
X-Google-Smtp-Source: AK7set8I5RJlEXzf+OxgwsivP9v9gXmqOhyDr2jbVSvTQKe6bfEMoR9t4LXVe4wkaeYLmse+voku7Q==
X-Received: by 2002:a17:90b:1a8f:b0:22c:59c3:8694 with SMTP id ng15-20020a17090b1a8f00b0022c59c38694mr26601678pjb.44.1678466802012;
        Fri, 10 Mar 2023 08:46:42 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id t3-20020a17090a2f8300b0023b29b464f9sm59399pjd.27.2023.03.10.08.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 08:46:41 -0800 (PST)
Date:   Fri, 10 Mar 2023 08:46:41 -0800 (PST)
X-Google-Original-Date: Fri, 10 Mar 2023 08:45:18 PST (-0800)
Subject: [GIT PULL] RISC-V Fixes for 6.3-rc2
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-6fd4abee-eb36-4748-9b07-d310908f08bb@palmer-ri-x1c9a>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.3-rc2

for you to fetch changes up to 2a8db5ec4a28a0fce822d10224db9471a44b6925:

  RISC-V: Don't check text_mutex during stop_machine (2023-03-09 14:58:51 -0800)

----------------------------------------------------------------
RISC-V Fixes for 6.3-rc2

* RISC-V architecture-specific ELF attributes have been disabled in the
  kernel builds.
* A fix for a locking failure while during errata patching that
  manifests on SiFive-based systems.
* A fix for a KASAN failure during stack unwinding.
* A fix for some lockdep failures during text patching.

----------------------------------------------------------------
There's a handful of failures with this alone, but they're all merge window
regressions from other trees and have been fixed in master already.  I figured
it would be saner to just keep this on rc1 rather than try and pull anything
else in.

----------------------------------------------------------------
Alexandre Ghiti (1):
      riscv: Use READ_ONCE_NOCHECK in imprecise unwinding stack mode

Conor Dooley (2):
      RISC-V: fix taking the text_mutex twice during sifive errata patching
      RISC-V: Don't check text_mutex during stop_machine

Palmer Dabbelt (1):
      RISC-V: Stop emitting attributes

 arch/riscv/Makefile                    |  7 +++++++
 arch/riscv/errata/sifive/errata.c      |  2 +-
 arch/riscv/include/asm/ftrace.h        |  2 +-
 arch/riscv/include/asm/patch.h         |  2 ++
 arch/riscv/kernel/compat_vdso/Makefile |  4 ++++
 arch/riscv/kernel/ftrace.c             | 13 +++++++++++--
 arch/riscv/kernel/patch.c              | 28 +++++++++++++++++++++++++---
 arch/riscv/kernel/stacktrace.c         |  2 +-
 8 files changed, 52 insertions(+), 8 deletions(-)
