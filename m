Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB1B64EEDE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiLPQVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiLPQUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:20:32 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1052229F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:20:23 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id EE57554124E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 16:20:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a305.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 759D75422A3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 16:20:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1671207622; a=rsa-sha256;
        cv=none;
        b=CLPjsgUvgSVd+UyVrud6gfG1fmQSZ0YWN+968qApt0xbPwszNThIMo2m3WHSPtbkot/qHQ
        Pda4ABw7iLV5be06IIvifr7/gqMe/JzbMTxYOfY4EfU3YXHZ4t+j9bKjFKU18RkONPKn1T
        Apq/qsBCw6aAfVPSMzHRrB0xI4moGHMIFpDcHlmRoqHGOAK9u6QBt6R6oSaHamPzRRsPV8
        ysG5HoI6LLOVpH5lCYM09WaL+abNqIE9ey6jh6sJNZklbszgoZLExWqDZ4ze9RPdsrjBKX
        YymUmZ9LII3V8NNbcLYpTjqe2gcbxvkEbpxkKHoY0XRmQsIUWAuDOVbYgK/jYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1671207622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=zZIw3M+aiD6J4RND/PUJdeymks7EZfag7xLSLFs2i3I=;
        b=ppOEA9H8oC49Q83ojalReCvUf4cicDZM56vsIgdTYzA1GUAyvhzmgrv4nbQbq8wL6wFevB
        zN7DzwuxkriAEHQCsX6fXefv0FNaXCadeG0FWgsrv5bh0aUmaKCXhyXZ+rpnPulWuqi3Db
        RZbvAOXtQO5iVIT0lxrsXZPMI6x+BIqd49s2A4Y46RycOexgM71lztkWo6n6cq9wWWDqOw
        J3Yk0qEcxNkOH6e6b41bT1RmAon19B6s5N9yLbSTtnTFwVxiL8lsBLBBWohA0G2cBnLeOH
        c2zAEGMVBXQE7ZG8Mew8f5bvqYAI9GEPhrBSbuO22hl7kN4IxrrF0thprQmpKA==
ARC-Authentication-Results: i=1;
        rspamd-56db58bdfc-47zsc;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Towering-Slimy: 499281f83aff6bdb_1671207622743_653816971
X-MC-Loop-Signature: 1671207622743:1216530471
X-MC-Ingress-Time: 1671207622743
Received: from pdx1-sub0-mail-a305.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.57 (trex/6.7.1);
        Fri, 16 Dec 2022 16:20:22 +0000
Received: from kmjvbox (c-73-70-108-208.hsd1.ca.comcast.net [73.70.108.208])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a305.dreamhost.com (Postfix) with ESMTPSA id 4NYZ85680lz3H
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1671207621;
        bh=zZIw3M+aiD6J4RND/PUJdeymks7EZfag7xLSLFs2i3I=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=YEt2plgXEZaBr0/tJ9/+hiIyZbJk2re9z+n80Yi71Kq9Q5zoio/3k3hj4NwDhkKBI
         ErkBn62H0g2n888Wq6cBHxfD2F78xl3aki213XhYo9hkL1AaOYxBqxdV5KQME4b3IS
         VfERcRWleQXhLqaFq78qN6cFyIiVZBCrnNMwK+iU=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e002b
        by kmjvbox (DragonFly Mail Agent v0.12);
        Fri, 16 Dec 2022 08:20:19 -0800
Date:   Fri, 16 Dec 2022 08:20:19 -0800
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Anthony Liguori <aliguori@amazon.com>,
        David Reaver <me@davidreaver.com>,
        Brendan Gregg <brendan@intel.com>
Subject: Re: [PATCH linux-next v2] x86/xen/time: prefer tsc as clocksource
 when it is invariant
Message-ID: <20221216162019.GA2633@templeofstupid.com>
References: <20221208163650.GA3225@templeofstupid.com>
 <1e6c1b08-d573-fba9-61fd-d40a74427d46@oracle.com>
 <20221212155730.GA1973@templeofstupid.com>
 <20221212160524.GB1973@templeofstupid.com>
 <d1a2b785-edc7-b7da-d2f2-123d1555022e@oracle.com>
 <20221212220959.GB1935@templeofstupid.com>
 <9dfe87f0-fc95-6c28-6695-62f1f5403df6@oracle.com>
 <20221214180147.GA1953@templeofstupid.com>
 <0835453d-9617-48d5-b2dc-77a2ac298bad@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0835453d-9617-48d5-b2dc-77a2ac298bad@oracle.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 04:46:10PM -0500, Boris Ostrovsky wrote:
> 
> On 12/14/22 1:01 PM, Krister Johansen wrote:
> > On Tue, Dec 13, 2022 at 04:25:32PM -0500, Boris Ostrovsky wrote:
> > > On 12/12/22 5:09 PM, Krister Johansen wrote:
> > > > On Mon, Dec 12, 2022 at 01:48:24PM -0500, Boris Ostrovsky wrote:
> > > > > On 12/12/22 11:05 AM, Krister Johansen wrote:
> > > > > > diff --git a/arch/x86/include/asm/xen/cpuid.h b/arch/x86/include/asm/xen/cpuid.h
> > > > > > index 6daa9b0c8d11..d9d7432481e9 100644
> > > > > > --- a/arch/x86/include/asm/xen/cpuid.h
> > > > > > +++ b/arch/x86/include/asm/xen/cpuid.h
> > > > > > @@ -88,6 +88,12 @@
> > > > > >      *             EDX: shift amount for tsc->ns conversion
> > > > > >      * Sub-leaf 2: EAX: host tsc frequency in kHz
> > > > > >      */
> > > > > > +#define XEN_CPUID_TSC_EMULATED       (1u << 0)
> > > > > > +#define XEN_CPUID_HOST_TSC_RELIABLE  (1u << 1)
> > > > > > +#define XEN_CPUID_RDTSCP_INSTR_AVAIL (1u << 2)
> > > > > > +#define XEN_CPUID_TSC_MODE_DEFAULT   (0)
> > > > > > +#define XEN_CPUID_TSC_MODE_EMULATE   (1u)
> > > > > > +#define XEN_CPUID_TSC_MODE_NOEMULATE (2u)
> > > > > This file is a copy of Xen public interface so this change should go to Xen first.
> > > > Ok, should I split this into a separate patch on the linux side too?
> > > Yes. Once the Xen patch has been accepted you will either submit the same patch for Linux or sync Linux file with Xen (if there are more differences).
> > Thanks.  Based upon the feedback I received from you and Jan, I may try
> > to shrink the check in xen_tsc_safe_clocksource() down a bit.  In that
> > case, I may only need to refer to a single field in the leaf that
> > provides this information.  In that case, are you alright with dropping
> > the change to the header and referring to the value directly, or would
> > you prefer that I proceed with adding these to the public API?
> 
> It would certainly be appreciated if you updated the header files but it's up to maintainers to decide whether it's required.

Sure, I'm just trying to avoid generating extra work for the maintainers
if this patch isn't likely to make it in.  I'm cutting a v3 that doesn't
reference the header.  If it's acceptable, and this looks otherwise
unobjectionable, then I'll go ahead and put together the pieces for the
public API, if that's still a desireable change.

> > > > > > +static int __init xen_tsc_safe_clocksource(void)
> > > > > > +{
> > > > > > +	u32 eax, ebx, ecx, edx;
> > > > > > +
> > > > > > +	if (!(xen_hvm_domain() || xen_pvh_domain()))
> > > > > > +		return 0;
> > > > > > +
> > > > > > +	if (!(boot_cpu_has(X86_FEATURE_CONSTANT_TSC)))
> > > > > > +		return 0;
> > > > > > +
> > > > > > +	if (!(boot_cpu_has(X86_FEATURE_NONSTOP_TSC)))
> > > > > > +		return 0;
> > > > > > +
> > > > > > +	if (check_tsc_unstable())
> > > > > > +		return 0;
> > > > > > +
> > > > > > +	cpuid(xen_cpuid_base() + 3, &eax, &ebx, &ecx, &edx);
> > > > > > +
> > > > > > +	if (eax & XEN_CPUID_TSC_EMULATED)
> > > > > > +		return 0;
> > > > > > +
> > > > > > +	if (ebx != XEN_CPUID_TSC_MODE_NOEMULATE)
> > > > > > +		return 0;
> > > > > Why is the last test needed?
> > > > I was under the impression that if the mode was 0 (default) it would be
> > > > possible for the tsc to become emulated in the future, perhaps after a
> > > > migration.  The presence of the tsc_mode noemulate meant that we could
> > > > count on the falseneess of the XEN_CPUID_TSC_EMULATED check remaining
> > > > constant.
> > > This will filter out most modern processors with TSC scaling support where in default mode we don't intercept RDTCS after migration. But I don't think we have proper interface to determine this so we don't have much choice but to indeed make this check.
> > Yes, if this remains a single boot-time check, I'm not sure that knowing
> > whether the processor supports tsc scaling helps us.  If tsc_mode is
> > default, there's always a possibility of the tsc becoming emulated later
> > on as part of migration, correct?
> 
> If the processor supports TSC scaling I don't think it's possible (it can happen in theory) but if it doesn't and you migrate to a CPU running at different frequency then yes, hypervisor will start emulating RDTSC.

Yes, I wondered whether it's reasonable to expect that users migrate
between hardware that is pretty similar, or if this case of moving from
a CPU that supports tsc scaling to one that doesn't is likely to happen
in practice.

-K 
