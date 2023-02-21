Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B1869E5D3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbjBURWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbjBURWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:22:09 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155042E0C8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:22:00 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 2D54B2611CF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 17:21:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a305.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 80D02260DFC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 17:21:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677000118; a=rsa-sha256;
        cv=none;
        b=yNXt/YCL7zBNWZ5jMBqAphRrV0waETqAjTC/MuAcCZ/zgxLsovurdPDcC7Z7vcwnOESFEd
        Jm4uUIs9qDEG7qvBWxZZ6tJzUsk696oGo1n9lzTVA9vBKPBIJT/XYTcCTiAgGd1ZSh/Mkf
        sv8KCR4jIIIMoI7r5kwNe6ieXhXQ0S197xGMSutHLX2LaHIZjE6M9/sNLVdWNdSDA3uPfh
        ACT7ikn2FE3d0+cuGRiEL9DxwdcHgk/Y25aUCEFdohQttMD2XcL1UHRHNTF/SRBh7SDba3
        dz3cH3So6Xx6sVMpAu6xPRUNd5TQ+Ky2e65hEdJKd9/Fb4RrJrIwTP5jY41v3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677000118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=Ik/BxQVPULpYrwYc2hSx19d57QjiK1F7eWzQZ1uWOVk=;
        b=DGPelUezPNn6afV8fw0qbQ8ZJClhLhM31oT0bpFY3ptDrtGQCC4/bZkSbDL0Qeia9C7c+0
        lbKNaKr8R5DNuVWNl73KkX1Bdy/1C5mWKmNUEagNytVsHMeNLYi/w+WAVpug8frohqwwzX
        +aRajoGwwYtGGCbtsJn84HZ6Q2dfEmAOQxU0sxrFFcKvxb2GI4TwONPgqv05+gAU7HQ3uK
        isUb93rB+ZSAQnmN3CyI3sd4lYLfYvJ0M7Wym/FwH6kT1JIxC39Cv7CvFrZsTzG07QK5R4
        7sFsiwVIqBDYqQke2UNDRMaTUsmgOPFmjTQUs3gYVSCqQGQAKd5STxJWcDjtnw==
ARC-Authentication-Results: i=1;
        rspamd-5db48964c-xr92q;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Eight-Turn: 12b6b6a96b50888a_1677000118771_2410586654
X-MC-Loop-Signature: 1677000118771:83197052
X-MC-Ingress-Time: 1677000118771
Received: from pdx1-sub0-mail-a305.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.47 (trex/6.7.1);
        Tue, 21 Feb 2023 17:21:58 +0000
Received: from kmjvbox (c-76-102-200-71.hsd1.ca.comcast.net [76.102.200.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a305.dreamhost.com (Postfix) with ESMTPSA id 4PLmLD43qvzwV
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1677000116;
        bh=Ik/BxQVPULpYrwYc2hSx19d57QjiK1F7eWzQZ1uWOVk=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=gqF9568282uKRsEIEgA1nRl+jKjN+IosOQmmHCR/gPRbwLyXl2ITSNpOf7umXPYdF
         u73Oxg7tU1yOpCAY7rg/bT5YAvg/eOIlyqKV4CizKqFDA7SQjMXbJH3nfWz5Elz71n
         idH4kJJcLrOUw5dgnxgx03DDEjqg2oXoNYnz0oEY=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0049
        by kmjvbox (DragonFly Mail Agent v0.12);
        Tue, 21 Feb 2023 09:21:53 -0800
Date:   Tue, 21 Feb 2023 09:21:53 -0800
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Krister Johansen <kjlx@templeofstupid.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Anthony Liguori <aliguori@amazon.com>,
        David Reaver <me@davidreaver.com>,
        Brendan Gregg <brendan@intel.com>
Subject: Re: [PATCH linux-next 2/2] x86/xen/time: cleanup
 xen_tsc_safe_clocksource
Message-ID: <20230221172153.GA1958@templeofstupid.com>
References: <cover.1676610413.git.kjlx@templeofstupid.com>
 <f6bab47230b00cecb67f2c5d94716c8236609967.1676610413.git.kjlx@templeofstupid.com>
 <87h6vgov2p.ffs@tglx>
 <20230221041440.GA1934@templeofstupid.com>
 <20230221055117.GA1934@templeofstupid.com>
 <871qmjpegh.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qmjpegh.ffs@tglx>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 10:14:54AM +0100, Thomas Gleixner wrote:
> On Mon, Feb 20 2023 at 21:51, Krister Johansen wrote:
> > On Mon, Feb 20, 2023 at 08:14:40PM -0800, Krister Johansen wrote:
> >> > static bool __init xen_tsc_safe_clocksource(void)
> >> > {
> >> > 	u32 eax, ebx. ecx, edx;
> >> >  
> >> > 	/* Leaf 4, sub-leaf 0 (0x40000x03) */
> >> > 	cpuid_count(xen_cpuid_base() + 3, 0, &eax, &ebx, &ecx, &edx);
> >> > 
> >> > 	return ebx == XEN_CPUID_TSC_MODE_NEVER_EMULATE;
> >> > }
> >> 
> >> I'm all for simplifying.  I'm happy to clean up that return to be more
> >> idiomatic.  I was under the impression, perhaps mistaken, though, that
> >> the X86_FEATURE_CONSTANT_TSC, X86_FEATURE_NONSTOP_TSC, and
> >> check_tsc_unstable() checks were actually serving a purpose: to ensure
> >> that we don't rely on the tsc in environments where it's being emulated
> >> and the OS would be better served by using a PV clock.  Specifically,
> >> kvmclock_init() makes a very similar set of checks that I also thought
> >> were load-bearing.
> >
> > Bah, what I meant to say was emulated, unstable, or otherwise unsuitable
> > for use as a clocksource.  IOW, even if TSC_MODE_NEVER_EMULATE is
> > set, it's possible that a user is attempting a migration from a cpu
> > that's not invariant, and we'd still want to check for that case and
> > fall back to a PV clocksource, correct?
> 
> Sure. But a life migration from a NEVER_EMULATE to a non-invariant host
> is a patently bad idea and has nothing to do with the __init function,
> which is gone at that point already.
> 
> What I wanted to say:
> 
> static bool __init xen_tsc_safe_clocksource(void)
> {
>         ......        
> 
> 	/* Leaf 4, sub-leaf 0 (0x40000x03) */
> 	cpuid_count(xen_cpuid_base() + 3, 0, &eax, &ebx, &ecx, &edx);
> 
> 	return ebx == XEN_CPUID_TSC_MODE_NEVER_EMULATE;
> }

Thanks, I'm happy to make it look like ^ that.  I should have thought to
do this myself. :/

I'll send out a v2 making this correction.

> I didn't have the full context and was just looking at the condition.
> Now I checked the full context and I think that except for the
> 
> 	if (check_tsc_unstable())
> 
> check everything else can go away unless you do not trust the hypervisor
> that it only sets the NEVER_EMULATE bit when CONSTANT and NONSTOP are
> set as well. But yeah, you might prefer to be paranoid. It's virt after
> all.

Unless there are objections, I think I'd prefer to err on the side of
paranoia here.  Sorry for the confusion.

-K
