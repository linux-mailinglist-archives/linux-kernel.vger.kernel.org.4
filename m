Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AA172B8F0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbjFLHni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235260AbjFLHn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:43:29 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86DA1705
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 00:43:05 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-54f71fa7e41so691644a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 00:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686555712; x=1689147712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSLtE9E0vmCcghH4dSd0lHHpsUifthyCoqFs6ZgaUaw=;
        b=VyxQ9Rkh3zhRrPa+z0VNWVV7eMuki71zijDBxYrRhKUGgtimiNX3HiYS6FpKUCj4V7
         jvqfGYSU4bpIVBu6Z3+0Wpd7dLv55JxUNffaaWbDJNms8B4wULR1DSrRpPscL1+kALCJ
         twvdd45qWfNMLXrP+b5tOD2Yv7TOrtIeNb6JZhBQnX3UnZ4ti6MJFEbVo2aN/kALrbE7
         NRjks+atUjin0MzJlKKPKnFO+mp1tZPkDMqu/K/R2uEfg4f7oxYjYVzoiPlX0IdTX7TM
         aql9L02SifdCsxsZpwuSEOn/RzegirjCtnyv/4aUni8UOXrz0rvCbjApviX19D9ZQcQv
         OBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686555712; x=1689147712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSLtE9E0vmCcghH4dSd0lHHpsUifthyCoqFs6ZgaUaw=;
        b=FaII7R4F66fRiIKAXImOFCBXb1nUf2xXnCbv9rxupisgzttUFfn7MpQoSVNM80XwVu
         YirbaxDVHGo3cozWRYqdBnS/40JLNuZ1pHbf0PhJ4NRo1KMY0a0ehMrOxCe+Ovjt84KU
         ln1CSNtDJn1Uqaif2Sayg5NtkHMn0bnGuxO0tnfAjKb4rOxqgl6x6f+OH0VJaUFmPG50
         6QvtlRwNsYZ1Js2Xkzz4Bxu29LKhJ+4Y5UN+ezhkjvty8I5c/QDq2ekS3vHVxFCudr32
         ENM6uH16H4kA+qVYjvoPP80gkKGkhk9XpI0hyd6F1Vwgk4LfLCGB2rCqKqAMu1eKf48Z
         uPpA==
X-Gm-Message-State: AC+VfDxjJiGXvx2PUEL/s6nycfrEFuSaAHGIF5XnING5oGfIm+J9rqKP
        bFZ38ZQicWJjH591nPmJEoGCTD1V0R71ebEqJzU=
X-Google-Smtp-Source: ACHHUZ4GJlYRw5sQhOMFC+yfY+NGowvFcUFxYSpFHK3hwLbSevbI8QoY3IsTyXIBdxTb9oiPTyAB+swTScLD2gajvh0=
X-Received: by 2002:a17:90a:688d:b0:259:17c9:fda7 with SMTP id
 a13-20020a17090a688d00b0025917c9fda7mr7130374pjd.4.1686555711613; Mon, 12 Jun
 2023 00:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <1685947150-4949-1-git-send-email-yangtiezhu@loongson.cn> <CAAhV-H5CXX+tVdXj8jpYjeprwFihDJw6O6K5t6dRZPH8bWZ94A@mail.gmail.com>
In-Reply-To: <CAAhV-H5CXX+tVdXj8jpYjeprwFihDJw6O6K5t6dRZPH8bWZ94A@mail.gmail.com>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Mon, 12 Jun 2023 15:41:40 +0800
Message-ID: <CAEr6+EA9OCRANk+kVov=jZmrbxAV_vVhLV-F+5v7P7dYM2g7PQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Add uprobes support for LoongArch
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>, loongarch@lists.linux.dev,
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

On Wed, Jun 7, 2023 at 4:52=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org> =
wrote:
>
> Hi, Jeff,
>
> I queued this series at
> https://github.com/chenhuacai/linux/commits/loongarch-next, could you
> please test it when you have time? Thanks.

I have tested this series and saw no errors while using uprobe, the
patchset looks good to me.

Tested-by: Jeff Xie <xiehuan09@gmail.com>

>
> Huacai
>
> On Mon, Jun 5, 2023 at 2:39=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.c=
n> wrote:
> >
> > v5:
> >   -- Rebased on 6.4rc5
> >   -- Like arm64, add user_enable_single_step() in arch_uprobe_pre_xol()=
,
> >      add user_disable_single_step() in arch_uprobe_{post,abort}_xol(),
> >      suggested by Jeff and Huacai offline
> >
> > v4:
> >   -- Rebased on 6.4rc1
> >   -- Fix problem about "perf probe -x /lib64/libc.so.6 malloc"
> >
> > v3:
> >   -- Check atomic instructions in insns_not_supported()
> >   -- Remove five DIE_* definitions in kdebug.h
> >
> > v2:
> >   -- Move the functions to inst.c in patch #1
> >   -- Pass around union for insns_not_supported(),
> >      insns_need_simulation() and arch_simulate_insn()
> >
> > v1:
> >   -- Split the RFC patch #2 into two patches
> >   -- Use larch_insn_gen_break() to generate break insns
> >      for kprobes and uprobes
> >   -- Pass around instruction word instead of union for
> >      insns_not_supported(), insns_need_simulation() and
> >      arch_simulate_insn() to avoid type conversion for callers
> >   -- Add a simple test case for uprobes in the commit message
> >
> > Tiezhu Yang (6):
> >   LoongArch: Move three functions from kprobes.c to inst.c
> >   LoongArch: Add larch_insn_gen_break() to generate break insns
> >   LoongArch: Use larch_insn_gen_break() for kprobes
> >   LoongArch: Add uprobes support
> >   LoongArch: Check atomic instructions in insns_not_supported()
> >   LoongArch: Remove five DIE_* definitions in kdebug.h
> >
> >  arch/loongarch/Kconfig               |   3 +
> >  arch/loongarch/include/asm/inst.h    |  42 ++++++++++
> >  arch/loongarch/include/asm/kdebug.h  |   5 --
> >  arch/loongarch/include/asm/kprobes.h |   2 +-
> >  arch/loongarch/include/asm/uprobes.h |  35 ++++++++
> >  arch/loongarch/kernel/Makefile       |   1 +
> >  arch/loongarch/kernel/inst.c         |  54 +++++++++++++
> >  arch/loongarch/kernel/kprobes.c      |  75 ++++-------------
> >  arch/loongarch/kernel/traps.c        |   9 +--
> >  arch/loongarch/kernel/uprobes.c      | 152 +++++++++++++++++++++++++++=
++++++++
> >  10 files changed, 306 insertions(+), 72 deletions(-)
> >  create mode 100644 arch/loongarch/include/asm/uprobes.h
> >  create mode 100644 arch/loongarch/kernel/uprobes.c
> >
> > --
> > 2.1.0
> >



--=20
Thanks,
JeffXie
