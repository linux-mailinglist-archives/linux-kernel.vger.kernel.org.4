Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1806870EBEE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbjEXDjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbjEXDjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:39:43 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09DDC1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:39:42 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ae763f9a94so3292645ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684899582; x=1687491582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xpE20eNVidXtRfeBPc8KiuEmj3SkVNK4dKgKhkKddl4=;
        b=DsAUiqjRC2+yvrN5LBqNi+EJ13Mh8/YBdkcRYdCg8eR/Tn7dtl95Y6mjn1XWC9hpKj
         UmIDZ3GP+KnvSzW1zSN2MjE98R9Xso9SJwKvobuOCIpALvk/3xkGNSf4yAgBev4jRUTx
         7q5wQiWmunnGilC4NrJ9ksB8o3BTmirLMmhJvaU8a9el9OqU2+xzMAVvIdxBoeYAWNW7
         GR2OPzZbT5y1ryII3LeNw7Wf3PK3UQ70GuWG++rQM3a/wQgcYmCMd3gWYMRyinmz+F+s
         P00lar0loGhY33H8ZO2EWj47oesYNt+mx337QC931r8RJxdVNZkN0/8zPUD9j0+ps1uI
         ZlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684899582; x=1687491582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xpE20eNVidXtRfeBPc8KiuEmj3SkVNK4dKgKhkKddl4=;
        b=J2a3AkHoB2hDWAxBMHutSOFD6FfgAiK8MX3Ey+7H7uKLaU4KdYkY5WI2JoyeADbpnM
         1IJXZe1+mxcMaBrV7+fm6099Uc4CfjkPjH2+IaAZT5yzV7DCFfdvA+bzBBKhZWGh1oIp
         Yuw2E1asWUzSlcX8h+32167kP0N+GqAHEdsSVOIMQDwPcDHjVzRRfZOwvJu4dDY7rKH3
         xs51DCKxzGH50VS5q19AOqZqZZfH5McsLT3HaKcQFI2Udcw+6RlySvMC9hjb8KMbw8PY
         jW0g8dpknjv4oziIykwbU33Fwm4M0z3DDFllGKMrgdAaL3vNpZMisrKEPaHl7aq94Ik0
         FrcQ==
X-Gm-Message-State: AC+VfDxQklggMbFd3fvddXfFCHxMfDQGHKBJmfY1usgPdPl50znyQIut
        na+0SzjLax8mGz2TXQ8hYzscuv8Hfviy6gvh0ek=
X-Google-Smtp-Source: ACHHUZ4fg/T6uiM9WccbMcrTVJbxSdq/HfLC3DPVjn/67kEAjXuylbetE4NdUuFWvUpyG/NZwN0HnDWSlQ7jyAYDRcI=
X-Received: by 2002:a17:903:41ca:b0:1af:cbb1:837 with SMTP id
 u10-20020a17090341ca00b001afcbb10837mr4741738ple.65.1684899582076; Tue, 23
 May 2023 20:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230523140942.18679-1-qiang.zhang1211@gmail.com>
 <ZG0WoOqfr6R5wK1p@slm.duckdns.org> <ZG0YeeTZNox8YB25@slm.duckdns.org>
In-Reply-To: <ZG0YeeTZNox8YB25@slm.duckdns.org>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Wed, 24 May 2023 11:39:29 +0800
Message-ID: <CALm+0cX7URDtGJfeE_BBTtxLhw34JQwsLcXUC9RBmnTsG23SOw@mail.gmail.com>
Subject: Re: [PATCH v2] workqueue: Fix warning triggered when nr_running is
 checked in worker_enter_idle()
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, naresh.kamboju@linaro.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Hello,
>
> On Tue, May 23, 2023 at 09:40:16AM -1000, Tejun Heo wrote:
> > On Tue, May 23, 2023 at 10:09:41PM +0800, Zqiang wrote:
> > > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > > index 9c5c1cfa478f..329b84c42062 100644
> > > --- a/kernel/workqueue.c
> > > +++ b/kernel/workqueue.c
> > > @@ -1144,13 +1144,12 @@ void wq_worker_tick(struct task_struct *task)
> > >      * longer than wq_cpu_intensive_thresh_us, it's automatically marked
> > >      * CPU_INTENSIVE to avoid stalling other concurrency-managed work items.
> > >      */
> > > -   if ((worker->flags & WORKER_NOT_RUNNING) ||
> > > +   if ((worker->flags & WORKER_NOT_RUNNING) || worker->sleeping ||
> > >         worker->task->se.sum_exec_runtime - worker->current_at <
> > >         wq_cpu_intensive_thresh_us * NSEC_PER_USEC)
> > >             return;
> >
> > Ah, right, this isn't just interrupted read-modify-write. It has to consider
> > sleeping. This is subtle. We'll definitely need more comments. Will think
> > more about it.
>
> So, there already are enough barriers to make this safe but that's kinda
> brittle because e.g. it'd depend on the barrier in preempt_disable() which
> is there for an unrelated reason. Can you please change ->sleeping accesses
> to use WRITE/READ_ONCE() and explain in wq_worker_tick() that the worker
> doesn't contribute to ->nr_running while ->sleeping regardless of
> NOT_RUNNING and thus the operation shouldn't proceed? We probably need to
> make it prettier but I think that should do for now.

Thanks for the suggestion, I will resend.

>
> Thanks.
>
> --
> tejun
