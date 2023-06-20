Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEA573635E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 08:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjFTGCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 02:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjFTGCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 02:02:10 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF24D10D7;
        Mon, 19 Jun 2023 23:02:08 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-54290603887so2071205a12.1;
        Mon, 19 Jun 2023 23:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687240928; x=1689832928;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhFIFU57cByFDAhVSMpMEozfr44ZpyTZ3bNZ73m21kU=;
        b=B0ZoD4BtHlrpGHBlu9LWZIBUHGrvsy1RZ7Jfsf0PiLea0ljFwwqRuNFH1928LeSvJm
         d99S/uMdm+kMTP3hbZcaJIeYMI1rMdPm+Qd6t9zeRmtMIaIZHXkYRPU3U7CJijdOgVXM
         5bysPLPMAMxj8h1pa3E+Otmr1vILxMFHuHO2WGzXGorVLByvLJLKZ0S9jFmFNQNWaofi
         pbvqZOttRdZTsqVREq6Dnsb0apYOsF65mVCbqPrtMiv+0EVNXsq7EvsX2uJOqqgyjjhV
         fDm8UXZl6UeZs80STtQEh6Zgx4pc9Ve3I0qrgjqTuHcmYw83GFP+joZf0ak0ZTSaxFY1
         XDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687240928; x=1689832928;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VhFIFU57cByFDAhVSMpMEozfr44ZpyTZ3bNZ73m21kU=;
        b=lTiujoNtyXiMEEiNl9QAlx40NhU04QoefWuRXCkMN5vZZdFkKEC1WRMnlicg6RdzpW
         y09LaWsLBh2rUebli3bQOin776HZAAM0DVdDH2dc9myEHrsPhqZMzoXLZ9LJM5h5OHtx
         ZHd3nKL8wABkvocTOhJ4u8pIZ0tBKjkSxcu7I/giCMo96M4OgZ1J1zWnnGe54bXw72BZ
         kKazTw8ziRnJKa33jxpqkn5QqoLkyCRvKRI1qbVnH2hGVnJCh2ThdewYnBy3ucRWELsD
         dc6e+J2v5sPf4ohb4mapeWzDV/bsDh+ayHDfSivlsNSmQltkcX84yZrzWMYaoHsUwp6M
         OZ5A==
X-Gm-Message-State: AC+VfDzLHyagSiNPQITY746LmFze5z5aieRho6a9HDmddTngnfNSRSLG
        b1LffBdxXf3+1AiFbOJRLXHHL00Wgck=
X-Google-Smtp-Source: ACHHUZ7hgXl4Vkj+QTtf5rdDM8dJ9ulPZoqT+yMmwHqSjGsIXo58PbQ00mdSYf5l9BRfHzcfcE/yaQ==
X-Received: by 2002:a05:6a20:258e:b0:10f:13bb:5d4f with SMTP id k14-20020a056a20258e00b0010f13bb5d4fmr2690351pzd.2.1687240928245;
        Mon, 19 Jun 2023 23:02:08 -0700 (PDT)
Received: from localhost (193-116-195-252.tpgi.com.au. [193.116.195.252])
        by smtp.gmail.com with ESMTPSA id w15-20020a170902e88f00b0019ee045a2b3sm704657plg.308.2023.06.19.23.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 23:02:07 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 20 Jun 2023 16:02:02 +1000
Message-Id: <CTH8ZNDRMLEZ.2WS18IS2E38T7@wheely>
Subject: Re: +
 lazy-tlb-fix-hotplug-exit-race-with-mmu_lazy_tlb_shootdown.patch added to
 mm-hotfixes-unstable branch
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <mm-commits@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <peterz@infradead.org>,
        <akpm@linux-foundation.org>
X-Mailer: aerc 0.14.0
References: <20230525205253.E2FAEC433EF@smtp.kernel.org>
 <87v8fv86bh.ffs@tglx>
