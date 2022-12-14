Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BDD64CF10
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 19:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbiLNSCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 13:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238488AbiLNSBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 13:01:53 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB011220C2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:01:51 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 8D454201894
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 18:01:50 +0000 (UTC)
Received: from pdx1-sub0-mail-a305.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2B4642015F7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 18:01:50 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1671040910; a=rsa-sha256;
        cv=none;
        b=buRXdRzQMKm0vngaI84TTRgeBams5ZWpbf16jZ6Y35+bNeHONvbv+92x2rTNlQ2SkQENeX
        sUoQcmhxBdxixHtFXoCH9RJWmeXGoU3bFbic4t23RezBxUvBVBnjIQzV3llAFWGmTAYT6V
        238uU8qwmLIRs29LeNmvur6rqnI3PcNcWYS4R5bD67aL9SVhtT8qu9BIGwDqbcmMB1vt9w
        Gx2T5sCPzAEt8teq61oyoccO7+2AXXB3GncCoWMThhTgHMXS03SGgjz9M2MrfUatYdjzt4
        sJylPKpLxolYDnST7ct/PctrsQiTz4om458hXZ8d+LD+uDoiRVU9K0VsAYudkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1671040910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=nzCxD9ep+HzlNnesq87i3wkKKSLnVJxdvoCsaYb8DkE=;
        b=ZlxtOw25aVMk87QlCyBtudooKQ5k/2XX6qSYgAkfIyHc3RrAqbHKvFaCkxN+baPVxZO5zG
        PzNnzsExvpBpZIEy3GN6E0hsrU9ak3eKIaxy5b0pWrD/NdWBHLmQS2VwucM1ieTf7Y0BWq
        yvgwRx5YP+LDsqBl1ksQEZfcN5yDydQOAbHK98lorBK86c/c8L5aSvXTOJxahZf40MB00Z
        hR05PMrrG/hvKvCCPQvzqoa+Rgg18HuiTcKkk6YqBY0bl7Qr6hLYdW/HyCryySqGPNxfpi
        k7fKpFn3fBoJjCbA0YLqSDtxj7ovC260O0NFZpYIrdtRGxTZzQT/sVctbUQyxg==
ARC-Authentication-Results: i=1;
        rspamd-747d4f8b9f-4b2ws;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Society-Celery: 4f36f8d16e602aa7_1671040910419_3400174159
X-MC-Loop-Signature: 1671040910419:1363196436
X-MC-Ingress-Time: 1671040910419
Received: from pdx1-sub0-mail-a305.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.74.58 (trex/6.7.1);
        Wed, 14 Dec 2022 18:01:50 +0000
Received: from kmjvbox (c-73-70-108-208.hsd1.ca.comcast.net [73.70.108.208])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a305.dreamhost.com (Postfix) with ESMTPSA id 4NXNV50sQszZT
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1671040909;
        bh=nzCxD9ep+HzlNnesq87i3wkKKSLnVJxdvoCsaYb8DkE=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=OW9k8ELEAyWo+0pl83ai3xFagV5qPlnhBJEtud7VRNpzpUw4wqpMU8MMjnrnVczuo
         JTzHJ6L0ry5Mc0/ItMtQ7l1hJfUYum5eDEp/MJzqTrNP7ctgqz2agBAj+5Zdw72tMj
         AKsS43GKUbyW3dWNHcPVuW+wocpy+QINo+Q0VIvg=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0042
        by kmjvbox (DragonFly Mail Agent v0.12);
        Wed, 14 Dec 2022 10:01:47 -0800
Date:   Wed, 14 Dec 2022 10:01:47 -0800
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
Subject: Re: [PATCH linux-next v2] x86/xen/time: prefer tsc as clocksource
 when it is invariant
Message-ID: <20221214180147.GA1953@templeofstupid.com>
References: <20221208163650.GA3225@templeofstupid.com>
 <1e6c1b08-d573-fba9-61fd-d40a74427d46@oracle.com>
 <20221212155730.GA1973@templeofstupid.com>
 <20221212160524.GB1973@templeofstupid.com>
 <d1a2b785-edc7-b7da-d2f2-123d1555022e@oracle.com>
 <20221212220959.GB1935@templeofstupid.com>
 <9dfe87f0-fc95-6c28-6695-62f1f5403df6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dfe87f0-fc95-6c28-6695-62f1f5403df6@oracle.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 04:25:32PM -0500, Boris Ostrovsky wrote:
