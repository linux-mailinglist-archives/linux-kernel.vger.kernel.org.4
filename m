Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA3869DA80
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 06:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbjBUFv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 00:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjBUFv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 00:51:26 -0500
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA3123C62
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 21:51:23 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 8A13F880B87
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 05:51:20 +0000 (UTC)
Received: from pdx1-sub0-mail-a304.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 279178807A3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 05:51:20 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1676958680; a=rsa-sha256;
        cv=none;
        b=+SyVpYUnYMG49RZl3Fo/SmAlUKFBnBia8sMvoyEOd3+3JlCx3DaWZLrpHWQN8cwbkZium+
        QMk3t6S4giTn1AvWKL/PB8mWqjIPctNZUJy0lPM34RExFVvpguY9rVbrg1FEJ4MtzmnYg2
        73ihYDMVNEcBR+zOHi/9cvF6+g6k1eP7sbjcwLD592Stpgmaxj3MdWvFdJ/szW5Aot/o5y
        xhG2/96M+NTMk+LID5Dlx4OaePeudPFZ3Em6iVzCVAVuv6u82XxLrvFp+6en0Mgup9leyh
        NGeLZI8W83tHUdskjFQAuQleSh9Ee35hS12zvhlnxQ2ybELZcx/pL3LfrQAShA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1676958680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=4Ryms4gHoy/MGnNprWGKzCdsTkn+W4ai7vFOzO+3AGw=;
        b=3P6hxWtKbaqG76Fh6IYONPJSCJYuOVJv2GC1nxO/in/eyXs9LZCqPLKd3d6SSK6cp99bUQ
        UFLoukSPM3nx4mDYL+Z3Usehjh1VBPC0v8ZD2Ob2QZZsjAnmtF/ra3hWek2fW55Wf0w3y4
        6fyd/PPoOGnWipC18REV7qgKVdMnNtDgYKklX30BC615KXDv0HN5L5XsxFu4I4o9YkF6Uz
        Szn5NnDbHQDbhKYyQj5uT3dvqfMlp0xzB+GBfg8jS4nxF/Sa/gxomFi03+SNeJEk+aHFCq
        qRkRP/eYRlzV8M+eQoCo4IWqx2ZLpFK8BOFI5QNL3vdTAp1ztpaYlsW9UgI7Sw==
ARC-Authentication-Results: i=1;
        rspamd-5db48964c-wmdpd;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Tasty-Cure: 1bb3e197561569fe_1676958680373_915016925
X-MC-Loop-Signature: 1676958680373:3919516853
X-MC-Ingress-Time: 1676958680373
Received: from pdx1-sub0-mail-a304.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.107.134.126 (trex/6.7.1);
        Tue, 21 Feb 2023 05:51:20 +0000
Received: from kmjvbox (c-76-102-200-71.hsd1.ca.comcast.net [76.102.200.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a304.dreamhost.com (Postfix) with ESMTPSA id 4PLT1M5BZgzd7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 21:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1676958679;
        bh=4Ryms4gHoy/MGnNprWGKzCdsTkn+W4ai7vFOzO+3AGw=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=ODo7CVzs5sFOwiyqDH58lvqtbRhN/pp+GDD4QD1mQcWjhYGj7KIwGzNCXNv05epkH
         AHrXXdv5ri7R5VdJHLYFtSuAw+zt7Zc5ZYr9It1N2KHKsUuicchc0+223SRciI5eHi
         bcysQHndCS0eGw34Z4+B0DZFd4J+TGPvdwlX+YZ4=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e00f5
        by kmjvbox (DragonFly Mail Agent v0.12);
        Mon, 20 Feb 2023 21:51:17 -0800
Date:   Mon, 20 Feb 2023 21:51:17 -0800
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
Message-ID: <20230221055117.GA1934@templeofstupid.com>
References: <cover.1676610413.git.kjlx@templeofstupid.com>
 <f6bab47230b00cecb67f2c5d94716c8236609967.1676610413.git.kjlx@templeofstupid.com>
 <87h6vgov2p.ffs@tglx>
 <20230221041440.GA1934@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221041440.GA1934@templeofstupid.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 08:14:40PM -0800, Krister Johansen wrote:
> On Mon, Feb 20, 2023 at 11:01:18PM +0100, Thomas Gleixner wrote:
> > On Mon, Feb 20 2023 at 09:17, Krister Johansen wrote:
> > > @@ -495,8 +496,7 @@ static int __init xen_tsc_safe_clocksource(void)
> > >  	/* Leaf 4, sub-leaf 0 (0x40000x03) */
> > >  	cpuid_count(xen_cpuid_base() + 3, 0, &eax, &ebx, &ecx, &edx);
> > >  
> > > -	/* tsc_mode = no_emulate (2) */
> > > -	if (ebx != 2)
> > > +	if (ebx != XEN_CPUID_TSC_MODE_NEVER_EMULATE)
> > >  		return 0;
> > >  
> > >  	return 1;
> > 
> > What about removing more stupidity from that function?
> > 
> > static bool __init xen_tsc_safe_clocksource(void)
> > {
> > 	u32 eax, ebx. ecx, edx;
> >  
> > 	/* Leaf 4, sub-leaf 0 (0x40000x03) */
> > 	cpuid_count(xen_cpuid_base() + 3, 0, &eax, &ebx, &ecx, &edx);
> > 
> > 	return ebx == XEN_CPUID_TSC_MODE_NEVER_EMULATE;
> > }
> 
> I'm all for simplifying.  I'm happy to clean up that return to be more
> idiomatic.  I was under the impression, perhaps mistaken, though, that
> the X86_FEATURE_CONSTANT_TSC, X86_FEATURE_NONSTOP_TSC, and
> check_tsc_unstable() checks were actually serving a purpose: to ensure
> that we don't rely on the tsc in environments where it's being emulated
> and the OS would be better served by using a PV clock.  Specifically,
> kvmclock_init() makes a very similar set of checks that I also thought
> were load-bearing.

Bah, what I meant to say was emulated, unstable, or otherwise unsuitable
for use as a clocksource.  IOW, even if TSC_MODE_NEVER_EMULATE is
set, it's possible that a user is attempting a migration from a cpu
that's not invariant, and we'd still want to check for that case and
fall back to a PV clocksource, correct?

-K
