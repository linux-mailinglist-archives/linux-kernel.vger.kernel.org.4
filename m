Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987A46831CC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjAaPsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjAaPsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:48:15 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB126C648
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:48:14 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id m13so3588246plx.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=la8OZBgC7aYcAt3o4Ce5dg5dt0dTa4vFux9stLocmok=;
        b=XJrImPQrIl/4wm5wtN/jh/S1cV10rzscLfyejPeO63bLXexp96Ygfz8pMfPBF+26yN
         6yPxUYH9uP9Bo7aHontrv8HK9R4Hez3O0RiccpMyO5jLlV3owmte8tTqlLeqNBhK3kSq
         9feoiunNv2niHSUVReyyzNAYwlGIX37P62QhwRId1hqHNF2iDB7LhjcXOu1hNU1mIeCe
         dNcX2QWH/QPB7Wk5Ixz2Sn3HocR7Q/FwLB8X8P6NY9iGwHieOoh3eSuUhklfKoSc74vk
         mMfiAfpYWD4v5aISzz9gsT+yrWhZf93luSK/xjcvRR44gf0GH9ocmH97oN1uLgStyUX+
         kmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=la8OZBgC7aYcAt3o4Ce5dg5dt0dTa4vFux9stLocmok=;
        b=8E0b70eT+ZbylH0mWE8SuNNhSf6A0VNYGjUQe/yAepzK0fX01MTc2+o1QdSPqFkUsI
         N+cBUqbJFjqEFeraEGB+Gi2HR15cf1VYXF4JM5hkRDTRLWsNVXekPZWfPfj2CYEl60ye
         znHvW5zHmD2sZ+WfOXskr9F3ciDqt3Y3TA9tPXLxrwLlCHzh09JtG8XuJnTDek+dylDM
         8KVlStDeEWVuU9v64WYdU0GsyZte1own4+xBw6taS/+Qf+V1NTrEWpSDT5+r7ZFN5zus
         5jdwemhNsKlIJKEuwzceWrs68jRPWoPHYYTg0rbb2x2JwWAOEEql8hEc/hH8YexHpH91
         m1RA==
X-Gm-Message-State: AO0yUKXyOwFyJgWMEsvRRcxTbdZ49jBrvUs0q6QSg+vanskNOZDVLV+6
        z9g7ry/MEM7kh4FqGt7hWGTGGewjBt/m873jhF8=
X-Google-Smtp-Source: AK7set+UQu97F5JDMbZSW5Zp0ZVnOmV17D9JI6UbXY9ODO+fJUTkVma/G3lmCkXnnfLMQFb4HOkq+w4ZUIZCpT2N5rY=
X-Received: by 2002:a17:90a:630b:b0:22c:5b7f:d37f with SMTP id
 e11-20020a17090a630b00b0022c5b7fd37fmr1960691pjj.31.1675180094246; Tue, 31
 Jan 2023 07:48:14 -0800 (PST)
MIME-Version: 1.0
References: <20220819032706.695212-1-xiehuan09@gmail.com> <20221017154057.78babf40@gandalf.local.home>
 <CAEr6+ECqn7rABE0cJP_oPr6g37B1kXu2xpge7Pg67hxywqyO0g@mail.gmail.com>
 <20221129113006.0d745fae@gandalf.local.home> <CAEr6+EArZtwJPwZnKAB_61a=khPpC1=6ogqEC8r4npaaX0WvjA@mail.gmail.com>
 <CAEr6+EB89otsHVOnYNGQ_gbo_g=2fNiU4+3pk06YWFrpZDy=kQ@mail.gmail.com> <20230131103623.53a4e3a3@gandalf.local.home>
In-Reply-To: <20230131103623.53a4e3a3@gandalf.local.home>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Tue, 31 Jan 2023 23:48:02 +0800
Message-ID: <CAEr6+EBdJLZ7pQyxr9uzMMfaUdW4skaaqSD7LtzG14TmtCf2WA@mail.gmail.com>
Subject: Re: [PATCH v15 0/4] trace: Introduce objtrace trigger to trace the
 kernel object
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, chensong_2000@189.cn
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 11:36 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 31 Jan 2023 17:55:16 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
>
> >  Hi Steve,
> >
> > On Sat, Dec 17, 2022 at 4:27 PM Jeff Xie <xiehuan09@gmail.com> wrote:
> > >
> > > On Wed, Nov 30, 2022 at 12:30 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > > >
> > > > On Wed, 30 Nov 2022 00:09:51 +0800
> > > > Jeff Xie <xiehuan09@gmail.com> wrote:
> > > >
> > > > > > Now instead of searching the function arguments for "obj", we should just
> > > > > > read the obj value at every function and report when it changed, as well as
> > > > > > the last function it was still the same. The report will be like the
> > > > > > "func_repeats" entry. And instead we can print when the object changes,
> > > > > > something like this:
> > > > > >
> > > > > >               cat-117     [002] ...2.     1.602245: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x2000 (last value:0x1000 at [002] __bio_add_page <-bio_add_page ts: 1.602245)
> > > > >
> > > > >
> > > > > I'm just curious if we'll see this rewritten version in the next merge
> > > > > window  ;-)
> > > >
> > > > Unfortunately, this ended up getting dropped in priority, as my workload
> > > > increased internally. :-/
> > >
> >
> > I would like to ask if there is any hope that this patchset can be
> > merged into the linux kernel in the end.
> >
> > We spent a lot of time on this patchset, I don't want to give up so easily ;-)
> >
>
> I think we were near the end, but it wasn't quite done, as I want it to be
> integrated with the kprobes indirection interface:
>
>   https://lore.kernel.org/all/20220924160136.5029e942@rorschach.local.home/
>
> Which I started to work on but didn't have time to finish, nor even get
> very far with it.
>
> I think once we can get that implemented, then this can get in. I don't
> want to give up on it either.

Thank you for your positive and fast feedback.

>
> -- Steve


-- 
Thanks,
JeffXie
