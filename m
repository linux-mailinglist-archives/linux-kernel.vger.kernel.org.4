Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E455F633DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbiKVNan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbiKVNaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:30:39 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B54654F4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:30:35 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id e76so8549701yba.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3u1XUALavBeR1kKMHVM25AVpNdjJ1fTh/8LVQ3pBSzA=;
        b=F9q4drH+N1IMCom8ENOvIuU/6OCrrvFECfe5ScOD77fy2QwKAMMxA7EE6TKqT6530F
         6nVxgo5aulAAf2ZrYhuBo85xMfsvLOcbefPxASO07ofisIfgC+TtyUbafZXMN6/Wng7z
         TGbjSdoURgZWqEPBx/hqTTCOIjhT/A3Ln5BpM3NpiHauoJwVZXMhCFtmR5rWsbElSFty
         Qf0AtzT33ML4bIhCbGPUDSL13uA80Tfv6XWhJf2wX9Kg713AQLgqm0w0LDvAn9IaNsr4
         heAkQ0FiTsh4B1f1WF82/rvezusxEiStHkHoRmAn5P0QUTTxgwaqo6kyUShLBjkrYhwz
         x0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3u1XUALavBeR1kKMHVM25AVpNdjJ1fTh/8LVQ3pBSzA=;
        b=d4QTweB1ZCt7NMCLD9TNQ8MtwTbsO4NTkfJSOYx1z41uh+qNaEpv1e8AaqGyBNkkxM
         f+v3D64YgAde+V8xFpOeE91ERVl3UEKbFNA+6ulxi659jZC7DGtUvD6BW6VBph98nT6R
         9qIfazHOBxnaAkXJ9U8HDoWQDDnU0bHUh35uU/hIKDJVR0C/vwliyFaOZ3gpzdLyluMJ
         9U95hhx6M/m7FxFqzWtpmYJP7QFTTDeaIYi6jAgAXo/2AU2eCOZRd6seKXg2iePgzXTr
         bGTObWBisg9N7wZ8wfYm8SW038HudYh7wFm49MZkHycoIjPbLUcLNsjmqTm883q7QTvr
         hqBQ==
X-Gm-Message-State: ANoB5pkWYNGaGaINS3ewS7ju3l7EC0hyHkdVSQVovypDhPvbmMoNMs3a
        j0WWB3vWnVkz8MB+U/4MW4fXrzNL92IdEiA7VGd9Zw==
X-Google-Smtp-Source: AA0mqf5bV7d8p5GauuDP4eZ44mV+c9M00UQOg+30Bt/xSqVCkfos0pcbeU+IN+5jK9Mr48pUHWNEzE7YWUNQ3XsXAsE=
X-Received: by 2002:a25:510:0:b0:6d2:e45c:71c0 with SMTP id
 16-20020a250510000000b006d2e45c71c0mr3906010ybf.153.1669123834422; Tue, 22
 Nov 2022 05:30:34 -0800 (PST)
MIME-Version: 1.0
References: <20221120154625.57095-1-y.oudjana@protonmail.com>
 <795deac4-71fe-d40b-a3b6-855eb3875ad1@linaro.org> <1H1PLR.S9UFOHIJCU6S@gmail.com>
 <1419e9da-98f7-c477-9f07-4b54e82be4c4@linaro.org>
