Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6DD6A7C32
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 09:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjCBIEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 03:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBIEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 03:04:08 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E4613D7E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 00:04:06 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s11so189433edy.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 00:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPeAAXYW7Bewgw47CWdiJWo1wFABur0NebkKefn8ixw=;
        b=XPGNGpz2AZQ/ZzC4GkQQlLQqzNIS/hjc+iSdwh4tYRCbd2wfF1zh7Z4lZqlqg5EhpG
         Y38WtXp8mX7zkVJXntgAJmL4H/6xicl1QgUzHG46Q6JgDP1xmsoHbdqsthceSQMfYoFs
         +BPHhucuC9J0ThpBhxfomiDGg599oXAdm5a6y16EC/QGxQ6mC8fIWAE2yh0voB1pf0Q5
         2urkz1i2JrCobWct3JWWPPCeyQNToTUsYKUG/LW51IIYLMz0cI5vBSGdsu7DZKYoH49j
         M0AsQr+TBcJldKBs/6/M2FI3XBG5vmwf0KyLK0HCo85FISguQiv78dvqyDzYLCiEiAFj
         x4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UPeAAXYW7Bewgw47CWdiJWo1wFABur0NebkKefn8ixw=;
        b=4SZHwfTfcdbk99EjolsodkV2IzeUWJWrSLlwy3qwpVBUQ+P/rAz+CjZ/8WmhAoHkIu
         XAvWde2Ye1yQZRd5LoTWCVtIY98bzJwoZZkGN+dKRIVklBxFZ4XQfeGF4rGXtvtlCk7I
         UepWdAR5dHJ7PiI+fJbD8SaEPAa1G38b0IXNZU2OhKLqp9N4fujwMqtkjf6BUE4+XgEP
         SegaTgtWGFqb6GCnluVewNv/rybeKSu0ITQ4zqhyZ3i9hZvd67Ha5D6ILSSQcRGlO9j9
         0gowalWKill+2y2WomXbIRoIyynNpablb4Xd8j8wtIe8A+tIWYP1B4J60+QhmJvU2aBP
         HdDg==
X-Gm-Message-State: AO0yUKVed7YEPBZq4E96TKnPM6pJOMO9Kd9hUksZnYqHvftr6qUS7ERa
        AODuLA0sbWXaqMAen1Tj+X4=
X-Google-Smtp-Source: AK7set8OqDLpBNpg7xcriXK2BCaITaSKuHwfC526OfOF/g20b9zcrR3xSuJ6fvCjAJ5yapHdIckuBQ==
X-Received: by 2002:a17:906:5805:b0:86a:833d:e7d8 with SMTP id m5-20020a170906580500b0086a833de7d8mr8830668ejq.17.1677744244619;
        Thu, 02 Mar 2023 00:04:04 -0800 (PST)
Received: from gmail.com ([31.46.241.31])
        by smtp.gmail.com with ESMTPSA id gg16-20020a170906e29000b008d044ede804sm6656790ejb.163.2023.03.02.00.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 00:04:03 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 2 Mar 2023 09:03:57 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] objtool changes for v6.3
Message-ID: <ZABYbRAg4XsuW2iI@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest objtool/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2023-03-02

   # HEAD: 00c8f01c4e84637c3db76f368b8687cb61f4dd9d objtool: Fix ORC 'signal' propagation

NOTE:

 - We had to perform a rebase of 10 tail commits a week ago & merged in an 
   upstream tree within the merge window [585a78c1f77b], to eliminate
   3 duplicate commits with the Xen tree that are already upstream. (This
   was a cross-tree cooperation mishap we didn't want to cause duplicate
   upstream commits - just in case you are wondering about the merge commit.)

Changes in this cycle were:

 - Shrink 'struct instruction', to improve objtool performance & memory
   footprint.

 - Other maximum memory usage reductions - this makes the build both faster,
   and fixes kernel build OOM failures on allyesconfig and similar configs
   when they try to build the final (large) vmlinux.o.

 - Fix ORC unwinding when a kprobe (INT3) is set on a stack-modifying
   single-byte instruction (PUSH/POP or LEAVE). This requires the
   extension of the ORC metadata structure with a 'signal' field.

 - Misc fixes & cleanups.

 Thanks,

	Ingo

------------------>
Ian Rogers (3):
      objtool: Install libsubcmd in build
      objtool: Properly support make V=1
      objtool: Fix HOSTCC flag usage

Josh Poimboeuf (3):
      x86/unwind/orc: Add 'signal' field to ORC metadata
      x86/entry: Fix unwinding from kprobe on PUSH/POP instruction
      objtool: Fix ORC 'signal' propagation

Miaoqian Lin (1):
      objtool: Fix memory leak in create_static_call_sections()

Michal Kubecek (1):
      objtool: Check that module init/exit function is an indirect call target

Peter Zijlstra (9):
      objtool: Change arch_decode_instruction() signature
      objtool: Make instruction::stack_ops a single-linked list
      objtool: Make instruction::alts a single-linked list
      objtool: Shrink instruction::{type,visited}
      objtool: Remove instruction::reloc
      objtool: Union instruction::{call_dest,jump_table}
      objtool: Fix overlapping alternatives
      x86: Fix FILL_RETURN_BUFFER
      objtool: Remove instruction::list

Thomas Weiﬂschuh (5):
      objtool: Make struct entries[] static and const
      objtool: Make struct check_options static
      objtool: Allocate multiple structures with calloc()
      objtool: Optimize layout of struct symbol
      objtool: Optimize layout of struct special_alt


 arch/x86/entry/entry_64.S               |   9 +-
 arch/x86/include/asm/nospec-branch.h    |   2 +-
 arch/x86/include/asm/orc_types.h        |   4 +-
 arch/x86/include/asm/unwind_hints.h     |  10 +-
 arch/x86/kernel/unwind_orc.c            |   5 +-
 include/linux/objtool.h                 |  11 +-
 tools/arch/x86/include/asm/orc_types.h  |   4 +-
 tools/include/linux/objtool.h           |  11 +-
 tools/objtool/.gitignore                |   1 +
 tools/objtool/Build                     |   2 -
 tools/objtool/Documentation/objtool.txt |   8 +
 tools/objtool/Makefile                  |  66 ++++--
 tools/objtool/arch/powerpc/decode.c     |  22 +-
 tools/objtool/arch/x86/decode.c         | 107 +++++----
 tools/objtool/builtin-check.c           |   2 +-
 tools/objtool/check.c                   | 375 ++++++++++++++++++++------------
 tools/objtool/elf.c                     |  42 ++--
 tools/objtool/include/objtool/arch.h    |   6 +-
 tools/objtool/include/objtool/builtin.h |   2 -
 tools/objtool/include/objtool/cfi.h     |   1 +
 tools/objtool/include/objtool/check.h   |  61 +++---
 tools/objtool/include/objtool/elf.h     |   9 +-
 tools/objtool/include/objtool/objtool.h |   1 -
 tools/objtool/include/objtool/special.h |   2 +-
 tools/objtool/objtool.c                 |   1 -
 tools/objtool/orc_dump.c                |   4 +-
 tools/objtool/orc_gen.c                 |   1 +
 tools/objtool/special.c                 |   6 +-
 28 files changed, 455 insertions(+), 320 deletions(-)
