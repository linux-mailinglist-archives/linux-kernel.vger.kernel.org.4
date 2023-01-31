Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C5D683ACE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 00:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjAaX6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 18:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjAaX6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 18:58:41 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DECC72A8;
        Tue, 31 Jan 2023 15:58:40 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VNeDDi018846;
        Tue, 31 Jan 2023 23:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=TG0M5gWpFe21mBuXZasqDgHnDl7WU7Xs/Y57d1jNEko=;
 b=LnQvEWxquyqesQGN9EEw8/dmEqiFSRW227IFi/vpXOWecg88qOMGWGblURXhOqWHAHYA
 zGgzA9AbYczDkZ1B+7kE6M0t8MSaUyL5R4RXzMCCeSlF4ZA+Zu9bxKDf00LENTz7vcOb
 CjEv96wJ33v0CDKM0Th9GUlT2QbSpoyqXrMhcgISXlbWNe4ErRvN2UyS/rb4xRhc9lwZ
 URrsQzC6iosx4w6Ld39Zgi8i1CrDdPEOauePIGhUjQMbNphTVV3E9Rijt+fDwmN2Tklp
 WCVtk1jkD2FoLYY92gZTFO/ZAP73fs4l4BDttjf3LYAgi1wIg6AyDoh0WUEaF7E93HnP fw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nf70sgqh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 23:58:35 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30VNwZEr003853
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 23:58:35 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 31 Jan 2023 15:58:34 -0800
Date:   Tue, 31 Jan 2023 15:58:33 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Introduce GPIO-based SBU mux
Message-ID: <20230131235833.GA1647930@hu-bjorande-lv.qualcomm.com>
References: <20230118180811.GB3322341@hu-bjorande-lv.qualcomm.com>
 <20230119161132.GA1880784-robh@kernel.org>
 <20230119173954.GB3899167@hu-bjorande-lv.qualcomm.com>
 <CAL_Jsq+4t09XDkF0dbh+aOyTz80SY18EpRBdoGpLqQBuCPQ5=Q@mail.gmail.com>
 <20230124170437.GA1209567@hu-bjorande-lv.qualcomm.com>
 <CAL_JsqL+-updMkZ7AZoKPdU==PPdVv7qZC2MFc7Xw_PSo7QPGw@mail.gmail.com>
 <20230125234013.GA2132606@hu-bjorande-lv.qualcomm.com>
 <20230130164813.GA2730437-robh@kernel.org>
 <20230130214214.GA953860@hu-bjorande-lv.qualcomm.com>
 <20230131194405.GA3793867-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230131194405.GA3793867-robh@kernel.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Q9CY0WF9x-cUJA1b7DaA4oc-L5ATCih-
X-Proofpoint-ORIG-GUID: Q9CY0WF9x-cUJA1b7DaA4oc-L5ATCih-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 spamscore=0
 mlxscore=0 malwarescore=0 impostorscore=0 bulkscore=0 clxscore=1015
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310205
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 01:44:05PM -0600, Rob Herring wrote:
> On Mon, Jan 30, 2023 at 01:42:14PM -0800, Bjorn Andersson wrote:
> > On Mon, Jan 30, 2023 at 10:48:13AM -0600, Rob Herring wrote:
> > > On Wed, Jan 25, 2023 at 03:40:13PM -0800, Bjorn Andersson wrote:
> > > > On Tue, Jan 24, 2023 at 08:31:13PM -0600, Rob Herring wrote:
> > > > > On Tue, Jan 24, 2023 at 11:04 AM Bjorn Andersson
> > > > > <quic_bjorande@quicinc.com> wrote:
[..]
> > This is the design we have in a range of different boards:
> 
> *This* is what I need for every Type-C binding.
> 

Glad you like it.

> > 
> >                      +------------- - -
> >  USB connector       | SoC
> >  +-+                 |   +--------+    +-------+
> >  | |                 |   |        |    |       |
> >  |*|<------- HS -----|-->| HS phy |<-->| (EUD) |<--+
> >  | |                 |   |        |    |       |   |   +--------+
> >  | |                 |   +--------+    +-------+   +-->|        |
> >  | |                 |                                 |  dwc3  |
> >  | |                 |   +--------+        /---------->|        |
> >  | |   +----------+  |   |        |<------/            +--------+
> >  |*|<--|(redriver)|<-|-->| SS phy |
> >  | |   +----------+  |   |        |<-\   +------------+
> >  | |                 |   +--------+   \->|            |
> >  | |                 |                   |     DP     |
> >  | |     +-----+     |                   | controller |
> >  |*|<--->| SBU |<----|------------------>|            |
> >  | |     | mux |     |                   |            |
> >  | |     +----+      |                   +------------+
> >  +-+                 |
> >                      +------------- - -
> 
> Where's the TCPM?
> 

The TCPM here becomes the implementation behind one more more
USB connectors.

> 
> > The EUD and redriver are only found/used in some designs.  My proposed
> > representation of this (without those) is:
> 
> I'd assume a redriver is mostly transparent to s/w?
> 

