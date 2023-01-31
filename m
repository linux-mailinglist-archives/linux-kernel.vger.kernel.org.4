Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A4D6836C1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjAaToL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjAaToJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:44:09 -0500
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1597A49548;
        Tue, 31 Jan 2023 11:44:08 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-142b72a728fso20758573fac.9;
        Tue, 31 Jan 2023 11:44:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2m9tJqzXLR/Xzl9b5IOsjDqW60hmyJ9ePLlpb3yLZfU=;
        b=lkJRj/9bf7On/RbHJ/losJQm9LBRcnuyyqutIG6yuUcLmcAxNayEHVPmY+JTN6WdVp
         xYjP5qz+tIjTYJ2OipxVocIgs9XX4yfnxDotYrZwUEH7DdSY1qq+76m7WXGS2w6Ltrhu
         mXrejoY+LwiZTXt8UDy0uA8YVxFED3K/inQaTBiWESeLTbfOFcyOP8JHL4ZSzgXYs9mH
         j5glRKKhr8GunsWj7e2wLAvDEeyK2/20Hn8GycsdQVQ6cKt64/q38RKHrMyOld5S5Lc/
         4RvnLI+mpJ9NTK1sP0seB0rHAN9zv81NDmUBJHCJ7U4MY08HCRKoW3+mD0s6LNyU6OOQ
         DNtQ==
X-Gm-Message-State: AO0yUKX4itZgMH0Ddq9FHD23K2Ji1A58EDqPcQX8yIki8Uy+bpFxhxBi
        FwHD/5WpaMSwx7qYNeTN5w==
X-Google-Smtp-Source: AK7set+Qd5VxIRtd+LTzqR87o/lZl+6e+O3ojtFUT/yPAUaWm3DEnfWlJp92dTB67fCjVASNdj+U5w==
X-Received: by 2002:a05:6870:738d:b0:163:b86b:2f0f with SMTP id z13-20020a056870738d00b00163b86b2f0fmr5150991oam.18.1675194247164;
        Tue, 31 Jan 2023 11:44:07 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id kz12-20020a056871408c00b0013b911d5960sm6941580oab.49.2023.01.31.11.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 11:44:06 -0800 (PST)
Received: (nullmailer pid 1832867 invoked by uid 1000);
        Tue, 31 Jan 2023 19:44:05 -0000
Date:   Tue, 31 Jan 2023 13:44:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Introduce GPIO-based SBU mux
Message-ID: <20230131194405.GA3793867-robh@kernel.org>
References: <20230117175657.GA3275060-robh@kernel.org>
 <20230118180811.GB3322341@hu-bjorande-lv.qualcomm.com>
 <20230119161132.GA1880784-robh@kernel.org>
 <20230119173954.GB3899167@hu-bjorande-lv.qualcomm.com>
 <CAL_Jsq+4t09XDkF0dbh+aOyTz80SY18EpRBdoGpLqQBuCPQ5=Q@mail.gmail.com>
 <20230124170437.GA1209567@hu-bjorande-lv.qualcomm.com>
 <CAL_JsqL+-updMkZ7AZoKPdU==PPdVv7qZC2MFc7Xw_PSo7QPGw@mail.gmail.com>
 <20230125234013.GA2132606@hu-bjorande-lv.qualcomm.com>
 <20230130164813.GA2730437-robh@kernel.org>
 <20230130214214.GA953860@hu-bjorande-lv.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130214214.GA953860@hu-bjorande-lv.qualcomm.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 01:42:14PM -0800, Bjorn Andersson wrote:
