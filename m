Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44980638BAF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiKYN5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiKYN45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:56:57 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AD71A3AF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 05:56:57 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id EA15F5C0042;
        Fri, 25 Nov 2022 08:56:53 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 25 Nov 2022 08:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1669384613; x=1669471013; bh=AJ9PsFy5CS
        z721+gAGzXyodp3uslzfHlE5deNBj+7XM=; b=o5q0VB0XWsH9AG+wLN47Ylrsj1
        YwBedZULmI9/U/WIbZLvylclvsnSnZpQJ4UgqXBjOJajSaFpgPGgWqyMmYWziTij
        v7McsddverO3OK4JiPycLCB6zUYVRSOEj4QVkr/afyZGV1WUGw4ycjt9uLwp8xaf
        9JY0OfNXJxgi8PEYojWxWLGCpUN4M/xLhyOYLxQvdHX+sXbTGDhJraSrZ0Z/NWT9
        oSGahZkH5bhm5g438XfKztyIwJnzIjiFE4KYgs1J4Vct1OMOL8iJ2udheAH3NjLI
        UDWXrqYDRHoTBh6LGnucrUIkXFFW6elXdxjLYP+V0LHGbMNqoI81hVyFAAHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669384613; x=1669471013; bh=AJ9PsFy5CSz721+gAGzXyodp3usl
        zfHlE5deNBj+7XM=; b=cT5iBxNtCxKQLK3E704dI0GwO7f816dGYwUtSIpu/a17
        zQJJ6KzmVvXrcR/9KegxJYo/fXLAEA7Eaxp69wp4fnyIj9kCBFQv7Xqpwnxb7kn8
        ic2eDXcd0jeu+RtKpaH9AEJf+NgQZFwg6nut9wCIkTc33wAquNzJv6GzKVSpm2KS
        IWBUOdZ2D3J7xEXN2fnJKnGJlOSNX1sE1csSOo3eLFId2rji1jt1H9hINYCLqOrV
        FcmIeopzyB4pq4pVu9fVRa27UT5yclIhAol8tLr0MJh1p47ZN5YooD1s9sLf67kD
        UDCLGF6BJXRWflt0qhm/2mbZePRXK/zIKREjd/TeJA==
X-ME-Sender: <xms:pMmAY96BTwqIFJjqGfCNm5KGTJofa6ZdFpZe8nU73oqd5Nrqype9JA>
    <xme:pMmAY67bJVdykE36mfOPfdqdzcVL-43PxOudaUeoGY4HN-vI-WQx_0sNhO1BR8fmG
    yRfG23I5ybUozkIO4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieehgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:pMmAY0c1RX5dPxzxlFexGL0mtChlYM0nRWeksdXKdJ5m90N9QtSReQ>
    <xmx:pMmAY2LlrOUlVAZzzabe3rQbuL7VysUvCyaQyWsKuHkkggQ69TcNIg>
    <xmx:pMmAYxJ7T8_tN41JgdR9CTKrVFvrgV2B9S89G2H7YOEhjt5aE2cLOw>
    <xmx:pcmAY4Y9HaDEI4VCbMF-7ocFtKklwf8oZkLghIjakyvLZQf9EHAdYw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BE346B60089; Fri, 25 Nov 2022 08:56:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <98978f82-eb78-4fa7-901e-76c3070362e3@app.fastmail.com>
In-Reply-To: <Y4C66dg+9wwiXdVs@leoy-yangtze.lan>
References: <20201228023941.E0DE2203B5@pchp3.se.axis.com>
 <20201229030933.GC28115@leoy-ThinkPad-X240s> <Y4Cspv98j8TqwCqZ@axis.com>
 <Y4C66dg+9wwiXdVs@leoy-yangtze.lan>
Date:   Fri, 25 Nov 2022 14:56:31 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Leo Yan" <leo.yan@linaro.org>,
        "Vincent Whitchurch" <vincent.whitchurch@axis.com>
Cc:     "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        "Hans-Peter Nilsson" <hp@axis.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "John Garry" <john.garry@huawei.com>,
        "Will Deacon" <will@kernel.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Jiri Olsa" <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "Kim Phillips" <kim.phillips@arm.com>
Subject: Re: [PATCH] perf arm64: Fix mksyscalltbl, don't lose syscalls due to sort -nu
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

On Fri, Nov 25, 2022, at 13:54, Leo Yan wrote:
> On Fri, Nov 25, 2022 at 12:53:10PM +0100, Vincent Whitchurch wrote:

>> It looks like this patch was never applied?  AFAICS it is still needed
>> on current HEAD and it still applies cleanly.
>
> Thanks a lot for bringing up this.
>
> Before there have a discussion [1] for refactoring Arm64 system call
> table but it didn't really happen.

I actually worked on this last week and did a new series to convert
the old asm-generic/unistd.h header into the syscall.tbl format,
and change arm64 to use that.

You can find my work in the 'syscall-tbl' branch of my asm-generic
tree [1]. This has only seen light build testing so far, and is
probably still buggy, but most of the work is there. The missing
bits are the Makefiles for the other seven architectures using
asm-generic/unistd.h, and checking the output to ensure the
contents are still the same.

> I think it's the right thing to merge
> this patch, @Arnaldo, could you pick up this patch?

That sounds fine to me.

    Arnd

[1] https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/
