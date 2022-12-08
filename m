Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6FB6478D3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 23:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiLHWbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 17:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiLHWbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 17:31:04 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F3B80A34
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 14:31:02 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id f11-20020a5b01cb000000b0070374b66537so2995083ybp.14
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 14:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Op1hedj0umyHwinIbX433kdLf9A7H94rRM4kdJUwu1U=;
        b=KUlYt0HAsv5q3OB5O7uVwbMCAAlKwo9OX3CkimRp9O0KMXOR3fQtJa4/JGRAYBfLS3
         UWjxBpwSqVp4SfPLA8raO1YotZ0gGapuq5jyqmTL8lK1lZJr7cjkXzReYiLBGItU4E9D
         0T8A7mc5s8RBwzrErPxqvOCZTGP6/0t5mZtH8wmtkRmS0Jxh1YDhsBacINgAhXbPrJux
         dCUFEaD7bX2ZzyaS4iBZ67E36t9PsqWFKE4Xsjjq+6vOVD8ebEZfn3jYNkW5iV2cJlS5
         oqpJ+9GIqQgV8pK5DE3nMqax+6btOdhpotca7VY8at5yTMQWcK7JjM1efnIU6A111HHY
         sPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Op1hedj0umyHwinIbX433kdLf9A7H94rRM4kdJUwu1U=;
        b=IJHV9aIX+yhrDPNDuz2TDxfiJwtvJojk1yhNtQ+4nYH8Di+TW3C2gwvncDdRq/xrTZ
         2tr/E4Hbt/bI4C4Mu9i24MnIe9fDGbBjxOBbSRnHLSU9sdvusjms4zQQVIDVPP3MUUMp
         rWiBx0BpROWdPbV+Cv2rNISCZlYv+XtGaqY3c8V0ApAtJ1keZnHfuOSfT04se9nLksr1
         3j+Q2Huq85qrIVSt00r2O+j515Rgwqrhm17cI+2k8WDFiq5ilO9XSXP40L95VeIVxIQH
         m+y3YGLxFqgfPWM/g+AVkDw/oTU3zzJMfSyIZzEyTZ+zHM+NTEFScbS6wsy4coPYL1S7
         bczw==
X-Gm-Message-State: ANoB5pnEhO5FEFLP+cGFcEGmL/aui4ICXey8QwlWyrpdTIId3GakSki/
        KceHN9nIbxpPl4Q+6GuKW8Hzh/R1NPxWKifv+A==
X-Google-Smtp-Source: AA0mqf4DskqcvdBLvPNp02IHwvpZkxLHqpLt4SFw39kujiQ7eDJ0kU0Ugfd7mCj/t9hZzEQcWAxDheEPSNaefp8Bug==
X-Received: from peternewman10.zrh.corp.google.com ([2a00:79e0:9d:6:e58a:ed70:d07c:546b])
 (user=peternewman job=sendgmr) by 2002:a81:9e44:0:b0:3b3:174d:7a6b with SMTP
 id n4-20020a819e44000000b003b3174d7a6bmr664288ywj.204.1670538662048; Thu, 08
 Dec 2022 14:31:02 -0800 (PST)
Date:   Thu,  8 Dec 2022 23:30:59 +0100
In-Reply-To: <e28c1f27-f320-511b-e5ea-c278a570d709@intel.com>
Mime-Version: 1.0
References: <e28c1f27-f320-511b-e5ea-c278a570d709@intel.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221208223059.4086209-1-peternewman@google.com>
Subject: Re: [PATCH v4 1/2] x86/resctrl: Update task closid/rmid with task_call_func()
From:   Peter Newman <peternewman@google.com>
To:     reinette.chatre@intel.com
Cc:     bp@alien8.de, derkling@google.com, eranian@google.com,
        fenghua.yu@intel.com, hpa@zytor.com, james.morse@arm.com,
        jannh@google.com, kpsingh@google.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peternewman@google.com, tglx@linutronix.de,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On Wed, Dec 7, 2022 at 7:41 PM Reinette Chatre <reinette.chatre@intel.com> =
wrote:
> On 12/7/2022 2:58 AM, Peter Newman wrote:
> >>> =C2=A02. resctrl_sched_in() loads t->{closid,rmid} before the calling=
 context
> >>> =C2=A0 =C2=A0 switch stores new task_curr() and task_cpu() values.
> >>
> >> This scenario is not clear to me. Could you please provide more detail=
 about it?