> On Mon, Jan 30, 2023 at 10:48:13AM -0600, Rob Herring wrote:
> > On Wed, Jan 25, 2023 at 03:40:13PM -0800, Bjorn Andersson wrote:
> > > On Tue, Jan 24, 2023 at 08:31:13PM -0600, Rob Herring wrote:
> > > > On Tue, Jan 24, 2023 at 11:04 AM Bjorn Andersson
> > > > <quic_bjorande@quicinc.com> wrote:
> > > > >
> > > > > On Tue, Jan 24, 2023 at 10:00:12AM -0600, Rob Herring wrote:
> > > > > > On Thu, Jan 19, 2023 at 11:40 AM Bjorn Andersson
> > > > > > <quic_bjorande@quicinc.com> wrote:
> [..]
> > > > > Are you saying that the connector should link with the mux and then the
> > > > > source of the signal should be daisy chained? Or that we should just
> > > > > link both of them as two separate endpoints from the connector?
> > > > 
> > > > The former. The data path of the signal in h/w should match in the DT
> > > > graph. The caveat being we don't normally show PHYs in that mix
> > > > because they are somewhat transparent. That's maybe becoming less true
> > > > with routing or muxing included in PHYs.
> > > > 
> > > 
> > > We have discussed and prototyped this a few times now in the Qualcomm
> > > community, and I am not a fan of having to add forwarding-logic to each
> > > implementation of a Type-C mux/switch, which in some configuration might
> > > have an entity behind it that needs the notifications.
> > 
> > I don't know if we can really escape that.
> > 
> 
> Okay, we'll have to figure out how to implement that when such need come...
> 
> > 
> > > But I don't think there's a concern for this binding (in my
> > > implementation), there's currently no mode/orientation switching
> > > happening beyond this entity.
> > > 
> > > 
> > > 
> > > That said, if we're to represent each signal path to the connector,
> > > I would like to bring up this problem again:
> > > https://lore.kernel.org/all/20220520164810.141400-1-bjorn.andersson@linaro.org/
> > > 
> > > port@0 represent the HS signals going to the connector, port@1 the SS
> > > signals going to the connector, port@2 the SBU signals going to the
> > > connector.
> > > 
> > > But I need some representation of the HPD (hot plug detection) "signal"
> > > (there is no actual signal path in hardware, this is a virtual
> > > notification) going _from_ the connector to the DisplayPort controller.
> > 
> > I would assume whatever entity is deciding to enable the DP signals on 
> > the connector would be what generates the HPD notification.
> 
> The HPD notification comes from the display/connector, and is
> conceptually equivalent to hpd-gpios in e.g. the dp-connector binding.

Except that it is software based rather than a h/w signal (ignoring the 
s/w generating a h/w HPD signal for you).

> 
> > I think you want to describe the DP signal connections and muxing, but
> > HPD itself wouldn't be in the DT.
> > 
> 
> Okay, so you're saying that the display driver needs to traverse the
> graph representing the display-signal path, in hope to find someone
> generating a HPD notification?

After further discussion, I think it is still the immediate neighbor, it 
is just that the immediate neighbor is some other component, not the 
type-c connector. 

> > > We discussed this (perhaps in person, as there's no trace on lkml?) and
> > > you suggested that I use a second endpoint under port@1, instead of
> > > introducing a fourth port.
> > 
> > Multiple endpoints on a port are typically a mux or fanout depending on 
> > the data direction. But the muxing is not really in the connector, so 
> > that should probably be represented somewhere else. I think a new port 
> > suffers from the same issue. Maybe that's close enough? Depends if there 
> > are cases of more alt modes or more complicated muxing/switching.
> > 
> > > I'm fine either way, but I don't think it would be convenient nor
> > > representable to daisy chain this behind any of the existing endpoints;
> > > none of the other endpoints should deal with the HPD signal and the
> > > direct of_graph-link between the usb-c-connector and the DP controller
> > > mimics that of e.g. dp-connector very nicely, both in description and
> > > implementation.
> > 
> > That would be nice, but the reality is there's a lot more between DP and 
> > the connector with USB-C and the graph should reflect that.
> 
> Not when it comes to delivering the HPD notification, afaict.
> 
> The TCPM will configure muxes & switches to ensure that the USB
> connector is wired up according to what has been decided over USB PD.
> 
> The HPD signal is orthogonal to that configuration, and should not be
> picked up by any of the other components.

Agreed as HPD is not a h/w signal routed between components.


> > I guess the 
> > problem there is being able to walk the graph. Suppose we have:
> > 
> > DP out port -> altmode mux in port -> altmode mux out port -> type-c 
> > port 1
> > 
> > The issue walking the graph here would be generic code doesn't know 
> > altmode mux port numbering as that's not a generic thing (could be 
> > perhaps?). Maybe you can walk from each end and see if you end up in 
> > the same device.
> > 
> > Of course, I haven't even considered the split cases where it's not 
> > just either USB3 OR DP, but combinations. 
> > 
> 
> The implementation that toggles between the DP-only and USB/DP-combo is
> not stable, so we currently only support USB/DP-combo upstream.

Okay, but I don't care about that from a binding standpoint. All 
possibilities need to be considered whether your h/w can support it or 
not.
 
> Again, the TCPM will handle the muxing and orientation switching in the
> PHY and sbu-mux, then once a datapath capable of delivering DP-altmode
> data is established, it might send HPD notifications - to the display
> driver.
> 
> > 
> > What I'd really like to see for all this USB-C stuff is block diagrams 
> > of the h/w components and then what the corresponding DT looks like. 
> > Trying to extend things one piece at a time is hard to review and not 
> > likely going to end with a flexible design.
> > 
> 
> This is the design we have in a range of different boards:

*This* is what I need for every Type-C binding.

