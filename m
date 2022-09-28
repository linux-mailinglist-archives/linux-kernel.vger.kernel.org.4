Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28C85EDE8F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbiI1OPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbiI1OPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:15:39 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE97F5F22E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:15:37 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so1821741pjh.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hktgs1ApCFso4Lgx9S/kJQ05/BGQ8OgyJMNxMyrvQBs=;
        b=F/6RrXPN2Oh00MjZTjWUsUmGG7qMPExV/sPvicQ1PPTbu6hbeu6/yb9iMjMeubGQK3
         9ge9yEp0QjKJQ2RF+MCAo7wZtkh4ertFYACSS1KE84tGVhMGdvkFipbkACSgBrCod9ZX
         eHRMTY5kv3GZ3X4Wu1Lrj7oRakgo4PKOartXs0AxAILL+fZsy4nz4lbqMhADKVurrLLb
         VSsuqlKDxQVWhDau0rveQ3WOMuKK6SdWPTdp+SICBF0VllWW0ej+gsfnPOe9xKmgIHWy
         02RtBjxNFfp2ZSce/juDLS0h0O68Gtfr56PMu7G6j04b5Z2IIuWKExodhEDsYOaio+8L
         ADyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hktgs1ApCFso4Lgx9S/kJQ05/BGQ8OgyJMNxMyrvQBs=;
        b=70nK0TuuYl6hXxA6EEFMc8VwAuG/+xW45sBe0EYDXnmdnXZUBnO2TA0bL8peiykcTc
         hcUElZQ/DIC4d85ejSzj5mh6dgL8LUBmqdFmlI6llDkGID2lO/AmTfcIxXyBjsLnmA/A
         26eejKMCmz6y6Wt8BjDRLRnm7GtL2bOj+Qp9H1su2MZhxJfrsYds9wAct6xwBCurhT4F
         J+AYvitb2kIJDnWDwq/TMGF3rcKEXcA8r7qDQdvXoQMIvbGbnd2Yzq0l7PwkqlRlFimh
         PGAQkw5s9I+CWPNfNpYEGTVbRdet+vXuDQyX85+GYQu6wK4Qj51iC9Al0T517ImlN4C2
         OEjQ==
X-Gm-Message-State: ACrzQf0tfrbxwFJbpYZuSNlDIHHQT4YdMIx9lNaBGRaCcx1cZamjS0PF
        R/wj/IzF4srPUVF4hK3RUVAfcoBjdD8E1fr8UR0=
X-Google-Smtp-Source: AMsMyM6eOj8LLGBi2HGME8r2zF3t5LKk+ytYQdxJy9ugdQyWFmbXQahIMQrXp5vpgu8JE7yPVjc3WkJGvvt/g0279Ko=
X-Received: by 2002:a17:902:6b8b:b0:178:7cf5:ad62 with SMTP id
 p11-20020a1709026b8b00b001787cf5ad62mr48527plk.13.1664374537372; Wed, 28 Sep
 2022 07:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220819032706.695212-1-xiehuan09@gmail.com> <20220819032706.695212-3-xiehuan09@gmail.com>
 <20220924160136.5029e942@rorschach.local.home> <CAEr6+ECbocOnr_fSp_rwnu7ugg_q0wrYWShYsW3XOJffqwSOYA@mail.gmail.com>
 <20220925115335.44b58732@rorschach.local.home> <CAEr6+EDft-pFrCdatd1ypWbjk9_KkMpBXcS6q4zaUgmkQuW0Eg@mail.gmail.com>
In-Reply-To: <CAEr6+EDft-pFrCdatd1ypWbjk9_KkMpBXcS6q4zaUgmkQuW0Eg@mail.gmail.com>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Wed, 28 Sep 2022 22:15:24 +0800
Message-ID: <CAEr6+EAHVUntQMVAC0_Rm7A2wWWC9TZsYi4PgV-tdO0bvUKguA@mail.gmail.com>
Subject: Re: [PATCH v15 2/4] trace/objtrace: Get the value of the object
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

On Mon, Sep 26, 2022 at 12:49 AM Jeff Xie <xiehuan09@gmail.com> wrote:
>
> On Sun, Sep 25, 2022 at 11:53 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Sun, 25 Sep 2022 13:27:10 +0800
> > Jeff Xie <xiehuan09@gmail.com> wrote:
> >
> > >
> > > It also looks like the "add" command field has been removed,
> > > Masami previously suggested I to add a reserved command field for the
> > > future (see [1] and [2]):
> > >
> > > [1]:
> > > https://lore.kernel.org/lkml/20211026225234.549ec8e9eb59f1fd1671edbc@kernel.org/
> > >
> > > [2]:
> > > https://lore.kernel.org/lkml/20211105004704.3f4aa456c2c537a56f64e65a@kernel.org/
> >
> > Ah, I see. add means enable the tracing and del means disable.
> >
> > Masami, perhaps we should call it "enable/disable" instead? Because, to
> > me "del" means to remove it (permanently), where as "enable/disable"
> > matches other triggers like the "enable/disable event" that starts and
> > stops another event.
> >
> > >
> > >
> > > > This code is available in the kprobe code that eprobes also uses:
> > > >
> > > > See process_fetch_insn() in kernel/trace/trace_eprobe.c
> > > >
> > > > and the parsing of the string is in kernel/trace/trace_probe.c:
> > > >
> > > >   parse_probe_arg()

I guess I won't be able to finish it until the next merge window, I've
been trying it for a few days
In my spare time recently, with no progress, it looks like it's really
more complicated to implement ;-)


> > >
> > > Thanks for your guidance, but the next merge window is coming soon,
> > > and since I'm not doing full-time kernel development,
> > > I can't guarantee that the development and testing of this change will
> > > be completed before the next window merge.
> > >
> > >  Anyone familiar with this code providing a patch is welcome ;-)
> >
> > If I get a chance, I may see if I can quickly implement it.
>
> Thanks a lot ;-)
>
> >
> > >
> > > >
> > > > I think doing this will make it much more extensive, not to mention it
> > > > will match the syntax of other code in the tracing infrastructure.
> > >
> > > I super agree.
> >
> > Thanks for you patience, and I'm sorry it took so long for me to review
> > it.
>
> Nevermind, I've always been a fan of ftrace.
>
> >
> > -- Steve
>
>
>
> --
> Thanks,
> JeffXie


-- 
Thanks,
JeffXie
