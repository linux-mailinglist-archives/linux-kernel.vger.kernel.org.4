Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B6265589C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 07:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiLXGT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 01:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiLXGTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 01:19:54 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB2313F28
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 22:19:53 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so6693198pjm.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 22:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZjVYIeHaHMd41xXC10DzHW2hRZWYF7bxDRwc+vDs0I=;
        b=g3DrVUAAex7F3ExnETfKs+s6TyLkShJvfDX0EeO1IaFoKq78t49mTmXJj/hI6mgJ1l
         JhYRtUSxDoEAF8JV6j7PKZC3XP+z2q6S8BF8mxF9j6RdSwl2gsXrObmYtZpiCorqw/kP
         4blGxUSxCLW6Eyy+trrHqZ8V3/L9QQS3WJOccH1FcwRXfbjfCZhi8UQuUZTpkuTImgvV
         aIyedRZPW/Dq7QQfbfOMVZUPiLupsewoW7WHT73XvFt76t+3weVQ/4uagLSeN/i/NZVm
         2wvttBZ4hzFrUyDp63LUrf3RXgMdSzrx0P/4g2t9EBBsvk1WBHmWXqPYVyvsYRnRNEeR
         VthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ZjVYIeHaHMd41xXC10DzHW2hRZWYF7bxDRwc+vDs0I=;
        b=QoqEFJfmZBBrAHfoSm/tLVolurQ4bqueLVKJcRsfxltvkkHfM5X882Hwh85Cd97lVc
         ffl9VxoBRF8VQ5ggmuxxt2+OdOTajH4tRzsVf5j0GWwZae7l91GFntMhXJUtSeHr/JKu
         qz4wsCQhkO55EplVsNK/Tw4FWw3XEDMglLMhJYTzKhLx9HIJCEpCFwi7nqeg8Hi7VJJs
         5uKKl9XFVoNcLjzKxIM6wT+60mYYUitzjfrGlieoY0///exHt5SpM4UB9xglM1Nn6aMr
         DA+0OkpAubVj+u1Nrenp4TGIrdXlMsC2nlpzOxBnkozM+uNH6JZUESIs1dLkDdiR/m/s
         AtSg==
X-Gm-Message-State: AFqh2kqOba4mgAyEtlyj1uiEE7lqVBnJDyLDXvqIht9BADBniQNrjz5E
        lXcPe/+hKWT7NnymVihMqlZvZE8MorjAmzYsh9o=
X-Google-Smtp-Source: AMrXdXvmD9eq/sY5pNRC9hDGCSd+LhNGfX+dnzIG/iApKlAPkbb5sMuq1Q6H4XEtOJLLuEwcP0T3LBHzuAx2krgxO/I=
X-Received: by 2002:a17:902:e886:b0:189:80fe:b483 with SMTP id
 w6-20020a170902e88600b0018980feb483mr751359plg.20.1671862793109; Fri, 23 Dec
 2022 22:19:53 -0800 (PST)
MIME-Version: 1.0
References: <20221224050640.64427-1-zhouzhouyi@gmail.com> <Y6aVA9M/wxsi/KKh@dev-arch.thelio-3990X>
In-Reply-To: <Y6aVA9M/wxsi/KKh@dev-arch.thelio-3990X>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Sat, 24 Dec 2022 14:19:42 +0800
Message-ID: <CAABZP2xojYo+gtvFz9MtfPp4xJ=iha-tuRR3x-TRkKUqTYDUjg@mail.gmail.com>
Subject: Re: [PATCH linux-next] lib: Dhrystone: initialize ret value
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     ndesaulniers@google.com, trix@redhat.com,
        akpm@linux-foundation.org, geert+renesas@glider.be,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
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

On Sat, Dec 24, 2022 at 1:58 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Sat, Dec 24, 2022 at 01:06:40PM +0800, Zhouyi Zhou wrote:
> > Initialize ret value whenever 'if' condition is false in dhry_run_set.
> >
> > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > ---
> > Dear Developers:
> > When I invoke make bzImage LLVM=1, clang complains followings:
> > lib/dhry_run.c:61:6: error: variable 'ret' is used uninitialized whenever 'if' condition is false
> >
> > Fix above complain by initialize the ret value.
> >
> > Thanks
> > Zhouyi
>
> Thank you for the patch! I think this has already been fixed:
>
> https://lore.kernel.org/20221219221045.0ABAEC433D2@smtp.kernel.org/
Thank you for reviewing my patch ;-), I see
>
> -next is on a break so it won't be there for a bit:
>
> https://lore.kernel.org/20221220112148.64f183ce@canb.auug.org.au/
Thank you for your guidance, I think I should stop working on -next
for awhile ;-)
>
> Cheers,
> Nathan
Cheers
Zhouyi
>
> > --
> >  lib/dhry_run.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/lib/dhry_run.c b/lib/dhry_run.c
> > index 31a1d442e4a0..be86e5126c29 100644
> > --- a/lib/dhry_run.c
> > +++ b/lib/dhry_run.c
> > @@ -64,6 +64,7 @@ static int dhry_run_set(const char *val, const struct kernel_param *kp)
> >                       return ret;
> >       } else {
> >               dhry_run = true;
> > +             ret = 0;
> >       }
> >
> >       if (dhry_run && system_state == SYSTEM_RUNNING)
> > --
> > 2.34.1
> >
