Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1D36F1660
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345600AbjD1LF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345739AbjD1LFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:05:52 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2B149D2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 04:05:35 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64115eef620so11630581b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 04:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682679935; x=1685271935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDCWddT8uldXy1MsYQfBwNU4U/3mNf0JXHspRWH9+ZQ=;
        b=GQzUjvDZnfF23R54fvFvBDWzw5gkr9wKc9LCmayILvW5Lg8w/eF2h2JBPbzstyApcJ
         SP90aAOEky8Mua3UVw4zYD4IS4LMm/g54KSnn0+vRf0bY5cwosO2wq1GV94XBtIu0r5/
         +nGIiPvtfdFZnZBA62qi8rZYGorRKCWy4sgpimAUtpg4ZCQ7ZbOG+ty1fMwDNu8n5Xls
         g5+vRJOsWRvj8jrwVgWdwUTfYVdM21dsvKG6cCTYDClbgFWPjiZBiPC23rcE3ym0rRFX
         laht1odx6RkBnJGJi4XhAF2zbbXee4qd6pP3MrKh1iWg/ZTgCgJa6FqhwTj7HZ1ZFzPw
         j4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682679935; x=1685271935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDCWddT8uldXy1MsYQfBwNU4U/3mNf0JXHspRWH9+ZQ=;
        b=Ddi0O7Vy590+YKNqm7XEVG40c/WtfroWIMfQYJDhSQ9YfqSVADZLe9dfD9bbvGQhi+
         QLlJd8GGWWmJkfsKjxeoSJlFgS+B9lzONe7xTk8Sn6TbMASO8gkEfIbsEJGfoBrah2z7
         r9k6BDxZxIT3wVEEBa5L7/NMcU3urxjik2KBO0zMo7we//C2QJPMz5gwiXou5Ctcv19i
         CskFy1lyUQ0075IANhNPD5bnHD3Ob70WmeszeDEVi31kQI0Es1QKY3wEPMiXXRpjbg3S
         BPormD+XoWGPLtfl0wDufouCL2AzS38fbixztmaMtB3Ge47jTNuNtouKZa7k9COBG0D3
         yCtg==
X-Gm-Message-State: AC+VfDy+4bWzn/nWvGGjaMnYUD8jAKaR0TJuQJ6TRBJ2Add5iV1Y1jzv
        gcXCm6Jl7E3FXL6GsVxgn181Yz5jBkq6qDVEqtnM39KGR7I=
X-Google-Smtp-Source: ACHHUZ5GASWelWwRFJ4V+jN6AtwbD6v1Rp28eaEf0i2883C54KXDlRb+lVg3ntZkpewiYHqrJAsRifHvH3bhfPD9I8s=
X-Received: by 2002:a17:90a:1b07:b0:24b:60d0:d622 with SMTP id
 q7-20020a17090a1b0700b0024b60d0d622mr5059738pjq.24.1682679934500; Fri, 28 Apr
 2023 04:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <1681898221-27828-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1681898221-27828-1-git-send-email-yangtiezhu@loongson.cn>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Fri, 28 Apr 2023 19:05:22 +0800
Message-ID: <CAEr6+ECw=5JwuQ1h1KEhm82X_UGRRSCQS0munwJ94o=ht1NSiw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Add uprobes support for LoongArch
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tiezhu,

I have tested the uprobe patchset and found that:

# perf probe -x /lib/libc.so.6 malloc
# perf record -e probe_libc:malloc -aR sleep 30

Then the OS will hang forever and the problem can always be reproduced.

On Wed, Apr 19, 2023 at 6:10=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> v3:
>   -- Check atomic instructions in insns_not_supported()
>   -- Remove five DIE_* definitions in kdebug.h
>
> v2:
>   -- Move the functions to inst.c in patch #1
>   -- Pass around union for insns_not_supported(),
>      insns_need_simulation() and arch_simulate_insn()
>
> v1:
>   -- Split the RFC patch #2 into two patches
>   -- Use larch_insn_gen_break() to generate break insns
>      for kprobes and uprobes
>   -- Pass around instruction word instead of union for
>      insns_not_supported(), insns_need_simulation() and
>      arch_simulate_insn() to avoid type conversion for callers
>   -- Add a simple test case for uprobes in the commit message
>
> Tiezhu Yang (6):
>   LoongArch: Move three functions from kprobes.c to inst.c
>   LoongArch: Add larch_insn_gen_break() to generate break insns
>   LoongArch: Use larch_insn_gen_break() for kprobes
>   LoongArch: Add uprobes support
>   LoongArch: Check atomic instructions in insns_not_supported()
>   LoongArch: Remove five DIE_* definitions in kdebug.h
>
>  arch/loongarch/Kconfig               |   3 +
>  arch/loongarch/include/asm/inst.h    |  42 ++++++++++
>  arch/loongarch/include/asm/kdebug.h  |   5 --
>  arch/loongarch/include/asm/kprobes.h |   2 +-
>  arch/loongarch/include/asm/uprobes.h |  36 +++++++++
>  arch/loongarch/kernel/Makefile       |   1 +
>  arch/loongarch/kernel/inst.c         |  54 +++++++++++++
>  arch/loongarch/kernel/kprobes.c      |  75 ++++--------------
>  arch/loongarch/kernel/traps.c        |   9 +--
>  arch/loongarch/kernel/uprobes.c      | 143 +++++++++++++++++++++++++++++=
++++++
>  10 files changed, 298 insertions(+), 72 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/uprobes.h
>  create mode 100644 arch/loongarch/kernel/uprobes.c
>
> --
> 2.1.0
>


--=20
Thanks,
JeffXie
