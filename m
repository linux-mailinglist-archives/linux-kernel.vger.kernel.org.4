Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C55F67FDBC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 10:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjA2JIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 04:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2JIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 04:08:44 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AFC448D
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 01:08:42 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id b18so1892615uan.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 01:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BgdDQUBx0zOFDvBpuu6IhTDsS4BSPGy7EFYvh+zN3iU=;
        b=P4QlemCJuDx16hO6FpsFjhf6l4rrtEeiCp4CdkY01nDsAR9KImzLOporfCPpzeZy+1
         2uXW06OcYuKapxyrrDamD2FA+NOrAxUq5q85SQic+LUxh+dQdG6PheMlIWwM7shXJZET
         GwJ6oO35yvqZ9/6DMFlyZ3FFpn+TauX/zt0s+ZQ9TK8xa2TNXBwh5De5Jm7Jn2ypq3E3
         2bKza3YAqTG+/1MSORfhg65E9mSUlcFnSILLh2prXAI3k2eou1hZiH7gC5EDfvBWrjz3
         775etGaG5aLsM4So+zRk+fBAjEyrPfKj0ya9pXRwshaO2YpK4ukXbdsdcDc463bV4SHV
         E9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BgdDQUBx0zOFDvBpuu6IhTDsS4BSPGy7EFYvh+zN3iU=;
        b=xQRL4KIFrnk+B7vyGLQWpQ9qmjC4nOFuJ14dZ6tIy24m+ha9pjmDwhhDD7POThyScb
         9IC75cmR65etT22MiT9YxHRvcf2pbeHm3ZDXHB77QYC7ZreNgB+kdXwjo2djbwNfcc8b
         0f2wiuRVlXw5Yj59mGsg7QHX0Qgpjh5jboJsK8WY+uyFOlBfS+sBe7/BJjJV+6aW3DM7
         YRrs/FraIZFOgkv5O85itlI1ou6EnjiTj6/w/peEbXF3EkM1OYumTfr7KKTarqMhrNHz
         9Fze786KBOVzdY8kW+lDqqqfEiMQBUt4c8/wMreP2wO6+W4RgB3O81yhL3Fimzb92j2N
         HwkA==
X-Gm-Message-State: AFqh2koAza7pOH6twwQx4eD697PqdQVa/dXiuJFu/3X6/LMuQQR1Ie5I
        lJ8wb7lv23aeqZknmrhwqFwCdbIJpo5prj47rdGqqfGeqUo=
X-Google-Smtp-Source: AMrXdXtYL2mzyqH7Xq+hW8Y78iQxv6wrScPfJpW1Tl9Y0JgXGVeFdMIWHY1l4ZmpXT0ulKPFmKjnq06tbjchoV8/8oY=
X-Received: by 2002:ab0:2990:0:b0:634:2961:6db with SMTP id
 u16-20020ab02990000000b00634296106dbmr4194444uap.22.1674983321232; Sun, 29
 Jan 2023 01:08:41 -0800 (PST)
MIME-Version: 1.0
References: <Y7/QOZYvOFjbP3wu@zwp-5820-Tower> <Y8FgGev2HPX/ksUS@alley>
In-Reply-To: <Y8FgGev2HPX/ksUS@alley>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Sun, 29 Jan 2023 17:08:29 +0800
Message-ID: <CAA70yB4MJoe3a7+yKPTA7XzS7c1FsMS-nyFmsiu3c7pJK-WcOQ@mail.gmail.com>
Subject: Re: [RFC PATCH] hung_task: show sysctl_hung_task_warnings
To:     Petr Mladek <pmladek@suse.com>
Cc:     akpm@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
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

Sorry for the late reply.

On Fri, Jan 13, 2023 at 9:43 PM Petr Mladek <pmladek@suse.com> wrote:
>
> On Thu 2023-01-12 17:17:45, Weiping Zhang wrote:
> > This patch try to add more debug info to detect lost kernel log or no
> > hung task was detected.
> >
> > The user set 10 to the hung_task_timeout_secs, the kernel log:
> >
> > [ 3942.642220] INFO: task mount:19066 blocked for more than 10 seconds.
> > [ 3952.876768] INFO: task kworker/u81:0:7 blocked for more than 10 seconds.
> > [ 3952.877088] INFO: task scsi_eh_0:506 blocked for more than 10 seconds.
> > [ 3952.878212] INFO: task mount:19066 blocked for more than 10 seconds.
> > [ 3963.116805] INFO: task kworker/u81:0:7 blocked for more than 10 seconds.
> > [ 3963.117137] INFO: task scsi_eh_0:506 blocked for more than 10 seconds.
> > [ 3963.118275] INFO: task mount:19066 blocked for more than 10 seconds.
> > [ 3973.356837] INFO: task kworker/u81:0:7 blocked for more than 10 seconds.
> > [ 3973.357148] INFO: task scsi_eh_0:506 blocked for more than 10 seconds.
> > [ 3973.358247] INFO: task mount:19066 blocked for more than 10 seconds.

Expect but no hung task log at this moment.

> > [ 3993.836899] INFO: task kworker/u81:0:7 blocked for more than 10 seconds.
> > [ 3993.837238] INFO: task scsi_eh_0:506 blocked for more than 10 seconds.
> > [ 3993.838356] INFO: task mount:19066 blocked for more than 10 seconds.
> >
> > There is no any log at about 3983, it's hard to know if kernel log was
> > lost or there is no hung task was detected at that moment. So this patch
> > print sysctl_hung_task_warnings to distinguish the above two cases.
> >
> > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> > ---
> >  kernel/hung_task.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> > index c71889f3f3fc..ca917931473d 100644
> > --- a/kernel/hung_task.c
> > +++ b/kernel/hung_task.c
> > @@ -127,8 +127,11 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
> >        * complain:
> >        */
> >       if (sysctl_hung_task_warnings) {
> > -             if (sysctl_hung_task_warnings > 0)
> > +             if (sysctl_hung_task_warnings > 0) {
> >                       sysctl_hung_task_warnings--;
> > +                     pr_err("sysctl_hung_task_warnings: %d\n",
> > +                             sysctl_hung_task_warnings);
> > +             }
>
> It is too much noise. But it might make sense to report it when
> the counter gets down to zero. Something like:
>
>                 if (sysctl_hung_task_warnings)
>                         pr_info("Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings\n");
>
> and move this down after printing all the details for this hung task report.
I'm fine to print this warning when it gets down to 0.

The warning counter is useful to detect kernel log lost or not, if add
a new line to print this count is too noise,
how about append this counter at the end of the following line:
        pr_err("INFO: task %s:%d blocked for more than %ld seconds,
sysctl_hung_task_warnings: %d\n",
                t->comm, t->pid, (jiffies - t->last_switch_time) / HZ,
sysctl_hung_task_warnings);
>
> >               pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
> >                      t->comm, t->pid, (jiffies - t->last_switch_time) / HZ);
> >               pr_err("      %s %s %.*s\n",
>
> Best Regards,
> Petr

Thanks a ton
Weiping
