Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91851643C58
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 05:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiLFEf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 23:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiLFEfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 23:35:55 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C79EDF35
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 20:35:54 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id i82-20020a1c3b55000000b003d1cb516ce0so45335wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 20:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iQwa+R1KLDXopnUAA1dbKp/4fK/ui68aTa9/gBzOhFQ=;
        b=H6ANoPT78eFQdRrIQO0q8MdFumITeNDfzHwmPr8EU2V50+6HkfFPrWkjbrFy3FmOZE
         1zl52/MRK2zs2H3qNAMRSRAArs68cjnXlgD4UF5TH7rnVncDulYPeQl9MIEPoRbQja/E
         ztBqJ49EnDpwzrKjy3+NZ5hurEdn56vhVLeg+keGIQfKmL74i+zcJ0Z74lCto/KDnGEn
         YPj9ubgBp9H+7jlrUwkYdzzjudO4vGk3pue3vas+sd3RQztShGdQBke6IWvCKeRzR6p9
         JhnD+1r0apUTQE8cH1Jpdz+KxosKz7JKv7dAcRw0SqCg/Z3F1+MujCheqmJocCz2huiF
         9tTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQwa+R1KLDXopnUAA1dbKp/4fK/ui68aTa9/gBzOhFQ=;
        b=tyni/O+2Wi9NnZeMvtKt/gbx4jZAILURcImGU5sUqxGwaKCNaQodblwW8PE6H//Iu3
         uofi+9gik4tv0/HLggM75g3NG3XnZAgcsg67iXZhMd0DT2jGI3+HIaUyJOkIAkQUuxnA
         RK+TrBMZFznq6vGZfa+tKNPw46a4YXeXuvgQsMnvLg73uOYOjzyz1d3ERfUE0ce7BUAJ
         XC31UR55OZWxWETKCpBBIFqOlw9BhHHYO7tYOU8z6eBDUkNdbwjgejAl//3SR6bmmgKr
         TZtfSpRJMnUWwsF5TkVyXzwxd7UD044g0xCLiQcFUhhPfrTUO9u3G4q5dWSytn997nEB
         0OVg==
X-Gm-Message-State: ANoB5pkTGORmEHoH978eIxLjXbA1vRH8/eY1JgnvXJmpoJMtbLjlkELu
        NwPs19TLQZPQxVC3vls1DCs88h0bZnlP7TNKCGhX5XST
X-Google-Smtp-Source: AA0mqf6pbFKivzLW9sTETTgbjU2iCnnNpTrUSST5hdLCwPSaKSj4hhaJiZhaZN27E4z6+iSwnunaq46KtN8khnViBdA=
X-Received: by 2002:a05:600c:22c4:b0:3cf:71b7:7a41 with SMTP id
 4-20020a05600c22c400b003cf71b77a41mr64001708wmg.31.1670301352752; Mon, 05 Dec
 2022 20:35:52 -0800 (PST)
MIME-Version: 1.0
References: <CAJNi4rOgYmmtOaXVqYB9sAxDmRhGhS_vVXmZbCbMjvFCQsdjCw@mail.gmail.com>
 <CAJhGHyD+oR8SeYeObJ2DSKfudqBtBOiL14jCsST3L5OG8WjT_g@mail.gmail.com>
In-Reply-To: <CAJhGHyD+oR8SeYeObJ2DSKfudqBtBOiL14jCsST3L5OG8WjT_g@mail.gmail.com>
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Tue, 6 Dec 2022 12:35:41 +0800
Message-ID: <CAJNi4rOs-=xx5qV-hQQYgSLQCz_q3JuFxJEd+wpPaao8Ej26yQ@mail.gmail.com>
Subject: Re: work item still be scheduled to execute after destroy_workqueue?
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

On Tue, Dec 6, 2022 at 12:13 PM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> On Mon, Dec 5, 2022 at 2:18 PM richard clark
> <richard.xnu.clark@gmail.com> wrote:
> >
> > Hi Lai and Tejun,
> >
> > Why can the work still be queued to and executed when queueing it to a
> > wq has been destroyed, for instance, the below code snippet in a
> > kernel module:
> > ---------------------->8---------------------
> >
> > struct workqueue_struct *wq0;
> > #define MAX_ACTIVE_WORKS        (3)
> >
> > static void work0_func(struct work_struct *work);
> > static void work1_func(struct work_struct *work);
> > static void work2_func(struct work_struct *work);
> >
> > static DECLARE_WORK(w0, work0_func);
> > static DECLARE_WORK(w1, work1_func);
> > static DECLARE_WORK(w2, work2_func);
> >
> > /* work->func */
> > static void work0_func(struct work_struct *work)
> > {
> >         pr_info("+%s begins to sleep\n", __func__);
> >         /* sleep for 10s */
> >         schedule_timeout_interruptible(msecs_to_jiffies(10000));
> >         pr_info("+%s after sleep, begin to queue another work\n", __func__);
> >         queue_work_on(1, wq0, &w1);
> > }
> >
> > /* work->func */
> > static void work1_func(struct work_struct *work)
> > {
> >         pr_info("+%s scheduled\n", __func__);
> > }
> >
> > /* work->func */
> > static void work2_func(struct work_struct *work)
> > {
> >         pr_info("+%s scheduled\n", __func__);
> > }
> >
> > static int destroy_init(void)
> > {
> >         wq0 = alloc_workqueue("percpu_wq0", 0, MAX_ACTIVE_WORKS);
> >         if (!wq0) {
> >                 pr_err("alloc_workqueue failed\n");
> >                 return -1;
> >         }
> >         queue_work_on(1, wq0, &w0);
> >         pr_info("Begin to destroy wq0...\n");
> >         destroy_workqueue(wq0);
> >         pr_info("queue w2 to the wq0 after destroyed...\n");
> >         queue_work_on(1, wq0, &w2);
>
> Hello, Richard.
>
> Nice spot.
>
> It is illegal to use a destroyed structure in the view of any API.
>
> A destroyed workqueue might be directly freed or kept for a while,
> which is up to the code of workqueue.c
>
> Before e2dca7adff8f(workqueue: make the workqueues list RCU walkable),
> the workqueue is directly totally freed when destroyed.
> After the said commit, the workqueue is held for an RCU grace before
> totally freed.  And it is a per-cpu workqueue, and the base ref is
> never dropped on per-cpu pwqs, which means it is referencable and
> able to be queued items during the period by accident.
>
> Albeit it is illegal to use a destroyed workqueue, it is definitely bad
> for workqueue code not to complain noisily about the behavior, so I am
> going to set __WQ_DRAINING permanently for the destroyed workqueue, so
> the illegal usage of the destroyed workqueue can result WARN().
>
A WARN is definitely reasonable and has its benefits. Can I try to
submit the patch and you're nice to review as maintainer?

Thanks,
Richard
>
> Thank you for the report.
> Lai
>
> >
> >         return 0;
> > }
> >
> > The output on my x86_64 box is:
> >
> > [344702.734480] +destroy_init+
> > [344702.734499] Begin to destroy wq0...
> > [344702.734516] +work0_func begins to sleep
> > [344712.791607] +work0_func after sleep, begin to queue another work
> > [344712.791620] +work1_func scheduled
> > [344712.791649] queue w2 to the wq0 after destroyed...
> > [344712.791663] +work2_func scheduled  <------------- work 2 still be scheduled?
