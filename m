Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66B96637A9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 04:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbjAJDGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 22:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjAJDGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 22:06:40 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06942389C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 19:06:39 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id g4so10491908ybg.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 19:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5+D9Kp+m1TrCt/2NoyfRnm8EbsBCOqgC+dgNwk8kA84=;
        b=LzUaI5PIs7YxKQWTV4P0BQ84YFg0FZcfOB76n0WrSfWkoJ0EbjEmlQU4KL8mrP2m9h
         I5q/eQQcYrRTGvjJrywzcB95BRm2ET0awFj/nb3by+w5j1NumSCptdAhSl0kZvmNKt6R
         HAL53OibOI8d2tHgdAz4mUI+H8+enCvA0D0PtyNE7YMf/2rZRoWpJjV43wFYQmDoZO8d
         ZEh5YQjSg7hyZcCvjof/FD/bD8U7dezsj0ONqfH+ryIeNtz8JboCWNelVMeUpmzdp3lB
         ZvF9VyHLxcOuZ/mB2G60DeyWcnZCWpGCua66Cz3RRprFQZAQUat0g7AetyjO5lNHuP4j
         V48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5+D9Kp+m1TrCt/2NoyfRnm8EbsBCOqgC+dgNwk8kA84=;
        b=AbDggWDb9/A0bJBRf7HWUKg72kezgd9zoWAREdx+DlwhJBCu/l3dn0+yx1oUFlL38S
         AOUqj7IQN0gg5U1/UU+VA/I0mQz2/0TiHUlQJhgt4+cRyEAL0yzFDE3r+6vKHpcU0iL3
         hRZtXm26ExiMD8MDiS3tYv5WP0X0Q3NsFfS8VgaWq5LYGZvNuZjcmXw4vx7rfvwfWHUi
         1vJtBWGsVkosKs+ssT67ShYFnrNTzosuO1Or8ywwPJGmCaBsCZBpKNvRp5J8kCM0IAqB
         tteOWG8YjgMs5mXfbmkS2eH4sNFsuMNGt2G1mT8w6MaCD00vpPYjd1waRuanEsx87fDV
         E89A==
X-Gm-Message-State: AFqh2kq7Dh0YPxgoeTqnczW7bH7mg9tcP6HsM6H4jJ74Vct+MJpClvsw
        4m8kdbJ9jKrZhQhvhdDD7mJHBovFzMqyh/A2YJpJQEcnm05xj3P2
X-Google-Smtp-Source: AMrXdXuYqbq2JB2sW8S9M66b0AnoflvjFyZghVlTFz8TpKpEFKeWUxrCRCa9PEZgYYSr+a86Eua47uWj778MWFelFIA=
X-Received: by 2002:a25:83d2:0:b0:7ba:78b1:9fcc with SMTP id
 v18-20020a2583d2000000b007ba78b19fccmr781052ybm.593.1673319997997; Mon, 09
 Jan 2023 19:06:37 -0800 (PST)
MIME-Version: 1.0
References: <20230107080702.4907-1-hdanton@sina.com> <20230108222548.698721-1-kamatam@amazon.com>
 <20230108234917.5322-1-hdanton@sina.com> <CAJuCfpEWd6RtevMiUcv7RCH7rjadTMr7UYjJJiGw1ReNHtbJ0g@mail.gmail.com>
In-Reply-To: <CAJuCfpEWd6RtevMiUcv7RCH7rjadTMr7UYjJJiGw1ReNHtbJ0g@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 9 Jan 2023 19:06:26 -0800
Message-ID: <CAJuCfpEL6FBOVr5UhvS4EjAicvQQijw0AULWnftRemgDE08kbw@mail.gmail.com>
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

On Mon, Jan 9, 2023 at 5:33 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Sun, Jan 8, 2023 at 3:49 PM Hillf Danton <hdanton@sina.com> wrote:
> >
> > On 8 Jan 2023 14:25:48 -0800 PM Munehisa Kamata <kamatam@amazon.com> wrote:
> > >
> > > That patch survived the repro in my original post, however, the waker
> > > (rmdir) was getting stuck until a file descriptor of the epoll instance or
> > > the pressure file got closed. So, if the following modified repro runs
> > > with the patch, the waker never returns (unless the sleeper gets killed)
> > > while holding cgroup_mutex. This doesn't seem to be what you expected to
> > > see with the patch, does it? Even wake_up_all() does not appear to empty
> > > the queue, but wake_up_pollfree() does.
> >
> > Thanks for your testing. And the debugging completes.
> >
> > Mind sending a patch with wake_up_pollfree() folded?
>
> I finally had some time to look into this issue. I don't think
> delaying destruction in psi_trigger_destroy() because there are still
> users of the trigger as Hillf suggested is a good way to go. Before
> [1] correct trigger destruction was handled using a
> psi_trigger.refcount. For some reason I thought it's not needed
> anymore when we placed one-trigger-per-file restriction in that patch,
> so I removed it. Obviously that was a wrong move, so I think the
> cleanest way would be to bring back the refcounting. That way the last
> user of the trigger (either psi_trigger_poll() or psi_fop_release())
> will free the trigger.
> I'll check once more to make sure I did not miss anything and if there
> are no objections, will post a fix.

Uh, I recalled now why refcounting was not helpful here. I'm making
the same mistake of thinking that poll_wait() blocks until the call to
wake_up() which is not the case. Let me think if there is anything
better than wake_up_pollfree() for this case.


>
> [1] https://lore.kernel.org/lkml/20220111232309.1786347-1-surenb@google.com/
>
> Thanks,
> Suren.
>
> >
> > Hillf
