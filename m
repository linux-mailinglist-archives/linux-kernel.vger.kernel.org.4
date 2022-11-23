Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED791636084
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237886AbiKWNx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbiKWNws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:52:48 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47C613F6F;
        Wed, 23 Nov 2022 05:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669211222; x=1700747222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=liuuYffao1svpZRieQS14LiWSlQPrdAQn3xHBamy8s8=;
  b=f4Y+EtxJ6omvvEpp+rOJRdgKB9/7Swxbu4jJpkI3ORijZf++5ecdYGmE
   S/UiXDpLOrXKS7kqR7VEfgxYLmx6sO4LYvYHvqp1lF160fbYaGqqCiumD
   VmZo5awTFZD9Qww6aTT6B2060rlDQSax3iNtF0TcMwJmHphHguyhIlytd
   sqPsxHm0gjTUG90GT4N5Jb03hwBwaDTKpQ9L9g7vNObAZFXWGsTJpLnf1
   XUeGNy0yyR0/of/OQC6l/2rOZX/J/BuQpULPpRz2FCS93ochyOCAkLRBW
   rBZ/Q+beiUJxk+lgQT16pOh3wmU+0xACuigEA7MfmYAX64A+vUecK/+NN
   g==;
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="190245048"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Nov 2022 06:47:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 23 Nov 2022 06:46:47 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 23 Nov 2022 06:46:45 -0700
Date:   Wed, 23 Nov 2022 13:46:27 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Anup Patel <anup@brainfault.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: riscv: Add optional DT property
 riscv,timer-can-wake-cpu
Message-ID: <Y34kM9TZ1FSqpeEB@wendy>
References: <20220727114302.302201-1-apatel@ventanamicro.com>
 <20220727114302.302201-2-apatel@ventanamicro.com>
 <372e37bf-ac90-c371-ad9e-b9c18e1cc059@linaro.org>
 <CAK9=C2WjU+2cD7UZbja3TT++KCdRyWroT=50dw=fzi5mX30rcw@mail.gmail.com>
 <7a0477a0-9f0f-87d6-4070-30321745f4cc@linaro.org>
 <CAAhSdy20p5bkVanKGkGyArn94hWJhwncztnX7U+4WkN9-v7NsA@mail.gmail.com>
 <Y3zjQXqEHsaoVVvf@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y3zjQXqEHsaoVVvf@wendy>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Anup,