In-Reply-To: <87v8fv86bh.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Jun 11, 2023 at 5:29 AM AEST, Thomas Gleixner wrote:
> On Thu, May 25 2023 at 13:52, Andrew Morton wrote:
>
> Replying here as I wasn't cc'ed on the patch.
>
> > @@ -1030,6 +1031,8 @@ static int take_cpu_down(void *_param)
> >  	enum cpuhp_state target =3D max((int)st->target, CPUHP_AP_OFFLINE);
> >  	int err, cpu =3D smp_processor_id();
> > =20
> > +	idle_task_prepare_exit();
> > +
> >  	/* Ensure this CPU doesn't handle any more interrupts. */
> >  	err =3D __cpu_disable();
> >  	if (err < 0)
> > --- a/kernel/sched/core.c~lazy-tlb-fix-hotplug-exit-race-with-mmu_lazy_=
tlb_shootdown
> > +++ a/kernel/sched/core.c
> > @@ -9373,19 +9373,33 @@ void sched_setnuma(struct task_struct *p
> >   * Ensure that the idle task is using init_mm right before its CPU goe=
s
> >   * offline.
> >   */
> > -void idle_task_exit(void)
> > +void idle_task_prepare_exit(void)
>
> This function name along with the above comment is completely
> misleading. It suggests this is about the idle task itself instead of
> making it clear that this ensures that the kernel threads of the
> outgoing CPU are not longer using a mm which is not init_mm.
>
> The callsite is arbitratily chosen too. Why does this have to be done
> from stomp machine context?

It's the minimalish fix. My patch didn't change what that idle_task_exit
is attempting to do.

> There is zero reason to do so. The last hotplug state before teardown is
> CPUHP_AP_SCHED_WAIT_EMPTY. It invokes sched_cpu_wait_empty() in the
> context of the CPU hotplug thread of the outgoing CPU.
>
> sched_cpu_wait_empty() guarantees that there are no temporarily pinned
> (via migrate disable) user space tasks on that CPU anymore. The
> scheduler guarantees that there won't be user space tasks woken up on or
> migrated to that CPU because the CPU is not in the cpu_active mask.
>
> The stopper thread has absolutely nothing to do with that.
>
> So sched_cpu_wait_empty() is the obvious place to handle that:
>
> int sched_cpu_wait_empty(unsigned int cpu)
> {
> 	balance_hotplug_wait();
> +	sched_force_init_mm();
> 	return 0;
> }
>
> And then have:
>
> /*
>  * Invoked on the outgoing CPU in context of the CPU hotplug thread
>  * after ensuring that there are no user space tasks left on the CPU.
>  *
>  * If there is a lazy mm in use on the hotplug thread, drop it and
>  * switch to init_mm.
>  *
>  * The reference count on init_mm is dropped in finish_cpu().
>  */
> static void sched_force_init_mm(void)
> {
>
> No?

It could be done in many places. Peter touched it last and it's
been in the tree since prehistoric times.

> >  {
> >  	struct mm_struct *mm =3D current->active_mm;
> > =20
> > -	BUG_ON(cpu_online(smp_processor_id()));
> > -	BUG_ON(current !=3D this_rq()->idle);
> > +	WARN_ON(!irqs_disabled());
> > =20
> >  	if (mm !=3D &init_mm) {
> > -		switch_mm(mm, &init_mm, current);
> > +		mmgrab_lazy_tlb(&init_mm);
> > +		current->active_mm =3D &init_mm;
> > +		switch_mm_irqs_off(mm, &init_mm, current);
> >  		finish_arch_post_lock_switch();
> > +		mmdrop_lazy_tlb(mm);
> >  	}
> > +	/* finish_cpu() will mmdrop the init_mm ref after this CPU stops */
> > +}
> > +
> > +/*
> > + * After the CPU is offline, double check that it was previously switc=
hed to
> > + * init_mm. This call can be removed because the condition is caught i=
n
> > + * finish_cpu() as well.
>
> So why adding it in the first place?
>
> The changelog mumbles something about reducing churn, but I fail to see
> that reduction. This adds 10 lines of pointless code and comments for
> zero value.

Not sure what you're talking about. The patch didn't add it. Removing it
requires removing it from all archs, which is the churn.

Thanks,
Nick
