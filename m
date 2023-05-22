Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A0F70C005
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbjEVNsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbjEVNsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:48:18 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F11F4
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 06:48:17 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5343c3daff0so4079689a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 06:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684763296; x=1687355296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGz08OQyeCqnxoLIdSWq6+vL4UPq3XQv2QFGyx1tKg0=;
        b=qjgTLN5ERjKFpuEJDSYNk4vi4w+YGsguhc3ja5gz5WGB5Yf6W8P14biSciYvbMBtS1
         uzmhoCmwR5WeSgVlFxYLxU3KwfmoQDyDtPJqB+A1+gBSsMhWP2DBAkayAeSyySIMn9Wy
         hVkG6/sVX353mDAMcCpBKRMGHZgt3Wt/K1CYOUPxVAYJfGrrPywwf/pi5RQbnPfg+6ke
         WdynKBvc5b9g9roZ4+9VUwGPq5pqfDrJWtGInWRSoipySMQA09QEXjFnoG+EaTB38oB/
         lM0YhEIU+73uu7yZkd5zf933iEcZ9WEqAXq1P9BtD53vhuz0vw4TGHD6hAuZZDH27ZVP
         VjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684763296; x=1687355296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGz08OQyeCqnxoLIdSWq6+vL4UPq3XQv2QFGyx1tKg0=;
        b=fDvJ6/Un1D6aDwYcBIDbMc8c6qdSvq2FARrbsbrnfnhLW4Wdcx+A+FxOKGKLi6Y8jJ
         HTpUrKyVJNH7brWfoTzjIxIkwy4+Zg1DKSbHV/z1vt5ojW3HHhfTWTHrE3dsw0S1joFK
         OfxoCjnw1ekAFNAcfTfCpveNEmyFoMkDeOjAjve7/8uf6yqu4bEtocg0R9LRGP/mIjrk
         jp7r8XvBE4/9vKW3phAxsTXpkRUB8TBWkzeofm2MUmo7VirAM0l7QnzvP8A7o+Q0n1O8
         APS7Y0X0jQyRmQBw9wL/XqO/RREIkniSSITZyrfahBr5pcZS/WK4jFY+Q99YpQm1BmKR
         AM3Q==
X-Gm-Message-State: AC+VfDxQzaCOYQQS6qhV0r904oGBfEMGZ/3hX+hiFYobXrK0ULHGx3vM
        JDLA7jpVF8DlOkcgRlT9zJy+9IcSwYlxUKb+ioA=
X-Google-Smtp-Source: ACHHUZ6IS5JmJ+ZDTz9QQZzHRGh7k7Pl91xxM/bsmLz/eNgRZwjR4aYBIugPczwz3Y9QlmRcmk40BVDGa6k/Iq/KC0Q=
X-Received: by 2002:a17:902:8508:b0:1af:b2d3:c6f4 with SMTP id
 bj8-20020a170902850800b001afb2d3c6f4mr2949506plb.14.1684763295850; Mon, 22
 May 2023 06:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <1683792372-29338-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1683792372-29338-1-git-send-email-yangtiezhu@loongson.cn>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Mon, 22 May 2023 21:48:03 +0800
Message-ID: <CAEr6+EBU+Uon8rMvuEhLU0nADUMDEOSVZGSkAZvtuXJCEndzMg@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Add uprobes support for LoongArch
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

On Thu, May 11, 2023 at 4:06=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> v4:
>   -- Rebased on 6.4rc1
>   -- Fix problem about "perf probe -x /lib64/libc.so.6 malloc"
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
>  arch/loongarch/include/asm/uprobes.h |  35 +++++++++
>  arch/loongarch/kernel/Makefile       |   1 +
>  arch/loongarch/kernel/inst.c         |  54 +++++++++++++
>  arch/loongarch/kernel/kprobes.c      |  75 ++++--------------
>  arch/loongarch/kernel/traps.c        |   9 +--
>  arch/loongarch/kernel/uprobes.c      | 148 +++++++++++++++++++++++++++++=
++++++
>  10 files changed, 302 insertions(+), 72 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/uprobes.h
>  create mode 100644 arch/loongarch/kernel/uprobes.c
>
> --
> 2.1.0
>
>

It looks good to me for the patchset.

Tested-by: Jeff Xie <xiehuan09@gmail.com>

--=20
Thanks,
JeffXie