In-Reply-To: <1419e9da-98f7-c477-9f07-4b54e82be4c4@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 22 Nov 2022 15:30:23 +0200
Message-ID: <CAA8EJpor_LnxLGYy25i-D6RBBO+-G9MsVWw=Qfm1Emp88KRJzQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 21 Nov 2022 at 19:07, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/11/2022 11:36, Yassine Oudjana wrote:
> >
> > On Mon, Nov 21 2022 at 09:26:59 +01:00:00, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >> On 20/11/2022 16:46, Yassine Oudjana wrote:
> >>>>>  +  interrupts:
> >>>>>  +    items:
> >>>>>  +      - description: Charger error
> >>>>>  +      - description: Charger inhibited
> >>>>>  +      - description: Charger precharge safety timer timeout
> >>>>>  +      - description: Charger charge safety timer timeout
> >>>>>  +      - description: Charger pre to fast charging switch
> >>>>> threshold reached
> >>>>>  +      - description: Charger recharge threshold reached
> >>>>>  +      - description: Charger taper threshold reached
> >>>>>  +      - description: Charger charge termination threshold reached
> >>>>>  +      - description: Battery hot
> >>>>>  +      - description: Battery warm
> >>>>>  +      - description: Battery cold
> >>>>>  +      - description: Battery cool
> >>>>>  +      - description: Battery overvoltage
> >>>>>  +      - description: Battery low
> >>>>>  +      - description: Battery missing
> >>>>>  +      - description: Battery thermistor missing # unconfirmed
> >>>>>  +      - description: USB input undervolt
> >>>>>  +      - description: USB input overvolt
> >>>>>  +      - description: USB input source detected
> >>>>>  +      - description: OTG regulator failure
> >>>>>  +      - description: OTG regulator overcurrent
> >>>>>  +      - description: Automatic input current limiting done
> >>>>>  +      - description: USB ID pin changed
> >>>>>  +      - description: DC input undervolt
> >>>>>  +      - description: DC input overvolt
> >>>>>  +      - description: Power OK
> >>>>>  +      - description: Temperature shutdown
> >>>>>  +      - description: Watchdog timeout
> >>>>>  +      - description: Flash failure
> >>>>>  +      - description: OTST2 # unknown
> >>>>>  +      - description: OTST3 # unknown
> >>>>
> >>>>  It seems you listed register interrupts, not physical pins. This
> >>>> should
> >>>>  be interrupt lines.
> >>>
> >>>  I'm not sure what I'm supposed to do here. I couldn't find an
> >>> interrupt-lines
> >>>  property used anywhere so that's not what you meant, right?
> >>
> >> Are these physical interrupt lines this device has, register offsets
> >> or
> >> virtual interrupts (e.g. passed via irq_chip)? Definitely not the
> >> first
> >> and rather offsets for qpnpint_irq_domain_translate. Devicetree is not
> >> for describing register layout of devices. IOW, register layout does
> >> not
> >> change on different boards, because the device is exactly the same, so
> >> there is no point to put it into DTS.
> >>
> >
> > So how would I describe the interrupts then? Or if you are saying I
> > shouldn't have these interrupts in DT at all, how would I get them and
> > register handlers for them in the driver? the PMIC arbiter takes 4
> > interrupt cells, 3 of which are these offsets specifying the peripheral
> > and interrupt. All other PMIC peripherals currently described in DT
> > (examples being qcom,pm8916-wcd-analog-codec, qcom,pm8941-pwrkey and
> > qcom-wled) have their interrupts (if any) described this way, with the
> > only exceptions perhaps being the GPIO and MPP controllers which are
> > themselves interrupt controllers. Changing the way PMIC peripheral
> > interrupts are described would require changing PMIC arbiter bindings
> > and code which I believe is out of the scope of this patch series.
>
> I don't think this would touch PMIC arbiter bindings, rather the PMIC
> itself. Usually complex devices (like PMICs) have one few physical
> interrupt lines and many registers related to some specific interrupts.
> For example:
> 1. One IRQ line,
> 2. Register with bits for overvoltage, undervoltage, vharger error etc.
>
> Now how the MFD child device accesses them. Since this is strictly
> related to hardware programming model, it's not something you put to
> Devicetree. Instead parent device (PMIC) registers IRQ chip for its one
> interrupt line with several Linux (or virtual) interrupts. The children
> then just get a virtual IRQ from the parent (PMIC) and setup a
> handler(s) for them.

Unfortunately this is not how SPMI PMICs work (at least on the
Qualcomm platforms). Access to interrupt registers is handled via the
SPMI bus arbiter writes, not through the GPIO pin or typical spmi's
bus interface (in the other words, not through the PMIC's SPMI
regmap). I guess we can add an intermediate irq chip to automatically
handle the USID, etc. However I doubt that it will really bring a lot
in our case.

> You will find some examples for this, just grep for regmap_irq_get_virq,
> for the drivers using regmap_irq_chip (or irq_create_mapping for
> non-regmaps).
>
> Since it is *one* device - the PMIC and its child like charger - the
> register layout is fixed thus I think these virtual (or Linux)
> interrupts are fixed as well.
>
> I don't know why Qualcomm PMIC for SPMI is done differently.
>
> Best regards,
> Krzysztof
>


-- 
With best wishes
Dmitry
