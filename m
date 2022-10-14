Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B425FF396
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 20:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJNS1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 14:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiJNS1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:27:10 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82401188124
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 11:27:09 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id b2so8482768lfp.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 11:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8FhXfmB7vbdRxcIXi2knFJ92gK+fbhoVYHcE4dssAks=;
        b=caJLb2wohlaaG+6zBqBX8HxmcIRV41QNtIC7swgLYApKVu5s9y7n7MYkuP/TGKu3kP
         vygyLvuj3vTfsy78mvmDpSr2gj4LCxNed4mTwGO+iyYHenj+hkufL89IjTpncAwoDv4F
         75LOlV2UcWgmSBHoLNIosnlhMjnLcLa8/K8ysSHIlEM/12dyJ55KsihF7FZLaoUB0794
         OaF6DAJoH2zmuDPoT/CBsgrSWXrXPTa8UCQEFaXfPldTGHCr2r28Ujxm8u30kF7iyHdh
         1UvchqblVFhn0Ai1ZGa8QJzIfeiNvFtf6A1cONDqqh1lukAXyoBeeCVUCiuweQFVl6Uz
         scpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8FhXfmB7vbdRxcIXi2knFJ92gK+fbhoVYHcE4dssAks=;
        b=A4PzRZHj4mh3o9M9cS/Yf7VX8t36f4eot9miMI6fHHF6ndrvzKtWBe8Sh0ABsX2Yg6
         T168fGgLlTphi0C69paISblFjmv41fyhKSY0Ofug7KI8ssqmVKnZdyyJaiv8TXYITdtW
         V86IvYLpTI78pVlhaP1JiJ56IjHFClYBN2nCKOnIZuaxhlwWXRjOgWCYGJuBlEGaVjBK
         pFsnBXGnsfxFQMmic5hWfrxn+q7qvBd+iJ92E+ympHp6199JBWYe63dWwGSHOtbzkwhX
         Kf89vAqcQ4Y6zFURnIbiwwclWNCzEZx3b9Xt9uPe12YV4pxFNOlUfoHeOLRRo89tfYSw
         2fDQ==
X-Gm-Message-State: ACrzQf3qK75vxPMwXMahszDWndoJ1EIa89QAEsR5g/cA+vunwO4dsMLi
        sw/auBILu4y3vO9gjqv9BqkBQX+HsbbCtiVoKUnDGQ==
X-Google-Smtp-Source: AMsMyM5Gg3NtmB+8BN91lmfj3HGorSoWcvWF5tzTk3DjGjg3Ey4b4HHl3lo6dSnGbdIwjIQBBL3yOrBsV8fGt+8/ScQ=
X-Received: by 2002:a05:6512:114e:b0:4a1:fcf1:c3d1 with SMTP id
 m14-20020a056512114e00b004a1fcf1c3d1mr2114892lfg.248.1665772027587; Fri, 14
 Oct 2022 11:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221010220538.1154054-1-vipinsh@google.com> <DS0PR11MB63735576A8FBF80738FF9B76DC249@DS0PR11MB6373.namprd11.prod.outlook.com>
 <Y0mPqNRSgpArgyS8@google.com> <CALzav=dU2-3avKGT2-AxO8d_uVH9bmYaO=ym8pPFM8esuSWP=A@mail.gmail.com>
In-Reply-To: <CALzav=dU2-3avKGT2-AxO8d_uVH9bmYaO=ym8pPFM8esuSWP=A@mail.gmail.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Fri, 14 Oct 2022 11:26:31 -0700
Message-ID: <CAHVum0d2Jfr=WVxKxvnmwGKzPfV3vN5dbz11=rdcW6qoSoobew@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] dirty_log_perf_test vCPU pinning
To:     Sean Christopherson <seanjc@google.com>,
        "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     David Matlack <dmatlack@google.com>,
        "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
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

On Fri, Oct 14, 2022 at 9:55 AM David Matlack <dmatlack@google.com> wrote:
>
> On Fri, Oct 14, 2022 at 9:34 AM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Fri, Oct 14, 2022, Wang, Wei W wrote:
> > > On Tuesday, October 11, 2022 6:06 AM, Vipin Sharma wrote:
> > > > Pin vCPUs to a host physical CPUs (pCPUs) in dirty_log_perf_test and optionally
> > > > pin the main application thread to a physical cpu if provided. All tests based on
> > > > perf_test_util framework can take advantage of it if needed.
> > > >
> > > > While at it, I changed atoi() to atoi_paranoid(), atoi_positive,
> > > > atoi_non_negative() in other tests, sorted command line options alphabetically
> > > > in dirty_log_perf_test, and added break between -e and -g which was missed in
> > > > original commit when -e was introduced.
> > >
> > > Just curious why not re-using the existing tools (e.g. taskset) to do the pinning?
> >
> > IIUC, you're suggesting the test give tasks meaningful names so that the user can
> > do taskset on the appropriate tasks?  The goal is to ensure vCPUs are pinned before
> > they do any meaningful work.  I don't see how that can be accomplished with taskset
> > without some form of hook in the test to effectively pause the test until the user
> > (or some run script) is ready to continue.
>
> A taskset approach would also be more difficult to incorporate into
> automated runs of dirty_log_perf_test.
>
> >
> > Pinning aside, naming the threads is a great idea!  That would definitely help
> > debug, e.g. if one vCPU gets stuck or is lagging behind.
>
> +1

I also like the idea.

Sean:
Do you want a v6 with the naming patch or you will be fine taking v5,
if there are no changes needed in v5, and I can send a separate patch
for naming?
