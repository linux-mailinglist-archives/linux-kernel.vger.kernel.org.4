Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505A7636462
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238653AbiKWPr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238932AbiKWPrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:47:08 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EDE77212
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:47:07 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-142612a5454so20593517fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YM14aiVzqDo2VYlJPLD2N03qJKZNpMBQyuvIk6tlGNY=;
        b=nH/2LsxhLaH6XcmoOc6ztXPeUKL6fNyzeEK0EHZNeTahDT5YT1M09jjwAjtpcFG6kE
         4beCzlMVU1GK6oWHmUavV0x0PBTf7zZjeo4igHNs73DKK8MjYdtHJ8jXXqhXaxXZg0mb
         0gb/ucTpegyyWsLT/Cp4jQzN0zBji7NcQ3vFt4UvwXuWAhptz0GyVwUe3dlyGaRnAYea
         im8sXmP6p5QUjZFXakmbNpMQHlbx7A6IXc1gEtfrsHfN5Yal7j4ESMwXAM8ivN4+dWCN
         C8CfydgGichYuA1cwiwHlQrq+6sWoiwhrE2yGmQTK/3KiDqrQ6mGNdEWx9poNxP8usjn
         JBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YM14aiVzqDo2VYlJPLD2N03qJKZNpMBQyuvIk6tlGNY=;
        b=3VqNekavMz2JxDPT/KR6OhKlZpR/Y6M/RlM7vCCG1mwq2pFAYGxd+2h3jlQAq5dD3b
         tTv6/UN/dP5m0J0z9XQsaXmwJUJjvMrHwjEPL4MRDneFyBc9hxGKF7V2It6aVn5tHuqN
         xyaXXhMwoYu45QmEdeIhzV1mUEhYiDsdDAGz+x+79ZDHAOYz0prCHg3jCBfoeIrPfEBf
         F+XeDPzVFkKsDKMYLC+OootIH6PEKIFDJO7b1/uD+mL9AVV/Un+6r0YpJVB+qM/YBvOO
         DNIVqtEzH72DCejaKgfFF4nvX1bM+bG+pFIQtWIkjo2pLa/grvu8PHJ/DFUweienhUHd
         83Iw==
X-Gm-Message-State: ANoB5pk+JlN1D8UAoIB/haPd+67+Nc3fUiA98fi1gn/ITb0mCpB+5ciV
        4b2ZAOGyJ3rqLJkeerkq0lbRxt2ul2/hLemUdPK1Kg==
X-Google-Smtp-Source: AA0mqf6SmYaTkY15OJxApRh8xFwuKZLN4SNTXpRCUcINCNpWUALoUWNVHELpC+FPEOyvLfqKx1cJM1WikWq05upKj1g=
X-Received: by 2002:a05:6870:3b0a:b0:142:ff0f:3db with SMTP id
 gh10-20020a0568703b0a00b00142ff0f03dbmr6102336oab.17.1669218426481; Wed, 23
 Nov 2022 07:47:06 -0800 (PST)
MIME-Version: 1.0
References: <20220727114302.302201-1-apatel@ventanamicro.com>
 <20220727114302.302201-2-apatel@ventanamicro.com> <372e37bf-ac90-c371-ad9e-b9c18e1cc059@linaro.org>
 <CAK9=C2WjU+2cD7UZbja3TT++KCdRyWroT=50dw=fzi5mX30rcw@mail.gmail.com>
 <7a0477a0-9f0f-87d6-4070-30321745f4cc@linaro.org> <CAAhSdy20p5bkVanKGkGyArn94hWJhwncztnX7U+4WkN9-v7NsA@mail.gmail.com>
 <Y3zjQXqEHsaoVVvf@wendy> <Y34kM9TZ1FSqpeEB@wendy>
