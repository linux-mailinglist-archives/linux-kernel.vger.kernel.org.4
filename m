Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8BA6816D4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbjA3QsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbjA3QsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:48:17 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D8AF77D;
        Mon, 30 Jan 2023 08:48:15 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id k15-20020a4adfaf000000b00517450f9bd7so601337ook.8;
        Mon, 30 Jan 2023 08:48:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLqvqE2pEr5jQoyGystjR0URkw9KxZ/MIpXl61MzN8w=;
        b=IiP8gdjJWj92ZDo8HJiF5kOVii6pSVk4O0ntLXdhX52WLD5dl+eRtL+WND9DL6uyBq
         fPLFeyjYEYKZOHWN6NGo//zWGLF6Vw2wq2iclmrKuH2+j2hSrSqmyAvbJcaYkuxi9whN
         ooN9kcT9liGl89yczCXHvNKdLOuLZcufbo67KHIBk1THB/GFfjSfKUwXDagtOB9sLALS
         7Dw34uxFx3fI07ECcQBylup6ePW+1JW6gN1vFNMwLL+EGuon5ihlMl+iEnvSdnM2Pvbt
         HclsnglctgvgvQXbnDhdlnM6pXp8n7diFWhuOLShKThqLmXLS1NggtD4etcGkyu7wkRM
         8ySQ==
X-Gm-Message-State: AFqh2kq3rbG0QREI1HxoAeaQjkxlLaPtokcF6UQxZT2ihEZJbWnhxXQl
        XAZnmOOCC3NPZnPgK0TM/A==
X-Google-Smtp-Source: AMrXdXvHVPlVqvcNpBLmjf0I9+f+tvHHIjoM9QSGwRCoSefFTS8eaMuG+7CTLiL9cy19UAtRlzAeig==
X-Received: by 2002:a4a:c118:0:b0:4f2:9e:3e87 with SMTP id s24-20020a4ac118000000b004f2009e3e87mr21300637oop.4.1675097294723;
        Mon, 30 Jan 2023 08:48:14 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v6-20020a4ac906000000b0051762a73553sm2313549ooq.18.2023.01.30.08.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 08:48:14 -0800 (PST)
Received: (nullmailer pid 2790934 invoked by uid 1000);
        Mon, 30 Jan 2023 16:48:13 -0000
Date:   Mon, 30 Jan 2023 10:48:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Introduce GPIO-based SBU mux
Message-ID: <20230130164813.GA2730437-robh@kernel.org>
References: <20230113041115.4189210-1-quic_bjorande@quicinc.com>
 <20230117175657.GA3275060-robh@kernel.org>
 <20230118180811.GB3322341@hu-bjorande-lv.qualcomm.com>
 <20230119161132.GA1880784-robh@kernel.org>
 <20230119173954.GB3899167@hu-bjorande-lv.qualcomm.com>
 <CAL_Jsq+4t09XDkF0dbh+aOyTz80SY18EpRBdoGpLqQBuCPQ5=Q@mail.gmail.com>
 <20230124170437.GA1209567@hu-bjorande-lv.qualcomm.com>
 <CAL_JsqL+-updMkZ7AZoKPdU==PPdVv7qZC2MFc7Xw_PSo7QPGw@mail.gmail.com>
 <20230125234013.GA2132606@hu-bjorande-lv.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125234013.GA2132606@hu-bjorande-lv.qualcomm.com>
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

