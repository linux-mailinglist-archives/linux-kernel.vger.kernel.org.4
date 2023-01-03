Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DBC65C6D3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjACS7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238542AbjACS7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:59:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF055DF24;
        Tue,  3 Jan 2023 10:59:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 886A5614E3;
        Tue,  3 Jan 2023 18:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E057CC433EF;
        Tue,  3 Jan 2023 18:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672772349;
        bh=+CJk9OwSCEk1H/q4t+TF4/vkdk8PvOEpM8L7jWrZOjY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HXhSvzMTqih359QbIxXdEIubg8JzAxZNkH/B6vmJPb2c83zUxlSbv05qAAdM3AqFZ
         RNsw6Yld/pCkKtNLx7J8sbT9vAoum/XkGKT8FtL6pHR70wr9pB+i9bhplgbtXK+W2A
         W9lIh+rQhP15L28U8ETt5QyyWUDYPgpWTZa3yWY0vvACcRqQmO9V24itMM6Hr/u0Xe
         uBH5pAUtuv09Lr0709haFcc9JlmebobKwechcad7RbIzxxXwt8o0KK+c4yw79wIwAq
         4GL3DEJ3pVlHF+y2YoTM4zdUDx9z4qMF66Z1AjQP5gKeoA785mZp0Mb20u64PiHzke
         RrezfG9sGho/g==
Received: by mail-vs1-f45.google.com with SMTP id a66so32705741vsa.6;
        Tue, 03 Jan 2023 10:59:09 -0800 (PST)
X-Gm-Message-State: AFqh2kpJ0k93VTtEn//V3WveI87Cj5aqVfXuG2XLCJRsJ/Gxxft/+q4z
        cPmAEIBTM91/zSwcnVWyEnHknMZmF+8jgk6L4A==
X-Google-Smtp-Source: AMrXdXt30e7MO4nUMxWQHE6eLMPSl7qMY4TL2xhtIPpuWB6pfg5JetNnhvd0qb+pRf12HhvnIWpNMXq7DfSUX1oyzqI=
X-Received: by 2002:a05:6102:3546:b0:3c8:a6ed:faa8 with SMTP id
 e6-20020a056102354600b003c8a6edfaa8mr3777310vss.85.1672772348793; Tue, 03 Jan
 2023 10:59:08 -0800 (PST)
MIME-Version: 1.0
References: <20221219191038.1973807-1-robh@kernel.org> <87edsua5q4.fsf@balbi.sh>
 <CAL_JsqKgGWN93QJ=V34=X3hC2bgdcd3vwO0Mne-8z8HOfVDz-g@mail.gmail.com>
 <878riy9ztm.fsf@balbi.sh> <20221223235712.h54lggnjjuu3weol@synopsys.com>
 <CAL_Jsq+gCi8g0jY2ic1tJebc_JijMU-GntWQg09q+X41O3=1RA@mail.gmail.com>
 <87o7rlffi7.fsf@balbi.sh> <CAL_Jsq+viP_aY3n378WC7WpxZFnsTc-vKjW9Ojvcy0Ef-z09Ng@mail.gmail.com>
 <87k028g6ol.fsf@balbi.sh>
In-Reply-To: <87k028g6ol.fsf@balbi.sh>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 3 Jan 2023 12:58:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKjrXsz6hak2rG3GMKaOot4azDWpYCOsQmdVtmszN1WQw@mail.gmail.com>
Message-ID: <CAL_JsqKjrXsz6hak2rG3GMKaOot4azDWpYCOsQmdVtmszN1WQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb: snps,dwc3: Allow power-domains property
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
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

On Fri, Dec 30, 2022 at 11:09 AM Felipe Balbi <balbi@kernel.org> wrote:
>
>
> Hi,
>
> Rob Herring <robh@kernel.org> writes:
> >> >> > >> >  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 3 +++
> >> >> > >> >  1 file changed, 3 insertions(+)
> >> >> > >> >
> >> >> > >> > diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> >> >> > >> > index 6d78048c4613..bcefd1c2410a 100644
> >> >> > >> > --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> >> >> > >> > +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> >> >> > >> > @@ -91,6 +91,9 @@ properties:
> >> >> > >> >          - usb2-phy
> >> >> > >> >          - usb3-phy
> >> >> > >> >
> >> >> > >> > +  power-domains:
> >> >> > >> > +    maxItems: 1
> >> >> > >>
> >> >> > >> AFAICT this can be incorrect. Also, you could have Cc the dwc3
> >> >> > >> maintainer to get comments.
> >> >>
> >> >> Felipe is correct. We have 2 power-domains: Core domain and PMU.
> >> >
> >> > Power management unit? Performance management unit?
> >> >
> >> > That doesn't change that the rk3399 is 1 and we're stuck with it. So I
> >> > can say 1 or 2 domains, or we add the 2nd domain when someone needs
> >> > it.
> >>
> >> Isn't the snps,dwc3.yaml document supposed to document dwc3's view of
> >> the world? In that case, dwc3 expects 2 power domains. It just so
> >> happens that in rk3399 they are fed from the same power supply, but
> >> dwc3' still thinks there are two of them. No?
> >
> > Yes. That is how bindings *should* be. However, RK3399 defined one PD
> > long ago and it's an ABI. So we are stuck with it. Everyone else put
>
> Are you confusing things, perhaps? DWC3, the block Synopsys licenses,
> has, as Thinh confirmed, 2 internal power domains. How OEMs (TI, Intel,
> Rockchip, Allwinner, etc) decide to integrate the IP into their systems
> is something different. That is part of the (so-called)
> wrapper. Different integrators will wrap Synopsys IP however they see
> fit, as long as they can provide a suitable translation layer between
> Synopsys own view of the world (its own interconnect implementation, of
> which there are 3 to choose from, IIRC) and the rest of the SoC.
>
> Perhaps what RK3399 did was provide a single power domain at the wrapper
> level that feeds both of DWC3's own power domains, but DWC3 itself still
> has 2 power domains, that's not something rockchip can change without
> risking the loss of support from Synopsys, as it would not be Synopsys
> IP anymore.

Again, none of this matters. I'm documenting what is already in use
and an ABI, not what is correct. The time for correctness was when
this binding was added.

To move forward, how about something like this:

power-domains:
  description: Really there are 2 PDs, but some implementations
defined a single PD.
  minItems: 1
  items:
    - description: core
    - description: PMU

We unfortunately can't constrain this to Rockchip in the schema
because that specific information is in the parent node.

(kind of crappy descriptions too, but that's the amount of information I have.)

> > power-domains in the parent because obviously the DWC3 has 0
> > power-domains.
>
> How did you come to this conclusion?

By testing the schema against the in tree .dts files. To date, no one
other than Rockchip has power-domains in the DWC3 node.

Rob