In-Reply-To: <Y34kM9TZ1FSqpeEB@wendy>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 23 Nov 2022 21:16:55 +0530
Message-ID: <CAK9=C2UeUhMXmbMZzS4rnhS++DfsTYTCQ4y-LVu6QgL0c64=0A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: riscv: Add optional DT property riscv,timer-can-wake-cpu
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Anup Patel <anup@brainfault.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 7:17 PM Conor Dooley <conor.dooley@microchip.com> wrote:
>
> Hey Anup,
>
> (keeping all the context since you didn't reply to this mail yet)
>
> On Tue, Nov 22, 2022 at 02:57:05PM +0000, Conor Dooley wrote:
> > Hey Anup,
> >
> > I've been meaning to get back to you on this stuff for quite a while,
> > but unfortunately I've gotten distracted with other stuff every time I
> > got close. Apologies for that :(
> >
> > On Wed, Jul 27, 2022 at 07:04:57PM +0530, Anup Patel wrote:
> > > On Wed, Jul 27, 2022 at 6:05 PM Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:
> > > >
> > > > On 27/07/2022 14:21, Anup Patel wrote:
> > > > > On Wed, Jul 27, 2022 at 5:37 PM Krzysztof Kozlowski
> > > > > <krzysztof.kozlowski@linaro.org> wrote:
> > > > >>
> > > > >> On 27/07/2022 13:43, Anup Patel wrote:
> > > > >
> > > > > Since, there is no dedicated timer node, we use CPU compatible string
> > > > > for probing the per-CPU timer.
> > > >
> > > > Next time you add a properties:
> > > > riscv,saata-can-wake-cpu
> > > > riscv,usb-can-wake-cpu
> > > > riscv,interrupt-controller-can-wake-cpu
> > > >
> > > > and so on and keep explaining that "historically" you did not define
> > > > separate nodes, so thus must be in CPU node.
> > >
> > > This is a one-of-case with RISC-V DeviceTree where we are living with
> > > the fact that there is no timer DT node. If we add a timer DT node now
> > > then we have to deal with compatibility for existing platforms.
> >
> > I don't really understand the argument here. Perhaps this made sense a
> > few months ago, but it no longer does IMO.
> >
> > We have existing platforms that interpreted the SBI spec (or perhaps
> > predated the SBI spec in the relevant form?) differently. I've pasted it
> > several times now I feel but it's relevant so pasting it here again...
> >
> > On the subject of suspend, the RISC-V SBI spec states:
> > > Request the SBI implementation to put the calling hart in a platform
> > > specific suspend (or low power) state specified by the suspend_type
> > > parameter. The hart will automatically come out of suspended state and
> > > resume normal execution when it receives an interrupt or platform
> > > specific hardware event.
> >
> > This does not cover whether a given event actually reaches the hart or
> > not, just what the hart will do if it receives an event. For the
> > implementation on the Allwinner D1, timer events are not received during
> > suspend.
> >
> > Through-out the various bits of conversation so far, I have been
> > operating on the assumption that on PolarFire SoC, and potentially other
> > SiFive based implementations, events from the RISC-V timer do reach a
> > hart during suspend.
> > I realised while writing this response that I have never actually tested
> > it - the C3STOP flag caused problems for me during regular operation &
> > not while using some DT defined sleep states.
> > I've been learning/piecing together the bits of what is happening here as
> > time goes on, so I made an assumption that may or may not be correct, and
> > I am still oh-so-far from an understanding.
> > I just took it for granted that the existing driver worked correctly for
> > "old" SiFive stuff which MPFS is based on & figured that with ~the same
> > core complex as the fu540 that we'd behave similarly.
> > Perhaps that was not a good idea & please let me know if I've been
> > barking up the wrong tree.
> >
> > Do we know definitively what is/isn't the case for any of the existing
> > platforms?
> > I can test some stuff, but it'll take some time as it's a bad week in
> > my neck of the woods.
> >
> > > If we add a timer DT node now
> > > then we have to deal with compatibility for existing platforms.
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
> >
> > I noted the above:
> >
> > > Since, there is no dedicated timer node, we use CPU compatible string
> > > for probing the per-CPU timer.
> >
> > If we could rely on the cpu compatible why would we need to add a
> > dt-property anyway? Forgive my naivety here, but is the timer event in
> > suspend behaviour not a "core complex" level attribute rather than a
> > something that can be consistently determined by the cpu compatible?
> >
> > Either way, we need to figure out why enabling C3STOP is causing other
> > timer issues even when we are not in some sort of sleep state & do
> > something about that - or figure out some different way to communicate
> > the behavioural differences.
> > I would expect timers to continue working "normally" with the flag set,
> > even if how they work is subtly different?
> > On a D1, with the C3STOP "feature" flag set, and it's custom timer
> > implementation unused, how do timers behave?
> >
> > Hopefully I've missed something blatant here Anup!
>
> So what I missed, as Anup pointed out else where, is:
>
> > me:
> > > I don't really follow. How is there a compatibility issue created by
> > > adding a new node that is not added for a new property? Both will
> > > require changes to the device tree. (You need not reply here, I am going
> > > to review the other thread, it's been on my todo list for too long. Been
> > > caught up with non-coherent stuff & our sw release cycle..)
> >
> > Adding a new timer DT node would mean, the RISC-V timer driver
> > will now be probed using the compatible to the new DT node whereas
> > the RISC-V timer driver is currently probed using CPU DT nodes.
>
> In that case, we would have to retain the ability to match against the
> "riscv". Spitballing:
> - add a new timer node
> - keep matching against "riscv"
> - look up a timer node during init w/ of_find_matching_node() that
>   contains any new timer properties
>
> I think it's unlikely that this will be the last time we have to add
> some timer properties & we should avoid doing odd things in a DT to suit
> an operating system?
>
> Would something along those lines work Anup, or am I, yet again, missing
> something?

I was already working on v3 along these lines. I will try to post a v3 this
week itself.

Regards,
Anup

>
> Thanks,
> Conor.
>