There are both cases. But per our discussion (summarized below), each
entity in the graph should represent the actual signal path.  So in the
case where it need to be represented in the signal path, the
implementation would have to deal with it being the port@1
remote-endpoint.

> 
> > 
> > /soc {
> >     usb-controller {
> >         dwc3 {
> >             port {
> >                 dwc0-out: endpoint {
> >                     remote-endpoint = <&connector0_hs>;
> >             };
> >         };
> >     };
> > 
> >     ss_phy: phy {
> >         port {
> >             ss_phy_out: endpoint {
> >                 remote-endpoint = <&connector0_ss>;
> >             };
> >         };
> >     };
> > 
> >     display-subsystem {
> >         displayport-controller {
> >             phys = <&ss_phy>;
> >             ports {
> >                 port@1 {
> >                     reg = <1>;
> >                     dp0_out: endpoint {
> >                         remote-endpoint = <&connector0_hpd>;
> >                     };
> >                 };
> >             };
> >         };
> >     };
> > };
> > 
> > usb0-sbu-mux {
> >     compatible = "gpio-sbu-mux";
> > 
> >     port {
> >         sbu0_out: endpoint {
> >             remote-endpoint = <&connector_sbu>;
> >         };
> >     };
> > };
> > 
> > tcpm {
> >     connector@0 {
> >         compatible = "usb-c-connector";
> >         reg = <0>;
> >         ports {
> >             port@0 {
> >                 reg = <0>;
> >                 connector0_hs: endpoint {
> >                     remote-endpoint = <&dwc0_out>;
> >                 };
> >             };
> > 
> >             port@1 {
> >                 reg = <1>;
> >                 connector0_ss: endpoint@0 {
> >                     remote-endpoint = <&ss_phy_out>;
> >                 };
> >                 connector0_hpd: endpoint@1 {
> >                     remote-endpoint = <&dp0_out>;
> >                 };
> 
> This just looks wrong to me because one connection is the output of the 
> phy's mux and one is the input. The USB SS connection is implicit, but I 
> think it should be explicit from dwc3 to ss_phy. It would need an output 
> port and 2 input ports. I want to say we already have bindings doing 
> this.
> 

Right, endpoint@0 represents the actual signal path, while endpoint@1
represents the display signal source or HPD destination.

It does look weird, but that's what we agreed upon in a previous
iteration.

> >             };
> > 
> >             port@2 {
> >                 reg = <2>;
> >                     connector_sbu: endpoint {
> >                         remote-endpoint = <&sbu0_out>;
> >                 };
> >             };
> >         };
> >     };
> > };
> > 
[..]
> > 
> > /dp-connector {
> >     compatible = "dp-connector";
> > 
> >     port {
> >         connector: endpoint {
> >             remote-endpoint = <&dp_out>;
> >         };
> >     };
> > };
> > 
> > /soc {
> >     display-subsystem {
> >         displayport-controller {
> >             phys = <&some_dp_phy>;
> >             ports {
> >                 port@1 {
> >                     reg = <1>;
> >                     dp_out: endpoint {
> >                         remote-endpoint = <&connector>;
> >                     };
> >                 };
> >             };
> >         };
> >     };
> > };
> > 
> > As you said previously, it doesn't make sense to represent the phy in this
> > graph. We just define the output of the controller as port@1 and link that to
> > the connector.
> 
> What I said (or meant) was we don't represent phys which are just 
> providing the electrical interface. Your 'phy' is also a mux/switch, so 
> it does make sense to represent it in the graph.
> 

Attempting to summarize our lengthy discussion on IRC.

The output port of the display block represents the signal path.

In the even that the associated phy is merely a dumb D/A converter, the
next logical entity on that path is the connector, such as the
dp-connector example above.

If, on the other hand, the phy, or any other component, on the signal path
is doing more than just electrical conversion, it should be represented
in the DT and linked using the of-graph.

As such, in the case where the phy is involved in e.g. orientation
switching, the output (port@1 in the Qualcomm DP binding) of the
display block should be tied to the phy, and then the phy should be
connected to the next entity on the path (e.g. the usb-c-connector).

In both cases, the phys property can be seen as representing the
"control interface", and the graph is used to represent the signal path.

> > 
> > So what is the output of the dp controller in the USB case - if we're not
> > representing that as the HPD link directly between the connector and the
> > controller?
> 
> The answer lies in your block diagram... 
> 

So, each (active) component in the diagram should be represented in the
Devicetree and the links between them should be represented by
of-graphs.

> The question I think is whether we could standardize the mux/switch 
> graph ports. Say 'port@0' is the output to type-C connector port@1, 
> and port@[1-9] are altmode connections to USB/DP/TB. If we did that, 
> then generic code can walk the graph from a controller to the connector. 
> We only need to know that port@0 goes to the connector.

In the display bindings today, we use port@0 for in and port@1 for
out, but it doesn't some universal.

> However, that assumes there is only 1 entity in the middle and I don't
> know if that holds true.
> 

We've seen examples of redrivers or the ChromeOS switch, where this
doesn't hold. In the latter we have two outputs (one being active at a
time)...

Regards,
Bjorn
