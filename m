Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E613681D05
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjA3Vmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjA3Vmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:42:40 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219B61BFE;
        Mon, 30 Jan 2023 13:42:23 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ULXYcI032482;
        Mon, 30 Jan 2023 21:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=h2I4/mcmSpa6R0vrAqyYrs9BdhrWylAGeV80PfRUrj8=;
 b=HhcMCSng+4l+bRIM1ry/QXdQ0WzG66MYRlgSoVGlv+W0TLqxXsLq5bLpAM4lucbZUR+E
 nQblDFw3Hcfxr1AQRqKRh9bpsGdiUXoShiUpEP5Kz/WI300/j+yGnfqYdWHcJX2An8JZ
 pzSNhFl7lcZgoHDWFVeZZF10ctSC//FG/Dhj7ZNt1Qrkyu+f4zngg4pVr90DCVoWducm
 BrPOjEntcTuYAJJ/9MVoAdcfmkR6WAFlJz8ghJKCf+ZmN5IsJHKsfqQI31ZXRKEUtjHr
 FXx6509sfS1l5iwSFrb597GQzfkPtWshCxggfENuHJ2gR5+WmMnzhhl6zND/3mIzFnN7 Rw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nefmfrvsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 21:42:16 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30ULgF1O002909
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 21:42:15 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 30 Jan 2023 13:42:15 -0800
Date:   Mon, 30 Jan 2023 13:42:14 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Introduce GPIO-based SBU mux
Message-ID: <20230130214214.GA953860@hu-bjorande-lv.qualcomm.com>
References: <20230113041115.4189210-1-quic_bjorande@quicinc.com>
 <20230117175657.GA3275060-robh@kernel.org>
 <20230118180811.GB3322341@hu-bjorande-lv.qualcomm.com>
 <20230119161132.GA1880784-robh@kernel.org>
 <20230119173954.GB3899167@hu-bjorande-lv.qualcomm.com>
 <CAL_Jsq+4t09XDkF0dbh+aOyTz80SY18EpRBdoGpLqQBuCPQ5=Q@mail.gmail.com>
 <20230124170437.GA1209567@hu-bjorande-lv.qualcomm.com>
 <CAL_JsqL+-updMkZ7AZoKPdU==PPdVv7qZC2MFc7Xw_PSo7QPGw@mail.gmail.com>
 <20230125234013.GA2132606@hu-bjorande-lv.qualcomm.com>
 <20230130164813.GA2730437-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230130164813.GA2730437-robh@kernel.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: i4epkRaagcx2TwJJ7nHqDaVH_lfa6pA1
X-Proofpoint-GUID: i4epkRaagcx2TwJJ7nHqDaVH_lfa6pA1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300201
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 10:48:13AM -0600, Rob Herring wrote:
> On Wed, Jan 25, 2023 at 03:40:13PM -0800, Bjorn Andersson wrote:
> > On Tue, Jan 24, 2023 at 08:31:13PM -0600, Rob Herring wrote:
> > > On Tue, Jan 24, 2023 at 11:04 AM Bjorn Andersson
> > > <quic_bjorande@quicinc.com> wrote:
> > > >
> > > > On Tue, Jan 24, 2023 at 10:00:12AM -0600, Rob Herring wrote:
> > > > > On Thu, Jan 19, 2023 at 11:40 AM Bjorn Andersson
> > > > > <quic_bjorande@quicinc.com> wrote:
[..]
> > > > Are you saying that the connector should link with the mux and then the
> > > > source of the signal should be daisy chained? Or that we should just
> > > > link both of them as two separate endpoints from the connector?
> > > 
> > > The former. The data path of the signal in h/w should match in the DT
> > > graph. The caveat being we don't normally show PHYs in that mix
> > > because they are somewhat transparent. That's maybe becoming less true
> > > with routing or muxing included in PHYs.
> > > 
> > 
> > We have discussed and prototyped this a few times now in the Qualcomm
> > community, and I am not a fan of having to add forwarding-logic to each
> > implementation of a Type-C mux/switch, which in some configuration might
> > have an entity behind it that needs the notifications.
> 
> I don't know if we can really escape that.
> 

Okay, we'll have to figure out how to implement that when such need come...

> 
> > But I don't think there's a concern for this binding (in my
> > implementation), there's currently no mode/orientation switching
> > happening beyond this entity.
> > 
> > 
> > 
> > That said, if we're to represent each signal path to the connector,
> > I would like to bring up this problem again:
> > https://lore.kernel.org/all/20220520164810.141400-1-bjorn.andersson@linaro.org/
> > 
> > port@0 represent the HS signals going to the connector, port@1 the SS
> > signals going to the connector, port@2 the SBU signals going to the
> > connector.
> > 
> > But I need some representation of the HPD (hot plug detection) "signal"
> > (there is no actual signal path in hardware, this is a virtual
> > notification) going _from_ the connector to the DisplayPort controller.
> 
> I would assume whatever entity is deciding to enable the DP signals on 
> the connector would be what generates the HPD notification.

The HPD notification comes from the display/connector, and is
conceptually equivalent to hpd-gpios in e.g. the dp-connector binding.

> I think you want to describe the DP signal connections and muxing, but
> HPD itself wouldn't be in the DT.
> 

Okay, so you're saying that the display driver needs to traverse the
graph representing the display-signal path, in hope to find someone
generating a HPD notification?

