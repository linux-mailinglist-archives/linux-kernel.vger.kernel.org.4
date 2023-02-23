Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F876A0E8D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 18:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjBWRTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 12:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBWRTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 12:19:03 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD0616302
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 09:18:59 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 4976C8C0EEE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 17:18:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a304.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id DACDB8C12FD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 17:18:57 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677172737; a=rsa-sha256;
        cv=none;
        b=4+oESQwNJfbueXlX4z0ZDT25lmI2rmWc2tJeZMuWsfUj0KKAGj9D/vr1eUpxbAtP4U7oN2
        K/OfziNEpRuHA0D2qcatGZQlqqY4n8+MuINu+Vf6uav07slFTq4E5kfWAzs2MmLJokpJs9
        ZM+db0CumZ6x5fp+/TfHtxxOrTg4F2xgXB+blJuDN8DfWtGsJ8Zmx2wIHs7jyLeddgJJvp
        SLgcXVxq2cipjexUYH2VJGzQRAE9D4ARzXeJGHhAj2a1fqEpQVwdnUcVxCqSB6pmPEGPNo
        RuYDFTpDElYnHoQxbmEhBH3BBz47wlLwSuDvVdOJnUTYiZ+hysD3Yp9fpiHSdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677172737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=lRYce4KCQENlo/4Iyy0wDSPQmcZweRPYZ7BvHZ9CWRo=;
        b=V6BKmAHgsomefRwdKSThgaX2R7oGzr+lBxoYDj+3/vwtQlwE4SqkL+D6un6pZ8LA0Pa3au
        9aEAwuUWglj/11VDdegPoEPuA8tZdGcgxG/95rG0LQRYTSUepaLjyI0d0Is21KtjBM5kug
        c2hGZTcgVUHQSF+2QiLqIZKleCQ1sePjmS/bM9bwi1kFrDQF6a0fpXhJ/c0T7eN7bd7Uxp
        66qzCfZLLm/5SC2Ak6D4yAux+gNBeItjD6Eug1NQknMzKetn7Bw+GKfque3+rO1Sv9Bna/
        Tf4L3RoldC4tyHbwKbNRDbpiRPuBAFvAJtLeatJrYuAWwk6bdhR70XI3WeRLYQ==
ARC-Authentication-Results: i=1;
        rspamd-9788b98bc-ft5nn;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Left-Callous: 66854b6c52088cf3_1677172738119_1153397040
X-MC-Loop-Signature: 1677172738119:128349036
X-MC-Ingress-Time: 1677172738119
Received: from pdx1-sub0-mail-a304.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.74.37 (trex/6.7.1);
        Thu, 23 Feb 2023 17:18:58 +0000
Received: from kmjvbox (c-76-102-200-71.hsd1.ca.comcast.net [76.102.200.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a304.dreamhost.com (Postfix) with ESMTPSA id 4PN09s3bH1z1G
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 09:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1677172737;
        bh=lRYce4KCQENlo/4Iyy0wDSPQmcZweRPYZ7BvHZ9CWRo=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=oPIxTFyZbMU3AEcozwC1RmCJGc00jusHFNFoQQEuMMaPyjzSDKAvMkKTIAJVzWzng
         DZkvMkL0LeNHmwVu0fJkiqnT43AE8G/dQY83QZlEwNOFV5S/bKAcBW+5LtE+QN2Wnb
         Ftx4k00m5JnHe3CXR598SkIRB4GertoqAtjZQMao=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0084
        by kmjvbox (DragonFly Mail Agent v0.12);
        Thu, 23 Feb 2023 09:18:54 -0800
Date:   Thu, 23 Feb 2023 09:18:54 -0800
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Anthony Liguori <aliguori@amazon.com>,
        David Reaver <me@davidreaver.com>,
        Brendan Gregg <brendan@intel.com>
Subject: Re: [PATCH linux-next 2/2] x86/xen/time: cleanup
 xen_tsc_safe_clocksource
Message-ID: <20230223171854.GA1963@templeofstupid.com>
References: <cover.1676610413.git.kjlx@templeofstupid.com>
 <f6bab47230b00cecb67f2c5d94716c8236609967.1676610413.git.kjlx@templeofstupid.com>
 <87h6vgov2p.ffs@tglx>
 <20230221041440.GA1934@templeofstupid.com>
 <Y/d5XhtOaYkNRnpQ@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/d5XhtOaYkNRnpQ@tpad>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

On Thu, Feb 23, 2023 at 11:34:06AM -0300, Marcelo Tosatti wrote:
> On Mon, Feb 20, 2023 at 08:14:40PM -0800, Krister Johansen wrote:
> > On Mon, Feb 20, 2023 at 11:01:18PM +0100, Thomas Gleixner wrote:
> > > On Mon, Feb 20 2023 at 09:17, Krister Johansen wrote:
> > > > @@ -495,8 +496,7 @@ static int __init xen_tsc_safe_clocksource(void)
> > > >  	/* Leaf 4, sub-leaf 0 (0x40000x03) */
> > > >  	cpuid_count(xen_cpuid_base() + 3, 0, &eax, &ebx, &ecx, &edx);
> > > >  
> > > > -	/* tsc_mode = no_emulate (2) */
> > > > -	if (ebx != 2)
> > > > +	if (ebx != XEN_CPUID_TSC_MODE_NEVER_EMULATE)
> > > >  		return 0;
> > > >  
> > > >  	return 1;
> > > 
> > > What about removing more stupidity from that function?
> > > 
> > > static bool __init xen_tsc_safe_clocksource(void)
> > > {
> > > 	u32 eax, ebx. ecx, edx;
> > >  
> > > 	/* Leaf 4, sub-leaf 0 (0x40000x03) */
> > > 	cpuid_count(xen_cpuid_base() + 3, 0, &eax, &ebx, &ecx, &edx);
> > > 
> > > 	return ebx == XEN_CPUID_TSC_MODE_NEVER_EMULATE;
> > > }
> > 
> > I'm all for simplifying.  I'm happy to clean up that return to be more
> > idiomatic.  I was under the impression, perhaps mistaken, though, that
> > the X86_FEATURE_CONSTANT_TSC, X86_FEATURE_NONSTOP_TSC, and
> > check_tsc_unstable() checks were actually serving a purpose: to ensure
> > that we don't rely on the tsc in environments where it's being emulated
> > and the OS would be better served by using a PV clock.  Specifically,
> > kvmclock_init() makes a very similar set of checks that I also thought
> > were load-bearing.
> 
> kvmclock_init will lower the rating of kvmclock so that TSC clocksource
> can be used instead:
> 
>         /*
>          * X86_FEATURE_NONSTOP_TSC is TSC runs at constant rate
>          * with P/T states and does not stop in deep C-states.
>          *
>          * Invariant TSC exposed by host means kvmclock is not necessary:
>          * can use TSC as clocksource.
>          *
>          */
>         if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
>             boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
>             !check_tsc_unstable())
>                 kvm_clock.rating = 299;

Yes, I saw the change you made to the kvmclock to do this and was
inspired to try to do something similar for Xen:

https://lore.kernel.org/xen-devel/20221216162118.GB2633@templeofstupid.com/

Thanks,

-K
