Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E6169110F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjBITNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjBITNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:13:16 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89998A58
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 11:13:14 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id n1so2324609ybm.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 11:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0WFna3RnbyIN5xpLlcRG0QF1tzU7bO3nMdV/kLugpFI=;
        b=cUJXptVKcev0jWNG0fpaHealHgyPAha/CVW/u3EfdI9Z4La30pZSwbtwXbI0fr9EAd
         Wx6XDYq+Uat9LNVQqGVixbDNIdj0p8k7zciauDxshDBtuUMkIK6cklsAzKyQ49WwFR6N
         SUr/o6KVjqez8JGDYRtr84g7HPedYdwZbpq/cct/A+jYgpCPSX0cFECW2Vtonjyulikj
         I2rYTgLXVwaOwQAFs2cy2Ojn1lIbDM7DjMpP1IekpDtgffe+JKmWxQNWiMMfNRT0K/eT
         OR1+beltKfbp9ZB/65Osl6n6XsBKvgPiUlSZ9cPFcxPAtFiqzzxs3AZKR86opgSZR1Vg
         L87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0WFna3RnbyIN5xpLlcRG0QF1tzU7bO3nMdV/kLugpFI=;
        b=g29AGiN3ZOoFEoHttc863tbZIXcYFDiFQawcBZYOvsI9UY9hhUv3tvZRLuKwdSxuQe
         Lz42+DiztfTtDBf7yJfASAwpdnCAlISMimAbwIgh/YlGVeXLMo+JFWrwVzvYlIVaNr/M
         KPNQ3OEmBj6uPlgPNhZZXbwu6d031lNibgCuWpL0JPcxoRJPXsvAQQLobsUuJXssh75u
         +PdJNzew/DwwO/LJg4L1ewlGI7Lsk+6UKkPWhP1hdZ+KZ9B3dBoJNUncD3dw4kAqpNFK
         GDD91L4XTjaZbVfyioTPCIbMbhnOtDD1MM270NikDd+jJIpmiFPm0WQUBWagy54ZhTHM
         UK4w==
X-Gm-Message-State: AO0yUKWIoMDz5thUQPYl/xQUHu01c3/94v7FNDO/bTWFDPAZdrBPGOsY
        yxdO7KU4o3pjzSoMrle4GQg4uv+BtZc7ByK/3RZE0A==
X-Google-Smtp-Source: AK7set/D/XHV8uJf1p3K2MyhQKXuCrrMpzLjcB2ACdTq1kWeMTM7NQl1s3QPQPiKOSlGvN1jVScuRJJcqmjPXjwTPRY=
X-Received: by 2002:a05:6902:510:b0:8b2:bb9a:a9d6 with SMTP id
 x16-20020a056902051000b008b2bb9aa9d6mr897129ybs.431.1675969993962; Thu, 09
 Feb 2023 11:13:13 -0800 (PST)
MIME-Version: 1.0
References: <CAJuCfpFZ3B4530TgsSHqp5F_gwfrDujwRYewKReJru==MdEHQg@mail.gmail.com>
 <20230202030023.1847084-1-kamatam@amazon.com> <Y9tCl4r/qjqsrVj9@sol.localdomain>
 <CAJuCfpFb0J5ZwO6kncjRG0_4jQLXUy-_dicpH5uGiWP8aKYEJQ@mail.gmail.com>
 <CAJuCfpH4aAAfEJeFzZSGsifhFNCpzZ17MEzXtxhZqoX04jrWbA@mail.gmail.com> <Y+U/k678tB5w5hJP@gmail.com>
In-Reply-To: <Y+U/k678tB5w5hJP@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 9 Feb 2023 11:13:02 -0800
Message-ID: <CAJuCfpECvLiEdp+VfDo=_ZmhakEbtL2JzcwDfFahUk4XBOYNpg@mail.gmail.com>
Subject: Re: [PATCH] sched/psi: fix use-after-free in ep_remove_wait_queue()
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Munehisa Kamata <kamatam@amazon.com>, hannes@cmpxchg.org,
        hdanton@sina.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mengcc@amazon.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 9, 2023 at 10:46 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Thu, Feb 09, 2023 at 09:09:03AM -0800, Suren Baghdasaryan wrote:
> > On Thu, Feb 2, 2023 at 1:11 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > On Wed, Feb 1, 2023 at 8:56 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > > >
> > > > On Wed, Feb 01, 2023 at 07:00:23PM -0800, Munehisa Kamata wrote:
> > > > > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > > > > index 8ac8b81bfee6..6e66c15f6450 100644
> > > > > --- a/kernel/sched/psi.c
> > > > > +++ b/kernel/sched/psi.c
> > > > > @@ -1343,10 +1343,11 @@ void psi_trigger_destroy(struct psi_trigger *t)
> > > > >
> > > > >       group = t->group;
> > > > >       /*
> > > > > -      * Wakeup waiters to stop polling. Can happen if cgroup is deleted
> > > > > -      * from under a polling process.
> > > > > +      * Wakeup waiters to stop polling and clear the queue to prevent it from
> > > > > +      * being accessed later. Can happen if cgroup is deleted from under a
> > > > > +      * polling process otherwise.
> > > > >        */
> > > > > -     wake_up_interruptible(&t->event_wait);
> > > > > +     wake_up_pollfree(&t->event_wait);
> > > > >
> > > > >       mutex_lock(&group->trigger_lock);
> > > >
> > > > wake_up_pollfree() should only be used in extremely rare cases.  Why can't the
> > > > lifetime of the waitqueue be fixed instead?
> > >
> > > waitqueue lifetime in this case is linked to cgroup_file_release(),
> > > which seems appropriate to me here. Unfortunately
> > > cgroup_file_release() is not directly linked to the file's lifetime.
> > > For more details see:
> > > https://lore.kernel.org/all/CAJuCfpFZ3B4530TgsSHqp5F_gwfrDujwRYewKReJru==MdEHQg@mail.gmail.com/#t
> > > .
> > > So, if we want to fix the lifetime of the waitqueue, we would have to
> > > tie cgroup_file_release() to the fput() somehow. IOW, the fix would
> > > have to be done at the cgroups or higher (kernfs?) layer.
> >
> > Hi Eric,
> > Do you still object to using wake_up_pollfree() for this case?
> > Changing higher levels to make cgroup_file_release() be tied to fput()
> > would be ideal but I think that would be a big change for this one
> > case. If you agree I'll Ack this patch.
> > Thanks,
> > Suren.
> >
>
> I haven't read the code closely in this case.  I'm just letting you know that
> wake_up_pollfree() is very much a last-resort option for when the waitqueue
> lifetime can't be fixed.

Got it. Thanks for the warning.
I think it can be fixed but the right fix would require a sizable
higher level refactoring which might be more justifiable if we have
more such cases in the future.

>  So if you want to use wake_up_pollfree(), you need to
> explain why no other fix is possible.  For example maybe the UAPI depends on the
> waitqueue having a nonstandard lifetime.

I think the changelog should explain that the waitqueue lifetime in
cases of non-root cgroups is tied to cgroup_file_release() callback,
which in turn is not tied to file's lifetime. That's the reason for
waitqueue and the file having different lifecycles. Would that suffice
as the justification?
Again, I'm not saying that no other fix is possible, but that the
right fix would be much more complex.
Thanks,
Suren.

>
> - Eric