> >> I was trying to follow the context_switch() flow and resctrl_sched_in(=
) is
> >> one of the last things done (context_switch()->switch_to()->resctrl_sc=
hed_in()).
> >> From what I can tell rq->curr, as used by task_curr() is set before
> >> even context_switch() is called ... and since the next task is picked =
from
> >> the CPU's runqueue (and set_task_cpu() sets the task's cpu when moved =
to
> >> a runqueue) it seems to me that the value used by task_cpu() would als=
o
> >> be set early (before context_switch() is called). It is thus not clear=
 to
> >> me how the above reordering could occur so an example would help a lot=
.
> >
> > Perhaps in both scenarios I didn't make it clear that reordering in the
> > CPU can cause the incorrect behavior rather than the program order. In
> > this explanation, items 1. and 2. are supposed to be completing the
> > sentence ending with a ':' at the end of paragraph 3, so I thought that
> > would keep focus on the CPU.
>
> You did make it clear that the cause is reordering in the CPU. I am just
> not able to see where the reordering is occurring in your scenario (2).

It will all come down to whether it can get from updating rq->curr to
reading task_struct::{closid,rmid} without encountering a full barrier.

I'll go into the details below.

> Please do. Could you start by highlighting which resctrl_sched_in()
> you are referring to? I am trying to dissect (2) with the given informati=
on:
> Through "the calling context switch" the scenario is written to create
> understanding that it refers to:
> context_switch()->switch_to()->resctrl_sched_in() - so the calling contex=
t
> switch is the first in the above call path ... where does it (context_swi=
tch())
> store the new task_curr() and task_cpu() values and how does that reorder=
 with
> resctrl_sched_in() further down in call path?

Yes, the rq->curr update is actually in __schedule(). I was probably
still thinking it was in prepare_task_switch() (called from
context_switch()) because of older kernels where __rdtgroup_move_task()
is still reading task_struct::on_cpu.

There is an interesting code comment under the rq->curr update site in
__schedule():

	/*
	 * RCU users of rcu_dereference(rq->curr) may not see
	 * changes to task_struct made by pick_next_task().
	 */
	RCU_INIT_POINTER(rq->curr, next);
	/*
	 * The membarrier system call requires each architecture
	 * to have a full memory barrier after updating
	 * rq->curr, before returning to user-space.
	 *
	 * Here are the schemes providing that barrier on the
	 * various architectures:
	 * - mm ? switch_mm() : mmdrop() for x86, s390, sparc, PowerPC.
	 *   switch_mm() rely on membarrier_arch_switch_mm() on PowerPC.
	 * - finish_lock_switch() for weakly-ordered
	 *   architectures where spin_unlock is a full barrier,
	 * - switch_to() for arm64 (weakly-ordered, spin_unlock
	 *   is a RELEASE barrier),
	 */

Based on this, I believe (2) doesn't happen on x86 because switch_mm()
provides the required ordering.

On arm64, it won't happen as long as it calls its resctrl_sched_in()
after the dsb(ish) in __switch_to(), which seems to be the case:

https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/tree/arch/a=
rm64/kernel/process.c?h=3Dmpam/snapshot/v6.0-rc1#n561

Based on this, I'll just sketch out the first scenario below and drop
(2) from the changelog. This also implies that the group update cases
can use a single smp_mb() to provide all the necessary ordering, because
there's a full barrier on context switch for it to pair with, so I don't
need to broadcast IPI anymore.  I don't know whether task_call_func() is
faster than an smp_mb(). I'll take some measurements to see.

The presumed behavior is __rdtgroup_move_task() not seeing t1 running
yet implies that it observes the updated values:

CPU 0                                   CPU 1
-----                                   -----
(t1->{closid,rmid} -> {1,1})            (rq->curr -> t0)

__rdtgroup_move_task():
  t1->{closid,rmid} <- {2,2}
  curr <- t1->cpu->rq->curr
                                        __schedule():
                                          rq->curr <- t1
                                        resctrl_sched_in():
                                          t1->{closid,rmid} -> {2,2}
  if (curr =3D=3D t1) // false
    IPI(t1->cpu)

In (1), CPU 0 is allowed to store {closid,rmid} after reading whether t1
is current:

CPU 0                                   CPU 1
-----                                   -----
__rdtgroup_move_task():
  curr <- t1->cpu->rq->curr
                                        __schedule():
                                          rq->curr <- t1
                                        resctrl_sched_in():
                                          t1->{closid,rmid} -> {1,1}
  t1->{closid,rmid} <- {2,2}
  if (curr =3D=3D t1) // false
   IPI(t1->cpu)

Please let me know if these diagrams clarify things.

-Peter
