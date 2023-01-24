Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BDA67A04A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbjAXRgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjAXRgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:36:47 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF5017171;
        Tue, 24 Jan 2023 09:36:45 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OG9K2P030062;
        Tue, 24 Jan 2023 17:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=eWV1NkcVm5xcWqDAndxjFtGjnMLN5/CF8PkfvUkOpxU=;
 b=jI/MwYdi3uF2LK6mDmJZ4Xd/IdhnyrVSaHIh5x65JncNqTfeL9jXaKSKhORTmJfg1muE
 Hf2Lmk9Ph4QPG41voXAo4nbxNXsKa29W9tB3F0ReNNMm+cdV2gLCaCm9/JKsJAAaGpDD
 SdNRigvuq4kroSnLvmxMlmbtA9XPi39/rAp5ZR1k5vH8L0yAizHBOJgtrrLLERj9r2yO
 6dpjMlMEf+2p0YIkPbnrT5crcNV95EJ7XGMMFJBIap5Z3qT0NmdP4Jg3xazYUTpmcOwo
 CpsfxM6LyRaXHNw54LNE+2fj1z3bxKObU5gFEE0mJp1uS0QjMWLkR1YxF6Nk9cYQoQJy qA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3najkh8663-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 17:04:40 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30OH4duX001080
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 17:04:39 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 24 Jan 2023 09:04:38 -0800
Date:   Tue, 24 Jan 2023 09:04:37 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Introduce GPIO-based SBU mux
Message-ID: <20230124170437.GA1209567@hu-bjorande-lv.qualcomm.com>
References: <20230113041115.4189210-1-quic_bjorande@quicinc.com>
 <20230117175657.GA3275060-robh@kernel.org>
 <20230118180811.GB3322341@hu-bjorande-lv.qualcomm.com>
 <20230119161132.GA1880784-robh@kernel.org>
 <20230119173954.GB3899167@hu-bjorande-lv.qualcomm.com>
 <CAL_Jsq+4t09XDkF0dbh+aOyTz80SY18EpRBdoGpLqQBuCPQ5=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+4t09XDkF0dbh+aOyTz80SY18EpRBdoGpLqQBuCPQ5=Q@mail.gmail.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hvfFUEO8T6MTkVPxNVc7gc_RdK1KFBtY
