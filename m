Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456C4633702
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiKVI0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbiKVIZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:25:52 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AE64047B;
        Tue, 22 Nov 2022 00:25:50 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id jr19so8833934qtb.7;
        Tue, 22 Nov 2022 00:25:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+a9AQHe77TpOi1nNEBNs7a4bTR4w2mw5oUVGtsuLCj8=;
        b=LCkYXeCBi5miYV1qs8WXYwAxOvVQgl3OpcFXqgrvDOMoDjeNEEYOC8K+SxAeMjGidu
         PEnTce3Zmpu1FjuTgHzMCmJmgED0oyg8T+Q9jXmgr685rsOyP9cADveIeAA/e0HX9SQP
         5Dx5qtmAHX6ButOzq5q+8ukasM/r8wj0QaQISnSZXiAHtPkr3kxCWn++zMHOxedfaA/U
         5jpXC4KJzbXdiyfIG6HvckZJkN4A/4JTAZ4qCP73KpusGbsT7XsM8a6BOx+6WXy+x9pa
         MwmCPtyxk+V4hLpcOoFKFw6QC+nygEUzTa75zLRedXl6PWNMA6VPOTMvZNpkCPcoeT7v
         MQbg==
X-Gm-Message-State: ANoB5pkK+XaKoj5qn313qdhd4TfFW21VSnRL+rVLw2iNY8s3JIKH0WZ4
        sP3DQqmodyB1mstmmh+JYUcemltHG2VwjA==
X-Google-Smtp-Source: AA0mqf5QmpJU/yJ68T8miverIZ6IoUt66s8gW8cXuA5LzFzLjsr8dIWOUgLZCHg8UKP7Ag3NeeVQkQ==
X-Received: by 2002:a05:622a:4d4e:b0:39a:78d4:57e with SMTP id fe14-20020a05622a4d4e00b0039a78d4057emr5838777qtb.118.1669105549313;
        Tue, 22 Nov 2022 00:25:49 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id h9-20020a05620a244900b006fbdeecad51sm7310306qkn.48.2022.11.22.00.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 00:25:48 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id b131so16482694yba.11;
        Tue, 22 Nov 2022 00:25:48 -0800 (PST)
X-Received: by 2002:a25:8249:0:b0:6dd:b521:a8f2 with SMTP id
 d9-20020a258249000000b006ddb521a8f2mr2342411ybn.380.1669105548029; Tue, 22
 Nov 2022 00:25:48 -0800 (PST)
MIME-Version: 1.0
References: <20221114111513.1436165-1-herve.codina@bootlin.com>
 <20221114111513.1436165-3-herve.codina@bootlin.com> <a1a7fdf4-2608-d6c9-7c7a-f8e8fae3a742@linaro.org>
 <c9a77262-f137-21d9-58af-eb4efb8aadbf@linaro.org> <20221115150417.513955a7@bootlin.com>
 <20221118112349.7f09eefb@bootlin.com> <d9bd5075-9d06-888d-36a9-911e2d7ec5af@linaro.org>
 <20221121165921.559d6538@bootlin.com> <4e54bfb4-bb67-73b8-f58f-56797c5925d3@linaro.org>
 <CAMuHMdU=-ZUzHSb0Z8P3wsLK9cgGVCPdMi6AcjTH23tUQEeEBA@mail.gmail.com>
 <a3e1332e-fc15-8a78-0ddd-6d5b26197f11@linaro.org> <CAMuHMdXzqZB4sKMmroriq5oPp7z=yXiHk=+eQKwSyPhNbYqgYA@mail.gmail.com>
 <1f12883b-1e37-7f2b-f9e9-c8bad290a133@linaro.org>
In-Reply-To: <1f12883b-1e37-7f2b-f9e9-c8bad290a133@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Nov 2022 09:25:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVbzg8y2So+A=z8nUwHMoL+XKUrvoXp9QdbCnUve1_Atw@mail.gmail.com>
Message-ID: <CAMuHMdVbzg8y2So+A=z8nUwHMoL+XKUrvoXp9QdbCnUve1_Atw@mail.gmail.com>
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
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, Nov 22, 2022 at 8:45 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 21/11/2022 21:46, Geert Uytterhoeven wrote:
> >> This does not change anything. Herve wrote:
> >>
> >>> probe some devices (USB host and probably others)
> >>
> >> Why some can be probed earlier and some not, if there are no
> >> dependencies? If there are dependencies, it's the same case with sysctrl
> >> touching the register bit and the USB controller touching it (as well
> >> via syscon, but that's obvious, I assume).
> >>
> >> Where is the synchronization problem?
> >
> > The h2mode bit (and probably a few other controls we haven't figured out
> > yet) in the sysctrl must be set before any of the USB devices is active.
> > Hence it's safest for the sysctrl to do this before any of the USB drivers
> > probes.
>
> Again, this does not differ from many, many of other devices. All of
> them must set something in system controller block, before they start
> operating (or at specific time). It's exactly the same everywhere.

The issue here is that there are two _different drivers_ (USB host
and device). When both are modular, and the driver that depends on the
sysctrl setting is loaded second, you have a problem: the sysctrl change
must not be done when the first driver is already using the hardware.

Hence the sysctrl driver should take care of it itself during early
initialization (it's the main clock controller, so it's a dependency
for all other I/O device drivers).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
