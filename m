Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107646631B7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbjAIUnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbjAIUnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:43:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C190A559FA;
        Mon,  9 Jan 2023 12:43:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BE0F613E9;
        Mon,  9 Jan 2023 20:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82420C433F0;
        Mon,  9 Jan 2023 20:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673296990;
        bh=8Le0HxyQ1hvS52eAoweCLxxf9X4TqmN17EpbgjPbkhQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kA3tlsjNZxtuRffwjcyWZjv9MwD9h8wHCPiHmolj/RHcDPDHnqYt6+ABAbYzB5RTR
         YNkDS8gLFLoQrVaor8JNsPjY2AoxLFZC4WSX3vKL/8jTevgyJTwBKROMeJBls8vxs4
         mdoKwp5lpylrBMRumvWRvLCcUZzEpwP6V4ivQpSefZEV1HnIVnDWOfSV36aJOMu32U
         3FUHN8p+IQIBoEcIWGs2BGjKF+J5XOhLBQAKQVlsc9ENbKTcbvmbWSipUY+/LlZP/Z
         z1oYbz0h4mWlvb21yxG1I7W0tEGvUsZrl/qbKx0x0nidSkScbYNzPzbNa+6lRSgHrs
         swug+t0xVeVJQ==
Received: by mail-vk1-f170.google.com with SMTP id t2so4584589vkk.9;
        Mon, 09 Jan 2023 12:43:10 -0800 (PST)
X-Gm-Message-State: AFqh2kr6pR8ugxpSyV5dtLD0kejb/sa0L1iuu34kLEg8T+T/VpDKbGV0
        t3dV17T9AhYFZJU1RzLkpZVpU78PcxyacjAHtg==
X-Google-Smtp-Source: AMrXdXtKHlPsJVq6VwhjeerV8r1su/+h8wjs3OgcrdF35UE0ccjT3YhB5F0EFrEaRdkuT2b6Ohu5yCwEU52xKhhJ7Bo=
X-Received: by 2002:a1f:1c55:0:b0:3d5:d30f:81c2 with SMTP id
 c82-20020a1f1c55000000b003d5d30f81c2mr3979357vkc.14.1673296989386; Mon, 09
 Jan 2023 12:43:09 -0800 (PST)
MIME-Version: 1.0
References: <20221219191038.1973807-1-robh@kernel.org> <87edsua5q4.fsf@balbi.sh>
 <CAL_JsqKgGWN93QJ=V34=X3hC2bgdcd3vwO0Mne-8z8HOfVDz-g@mail.gmail.com>
 <878riy9ztm.fsf@balbi.sh> <20221223235712.h54lggnjjuu3weol@synopsys.com>
 <CAL_Jsq+gCi8g0jY2ic1tJebc_JijMU-GntWQg09q+X41O3=1RA@mail.gmail.com>
 <87o7rlffi7.fsf@balbi.sh> <CAL_Jsq+viP_aY3n378WC7WpxZFnsTc-vKjW9Ojvcy0Ef-z09Ng@mail.gmail.com>
 <87k028g6ol.fsf@balbi.sh> <CAL_JsqKjrXsz6hak2rG3GMKaOot4azDWpYCOsQmdVtmszN1WQw@mail.gmail.com>
 <20230109194004.yqaqslcwnqqywkr3@synopsys.com>
