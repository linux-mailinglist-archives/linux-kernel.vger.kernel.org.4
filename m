Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950C767A8C8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 03:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjAYCba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 21:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjAYCb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 21:31:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5AE4FCD2;
        Tue, 24 Jan 2023 18:31:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFF6E60B86;
        Wed, 25 Jan 2023 02:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC4BC433D2;
        Wed, 25 Jan 2023 02:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674613886;
        bh=NBX/blGlwDBKb3igPy4FDMOM/6jUfFSl0WokYfrca10=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=INBbHYypNrQzveNOSA5FUAJe+8K5xCI+biqYM2Pl4XneItNpeMj48LhRJaj33Xp/m
         ueizjYcNxdDarHRH3iM3h6fA4Rx7imJnfTfxGyPPpje5vdmQvtdn1871Sb0qu44x55
         sh6pawDf4CAbUwra7Bzk8YS5mI8uudLY8mzoGpWVN2VYLPDx8zeSsngSjtDCrcHfJ+
         rxqIfYPK2N8tJczgKReFyDGTqP6gcuQj8bQq3fB+xIUmSX318+pYiiRaRaJ2fIyYJJ
         O999jqdz7df5YU495eWJjD5bJqhtGEqxkBGEjgWkOHIDA9/DMTVS8UzCwSQDg7vZF5
         qLg6vRPSyFHoA==
Received: by mail-vk1-f181.google.com with SMTP id z190so8572223vka.4;
        Tue, 24 Jan 2023 18:31:26 -0800 (PST)
X-Gm-Message-State: AFqh2kpYVnf0vH2cEes6z4ef6h0PwrmqFfTUi/AnLFtvpormUJiAOf3P
        kl4X7sAQvkfTGXE/Qi5+dEyMrBotURN7g8PCgw==
X-Google-Smtp-Source: AMrXdXs8yM2Cl/cIggjtO1zM//fyI5Fuwb1Y2r2y3uqsvvj51ZUl4d9iXHWDny8meYkWtKkJ7H+J/eTqrBTmu3iY5Bw=
X-Received: by 2002:a1f:1797:0:b0:3e1:6f10:db58 with SMTP id
 145-20020a1f1797000000b003e16f10db58mr4073846vkx.19.1674613885155; Tue, 24
 Jan 2023 18:31:25 -0800 (PST)
MIME-Version: 1.0
References: <20230113041115.4189210-1-quic_bjorande@quicinc.com>
 <20230117175657.GA3275060-robh@kernel.org> <20230118180811.GB3322341@hu-bjorande-lv.qualcomm.com>
 <20230119161132.GA1880784-robh@kernel.org> <20230119173954.GB3899167@hu-bjorande-lv.qualcomm.com>
 <CAL_Jsq+4t09XDkF0dbh+aOyTz80SY18EpRBdoGpLqQBuCPQ5=Q@mail.gmail.com> <20230124170437.GA1209567@hu-bjorande-lv.qualcomm.com>