> 
>                      +------------- - -
>  USB connector       | SoC
>  +-+                 |   +--------+    +-------+
>  | |                 |   |        |    |       |
>  |*|<------- HS -----|-->| HS phy |<-->| (EUD) |<--+
>  | |                 |   |        |    |       |   |   +--------+
>  | |                 |   +--------+    +-------+   +-->|        |
>  | |                 |                                 |  dwc3  |
>  | |                 |   +--------+        /---------->|        |
>  | |   +----------+  |   |        |<------/            +--------+
>  |*|<--|(redriver)|<-|-->| SS phy |
>  | |   +----------+  |   |        |<-\   +------------+
>  | |                 |   +--------+   \->|            |
>  | |                 |                   |     DP     |
>  | |     +-----+     |                   | controller |
>  |*|<--->| SBU |<----|------------------>|            |
>  | |     | mux |     |                   |            |
>  | |     +----+      |                   +------------+
>  +-+                 |
>                      +------------- - -

Where's the TCPM?


> The EUD and redriver are only found/used in some designs.  My proposed
> representation of this (without those) is:

I'd assume a redriver is mostly transparent to s/w?


> 
> /soc {
>     usb-controller {
>         dwc3 {
>             port {
>                 dwc0-out: endpoint {
>                     remote-endpoint = <&connector0_hs>;
>             };
>         };
>     };
> 
>     ss_phy: phy {
>         port {
>             ss_phy_out: endpoint {
>                 remote-endpoint = <&connector0_ss>;
>             };
>         };
>     };
> 
>     display-subsystem {
>         displayport-controller {
>             phys = <&ss_phy>;
>             ports {
>                 port@1 {
>                     reg = <1>;
>                     dp0_out: endpoint {
>                         remote-endpoint = <&connector0_hpd>;
>                     };
>                 };
>             };
>         };
>     };
> };
> 
> usb0-sbu-mux {
>     compatible = "gpio-sbu-mux";
> 
>     port {
>         sbu0_out: endpoint {
>             remote-endpoint = <&connector_sbu>;
>         };
>     };
> };
> 
> tcpm {
>     connector@0 {
>         compatible = "usb-c-connector";
>         reg = <0>;
>         ports {
>             port@0 {
>                 reg = <0>;
>                 connector0_hs: endpoint {
>                     remote-endpoint = <&dwc0_out>;
>                 };
>             };
> 
>             port@1 {
>                 reg = <1>;
>                 connector0_ss: endpoint@0 {
>                     remote-endpoint = <&ss_phy_out>;
>                 };
>                 connector0_hpd: endpoint@1 {
>                     remote-endpoint = <&dp0_out>;
>                 };

This just looks wrong to me because one connection is the output of the 
phy's mux and one is the input. The USB SS connection is implicit, but I 
think it should be explicit from dwc3 to ss_phy. It would need an output 
port and 2 input ports. I want to say we already have bindings doing 
this.

>             };
> 
>             port@2 {
>                 reg = <2>;
>                     connector_sbu: endpoint {
>                         remote-endpoint = <&sbu0_out>;
>                 };
>             };
>         };
>     };
> };
> 
> The EUD needs to be able to override the role-switch state, so the design that
> was accepted was to implement the role-switch forwarding logic in the driver
> and daisy chain the of-graph.

Given EUD is a Qualcomm only thing, I'm not all that worried about it.

> 
> No redriver has made it to LKML, but the this is where the daisy chain vs
> reference all instances from port@1 comes in.
> 
> The Type-C port manager (tcpm) might be handling multiple usb-c-connectors, in
> which case the reg of the connector identifies which instance is being
> described.
> 
> 
> So I think that all these pieces fits your model, except the port@1/endpoint@1
> and the fact that displayport-controller has a of_graph.
> 
> 
> In particular we have a number of these:
> 
> /dp-connector {
>     compatible = "dp-connector";
> 
>     port {
>         connector: endpoint {
>             remote-endpoint = <&dp_out>;
>         };
>     };
> };
> 
> /soc {
>     display-subsystem {
>         displayport-controller {
>             phys = <&some_dp_phy>;
>             ports {
>                 port@1 {
>                     reg = <1>;
>                     dp_out: endpoint {
>                         remote-endpoint = <&connector>;
>                     };
>                 };
>             };
>         };
>     };
> };
> 
> As you said previously, it doesn't make sense to represent the phy in this
> graph. We just define the output of the controller as port@1 and link that to
> the connector.

What I said (or meant) was we don't represent phys which are just 
providing the electrical interface. Your 'phy' is also a mux/switch, so 
it does make sense to represent it in the graph.

> 
> So what is the output of the dp controller in the USB case - if we're not
> representing that as the HPD link directly between the connector and the
> controller?

The answer lies in your block diagram... 

The question I think is whether we could standardize the mux/switch 
graph ports. Say 'port@0' is the output to type-C connector port@1, 
and port@[1-9] are altmode connections to USB/DP/TB. If we did that, 
then generic code can walk the graph from a controller to the connector. 
We only need to know that port@0 goes to the connector. However, that 
assumes there is only 1 entity in the middle and I don't know if that 
holds true.

Rob
