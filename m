Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4046759EF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjATQ31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjATQ3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:29:24 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B075FF0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:28:44 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 188so7337071ybi.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UsgwD1M2WCaGKZ28mz2lre3YTN/XGgKTUhmzvANIwrs=;
        b=UWgCAbzsC3BkBkDEqEdU8jLnBSczGtgp4NjRW6kn+6R2j3opMeudfAuaqqqMFkgHMN
         Z9P5B9yuyMwdGPkgRNgnz/TOfWo4Wt5uUNjhZ9I83OZjL9gygtUTM8AtpJylYaZz4T75
         llL+lsUaE67/CZ536Vs50o4WQOxUgeiSOOc2utQEH0qXqFdF+cnrQO8WfbOxo72M94IP
         EpLffVj4j9OiAUW1gjBCCgOnTUNBiCRg+9C5Ji2JKF0CUrBWHcpBBMDgAm5WTkUeKzl5
         8Iq3R9Gt3UyVNdl2fwcUJN8gE7Zx9keZ2uWloUQNxAYituoqb67QgwmozacBZS8hJrOt
         R4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UsgwD1M2WCaGKZ28mz2lre3YTN/XGgKTUhmzvANIwrs=;
        b=2kK643k51JHi5aqDQnL1meAILSR/aqZIDsafq1NZZwevhlcWIkcSHW+LRcF3PZQ4mT
         Zf2u5Ibgy0hDbLm/wjG+ZJFikj1Nn3/w95HMl0VXGZIXoJo4UyRiFa4o1dev4Q5PtCU9
         MBqT1BXN+2nnl/tYTe2b6fJDEltd0Luid/JPZoReofaYufrR8zQLI9b+elvrjhhjdV05
         J8h5vlpyIGPQSo/+0PpyC7yTJ8OlqcKnXYH1+vaHAw1pNi8oBOPlgyM99t70CGaz16k3
         pTq2SmfJ4hwFVayc58CjyLG5oTInYDfNtYMLQptM0jOZEunDIWDJfI0YwsNXPzrv8BI6
         IIqw==
X-Gm-Message-State: AFqh2kr5o1HyQjtqPG5vBpeRyIH+bWyWsWOSHgCWI8BS2ErHOGfRDTQC
        +1FDTZD+XScOUPWjdmQXWyLJbB36lJ77Eed2stqWzA==
X-Google-Smtp-Source: AMrXdXsoVM0i9/+nWuevD8gu1lstoic8Y7elrHX1HRwzV169/ExhmAVo5mtJCbkcuPTncHwqD6EZnANKYQfFrTvFbjI=
X-Received: by 2002:a25:ceca:0:b0:7e4:115c:9cf6 with SMTP id
 x193-20020a25ceca000000b007e4115c9cf6mr1790830ybe.316.1674232116013; Fri, 20
 Jan 2023 08:28:36 -0800 (PST)
MIME-Version: 1.0
References: <CAJuCfpEMEsSYcKakFiDK=QV+apW-2baLcUcw7uRyrmKkWVnR8A@mail.gmail.com>
 <20230113022555.2467724-1-kamatam@amazon.com> <CAJuCfpEH7kC=S8S_SRLW-X483kpaL4xdn5b35Ou08V7b56QdJA@mail.gmail.com>
 <CAJuCfpHV2-pnHd6U3paA1fO2gaYP1RTqAJwp_5QC7C2YR3JG5g@mail.gmail.com>
 <CAJuCfpFZ3B4530TgsSHqp5F_gwfrDujwRYewKReJru==MdEHQg@mail.gmail.com>
 <20230120013055.3628-1-hdanton@sina.com> <CAJuCfpF9tCx4mjYFyX+p7qO9qt+rm=UMSdBt-uzaOqE0ThG04g@mail.gmail.com>
 <20230120090001.3807-1-hdanton@sina.com>
In-Reply-To: <20230120090001.3807-1-hdanton@sina.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 20 Jan 2023 08:28:25 -0800
Message-ID: <CAJuCfpFShuXs_CcfXR6PjYyXemapbuHPG0oZQJb_Y9ZpCUGZXg@mail.gmail.com>
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

On Fri, Jan 20, 2023 at 1:00 AM Hillf Danton <hdanton@sina.com> wrote:
>
> On Thu, 19 Jan 2023 17:37:11 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> > On Thu, Jan 19, 2023 at 5:31 PM Hillf Danton <hdanton@sina.com> wrote:
> > > On Thu, 19 Jan 2023 13:01:42 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > Hi Folks,
> > > > I spent some more time digging into the details and this is what's
> > > > happening. When we call rmdir to delete the cgroup with the pressure
> > > > file being epoll'ed, roughly the following call chain happens in the
> > > > context of the shell process:
> > > >
> > > > do_rmdir
> > > >   cgroup_rmdir
> > > >     kernfs_drain_open_files
> > > >       cgroup_file_release
> > > >         cgroup_pressure_release
> > > >           psi_trigger_destroy
> > > >
> > > > Later on in the context of our reproducer, the last fput() is called
> > > > causing wait queue removal:
> > > >
> > > > fput
> > > >   ep_eventpoll_release
> > > >     ep_free
> > > >       ep_remove_wait_queue
> > > >         remove_wait_queue
> > > >
> > > > By this time psi_trigger_destroy() already destroyed the trigger's
> > > > waitqueue head and we hit UAF.
> > > > I think the conceptual problem here (or maybe that's by design?) is
> > > > that cgroup_file_release() is not really tied to the file's real
> > > > lifetime (when the last fput() is issued). Otherwise fput() would call
> > > > eventpoll_release() before f_op->release() and the order would be fine
> > > > (we would remove the wait queue first in eventpoll_release() and then
> > > > f_op->release() would cause trigger's destruction).
> > >
> > >   eventpoll_release
> > >     eventpoll_release_file
> > >       ep_remove
> > >         ep_unregister_pollwait
> > >           ep_remove_wait_queue
> > >
> >
> > Yes but fput() calls eventpoll_release() *before* f_op->release(), so
> > waitqueue_head would be removed before trigger destruction.
>
> Then check if file is polled before destroying trigger.
>
> +++ b/kernel/sched/psi.c
> @@ -1529,6 +1529,7 @@ static int psi_fop_release(struct inode
>  {
>         struct seq_file *seq = file->private_data;
>
> +       eventpoll_release_file(file);

Be careful here and see the comment in
https://elixir.bootlin.com/linux/latest/source/fs/eventpoll.c#L912.
eventpoll_release_file() assumes that the last fput() was called and
nobody other than ep_free() will race with us. So, this will not be
that simple. Besides if we really need to fix the order here, the fix
should be somewhere at the level of cgroup_file_release() or even
kernfs to work for other similar situations.

>         psi_trigger_destroy(seq->private);
>         return single_release(inode, file);
>  }
>
