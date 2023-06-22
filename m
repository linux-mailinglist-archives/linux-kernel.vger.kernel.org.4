Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7564873A63C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 18:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjFVQkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 12:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjFVQkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:40:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28C41FCB
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:40:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2656E61857
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 16:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D64CC433C8;
        Thu, 22 Jun 2023 16:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687452006;
        bh=jN4aPtLwfFDashrtaZYc4JG/gemsFBwistd11UaUU2g=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=CBD26+tlkCJobJd6pFepFdSvV3kafkq2dt8jF/YC9bIxw7VtpfmVt2Dql7+aUsgHG
         Ewl/7tpVFUyGVRy6/b+BtQo/hWGzof58E72vWk59tC8D5CKcwOB5FmGhNbUbvkATEl
         fEgeR95A88oWJM2ckCT2Jj8VaG9n6lD6Si6hFBWFfygg+vlTRVr+wf4BcNrFrExAkk
         5DUptH/AWnzc9vNMIaUaEcgTvv+88w81ii+KanxgVS2W10b2KKfAKdOqJM4oYmuXxR
         HnN3biYWbx7EOv9MURqTuOpSLQklvL4xNSawiTsmdLlXoGxAMbe7KAcu8JRwd5LPb1
         vppLRc9fDnNKA==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id EB8B527C0054;
        Thu, 22 Jun 2023 12:40:04 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Thu, 22 Jun 2023 12:40:04 -0400
X-ME-Sender: <xms:Y3mUZA4ehEbH4v8G7t3imkZ7ykIVX6vNTbHoCq4RQHXWrGM5RaGMig>
    <xme:Y3mUZB58H9qaH0qm_NjlMTfp66cZ4pU6BTjLewbHvEhEa4tRv7qExpFD68z7efHwl
    idaaHDCAKb3lvxuFhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeguddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvhfeuvddthfdufffhkeekffetgffhledtleegffetheeugeej
    ffduhefgteeihfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:Y3mUZPck849Kfm66nO3QT3FbTl2ekvOfZV7f_OV4sjcm2niuH4gomg>
    <xmx:Y3mUZFITVEi15anq_8dbk4xKayiIHj967sMkyRsIhQxV1vH0QReyiQ>
    <xmx:Y3mUZEKqA33DsFqHVIgL9DJbHTfoBiK52lF-3GB3WPqEtqHpxftgbA>
    <xmx:ZHmUZBBRkTtB-5LGk5yhARqXaEcH3AXRTAtfBFqzPDGu8y-1J192ag>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7294531A0063; Thu, 22 Jun 2023 12:40:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <8a5b8e4a-d238-4f35-b4c7-fb9e34650a14@app.fastmail.com>
In-Reply-To: <4d29bfe0-975a-c97f-3e79-5b77d95d3494@suse.com>
References: <20230621151442.2152425-1-per.bilse@citrix.com>
 <20230621164038.GM2053369@hirez.programming.kicks-ass.net>
 <6523f3e2-8dfc-c2dd-6d14-9e0c3ac93cc8@citrix.com>
 <20230621200409.GC4253@hirez.programming.kicks-ass.net>
 <a8cd2788-a695-964a-3311-dbecb669bb72@suse.com>
 <20230622082607.GD4253@hirez.programming.kicks-ass.net>
 <4d29bfe0-975a-c97f-3e79-5b77d95d3494@suse.com>
Date:   Thu, 22 Jun 2023 09:39:43 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Juergen Gross" <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     "Per Bilse" <Per.Bilse@citrix.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] Updates to Xen hypercall preemption
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023, at 3:33 AM, Juergen Gross wrote:
> On 22.06.23 10:26, Peter Zijlstra wrote:
>> On Thu, Jun 22, 2023 at 07:22:53AM +0200, Juergen Gross wrote:
>> 
>>> The hypercalls we are talking of are synchronous ones. They are running
>>> in the context of the vcpu doing the call (like a syscall from userland is
>>> running in the process context).
>> 
>> (so time actually passes from the guest's pov?)
>
> Correct.
>
>> 
>>> The hypervisor will return to guest context from time to time by modifying
>>> the registers such that the guest will do the hypercall again with different
>>> input values for the hypervisor, resulting in a proper continuation of the
>>> hypercall processing.
>> 
>> Eeeuw.. that's pretty terrible. And changing this isn't in the cards,
>> like at all?
>
> In the long run this should be possible, but not for already existing Xen
> versions.
>
>> 
>> That is, why isn't this whole thing written like:
>> 
>> 	for (;;) {
>> 		ret = hypercall(foo);
>> 		if (ret == -EAGAIN) {
>> 			cond_resched();
>> 			continue;
>> 		}
>> 		break;
>> 	}
>
> The hypervisor doesn't return -EAGAIN for hysterical reasons.
>
> This would be one of the options to change the interface. OTOH there are cases
> where already existing hypercalls need to be modified in the hypervisor to do
> preemption in the middle due to e.g. security reasons (avoiding cpu hogging in
> special cases).
>
> Additionally some of the hypercalls being subject to preemption are allowed in
> unprivileged guests, too. Those are mostly hypercalls allowed for PV guests
> only, but some are usable by all guests.
>
>> 
>>> It is an awful interface and I agree that switching to full preemption in
>>> dom0 seems to be the route which we should try to take.
>> 
>> Well, I would very strongly suggest the route to take is to scrap the
>> whole thing and invest in doing something saner so we don't have to jump
>> through hoops like this.
>> 
>> This is quite possibly the worst possible interface for this Xen could
>> have come up with -- awards material for sure.
>
> Yes.
>
>> 
>>> The downside would be that some workloads might see worse performance
>>> due to backend I/O handling might get preempted.
>> 
>> Is that an actual concern? Mark this a legaxy inteface and anybody who
>> wants to get away from it updates.
>
> It isn't that easy. See above.
>
>> 
>>> Just thinking - can full preemption be enabled per process?
>> 
>> Nope, that's a system wide thing. Preemption is something that's driven
>> by the requirements of the tasks that preempt, not something by the
>> tasks that get preempted.
>
> Depends. If a task in a non-preempt system could switch itself to be
> preemptable, we could do so around hypercalls without compromising the
> general preemption setting. Disabling preemption in a preemptable system
> should continue to be possible for short code paths only, of course.
>
>> Andy's idea of having that thing intercepted as an exception (EXTABLE
>> like) and relocating the IP to a place that does cond_resched() before
>> going back is an option.. gross, but possibly better, dunno.
>> 
>> Quite the mess indeed :/
>
> Yeah.

Having one implementation of interrupt handlers that schedule when they interrupt kernel code (the normal full preempt path) is one thing.  Having two of them (full preempt and super-special-Xen) is IMO quite a bit worse.  Especially since no one tests the latter very well.

Having a horrible Xen-specific extable-like thingy seems honestly rather less bad.  It could even have a little self-contained test that runs at boot, I bet.

But I'll bite on the performance impact issue.  What, exactly, is wrong with full preemption?  Full preemption has two sources of overhead, I think.  One is a bit of bookkeeping.  The other is the overhead inherent in actually rescheduling -- context switch cost, losing things from cache, etc.

The bookkeeping part should have quite low overhead.  The scheduling part sounds like it might just need some scheduler tuning if it's really a problem.

In any case, for backend IO, full preemption sounds like it should be a win, not a loss.  If I'm asking dom0 to do backend IO for me, I don't want it delayed because dom0 was busy doing something else boring.  IO is faster when the latency between requesting it and actually submitting it to hardware is lower.

Can anyone actually demonstrate full preemption being a loss on a real Xen PV workload?

--Andy
