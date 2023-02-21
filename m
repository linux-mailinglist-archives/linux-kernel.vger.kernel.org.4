Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A15069E5FB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbjBUR2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjBUR2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:28:43 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783087AAA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:27:57 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 2BE176C1DB6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 17:22:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a305.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A009A6C1DE0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 17:22:05 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677000125; a=rsa-sha256;
        cv=none;
        b=VCaO+SqLxLYZsHGRDLjXP2mj6QxwFXRre6qoC6b1BHWJCP0Bw7Sgo7XpDnoHn3vRF6JzEE
        MFWiS8Sd2EEGHaDXv2Rn/7JGXiQPAoh/buI2iK9aDUCO8/MEXy2QTo54D2kN9esscWaW31
        8rOM/SnmmffqFu9CaRJdxd+WI4laRqr0SHRLAN/wEt4Y7k+vDzF6NLqsdbqOE8++7p31EA
        Cp6Ybvjkl2m8EtetWDNjV5Hw6eD4+qrVPSwQB/DujzCwqQ3bHnHIkvefWvp6YYuqze0gPc
        3iOGyKQXLaKiBn87t7P3aF5HaCdaMyzbM14Ry4GmgEanjXmuZHod9xGTXH36RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677000125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=V/XcrwQCic125n2lnngmDNOBHq5WbsWAtWXZs/Ki6+I=;
        b=1X/V0cdKSyXKznrvzxPUyPKrvoTej7rXzAGBTNwuiraGZHnzOtroUg12UASkzmm+dwk+5f
        bl4WCDYGky7++GbzFcgH76Na4AAaV3+FkzzacTotFCAEjjRn1G/MBWwtwntv9UVXy+z6wk
        4Sg9GqEUU2LlyfKecRWmQ5o9jt/ywjvyWbSuCKOa8kkEhezfwtmHIGrhfTrl3xEByK7dq6
        /QFGSjnnrlUEcDLJHx38FTUB9exQug/1SnsWA7AnNAew4an5r0whJ9R6HKToQ4bOgvCFcv
        YtYYKvK137h76jGzGtkTp3Wg1IdpqwmLTNZKsCVW/d7RFmFTP0Bt4EfNCGiHhQ==
ARC-Authentication-Results: i=1;
        rspamd-5db48964c-h5x86;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Celery-Desert: 0271dbc06f45e987_1677000125967_4182954317
X-MC-Loop-Signature: 1677000125967:1643486477
X-MC-Ingress-Time: 1677000125967
Received: from pdx1-sub0-mail-a305.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.227.140 (trex/6.7.1);
        Tue, 21 Feb 2023 17:22:05 +0000
Received: from kmjvbox (c-76-102-200-71.hsd1.ca.comcast.net [76.102.200.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a305.dreamhost.com (Postfix) with ESMTPSA id 4PLmLM6xH0zdR
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1677000124;
        bh=V/XcrwQCic125n2lnngmDNOBHq5WbsWAtWXZs/Ki6+I=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=t38e3ebH6n0d5KAs1qjo+n9b7yYz904DV8k7Xm4gfAeAvlRyaKDDgF5f5myB4DFNz
         GW/e+O3i5YqMryRYNEMlfdLI1G8jHb8ihCRKW5zanR4jwJU2dynL91n7DmCWMgQWcL
         uJvrwUpSBfmIbAhMqrx8ptJvUv1RXb6kjneLFU9o=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0049
        by kmjvbox (DragonFly Mail Agent v0.12);
        Tue, 21 Feb 2023 09:22:00 -0800
Date:   Tue, 21 Feb 2023 09:22:00 -0800
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     Krister Johansen <kjlx@templeofstupid.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
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
Message-ID: <20230221172200.GB1958@templeofstupid.com>
References: <cover.1676610413.git.kjlx@templeofstupid.com>
 <f6bab47230b00cecb67f2c5d94716c8236609967.1676610413.git.kjlx@templeofstupid.com>
 <87h6vgov2p.ffs@tglx>
 <20230221041440.GA1934@templeofstupid.com>
 <20230221055117.GA1934@templeofstupid.com>
 <cd9acc63-c352-93c8-56bf-52ef69e5e124@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd9acc63-c352-93c8-56bf-52ef69e5e124@suse.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 09:47:24AM +0100, Juergen Gross wrote:
> On 21.02.23 06:51, Krister Johansen wrote:
> > On Mon, Feb 20, 2023 at 08:14:40PM -0800, Krister Johansen wrote:
> > > On Mon, Feb 20, 2023 at 11:01:18PM +0100, Thomas Gleixner wrote:
> > > > On Mon, Feb 20 2023 at 09:17, Krister Johansen wrote:
> > > > > @@ -495,8 +496,7 @@ static int __init xen_tsc_safe_clocksource(void)
> > > > >   	/* Leaf 4, sub-leaf 0 (0x40000x03) */
> > > > >   	cpuid_count(xen_cpuid_base() + 3, 0, &eax, &ebx, &ecx, &edx);
> > > > > -	/* tsc_mode = no_emulate (2) */
> > > > > -	if (ebx != 2)
> > > > > +	if (ebx != XEN_CPUID_TSC_MODE_NEVER_EMULATE)
> > > > >   		return 0;
> > > > >   	return 1;
> > > > 
> > > > What about removing more stupidity from that function?
> > > > 
> > > > static bool __init xen_tsc_safe_clocksource(void)
> > > > {
> > > > 	u32 eax, ebx. ecx, edx;
> > > > 	/* Leaf 4, sub-leaf 0 (0x40000x03) */
> > > > 	cpuid_count(xen_cpuid_base() + 3, 0, &eax, &ebx, &ecx, &edx);
> > > > 
> > > > 	return ebx == XEN_CPUID_TSC_MODE_NEVER_EMULATE;
> > > > }
> > > 
> > > I'm all for simplifying.  I'm happy to clean up that return to be more
> > > idiomatic.  I was under the impression, perhaps mistaken, though, that
> > > the X86_FEATURE_CONSTANT_TSC, X86_FEATURE_NONSTOP_TSC, and
> > > check_tsc_unstable() checks were actually serving a purpose: to ensure
> > > that we don't rely on the tsc in environments where it's being emulated
> > > and the OS would be better served by using a PV clock.  Specifically,
> > > kvmclock_init() makes a very similar set of checks that I also thought
> > > were load-bearing.
> > 
> > Bah, what I meant to say was emulated, unstable, or otherwise unsuitable
> > for use as a clocksource.  IOW, even if TSC_MODE_NEVER_EMULATE is
> > set, it's possible that a user is attempting a migration from a cpu
> > that's not invariant, and we'd still want to check for that case and
> > fall back to a PV clocksource, correct?
> 
> But Thomas' suggestion wasn't changing any behavior compared to your
> patch. It just makes it easier to read.
> 
> If you are unsure your patch is correct, please verify the correctness
> before sending it.

Thanks, and apologies. I misunderstood and thought a more complex change
was requested.

-K
