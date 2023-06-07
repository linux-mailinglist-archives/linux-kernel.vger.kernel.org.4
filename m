Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C16B72562B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239283AbjFGHom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239315AbjFGHoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:44:08 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862AA26A9;
        Wed,  7 Jun 2023 00:41:10 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6b28eefb49cso1537682a34.0;
        Wed, 07 Jun 2023 00:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686123670; x=1688715670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3KrlRfv/7QYY0HE+ZUgaLav43RjvHqvaQRliHdP3rA=;
        b=f6ychmbJLaVQQy9KICAzAtL+MMzS88bDdlfqsVIjSQ+WJJkZMEgp7y871NupB1e3g9
         KS+l5rOYNhdMknvdNoTOdGpOH6CdMfa+mZMZBrnPCwwFYZSIgfI2gppZcgByJdIYoSyT
         AHm6QZG7dRGkO0pwhyFgXBFMQXTz9II925qu021RuoE/r3KjZjBsybA17D14NUJSTVy4
         gXcjZtuLlNdha+0YWVxPu9n8MsUxFvCiB3mLTPlr9+r1X2z1RwY9jFOyOC8q0qs+Iu9g
         SEQGv45wTMAVcOrgQYB6eLy+FE2rlpEfouqXKWIBaLyg1w0lwHywkoyMz7Zn7wtlCjKN
         maAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686123670; x=1688715670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3KrlRfv/7QYY0HE+ZUgaLav43RjvHqvaQRliHdP3rA=;
        b=J/JPkpfW8gHEgaOqEWCYofp/2nVaowFsEiWTDbm9FlL5Qkhm+PzM06lm57U6vUPl/P
         6CPKRaPmiEoO3VYohO6sfH116B1m8M7Rbgfzw+WNTzix0ufgsX08YrDPSWA7tFGlL3gE
         e6HJ+67VCVJ6bI7On4aU0MSvRpzmdvzCSCjCBZL6yryvyPwGT/tlNPhLhvW7EvNVMEO/
         VpPRPF/04FwMBHdA8XHsXj4xHxSfuU31bb5ZlQ2EvIGxQcF9MqgKQav8jAYB7hIbPorN
         ER7n0y0XL6h5Frgnvf3DjwXw22fcJAPa5yQVWivjbtZ7C9zbGts6X1GMOmteTqwFBZ1Y
         LbiQ==
X-Gm-Message-State: AC+VfDwOdC+/LVge4Jnw8XDSJwxG77sGEmTIFr0aG9I3psoo+JCfF5Dh
        HhEzdxb/qAMtn5J3Ppx9UT/qZ1k8rYTjUC0yAB4=
X-Google-Smtp-Source: ACHHUZ6eslG51DG5L/MMouHVxXGT0Qgo5TYpWX1p5wJFuuUhJkDe94ee9NKRsEmUXQKB4xD16+w2aiEcx+9MNylaMCo=
X-Received: by 2002:a05:6830:442:b0:6b2:9462:570e with SMTP id
 d2-20020a056830044200b006b29462570emr2520478otc.22.1686123669681; Wed, 07 Jun
 2023 00:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230530075311.400686-1-fl.scratchpad@gmail.com>
 <20230530075311.400686-6-fl.scratchpad@gmail.com> <20230530-cannabis-headstone-883c5b891dd3@spud>
 <CAPJMGm4=sRQGPmVi8NjAVvOVrr8s2By6PO8kKRKZt3W0FR9j-Q@mail.gmail.com>
 <5d65b644-9b79-d232-d0d0-d2772325eef5@linaro.org> <CAPJMGm6T_x9Oocdmbrhi879QqZSd812LxJP=J554UbH9k9_LBw@mail.gmail.com>
 <01dae949-4018-37f4-2dd9-cbecbd65b9a1@linaro.org>