In-Reply-To: <20230109194004.yqaqslcwnqqywkr3@synopsys.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 9 Jan 2023 14:42:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLE+v7LkDk_TG_=aT3mUeGb8eVnJmeKLz5w1XmfVPkHeQ@mail.gmail.com>
Message-ID: <CAL_JsqLE+v7LkDk_TG_=aT3mUeGb8eVnJmeKLz5w1XmfVPkHeQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb: snps,dwc3: Allow power-domains property
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Johan Jonker <jbx6244@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 9, 2023 at 1:40 PM Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:
>
> On Tue, Jan 03, 2023, Rob Herring wrote:
> > On Fri, Dec 30, 2022 at 11:09 AM Felipe Balbi <balbi@kernel.org> wrote:
> > >
> > >
> > > Hi,
> > >
> > > Rob Herring <robh@kernel.org> writes:
> > > >> >> > >> >  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 3 +++
> > > >> >> > >> >  1 file changed, 3 insertions(+)
> > > >> >> > >> >
> > > >> >> > >> > diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > >> >> > >> > index 6d78048c4613..bcefd1c2410a 100644
> > > >> >> > >> > --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > >> >> > >> > +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > >> >> > >> > @@ -91,6 +91,9 @@ properties:
> > > >> >> > >> >          - usb2-phy
> > > >> >> > >> >          - usb3-phy
> > > >> >> > >> >
> > > >> >> > >> > +  power-domains:
> > > >> >> > >> > +    maxItems: 1
> > > >> >> > >>
> > > >> >> > >> AFAICT this can be incorrect. Also, you could have Cc the dwc3
> > > >> >> > >> maintainer to get comments.
> > > >> >>
> > > >> >> Felipe is correct. We have 2 power-domains: Core domain and PMU.
> > > >> >
> > > >> > Power management unit? Performance management unit?
> > > >> >
> > > >> > That doesn't change that the rk3399 is 1 and we're stuck with it. So I
> > > >> > can say 1 or 2 domains, or we add the 2nd domain when someone needs
> > > >> > it.
> > > >>
> > > >> Isn't the snps,dwc3.yaml document supposed to document dwc3's view of
> > > >> the world? In that case, dwc3 expects 2 power domains. It just so
> > > >> happens that in rk3399 they are fed from the same power supply, but
> > > >> dwc3' still thinks there are two of them. No?
> > > >
> > > > Yes. That is how bindings *should* be. However, RK3399 defined one PD
> > > > long ago and it's an ABI. So we are stuck with it. Everyone else put
> > >
> > > Are you confusing things, perhaps? DWC3, the block Synopsys licenses,
> > > has, as Thinh confirmed, 2 internal power domains. How OEMs (TI, Intel,
> > > Rockchip, Allwinner, etc) decide to integrate the IP into their systems
> > > is something different. That is part of the (so-called)
> > > wrapper. Different integrators will wrap Synopsys IP however they see
> > > fit, as long as they can provide a suitable translation layer between
> > > Synopsys own view of the world (its own interconnect implementation, of
> > > which there are 3 to choose from, IIRC) and the rest of the SoC.
> > >
> > > Perhaps what RK3399 did was provide a single power domain at the wrapper
> > > level that feeds both of DWC3's own power domains, but DWC3 itself still
>
> Just for some additional context/use case, the power to the PMU (power
> management unit) must always be on. If the device supports hibernation,
> in hibernation, the power supply to the core can be turned off.

Things in an always-on PD may or may not be described in
'power-domains', so from a DT perspective I would say 1 domain is
perfectly valid here.

I suppose the PMU could be in a PD which can be gated off, but any
hibernation features would be lost.

> > > has 2 power domains, that's not something rockchip can change without
> > > risking the loss of support from Synopsys, as it would not be Synopsys
> > > IP anymore.
> >
> > Again, none of this matters. I'm documenting what is already in use
> > and an ABI, not what is correct. The time for correctness was when
> > this binding was added.
>
> That's unfortunate. That makes this very difficult to maintain if we
> can't rectify a mistake.

Shrug. What's unfortunate is only a limited number of people can
review bindings to be correct in this aspect. And I'm not one of them.

We deal with this all the time already. It's just amplified when it is
shared IP. Would I like less variation? Yes, but it's not a
showstopper.

> > To move forward, how about something like this:
> >
> > power-domains:
> >   description: Really there are 2 PDs, but some implementations
> > defined a single PD.
> >   minItems: 1
> >   items:
> >     - description: core
> >     - description: PMU
> >
> > We unfortunately can't constrain this to Rockchip in the schema
> > because that specific information is in the parent node.
> >
> > (kind of crappy descriptions too, but that's the amount of information I have.)
>
> Can we omit mentioning min or maxItems? While it may not be desired,
> it's not a hard requirement right? This can help avoid some confusion
> with devicetree documentation and dwc3 databook.

Why? Don't you want to catch someone defining 3 domains?

Rob
