Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE3E68EB14
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjBHJXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjBHJWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:22:37 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CCC1BEF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:20:32 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id v17so26191022lfd.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 01:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6x/YLvjMdKqIyfSq9HWwMBVMm1r5pILgbR3br9aIWe4=;
        b=eDNiEt5ahHb0Nak3ekxqptay2gOu7jeigadWsx/mo1bJoUDQCyLGcBDi6oFGt616wG
         JvcD0uxBDJp6+N749kMGO8DJoYJaUbFP3IUcta47A91TCIBvHm30nWUX1+QgWQWtkFTj
         bfUelsTHIovsAqwjj0IuNpH29JzXWSDKXsaWZ0JGLZw6QoBo5ou19t6Zw97hA1RfD1mz
         sJN+sp756ZRHSHKWiN725SZxl/RkADyQhWFkhkDPFtb7o2o/levnXS9ZZ2OYb/p/sfIf
         8yqfUCeIB6u1R8qpWtOYfcAEAoHZyZZH1frh8sg4j2madxhDfJ2MshoH+GbNTC9Dqnca
         6qOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6x/YLvjMdKqIyfSq9HWwMBVMm1r5pILgbR3br9aIWe4=;
        b=bnc/xj0ZZabedsg59KFJuQMGI113hcFZ9nVSUoPj9o+7mw1OeqPugvWnywqJ5mvWAJ
         wFIKKamYz0YDlrp6HhBdcnVGNebZhc6UMoAGb/bQiYkcDLH8D0y/r8QIgZrF7LsztEAf
         H5uDVemcNyHmojs/kVsngMSoP77Vgq7ghOMqXtbsTDKDcGZarlW4gHO3My0sxKNsywU6
         8qHyB76BlGruFXfDt07oqPgF0QMBhvMFRjQKwxamL/cQH2fCDYO3m6+PA9G6sDqYxopk
         cwZAr32d0eqLN/hajZBZ5t+1jjLQup80v0xPbwmozRuPBQMdSi636WmDUKC4se4Ctbcp
         0crA==
X-Gm-Message-State: AO0yUKXCKdWPklwystsDFXXwdpxoWCauHHZT8cfpvix+TREtOTp+7r9X
        pPXXvfSxYuJDQxCnRotuEXbRzE+5dMoEawI9UFY=
X-Google-Smtp-Source: AK7set+kypxFGR3xaFePIv6tbGa7nm2uXd/1Q8BtGmcGgbmFBf62BNVkuqZhLtzKe7MWYdoSW8CDnfKgnRuRHAYikO4=
X-Received: by 2002:ac2:4350:0:b0:4ca:f757:6c91 with SMTP id
 o16-20020ac24350000000b004caf7576c91mr1005207lfl.92.1675848030486; Wed, 08
 Feb 2023 01:20:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675734681.git.chenfeiyang@loongson.cn> <1af05c1441e9f96870be1cc20b1162e3f5043b2e.1675734681.git.chenfeiyang@loongson.cn>
 <1e7da4e7-392d-4a9e-aa95-0599a0c84419@app.fastmail.com> <CACWXhK==yVZGZbY+3DUAuxL34=gKwQv20Cw3y1+QKir0D2F3EQ@mail.gmail.com>
 <Y+MXk9A+gB1W6T/n@1wt.eu> <CACWXhKn1N6f7XvtrbDno4UyAhMZbV_htQoRbm0ws9gjF08wnBw@mail.gmail.com>
 <7c98aac5-6b64-4f6b-b242-7ad3b8a334a8@app.fastmail.com> <Y+NbF6OrYu62OQCX@1wt.eu>
In-Reply-To: <Y+NbF6OrYu62OQCX@1wt.eu>
From:   Feiyang Chen <chris.chenfeiyang@gmail.com>
Date:   Wed, 8 Feb 2023 17:20:18 +0800
Message-ID: <CACWXhKmWo0MX2mVE3O_xDDwNg7XxW_Yjm272K2nzRAiN13CQ9w@mail.gmail.com>
Subject: Re: [PATCH 1/3] nolibc: Add statx() support to implement sys_stat()
To:     Willy Tarreau <w@1wt.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2023 at 16:19, Willy Tarreau <w@1wt.eu> wrote:
>
> On Wed, Feb 08, 2023 at 09:06:24AM +0100, Arnd Bergmann wrote:
> > On Wed, Feb 8, 2023, at 08:42, Feiyang Chen wrote:
> > > On Wed, 8 Feb 2023 at 11:31, Willy Tarreau <w@1wt.eu> wrote:
> > >>
> > >> I generally agree with the Arnd's points overall and I'm fine with the
> > >> rest of your series. On this specific point, I'm fine with your proposal,
> > >> let's just start with sys_statx() only on this arch, please add a comment
> > >> about this possibility in the commit message that brings statx(),
> > >> indicating that other archs are likely to benefit from it as well, and
> > >> let's see after this if we can migrate all archs to statx.
> > >>
> > >
> > > We have a problem if we just start with sys_statx() only on this arch.
> > > When struct stat is not defined, what should we do with stat() in the
> > > nolibc selftest?
> >
> > To clarify: your proposed implementation of the stat() function that
> > fills the nolibc 'struct stat' based on information from 'struct statx'
> > is fine here. Just remove the 'struct sys_stat_struct' definition
> > loongarch but keep 'struct stat'.
>
> Ah I think now I understand the problem Feiyang is facing. Since "struct
> stat" is just between libc and userland, there's the "sys_stat_struct"
> that we're using to abstract the syscalls in sys_stat() and that is
> compatible with each variant of the stat() syscall on each arch. Here
> there's simply no stat() syscall so it's best not to try to abstract
> this function at all since types will not match between stat and statx,
> so it will be better to just implement it like this:
>
> #if defined(__NR_statx)
>     static __attribute__((unused))
>     int sys_stat(const char *path, struct stat *buf)
>     {
>        struct statx statx;
>        long ret;
>
>        ret = statx(...);
>        buf->xxx = statx.xxx;
>        ...
>        return ret;
>     }
> #else ...
>    // keep the regular sys_stat() here
> #endif
>
> Also looking at the man page I see that statx() only appeared in 4.11,
> and here we're targetting userland so I'd rather keep a bit of margin
> when it comes to backwards compatibility, thus not dropping stat() and
> friends too early when not necessary. However using statx() by default
> when available sounds fine to me!
>

Hi, Arnd, Willy,

I think I get it now, thank you!

Thanks,
Feiyang

> Cheers,
> Willy
