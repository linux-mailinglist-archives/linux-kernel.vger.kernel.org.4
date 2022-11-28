Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D4463A739
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiK1Lav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiK1Lar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:30:47 -0500
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4110264D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:30:46 -0800 (PST)
Received: by mail-pl1-f181.google.com with SMTP id k7so9834843pll.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:30:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RmFO5OJ3cd4rLP1Vd2+1lbrtn+fA46/oGhT7pixxOn8=;
        b=qoq/ZFhkKT9gZ2CXzkV1QjlGz4yVmtwO3S97reYw3ghSipeHKaWBeoA09U04Wbr2qP
         7G2EuZ4g0+UFsxFR4lP14GyzK4NQdd2eT9psRJFqu8x58jR6ZXM/FdKqQODUCBFMbj08
         EiuKCwkl9WGvOExsPYUrRmjAfloak08E0BmfLWdqeJzAckGKM1GhzyHeFKmiHKSXI2Qc
         dbCWKMw6NBdSlTGAyZm1ObCJzR1Loqv2YddMGA3aZrl6ndcLd79vZUCpwWrPl7D3pbHg
         iV70+S/LgsFVsTb9RgMIayczo/+hYmuvIX6vt4v4G6nw/TCjEdDoXJWeqjepeLMZXUgL
         WpGA==
X-Gm-Message-State: ANoB5plMT5Rt2ooCRSnk3pJQ2OkwFN1z6sjFbkXhL4OAmWl0Imq5Cfo0
        U8xIt7ACWHAWWqCF0Xd1+yZKTnSa/KtH5QmJ46ysXf37X2Pkbw==
X-Google-Smtp-Source: AA0mqf6pr9VkEctdEd50192SSHk7BNGy7brh38vcW49MrSZc4FoxwDHJsas6GXoEIYCLPHazH12pRLOsbl0pi/NPWHE=
X-Received: by 2002:a17:902:aa04:b0:17f:6fee:3334 with SMTP id
 be4-20020a170902aa0400b0017f6fee3334mr31752930plb.10.1669635046224; Mon, 28
 Nov 2022 03:30:46 -0800 (PST)
MIME-Version: 1.0
References: <20221128091506.gp4l6klznqhigjxv@box.shutemov.name>
 <20221128101117.3614401-1-mailhol.vincent@wanadoo.fr> <20221128111112.dzavip4eqqgpyrai@box.shutemov.name>
In-Reply-To: <20221128111112.dzavip4eqqgpyrai@box.shutemov.name>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Mon, 28 Nov 2022 20:30:35 +0900
Message-ID: <CAMZ6RqJ0EgbLcz97ujqEzF1MBsH045W0Cu8mMuR0WCx_cTemCQ@mail.gmail.com>
Subject: Re: [PATCH] x86/asm: Remove unused COMPILE_OFFSETS macro from asm-offsets.c
To:     kirill.shutemov@linux.intel.com
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, viro@zeniv.linux.org.uk, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon. 28 Nov. 2022 at 20:11, <kirill.shutemov@linux.intel.com> wrote:
> On Mon, Nov 28, 2022 at 07:11:17PM +0900, Vincent Mailhol wrote:
> > On Mon, 28 Nov 2022 12:15:06 +0300, Kirill A. Shutemov wrote:
> > > On Sun, Nov 27, 2022 at 03:23:35PM +0900, Vincent Mailhol wrote:
> > > > Following [1], the macro COMPILE_OFFSETS becomes unused:
> > >
> > > Really? I see #ifdef COMPILE_OFFSETS in ftrace.h. Hm?
> > >
> > > Have you tested your patch with CONFIG_FTRACE_SYSCALLS=y and
> > > CONFIG_IA32_EMULATION=y?
> >
> > Even if I activate those two configurations, the compiler still
> > tells me it is unused:
> >
> >   $ grep -E "CONFIG_FTRACE_SYSCALLS|CONFIG_IA32_EMULATION" .config
> >   CONFIG_IA32_EMULATION=y
> >   CONFIG_FTRACE_SYSCALLS=y
> >
> >   $ make W=2 arch/x86/kernel/asm-offsets.o
> >   <...>
> >   arch/x86/kernel/asm-offsets.c:7: warning: macro "COMPILE_OFFSETS" is not used [-Wunused-macros]
> >   <...>
>
> If you are sure <asm/ftrace.h> is never included from asm-offsets.c,
> remove #ifndef COMPILE_OFFSETS too.

It is never included from asm-offsets.c but it is still used by
kvm-asm-offsets.c:
https://elixir.bootlin.com/linux/v6.1-rc7/source/arch/x86/kvm/kvm-asm-offsets.c#L7
