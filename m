Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9131863A766
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiK1Lw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiK1Lw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:52:26 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2261A17E38
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:52:25 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id k206so11656913ybk.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KbUuMHeR4QXwVkyC8KXqnqBc4Pew2f6yNEVpnNUgiGc=;
        b=YQ840ynkGpNMPeiotrfzusH6mH6FLd+ci3EmliELBNEcQbvMv40Fap0bcq6ZnTkGnB
         9fJmInqsDpW0CmkH7hbhF3S4Xk0y6ZMnCynia3OmDjh9/pCo+74rA7eHZJw/Ybr4ykZN
         +penn91lvzW/rVCuahPAUPQRH6Y9VsO0WQTqrB0YoyuDQAsoNKUlitTBUHp1SlvGgaVa
         LNlfh3BRmaAsUKQse6HsikSgFxeGKVSzjIwohXSkukjdDfaefZ4qneeiRz5zVzMBFUsq
         TUhwSFOIlVyPPJXGPYoN+I5UnF+pDEPcw3JMv1OPTUC6BVXIB7Z6qHRGAmywIaVSkvOY
         ptmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KbUuMHeR4QXwVkyC8KXqnqBc4Pew2f6yNEVpnNUgiGc=;
        b=h5QM7AyhYYA20nXy5NuKL8B2Xi8BlNUKVM+2dlJUagkUvgJPJwyZbcsCGvdHXvAS/O
         gSbU10ZomSellwTQdytBlORmvDVKVDrNHhWgGqhkEn8yUQgBqPpVvcfq/GOB91Yu02wh
         iBKmWA9mmmEwWWIgOfEQUzLhoENcfjYeuBxFnF80FfrVgq4Rbws3kystM1O87Y54EG/z
         b9fKmJ8ldYskS1qISs/8rv1QOFgyboWH5g1r4qeE1GoJQb6a0SBgCFCEx3CwkWPFiAU+
         aPCAcbKdMxH1ptzAxiUGCmHdrXvq01rFluGAohCQU4xKYfp7mlmwpLOT6VPpHoI8r8RN
         jFXw==
X-Gm-Message-State: ANoB5pnj/Fq0lJhWNl4c29x2/XwDg0gIOWZEATld492pZ9h/QCXj2xCx
        uJPu1GKr3NYj3alD34+/DF3f7/xXcCwTWOwRPEiWeQ==
X-Google-Smtp-Source: AA0mqf7hA0Hjz5xaZr+VJE/nFlbpmH1QrwRikxzKaln0H9Muro5e9X9UcBRF4wUx26kYHqFJwcm9FaFbqDGz0FFi0co=
X-Received: by 2002:a25:910c:0:b0:6dd:ac4a:65e1 with SMTP id
 v12-20020a25910c000000b006ddac4a65e1mr48256861ybl.288.1669636344317; Mon, 28
 Nov 2022 03:52:24 -0800 (PST)
MIME-Version: 1.0
References: <20221120154625.57095-1-y.oudjana@protonmail.com>
 <795deac4-71fe-d40b-a3b6-855eb3875ad1@linaro.org> <1H1PLR.S9UFOHIJCU6S@gmail.com>
 <1419e9da-98f7-c477-9f07-4b54e82be4c4@linaro.org> <CAA8EJpor_LnxLGYy25i-D6RBBO+-G9MsVWw=Qfm1Emp88KRJzQ@mail.gmail.com>
 <fdbdd905-c233-cf76-c16f-92fb59eb35ef@linaro.org>
