Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF143672656
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjARSJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjARSIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:08:44 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D2D59E49;
        Wed, 18 Jan 2023 10:08:25 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IHe20q023109;
        Wed, 18 Jan 2023 18:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=VjGaB6NlBlE2IyOc/pNC2n8e7KGS2UDLgRGKXfFgm70=;
 b=h42SU5g+xzOtTo/aGwOhipivIuXFl2rgMO2ApB1Cc5+B7ZC6x0QmcNcygW5MHDzXB9PU
 Tc15W3AZCsNfqG05aDyXVHleGMA+caI3qGftk+EbI2RIi94b06xZwfgwO0p+6aIrvXZH
 bzTHZCkSYLVpdNcjymKqW/pqF6LNIKLTzz3XfO9gsaDYrk06BFkVBELnYR43hmJum5v3
 ty6awGCQwX1cw5mZBq39yLF4O599chBL/43jdkJwU3b1XVyK+Nz9fjSqA1kEfUQnhQjV
 QBc7P0rczHc/c5FjITpijJ24n5+AhPJr3hrVBMf+IdYh49VD8hLoymju63RJ/Zd38ths Sw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6e4r143j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 18:08:13 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30II8DUW023627
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 18:08:13 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 18 Jan 2023 10:08:12 -0800
Date:   Wed, 18 Jan 2023 10:08:11 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Introduce GPIO-based SBU mux
Message-ID: <20230118180811.GB3322341@hu-bjorande-lv.qualcomm.com>
References: <20230113041115.4189210-1-quic_bjorande@quicinc.com>
 <20230117175657.GA3275060-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230117175657.GA3275060-robh@kernel.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1tDhuNKfhXogcIxd2n2-Jh9YFBmJcPFh
X-Proofpoint-ORIG-GUID: 1tDhuNKfhXogcIxd2n2-Jh9YFBmJcPFh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 impostorscore=0 clxscore=1011 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301180153
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 11:56:57AM -0600, Rob Herring wrote:
> On Thu, Jan 12, 2023 at 08:11:14PM -0800, Bjorn Andersson wrote:
> > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > 
> > Introduce a binding for GPIO-based mux hardware used for connecting,
> > disconnecting and switching orientation of the SBU lines in USB Type-C
> > applications.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> > 
> > Changes since v1:
> > - Expanded the example to indicate how this fits with the TCPM
> > - Updated maintainer email address.
> > 
> >  .../devicetree/bindings/usb/gpio-sbu-mux.yaml | 110 ++++++++++++++++++
> >  1 file changed, 110 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
> > new file mode 100644
> > index 000000000000..bf4b1d016e1f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
> > @@ -0,0 +1,110 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/usb/gpio-sbu-mux.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: GPIO-based SBU mux
> > +
> > +maintainers:
> > +  - Bjorn Andersson <andersson@kernel.org>
> > +
> > +description:
> > +  In USB Type-C applications the SBU lines needs to be connected, disconnected
> > +  and swapped depending on the altmode and orientation. This binding describes
> > +  a family of hardware solutions which switches between these modes using GPIO
> > +  signals.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - onnn,fsusb43l10x
> > +          - pericom,pi3usb102
> > +      - const: gpio-sbu-mux
> > +
> > +  enable-gpios:
> > +    description: Switch enable GPIO
> > +
> > +  select-gpios:
> > +    description: Orientation select
> > +
> > +  vcc-supply:
> > +    description: power supply
> > +
> > +  mode-switch:
> > +    description: Flag the port as possible handle of altmode switching
> > +    type: boolean
> > +
> > +  orientation-switch:
> > +    description: Flag the port as possible handler of orientation switching
> > +    type: boolean
> > +
> > +  port:
> > +    $ref: /schemas/graph.yaml#/properties/port
> > +    description:
> > +      A port node to link the SBU mux to a TypeC controller for the purpose of
> > +      handling altmode muxing and orientation switching.
> > +
> > +required:
> > +  - compatible
> > +  - enable-gpios
> > +  - select-gpios
> > +  - mode-switch
> > +  - orientation-switch
> > +  - port
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    tcpm {
> > +        connector {
> > +            compatible = "usb-c-connector";
> > +
> > +            ports {
> > +                #address-cells = <1>;
> > +                #size-cells = <0>;
> > +
> > +                port@0 {
> > +                    reg = <0>;
> > +                    tcpm_hs_out: endpoint {
> > +                        remote-endpoint = <&usb_hs_phy_in>;
> > +                    };
> > +                };
> > +
> > +                port@1 {
> > +                    reg = <1>;
> > +                    tcpm_ss_out: endpoint {
> > +                        remote-endpoint = <&usb_ss_phy_in>;
> > +                    };
> > +                };
> > +
> > +                port@2 {
> > +                    reg = <2>;
> > +                    tcpm_sbu_out: endpoint {
> > +                        remote-endpoint = <&sbu_mux_in>;
> > +                    };
> > +                };
> > +            };
> > +        };
> > +    };
> > +
> > +    sbu-mux {
> > +        compatible = "pericom,pi3usb102", "gpio-sbu-mux";
> > +
> > +        enable-gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
> > +        select-gpios = <&tlmm 164 GPIO_ACTIVE_HIGH>;
> > +
> > +        mode-switch;
> > +        orientation-switch;
> > +
> > +        port {
> > +            sbu_mux_in: endpoint {
> > +                remote-endpoint = <&tcpm_sbu_out>;
> > +            };
> 
> Don't you need a connection to whatever drives SBU? Maybe your case is 
> fixed because the phy does the DP/USB muxing? But the binding needs to 
> support the worst case which I guess would be all the muxing/switching 
> is done by separate board level components.
> 

Perhaps I'm misunderstanding your request, but I think this is the worst
case you're talking about.

&usb_ss_phy_in is a reference to the PHY, which does switching/muxing of
the SuperSpeed lanes in the connector, but the PHY provides no control
over the SBU signals.

So this sbu-mux is a separate component between the SBU-pads on the SoC
and the usb-c-connector, referenced through he &sbu_mux_in reference.


So upon e.g. a orientation switch, the typec_switch_set() call the tcpm
implementation will request orientation switching from port@1 and port@2
(no orientation-switch on port@0/HS pins).

Regards,
Bjorn
