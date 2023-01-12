Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73856686DF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239903AbjALWYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240200AbjALWXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:23:55 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAAA266E
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:01:36 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-4b718cab0e4so259731167b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w5TcqIxkG85wy5A28OaJ2ye2/9ChOspqn1Q7cVOdJn0=;
        b=A+wS4FaoYpgPCd0w38jm84CFe8f75fRTrIXDBdk9m3jD7iCzlcRn9Rg9OcYCILRwjY
         iB4NDneF/jHazFp/Bxz/neGxg4+pdPgkWbCLsQHnRyFZXHgJAd50tpB2dbtp+qklrOYt
         A/sx3rwgs8x8SNpxqKkW201PO03W/uVUg2V2Y/4yZbEaM6jbhih8pzMWlL6Tb8E2jc6H
         3BbldDBa/6K/M0VTcHxxzFdEGQBmLRDDfn9DnLX45gCkN7sTF+vuNRkD5zV9Iv4oR1OX
         eezNaDIptisgCNpOEMMof8E6OI9peoCjEVOEc9Fa7ILgUdurmLGE8RwzxH4X3jAKAJWH
         CEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5TcqIxkG85wy5A28OaJ2ye2/9ChOspqn1Q7cVOdJn0=;
        b=FT59M7kJ8DvGtN4V5LnxIrjIDsodYN7dYS1mSLgLSOdbTNq829DTOjk7w+6tbPOHBC
         UOrqR2gfOXPtvXGRXCTvwL01PIX+ku1dwhHUBPTimXVvHG3U+y0wvBPRNPj0M028jKJ4
         7LN9AHAN2MGpNLzDljfV08q+7oE5NPB+ZTmRD31Qp5HvqDvqlfUYOP38FWI8qV6eIDRP
         aBCJlRWWLPB8JeIMZOQC0o2o4pJeVbC84hqGxeEmFvQg/oFtqY2mrrivzCEjtL7qg3oF
         XVZR4gDt5LJHq6LEcd5qH0cjU04wsLItcK8713iTIxskBE1NENyFLTGMbpB5pKQy+Ke2
         RpPg==
X-Gm-Message-State: AFqh2kqRNj921SZCjzmlk+XF9PxRLu5W/oJl8Hzrchp8kz9rulk/jWrj
        EH0SzxEvqxs80nCtMYBv9jnf2fXNdtfBqDq44UsgKA==
X-Google-Smtp-Source: AMrXdXtVXRFLY7wCC4gUeokPTi/KXPVvtemxjT2oHq9FYY9pfpQH+oC59h5/OYQ+da0pOshzN9hZOZho5femd/TbPxg=
X-Received: by 2002:a81:1352:0:b0:4dc:4113:f224 with SMTP id
 79-20020a811352000000b004dc4113f224mr268784ywt.455.1673560895606; Thu, 12 Jan
 2023 14:01:35 -0800 (PST)
MIME-Version: 1.0
References: <20230107080702.4907-1-hdanton@sina.com> <20230108222548.698721-1-kamatam@amazon.com>
 <20230108234917.5322-1-hdanton@sina.com> <CAJuCfpEWd6RtevMiUcv7RCH7rjadTMr7UYjJJiGw1ReNHtbJ0g@mail.gmail.com>
 <CAJuCfpEL6FBOVr5UhvS4EjAicvQQijw0AULWnftRemgDE08kbw@mail.gmail.com>
In-Reply-To: <CAJuCfpEL6FBOVr5UhvS4EjAicvQQijw0AULWnftRemgDE08kbw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 12 Jan 2023 14:01:24 -0800
Message-ID: <CAJuCfpEMEsSYcKakFiDK=QV+apW-2baLcUcw7uRyrmKkWVnR8A@mail.gmail.com>
Subject: Re: another use-after-free in ep_remove_wait_queue()
To:     Hillf Danton <hdanton@sina.com>
Cc:     Munehisa Kamata <kamatam@amazon.com>, hannes@cmpxchg.org,
        ebiggers@kernel.org, mengcc@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Mon, Jan 9, 2023 at 7:06 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Mon, Jan 9, 2023 at 5:33 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Sun, Jan 8, 2023 at 3:49 PM Hillf Danton <hdanton@sina.com> wrote:
> > >
> > > On 8 Jan 2023 14:25:48 -0800 PM Munehisa Kamata <kamatam@amazon.com> wrote:
> > > >
> > > > That patch survived the repro in my original post, however, the waker
> > > > (rmdir) was getting stuck until a file descriptor of the epoll instance or
> > > > the pressure file got closed. So, if the following modified repro runs
> > > > with the patch, the waker never returns (unless the sleeper gets killed)
> > > > while holding cgroup_mutex. This doesn't seem to be what you expected to
> > > > see with the patch, does it? Even wake_up_all() does not appear to empty
> > > > the queue, but wake_up_pollfree() does.
> > >
> > > Thanks for your testing. And the debugging completes.
> > >
> > > Mind sending a patch with wake_up_pollfree() folded?
> >
> > I finally had some time to look into this issue. I don't think
> > delaying destruction in psi_trigger_destroy() because there are still
> > users of the trigger as Hillf suggested is a good way to go. Before
> > [1] correct trigger destruction was handled using a
> > psi_trigger.refcount. For some reason I thought it's not needed
> > anymore when we placed one-trigger-per-file restriction in that patch,
> > so I removed it. Obviously that was a wrong move, so I think the
> > cleanest way would be to bring back the refcounting. That way the last
> > user of the trigger (either psi_trigger_poll() or psi_fop_release())
> > will free the trigger.
> > I'll check once more to make sure I did not miss anything and if there
> > are no objections, will post a fix.
>
> Uh, I recalled now why refcounting was not helpful here. I'm making
> the same mistake of thinking that poll_wait() blocks until the call to
> wake_up() which is not the case. Let me think if there is anything
> better than wake_up_pollfree() for this case.

Hi Munehisa,
Sorry for the delay. I was trying to reproduce the issue but even
after adding a delay before ep_remove_wait_queue() it did not happen.
One thing about wake_up_pollfree() solution that does not seem right
to me is this comment at
https://elixir.bootlin.com/linux/latest/source/include/linux/wait.h#L253:

`In the very rare cases where a ->poll() implementation uses a
waitqueue whose lifetime is tied to a task rather than to the 'struct
file' being polled, this function must be called before the waitqueue
is freed...`

In our case we free the waitqueue from cgroup_pressure_release(),
which is the handler for `release` operation on cgroup psi files. The
other place calling psi_trigger_destroy() is psi_fop_release(), which
is also tied to the lifetime to the psi files.  Therefore the lifetime
of the trigger's waitqueue is tied to the lifetime of the files and
IIUC, we should not be required to use wake_up_pollfree().
Could you please post your .config file? I might be missing some
configuration which prevents the issue from happening on my side.
Thanks,
Suren.

>
>
> >
> > [1] https://lore.kernel.org/lkml/20220111232309.1786347-1-surenb@google.com/
> >
> > Thanks,
> > Suren.
> >
> > >
> > > Hillf
