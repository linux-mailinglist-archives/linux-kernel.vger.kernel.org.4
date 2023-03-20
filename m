Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571E16C1DF8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbjCTRa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbjCTR3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:29:38 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3426728849;
        Mon, 20 Mar 2023 10:25:15 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id be16so9309224oib.0;
        Mon, 20 Mar 2023 10:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679333111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwYte0FtFZG8eWczHimoVeVFmR0OVT3lcfyLXk0qH2w=;
        b=lt8aqP1FG+udw9Q0/RUbLn7xO+AXDEEHgOy0GEzotsWIO46JdEynu5tSbCUvL5hvlj
         lNrbc5NBciW4S2IL+rnhZVEJIhBqgRAwS8lOZadDrRxviiQSmqfU9yJPpyuXgI2+25GK
         PBS7Ajy6XHt2RNS+zVDeGBmCeHqc5v//d6svifqwrh8r09RjXf9jQL21Fu5zZVwaxYkj
         Qxccob0dDvGAWAT/dzk++RokW06JXgLzxJ+3L96R6mYD0Ngu38y28nXuFl6Z7oWBnkxh
         kCKuG1h3VZ9ph20ToNww8pk8+JoZYYgI99ton40oOz/fWGlinIivhCjN/TSuCj9JmR35
         kQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679333111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwYte0FtFZG8eWczHimoVeVFmR0OVT3lcfyLXk0qH2w=;
        b=25ymYnxjeCJxwXmXxyTsoexKfRsmbk81aLpNxMBP74FfrWDZTz6c/m+LbEypmjMPsB
         jEjdwnwufMdfaGTmsAt7EspoxdiOjPSEnS03jbLo/bR1qs4L4ZMPDrju81FVWZeJnpnT
         eXI4g7tdjgLiDx0Q6inFo9Xy/vY7UB3XxLjX8tTScy5LeDtoqL5qKA6gbWEDtejSstex
         omWxh5n6R1Fti+AXGk9zCFNhU881ryUzND4A8K0wvfH0dbgn6baVAsGg4c3lEZlhr1L/
         z5sNLs2m/abi1drJZ1s6mk9EOlmPNRSJ4Jht+fJ0YAV1jVT3ZkHIJKe7GoEujx9SXIqo
         NRsw==
X-Gm-Message-State: AO0yUKXed1qUBADpkz2KoKhq6YonBFQksGUTfGSYxqef+c4F2jQEktle
        1QBWncUvUkIM6sJ6Cd95DhSBQd9IGcPQjTFuDdE=
X-Google-Smtp-Source: AK7set99nLRMGCaQsMXfUkkwGjfD2VCHlH+V3NU0HwtldQphI2vEN5ve+Togabn0vKIkTaR9VNRPgOMJ+6xUlQVL8m0=
X-Received: by 2002:a05:6808:2117:b0:386:a829:48d4 with SMTP id
 r23-20020a056808211700b00386a82948d4mr235548oiw.0.1679333109557; Mon, 20 Mar
 2023 10:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
 <20230320161823.1424278-2-sergio.paracuellos@gmail.com> <1e2f67b4-3bfb-d394-4f60-e6f63ce6a2fd@linaro.org>
In-Reply-To: <1e2f67b4-3bfb-d394-4f60-e6f63ce6a2fd@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 20 Mar 2023 18:24:56 +0100
Message-ID: <CAMhs-H8OQ9gJLsifLuHD2GN8rYwnY=Zmdb0kMEfX4UUHhjMUyQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] dt: bindings: clock: add mtmips SoCs clock device
 tree binding documentation
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, Mar 20, 2023 at 5:36=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/03/2023 17:18, Sergio Paracuellos wrote:
> > Adds device tree binding documentation for clocks and resets in the
> > Mediatek MIPS and Ralink SOCs. This covers RT2880, RT3050, RT3052, RT33=
50,
> > RT3883, RT5350, MT7620, MT7628 and MT7688 SoCs.
>
> Use subject prefixes matching the subsystem (which you can get for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching).
>
> Subject: drop second/last, redundant "device tree binding
> documentation". The "dt-bindings" prefix is already stating that these
> are bindings.

Sure, will do. Sorry for the inconvenience.

