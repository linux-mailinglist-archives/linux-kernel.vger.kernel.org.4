Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BC7717C31
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbjEaJkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbjEaJkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:40:25 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA04180;
        Wed, 31 May 2023 02:40:20 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-38c35975545so3890078b6e.1;
        Wed, 31 May 2023 02:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685526020; x=1688118020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coRLi+/G9QXU7tHORbRmPyNXE20ZC1wU2n0kAm+p0Xw=;
        b=fwAkPCxk6TUTIfTN/rW/VQD4jk+gsrwkPxDqK75unzLWd7TRfSVDbyO0kH/BeYyBMg
         ejbJViWddFZQ+GqkjBLvqw66Je0wYyF/8kj5uX4Cp4EigPcdBS49DLQPxxsatonqyi4w
         KnSgR6olMfJTC+TgLUoy5WoSqWuekFM+XJ/lH3Sio8Wp5L8jBHnXtyXecFFce3a0bK9/
         TQCKuC59pEvfd6Swi/5DxDBG+UnVTEZZsN7sHVLrp80VTuEzP6oer4iq5Npsqsa+QRmE
         oTdPc05sOWzTlkHIXhaUDnAQw5iZyioYJRAZDT5qVU/ITQMVc9pe5XwY5+TLasuNsuNr
         w0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685526020; x=1688118020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=coRLi+/G9QXU7tHORbRmPyNXE20ZC1wU2n0kAm+p0Xw=;
        b=ReEuP8cU+uxNUpN0ZxnptJTcKRQwsl2drJZSdnhnGL20qzHaHIDvH1082lrC2mRMoX
         1F7OTYtCZwBuC8EjuKeiOiPSI3QJZfA02rOWq1M2VkAfHosozZYUt8STvt+2dYbJDfMV
         J73jMLwWyBeZ162+xt8GDtzAh31lLxkOpjs/eCzVbEcrFVgyQ8+5Bjg4bfbBZm2XZFhN
         qyY621uzxbcnGYrx4w73udacP2ZmHH0xhwKkAMO0zE53Furbu+MjxrOCPQ4dRFEv+eri
         gqiLLlcTG6DWKkhg5dKltRTuLl6HgRu83HTJsev/MCDpH+77PjREIdQGzFgMWTRUOEBZ
         rNnA==
X-Gm-Message-State: AC+VfDxfZ8TlBmx6VDtjObaUgO9uzSyXtWbVE76a8HOIvsP6lr5VXQ2s
        R1kS4lEFOBD1cvq11pGNqb8yg2164+fafWxvd1E=
X-Google-Smtp-Source: ACHHUZ4TmGPb+Ef/cpI6BKSIlo4sbTG/DIPX8TM2VlBM2dzDQydUm7TklpQRF6VQiR1P2Oa11hUWEIbc6728xkg7BFE=
X-Received: by 2002:a05:6808:1142:b0:399:b92:1180 with SMTP id
 u2-20020a056808114200b003990b921180mr3913395oiu.23.1685526020084; Wed, 31 May
 2023 02:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230530075311.400686-1-fl.scratchpad@gmail.com>
 <20230530075311.400686-6-fl.scratchpad@gmail.com> <20230530-cannabis-headstone-883c5b891dd3@spud>
 <CAPJMGm4=sRQGPmVi8NjAVvOVrr8s2By6PO8kKRKZt3W0FR9j-Q@mail.gmail.com> <5d65b644-9b79-d232-d0d0-d2772325eef5@linaro.org>
In-Reply-To: <5d65b644-9b79-d232-d0d0-d2772325eef5@linaro.org>
From:   Fabrizio Lamarque <fl.scratchpad@gmail.com>
Date:   Wed, 31 May 2023 11:40:08 +0200
Message-ID: <CAPJMGm6T_x9Oocdmbrhi879QqZSd812LxJP=J554UbH9k9_LBw@mail.gmail.com>
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

On Wed, May 31, 2023 at 9:14=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 31/05/2023 08:59, Fabrizio Lamarque wrote:
> > On Tue, May 30, 2023 at 7:22=E2=80=AFPM Conor Dooley <conor@kernel.org>=
 wrote:
