Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222BF610253
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 22:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbiJ0UDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 16:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236832AbiJ0UD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 16:03:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D49564E1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:03:28 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i5-20020a1c3b05000000b003cf47dcd316so4964454wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5VjJAp0N2+61Oxh2IMIlFv8RGCM+I8VCYCw/pBRRGl4=;
        b=rDS5vXypkzMWqdwalT/qT+2EkHrOMl5WdG+1xqXQ95n/JeHKDOdgvcQYLdiBx7vVic
         q/9lvXpSW6KPOVLNXmUGPHDImAVmHe+vI8ruMWy0Dhf2/qMN6AFwsiabdxfLHw5EXNM5
         SxAYtXcCmWxpHa+uyH79lp9JestzjrPfR8k+JX/ppBCfUSfgBFHrSY/4tdGbU/OsBCg2
         yELITCt4Q43G3BFRwibHoG8pv3nFxcow2sWte7mD52ZFBUc7/H2lF9P7kqN/irY4aY8S
         gG2h1su2qka2iMZUr7bJ1vGZd5u0Xvl3c2r6EMowplLAmYDrBARvdXrkBZRH7lhdGZ7i
         jVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5VjJAp0N2+61Oxh2IMIlFv8RGCM+I8VCYCw/pBRRGl4=;
        b=UWxlZT6nv+Bv4wRq2w2m44/UfKhf0oHYyzGr2Z4Oss0XaZw7gO+Q/P6F2Xi3s8lToW
         Vvqru5OqdEWbLdOIorXESejq+eQscYNhE+GpGC7wZztX5pyJr5dLvuinNjXL1f9aBzhm
         J62XdIEziCipLgwlbnF4VtykN/XcYm4ETfsxhUxjGv1uwaQ13NjUaUEojwxQHjoAx8SH
         14+1+GLFRSMIyFIzZx0RUARCK0vfNbcHRjhzH12sCHBlpQf8DDCi+UEA/trmBfV+yASY
         03JMeKJhKPACTm3KdtdQnPBf4dIYP+ZZl57HuF8Otib8sDu+/MJm/4vru0VXfgmrIqOk
         64DA==
X-Gm-Message-State: ACrzQf0Jua+v6EYtfx/One+XP9QN6/RymELPk9fjpPxntTJmMcgSIcte
        5nDkaXLnPyPMXLtjciskOzJHpIYAmwxQLZRptMJF3g==
X-Google-Smtp-Source: AMsMyM5pAaws2hi59KHD9u3VHAH4ISacGKoFe/jGcaPZMrcw5Mdnz9NoAiQcbpPYG/5E11g7KmXZkBv4iUy9Oo6f1QE=
X-Received: by 2002:a05:600c:3b11:b0:3c6:c02d:babb with SMTP id
 m17-20020a05600c3b1100b003c6c02dbabbmr7040071wms.69.1666901006407; Thu, 27
 Oct 2022 13:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221021211816.1525201-1-vipinsh@google.com> <20221021211816.1525201-6-vipinsh@google.com>
 <DS0PR11MB637351B52E5F8752E7DA16A4DC309@DS0PR11MB6373.namprd11.prod.outlook.com>
 <Y1lV0l4uDjXdKpkL@google.com> <DS0PR11MB6373E6CA4DDFFD47B64CB719DC339@DS0PR11MB6373.namprd11.prod.outlook.com>
 <Y1qqIgVdZi7qSUD0@google.com>
In-Reply-To: <Y1qqIgVdZi7qSUD0@google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Thu, 27 Oct 2022 13:02:49 -0700
Message-ID: <CAHVum0edLWu0fGMgs7n2v2Fu-XW5mXtAsJ2dtkWD=ZadbRi+hw@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] KVM: selftests: Allowing running
 dirty_log_perf_test on specific CPUs
To:     Sean Christopherson <seanjc@google.com>
Cc:     "Wang, Wei W" <wei.w.wang@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "dmatlack@google.com" <dmatlack@google.com>,
        "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Thu, Oct 27, 2022 at 8:56 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Thu, Oct 27, 2022, Wang, Wei W wrote:
> > On Wednesday, October 26, 2022 11:44 PM, Sean Christopherson wrote:
> > > If we go this route in the future, we'd need to add a worker trampoline as the
> > > pinning needs to happen in the worker task itself to guarantee that the pinning
> > > takes effect before the worker does anything useful.  That should be very
> > > doable.
> >
> > The alternative way is the one I shared before, using this:
> >
> > /* Thread created with attribute ATTR will be limited to run only on
> >    the processors represented in CPUSET.  */
> > extern int pthread_attr_setaffinity_np (pthread_attr_t *__attr,
> >                                  size_t __cpusetsize,
> >                                  const cpu_set_t *__cpuset)
> >
> > Basically, the thread is created on the pCPU as user specified.
> > I think this is better than "creating the thread on an arbitrary pCPU
> > and then pinning it to the user specified pCPU in the thread's start routine".
>
> Ah, yeah, that's better.
>

pthread_create() will internally call sched_setaffinity() syscall
after creation of a thread on a random CPU. So, from the performance
side there is not much difference between the two approaches.

However, we will still need pin_this_task_to_pcpu()/sched_affinity()
to move the main thread to a specific pCPU, therefore, I am thinking
of keeping the current approach unless there is a strong objection to
it.

> > Probably we also don't need "bool pin_vcpus".
>
> Yeah, but for selftests shaving bytes is not exactly top priority, and having a
> dedicated flag avoids the need for magic numbers.  If Vipin had used -1, I'd
> probably be fine with that, but I'm also totally fine using a dedicated flag too.
>

Same, it is not performance critical in this case to add a magical -1.
