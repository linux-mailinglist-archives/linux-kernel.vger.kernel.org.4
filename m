Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3E6609B5F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJXHdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJXHdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:33:14 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF980606A9;
        Mon, 24 Oct 2022 00:33:12 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1A1AC5C00CC;
        Mon, 24 Oct 2022 03:33:12 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 24 Oct 2022 03:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666596792; x=1666683192; bh=MLgwl6qVQ1
        d5bswGgDHxIEJUCPcVEho8D9vRKEmhmk8=; b=GHgwqBJ1of6xGRv2pG2BGEt8rE
        CewjyOnqG3XsUJOJdIk9/EbkQKJtPGc71OXxQ4Z85kQPLrrlOL0rB4lnZl8HLVjy
        sL64F831eIsoYiZOo9PjdNOjd/BjBYFBj0PwZ+n2IZJFws6958OvauvdcTUbj6Xb
        YAr94iVFFIJYpN29b+cbjGpjOzma0LABf7WPmoe6PS7PhnXuRNopy5RMTG593Hgg
        gC+TxNaBT5kVJmUi4kU685zxWc3+UhLrKi4h4866RCchEH0Z1ZbwAMPl9AvZHg4T
        IbIzj1S+xFoxWGl1Qx84pJSZC4X7ZgG1vE97hMqp9xPwuDUPFO/cqI1jZSHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666596792; x=1666683192; bh=MLgwl6qVQ1d5bswGgDHxIEJUCPcV
        Eho8D9vRKEmhmk8=; b=aESBKGu4MQ+NP6k7XUxbGLXgLZBIv/NbQmZz+8PUdEom
        ILy9GBFMOeowzyFjolQsKijHfCfiVos8c0zu+vkmwlQWvTcDdD6BFEhIp/2U1Yos
        bIAJH+c5iJIVrIkfMwKXqKyjouaiKQW3I0qJq3FfWw0SpunlPNXb6qvLGyyr9wwE
        d/kpCfcJNwKUY3aqbNLYQS/8BfdYoC3sUo6yZRhq8GH6pCxa0k5z1eXTIgTBLTwW
        SIGHrfH57n/mXNmD2rMjKfviyRsXWh9aCSbhFoovg0BxFrWNcctSNq/zlL2dztRW
        s6jgP5GqVavI7irhlwP5PZ7WRz8bRvFoFhIwhe8xZw==
X-ME-Sender: <xms:tT9WY9-5vUjqBRClSOb2LUQsndEg3k1PTMeFg3PnUWGVF0QNYslDsA>
    <xme:tT9WYxuaUHG11IOgzybvIygtbj-_H-OyYMuqbPf8PNfqqDdVaZYgqX00beELv8GSE
    RP2l_mm6QeihXcqr74>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtfedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeeivdeutdetiefgffdvteehtdegkeehvdelueetheeggeelkedutdfggeeg
    vedtheenucffohhmrghinheprhgvrggtthhoshdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:tT9WY7A3ChyT71AUD7f1miMNi0q7evkD_qnhGmqNWFbkDx2ZJHvTkw>
    <xmx:tT9WYxdChVkxjAnL6_v5P5DCQ1iDQl2cjseazrjj5Lnzv9sJKr5UWQ>
    <xmx:tT9WYyOSlfIubF34VFwb26LVW9aELgrlq47PkToWPe_Yfc-H7eMvUg>
    <xmx:uD9WY6OYxMpe-JEqo9gKZJLODnRbZPxnb_f0gNPc3UdsGAUOSlqM1A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 89108B60086; Mon, 24 Oct 2022 03:33:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <ddb4a078-4d81-4124-8da0-6d7fbd3cd5c7@app.fastmail.com>
In-Reply-To: <CAHk-=wgNZNNd4t004x0ehXm=DA+JmYY=0MgVNDXUtoV4ApyXvQ@mail.gmail.com>
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
Date:   Mon, 24 Oct 2022 09:30:09 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022, at 20:35, Linus Torvalds wrote:
>
> Honestly, I wouldn't mind upgrading the minimum requirements to at
> least M586TSC - leaving some of those early "fake Pentium" clones
> behind too. Because 'rdtsc' is probably an even worse issue than
> CMPXCHG8B.

Kconfig treats X86_CMPXCHG64 as a strict subset of X86_TSC (except
when enabling X86_PAE, which relies on cx8), so requiring both
sounds like a good idea.

From the Kconfig history, I see you initially only enabled
cx8 unconditionally for a couple of CPUs in 982d007a6eec ("x86:
Optimize cmpxchg64() at build-time some more"), and Matthew
Whitehead extended that list in f960cfd12650 ("x86/Kconfig:
Add missing i586-class CPUs to the X86_CMPXCHG64 Kconfig group").

There are still a handful of CPUs that according to [1] 
claim cx8 support that we leave disabled, specifically the
Kconfig symbols for MWINCHIP3D, MCRUSOE, MEFFICEON, MCYRIXIII,
MVIAC3_2 and MVIAC7 should have both tsc and cx8, while the
older MWINCHIPC6 and a small subset of M586 (Cyrix 6x86mx, C-II
and AMD K5) apparently have cx8 but not tsc.

Would you drop support for the 686-class chips that currently
don't use cmpxchg8b, or just remove CONFIG_X86_CMPXCHG64 and
assume they work after all?

       Arnd

[1] https://reactos.org/wiki/Supported_Hardware/CPU
