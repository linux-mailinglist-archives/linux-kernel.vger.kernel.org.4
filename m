Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939A46C292A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 05:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjCUEaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 00:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCUEaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 00:30:09 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6507027483;
        Mon, 20 Mar 2023 21:30:07 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id w21-20020a9d6755000000b00698853a52c7so7888994otm.11;
        Mon, 20 Mar 2023 21:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679373006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNaUCakcPu06DlpwCVBSdm8HeSeM0mI5yjyn3IpUwKc=;
        b=K8wrqWu40LqasIqfUUacfqER0pilNRhefWC42Ct/25I4z3CDTCHOJEpqbaUDoWpUhK
         qhO1UW7meIuMhBK4gQ5l3i1Kgka9VXe8b1ibMkHH6RkNcv69l9QUpEhdcZofV+h9T+49
         sbucRq5ap97SIdV9G4UfTo243Lnxmv36tSTA7ya4+sgW+Czs6APOihAzyPTAshzbhW2U
         qRBQx4RsyORzvBZi6rqfXce5SYFjDExEdrjEvTx27qu4j46Q2aBjVIZqPiD5WeNBFNL8
         XOx1n6BYIHAIl8iLCMm77WijovJMI64LcD7EXXJxLaRrL1CjJIYL+skF4Pii5ssbBFnA
         6Yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679373006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNaUCakcPu06DlpwCVBSdm8HeSeM0mI5yjyn3IpUwKc=;
        b=yABQmsvN7vyVzPpJIJofM7uE5hO0V5E10sghVieD91Zo5VPR6nnytSJM06lhHIX3qn
         fRQrOYNw+J2eAIn9nJIMpFXlkzzilG6A7ba38pdjKU60Kmsto0X6cr2OQyhlrzTRW2z1
         +1CMt+9qAh3cdWcdMNblcRZTPKpYLq38LJtVpWl/jh3a9iIWCriLolhUzJ5uEBLgeuhp
         ye3bZETt1J4mUm2J9F8CvfpEMDDMo74JgfWfbfsnZq6Cms6JYEvZeC2Kb+sc88bc9TYW
         HDf39Z8vL0+9tSKhrLUYvYs8DVstStDRIF2mWvsj1Jm7Rr4uc3eMoXJGBalheLpDMfaL
         ZuDA==
X-Gm-Message-State: AO0yUKXMUuGLHnslkPHZCiFzG9rZmrPcLgQ+yoF6fAVOLmX9c0m8t6Hz
        SvtvSnOR1lWS3SVtChme7guo5mRJtCEJ6PNi0po=
X-Google-Smtp-Source: AK7set9a7j28FpC+7+sbo1j7Ou4GjCFQUwk3Ai6ENsQJM9DonGrM23PFzcY1PQXQpZygkTGl6eIkVli2MSqV45twiz0=
X-Received: by 2002:a9d:66d5:0:b0:698:f988:7c37 with SMTP id
 t21-20020a9d66d5000000b00698f9887c37mr333428otm.3.1679373006663; Mon, 20 Mar
 2023 21:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
 <20230320161823.1424278-2-sergio.paracuellos@gmail.com> <1e2f67b4-3bfb-d394-4f60-e6f63ce6a2fd@linaro.org>
 <CAMhs-H8OQ9gJLsifLuHD2GN8rYwnY=Zmdb0kMEfX4UUHhjMUyQ@mail.gmail.com> <d0f74721-bf5a-62de-53dc-62e7e735e2dc@linaro.org>
In-Reply-To: <d0f74721-bf5a-62de-53dc-62e7e735e2dc@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 21 Mar 2023 05:29:55 +0100
Message-ID: <CAMhs-H8-A1yEXHVdmAmNUjYA8WCsxFbYxXJNy-r9vQkbMo5CVg@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 6:36=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/03/2023 18:24, Sergio Paracuellos wrote:
> > Hi Krzysztof,
> >
> > On Mon, Mar 20, 2023 at 5:36=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 20/03/2023 17:18, Sergio Paracuellos wrote:
> >>> Adds device tree binding documentation for clocks and resets in the
> >>> Mediatek MIPS and Ralink SOCs. This covers RT2880, RT3050, RT3052, RT=
3350,
> >>> RT3883, RT5350, MT7620, MT7628 and MT7688 SoCs.
> >>
> >> Use subject prefixes matching the subsystem (which you can get for
> >> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> >> your patch is touching).
> >>
> >> Subject: drop second/last, redundant "device tree binding
> >> documentation". The "dt-bindings" prefix is already stating that these
> >> are bindings.
> >
> > Sure, will do. Sorry for the inconvenience.
> >
> >> (BTW, that's the longest redundant component I ever saw)
> >
> > I thought it was better to just list compatible strings inside one
> > single file than adding the same binding in multiple files.
>
> I don't understand how this is answers about redundant piece of subject.
> Amount of files are not related to repeating pieces of subject prefix.

True :).

