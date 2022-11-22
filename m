Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B70633A22
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbiKVKbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbiKVKal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:30:41 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F97183B2;
        Tue, 22 Nov 2022 02:26:22 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id z6so8957910qtv.5;
        Tue, 22 Nov 2022 02:26:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=chfY2WySadeE6tcUA+nZ6X4EgtVEmwm/moQdjBt/eSI=;
        b=2tsD+0VRrQ2WIiARI7damFtEUq3ZgiMODXgJDXh0URv9rqx0nRWv6KFDHRXkQXtGD3
         TcYV9j1nKIyK1h+QeuGKwTSHB8A9Ib9lp48sRaGf3eAEJu/M8lMztz4xGM7KwmNpzy+C
         P6JmsMBs07mu0DcYZ1teZfcl5q4ntNLurMkXl9KPjHrjgFhRh3Bb6nPuxBhcqnB1vAU4
         aQ5tq6Qqoeuhz7B0DJmayAkaifrgygJYmKciC+fBbLrhnsFPC/Kx5W8sG+TCcJfCDaUD
         mF7pYlCwbC98Iy0scNZhlQ6VJWZkpSWq5x1WPcHyRQrGOtsSaFOZAHNQ1r/DEYbfYR1V
         H6DQ==
X-Gm-Message-State: ANoB5pnaxhPFJ03psv99MwpX9kUOl9iVxfl0GvgPeQVOkKpuNK/wrmhp
        X50lfeRrRdBlFFDz30xa3UBlBVexoY4kPw==
X-Google-Smtp-Source: AA0mqf4UT4FYqqb9h2w6g8aReoc4JLXBySZ7Nk/9Ns7TTaEMk9kPlrKolIpzsejMJQwpincsSh2hOg==
X-Received: by 2002:ac8:1090:0:b0:3a5:6047:c75b with SMTP id a16-20020ac81090000000b003a56047c75bmr2852431qtj.60.1669112781701;
        Tue, 22 Nov 2022 02:26:21 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id y18-20020ac87092000000b0039a08c0a594sm7919670qto.82.2022.11.22.02.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 02:26:20 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-398cff43344so90191777b3.0;
        Tue, 22 Nov 2022 02:26:20 -0800 (PST)
X-Received: by 2002:a0d:dc87:0:b0:370:61f5:b19e with SMTP id
 f129-20020a0ddc87000000b0037061f5b19emr20430887ywe.316.1669112779913; Tue, 22
 Nov 2022 02:26:19 -0800 (PST)
MIME-Version: 1.0
References: <20221114111513.1436165-1-herve.codina@bootlin.com>
 <20221114111513.1436165-3-herve.codina@bootlin.com> <a1a7fdf4-2608-d6c9-7c7a-f8e8fae3a742@linaro.org>
 <c9a77262-f137-21d9-58af-eb4efb8aadbf@linaro.org> <20221115150417.513955a7@bootlin.com>
 <20221118112349.7f09eefb@bootlin.com> <d9bd5075-9d06-888d-36a9-911e2d7ec5af@linaro.org>
 <20221121165921.559d6538@bootlin.com> <4e54bfb4-bb67-73b8-f58f-56797c5925d3@linaro.org>
 <CAMuHMdU=-ZUzHSb0Z8P3wsLK9cgGVCPdMi6AcjTH23tUQEeEBA@mail.gmail.com>
 <a3e1332e-fc15-8a78-0ddd-6d5b26197f11@linaro.org> <CAMuHMdXzqZB4sKMmroriq5oPp7z=yXiHk=+eQKwSyPhNbYqgYA@mail.gmail.com>
 <1f12883b-1e37-7f2b-f9e9-c8bad290a133@linaro.org> <CAMuHMdVbzg8y2So+A=z8nUwHMoL+XKUrvoXp9QdbCnUve1_Atw@mail.gmail.com>
 <191a7f3e-0733-8058-5829-fe170a06dd5a@linaro.org> <CAMuHMdV1Y4Ldq2Hu5X8awTOWYTHq4DPYWCMkyg-9TQY=DaxREg@mail.gmail.com>
 <978fb5a1-64f3-7ee6-3e98-1e31b8b6a88b@linaro.org>
In-Reply-To: <978fb5a1-64f3-7ee6-3e98-1e31b8b6a88b@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Nov 2022 11:26:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXMoYnCHBmSwgzriOhL=EEibzsUsMKnnMK_9sZ20339Bw@mail.gmail.com>
Message-ID: <CAMuHMdXMoYnCHBmSwgzriOhL=EEibzsUsMKnnMK_9sZ20339Bw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, Nov 22, 2022 at 11:23 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 22/11/2022 10:01, Geert Uytterhoeven wrote:
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
> >
> > Exactly.
> >
> >> Anyway with sysctrl approach you will have dependency and you cannot
> >> rely on clock provider-consumer relationship to order that dependency.
> >> What if you make all clocks on and do not take any clocks in USB device?
> >
> > Enabling the clocks does not have anything to do with this ordering.
>
> That was the argument from Herve, that ordering is guaranteed by clocks.
>
> > Clock consumers that are part of the clock domain are probed after
> > clock providers.  If the clock is missing, that would be an incorrect
> > description in DTS.
>
> If not clocks, what else is guaranteeing the ordering? You did not
> express it in DT.

clocks and power-domains

And if not clocks and power-domains... Oops, we didn't express in DT
that the SoC needs to be powered at all ;-)

Can we please stop this pointless discussion?
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