In-Reply-To: <20230124170437.GA1209567@hu-bjorande-lv.qualcomm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 24 Jan 2023 20:31:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL+-updMkZ7AZoKPdU==PPdVv7qZC2MFc7Xw_PSo7QPGw@mail.gmail.com>
Message-ID: <CAL_JsqL+-updMkZ7AZoKPdU==PPdVv7qZC2MFc7Xw_PSo7QPGw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Introduce GPIO-based SBU mux
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 11:04 AM Bjorn Andersson
<quic_bjorande@quicinc.com> wrote:
>
> On Tue, Jan 24, 2023 at 10:00:12AM -0600, Rob Herring wrote:
> > On Thu, Jan 19, 2023 at 11:40 AM Bjorn Andersson
> > <quic_bjorande@quicinc.com> wrote:
> > >
> > > On Thu, Jan 19, 2023 at 10:11:32AM -0600, Rob Herring wrote:
> > > > On Wed, Jan 18, 2023 at 10:08:11AM -0800, Bjorn Andersson wrote:
> > > > > On Tue, Jan 17, 2023 at 11:56:57AM -0600, Rob Herring wrote:
> > > > > > On Thu, Jan 12, 2023 at 08:11:14PM -0800, Bjorn Andersson wrote:
> > > > > > > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > > > >
> > > > > > > Introduce a binding for GPIO-based mux hardware used for connecting,
> > > > > > > disconnecting and switching orientation of the SBU lines in USB Type-C
> > > > > > > applications.
> > > > > > >
> > > > > > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > > > > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > > > > > > ---
> > > >
> > > >
> > > > > > > +    tcpm {
> > > > > > > +        connector {
> > > > > > > +            compatible = "usb-c-connector";
> > > > > > > +
> > > > > > > +            ports {
> > > > > > > +                #address-cells = <1>;
> > > > > > > +                #size-cells = <0>;
> > > > > > > +
> > > > > > > +                port@0 {
> > > > > > > +                    reg = <0>;
> > > > > > > +                    tcpm_hs_out: endpoint {
> > > > > > > +                        remote-endpoint = <&usb_hs_phy_in>;
> > > > > > > +                    };
> > > > > > > +                };
> > > > > > > +
> > > > > > > +                port@1 {
> > > > > > > +                    reg = <1>;
> > > > > > > +                    tcpm_ss_out: endpoint {
> > > > > > > +                        remote-endpoint = <&usb_ss_phy_in>;
> > > > > > > +                    };
> > > > > > > +                };
> > > > > > > +
> > > > > > > +                port@2 {
> > > > > > > +                    reg = <2>;
> > > > > > > +                    tcpm_sbu_out: endpoint {
> > > > > > > +                        remote-endpoint = <&sbu_mux_in>;
> > > > > > > +                    };
> > > > > > > +                };
> > > > > > > +            };
> > > > > > > +        };
> > > > > > > +    };
> > > > > > > +
> > > > > > > +    sbu-mux {
> > > > > > > +        compatible = "pericom,pi3usb102", "gpio-sbu-mux";
> > > > > > > +
> > > > > > > +        enable-gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
> > > > > > > +        select-gpios = <&tlmm 164 GPIO_ACTIVE_HIGH>;
> > > > > > > +
> > > > > > > +        mode-switch;
> > > > > > > +        orientation-switch;
> > > > > > > +
> > > > > > > +        port {
> > > > > > > +            sbu_mux_in: endpoint {
> > > > > > > +                remote-endpoint = <&tcpm_sbu_out>;
> > > > > > > +            };
> > > > > >
> > > > > > Don't you need a connection to whatever drives SBU? Maybe your case is
> > > > > > fixed because the phy does the DP/USB muxing? But the binding needs to
> > > > > > support the worst case which I guess would be all the muxing/switching
> > > > > > is done by separate board level components.
> > > > > >
> > > > >
> > > > > Perhaps I'm misunderstanding your request, but I think this is the worst
> > > > > case you're talking about.
> > > > >
> > > > > &usb_ss_phy_in is a reference to the PHY, which does switching/muxing of
> > > > > the SuperSpeed lanes in the connector, but the PHY provides no control
> > > > > over the SBU signals.
> > > > >
> > > > > So this sbu-mux is a separate component between the SBU-pads on the SoC
> > > > > and the usb-c-connector, referenced through he &sbu_mux_in reference.
> > > > >
> > > > >
> > > > > So upon e.g. a orientation switch, the typec_switch_set() call the tcpm
> > > > > implementation will request orientation switching from port@1 and port@2
> > > > > (no orientation-switch on port@0/HS pins).
> > > >
> > > > 'port@2' is supposed to define the connection to what controls SBU. The
> > > > mux here switches the signals, but it doesn't control them.
> > >
> > > The SBU signals are driven by the SS PHY, on behalf of the DisplayPort
> > > controller. These signals are  turned on/off as a result of the TCPM
> > > indicating the HPD state to the DisplayPort controller.
> > >
> > > There's a such not really a direct representation today of the entity
> > > that drives the SBU lines. It happens to be a sub-block in
> > > &usb_ss_phy_in, but I don't envision that we need/want any signaling
> > > between the TCPM and the SBU-"driver".
> > >
> > >
> > > I see that I missed that in the example above, your suggestion on how to
> > > model that relationship (TCPM - DP controller) was to add an additional
> > > endpoint in port@1. So that's the current design (but neither ports nor
> > > endpoints are significant from an implementation point of view).
> > >
> > > > The mux should sit in the middle, but the graph terminates at the mux.
> > > > You don't have a connection presumably because you know what the
> > > > connection.
> > >
> > > But do you suggest that the graph should reference the entity that
> > > drives the SBU signals?
> >
> > Yes, that was the original intent.
> >
>
> Directly from the connector, or just indirectly?
>
> > > What about the discrete mux?
> >
> > You mean the mux in this binding, right? That should be in the middle:
> >
> > DPaux --> SBUmux --> connector
> >
> > Maybe the SS phy is in there too.
> >
>
> The signal originally comes from the DP controller, the analog
> electronics lives in the SS phy, then the signal goes to the SBU mux and
> finally to the connector.
>
> > >
> > > > Perhaps because there is only 1 connector and controller.
> > > >
> > >
> > > There is one SBU mux, one DP controller and one SS PHY per
> > > usb-c-connector.
> > >
> > > > Suppose you have 2 connectors and 2 controllers which drive SBU
> > > > signals. Also assume that the SBU signals are completely independent
> > > > from what's driving the altmode SS signals. How would you describe that?
> > > >
> > >
> > > This is the setup we have on e.g. SC8280XP CRD; where the TCPM has two
> > > usb-c-connectors defined, each with their graph referencing the SS PHY,
> > > DP controller and respective sbu-mux.
> > >
> > > There's an incomplete example of this published at [1] (where the SS phy
> > > isn't represented yet - and hence there's no control over the SS lanes,
> > > nor is the HS lanes connected to the dwc3 for role switching).
> > >
> > > Perhaps I'm misunderstanding your concerns though?
> >
> > That looks like you can assume who drives SBU based on the DP
> > controller. Probably a safe assumption for DP (that DP-aux is part of
> > the DP controller), but I was more worried about if you can't assume
> > that relationship. Take HDMI for example where the DDC signals can
> > come from anywhere. They could be part of the HDMI bridge, a general
> > purpose I2C bus off the SoC, or bitbanged GPIOs. Though from what I've
> > read, HDMI Altmode is dead. I don't know if the need to describe the
> > SBU connection would apply to anything else.
> >
> > I guess this all boils down to whether the SBU mux should have a 2nd
> > optional port as the input for what drives it.
> >
>
> Are you saying that the connector should link with the mux and then the
> source of the signal should be daisy chained? Or that we should just
> link both of them as two separate endpoints from the connector?

The former. The data path of the signal in h/w should match in the DT
graph. The caveat being we don't normally show PHYs in that mix
because they are somewhat transparent. That's maybe becoming less true
with routing or muxing included in PHYs.

Rob
