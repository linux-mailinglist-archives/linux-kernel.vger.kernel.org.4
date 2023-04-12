Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BF96DFD8C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjDLScS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDLScQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:32:16 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1C119F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:32:15 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54fba72c1adso299047b3.18
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681324334; x=1683916334;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=unsQK783ZuljLmKYpP1tTMNm96vCB2UUQkNLBUKyn0Q=;
        b=wImcPsrNxghIbuoD7vh15iP9oZ8zp6eQWP5HdYu2jMTXgzuUo/P7CdiwHMeAz9ammv
         afIu2ZztCm1f6JDK5OCHf6FSqx2+/6CZ9PniTQUJ9sNUxEKP8EAkiF68QAuSo3E2Wz6Y
         j6GmfMcThWMN1tqDem48dZIiz7Jq8XGuZqZuQNfqPSH7e5dDyMfRVGK2TDa+5eSJD5uA
         zPszVMLKZio4TTxfGwN8oAiEcD9RaBdInc4bKfB0H4bo0QKuaGBimfnuCrME7dg5IjAq
         eZtJpDh37onYwYA8W9l9X9PPKQMq2OqcqW1Lfh9CyTT316DhPCiYbW3IrvmEjlDX2V14
         9nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681324334; x=1683916334;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=unsQK783ZuljLmKYpP1tTMNm96vCB2UUQkNLBUKyn0Q=;
        b=TddjSqfkNHjr82UF4XTz+cNpFZxpy0Dv2p8sf8cjmDtCq0kqWPjJ8Fd+J01ZoANu32
         eFcy8SLyhOcxFUwRit4GxAfItDEjx/JxRkHKUAjepkcjkWUZkWqBjAz0WE1GhX2S3gR2
         rMdk3loKke6lPcZf50imMu7xbmwF+m4KlJBY9E9hsH6vfkXL7uUGi2nKAbW/SeQjb2Kn
         NgHYMJoKGfiNuIwGkxPNwCpSbaZe3FoNvuth6hNYSHmPwL3TZPhJTa1rvoTj/xtE129n
         PEm/VODZEBom79uU0nZYzehRIyfmkLHo0ELsCdWSq1ndFqMSoLmXInQ/M9B/R8MSSN5U
         Kifg==
X-Gm-Message-State: AAQBX9cuxBNXDxbmKUijcvJ/bBsiRMlEcTGLHKTiocwtgh+J0BUvEIFQ
        2a3XO8RJHIDWCLJapp1lvWProT6/PPDWuq4Kbd8=
X-Google-Smtp-Source: AKy350asfywVXW9Fy4KzqBhDU/bQX7xifl9Wja8QAMqPvcJjv4csC++8cr3ABgrfg0Put9bxHZoYkpuE4lW61gB3BIE=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:4a4a:51a1:19b:61ab])
 (user=ndesaulniers job=sendgmr) by 2002:a25:d141:0:b0:b75:8ac3:d5da with SMTP
 id i62-20020a25d141000000b00b758ac3d5damr7557621ybg.4.1681324334082; Wed, 12
 Apr 2023 11:32:14 -0700 (PDT)
Date:   Wed, 12 Apr 2023 11:32:11 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACv5NmQC/w3LQQqAIBBA0avErBPUIqzLxGhDSjKFU22ku+fyw
 f8VhEoigaWrUOhNkk5uMH0HISLvpNLWDFbbQY/GKj5XuTEcl8LZmcmh9V4jtN6jkPIFOcR28JP z9/3pKfYIYAAAAA==
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681324332; l=3360;
 i=ndesaulniers@google.com; s=20220923; h=from:subject:message-id;
 bh=O3vM+UqKG7xDqT6eRLzJnQA+CEPVjKXEAVK41sMB3WA=; b=ivxUYQ2lSDuxxyJnaW7i9pXOfQLF2GhtrPCC3EKgGw8HT6o/LAHtCIrAyC0VVPFxeosi1ulwZRPt
 C0JCTfDkAazXDRs8Yu1BkCh4vLZdWVyJ2GTXuSMNatbp4DYLqhQZ
X-Mailer: b4 0.12.2
Message-ID: <20230412-no_stackp-v1-0-46a69b507a4b@google.com>
Subject: [PATCH 0/2] start_kernel: omit stack canary
From:   ndesaulniers@google.com
To:     "Borislav Petkov (AMD)" <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A security research paper was recently published detailing Catch Handler
Oriented Programming (CHOP) attacks.
https://download.vusec.net/papers/chop_ndss23.pdf
The TL;DR being that C++ structured exception handling runtimes are
attractive gadgets for Jump Oriented Programming (JOP) attacks.

In response to this, a mitigation was developed under embargo in
clang-16 to check the stack canary before calling noreturn functions.
https://bugs.chromium.org/p/llvm/issues/detail?id=30

This started causing boot failures in Android kernel trees downstream of
stable linux-4.14.y that had proto-LTO support, as reported by Nathan
Chancellor.
https://github.com/ClangBuiltLinux/linux/issues/1815

Josh Poimboeuf recently sent a series to explicitly annotate more
functions as noreturn. Nathan noticed the series, and tested it finding
that it now caused boot failures with clang-16+ on mainline (raising the
visibility and urgency of the issue).
https://lore.kernel.org/cover.1680912057.git.jpoimboe@kernel.org/

Once the embargo was lifted, I asked questions such as "what does C++
structured exception handling have to do with C code" and "surely GCC
didn't ship the same mitigation for C code (narrator: 'They did not:
https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=a25982ada523689c8745d7fb4b1b93c8f5dab2e7')?"

I now have a patch out for LLVM to undo this mess (or at least limit it
to C++ functions that may throw, similar to GCC's mitigation); it hasn't
landed yet but we're close to consensus and I expect it to land
imminently.
https://reviews.llvm.org/D147975

Remember this thread?  (Pepperidge farms remembers...)
https://lore.kernel.org/all/20200314164451.346497-1-slyfox@gentoo.org/

That reminded me that years ago we discussed a function attribute for
no_stack_protector.
https://lore.kernel.org/all/20200316130414.GC12561@hirez.programming.kicks-ass.net/

GCC didn't have one at the time, it now does. In addition to the LLVM
fix, I'd like to introduce this in the kernel so that we might start
using it in additional places:
* https://lore.kernel.org/linux-pm/20200915172658.1432732-1-rkir@google.com/
* https://lore.kernel.org/lkml/20200918201436.2932360-30-samitolvanen@google.com/
And eventually remove the final macro expansion site of
prevent_tail_call_optimization.

With the LLVM fix, this series isn't required, but I'd like to start
paving the way to use these function attributes since I think they are a
sweet spot in terms of granularity (as opposed to trying to move
start_kernel to its own TU compiled with -fno-stack-protector).

(This is my first time using b4 to send a series, as per
https://people.kernel.org/monsieuricon/sending-a-kernel-patch-with-b4-part-1.
Here goes nothing!)

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Nick Desaulniers (2):
      start_kernel: add no_stack_protector fn attr
      start_kernel: omit prevent_tail_call_optimization for newer toolchains

 arch/powerpc/kernel/smp.c           |  1 +
 include/linux/compiler_attributes.h | 12 ++++++++++++
 init/main.c                         |  8 +++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)
---
base-commit: 0bcc4025550403ae28d2984bddacafbca0a2f112
change-id: 20230412-no_stackp-a98168a2bb0a

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>

