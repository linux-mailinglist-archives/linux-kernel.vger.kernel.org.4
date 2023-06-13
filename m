Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4CF72DF5F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241586AbjFMK1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241444AbjFMK0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:26:43 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979DB19A8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 03:25:57 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1a6b7060862so583391fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 03:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686651956; x=1689243956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+12HrFJJafbDgwAZUJg7QlUi7xTvHfPMqe857mXUYsM=;
        b=WKNQEJ3n1Uu1HgOn69P9Fu2VaIUfxHMBuZUwBQ5GOJdkVPKFLIirysdjtvJgLnl4Pw
         qPtA9k7XNgsKL7+OO0mg4a6TMyrRS/7JA7BtBaWFU+HN+z4O3FtzJ7ToLZv6Ust19pFw
         jPV1ssZVmiALcOBcJKPuvH7bSjeI4dqbwwr4hgYNyh8ZYt0RnjgBACnN9E3nxBra7mUr
         OyJihR132UmEs0tMVsdsKUZEvKu9y8r3Hn2WB+H+Ar/T+jRPGzQPDsrjjT4UqA2PDL8w
         oVWp1/UpMoGLXDz7LRJsihYBOyTuLiVNpriFnPr/Ha71jwHUPz+Wq345iRPsH8TujJ4l
         UaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686651956; x=1689243956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+12HrFJJafbDgwAZUJg7QlUi7xTvHfPMqe857mXUYsM=;
        b=ag8wfDFAzV2DJ06vIJCMq1RIG+wEpxdaXHjnNtX0uD/vVLPH2Yp2lxmqHcfOBKnMEt
         rVHs866acuSFZFIBzIaRNGi5+Op7TyMoZFsRt7b+TpwjKP24ubWYNV3lxlgFQ+xcdyk0
         iGZ7290YrGp02DIQHdKJMddSVsS1yPaDjZZ2kjOBpnp4H0vO3slyn3pUGIU6EGnhv4ed
         XW1cJKOBM2TaYK1ILFRQg8Bjmgt5/IGh535XfNt9C+4BIGMuz9kqw7QYeRydkzl/iRFR
         Xh4/nDA2kjsprsvaKQB+YtbaGZLQFqzYLHZQIK6R8nJAXqO60rodVmQceS0t99eqwA/m
         qRgg==
X-Gm-Message-State: AC+VfDwDmJZ3cll4WND8Lq2Pj1EK+dlHl7IMHDEs7Zkz3FH9ccuN6yIi
        xGD5fsG8Fj56heFdoOKf2LW8ufMYu3m9Lj4h1h0=
X-Google-Smtp-Source: ACHHUZ72cb1vwndbq40e2EUPWkT1ZamoQeRr8dyGxcirXyCiB/Y7kd9eA/DOBxjTbkZUVZYUAAytSDlcgQx7yVxsFZA=
X-Received: by 2002:a05:6870:1a89:b0:19f:8df8:c50e with SMTP id
 ef9-20020a0568701a8900b0019f8df8c50emr8452401oab.0.1686651956300; Tue, 13 Jun
 2023 03:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230606093135.GA9077@didi-ThinkCentre-M930t-N000>
 <ZIJbvCcaqjzNteWs@slm.duckdns.org> <CAEQmJ=gYe=d53HHC1xW_epmPmmddA4J28SHybwGmQzUZgxZovg@mail.gmail.com>
 <ZIdbyOBdU6zAGxVw@slm.duckdns.org>
In-Reply-To: <ZIdbyOBdU6zAGxVw@slm.duckdns.org>
From:   Yuanhan Zhang <zyhtheonly@gmail.com>
Date:   Tue, 13 Jun 2023 18:25:44 +0800
Message-ID: <CAEQmJ=geNmoOk37w=owwkpvL6-FgDfzaPhCTPNcKiFtL0pv4hg@mail.gmail.com>
Subject: Re: [PATCH] workqueue: introduce queue_work_cpumask to queue work
 onto a given cpumask
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        pmladek@suse.com, zyhtheonly@yeah.net, zwp10758@gmail.com,
        tiozhang@didiglobal.com, fuyuanli@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

Tejun Heo <tj@kernel.org> =E4=BA=8E2023=E5=B9=B46=E6=9C=8813=E6=97=A5=E5=91=
=A8=E4=BA=8C 01:54=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello,
>
> On Fri, Jun 09, 2023 at 02:28:19PM +0800, Yuanhan Zhang wrote:
> > // I resend this to put it into the same thread, sorry for the confusio=
n.
>
> This got resent quite a few times and I don't know which one to reply to.
> Just picking the one which seems like the latest.

Thanks for your patience.

>
> > > Can you elaborate the intended use cases?
> >
> > Thanks for your reply! Please let me use myself as an example to explai=
n this.
> >
> > In my scenario, I have 7 cpus on my machine (actually it is uma, so
> > queue_work_node
> > or using UNBOUND do not works for me), and for some unlucky reasons
> > there are always some irqs running on cpu 0 and cpu 6, since I'm using =
arm64
> > with irqs tuning into FIFO threads, those threaded irqs are always runn=
ing on
> > cpu 0 and 6 too (for affinity). And this would not be fixed easily in
> > short terms :(
> >
> > So in order to help async init for better boot times for my devices,
> > I'd like to prevent
> > works from running on cpu 0 and 6. With queue_work_cpumask(), it would =
be simply
> > done by:
> >
> > ...
> > cpumask_clear_cpu(0, cpumask);  // actually I use sysfs to parse my cpu=
mask
> > cpumask_clear_cpu(6, cpumask);
> > queue_work_cpumask(cpumask, my_wq, &my_work->work);
> > ...
>
> But this would require explicit code customization on every call site whi=
ch
> doesn't seem ideal given that this is to work around something which is t=
ied
> to the specific hardware.

Yes, I agree that using wq_unbound_cpumask would be a great idea and a
substitute
solution for devices booting. But wq_unbound_cpumask could only constrain o=
n
WQ_UNBOUND while I'm trying to make each of my work configurable.
Please let me try to explain this by another example:

If I have several kinds of works, and I'd like to make them run on
different cpusets
(so it is not ideal to put them on WQ_UNBOUND).

This would be done like this:
queue_work_cpumask(cpumask_A  /*B or C or D, just maintain different cpumas=
ks*/,
system_wq, work);

And after that, I don't have to customize my codes anymore since I could
control those cpumasks by procfs or sysfs or ioctl or whatever I like.

So I believe this feature to let per work to choose its cpumask would be qu=
ite
convenient sometimes :)

>
> Wouldn't it be better to add a kernel parameter to further constrain
> wq_unbound_cpumask? Right now, on boot, it's only determined by isolcpus =
but
> it shouldn't be difficult to add a workqueue parameter to further constra=
in
> it.

Yes, thanks again, this would be a great solution for device boot. And
I have followed
your suggestion to submit another patch  '[PATCH] sched/isolation: add
a workqueue
parameter to constrain unbound CPUs'.  This patch simply let
"isolcpus=3D" to have a
"workqueue" option, which makes `housekeeping_cpumask(HK_TYPE_WQ)` to copy
a constrained workqueue cpumask to wq_unbound_cpumask.

Please help review, and thank you again for your time.

Thanks,
Tio Zhang

>
> Thanks.

>
> --
> tejun