In-Reply-To: <01dae949-4018-37f4-2dd9-cbecbd65b9a1@linaro.org>
From:   Fabrizio Lamarque <fl.scratchpad@gmail.com>
Date:   Wed, 7 Jun 2023 09:40:58 +0200
Message-ID: <CAPJMGm6T7ckH-W_DZu+7ySp3pOuKpe-MZPnvcfOz1wBJyG-pJg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] dt-bindings: iio: ad7192: Allow selection of clock modes
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor@kernel.org>, jic23@kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 9:24=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 31/05/2023 11:40, Fabrizio Lamarque wrote:
> > On Wed, May 31, 2023 at 9:14=E2=80=AFAM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 31/05/2023 08:59, Fabrizio Lamarque wrote:
> >>> On Tue, May 30, 2023 at 7:22=E2=80=AFPM Conor Dooley <conor@kernel.or=
g> wrote:
> >>>>
> >>>> On Tue, May 30, 2023 at 09:53:11AM +0200, fl.scratchpad@gmail.com wr=
ote:
> >>>>> From: Fabrizio Lamarque <fl.scratchpad@gmail.com>
> >>>>>
> >>>>> AD7192 supports external clock sources, generated by a digital cloc=
k
> >>>>> source or a crystal oscillator, or internally generated clock optio=
n
> >>>>> without external components.
> >>>>>
> >>>>> Describe choice between internal and external clock, crystal or ext=
ernal
> >>>>> oscillator, and internal clock output enable.
> >>>>>
> >>>>> Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
> >>>>> ---
> >>>>>  .../bindings/iio/adc/adi,ad7192.yaml          | 27 +++++++++++++++=
+---
> >>>>>  1 file changed, 24 insertions(+), 3 deletions(-)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.y=
aml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> >>>>> index 16def2985ab4..f7ecfd65ad80 100644
> >>>>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> >>>>> @@ -32,7 +32,8 @@ properties:
> >>>>>
> >>>>>    clocks:
> >>>>>      maxItems: 1
> >>>>> -    description: phandle to the master clock (mclk)
> >>>>> +    description: |
> >>>>> +      Master clock (mclk). If not set, internal clock is used.
> >>>>>
> >>>>>    clock-names:
> >>>>>      items:
> >>>>> @@ -50,6 +51,17 @@ properties:
> >>>>>    vref-supply:
> >>>>>      description: VRef voltage supply
> >>>>>
> >>>>> +  adi,clock-xtal:
> >>>>> +    description: |
> >>>>> +      Select whether an external crystal oscillator or an external
> >>>>> +      clock is applied as master (mclk) clock.
> >>>>> +    type: boolean
> >>>>
> >>>> Am I being daft, or are these the same thing? If they are not, and u=
se
> >>>> different input pins, I think it should be explained as it not clear=
.
> >>>> Could you explain why we actually care that the source is a xtal ver=
sus
> >>>> it being mclk, and why just having master clock is not sufficient?
> >>>
> >>> I may revise the description as follows. Feel free to add your sugges=
tions
> >>> in case it is still not clear enough.
> >>>
> >>> "Select whether an external crystal oscillator between MCLK1 and MCLK=
2 or
> >>> an external CMOS-compatible clock on MCLK2 is used as master clock".
> >>>
> >>> This is used to properly set CLK0 and CLK1 bits in the MODE register.
> >>> I guess most applications would use an external crystal or internal c=
lock.
> >>> The external digital clock would allow synchronization of multiple AD=
Cs,
> >>
> >> Description confuses me. Why would it matter what type of clock you ha=
ve
> >> as input - external crystal oscillator or external CMOS-compatible
> >> clock? Later you refer to "internal", so maybe you meant here also
> >> internal for one of the options?
> >
> > The AD7192 needs to be configured according to the type of external
> > clock that is
> > applied on MCLK1/MCLK2 pins in order to activate the correct circuitry.
> >
> > Here are some citations from the datasheet:
> >
> > MCLK2 pin description:
> > "The AD7192 has an internal 4.92 MHz clock. This internal clock can be
> > made available
> > on the MCLK2 pin. The clock for the AD7192 can be provided externally
> > also in the form
> > of a crystal or external clock. A crystal can be tied across the MCLK1
> > and MCLK2 pins.
> > Alternatively, the MCLK2 pin can be driven with a CMOS-compatible clock=
 and the
> > MCLK1 pin left unconnected."
> >
> > Each of these clock modes have to be configured via AD7192 mode registe=
r.
> > (Clock source configuration bits, mode register, CLK0 and CLK1).
> > Here is their description from datasheet:
> >
> > "Either the on-chip 4.92 MHz clock or an external clock can be used.
> > The ability to
> > use an external clock allows several AD7192 devices to be synchronized.=
 Also,
> > 50 Hz/60 Hz rejection is improved when an accurate external clock
> > drives the AD7192."
> >
> > The choice between internal clock, external crystal oscillator or
> > external CMOS digital
> > clock is a decision of the HW designer driven by noise rejection,
> > synchronization, and
> > cost requirements.
> >
> > If possible, I kindly ask you suggestions on how to adjust the descript=
ion
> > so that it would be cleaner.
>
> It's fine. I missed that part that first option requires feeding the
> clock through two pins ("and").

Thank you once again.
I've reworded the commit message, removed the
adi,int-clock-output-enable option and clarified the adi,clock-xtal
entry.

This would be the new commit message:

AD7192 can be clocked from either:
 - Internal clock
 - CMOS-compatible clock on MCLK2
 - Crystal oscillator on MCLK1 and MCLK2

Each of these modes have to be configured via AD7192 mode register.
Describe choice between these clock modes.


And this is the new description for adi,clock-xtal:

This bit sets external clock mode. When set, master clock is sourced from
a crystal connected from MCLK1 to MCLK2.
When cleared, a CMOS-compatible clock source is expected on MCLK2.


Is this description cleaner? If possible, I kindly ask you for feedback bef=
ore
posting a v4 (with only patch 3/5 and 5/5 since the others have
already been applied).

Best regards,
Fabrizio Lamarque
