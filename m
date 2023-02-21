Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54B269DA0B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 05:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjBUEOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 23:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjBUEOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 23:14:46 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE741A971
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 20:14:44 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 7212F821668
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 04:14:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a304.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id E221A821614
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 04:14:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1676952883; a=rsa-sha256;
        cv=none;
        b=awdKe+ch7t8bU96fGpC1UNSzzxqk9kMxlysC+cmnAPViZU8Jbu+vP4HGCGL/aPLZByGdqH
        y2Yt10oAJlhjEoZ/dsaLdojJS2uSxT56g4IKG8ooYS9cfxRPXz1Jr5c3kg69qYbeT0ytKa
        u6WvhflWgMHrFAu06gODtAul2TBrxAF/abgPl/INupqBTkke5HCsE05kZiOCg/3zoK46WC
        OxwlV4njnzXThRnrbZS9hNUjkZ9RG6X9VcKMrMit5z4hkvMYvRHJ2AAczp5ZejDi4G8NdI
        DdbdHwKU0JYCCHTnGhLf2wk0ecoflx31aiXE7Y7kpdD56KcS6ykfXZQ2N8dUpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1676952883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=ImnJPBdDN9t/YWBpOudrdBxjWvZR/5gNnDFra2E2Guo=;
        b=pOo0624vYcweerO92kqV680DXq2tGvW0aNUHOhlucb34eS0he7VTIi1zdX9L8BQJM1SC/R
        XukKT43PGZ5OOk+Uu20h+OmIYid1YhHAu/ZD02VZbefEr+wwELBpA1sFMZTfbfOQmAHPfr
        uRS7a/GpiPBThcjjo+iEf2NsBAqsXm0hFT0pvlLzQraulWxHA72c1/tvLOLKzDy3aNzp1R
        qEtYt7zLgSSzkvqyrU5g6+VVH6aD1vVSHd5J5yiBWJHXsY5x9X0e3de3sTJ7sT3x4TwL2m
        7iHDnxnO8WqwmVxAOm8xwhOjnxm7jWs1u0BT7HPSb4u8Z+nI0qjz2+pUHrrTJQ==
ARC-Authentication-Results: i=1;
        rspamd-9788b98bc-n8m26;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Lettuce-Trade: 35d8988209a053f4_1676952884135_2657517305
X-MC-Loop-Signature: 1676952884135:1728651785
X-MC-Ingress-Time: 1676952884135
Received: from pdx1-sub0-mail-a304.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.48.87 (trex/6.7.1);
        Tue, 21 Feb 2023 04:14:44 +0000
Received: from kmjvbox (c-76-102-200-71.hsd1.ca.comcast.net [76.102.200.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a304.dreamhost.com (Postfix) with ESMTPSA id 4PLQsv1sBGzd7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 20:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1676952883;
        bh=ImnJPBdDN9t/YWBpOudrdBxjWvZR/5gNnDFra2E2Guo=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=k50CCeG1AwC0vdT3btOV+KuR/P19UQfyulQMidh855dABo99SvbqOYjlLia6T2Jq7
         25IXt8VQFc6besORNDAPWD44BZBnVom61wSkATjq/E+342pQKcL794bjulfB8nX5hW
         NQYr4v7daSO72mW0wgSYvqS3DWYURzi891BhbDgE=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e009c
        by kmjvbox (DragonFly Mail Agent v0.12);
        Mon, 20 Feb 2023 20:14:40 -0800
Date:   Mon, 20 Feb 2023 20:14:40 -0800
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
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
Message-ID: <20230221041440.GA1934@templeofstupid.com>
References: <cover.1676610413.git.kjlx@templeofstupid.com>
 <f6bab47230b00cecb67f2c5d94716c8236609967.1676610413.git.kjlx@templeofstupid.com>
 <87h6vgov2p.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6vgov2p.ffs@tglx>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 11:01:18PM +0100, Thomas Gleixner wrote:
> On Mon, Feb 20 2023 at 09:17, Krister Johansen wrote:
> > @@ -495,8 +496,7 @@ static int __init xen_tsc_safe_clocksource(void)
> >  	/* Leaf 4, sub-leaf 0 (0x40000x03) */
> >  	cpuid_count(xen_cpuid_base() + 3, 0, &eax, &ebx, &ecx, &edx);
> >  
> > -	/* tsc_mode = no_emulate (2) */
> > -	if (ebx != 2)
> > +	if (ebx != XEN_CPUID_TSC_MODE_NEVER_EMULATE)
> >  		return 0;
> >  
> >  	return 1;
> 
> What about removing more stupidity from that function?
> 
> static bool __init xen_tsc_safe_clocksource(void)
> {
> 	u32 eax, ebx. ecx, edx;
>  
> 	/* Leaf 4, sub-leaf 0 (0x40000x03) */
> 	cpuid_count(xen_cpuid_base() + 3, 0, &eax, &ebx, &ecx, &edx);
> 
> 	return ebx == XEN_CPUID_TSC_MODE_NEVER_EMULATE;
> }

I'm all for simplifying.  I'm happy to clean up that return to be more
idiomatic.  I was under the impression, perhaps mistaken, though, that
the X86_FEATURE_CONSTANT_TSC, X86_FEATURE_NONSTOP_TSC, and
check_tsc_unstable() checks were actually serving a purpose: to ensure
that we don't rely on the tsc in environments where it's being emulated
and the OS would be better served by using a PV clock.  Specifically,
kvmclock_init() makes a very similar set of checks that I also thought
were load-bearing.

-K
