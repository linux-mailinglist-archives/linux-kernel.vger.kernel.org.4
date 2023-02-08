Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5116068E933
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjBHHnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjBHHnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:43:10 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F3610411
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 23:43:09 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bi36so25896609lfb.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 23:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mVCtFK5+Mzt3hAp57nZ3RLtIxxaSOtloZUtvAg8w8Z8=;
        b=VC+DuNOOj82IU4SduBxcLaGSrM4ddq1tKPseKrkGHxrCuw6C/zChYL0qfklZdF3P+R
         D8iSXjulGePVAobJZom/AbyDrYjYoyTEXpmBoVlf8bfLTTa58LNTnVU9IluL9SnnYy4+
         Xhteo6NM0gniCGjlZ9LVNHdnI+ch8r40Pr+V9w6Pn5fT/DWby3Wiy0apGsjIoE4MD87F
         PAUlSSgzqdIaRPULhcl/SOkLvQG2vUG94lwmIYS6Zvq8WqNntjWA2DeZOzAGaJag5KHN
         M6eAl5fpOnIncJ/PIO101Fnr6nQTWSLxJ2Bsu4d4iXAGLGDnEN7cfPow6lg01i9FIeqc
         viQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mVCtFK5+Mzt3hAp57nZ3RLtIxxaSOtloZUtvAg8w8Z8=;
        b=jRWmAa1JlIN201iRCQdUpLj60iQLcSdfRO7qQSRKEar/2m3tHtAI0MN3VfjNW7SdeS
         7j3uzN3893D7NSLimCvFqfiqIn57sLwvtcVKHAhtrQ8jCUZGSwdyLS8Y5amXxHJzbahK
         9OxT5evbmTRTXgqsIzWe1u3Z8bPeZBwopWoGwlPZMqS/RgAoI49OkRe7hBh6Hgjt8MHY
         Vu3kw3iacpYKx5AqoW+cj0qzz0bZLGTtouQAJxiUpJFlkFKySqr3nWgi3QP9FKLSRbp7
         mE9XUL67Ew34I9VdtWQCPYBsMmCq+gJS9nkbZqkjycEngCn4evSTB8ZYDFMRMIRloh+l
         /f1g==
X-Gm-Message-State: AO0yUKUZFHzieCVBdFQ2k26B4ZkF+MmQqEtz8lR41EQ0RHkwcVsFmfTh
        3n8bqqGWQVKrZ9SyBfDWfQiFWIrC0MaTtenJOlgO/VCiiQ2ARti/
X-Google-Smtp-Source: AK7set8sYvuy7Swp4ow4tiyiX80IrlkMkxfPBMo7vkP9t44dgWIjcaX3D9lMBrZqlgJspQF9whRYX1nMJFdMt/TWUR0=
X-Received: by 2002:a19:f60e:0:b0:4b5:5f2d:1458 with SMTP id
 x14-20020a19f60e000000b004b55f2d1458mr1153724lfe.253.1675842187514; Tue, 07
 Feb 2023 23:43:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675734681.git.chenfeiyang@loongson.cn> <1af05c1441e9f96870be1cc20b1162e3f5043b2e.1675734681.git.chenfeiyang@loongson.cn>
 <1e7da4e7-392d-4a9e-aa95-0599a0c84419@app.fastmail.com> <CACWXhK==yVZGZbY+3DUAuxL34=gKwQv20Cw3y1+QKir0D2F3EQ@mail.gmail.com>
 <Y+MXk9A+gB1W6T/n@1wt.eu>
In-Reply-To: <Y+MXk9A+gB1W6T/n@1wt.eu>
From:   Feiyang Chen <chris.chenfeiyang@gmail.com>
Date:   Wed, 8 Feb 2023 15:42:56 +0800
Message-ID: <CACWXhKn1N6f7XvtrbDno4UyAhMZbV_htQoRbm0ws9gjF08wnBw@mail.gmail.com>
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

On Wed, 8 Feb 2023 at 11:31, Willy Tarreau <w@1wt.eu> wrote:
>
> Hi Feiyang,
>
> Sorry for the delay.
>
> On Wed, Feb 08, 2023 at 10:09:48AM +0800, Feiyang Chen wrote:
> > On Tue, 7 Feb 2023 at 22:31, Arnd Bergmann <arnd@arndb.de> wrote:
> (...)
> > > Given that all architectures implement statx the same way, I wonder
> > > if we can't just kill off the old function here and always use statx.
> > >
> > > That would also allow removing the architecture specific
> > > sys_stat_struct definitions in all arch-*.h files.
> > >
> >
> > Hi, Arnd,
> >
> > I'd really like to make all architectures use sys_statx() instead
> > of sys_stat(). I just fear we might get dragged into a long discussion.
> > Can I send a patch series to do this later?
>
> I generally agree with the Arnd's points overall and I'm fine with the
> rest of your series. On this specific point, I'm fine with your proposal,
> let's just start with sys_statx() only on this arch, please add a comment
> about this possibility in the commit message that brings statx(),
> indicating that other archs are likely to benefit from it as well, and
> let's see after this if we can migrate all archs to statx.
>

Hi, Arnd, Willy,

We have a problem if we just start with sys_statx() only on this arch.
When struct stat is not defined, what should we do with stat() in the
nolibc selftest?

> I'm having another comment below however:
>
> > > > +struct statx_timestamp {
> > > > +     __s64   tv_sec;
> > > > +     __u32   tv_nsec;
> > > > +     __s32   __reserved;
> > > > +};
> > > > +
> > > > +struct statx {
> > > > +     /* 0x00 */
> > > > +     __u32   stx_mask;       /* What results were written [uncond] */
> > > > +     __u32   stx_blksize;    /* Preferred general I/O size [uncond] */
> > > > +     __u64   stx_attributes; /* Flags conveying information about the file
> (...)
>
> For all these types exposed to userland that you have to define, I'd
> prefer if we would avoid using kernel-inherited types like __u32, __u64
> etc given that all other archs for now only use regular types. It's not
> critical at all but I'd prefer that we stay consistent between all archs.
> Also, based on the comments on the fields it seems to me that this file
> was just copy-pasted from some uapi header which is not under the same
> license, so that's another reason for just defining what is needed here
> if you need to define it here. And of course, if including linux/stat.h
> also works, that's by far the preferred solution which will also save
> us from having to maintain a copy!
>

I try to include linux/stat.h and it works.

Thanks,
Feiyang

> Thanks!
> Willy