> >>
> >> On Tue, May 30, 2023 at 09:53:11AM +0200, fl.scratchpad@gmail.com wrot=
e:
> >>> From: Fabrizio Lamarque <fl.scratchpad@gmail.com>
> >>>
> >>> AD7192 supports external clock sources, generated by a digital clock
> >>> source or a crystal oscillator, or internally generated clock option
> >>> without external components.
> >>>
> >>> Describe choice between internal and external clock, crystal or exter=
nal
> >>> oscillator, and internal clock output enable.
> >>>
> >>> Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
> >>> ---
> >>>  .../bindings/iio/adc/adi,ad7192.yaml          | 27 ++++++++++++++++-=
--
> >>>  1 file changed, 24 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yam=
l b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> >>> index 16def2985ab4..f7ecfd65ad80 100644
> >>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> >>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> >>> @@ -32,7 +32,8 @@ properties:
> >>>
> >>>    clocks:
> >>>      maxItems: 1
> >>> -    description: phandle to the master clock (mclk)
> >>> +    description: |
> >>> +      Master clock (mclk). If not set, internal clock is used.
> >>>
> >>>    clock-names:
> >>>      items:
> >>> @@ -50,6 +51,17 @@ properties:
> >>>    vref-supply:
> >>>      description: VRef voltage supply
> >>>
> >>> +  adi,clock-xtal:
> >>> +    description: |
> >>> +      Select whether an external crystal oscillator or an external
> >>> +      clock is applied as master (mclk) clock.
> >>> +    type: boolean
> >>
> >> Am I being daft, or are these the same thing? If they are not, and use
> >> different input pins, I think it should be explained as it not clear.
> >> Could you explain why we actually care that the source is a xtal versu=
s
> >> it being mclk, and why just having master clock is not sufficient?
> >
> > I may revise the description as follows. Feel free to add your suggesti=
ons
> > in case it is still not clear enough.
> >
> > "Select whether an external crystal oscillator between MCLK1 and MCLK2 =
or
> > an external CMOS-compatible clock on MCLK2 is used as master clock".
> >
> > This is used to properly set CLK0 and CLK1 bits in the MODE register.
> > I guess most applications would use an external crystal or internal clo=
ck.
> > The external digital clock would allow synchronization of multiple ADCs=
,
>
> Description confuses me. Why would it matter what type of clock you have
> as input - external crystal oscillator or external CMOS-compatible
> clock? Later you refer to "internal", so maybe you meant here also
> internal for one of the options?

The AD7192 needs to be configured according to the type of external
clock that is
applied on MCLK1/MCLK2 pins in order to activate the correct circuitry.

Here are some citations from the datasheet:

MCLK2 pin description:
"The AD7192 has an internal 4.92 MHz clock. This internal clock can be
made available
on the MCLK2 pin. The clock for the AD7192 can be provided externally
also in the form
of a crystal or external clock. A crystal can be tied across the MCLK1
and MCLK2 pins.
Alternatively, the MCLK2 pin can be driven with a CMOS-compatible clock and=
 the
MCLK1 pin left unconnected."

Each of these clock modes have to be configured via AD7192 mode register.
(Clock source configuration bits, mode register, CLK0 and CLK1).
Here is their description from datasheet:

"Either the on-chip 4.92 MHz clock or an external clock can be used.
The ability to
use an external clock allows several AD7192 devices to be synchronized. Als=
o,
50 Hz/60 Hz rejection is improved when an accurate external clock
drives the AD7192."

The choice between internal clock, external crystal oscillator or
external CMOS digital
clock is a decision of the HW designer driven by noise rejection,
synchronization, and
cost requirements.

If possible, I kindly ask you suggestions on how to adjust the description
so that it would be cleaner.

>
> >
> >>
> >>> +  adi,int-clock-output-enable:
> >>> +    description: |
> >>> +      When internal clock is selected, this bit enables clock out pi=
n.
> >>> +    type: boolean
> >>
> >> And this one makes you a clock provider, so the devices advocate
> >> position would be that you know that this bit should be set if
> >> "clocks" is not present and a consumer requests a clock.
> >> I don't seem to have got the driver patches (at least not in this
> >> mailbox), so I have got no information on how you've actually implemen=
ted
> >> this.
> >
> > I see... When this bit is set, the AD7192 node should also be a clock p=
rovider.
> > The clock is output on MCLK2 pin, hence it can be used with internally
> > generated clock only.
> > I tend to dislike the idea of a "conditional clock provider". Also, I'd=
 guess
>
> Either this is a clock provider via common clock framework or is not.
> Don't re-implement clock provider via other properties but just skip
> such feature.

Ok, I understand. I will remove the bit from the patch in V4. Thank you.

The bit was already existing upstream in the driver, but I would just drop
the change in documentation without any additional patch that removes it
from the driver.

Best regards,
Fabrizio Lamarque
