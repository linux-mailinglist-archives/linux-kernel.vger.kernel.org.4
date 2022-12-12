Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDEB64AA02
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbiLLWND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbiLLWNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:13:00 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6904225DB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:12:58 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 12474341B3E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 22:05:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a304.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 9738E341B2D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 22:05:21 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1670882721; a=rsa-sha256;
        cv=none;
        b=jl2Fy+GDmVgN9Vfh1noaPkSibV3ZMbkTQwD5Mq+RZ447d9wXef+jvDcX5Z/T9oCK283YLx
        dpfywVIppPMU20CBiGHSbOhHkJhNjRt7A647ygO48Bg0nYKz0eeGsxxN4xh+PKIw/AWNxr
        kkZvJ2+qiruay8w88CM9EkAZpwCFDUtROgdgH2mlw+GeFpSR6L3kQ3j1IFlS0p2qLj+IGo
        AWI9u4mA7bedwtootNHTWskrPAE0014vxypgOTdFhWuQVZ3GTywv9Mr+TEjQGKoXC05DaI
        f1aIfubvq/2ro39UniifzLwyEOUynvovQbTw4Sn+KCJNy9DuYgJDn4/FHbINTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1670882721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=xrSRqK22H1qk6KC3KGZi1FQxfrUjE/JEcWhWhN579Q0=;
        b=Hc5Hm1yTIaEI/TpPGcAGP1yLa8t/5F/goBZyytoC5YOqs6UgrkKnssK4mFcEA8T34EuL1E
        rDysfAcAJk3LiuU6M5lVjvwa8/pUl9dYW33ZHYvzv+aQgIdH4rr3G9eoHDv64vunUfqPUS
        l++XXeDO9Dxa9TzbMEnqof8+YkTM4+BSG8oPj0f1/Q8+Y6QHAO7p4rRpElw7xUiYYOeO70
        rnqY71rGCwLz/yrpgf+y7bdXCpb6cipMkn7WiY01beTV2NJXfsXwCjRJyT23KoHb4ExJlV
        9m3KlEOwv6vfPvI8dKl0xCzA60EZedqAAZvxsZz2c1yOtm3BH8x3CNPNJPgYmA==
ARC-Authentication-Results: i=1;
        rspamd-d48c5ddb-mhsgd;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Plucky-Unite: 50a0f0c83f5f994b_1670882721833_1000516222
X-MC-Loop-Signature: 1670882721833:1295267959
X-MC-Ingress-Time: 1670882721833
Received: from pdx1-sub0-mail-a304.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.30 (trex/6.7.1);
        Mon, 12 Dec 2022 22:05:21 +0000
Received: from kmjvbox (c-73-70-108-208.hsd1.ca.comcast.net [73.70.108.208])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a304.dreamhost.com (Postfix) with ESMTPSA id 4NWG012NvKz3Q
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1670882721;
        bh=xrSRqK22H1qk6KC3KGZi1FQxfrUjE/JEcWhWhN579Q0=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=ppqXxqiW3B//K8XZoCy3NJk0DAjHvLdcxdqcjCuSKuzTvtABGWUNshaAQqBR9TeC3
         a5STwtmYrvqb5Yoyz4Xc9zvNGkgGEoD/omioUxifsuUJhDB9cil8maKDLC+3ZrlQ28
         9mqetbwCFJ8cxBul1svWEsJwQJiA7lgv+7bnmEI4=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0085
        by kmjvbox (DragonFly Mail Agent v0.12);
        Mon, 12 Dec 2022 14:05:19 -0800
Date:   Mon, 12 Dec 2022 14:05:19 -0800
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Anthony Liguori <aliguori@amazon.com>,
        David Reaver <me@davidreaver.com>,
        Brendan Gregg <brendan@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH linux-next v2] x86/xen/time: prefer tsc as clocksource
 when it is invariant
Message-ID: <20221212220519.GA1935@templeofstupid.com>
References: <20221208163650.GA3225@templeofstupid.com>
 <1e6c1b08-d573-fba9-61fd-d40a74427d46@oracle.com>
 <20221212155730.GA1973@templeofstupid.com>
 <20221212160524.GB1973@templeofstupid.com>
 <1eb6048b-bf23-78a0-9c3c-54bbd12c3864@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eb6048b-bf23-78a0-9c3c-54bbd12c3864@suse.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 05:46:29PM +0100, Jan Beulich wrote:
> On 12.12.2022 17:05, Krister Johansen wrote:
> > Both the Intel SDM[4] and the Xen tsc documentation explain that marking
> > a tsc as invariant means that it should be considered stable by the OS
> > and is elibile to be used as a wall clock source.  The Xen documentation
> > further clarifies that this is only reliable on HVM and PVH because PV
> > cannot intercept a cpuid instruction.
> 
> Without meaning to express a view on the argumentation as a whole, this
> PV aspect is suspicious. Unless you open-code a use of the CPUID insn
> in the kernel, all uses of CPUID are going to be processed by Xen by
> virtue of the respective pvops hook. Documentation says what it says
> for environments where this might not be the case.

Thanks, appreciate the clarification here. Just restating this for my
own understanding: your advice would be to drop this check below?

> > +	if (!(xen_hvm_domain() || xen_pvh_domain()))
> > +		return 0;

And then update the commit message to dispense with the distinction
between HVM, PV, and PVH?

> > +	cpuid(xen_cpuid_base() + 3, &eax, &ebx, &ecx, &edx);
> 
> Xen leaf 3 has sub-leaves, so I think you need to set ecx to zero before
> this call.

The cpuid() inline in arch/x86/include/asm/processor.h assigns zero to
ecx prior to calling __cpuid.  In arch/x86/boot/cpuflags.c the macros
are a little different, but it looks like there too, the macro passes 0
as an input argument to cpuid_count which ends up being %ecx.  Happy to
fix this up if I'm looking at the wrong cpuid functions, though.

-K