On Wed, Jan 25, 2023 at 03:40:13PM -0800, Bjorn Andersson wrote:
> On Tue, Jan 24, 2023 at 08:31:13PM -0600, Rob Herring wrote:
> > On Tue, Jan 24, 2023 at 11:04 AM Bjorn Andersson
> > <quic_bjorande@quicinc.com> wrote:
> > >
> > > On Tue, Jan 24, 2023 at 10:00:12AM -0600, Rob Herring wrote:
> > > > On Thu, Jan 19, 2023 at 11:40 AM Bjorn Andersson
> > > > <quic_bjorande@quicinc.com> wrote:
> > > > >
> > > > > On Thu, Jan 19, 2023 at 10:11:32AM -0600, Rob Herring wrote:
> > > > > > On Wed, Jan 18, 2023 at 10:08:11AM -0800, Bjorn Andersson wrote:
> > > > > > > On Tue, Jan 17, 2023 at 11:56:57AM -0600, Rob Herring wrote:
> > > > > > > > On Thu, Jan 12, 2023 at 08:11:14PM -0800, Bjorn Andersson wrote:
> > > > > > > > > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > > > > > >
> > > > > > > > > Introduce a binding for GPIO-based mux hardware used for connecting,
> > > > > > > > > disconnecting and switching orientation of the SBU lines in USB Type-C
> > > > > > > > > applications.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > > > > > > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > > > > > > > > ---
> > > > > >
> > > > > >
> > > > > > > > > +    tcpm {
> > > > > > > > > +        connector {
> > > > > > > > > +            compatible = "usb-c-connector";
> > > > > > > > > +
> > > > > > > > > +            ports {
> > > > > > > > > +                #address-cells = <1>;
> > > > > > > > > +                #size-cells = <0>;
> > > > > > > > > +
> > > > > > > > > +                port@0 {
> > > > > > > > > +                    reg = <0>;
> > > > > > > > > +                    tcpm_hs_out: endpoint {
> > > > > > > > > +                        remote-endpoint = <&usb_hs_phy_in>;
> > > > > > > > > +                    };
> > > > > > > > > +                };
> > > > > > > > > +
> > > > > > > > > +                port@1 {
> > > > > > > > > +                    reg = <1>;
> > > > > > > > > +                    tcpm_ss_out: endpoint {
> > > > > > > > > +                        remote-endpoint = <&usb_ss_phy_in>;
> > > > > > > > > +                    };
> > > > > > > > > +                };
> > > > > > > > > +
> > > > > > > > > +                port@2 {
> > > > > > > > > +                    reg = <2>;
> > > > > > > > > +                    tcpm_sbu_out: endpoint {
> > > > > > > > > +                        remote-endpoint = <&sbu_mux_in>;
> > > > > > > > > +                    };
> > > > > > > > > +                };
> > > > > > > > > +            };
> > > > > > > > > +        };
> > > > > > > > > +    };
> > > > > > > > > +
> > > > > > > > > +    sbu-mux {
> > > > > > > > > +        compatible = "pericom,pi3usb102", "gpio-sbu-mux";
> > > > > > > > > +
> > > > > > > > > +        enable-gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
> > > > > > > > > +        select-gpios = <&tlmm 164 GPIO_ACTIVE_HIGH>;
> > > > > > > > > +
> > > > > > > > > +        mode-switch;
> > > > > > > > > +        orientation-switch;
> > > > > > > > > +
> > > > > > > > > +        port {
> > > > > > > > > +            sbu_mux_in: endpoint {
> > > > > > > > > +                remote-endpoint = <&tcpm_sbu_out>;
> > > > > > > > > +            };
> > > > > > > >
> > > > > > > > Don't you need a connection to whatever drives SBU? Maybe your case is
> > > > > > > > fixed because the phy does the DP/USB muxing? But the binding needs to
> > > > > > > > support the worst case which I guess would be all the muxing/switching
> > > > > > > > is done by separate board level components.
> > > > > > > >
> > > > > > >
> > > > > > > Perhaps I'm misunderstanding your request, but I think this is the worst
> > > > > > > case you're talking about.
> > > > > > >
> > > > > > > &usb_ss_phy_in is a reference to the PHY, which does switching/muxing of
> > > > > > > the SuperSpeed lanes in the connector, but the PHY provides no control
> > > > > > > over the SBU signals.
> > > > > > >
> > > > > > > So this sbu-mux is a separate component between the SBU-pads on the SoC
> > > > > > > and the usb-c-connector, referenced through he &sbu_mux_in reference.
> > > > > > >
> > > > > > >
> > > > > > > So upon e.g. a orientation switch, the typec_switch_set() call the tcpm
> > > > > > > implementation will request orientation switching from port@1 and port@2
> > > > > > > (no orientation-switch on port@0/HS pins).
> > > > > >
> > > > > > 'port@2' is supposed to define the connection to what controls SBU. The
> > > > > > mux here switches the signals, but it doesn't control them.
> > > > >
> > > > > The SBU signals are driven by the SS PHY, on behalf of the DisplayPort
> > > > > controller. These signals are  turned on/off as a result of the TCPM
> > > > > indicating the HPD state to the DisplayPort controller.
> > > > >
> > > > > There's a such not really a direct representation today of the entity
> > > > > that drives the SBU lines. It happens to be a sub-block in
> > > > > &usb_ss_phy_in, but I don't envision that we need/want any signaling
> > > > > between the TCPM and the SBU-"driver".
> > > > >
> > > > >
> > > > > I see that I missed that in the example above, your suggestion on how to
> > > > > model that relationship (TCPM - DP controller) was to add an additional
> > > > > endpoint in port@1. So that's the current design (but neither ports nor
> > > > > endpoints are significant from an implementation point of view).
> > > > >
> > > > > > The mux should sit in the middle, but the graph terminates at the mux.
> > > > > > You don't have a connection presumably because you know what the
> > > > > > connection.
> > > > >
> > > > > But do you suggest that the graph should reference the entity that
> > > > > drives the SBU signals?
> > > >
> > > > Yes, that was the original intent.
> > > >
> > >
> > > Directly from the connector, or just indirectly?
> > >
> > > > > What about the discrete mux?
> > > >
> > > > You mean the mux in this binding, right? That should be in the middle:
> > > >
> > > > DPaux --> SBUmux --> connector
> > > >
> > > > Maybe the SS phy is in there too.
> > > >
> > >
> > > The signal originally comes from the DP controller, the analog
> > > electronics lives in the SS phy, then the signal goes to the SBU mux and
> > > finally to the connector.
> > >
> > > > >
> > > > > > Perhaps because there is only 1 connector and controller.
> > > > > >
> > > > >
> > > > > There is one SBU mux, one DP controller and one SS PHY per
> > > > > usb-c-connector.
> > > > >
> > > > > > Suppose you have 2 connectors and 2 controllers which drive SBU
> > > > > > signals. Also assume that the SBU signals are completely independent
> > > > > > from what's driving the altmode SS signals. How would you describe that?
> > > > > >
> > > > >
> > > > > This is the setup we have on e.g. SC8280XP CRD; where the TCPM has two
> > > > > usb-c-connectors defined, each with their graph referencing the SS PHY,
> > > > > DP controller and respective sbu-mux.
> > > > >
> > > > > There's an incomplete example of this published at [1] (where the SS phy
> > > > > isn't represented yet - and hence there's no control over the SS lanes,
> > > > > nor is the HS lanes connected to the dwc3 for role switching).
> > > > >
> > > > > Perhaps I'm misunderstanding your concerns though?
> > > >
> > > > That looks like you can assume who drives SBU based on the DP
> > > > controller. Probably a safe assumption for DP (that DP-aux is part of
> > > > the DP controller), but I was more worried about if you can't assume
> > > > that relationship. Take HDMI for example where the DDC signals can
> > > > come from anywhere. They could be part of the HDMI bridge, a general
> > > > purpose I2C bus off the SoC, or bitbanged GPIOs. Though from what I've
> > > > read, HDMI Altmode is dead. I don't know if the need to describe the
> > > > SBU connection would apply to anything else.
> > > >
> > > > I guess this all boils down to whether the SBU mux should have a 2nd
> > > > optional port as the input for what drives it.
> > > >
> > >
> > > Are you saying that the connector should link with the mux and then the
> > > source of the signal should be daisy chained? Or that we should just
> > > link both of them as two separate endpoints from the connector?
> > 
> > The former. The data path of the signal in h/w should match in the DT
> > graph. The caveat being we don't normally show PHYs in that mix
> > because they are somewhat transparent. That's maybe becoming less true
> > with routing or muxing included in PHYs.
> > 
> 
> We have discussed and prototyped this a few times now in the Qualcomm
> community, and I am not a fan of having to add forwarding-logic to each
> implementation of a Type-C mux/switch, which in some configuration might
> have an entity behind it that needs the notifications.

