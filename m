Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EEE700920
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbjELNXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241028AbjELNXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:23:39 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE901199E
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:23:36 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f396606ab0so1054761cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683897816; x=1686489816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPuUjEoje+/x3LJYWD5ZpBVMggT1RgV3pBWK7hnLfIM=;
        b=e8vn/ZqlpU5mZ4QkijvRWWTpKCtMaMyG1FPD3SUt2t2Dti6Zp009XklhScn2rs2yLO
         TfI7OMWT2SFe7gMWWm+qZXKG7Bx5wnwrEESUtXer1VssU0bMmjSQhyPF97sqEPzaF/ok
         Awx38FCWLm9/TnPUGjTTc56VZkXXIbuQyZM1dSaDUO5uOn6lyT/qUSXY+3nJjudGECgr
         bPDtWCtrFvLaknbIPDDus7YBJzxyOJnVEFAdTaYgUcdRRScV4HbfL18i1Tv34s6Kg5yh
         c9TzEAkmBpNuBSjmsjcmE8Ma6HuyWeJgBF8DZEws+jwSsJMxzVugrOyQmo+679e6IlEu
         20xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683897816; x=1686489816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPuUjEoje+/x3LJYWD5ZpBVMggT1RgV3pBWK7hnLfIM=;
        b=LXKzOcM9tSjJ6iKY0XQj5nN38VhtJ7VxOWgxAAm4SlYrj1DCTt1T4L2jM9r4a76EXp
         lNcLOlLWDv/i3oI7UeFj6235QpuzeNeyLT880+l4988R3/BfdtLYxQBcQwQXnAnW+vpc
         r+GgiiNd6lIio4PX3GRmYWqAGUB7nHDOlJasPC3x29yaUZmcO4L04B+kXlORxKFhf5Gu
         bGM4ydb5Skq8/91LkQRYygiA53EpyjiS3dplnXWkiP7YqNLSsOp5WC4JU2a0lzTZsbIO
         wMdXpAwO+7rYxSiu7w1/PX8UDy/qTMloAwchiTG0hG0ktjwKl1zCYjZyGnZBDj9LtKCy
         u93g==
X-Gm-Message-State: AC+VfDx02A9ZyrfKmJrqUThThhbXqr0nGNoS7mqT6/eKmDZIjAq9oFdN
        uH0WpxKGYetrlLL0imc1hwELJ0sZVBym4gp3J7UcLg==
X-Google-Smtp-Source: ACHHUZ4LFBoo6M5Sy4lh6dNFZ3J5WlpWwe5Z9jZ3gFM8kpxjGDsYjCQ0D8R3gvkHcwowoSS6PBIYP7/Tbb7CgRUiW/o=
X-Received: by 2002:a05:622a:1812:b0:3ef:1c85:5b5e with SMTP id
 t18-20020a05622a181200b003ef1c855b5emr248121qtc.19.1683897815844; Fri, 12 May
 2023 06:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230421141723.2405942-1-peternewman@google.com>
 <20230421141723.2405942-3-peternewman@google.com> <242db225-8ddc-968e-a754-6aaefd1b7da9@intel.com>
In-Reply-To: <242db225-8ddc-968e-a754-6aaefd1b7da9@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Fri, 12 May 2023 15:23:25 +0200
Message-ID: <CALPaoCg1Z4ucYibv4STe+DjB32o-ckuWm5PL4CmWwCgNWchoUg@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] x86/resctrl: Hold a spinlock in __rmid_read() on AMD
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stephane Eranian <eranian@google.com>,
        James Morse <james.morse@arm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On Thu, May 11, 2023 at 11:36=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> On 4/21/2023 7:17 AM, Peter Newman wrote:
> > From: Stephane Eranian <eranian@google.com>
> >
> > In AMD PQoS Versions 1.0 and 2.0, IA32_QM_EVTSEL MSR is shared by all
> > processors in a QOS domain.  So there's a chance it can read a differen=
t
> > event when two processors are reading the counter concurrently.  Add a
> > spinlock to prevent this race.
>
> This is unclear to me. As I understand it this changelog is written as
> though there is a race that is being fixed. I believe that rdtgroup_mutex
> currently protects against such races. I thus at first thought that
> this is a prep patch for the introduction of the new soft RMID feature,
> but instead this new spinlock is used independent of the soft RMID featur=
e.
>
> I think the spinlock is unnecessary when the soft RMID feature is disable=
d.

My understanding was that the race would happen a lot more when
simultaneously IPI'ing all CPUs in a domain, but I had apparently
overlooked that all of the counter reads were already serialized.


> > + * @lock:    serializes counter reads when QM_EVTSEL MSR is shared per=
-domain
> >   *
> >   * Members of this structure are accessed via helpers that provide abs=
traction.
> >   */
> > @@ -333,6 +334,7 @@ struct rdt_hw_domain {
> >       u32                             *ctrl_val;
> >       struct arch_mbm_state           *arch_mbm_total;
> >       struct arch_mbm_state           *arch_mbm_local;
> > +     raw_spinlock_t                  evtsel_lock;
> >  };
>
> Please note the difference between the member name in the struct ("evtsel=
_lock")
> and its description ("lock").

Will fix, thanks.


> > -static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *v=
al)
> > +static int __rmid_read(struct rdt_hw_domain *hw_dom, u32 rmid,
> > +                    enum resctrl_event_id eventid, u64 *val)
> >  {
> > +     unsigned long flags;
> >       u64 msr_val;
> >
> > +     if (static_branch_likely(&rmid_read_locked))
>
> Why static_branch_likely() as opposed to static_branch_unlikely()?

I read the documentation for static branches and I agree that unlikely
would make more sense so that the non-locked case is less impacted.

This instance apparently confused my understanding of static branches
and I will need to re-visit all uses of them in this patch series.

>
> > +             raw_spin_lock_irqsave(&hw_dom->evtsel_lock, flags);
> > +
> >       /*
> >        * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is config=
ured
> >        * with a valid event code for supported resource type and the bi=
ts
> > @@ -161,6 +166,9 @@ static int __rmid_read(u32 rmid, enum resctrl_event=
_id eventid, u64 *val)
> >       wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
> >       rdmsrl(MSR_IA32_QM_CTR, msr_val);
> >
> > +     if (static_branch_likely(&rmid_read_locked))
> > +             raw_spin_unlock_irqrestore(&hw_dom->evtsel_lock, flags);
> > +
>
> If the first "if (static_branch_likely(&rmid_read_locked))" was taken the=
n the second
> if branch _has_ to be taken. It should not be optional to release a lock =
if it was taken. I
> think it would be more robust if a single test of the static key decides =
whether the
> spinlock should be used.

Is the concern that the branch value could change concurrently and
result in a deadlock?

I'm curious as to whether this case is performance critical enough to
justify using a static branch. It's clear that we should be using them
in the context switch path, but I'm confused about other places
they're used when there are also memory flags.

-Peter
