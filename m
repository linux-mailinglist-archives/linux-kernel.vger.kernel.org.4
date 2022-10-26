Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A732060E4FB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbiJZPol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbiJZPof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:44:35 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AB1263A;
        Wed, 26 Oct 2022 08:44:29 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 43EDD5C0161;
        Wed, 26 Oct 2022 11:44:28 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 26 Oct 2022 11:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666799068; x=1666885468; bh=faDhQ6w8KK
        WL4bKQ9rSJWdVZALluEpOGbDu+CS6W134=; b=bJCPweOdBpkstkPFWbf/D07BrU
        R3SOatPR23LHk5AKzFnHO8amSc2lVZFTTgCDb5gWKUsUeSXZuPL6gVmB1oHfBsTb
        YuNLAzWUsXQqzxFljvScqSKm0dLYYOM5we1wLpGr32Y+LgJtbNlDMCJZ0xzmgJPM
        Vy5m0bUyNzgy8ZyOQSNi4DJmPipEmP2G9MgYpiPPXVbjuSXmZLv5CKGJg38oJxVF
        7tGm6vTAauefSkyAf0o3bZ24t8TsCPrhkY3qdEeDz+E7BRtjf4CkezVe5UOWictY
        mdrHCTbHGIbgVXEueI6ry/CIi0LBPprUdgZlMtfE/gaCVikI0ycig2D0lt/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666799068; x=1666885468; bh=faDhQ6w8KKWL4bKQ9rSJWdVZALlu
        EpOGbDu+CS6W134=; b=Xf94Od4Nj5XW+sY4mCqe2rsU1vB80GQ9E7u5ebDZaLQy
        kZpcoT3Mdyq4u4yLRbucUH2EPUQzN5nEp6V56i4kYINhFK7zLTHnbiyoDYm6ESpD
        o0r/lE/6vKjZQ/L883gfhklS1RDNXls6FSJI9m4ftNxsmGncZT9Dlqka7JgzkcBx
        alVCJ5Dom2t45VyeIs5v9V29a/ZBPte06OUmRqsWOX2rm0uYtMYjDCT44Hc0EPWh
        34vgRzgGR9ErjinleHkoGxPhB3B8SNGbKRv1O+pbgiz4LGdju4yjDNCQbPj0dR7h
        y6Io1OObx2xMQwsSpRdndxv2BZsZ6N8I4cvacw8OlA==
X-ME-Sender: <xms:2lVZY7HMMOpjGbGw-sdE61klOyFAaZMiMgHnxidos00DrnO5eIhWcA>
    <xme:2lVZY4VJ0AeC4hHZnoQiav7pOHh0OkZwKvbqmHBdgL5ShZIJ-Q2XR47vJqbHuWpwo
    6rWoqZr-YLtJNHaC60>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtddvgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:2lVZY9IjuYkH1KFmPo82bqPL1QOhCuC4dy1UeGZGHLwJF6Nf0l7T5g>
    <xmx:2lVZY5FYfmCsoaloUFKm2ADsFKG39u9W--osI3RpzonAcxudTUfXPQ>
    <xmx:2lVZYxXATTmd7yeMa_pQX3mczbljD9pOAuLmstZ07YLyMZ_JXeLhcw>
    <xmx:3FVZYyXUwOKnlcord76CkyoA60vDsxWSihWUpAA6cP00r_GJNCWPzg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1CC91B60086; Wed, 26 Oct 2022 11:44:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <d24a5273-1c66-4653-9730-4de31ffcf0e8@app.fastmail.com>