>
> >
> >>
> >>>
> >>> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> >>> ---
> >>>  .../bindings/clock/mtmips-clock.yaml          | 68 +++++++++++++++++=
++
> >>>  1 file changed, 68 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/clock/mtmips-cl=
ock.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/clock/mtmips-clock.yam=
l b/Documentation/devicetree/bindings/clock/mtmips-clock.yaml
> >>> new file mode 100644
> >>> index 000000000000..c92969ce231d
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/clock/mtmips-clock.yaml
> >>
> >> Filename matching compatible, so vendor prefix and device name (or
> >> family of names).
> >
> > I used mtmips here but list compatibles starting with ralink. As I
> > have said in the cover letter I am inspired by the last merged pinctrl
> > series for these SoCs.
> > See:
> > - https://lore.kernel.org/linux-gpio/e9e6ad87-2db5-9767-ff39-64a302b061=
85@arinc9.com/T/#t
>
> 21 patches, so what exactly I should see (except that I was involved in
> that discussions)?
>
> Plus nothing from this thread warrants here exception from naming style.
>
>
> >
> > Not all of compatible currently exist.
>
> Then clearly state this.

Sure. Will do in the commit message.

>
> > All of these are at the end the
> > way we can properly match compatible-data to write a proper driver.
> > The current ralink dtsi files which are in tree now
> > are totally incomplete and not documented so we are planning to align
>
> Nothing like this was said in commit msg, so how can we know?

Will add a comment about this also.

>
> > all of this with openWRT used files and others soon. That's the reason
> > we are not touching
> > 'arch/mips/boot/dts' at all now. I don't think anybody is using any of
> > this but mt7621 which is properly completed and documented.
>
> Anyway, none of this explains exception from naming convention - vendor,
> device or family name.
>
> >
> >>
> >>> @@ -0,0 +1,68 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/clock/mtmips-clock.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: MTMIPS SoCs Clock
> >>
> >> One clock? Are you sure these describe exactly one clock?
> >
> > I will change this to 'Clocks'.
>
> Then clock provider, but are you sure? You included there syscon and
> reset controller.

You are right. This is a system controller node even though it
provides clocks and resets for the rest of the world.

>
> >
> >>
> >>> +
> >>> +maintainers:
> >>> +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> >>> +
> >>> +description: |
> >>> +  MediaTek MIPS and Ralink SoCs have an XTAL from where the cpu cloc=
k is
> >>> +  provided as well as derived clocks for the bus and the peripherals=
.
> >>> +
> >>> +  Each clock is assigned an identifier and client nodes use this ide=
ntifier
> >>> +  to specify the clock which they consume.
> >>
> >> Drop useless or obvious pieces of description. Describe the hardware.
> >>
> >>> +
> >>> +  The clocks are provided inside a system controller node.
> >
> >>
> >> ???
> >
> > I meant, this node is a syscon from where both clock and reset related
> > registers are used. I think writing in this way was enough since it
> > has a pretty similar description like the one in
> > 'mediatek,mt7621-sysc.yaml'.
>
> But what is a system controller node? Some separate device? This is
> description for this device - called "Clock" or "Clocks" - and "system
> controller" appears for the first time.
>
> >
> >>
> >>> +
> >>> +  This node is also a reset provider for all the peripherals.
> >>
> >> ??? Does it mean it is not only "Clock" but also reset controller?
> >
> > Yes, this node is a clock and reset controller for all the SoC.
> >
> >>
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    items:
> >>> +      - enum:
> >>> +          - ralink,rt2880-sysc
> >>> +          - ralink,rt3050-sysc
> >>> +          - ralink,rt3052-sysc
> >>> +          - ralink,rt3352-sysc
> >>> +          - ralink,rt3883-sysc
> >>> +          - ralink,rt5350-sysc
> >>> +          - ralink,mt7620-sysc
> >>> +          - ralink,mt7620a-sysc
> >>> +          - ralink,mt7628-sysc'
> >>> +          - ralink,mt7688-sysc
> >>> +          - ralink,rt2880-reset
> >>
> >> That's odd. rt2880 is sysc and reset? One device with two compatibles?
> >
> > This 'ralink,rt2880-reset' is for compatibility reasons.
>
> I don't understand why. It is used in DTS, so what this node represents
> there?

True, this only has to be present in driver code. Not related to
bindings at all. Will drop it, then.

>
> > Reset related
> > code was inside 'arch/mips/ralink' folder reset.c file but it is moved
> > to this new driver, so we have maintained this reset stuff for the
> > reset compatibility. All of the rest are the new possible stuff for
> > both reset and clocks.
>
> We talk here about hardware, not drivers, so moving driver code around
> does not help me understand the rationale behind bindings.

Understood.

>
> > Clock driver is instantiated in two phases. The
> > earlier one set up the clocks via CLK_OF_DECLARE macro. Resets are set
> > up as a platform driver. Is only inside this where
> > 'ralink,rt2880-reset' is used. See patch 2 of the series for details.
>
> Sure, but it is not related to bindings.
>
> >
> >>
> >> Also, order these by name.
> >
> > All are ordered but I maintained the  'ralink,rt2880-reset' at the end.
>
> No, it is not. m is before r in alphabet.

In my mind all of these were ordered taking into account the year
since they exist :). So you are right. I will order this
alphabetically.

>
> Best regards,
> Krzysztof
>

Thanks,
    Sergio Paracuellos