> 
> On 12/12/22 5:09 PM, Krister Johansen wrote:
> > On Mon, Dec 12, 2022 at 01:48:24PM -0500, Boris Ostrovsky wrote:
> > > On 12/12/22 11:05 AM, Krister Johansen wrote:
> > > > diff --git a/arch/x86/include/asm/xen/cpuid.h b/arch/x86/include/asm/xen/cpuid.h
> > > > index 6daa9b0c8d11..d9d7432481e9 100644
> > > > --- a/arch/x86/include/asm/xen/cpuid.h
> > > > +++ b/arch/x86/include/asm/xen/cpuid.h
> > > > @@ -88,6 +88,12 @@
> > > >     *             EDX: shift amount for tsc->ns conversion
> > > >     * Sub-leaf 2: EAX: host tsc frequency in kHz
> > > >     */
> > > > +#define XEN_CPUID_TSC_EMULATED       (1u << 0)
> > > > +#define XEN_CPUID_HOST_TSC_RELIABLE  (1u << 1)
> > > > +#define XEN_CPUID_RDTSCP_INSTR_AVAIL (1u << 2)
> > > > +#define XEN_CPUID_TSC_MODE_DEFAULT   (0)
> > > > +#define XEN_CPUID_TSC_MODE_EMULATE   (1u)
> > > > +#define XEN_CPUID_TSC_MODE_NOEMULATE (2u)
> > > This file is a copy of Xen public interface so this change should go to Xen first.
> > Ok, should I split this into a separate patch on the linux side too?
> 
> Yes. Once the Xen patch has been accepted you will either submit the same patch for Linux or sync Linux file with Xen (if there are more differences).

Thanks.  Based upon the feedback I received from you and Jan, I may try
to shrink the check in xen_tsc_safe_clocksource() down a bit.  In that
case, I may only need to refer to a single field in the leaf that
provides this information.  In that case, are you alright with dropping
the change to the header and referring to the value directly, or would
you prefer that I proceed with adding these to the public API?

> > > > +static int __init xen_tsc_safe_clocksource(void)
> > > > +{
> > > > +	u32 eax, ebx, ecx, edx;
> > > > +
> > > > +	if (!(xen_hvm_domain() || xen_pvh_domain()))
> > > > +		return 0;
> > > > +
> > > > +	if (!(boot_cpu_has(X86_FEATURE_CONSTANT_TSC)))
> > > > +		return 0;
> > > > +
> > > > +	if (!(boot_cpu_has(X86_FEATURE_NONSTOP_TSC)))
> > > > +		return 0;
> > > > +
> > > > +	if (check_tsc_unstable())
> > > > +		return 0;
> > > > +
> > > > +	cpuid(xen_cpuid_base() + 3, &eax, &ebx, &ecx, &edx);
> > > > +
> > > > +	if (eax & XEN_CPUID_TSC_EMULATED)
> > > > +		return 0;
> > > > +
> > > > +	if (ebx != XEN_CPUID_TSC_MODE_NOEMULATE)
> > > > +		return 0;
> > > Why is the last test needed?
> > I was under the impression that if the mode was 0 (default) it would be
> > possible for the tsc to become emulated in the future, perhaps after a
> > migration.  The presence of the tsc_mode noemulate meant that we could
> > count on the falseneess of the XEN_CPUID_TSC_EMULATED check remaining
> > constant.
> 
> This will filter out most modern processors with TSC scaling support where in default mode we don't intercept RDTCS after migration. But I don't think we have proper interface to determine this so we don't have much choice but to indeed make this check.

Yes, if this remains a single boot-time check, I'm not sure that knowing
whether the processor supports tsc scaling helps us.  If tsc_mode is
default, there's always a possibility of the tsc becoming emulated later
on as part of migration, correct?

The other thing that might be possible here is to add a background
timer that periodically checks if the tsc is still not emulated, and if
it suddenly becomes so, change the rating again to prefer the xen
clocksource.  I had written this off initially as an impractical
solution, since it seemed like a lot more mechanism and because it meant
the performance characteristics of the system would change without user
intervention.  However, if this seems like a good idea, I'm not opposed
to giving it a try.

-K
