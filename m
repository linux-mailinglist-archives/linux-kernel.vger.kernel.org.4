Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD56C633A80
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbiKVKtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbiKVKsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:48:41 -0500
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7221B9C8;
        Tue, 22 Nov 2022 02:48:03 -0800 (PST)
Received: by mail-qk1-f172.google.com with SMTP id v8so9908869qkg.12;
        Tue, 22 Nov 2022 02:48:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJ2JMQwyOik22IxySZbtvNMc0gxR6KMN5eX+1lUk9qE=;
        b=RTrTcPzNGvFyESwdcG4h/tCEGDp6+RkzXNM7n0dCsG27c7XCim9KEc7Jz3ke5AVTuS
         Pi8kXyKupwoPsg0cY347ObfXD4JNFdK1m8L8/bcowgixag6V0tC2YvnUVy+4I4bnLxAG
         GIO3uNbrxADjUvO4yDC4UfgZaQjIsMqhib6E7S+/lyY26ddcHJlF4MpQ1H9eBkC2lYmO
         ISj1Ii2IwEPAPMK6l2hJkLhuCwFNCFu4RJ8/gNrsHgO3jCGW6kbkUXYyQMhCN2JwhvsG
         QeHX00bbjPwYpRv3IgP5VQ8mFqxyOC+0rWBuCg14FfnnAUri7ruGcsLrkXOHrKRSKxKX
         Qm6A==
X-Gm-Message-State: ANoB5pnkzj9tpt5+dQ6XOvAEapA422NBY3MpGKwY9oVkE7DAs06usPlK
        eObYmzNm9+X0HahEWTH59cllYWitMJofoA==
X-Google-Smtp-Source: AA0mqf48iCG8KTvFv07zsDDyox+Wz16lpl+9Fm0PLPtd1DLXgPugoHG22/HGpzJvdKPOUwvwEC5TnA==
X-Received: by 2002:a37:e212:0:b0:6cd:f16e:320a with SMTP id g18-20020a37e212000000b006cdf16e320amr20308671qki.495.1669114082001;
        Tue, 22 Nov 2022 02:48:02 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id y19-20020a05620a44d300b006bbf85cad0fsm10369578qkp.20.2022.11.22.02.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 02:48:01 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-39451671bdfso115107947b3.10;
        Tue, 22 Nov 2022 02:48:01 -0800 (PST)
X-Received: by 2002:a0d:fec2:0:b0:36b:56d3:71b8 with SMTP id
 o185-20020a0dfec2000000b0036b56d371b8mr20908152ywf.384.1669114080819; Tue, 22
 Nov 2022 02:48:00 -0800 (PST)
MIME-Version: 1.0
References: <20221114111513.1436165-1-herve.codina@bootlin.com>
 <20221114111513.1436165-3-herve.codina@bootlin.com> <a1a7fdf4-2608-d6c9-7c7a-f8e8fae3a742@linaro.org>
 <c9a77262-f137-21d9-58af-eb4efb8aadbf@linaro.org> <20221115150417.513955a7@bootlin.com>
 <20221118112349.7f09eefb@bootlin.com> <d9bd5075-9d06-888d-36a9-911e2d7ec5af@linaro.org>
 <20221121165921.559d6538@bootlin.com> <4e54bfb4-bb67-73b8-f58f-56797c5925d3@linaro.org>
 <CAMuHMdU=-ZUzHSb0Z8P3wsLK9cgGVCPdMi6AcjTH23tUQEeEBA@mail.gmail.com>
 <a3e1332e-fc15-8a78-0ddd-6d5b26197f11@linaro.org> <CAMuHMdXzqZB4sKMmroriq5oPp7z=yXiHk=+eQKwSyPhNbYqgYA@mail.gmail.com>
 <1f12883b-1e37-7f2b-f9e9-c8bad290a133@linaro.org> <CAMuHMdVbzg8y2So+A=z8nUwHMoL+XKUrvoXp9QdbCnUve1_Atw@mail.gmail.com>
 <191a7f3e-0733-8058-5829-fe170a06dd5a@linaro.org> <20221122100706.739cec4d@bootlin.com>
 <3856e2d8-1c16-a69f-4ac5-34b8e7f18c2b@linaro.org>