> (BTW, that's the longest redundant component I ever saw)

I thought it was better to just list compatible strings inside one
single file than adding the same binding in multiple files.

>
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  .../bindings/clock/mtmips-clock.yaml          | 68 +++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/mtmips-cloc=
k.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/clock/mtmips-clock.yaml =
b/Documentation/devicetree/bindings/clock/mtmips-clock.yaml
> > new file mode 100644
> > index 000000000000..c92969ce231d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/mtmips-clock.yaml
>
> Filename matching compatible, so vendor prefix and device name (or
> family of names).

I used mtmips here but list compatibles starting with ralink. As I
have said in the cover letter I am inspired by the last merged pinctrl
series for these SoCs.
See:
- https://lore.kernel.org/linux-gpio/e9e6ad87-2db5-9767-ff39-64a302b06185@a=
rinc9.com/T/#t

Not all of compatible currently exist. All of these are at the end the
way we can properly match compatible-data to write a proper driver.
The current ralink dtsi files which are in tree now
are totally incomplete and not documented so we are planning to align
all of this with openWRT used files and others soon. That's the reason
we are not touching
'arch/mips/boot/dts' at all now. I don't think anybody is using any of
this but mt7621 which is properly completed and documented.

>
> > @@ -0,0 +1,68 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/mtmips-clock.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MTMIPS SoCs Clock
>
> One clock? Are you sure these describe exactly one clock?

I will change this to 'Clocks'.

>
> > +
> > +maintainers:
> > +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > +
> > +description: |
> > +  MediaTek MIPS and Ralink SoCs have an XTAL from where the cpu clock =
is
> > +  provided as well as derived clocks for the bus and the peripherals.
> > +
> > +  Each clock is assigned an identifier and client nodes use this ident=
ifier
> > +  to specify the clock which they consume.
>
> Drop useless or obvious pieces of description. Describe the hardware.
>
> > +
> > +  The clocks are provided inside a system controller node.

>
> ???

I meant, this node is a syscon from where both clock and reset related
registers are used. I think writing in this way was enough since it
has a pretty similar description like the one in
'mediatek,mt7621-sysc.yaml'.

>
> > +
> > +  This node is also a reset provider for all the peripherals.
>
> ??? Does it mean it is not only "Clock" but also reset controller?

Yes, this node is a clock and reset controller for all the SoC.

>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - ralink,rt2880-sysc
> > +          - ralink,rt3050-sysc
> > +          - ralink,rt3052-sysc
> > +          - ralink,rt3352-sysc
> > +          - ralink,rt3883-sysc
> > +          - ralink,rt5350-sysc
> > +          - ralink,mt7620-sysc
> > +          - ralink,mt7620a-sysc
> > +          - ralink,mt7628-sysc'
> > +          - ralink,mt7688-sysc
> > +          - ralink,rt2880-reset
>
> That's odd. rt2880 is sysc and reset? One device with two compatibles?

This 'ralink,rt2880-reset' is for compatibility reasons. Reset related
code was inside 'arch/mips/ralink' folder reset.c file but it is moved
to this new driver, so we have maintained this reset stuff for the
reset compatibility. All of the rest are the new possible stuff for
both reset and clocks. Clock driver is instantiated in two phases. The
earlier one set up the clocks via CLK_OF_DECLARE macro. Resets are set
up as a platform driver. Is only inside this where
'ralink,rt2880-reset' is used. See patch 2 of the series for details.

>
> Also, order these by name.

All are ordered but I maintained the  'ralink,rt2880-reset' at the end.

>
>
> > +      - const: syscon
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#clock-cells':
> > +    description:
> > +      The first cell indicates the clock number.
> > +    const: 1
> > +
> > +  '#reset-cells':
> > +    description:
> > +      The first cell indicates the reset bit within the register.
> > +    const: 1
>
> Wait, only rt2880-reset is reset controller? This is confusing.

No, that is the reset compatibility one. All the rest are both clock
and reset controllers from now on.

>
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#clock-cells'
> > +  - '#reset-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    sysc: sysc@0 {
>
> Drop label.

Sure, thanks.

>
> Node names should be generic, clock-controller or reset-controller or
> system-controller sometimes.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-device=
tree-basics.html#generic-names-recommendation
>
> > +      compatible =3D "ralink,rt5350-sysc", "syscon";
> > +      reg =3D <0x0 0x100>;
> > +      #clock-cells =3D <1>;
> > +      #reset-cells =3D <1>;
> > +    };

Ok, so I will set this as 'syscon@' if you are ok with it.

>
> Best regards,
> Krzysztof
>

Thanks to you for the review.

Best regards,
    Sergio Paracuellos