In-Reply-To: <fdbdd905-c233-cf76-c16f-92fb59eb35ef@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 28 Nov 2022 13:52:13 +0200
Message-ID: <CAA8EJpo0sRMdDYRV30oC2dVz35dnbiKAx9oEC_9bNcF76eG0VA@mail.gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: power: supply: Add DT schema for
 Qualcomm SMBCHG
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alejandro Tafalla <atafalla@dnyon.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 28 Nov 2022 at 13:39, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/11/2022 14:30, Dmitry Baryshkov wrote:
> > Hi,
> >
> > On Mon, 21 Nov 2022 at 19:07, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 21/11/2022 11:36, Yassine Oudjana wrote:
> >>>
> >>> On Mon, Nov 21 2022 at 09:26:59 +01:00:00, Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>> On 20/11/2022 16:46, Yassine Oudjana wrote:
> >>>>>>>  +  interrupts:
> >>>>>>>  +    items:
> >>>>>>>  +      - description: Charger error
> >>>>>>>  +      - description: Charger inhibited
> >>>>>>>  +      - description: Charger precharge safety timer timeout
> >>>>>>>  +      - description: Charger charge safety timer timeout
> >>>>>>>  +      - description: Charger pre to fast charging switch
> >>>>>>> threshold reached
> >>>>>>>  +      - description: Charger recharge threshold reached
> >>>>>>>  +      - description: Charger taper threshold reached
> >>>>>>>  +      - description: Charger charge termination threshold reached
> >>>>>>>  +      - description: Battery hot
> >>>>>>>  +      - description: Battery warm
> >>>>>>>  +      - description: Battery cold
> >>>>>>>  +      - description: Battery cool
> >>>>>>>  +      - description: Battery overvoltage
> >>>>>>>  +      - description: Battery low
> >>>>>>>  +      - description: Battery missing
> >>>>>>>  +      - description: Battery thermistor missing # unconfirmed
> >>>>>>>  +      - description: USB input undervolt
> >>>>>>>  +      - description: USB input overvolt
> >>>>>>>  +      - description: USB input source detected
> >>>>>>>  +      - description: OTG regulator failure
> >>>>>>>  +      - description: OTG regulator overcurrent
> >>>>>>>  +      - description: Automatic input current limiting done
> >>>>>>>  +      - description: USB ID pin changed
> >>>>>>>  +      - description: DC input undervolt
> >>>>>>>  +      - description: DC input overvolt
> >>>>>>>  +      - description: Power OK
> >>>>>>>  +      - description: Temperature shutdown
> >>>>>>>  +      - description: Watchdog timeout
> >>>>>>>  +      - description: Flash failure
> >>>>>>>  +      - description: OTST2 # unknown
> >>>>>>>  +      - description: OTST3 # unknown
> >>>>>>
> >>>>>>  It seems you listed register interrupts, not physical pins. This
> >>>>>> should
> >>>>>>  be interrupt lines.
> >>>>>
> >>>>>  I'm not sure what I'm supposed to do here. I couldn't find an
> >>>>> interrupt-lines
> >>>>>  property used anywhere so that's not what you meant, right?
> >>>>
> >>>> Are these physical interrupt lines this device has, register offsets
> >>>> or
> >>>> virtual interrupts (e.g. passed via irq_chip)? Definitely not the
> >>>> first
> >>>> and rather offsets for qpnpint_irq_domain_translate. Devicetree is not
> >>>> for describing register layout of devices. IOW, register layout does
> >>>> not
> >>>> change on different boards, because the device is exactly the same, so
> >>>> there is no point to put it into DTS.
> >>>>
> >>>
> >>> So how would I describe the interrupts then? Or if you are saying I
> >>> shouldn't have these interrupts in DT at all, how would I get them and
> >>> register handlers for them in the driver? the PMIC arbiter takes 4
> >>> interrupt cells, 3 of which are these offsets specifying the peripheral
> >>> and interrupt. All other PMIC peripherals currently described in DT
> >>> (examples being qcom,pm8916-wcd-analog-codec, qcom,pm8941-pwrkey and
> >>> qcom-wled) have their interrupts (if any) described this way, with the
> >>> only exceptions perhaps being the GPIO and MPP controllers which are
> >>> themselves interrupt controllers. Changing the way PMIC peripheral
> >>> interrupts are described would require changing PMIC arbiter bindings
> >>> and code which I believe is out of the scope of this patch series.
> >>
> >> I don't think this would touch PMIC arbiter bindings, rather the PMIC
> >> itself. Usually complex devices (like PMICs) have one few physical
> >> interrupt lines and many registers related to some specific interrupts.
> >> For example:
> >> 1. One IRQ line,
> >> 2. Register with bits for overvoltage, undervoltage, vharger error etc.
> >>
> >> Now how the MFD child device accesses them. Since this is strictly
> >> related to hardware programming model, it's not something you put to
> >> Devicetree. Instead parent device (PMIC) registers IRQ chip for its one
> >> interrupt line with several Linux (or virtual) interrupts. The children
> >> then just get a virtual IRQ from the parent (PMIC) and setup a
> >> handler(s) for them.
> >
> > Unfortunately this is not how SPMI PMICs work (at least on the
> > Qualcomm platforms). Access to interrupt registers is handled via the
> > SPMI bus arbiter writes, not through the GPIO pin or typical spmi's
> > bus interface (in the other words, not through the PMIC's SPMI
> > regmap).
>
> I am not sure how this is related... Just because they do not use same
> regmap/interface does not mean that child device should have register
> bits as interrupt sources. Do you model I2C PMICs devices the same way?
> No. They get the interrupts from the parent and how the parent handles
> them (same or different regmap) is separate problem.

For i2c PMICs it's typically not the case, since the interrupt is OOB.
It is an external GPIO pin, as you have described previously.

For Qcom SPMI PMIC the interrupts are really handled by the SPMI host
controller (arbieter). So the DT really represents the hardware.

>
> The charger node does not make SPMI bus as interrupt parent, so these
> interrupts are going to the SPMI PMIC don't they? or is it mistake in
> DTS - lack of interrupt-parent?

I thought that with the lack of the interrupt-parent, the OS will
traverse the tree up until it finds one. Is it so?

> > I guess we can add an intermediate irq chip to automatically
> > handle the USID, etc. However I doubt that it will really bring a lot
> > in our case.
>
> The charger node defines all interrupts with SID=2, which is also not
> really correct. The parent device is SID=2. The child - does not matter.
> DT is a tree for some reason...

Yes, I agree with you. The bindings do not look ideal here. I was
trying to point out that this is not a problem with the smbchg device
only. Other Qcom SPMI PMIC devices also use exactly the same approach
(except gpio and mpps).
So, we can either:
- Continue using the current approach
- Rework pmic driver to provide an intermediate IRQ domain. This would
require finding a way to ping SPMI ARB's IRQ registers from PMIC
controller (via callbacks, via extra interrupt translation, etc).

-- 
With best wishes
Dmitry
