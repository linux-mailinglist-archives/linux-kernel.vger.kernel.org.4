Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494FD635C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbiKWLuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbiKWLuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:50:18 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A2D6254;
        Wed, 23 Nov 2022 03:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669204214; x=1700740214;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nNJj4/SNlznTLYes66f3xfwnOOogTO0GLozcvfHLa+E=;
  b=PyDarsJ39m1NLtmpHd00iYn4PgRUswUzOKQ2yn7j+pvnRMZzRj9+atPv
   7NhfkFwlbfVGcvXii+9pxyaW9ZVq7sBSJYc5ub74Iy19zSDQiT+swYrxB
   xIfegDQQOxXMYMBG7J7dlmfaFd9MiUJDG4KN/aOW2/zpj9/Zm9wy3T4Tm
   OT+qiwe7m9gpvvAbN34IE9MqxohtEPKo5jIE9qjOEWA+lcthG1RAzvS0t
   rbmgx4CdR2kIyVXaDh0LJtgQMB8mZmUqsFMKLuAAzhLHCF2ALfGGWQSyt
   Ehev0MoopP1G5oAg7puFDaWLLw2nk+/ed6Jn+UR/IfE6FdRLBU7MO9tPj
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="184837932"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Nov 2022 04:50:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 23 Nov 2022 04:49:48 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 23 Nov 2022 04:49:45 -0700
Date:   Wed, 23 Nov 2022 11:49:28 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Samuel Holland <samuel@sholland.org>
CC:     Anup Patel <anup@brainfault.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: riscv: Add optional DT property
 riscv,timer-can-wake-cpu
Message-ID: <Y34IyMroJA6TfrKN@wendy>
References: <20220727114302.302201-1-apatel@ventanamicro.com>
 <20220727114302.302201-2-apatel@ventanamicro.com>
 <372e37bf-ac90-c371-ad9e-b9c18e1cc059@linaro.org>
 <CAK9=C2WjU+2cD7UZbja3TT++KCdRyWroT=50dw=fzi5mX30rcw@mail.gmail.com>
 <7a0477a0-9f0f-87d6-4070-30321745f4cc@linaro.org>
 <CAAhSdy20p5bkVanKGkGyArn94hWJhwncztnX7U+4WkN9-v7NsA@mail.gmail.com>
 <Y3zjQXqEHsaoVVvf@wendy>
 <2b329306-9706-7156-ad18-b87e4da666d9@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2b329306-9706-7156-ad18-b87e4da666d9@sholland.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Samuel,

On Tue, Nov 22, 2022 at 11:43:04PM -0600, Samuel Holland wrote:
> On 11/22/22 08:57, Conor Dooley wrote:
> >> If we add a timer DT node now
> >> then we have to deal with compatibility for existing platforms.
> > 
> > In terms of what to encode in a DT, and given the spec never says that
> > the timer interrupt must arrive during suspend, we must assume, by
> > default, that no timer events arrive during suspend.
> > 
> > We have a bunch of existing platforms that may (do?) get timer events
> > during suspend, the opposite of the proposed default behaviour.
> > 
> > I'm trying to follow the line of reasoning but I fail to see how taking
> > either the property or node approach allows us to maintain behaviour for
> > exiting platforms that that do see timer events during suspend without
> > adding *something* to the DT. No matter what we add, we've got some sort
> > of backwards compatibility issue, right?
> 
> In the absence of bugs/limitations in Linux timer code (like the ones
> you are seeing on PolarFire), the backwards compatibility issue with
> setting C3STOP by default is that non-retentive idle states will be
> ignored unless:
>  1) the DT property is added (i.e. firmware upgrade), or
>  2) some other timer driver is available.
> No other behavior should be affected.

Aye, which I think is fine, in the context of platforms supported by
upstream Linux. Right now, nothing in-tree seems to use idle states:
- the SiFive stuff is more demo than anything
- we've not really got to that point with our reference PolarFire stuff
  (although I can't speak for any customers)
- the K210 is a toy (sorry Damien!)
- the StarFive lads have moved on to the jh7110
- the D1 (although it's not an in-tree config) needs C3STOP by default,
  so its behaviour is positively affected.

If there's someone with an out-of-tree idle config, there's not really
much that we can do about it?

> On the other hand, if C3STOP defaults to off, then the backwards
> compatibility issue concerns platforms that can currently boot Linux,
> but which cannot use cpuidle because they need the flag. If they were to
> upgrade their firmware, and Linux is provided a DTB that includes both
> idle states and the property, these platforms would unexpectedly fail to
> boot. (They would enter an idle state and never wake up.)
> 
> Assuming no such platforms exist, then it would actually be better to
> default C3STOP to off.

Yeah, *assuming* no such platforms exist I agree - but the D1 is one of
such platforms (albeit in a specific configuration) so I think we have
to default C3STOP to on.

> Now, this says nothing about how the property should be named -- we can
> set C3STOP based on the absence of a property, just as easily as we can
> clear C3STOP based on the presence of a property.
> 
> > I noted the above:
> > 
> >> Since, there is no dedicated timer node, we use CPU compatible string
> >> for probing the per-CPU timer.
> > 
> > If we could rely on the cpu compatible why would we need to add a
> > dt-property anyway? Forgive my naivety here, but is the timer event in
> > suspend behaviour not a "core complex" level attribute rather than a
> > something that can be consistently determined by the cpu compatible?
> 
> I do not support using either the CPU compatible (not specific enough)
> or the board compatible (too many to list, but still not specific
> enough). Consider that not all CPUs in a system may need this property.

Yeah, I was just trying to understand where Anup was coming from and
teasing out the different bits of logic. I do not think that using the
CPU compatible is a good idea - my understanding was that how a CPU with
a given compatible is integrated into a core complex determines which
timer (or interrupt etc) is capable of what.

> > Either way, we need to figure out why enabling C3STOP is causing other
> > timer issues even when we are not in some sort of sleep state & do
> > something about that - or figure out some different way to communicate
> > the behavioural differences.
> > I would expect timers to continue working "normally" with the flag set,
> > even if how they work is subtly different?
> 
> Definitely agree here. My intention was not to affect anything other
> than cpuidle behavior.
> 
> > On a D1, with the C3STOP "feature" flag set, and it's custom timer
> > implementation unused, how do timers behave?
> 
> D1 is uniprocessor, so I build with CONFIG_SMP=n. In this case,
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=n, and thus
> __tick_broadcast_oneshot_control() returns -EBUSY, forcing
> cpuidle_enter_state() to choose a retentive idle state.

Right & that makes sense for someone building a D1 focused kernel (and
is what I do for my Nezha IIRC) but if someone builds a multiplatform
kernel you're going to end up with CONFIG_SMP=y (but I'd imagine that in
that scenario they'll have the sunxi,foo-timer's driver enabled). At
this point, it's something I should go and dig out my board for though..

I was mainly just curious if the D1 also exhibits the borked timer
behaviour that I see.

Thanks again Samuel,
Conor.

