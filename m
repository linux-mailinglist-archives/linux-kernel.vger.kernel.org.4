Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77B563A0C2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 06:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiK1FZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 00:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiK1FZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 00:25:21 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FCB6255
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 21:25:19 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p16so7649626wmc.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 21:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WEPFViLQ/QFDaeZuqEb3slldMsdEu3a2P9zuhf94k74=;
        b=NmyNmlQdgaGw5JUc0uZoCcXkSENZfpRQQjqIIF40EAL5s2XlUHUliikkaot5Fa0RdN
         rp4UgKSCOPyMBg6PUXH1aktbnZZNOr3np/gtMSj8hui5cNtLMuSOiGuOvBMLBuCGTLyN
         6bIjNqsTk5lgtSQssAyWyBH7zopODBKj6uiD059hNV3/d/8pcNGR862u33IBL9i4HKNL
         fqTgWiaztFehNubu18Nh3d7k1TPbBl5WRsgpb799fvgwvbheUn53SfuOLqmmaA6WiZzJ
         Sia94Xir63AN2qWUX2ZHxQJPh62UTFiMld8TOyvyfqBQswFDHwM0zT8iVrI8kTQuGs/F
         KWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WEPFViLQ/QFDaeZuqEb3slldMsdEu3a2P9zuhf94k74=;
        b=Xhx2xyjktSC85bb2tLiHF+Y4YKEc1CR1APvqpBYhaPY87WCNYmiVPaylmJB+wSkY8/
         a7TOqWWobXw32hWlVPub/X3mvvby71WZfrvpBVIucrlJM4FcHGTyRw+BY6R869Un+o3c
         SxwPdQ/wDufTVJRR1q9oDLbhhieGB+U4LRFxVcIiVQO1KJlnL7oo1eKuhHhyYXwVVKST
         FDsL4SdnCkNyIXZFk83//8lT8yP/u8+TWJqs85FpMpkesB3rmdKLvSCGZxKSMQ4vjsY1
         b8YS0bd0oHPVERlOovzEzfDTIg+/koaUvefGnlhN723aHpVNN50qUolmnpADt4slyf1D
         90cQ==
X-Gm-Message-State: ANoB5plih1pLdjaSWlWCXL4BJmbB+lP1fBDX8vZ/oE66O9HPcoEg4yEN
        alPLRftzuWQeAnwJfaeHzzOIJ0/NWCk61xEHG4U=
X-Google-Smtp-Source: AA0mqf7SH52MqQGeaNG591RUpfmokawuZc69Qpwby8hPB0MVLito/Tm5pMqL5YRq4UWmmp9flqB6UwxY4tLYhisOl40=
X-Received: by 2002:a05:600c:3d08:b0:3cf:e84d:6010 with SMTP id
 bh8-20020a05600c3d0800b003cfe84d6010mr26852628wmb.197.1669613118447; Sun, 27
 Nov 2022 21:25:18 -0800 (PST)
MIME-Version: 1.0
References: <20221123095058.669684-1-richard.xnu.clark@gmail.com>
 <CAJNi4rMbZZbCCKu-Mth3YF-YubHkcgi=VHsd=FyWc77a54pKYA@mail.gmail.com> <CAJhGHyCPbmEY_Azx056ePxO0B-GzUY3KXs3_UT6Z9XUAfVqS0A@mail.gmail.com>
In-Reply-To: <CAJhGHyCPbmEY_Azx056ePxO0B-GzUY3KXs3_UT6Z9XUAfVqS0A@mail.gmail.com>
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Mon, 28 Nov 2022 13:25:06 +0800
Message-ID: <CAJNi4rPO86Gb4n8=QDpAEY_EnirAHrFkqTQiE2do48gSpp0OTA@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Remove the unbound release work from the
 per-cpu type
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org
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

Hi Lai,

On Mon, Nov 28, 2022 at 11:24 AM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> On Fri, Nov 25, 2022 at 11:02 AM richard clark
> <richard.xnu.clark@gmail.com> wrote:
> >
> > Hi Tejun,
> >
> > Would you pls help take a look at this? Or point to someone who is
> > maintaining the workqueue subsystem, I can ping him/her...
> >
> > Richard
>
> Hello, Richard
>
> Thank you for reviewing the code of workqueue and trying to improve it.
>
> But INIT_WORK() has no unwanted effect and it is better to initialize
> the field even if it is unused.
>
IMO, what you said is a perfect 'logical paradox', you think it 'even
if it is unused', then the interesting conclusion is 'it is better to'
use it, would you pls help to justify the underlying logic here?
'unused' but 'better', hmmm...
>
> The patch would not be accepted.
That's definitely fine, forgive me for being a perfectionist to see
the codes... Please note that I've no intention to offend you, trust
me :)

Thanks,
Richard

>
> Thanks.
> Lai
>
> >
> > On Wed, Nov 23, 2022 at 5:51 PM Richard Clark
> > <richard.xnu.clark@gmail.com> wrote:
> > >
> > > Both the per-cpu and unbound workqueue will call init_pwq(...) currently,
> > > the latter will init an unbound release work for the pwq which is unnecessary
> > > for the per-cpu type workqueue.
> > > This commit will remove this work item from the per-cpu workqueue by checking the
> > > wq->flags in init_pwq(...), the work is still reserved for the unbound workqueue.
> > >
> > > Signed-off-by: Richard Clark <richard.xnu.clark@gmail.com>
> > > Cc: Tejun Heo <tj@kernel.org>
> > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > ---
> > >  kernel/workqueue.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > > index 7cd5f5e7e0a1..01bdfb74081e 100644
> > > --- a/kernel/workqueue.c
> > > +++ b/kernel/workqueue.c
> > > @@ -3807,7 +3807,8 @@ static void init_pwq(struct pool_workqueue *pwq, struct workqueue_struct *wq,
> > >         INIT_LIST_HEAD(&pwq->inactive_works);
> > >         INIT_LIST_HEAD(&pwq->pwqs_node);
> > >         INIT_LIST_HEAD(&pwq->mayday_node);
> > > -       INIT_WORK(&pwq->unbound_release_work, pwq_unbound_release_workfn);
> > > +       if (wq->flags & WQ_UNBOUND)
> > > +               INIT_WORK(&pwq->unbound_release_work, pwq_unbound_release_workfn);
> > >  }
> > >
> > >  /* sync @pwq with the current state of its associated wq and link it */
> > > --
> > > 2.37.2
> > >