X-Proofpoint-GUID: hvfFUEO8T6MTkVPxNVc7gc_RdK1KFBtY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_13,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=823 clxscore=1015
 lowpriorityscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240155
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 10:00:12AM -0600, Rob Herring wrote:
> On Thu, Jan 19, 2023 at 11:40 AM Bjorn Andersson
> <quic_bjorande@quicinc.com> wrote:
> >
> > On Thu, Jan 19, 2023 at 10:11:32AM -0600, Rob Herring wrote:
> > > On Wed, Jan 18, 2023 at 10:08:11AM -0800, Bjorn Andersson wrote:
> > > > On Tue, Jan 17, 2023 at 11:56:57AM -0600, Rob Herring wrote:
> > > > > On Thu, Jan 12, 2023 at 08:11:14PM -0800, Bjorn Andersson wrote:
> > > > > > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > > >
> > > > > > Introduce a binding for GPIO-based mux hardware used for connecting,
> > > > > > disconnecting and switching orientation of the SBU lines in USB Type-C
> > > > > > applications.
> > > > > >
> > > > > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > > > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > > > > > ---
> > >
> > >
> > > > > > +    tcpm {
> > > > > > +        connector {
> > > > > > +            compatible = "usb-c-connector";
> > > > > > +
> > > > > > +            ports {
> > > > > > +                #address-cells = <1>;
> > > > > > +                #size-cells = <0>;
> > > > > > +
> > > > > > +                port@0 {
> > > > > > +                    reg = <0>;
> > > > > > +                    tcpm_hs_out: endpoint {
> > > > > > +                        remote-endpoint = <&usb_hs_phy_in>;
> > > > > > +                    };
> > > > > > +                };
> > > > > > +
> > > > > > +                port@1 {
> > > > > > +                    reg = <1>;
> > > > > > +                    tcpm_ss_out: endpoint {
> > > > > > +                        remote-endpoint = <&usb_ss_phy_in>;
> > > > > > +                    };
> > > > > > +                };
> > > > > > +
> > > > > > +                port@2 {
> > > > > > +                    reg = <2>;
> > > > > > +                    tcpm_sbu_out: endpoint {
> > > > > > +                        remote-endpoint = <&sbu_mux_in>;
> > > > > > +                    };
> > > > > > +                };
> > > > > > +            };
> > > > > > +        };
> > > > > > +    };
> > > > > > +
> > > > > > +    sbu-mux {
> > > > > > +        compatible = "pericom,pi3usb102", "gpio-sbu-mux";
> > > > > > +
> > > > > > +        enable-gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
> > > > > > +        select-gpios = <&tlmm 164 GPIO_ACTIVE_HIGH>;
> > > > > > +
> > > > > > +        mode-switch;
> > > > > > +        orientation-switch;
> > > > > > +
> > > > > > +        port {
> > > > > > +            sbu_mux_in: endpoint {
> > > > > > +                remote-endpoint = <&tcpm_sbu_out>;
> > > > > > +            };
> > > > >
> > > > > Don't you need a connection to whatever drives SBU? Maybe your case is
> > > > > fixed because the phy does the DP/USB muxing? But the binding needs to
> > > > > support the worst case which I guess would be all the muxing/switching
> > > > > is done by separate board level components.
> > > > >
> > > >
> > > > Perhaps I'm misunderstanding your request, but I think this is the worst
> > > > case you're talking about.
> > > >
> > > > &usb_ss_phy_in is a reference to the PHY, which does switching/muxing of
> > > > the SuperSpeed lanes in the connector, but the PHY provides no control
> > > > over the SBU signals.
> > > >
> > > > So this sbu-mux is a separate component between the SBU-pads on the SoC
> > > > and the usb-c-connector, referenced through he &sbu_mux_in reference.
> > > >
> > > >
> > > > So upon e.g. a orientation switch, the typec_switch_set() call the tcpm
> > > > implementation will request orientation switching from port@1 and port@2
> > > > (no orientation-switch on port@0/HS pins).
> > >
> > > 'port@2' is supposed to define the connection to what controls SBU. The
> > > mux here switches the signals, but it doesn't control them.
> >
> > The SBU signals are driven by the SS PHY, on behalf of the DisplayPort
> > controller. These signals are  turned on/off as a result of the TCPM
> > indicating the HPD state to the DisplayPort controller.
> >
> > There's a such not really a direct representation today of the entity
> > that drives the SBU lines. It happens to be a sub-block in
> > &usb_ss_phy_in, but I don't envision that we need/want any signaling
> > between the TCPM and the SBU-"driver".
> >
> >
> > I see that I missed that in the example above, your suggestion on how to
> > model that relationship (TCPM - DP controller) was to add an additional
> > endpoint in port@1. So that's the current design (but neither ports nor
> > endpoints are significant from an implementation point of view).
> >
> > > The mux should sit in the middle, but the graph terminates at the mux.
> > > You don't have a connection presumably because you know what the
> > > connection.
> >
> > But do you suggest that the graph should reference the entity that
> > drives the SBU signals?
> 
> Yes, that was the original intent.
> 

Directly from the connector, or just indirectly?

> > What about the discrete mux?
> 
> You mean the mux in this binding, right? That should be in the middle:
> 
> DPaux --> SBUmux --> connector
> 
> Maybe the SS phy is in there too.
> 

The signal originally comes from the DP controller, the analog
electronics lives in the SS phy, then the signal goes to the SBU mux and
finally to the connector.

> >
> > > Perhaps because there is only 1 connector and controller.
> > >
> >
> > There is one SBU mux, one DP controller and one SS PHY per
> > usb-c-connector.
> >
> > > Suppose you have 2 connectors and 2 controllers which drive SBU
> > > signals. Also assume that the SBU signals are completely independent
> > > from what's driving the altmode SS signals. How would you describe that?
> > >
> >
> > This is the setup we have on e.g. SC8280XP CRD; where the TCPM has two
> > usb-c-connectors defined, each with their graph referencing the SS PHY,
> > DP controller and respective sbu-mux.
> >
> > There's an incomplete example of this published at [1] (where the SS phy
> > isn't represented yet - and hence there's no control over the SS lanes,
> > nor is the HS lanes connected to the dwc3 for role switching).
> >
> > Perhaps I'm misunderstanding your concerns though?
> 
> That looks like you can assume who drives SBU based on the DP
> controller. Probably a safe assumption for DP (that DP-aux is part of
> the DP controller), but I was more worried about if you can't assume
> that relationship. Take HDMI for example where the DDC signals can
> come from anywhere. They could be part of the HDMI bridge, a general
> purpose I2C bus off the SoC, or bitbanged GPIOs. Though from what I've
> read, HDMI Altmode is dead. I don't know if the need to describe the
> SBU connection would apply to anything else.
> 
> I guess this all boils down to whether the SBU mux should have a 2nd
> optional port as the input for what drives it.
> 

Are you saying that the connector should link with the mux and then the
source of the signal should be daisy chained? Or that we should just
link both of them as two separate endpoints from the connector?

Regards,
Bjorn