> > We discussed this (perhaps in person, as there's no trace on lkml?) and
> > you suggested that I use a second endpoint under port@1, instead of
> > introducing a fourth port.
> 
> Multiple endpoints on a port are typically a mux or fanout depending on 
> the data direction. But the muxing is not really in the connector, so 
> that should probably be represented somewhere else. I think a new port 
> suffers from the same issue. Maybe that's close enough? Depends if there 
> are cases of more alt modes or more complicated muxing/switching.
> 
> > I'm fine either way, but I don't think it would be convenient nor
> > representable to daisy chain this behind any of the existing endpoints;
> > none of the other endpoints should deal with the HPD signal and the
> > direct of_graph-link between the usb-c-connector and the DP controller
> > mimics that of e.g. dp-connector very nicely, both in description and
> > implementation.
> 
> That would be nice, but the reality is there's a lot more between DP and 
> the connector with USB-C and the graph should reflect that.

Not when it comes to delivering the HPD notification, afaict.

The TCPM will configure muxes & switches to ensure that the USB
connector is wired up according to what has been decided over USB PD.

The HPD signal is orthogonal to that configuration, and should not be
picked up by any of the other components.

> I guess the 
> problem there is being able to walk the graph. Suppose we have:
> 
> DP out port -> altmode mux in port -> altmode mux out port -> type-c 
> port 1
> 
> The issue walking the graph here would be generic code doesn't know 
> altmode mux port numbering as that's not a generic thing (could be 
> perhaps?). Maybe you can walk from each end and see if you end up in 
> the same device.
> 
> Of course, I haven't even considered the split cases where it's not 
> just either USB3 OR DP, but combinations. 
> 

The implementation that toggles between the DP-only and USB/DP-combo is
not stable, so we currently only support USB/DP-combo upstream.

Again, the TCPM will handle the muxing and orientation switching in the
PHY and sbu-mux, then once a datapath capable of delivering DP-altmode
data is established, it might send HPD notifications - to the display
driver.

> 
> What I'd really like to see for all this USB-C stuff is block diagrams 
> of the h/w components and then what the corresponding DT looks like. 
> Trying to extend things one piece at a time is hard to review and not 
> likely going to end with a flexible design.
> 

This is the design we have in a range of different boards:

                     +------------- - -
 USB connector       | SoC
 +-+                 |   +--------+    +-------+
 | |                 |   |        |    |       |
 |*|<------- HS -----|-->| HS phy |<-->| (EUD) |<--+
 | |                 |   |        |    |       |   |   +--------+
 | |                 |   +--------+    +-------+   +-->|        |
 | |                 |                                 |  dwc3  |
 | |                 |   +--------+        /---------->|        |
 | |   +----------+  |   |        |<------/            +--------+
 |*|<--|(redriver)|<-|-->| SS phy |
 | |   +----------+  |   |        |<-\   +------------+
 | |                 |   +--------+   \->|            |
 | |                 |                   |     DP     |
 | |     +-----+     |                   | controller |
 |*|<--->| SBU |<----|------------------>|            |
 | |     | mux |     |                   |            |
 | |     +----+      |                   +------------+
 +-+                 |
                     +------------- - -

The EUD and redriver are only found/used in some designs.  My proposed
representation of this (without those) is:

/soc {
    usb-controller {
        dwc3 {
            port {
                dwc0-out: endpoint {
                    remote-endpoint = <&connector0_hs>;
            };
        };
    };

    ss_phy: phy {
        port {
            ss_phy_out: endpoint {
                remote-endpoint = <&connector0_ss>;
            };
        };
    };

    display-subsystem {
        displayport-controller {
            phys = <&ss_phy>;
            ports {
                port@1 {
                    reg = <1>;
                    dp0_out: endpoint {
                        remote-endpoint = <&connector0_hpd>;
                    };
                };
            };
        };
    };
};

usb0-sbu-mux {
    compatible = "gpio-sbu-mux";

    port {
        sbu0_out: endpoint {
            remote-endpoint = <&connector_sbu>;
        };
    };
};

tcpm {
    connector@0 {
        compatible = "usb-c-connector";
        reg = <0>;
        ports {
            port@0 {
                reg = <0>;
                connector0_hs: endpoint {
                    remote-endpoint = <&dwc0_out>;
                };
            };

            port@1 {
                reg = <1>;
                connector0_ss: endpoint@0 {
                    remote-endpoint = <&ss_phy_out>;
                };
                connector0_hpd: endpoint@1 {
                    remote-endpoint = <&dp0_out>;
                };
            };

            port@2 {
                reg = <2>;
                    connector_sbu: endpoint {
                        remote-endpoint = <&sbu0_out>;
                };
            };
        };
    };
};

The EUD needs to be able to override the role-switch state, so the design that
was accepted was to implement the role-switch forwarding logic in the driver
and daisy chain the of-graph.

No redriver has made it to LKML, but the this is where the daisy chain vs
reference all instances from port@1 comes in.

The Type-C port manager (tcpm) might be handling multiple usb-c-connectors, in
which case the reg of the connector identifies which instance is being
described.


So I think that all these pieces fits your model, except the port@1/endpoint@1
and the fact that displayport-controller has a of_graph.


In particular we have a number of these:

/dp-connector {
    compatible = "dp-connector";

    port {
        connector: endpoint {
            remote-endpoint = <&dp_out>;
        };
    };
};

/soc {
    display-subsystem {
        displayport-controller {
            phys = <&some_dp_phy>;
            ports {
                port@1 {
                    reg = <1>;
                    dp_out: endpoint {
                        remote-endpoint = <&connector>;
                    };
                };
            };
        };
    };
};

As you said previously, it doesn't make sense to represent the phy in this
graph. We just define the output of the controller as port@1 and link that to
the connector.

So what is the output of the dp controller in the USB case - if we're not
representing that as the HPD link directly between the connector and the
controller?

Note that it's not a matter of traversing the graph, because we don't use a
graph for the connection between the controller and the PHY.

Regards,
Bjorn
