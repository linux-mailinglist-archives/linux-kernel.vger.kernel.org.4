Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4B46829A4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjAaJzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjAaJz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:55:29 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B863125A8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:55:28 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id z1so6989375plg.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zNQqeS9ux7+sgyQiwT83A6zxgTgZIe3tVN+lKtRdGfM=;
        b=Z7UOQmcn7L2RlBmoZSiXDwvkFIJ+SlgEOxHQpYhBkrUjwOzuAmSAj53hL+LjXAd5k2
         4yaH/xNHkX/zvV9UF/T+3SjaEWWffwDS4WRPjL2GBdzcSqJMm1yw7B7A29SE0vzswiS7
         vIt9r312aJwT6W033TiCa+8rwUahkowK+zGP0pNALbBjwKS+zDvxFZBK0fibiglQDfzD
         mRujYUZ/TfxqoYNve7X6MemsX75+VVHpFJVMpo30faLvfUauO8K4ca2qnx3/GrLFDIaN
         FQ6h+jluRK4C0oKcR61NL9M6Q9owsto62tOW1XLWX+CTDueZJUN6HzSAF0cWjmRXzqRF
         sA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zNQqeS9ux7+sgyQiwT83A6zxgTgZIe3tVN+lKtRdGfM=;
        b=g4YulgogGvsjm8xsLbYXi2Ekwdi8vnvWiyCbteTbiTmyONnzxjK0fTJQA5jMFL/8tM
         PE99c7nsUOJcSjNYa0MaPQ5Rovulrz6BvoaguPXP48awCv1Y/yhARX9ef72ufFVAyXEu
         5JDzit79gJNNYXV7T/8d6I8mCY3SDWpRBXGkTucbsMi9g3mf7PbBab5xsvKmfB/V/dYX
         bGrlbfEShfPeCbCB/PaX4nty6oMkb0/femv57pqIskwNC6HIUuKQoci8F9/t/FzQq0A5
         6H1A92/6bW9Q9jG2z4jCHBGJ7EcJb5tcGIbBndLbmMJJGzPY1yJ2yiHHuOIfyiSH9gF8
         iWlw==
X-Gm-Message-State: AO0yUKW5W91s0QnEXs5D+HPVMoh1exJTLd5tNNX7G4vHsCpdRdJRTDku
        ABMNPXatQwe/5WjatRj50otTZWbV+ICly39mQwOz2JhzojA=
X-Google-Smtp-Source: AK7set95Kp3WLJXYec9occ2wfiNYNeo8X4kuhcLYffg4C8ramLyCodU/v/NRU8YxPhQPUHCQ9UV5On/pJ8meQbg+sEc=
X-Received: by 2002:a17:902:ab97:b0:196:2b0d:feb5 with SMTP id
 f23-20020a170902ab9700b001962b0dfeb5mr3139739plr.26.1675158927728; Tue, 31
 Jan 2023 01:55:27 -0800 (PST)
MIME-Version: 1.0
References: <20220819032706.695212-1-xiehuan09@gmail.com> <20221017154057.78babf40@gandalf.local.home>
 <CAEr6+ECqn7rABE0cJP_oPr6g37B1kXu2xpge7Pg67hxywqyO0g@mail.gmail.com>
 <20221129113006.0d745fae@gandalf.local.home> <CAEr6+EArZtwJPwZnKAB_61a=khPpC1=6ogqEC8r4npaaX0WvjA@mail.gmail.com>
In-Reply-To: <CAEr6+EArZtwJPwZnKAB_61a=khPpC1=6ogqEC8r4npaaX0WvjA@mail.gmail.com>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Tue, 31 Jan 2023 17:55:16 +0800
Message-ID: <CAEr6+EB89otsHVOnYNGQ_gbo_g=2fNiU4+3pk06YWFrpZDy=kQ@mail.gmail.com>
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

 Hi Steve,

On Sat, Dec 17, 2022 at 4:27 PM Jeff Xie <xiehuan09@gmail.com> wrote:
>
> On Wed, Nov 30, 2022 at 12:30 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Wed, 30 Nov 2022 00:09:51 +0800
> > Jeff Xie <xiehuan09@gmail.com> wrote:
> >
> > > > Now instead of searching the function arguments for "obj", we should just
> > > > read the obj value at every function and report when it changed, as well as
> > > > the last function it was still the same. The report will be like the
> > > > "func_repeats" entry. And instead we can print when the object changes,
> > > > something like this:
> > > >
> > > >               cat-117     [002] ...2.     1.602245: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x2000 (last value:0x1000 at [002] __bio_add_page <-bio_add_page ts: 1.602245)
> > >
> > >
> > > I'm just curious if we'll see this rewritten version in the next merge
> > > window  ;-)
> >
> > Unfortunately, this ended up getting dropped in priority, as my workload
> > increased internally. :-/
>

I would like to ask if there is any hope that this patchset can be
merged into the linux kernel in the end.

We spent a lot of time on this patchset, I don't want to give up so easily ;-)

-- 
Thanks,
JeffXie