(keeping all the context since you didn't reply to this mail yet)

On Tue, Nov 22, 2022 at 02:57:05PM +0000, Conor Dooley wrote:
> Hey Anup,
> 
> I've been meaning to get back to you on this stuff for quite a while,
> but unfortunately I've gotten distracted with other stuff every time I
> got close. Apologies for that :(
> 
> On Wed, Jul 27, 2022 at 07:04:57PM +0530, Anup Patel wrote:
> > On Wed, Jul 27, 2022 at 6:05 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > >
> > > On 27/07/2022 14:21, Anup Patel wrote:
> > > > On Wed, Jul 27, 2022 at 5:37 PM Krzysztof Kozlowski
> > > > <krzysztof.kozlowski@linaro.org> wrote:
> > > >>
> > > >> On 27/07/2022 13:43, Anup Patel wrote:
> > > >
> > > > Since, there is no dedicated timer node, we use CPU compatible string
> > > > for probing the per-CPU timer.
> > >
> > > Next time you add a properties:
> > > riscv,saata-can-wake-cpu
> > > riscv,usb-can-wake-cpu
> > > riscv,interrupt-controller-can-wake-cpu
> > >
> > > and so on and keep explaining that "historically" you did not define
> > > separate nodes, so thus must be in CPU node.
> > 
> > This is a one-of-case with RISC-V DeviceTree where we are living with
> > the fact that there is no timer DT node. If we add a timer DT node now
> > then we have to deal with compatibility for existing platforms.
> 
> I don't really understand the argument here. Perhaps this made sense a
> few months ago, but it no longer does IMO.
> 
> We have existing platforms that interpreted the SBI spec (or perhaps
> predated the SBI spec in the relevant form?) differently. I've pasted it
> several times now I feel but it's relevant so pasting it here again...
> 
> On the subject of suspend, the RISC-V SBI spec states:
> > Request the SBI implementation to put the calling hart in a platform
> > specific suspend (or low power) state specified by the suspend_type
> > parameter. The hart will automatically come out of suspended state and
> > resume normal execution when it receives an interrupt or platform
> > specific hardware event.
> 
> This does not cover whether a given event actually reaches the hart or
> not, just what the hart will do if it receives an event. For the
> implementation on the Allwinner D1, timer events are not received during
> suspend.
> 
> Through-out the various bits of conversation so far, I have been
> operating on the assumption that on PolarFire SoC, and potentially other
> SiFive based implementations, events from the RISC-V timer do reach a
> hart during suspend.
> I realised while writing this response that I have never actually tested
> it - the C3STOP flag caused problems for me during regular operation &
> not while using some DT defined sleep states.
> I've been learning/piecing together the bits of what is happening here as
> time goes on, so I made an assumption that may or may not be correct, and
> I am still oh-so-far from an understanding.
> I just took it for granted that the existing driver worked correctly for
> "old" SiFive stuff which MPFS is based on & figured that with ~the same
> core complex as the fu540 that we'd behave similarly.
> Perhaps that was not a good idea & please let me know if I've been
> barking up the wrong tree.
> 
> Do we know definitively what is/isn't the case for any of the existing
> platforms?
> I can test some stuff, but it'll take some time as it's a bad week in
> my neck of the woods.
> 
> > If we add a timer DT node now
> > then we have to deal with compatibility for existing platforms.
> 
> In terms of what to encode in a DT, and given the spec never says that
> the timer interrupt must arrive during suspend, we must assume, by
> default, that no timer events arrive during suspend.
> 
> We have a bunch of existing platforms that may (do?) get timer events
> during suspend, the opposite of the proposed default behaviour.
> 
> I'm trying to follow the line of reasoning but I fail to see how taking
> either the property or node approach allows us to maintain behaviour for
> exiting platforms that that do see timer events during suspend without
> adding *something* to the DT. No matter what we add, we've got some sort
> of backwards compatibility issue, right?
> 
> I noted the above:
> 
> > Since, there is no dedicated timer node, we use CPU compatible string
> > for probing the per-CPU timer.
> 
> If we could rely on the cpu compatible why would we need to add a
> dt-property anyway? Forgive my naivety here, but is the timer event in
> suspend behaviour not a "core complex" level attribute rather than a
> something that can be consistently determined by the cpu compatible?
> 
> Either way, we need to figure out why enabling C3STOP is causing other
> timer issues even when we are not in some sort of sleep state & do
> something about that - or figure out some different way to communicate
> the behavioural differences.
> I would expect timers to continue working "normally" with the flag set,
> even if how they work is subtly different?
> On a D1, with the C3STOP "feature" flag set, and it's custom timer
> implementation unused, how do timers behave?
> 
> Hopefully I've missed something blatant here Anup!

So what I missed, as Anup pointed out else where, is:

> me:
> > I don't really follow. How is there a compatibility issue created by
> > adding a new node that is not added for a new property? Both will
> > require changes to the device tree. (You need not reply here, I am going
> > to review the other thread, it's been on my todo list for too long. Been
> > caught up with non-coherent stuff & our sw release cycle..)
> 
> Adding a new timer DT node would mean, the RISC-V timer driver
> will now be probed using the compatible to the new DT node whereas
> the RISC-V timer driver is currently probed using CPU DT nodes.

In that case, we would have to retain the ability to match against the
"riscv". Spitballing:
- add a new timer node
- keep matching against "riscv"
- look up a timer node during init w/ of_find_matching_node() that
  contains any new timer properties

I think it's unlikely that this will be the last time we have to add
some timer properties & we should avoid doing odd things in a DT to suit
an operating system?

Would something along those lines work Anup, or am I, yet again, missing
something?

Thanks,
Conor.

