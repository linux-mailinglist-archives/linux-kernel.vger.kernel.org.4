Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1B660DD8F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 10:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbiJZIw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 04:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiJZIwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 04:52:54 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390299A9CF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 01:52:52 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-35befab86a4so140460697b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 01:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c2GJjxQXlRACGVSyWh1rRfrje5tRQvUdNnSASNewsQM=;
        b=C1gF9FC6lAH6D91dNfaXKJ43bJpdVXiKwPfIxVVBTBE8vcGb8oj7XUCkqvddeHiwxv
         GDrb87Yu+aPRZmRwySZm7QQGJy21Ijkj1+YsH7cif/U/xCrqJdy2Tl6gWmAI0c+9aF6k
         WqpNCV30aInH9Rl1RoRrs+ly6UhxN2ZWeW32Dpwl2onPY/RQMBS0rzYVLOHwDQGa3t6H
         bjKXbVdniz/uozAzGXCx1ETM5P6nCtSlhmqUYjGTz6OrOSl1KOT/0kNaYQ0hM5vxkF6Y
         jylJKyZEnLjRl+5zr4J2iS0exicXqLF6y9H8DY8aYHWJn8bm/vq4S3RTk3SUtXLwH4/q
         XWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c2GJjxQXlRACGVSyWh1rRfrje5tRQvUdNnSASNewsQM=;
        b=Im8y3ATDzyyv6+mV9eyTFiGcBgd1xqipTz7L0AiH26L3sHf/chRcBV04EoqzTZtXAy
         /doAus3rF+QWp7O6KqqZa9v8jiuHq1u6WIBG+gly02UYWuSD75HwMAZhDDqGiJDvG/ao
         QcpBjLf/jGPDzbJlUyonGNIPSlXBzC/S17VxI89OFxMw+pehh+JJ2LEShkaJy2s8oYc3
         LPgzuCjqQb2G14fBsEg/Z54rq6j5Ug2KAq8lEVxIrWlWKC9woX5ofbXAIiBITJTZLYv8
         CFBciDw5eXmZ/oMU2gcr6KdVvIBemlgmHUxH1wb6kaK5S/w4+ICoYACg2/tL/7KjeGD+
         C10Q==
X-Gm-Message-State: ACrzQf1xTJc/t+I15Xhg1iWp+kmRKaItuTPFGToOO4ayDY6UgaX5XDQ+
        dDEvKWWLS2+WOoJn3rJRSGnXiuD40+e3NvXZQf+qBA==
X-Google-Smtp-Source: AMsMyM4Wq7M/7T0OiXJsqluBz8s1LQV3vheQ3AHuyHU0ig7icR9INAafHlf+XXvpRuGFfR31LlGJIjzGltFBQmRNQl8=
X-Received: by 2002:a0d:eacc:0:b0:36b:506f:20cc with SMTP id
 t195-20020a0deacc000000b0036b506f20ccmr18647348ywe.313.1666774371390; Wed, 26
 Oct 2022 01:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com> <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com> <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
 <76bb4dc9-ab7c-4cb6-d1bf-26436c88c6e2@arm.com> <CALPaoCiKUQC+LxDwKQ0gE5AQniJi_nbzrXi_HA9ZBRtiXdw_dg@mail.gmail.com>
 <835d769b-3662-7be5-dcdd-804cb1f3999a@arm.com> <CALPaoCgiwtvxZMJ6f-BOTNMPXDbMB8QM42HyCAvYRi4grPiphQ@mail.gmail.com>
 <CALPaoCg2-9ARbK+MEgdvdcjJtSy_2H6YeRkLrT97zgy8Aro3Vg@mail.gmail.com> <715e4123-fdb3-a71e-4069-91d16a56a308@arm.com>
In-Reply-To: <715e4123-fdb3-a71e-4069-91d16a56a308@arm.com>
From:   Peter Newman <peternewman@google.com>
Date:   Wed, 26 Oct 2022 10:52:40 +0200
Message-ID: <CALPaoCjUk31HvhaqWKfkLNLyZJzbDLJOnEqTsqn882CToLCGcw@mail.gmail.com>
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
To:     James Morse <james.morse@arm.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Babu Moger <Babu.Moger@amd.com>,
        Gaurang Upasani <gupasani@google.com>
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

On Tue, Oct 25, 2022 at 5:55 PM James Morse <james.morse@arm.com> wrote:
> On 21/10/2022 13:42, Peter Newman wrote:
> > Even on x86, without an smp_mb(), the stores to t->closid and t->rmid could be
> > reordered with the task_curr(t) and task_cpu(t) reads which follow. The original
> > description of this scenario seemed to assume that accesses below would happen
> > in program order:
> >
> >     WRITE_ONCE(t->closid, to->closid);
> >     WRITE_ONCE(t->rmid, to->mon.rmid);
> >
> >     /*
> >      * If the task is on a CPU, set the CPU in the mask.
> >      * The detection is inaccurate as tasks might move or
> >      * schedule before the smp function call takes place.
> >      * In such a case the function call is pointless, but
> >      * there is no other side effect.
> >      */
> >     if (IS_ENABLED(CONFIG_SMP) && mask && task_curr(t))
> >          cpumask_set_cpu(task_cpu(t), mask);
> >
> > If the task concurrently switches in on another CPU, the code above may not
> > observed that it's running, and the CPU running the task may not have observed
> > the updated rmid and closid yet, so it could continue with the old rmid/closid
> > and not get interrupted.
>
> Makes sense to me - do you want to send a patch to fix it?

Sure, when I think of a solution. For an smp_mb() to be effective above,
we would need to execute another smp_mb() unconditionally before reading
the closid/rmid fields when switching a task in.

The only quick fix I know will work without badly hurting context switch
time would be to go back to pinging all CPUs following a mass
task-movement operation.

I'll see if I can come up with anything better, though.

-Peter