I don't know if we can really escape that.


> But I don't think there's a concern for this binding (in my
> implementation), there's currently no mode/orientation switching
> happening beyond this entity.
> 
> 
> 
> That said, if we're to represent each signal path to the connector,
> I would like to bring up this problem again:
> https://lore.kernel.org/all/20220520164810.141400-1-bjorn.andersson@linaro.org/
> 
> port@0 represent the HS signals going to the connector, port@1 the SS
> signals going to the connector, port@2 the SBU signals going to the
> connector.
> 
> But I need some representation of the HPD (hot plug detection) "signal"
> (there is no actual signal path in hardware, this is a virtual
> notification) going _from_ the connector to the DisplayPort controller.

I would assume whatever entity is deciding to enable the DP signals on 
the connector would be what generates the HPD notification. I think you 
want to describe the DP signal connections and muxing, but HPD itself 
wouldn't be in the DT.

> We discussed this (perhaps in person, as there's no trace on lkml?) and
> you suggested that I use a second endpoint under port@1, instead of
> introducing a fourth port.

Multiple endpoints on a port are typically a mux or fanout depending on 
the data direction. But the muxing is not really in the connector, so 
that should probably be represented somewhere else. I think a new port 
suffers from the same issue. Maybe that's close enough? Depends if there 
are cases of more alt modes or more complicated muxing/switching.

> I'm fine either way, but I don't think it would be convenient nor
> representable to daisy chain this behind any of the existing endpoints;
> none of the other endpoints should deal with the HPD signal and the
> direct of_graph-link between the usb-c-connector and the DP controller
> mimics that of e.g. dp-connector very nicely, both in description and
> implementation.

That would be nice, but the reality is there's a lot more between DP and 
the connector with USB-C and the graph should reflect that. I guess the 
problem there is being able to walk the graph. Suppose we have:

DP out port -> altmode mux in port -> altmode mux out port -> type-c 
port 1

The issue walking the graph here would be generic code doesn't know 
altmode mux port numbering as that's not a generic thing (could be 
perhaps?). Maybe you can walk from each end and see if you end up in 
the same device.

Of course, I haven't even considered the split cases where it's not 
just either USB3 OR DP, but combinations. 


What I'd really like to see for all this USB-C stuff is block diagrams 
of the h/w components and then what the corresponding DT looks like. 
Trying to extend things one piece at a time is hard to review and not 
likely going to end with a flexible design.

Rob