In-Reply-To: <alpine.DEB.2.21.2210240054280.50489@angie.orcam.me.uk>
References: <20220815071332.627393-1-yuzhao@google.com>
 <20220815071332.627393-9-yuzhao@google.com>
 <Y0go8wWtdcyH1+Ch@hirez.programming.kicks-ass.net>
 <CAOUHufa9+FTO3Pv-5jC-e3S5goPsUGu-5KcPVHa4bWb0X+d2ug@mail.gmail.com>
 <CAHk-=wj1rc2t5noMtVOgu8XXeTM4KiggEub9PdcexxeQrYPZvA@mail.gmail.com>
 <Y1FXpHdyvXjrjbLw@hirez.programming.kicks-ass.net>
 <CAHk-=whQchubuDpRGFabhmcZuzdt13OOF8wznXb+Dbi3GzBQhQ@mail.gmail.com>
 <Y1GZjPO+szk7X0wP@hirez.programming.kicks-ass.net>
 <CAHk-=wikUaRM5H_y1Bc+QyvGi40dKDL8fnCTyz7ECbwK7aHNPQ@mail.gmail.com>
 <Y1IUMDJFScAMrCS5@casper.infradead.org>
 <CAHk-=wjrpH1+6cQQjTO6p-96ndBMiOnNH098vhS2jLybxD+7gA@mail.gmail.com>
 <alpine.DEB.2.21.2210211911390.50489@angie.orcam.me.uk>
 <CAHk-=wgNZNNd4t004x0ehXm=DA+JmYY=0MgVNDXUtoV4ApyXvQ@mail.gmail.com>
 <alpine.DEB.2.21.2210240054280.50489@angie.orcam.me.uk>
Date:   Wed, 26 Oct 2022 17:43:59 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     "Matthew Wilcox" <willy@infradead.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Yu Zhao" <yuzhao@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Andi Kleen" <ak@linux.intel.com>,
        "Aneesh Kumar" <aneesh.kumar@linux.ibm.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Hillf Danton" <hdanton@sina.com>, "Jens Axboe" <axboe@kernel.dk>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "Jonathan Corbet" <corbet@lwn.net>, "Mel Gorman" <mgorman@suse.de>,
        "Michael Larabel" <Michael@michaellarabel.com>,
        "Michal Hocko" <mhocko@kernel.org>,
        "Mike Rapoport" <rppt@kernel.org>, "Tejun Heo" <tj@kernel.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Will Deacon" <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, "Brian Geffon" <bgeffon@google.com>,
        "Jan Alexander Steffens" <heftig@archlinux.org>,
        "Oleksandr Natalenko" <oleksandr@natalenko.name>,
        "Steven Barrett" <steven@liquorix.net>,
        "Suleiman Souhlal" <suleiman@google.com>,
        "Daniel Byrne" <djbyrne@mtu.edu>,
        "Donald Carr" <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        "Konstantin Kharlamov" <Hi-Angel@yandex.ru>,
        "Shuang Zhai" <szhai2@cs.rochester.edu>,
        "Sofia Trinh" <sofia.trinh@edi.works>,
        "Vaibhav Jain" <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v14 08/14] mm: multi-gen LRU: support page table walks
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022, at 18:28, Maciej W. Rozycki wrote:
> On Sun, 23 Oct 2022, Linus Torvalds wrote:
>
>> In fact, I don't understand how current kernels work on an i486 at
>> all, since it looks like
>> 
>>   exit_to_user_mode_prepare ->
>>     arch_exit_to_user_mode_prepare
>> 
>> ends up having an unconditional 'rdtsc' instruction in it.
>> >
>  The fix here is obviously and trivially:
>
> 	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET if !M486SX && !M486

I think that would be "if X86_TSC", otherwise you still include the
TSC-less 586-class (5x86, 6x86, Elan, Winchip C6, MediaGX, ...)

> So what's the actual burden from keeping this support around?  Would my 
> proposal to emulate CMPXCHG8B (and possibly RDTSC) in #UD handler help?

That sounds worse to me than the current use of runtime alternatives
for picking between cmpxchg8b_emu and the native instruction.

For arm32, we have a combination of two other approaches:

- On the oldest processors that never had SMP support (ARMv5 and
  earlier), it is not possible to enable support for SMP at all.
  Using a Kconfig 'depends on X86_CMPXCHG64' for CONFIG_SMP would
  still allow building 486 kernels, but completely avoid the problem
  of trying to make the same kernel work on later SMP machines.

- For the special case of early ARMv6 hardware that has 32-bit
  atomics but not 64-bit ones, the kernel just falls back to
  CONFIG_GENERIC_ATOMIC64 and no cmpxchg64(). The same should work
  for an i486+SMP kernel. It's obviously slower, but most users
  can trivially avoid this by either running an i686 SMP kernel
  or an i486 UP kernel.

       Arnd
