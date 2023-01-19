Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E528674025
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjASRkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjASRkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:40:09 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AE075A3E;
        Thu, 19 Jan 2023 09:40:05 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JGOIO4017445;
        Thu, 19 Jan 2023 17:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=EoGJQVVJ9xKpNBy0RBATI0NdzK40bf1BZRAPYrSNq+0=;
 b=l1sp/DJEk9yBsJ4KaoRcpCSHeSzPxsZB35mGT9tair3umQJz1Vl6ItwsFKD20gNRdFba
 AmP5wtqVcYjuqYzSVIzSHwgnszv+4sTKSkArrJ9Q+z2nrMP5vnHEoLec5uAF04DCQVnO
 7HwSJsdxSV0atAuh6GVuhzj1/2Ms2VPQ/CgRYQRVZy2xxJgdFRKcyyErvg+Ct3NrveKz
 7Rs9wZ58HNSZxBE2275jvJ45x9xKkDUoWARbddXLnIM3CyaRSJCFF1Ges90LZJeQ2dZv
 jBGkgd7qOPsi7q8w+mGCLM5ouYDk8QRh2ELn76oO0RpS2SYBqcXGSvRpaBhS3qIXccVZ /w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n700ysqu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 17:39:56 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30JHdtpA007981
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 17:39:55 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 19 Jan 2023 09:39:55 -0800
Date:   Thu, 19 Jan 2023 09:39:54 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Introduce GPIO-based SBU mux
Message-ID: <20230119173954.GB3899167@hu-bjorande-lv.qualcomm.com>
References: <20230113041115.4189210-1-quic_bjorande@quicinc.com>
 <20230117175657.GA3275060-robh@kernel.org>
 <20230118180811.GB3322341@hu-bjorande-lv.qualcomm.com>
 <20230119161132.GA1880784-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230119161132.GA1880784-robh@kernel.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: px6X3ChF-eumE99WeY5k1Br_m_Jdebfh
X-Proofpoint-ORIG-GUID: px6X3ChF-eumE99WeY5k1Br_m_Jdebfh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_11,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 bulkscore=0 phishscore=0
 mlxlogscore=802 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 10:11:32AM -0600, Rob Herring wrote:
> On Wed, Jan 18, 2023 at 10:08:11AM -0800, Bjorn Andersson wrote:
> > On Tue, Jan 17, 2023 at 11:56:57AM -0600, Rob Herring wrote:
> > > On Thu, Jan 12, 2023 at 08:11:14PM -0800, Bjorn Andersson wrote:
> > > > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > 
> > > > Introduce a binding for GPIO-based mux hardware used for connecting,
> > > > disconnecting and switching orientation of the SBU lines in USB Type-C
> > > > applications.
> > > > 
> > > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > > > ---
> 
> 
> > > > +    tcpm {
> > > > +        connector {
> > > > +            compatible = "usb-c-connector";
> > > > +
> > > > +            ports {
> > > > +                #address-cells = <1>;
> > > > +                #size-cells = <0>;
> > > > +
> > > > +                port@0 {
> > > > +                    reg = <0>;
> > > > +                    tcpm_hs_out: endpoint {
> > > > +                        remote-endpoint = <&usb_hs_phy_in>;
> > > > +                    };
> > > > +                };
> > > > +
> > > > +                port@1 {
> > > > +                    reg = <1>;
> > > > +                    tcpm_ss_out: endpoint {
> > > > +                        remote-endpoint = <&usb_ss_phy_in>;
> > > > +                    };
> > > > +                };
> > > > +
> > > > +                port@2 {
> > > > +                    reg = <2>;
> > > > +                    tcpm_sbu_out: endpoint {
> > > > +                        remote-endpoint = <&sbu_mux_in>;
> > > > +                    };
> > > > +                };
> > > > +            };
> > > > +        };
> > > > +    };
> > > > +
> > > > +    sbu-mux {
> > > > +        compatible = "pericom,pi3usb102", "gpio-sbu-mux";
> > > > +
> > > > +        enable-gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
> > > > +        select-gpios = <&tlmm 164 GPIO_ACTIVE_HIGH>;
> > > > +
> > > > +        mode-switch;
> > > > +        orientation-switch;
> > > > +
> > > > +        port {
> > > > +            sbu_mux_in: endpoint {
> > > > +                remote-endpoint = <&tcpm_sbu_out>;
> > > > +            };
> > > 
> > > Don't you need a connection to whatever drives SBU? Maybe your case is 
> > > fixed because the phy does the DP/USB muxing? But the binding needs to 
> > > support the worst case which I guess would be all the muxing/switching 
> > > is done by separate board level components.
> > > 
> > 
> > Perhaps I'm misunderstanding your request, but I think this is the worst
> > case you're talking about.
> > 
> > &usb_ss_phy_in is a reference to the PHY, which does switching/muxing of
> > the SuperSpeed lanes in the connector, but the PHY provides no control
> > over the SBU signals.
> > 
> > So this sbu-mux is a separate component between the SBU-pads on the SoC
> > and the usb-c-connector, referenced through he &sbu_mux_in reference.
> > 
> > 
> > So upon e.g. a orientation switch, the typec_switch_set() call the tcpm
> > implementation will request orientation switching from port@1 and port@2
> > (no orientation-switch on port@0/HS pins).
> 
> 'port@2' is supposed to define the connection to what controls SBU. The 
> mux here switches the signals, but it doesn't control them.

The SBU signals are driven by the SS PHY, on behalf of the DisplayPort
controller. These signals are  turned on/off as a result of the TCPM
indicating the HPD state to the DisplayPort controller.

There's a such not really a direct representation today of the entity
that drives the SBU lines. It happens to be a sub-block in
&usb_ss_phy_in, but I don't envision that we need/want any signaling
between the TCPM and the SBU-"driver".


I see that I missed that in the example above, your suggestion on how to
model that relationship (TCPM - DP controller) was to add an additional
endpoint in port@1. So that's the current design (but neither ports nor
endpoints are significant from an implementation point of view).

> The mux should sit in the middle, but the graph terminates at the mux.
> You don't have a connection presumably because you know what the
> connection.

But do you suggest that the graph should reference the entity that
drives the SBU signals? What about the discrete mux?

> Perhaps because there is only 1 connector and controller.
> 

There is one SBU mux, one DP controller and one SS PHY per
usb-c-connector.

> Suppose you have 2 connectors and 2 controllers which drive SBU 
> signals. Also assume that the SBU signals are completely independent 
> from what's driving the altmode SS signals. How would you describe that?
> 

This is the setup we have on e.g. SC8280XP CRD; where the TCPM has two
usb-c-connectors defined, each with their graph referencing the SS PHY,
DP controller and respective sbu-mux.

There's an incomplete example of this published at [1] (where the SS phy
isn't represented yet - and hence there's no control over the SS lanes,
nor is the HS lanes connected to the dwc3 for role switching).

Perhaps I'm misunderstanding your concerns though?

[1] https://github.com/andersson/kernel/blob/wip/sc8280xp-next-20220720/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts#L37

Regards,
Bjorn