In-Reply-To: <3856e2d8-1c16-a69f-4ac5-34b8e7f18c2b@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Nov 2022 11:47:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXPndkt=+k1CAcDbH7eK=TFfS6wMu+xdqWZSCz1+hyhEA@mail.gmail.com>
Message-ID: <CAMuHMdXPndkt=+k1CAcDbH7eK=TFfS6wMu+xdqWZSCz1+hyhEA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] dt-bindings: clock: renesas,r9a06g032-sysctrl: Add
 h2mode property
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, Nov 22, 2022 at 11:30 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 22/11/2022 10:07, Herve Codina wrote:
> > On Tue, 22 Nov 2022 09:42:48 +0100
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >
> >> On 22/11/2022 09:25, Geert Uytterhoeven wrote:
> >>> Hi Krzysztof,
> >>>
> >>> On Tue, Nov 22, 2022 at 8:45 AM Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>> On 21/11/2022 21:46, Geert Uytterhoeven wrote:
> >>>>>> This does not change anything. Herve wrote:
> >>>>>>
> >>>>>>> probe some devices (USB host and probably others)
> >>>>>>
> >>>>>> Why some can be probed earlier and some not, if there are no
> >>>>>> dependencies? If there are dependencies, it's the same case with sysctrl
> >>>>>> touching the register bit and the USB controller touching it (as well
> >>>>>> via syscon, but that's obvious, I assume).
> >>>>>>
> >>>>>> Where is the synchronization problem?
> >>>>>
> >>>>> The h2mode bit (and probably a few other controls we haven't figured out
> >>>>> yet) in the sysctrl must be set before any of the USB devices is active.
> >>>>> Hence it's safest for the sysctrl to do this before any of the USB drivers
> >>>>> probes.
> >>>>
> >>>> Again, this does not differ from many, many of other devices. All of
> >>>> them must set something in system controller block, before they start
> >>>> operating (or at specific time). It's exactly the same everywhere.
> >>>
> >>> The issue here is that there are two _different drivers_ (USB host
> >>> and device). When both are modular, and the driver that depends on the
> >>> sysctrl setting is loaded second, you have a problem: the sysctrl change
> >>> must not be done when the first driver is already using the hardware.
> >>>
> >>> Hence the sysctrl driver should take care of it itself during early
> >>> initialization (it's the main clock controller, so it's a dependency
> >>> for all other I/O device drivers).
> >>
> >> I assumed you have there bit for the first device (which can switch
> >> between USB host and USB device) to choose appropriate mode. The
> >> bindings also expressed this - "the USBs are". Never said anything about
> >> dependency between these USBs.
> >>
> >> Are you saying that the mode for first device cannot be changed once the
> >> second device (which is only host) is started? IOW, the mode setup must
> >> happen before any of these devices are started?
> >>
> >> Anyway with sysctrl approach you will have dependency and you cannot
> >> rely on clock provider-consumer relationship to order that dependency.
> >> What if you make all clocks on and do not take any clocks in USB device?
> >> Broken dependency. What if you want to use this in a different SoC,
> >> where the sysctrl does not provide clocks? Broken dependency.
> >
> > The issue is really related to the Renesas sysctrl itself and not related
> > to the USB drivers themselves.
> > From the drivers themselves, the issue is not seen (I mean the driver
> > takes no specific action related to this issue).
> > If we change the SOC, the issue will probably not exist anymore.
>
> Yeah, and in the next SoC you will bring 10 of such properties to
> sysctrl arguing that if one was approved, 10 is also fine. Somehow
> people on the lists like to use that argument - I saw it somewhere, so I
> am allowed to do here the same.

Like pin control properties? ;-)
This property represents a wiring on the board...
I.e. a system integration issue.

> I understand that the registers responsible for configuration are in
> sysctrl block, but it does not mean that it should be described as part
> of sysctrl Devicetree node. If there was no synchronization problem,
> this would be regular example of register in syscon which is handled
> (toggled) by the device (so USB device/host controller). Since there is
> synchronization problem, you argue that it is correct representation of
> hardware. No, it is not, because logically in DT you do not describe
> mode or existence of other devices in some other node and it still does
> not describe this ordering.

So we have to drop the property, and let the sysctrl block look
for <name>@<reg> nodes, and check which ones are enabled?

Running out of ideas...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
