Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB7E614E3F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiKAPXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKAPX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:23:27 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233602646
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 08:23:26 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id y72so17679990yby.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 08:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u1N5tYpxw2aXjVjz+sGqWmvGf2bg3xKcmvo0zAlLrkY=;
        b=mEK5byf6XxiAPM/ZDbvChCtZLllAi6Tt35yjm4V49LARv/+yjdp/PNq40pTDHTdFuN
         WsEXuxms8qqkc75t41FFbppkDcxPPo7mCXLCH3LhyPTMONzM2k3E9K4jA5orWrkjzUG8
         U2kaKv51dGtAACa8mm5VUgUCkeQ3xp5DzVB6WFu6CEooTIu73WG2yKA96eSwZPC9GGFY
         l9h/0hkfU0eXy137bEP+fNUq+70ENyKC9BBpctkt4+zvFwHB3D3UjiS+t0Pw4rFEYntu
         Dd76fVN4TjQdNj63PQjr6pEg1PsJjr4McLS/7rejEhe/oNuCZYO1G+kT83etmp0bbDZ1
         DpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1N5tYpxw2aXjVjz+sGqWmvGf2bg3xKcmvo0zAlLrkY=;
        b=zdtqXZpKrmztyON/O0dlxLuGPCk3mFqXz0326qaOBcht8Pz3XQZAx6sRCTZCorDsUK
         yWwReSgLZ8bHySOfKwky8HRqBilWtsO0tLuAkxfGVXEZLRdRrN75lZbfuajNNFuTYj5A
         z+ORLKSRoC9JHoJ9vR1Jmyk2OjdTwheqAIfgOmtpqYSrwsy1R3YGRh2Cu0dl74HUvZHv
         nRVHWPcW5lBk7AzUKNp0DOqfk9eaq/ricpPer47KKmhSWZI79M0QkEpjluGiPM1WOpFg
         1Cfn7menOjYajNppj73+3bVomdcTmiCsaYnTw3WjB5Kl4RBrCnFPKjz+mXeXiptlXOyt
         EPSw==
X-Gm-Message-State: ACrzQf2/irUgco/PbyngD91/b1E5roWqkK812JcRBwy1FF9zJLmAywSq
        lbrg1yUqR485pd0pUgNpAS6m7fVRl1F7Y6FRu6fJaw==
X-Google-Smtp-Source: AMsMyM6o4xtpjXa1l0Xfdsj7ntBlbKyV+WmYfUKqCObsYAJt7wAp/bDQr8TWS7ArbqxZwWfPgqc0tdJknyPJR9sLe+Q=
X-Received: by 2002:a5b:443:0:b0:6bc:e3d1:8990 with SMTP id
 s3-20020a5b0443000000b006bce3d18990mr19779529ybp.191.1667316205266; Tue, 01
 Nov 2022 08:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com> <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com> <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
 <76bb4dc9-ab7c-4cb6-d1bf-26436c88c6e2@arm.com> <CALPaoCiKUQC+LxDwKQ0gE5AQniJi_nbzrXi_HA9ZBRtiXdw_dg@mail.gmail.com>
 <835d769b-3662-7be5-dcdd-804cb1f3999a@arm.com> <CALPaoCgiwtvxZMJ6f-BOTNMPXDbMB8QM42HyCAvYRi4grPiphQ@mail.gmail.com>
 <CALPaoCg2-9ARbK+MEgdvdcjJtSy_2H6YeRkLrT97zgy8Aro3Vg@mail.gmail.com>
 <715e4123-fdb3-a71e-4069-91d16a56a308@arm.com> <CALPaoCjUk31HvhaqWKfkLNLyZJzbDLJOnEqTsqn882CToLCGcw@mail.gmail.com>
 <317b4a96-f28d-aab5-57cc-f0222b7e4901@intel.com> <CALPaoChNAaoJ7uzuxFFDn-f5nvUCXyJ4jkbETHXNdDpXNnh9pQ@mail.gmail.com>
 <08c0e91a-a17a-5dad-0638-800a4db5034f@intel.com>
In-Reply-To: <08c0e91a-a17a-5dad-0638-800a4db5034f@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Tue, 1 Nov 2022 16:23:13 +0100
Message-ID: <CALPaoCj8bVo3Z1r9_Ag=6KvGuR2wzQesArwZKEDvudGPYbbwaA@mail.gmail.com>
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
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

Hi Reinette,

On Thu, Oct 27, 2022 at 7:36 PM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> On 10/27/2022 12:56 AM, Peter Newman wrote:
> > On Wed, Oct 26, 2022 at 11:12 PM Reinette Chatre
> > <reinette.chatre@intel.com> wrote:
> >> The original concern is "the stores to t->closid and t->rmid could be
> >> reordered with the task_curr(t) and task_cpu(t) reads which follow". I can see
> >> that issue. Have you considered using the compiler barrier, barrier(), instead?
> >> From what I understand it will prevent the compiler from moving the memory accesses.
> >> This is what is currently done in __rdtgroup_move_task() and could be done here also?
> >
> > A memory system (including those on x86) is allowed to reorder a store with a
> > later load, in addition to the compiler.
> >
> > Also because the locations in question can be concurrently accessed by another
> > CPU, a compiler barrier would not be sufficient.
>
> This is hard. Regarding the concurrent access from another CPU it seems
> that task_rq_lock() is available to prevent races with schedule(). Using this
> may be able to prevent task_curr(t) changing during this time and thus the local
> reordering may not be a problem. I am not familiar with task_rq_lock() though,
> surely there are many details to consider in this area.

Yes it looks like the task's rq_lock would provide the necessary
ordering. It's not feasible to ensure the IPI arrives before the target
task migrates away, but the task would need to obtain the same lock in
order to migrate off of its current CPU, so that alone would ensure the
next migration would observe the updates.

The difficulty is this lock is private to sched/, so I'd have to propose
some API.

It would make sense for the API to return the result of task_curr(t) and
task_cpu(t) to the caller to avoid giving the impression that this
function would be useful for anything other than helping someone do an
smp_call_function targeting a task's CPU.

I'll just have to push a patch and see what people say.

-Peter
