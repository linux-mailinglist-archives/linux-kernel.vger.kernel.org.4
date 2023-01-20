Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058FC6748EB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 02:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjATBh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 20:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjATBhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 20:37:24 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A341894C91
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 17:37:23 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id x4so3250825ybp.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 17:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3qW0ZqDU1SxsOMEJ7uzCROunJKY+/aMuLDY89GBJPCw=;
        b=iWApCseUTsXD5MRO/z3i55jT3h70+EmHxm1sO6k11M3p2ZMmidJ2ZUuttrNWuvLqf5
         ofjfNu7+Qv6suGeTBF+JvcZKdJJIXkj5Z+HM+3BR/6JjFo10/I8egCnCQHyMnewX8IAa
         2Ei7lIfjs7R6lKOzV8KHz9eKMcT9qNVCy2f7Ffxy3oJOd7xIKMwksYDeJLxECv26dxzu
         YFxwy4dGl0urpFnjsiXT8CV2OKnfThR1rUQupKgpQoDAdSZnkY1UINjW/UKYllwJpSP+
         TARTreiAqlIEth8++kNzsDQVkPKaKmbenCjvbx7VyjKyH0X6jSz1W4s7C1n6B4aX/bTF
         /0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3qW0ZqDU1SxsOMEJ7uzCROunJKY+/aMuLDY89GBJPCw=;
        b=QBdqEnlaUG9HY+9rnOQ3oqvIwLKKQITM0Rg3YSsHkr88ljKjy0VlGtNfeV/2tcx+/U
         19J1NR5MekPwix7zHI5IRNoJsBzHJBbi+QlyrXciGgPCOsCNpjzqQcOCPkrZJpho0zch
         2YSlNtU7Pp62LlEdwCQfXozHn/D535XYdqjFwQhl/1VghnLczfn6pcXTOvOGxS4z6uKv
         gaCNVwAcU1w2ef54J3a8UZvIAP7lhEojX7P5Sux6z8eEOlkcCodkxh4JYquQy2BMCtK7
         /0g2jCo3Imz94JXVoK2ANZrXH1mLacCdNndm8yi1kKXMF+7nicQyg8pBqnYn250eLcmc
         sHKQ==
X-Gm-Message-State: AFqh2krHcQIp2zsKBf86iIyBtVbFgz1HWRQEGrwrQo9klkON369JPJ3J
        e/7vQm2Ag029I4mJl3QHPH5e8tAh7t217dTnn1tmeQ==
X-Google-Smtp-Source: AMrXdXsGl8LWu7yzL1XskHMPBgWuNjhHSJmWFfqS1WzZ/ogEQZtr30WyYU6py7eY48xrvVruauIXphXtCXvEHg9GWFY=
X-Received: by 2002:a25:f305:0:b0:7b8:6d00:ef23 with SMTP id
 c5-20020a25f305000000b007b86d00ef23mr1576376ybs.119.1674178642658; Thu, 19
 Jan 2023 17:37:22 -0800 (PST)
MIME-Version: 1.0
References: <CAJuCfpEMEsSYcKakFiDK=QV+apW-2baLcUcw7uRyrmKkWVnR8A@mail.gmail.com>
 <20230113022555.2467724-1-kamatam@amazon.com> <CAJuCfpEH7kC=S8S_SRLW-X483kpaL4xdn5b35Ou08V7b56QdJA@mail.gmail.com>
 <CAJuCfpHV2-pnHd6U3paA1fO2gaYP1RTqAJwp_5QC7C2YR3JG5g@mail.gmail.com>
 <CAJuCfpFZ3B4530TgsSHqp5F_gwfrDujwRYewKReJru==MdEHQg@mail.gmail.com> <20230120013055.3628-1-hdanton@sina.com>
In-Reply-To: <20230120013055.3628-1-hdanton@sina.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 19 Jan 2023 17:37:11 -0800
Message-ID: <CAJuCfpF9tCx4mjYFyX+p7qO9qt+rm=UMSdBt-uzaOqE0ThG04g@mail.gmail.com>
Subject: Re: another use-after-free in ep_remove_wait_queue()
To:     Hillf Danton <hdanton@sina.com>
Cc:     Munehisa Kamata <kamatam@amazon.com>, Tejun Heo <tj@kernel.org>,
        ebiggers@kernel.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mengcc@amazon.com
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

On Thu, Jan 19, 2023 at 5:31 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Thu, 19 Jan 2023 13:01:42 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > Hi Folks,
> > I spent some more time digging into the details and this is what's
> > happening. When we call rmdir to delete the cgroup with the pressure
> > file being epoll'ed, roughly the following call chain happens in the
> > context of the shell process:
> >
> > do_rmdir
> >   cgroup_rmdir
> >     kernfs_drain_open_files
> >       cgroup_file_release
> >         cgroup_pressure_release
> >           psi_trigger_destroy
> >
> > Later on in the context of our reproducer, the last fput() is called
> > causing wait queue removal:
> >
> > fput
> >   ep_eventpoll_release
> >     ep_free
> >       ep_remove_wait_queue
> >         remove_wait_queue
> >
> > By this time psi_trigger_destroy() already destroyed the trigger's
> > waitqueue head and we hit UAF.
> > I think the conceptual problem here (or maybe that's by design?) is
> > that cgroup_file_release() is not really tied to the file's real
> > lifetime (when the last fput() is issued). Otherwise fput() would call
> > eventpoll_release() before f_op->release() and the order would be fine
> > (we would remove the wait queue first in eventpoll_release() and then
> > f_op->release() would cause trigger's destruction).
>
>   eventpoll_release
>     eventpoll_release_file
>       ep_remove
>         ep_unregister_pollwait
>           ep_remove_wait_queue
>

Yes but fput() calls eventpoll_release() *before* f_op->release(), so
waitqueue_head would be removed before trigger destruction.

> Different roads run into the same Roma city.

You butchered the phrase :)

>
> > Considering these findings, I think we can use the wake_up_pollfree()
> > without contradicting the comment at
> > https://elixir.bootlin.com/linux/latest/source/include/linux/wait.h#L253
> > because indeed, cgroup_file_release() and therefore
> > psi_trigger_destroy() are not tied to the file's lifetime.
> >
> > I'm CC'ing Tejun to check if this makes sense to him and
> > cgroup_file_release() is working as expected in this case.
> >
> > Munehisha, if Tejun confirms this is all valid, could you please post
> > a patch replacing wake_up_interruptible() with wake_up_pollfree()? We
> > don't need to worry about wake_up_all() because we have a limitation
> > of one trigger per file descriptor:
> > https://elixir.bootlin.com/linux/latest/source/kernel/sched/psi.c#L1419,
> > so there can be only one waiter.
> > Thanks,
> > Suren.
>
