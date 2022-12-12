Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4979A64A48A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 17:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbiLLQEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 11:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiLLQEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:04:38 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6531F11806
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:04:36 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1D233141CC3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:57:35 +0000 (UTC)
Received: from pdx1-sub0-mail-a306.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A81DE1412F0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:57:34 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1670860654; a=rsa-sha256;
        cv=none;
        b=A6Fxl6EvVCG6EfLP0SdRS8q1RFUkO9J0IhPb0R2celh0mP1CtpyC8izAM2B4FoDThRHa1j
        Cc2XW4zfgfb0/5Nq8qn+NshXvoYj9FbNfZUl3i0WgUfNZoTSu6j+pX2o2BblPi45nsIIwp
        ClzpOZ5angBe1RoTw5fz96iKZmORuKLY48HWnGJXFmmcE/3T30uIrGb4IFtfPBnrWdlb+c
        4qVbvET3Cy1WnRy8+Zypf0w4CnOMtcqhvy2VE80XitZWM1qqcC1KobTaWof45UdnkvQhIF
        /C5hGBDSEjOquDai+H8ubSz3jNM1t6ll6q8dbEiMo2+/kY2FfqViOhucqDehWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1670860654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=4T/zjG3plJ8sYfo5jMTvgYHcxH66poUD8cr6GG0LDRs=;
        b=1LJZh+i+PAMrKIfHOqPHs7ys79S9Z+VgFeKAWg+GWL3D67BjaH9s8tlqBmP4CVMOrPH8vY
        Tvs799i86LnzYprl6Vu+aoX8j+3SxGGjYXa+ioSBWpS8wLqdBTJPjEKEF+4MkjGm3JWlAf
        +WX3wfaY4SZIltx3dIkq+bqXCN6nLE5bfOkiC4mbFq5hfzbuUdkCrH3RiM/OPF63qt57Bp
        9ipi2I72zB5/lAeMj2BkRBTmFyyzTLzebHQpokjOmrGDLrtcWOlHBjVZk5UUqsPG/cE6rf
        WOXuPxHsU6u8aU3L1UC6sq6mrZdUr+9UC3KmmPyw99j+ZULgBB/+9tIlBv5jYQ==
ARC-Authentication-Results: i=1;
        rspamd-d48c5ddb-nj59r;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Spicy-Bored: 23bdff68199c4b16_1670860654920_4039219628
X-MC-Loop-Signature: 1670860654920:4294638975
X-MC-Ingress-Time: 1670860654920
Received: from pdx1-sub0-mail-a306.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.227.146 (trex/6.7.1);
        Mon, 12 Dec 2022 15:57:34 +0000
Received: from kmjvbox (c-73-70-108-208.hsd1.ca.comcast.net [73.70.108.208])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a306.dreamhost.com (Postfix) with ESMTPSA id 4NW5qd4W0yzmL
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 07:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1670860653;
        bh=4T/zjG3plJ8sYfo5jMTvgYHcxH66poUD8cr6GG0LDRs=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=rS8AOfUvj/sxhB7y5MxG4vuS1Im8fpddc7fDN9zqGwS/Hy3RJorODqyuEGQRNj3BX
         bHuBPDgEDT/gv6BsAXfXPiSPCghIHIsAMHF5lYfJra4TDj+bYh8aRxjozA7oTQWx40
         FkPCBexZrraP8wgdo6ATStyICAChgaw92WElM4wA=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0062
        by kmjvbox (DragonFly Mail Agent v0.12);
        Mon, 12 Dec 2022 07:57:30 -0800
Date:   Mon, 12 Dec 2022 07:57:30 -0800
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Krister Johansen <kjlx@templeofstupid.com>,
        Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Anthony Liguori <aliguori@amazon.com>,
        David Reaver <me@davidreaver.com>,
        Brendan Gregg <brendan@intel.com>
Subject: Re: [PATCH linux-next] x86/xen/time: prefer tsc as clocksource when
 it is invariant
Message-ID: <20221212155730.GA1973@templeofstupid.com>
References: <20221208163650.GA3225@templeofstupid.com>
 <1e6c1b08-d573-fba9-61fd-d40a74427d46@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e6c1b08-d573-fba9-61fd-d40a74427d46@oracle.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 02:32:15PM -0500, Boris Ostrovsky wrote:
> 
> On 12/8/22 11:36 AM, Krister Johansen wrote:
> > +	/*
> > +	 * As Dom0 is never moved, no penalty on using TSC there.
> > +	 *
> > +	 * If the guest has invariant tsc, then set xen_clocksource rating
> > +	 * below that of the tsc so that the system prefers tsc instead.  This
> > +	 * check excludes PV domains, because PV is unable to guarantee that the
> > +	 * guest's cpuid call has been intercepted by the hypervisor.
> > +	 */
> > +	if (xen_initial_domain()) {
> >   		xen_clocksource.rating = 275;
> > +	} else if ((xen_hvm_domain() || xen_pvh_domain()) &&
> > +	    boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
> > +	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
> > +	    !check_tsc_unstable()) {
> > +		xen_clocksource.rating = 299;
> > +	}
> 
> 
> What if RDTSC is intercepted?

Right, thanks.  I'll send out an updated patch here shortly that
attempts to address this by examining the cpuid information to determine
if the tsc is being emulated.

-K
