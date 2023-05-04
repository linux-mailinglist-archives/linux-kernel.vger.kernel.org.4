Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D396F6E4D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjEDOyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjEDOwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:52:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BF27AA6;
        Thu,  4 May 2023 07:51:46 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344E82UW004917;
        Thu, 4 May 2023 14:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=qcppdkim1;
 bh=GhSbuOrmW94M9j+Wv4Gh8g0l7nGibTjHwc6eC1CVovo=;
 b=TlWaMz+O3G+UriYSGBJeGEnRlWBhj9cDJrGTSDpntgl/X+rdu3S7Oh0rH7wKWhP5WCKj
 kPIepsbFilGnuWCYalElsA1iy3zPa70PiS6vSW/422SKSRIb1pFonw/GggKyEutNbaV0
 FeZTU7CY6+4Xt8ljTOgd3K/QOebmRqQ9EpdmHixBCiBG5skJysITQecbn3A/qllnOFY3
 lt+q+QgcN/1fAnVk95waDoM64uGDOtJrFXpTc3slxfojINse7E6soxahLQwp0u5VZfh5
 Wiu/3rXIErWk/b2Sb6jTRhe+URquhnQBDDYIq//Bf3CxNinQps/yfW7F4P0KKoFNtyl2 sw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qce6mg372-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 14:51:39 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 344EpcEN002967
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 May 2023 14:51:39 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 4 May 2023 07:51:38 -0700
Date:   Thu, 4 May 2023 07:51:37 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
CC:     Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp: Add
 ports and orientation-switch
Message-ID: <20230504145137.GG870858@hu-bjorande-lv.qualcomm.com>
References: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
 <20230425034010.3789376-2-quic_bjorande@quicinc.com>
 <CAJB8c06H+3pxoUGXWOXyCgtbOj6y0OhSxb9dvoTo1b6iChy7ng@mail.gmail.com>
 <20230427195232.GB870858@hu-bjorande-lv.qualcomm.com>
 <ea0ec8b4-ec87-65f0-4f0e-504d8059b1e6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea0ec8b4-ec87-65f0-4f0e-504d8059b1e6@linaro.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Owq-MiMBFdp0s5W0zqY4uBpSH3fza73z
X-Proofpoint-ORIG-GUID: Owq-MiMBFdp0s5W0zqY4uBpSH3fza73z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040122
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 03:50:53PM +0200, Neil Armstrong wrote:
> On 27/04/2023 21:52, Bjorn Andersson wrote:
> > On Wed, Apr 26, 2023 at 11:21:29AM +0100, Bryan O'Donoghue wrote:
> > > On Tue, Apr 25, 2023 at 4:40 AM Bjorn Andersson
> > > <quic_bjorande@quicinc.com> wrote:
> > > > 
> > > > The QMP combo phy can be connected to a TCPM, a USB controller and a
> > > > DisplayPort controller for handling USB Type-C orientation switching
> > > > and propagating HPD signals.
> > > > 
> > > > Extend the binding to allow these connections to be described.
> > > > 
> > > > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > > > ---
> > > >   .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    | 51 +++++++++++++++++++
> > > >   1 file changed, 51 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> > > > index 3cd5fc3e8fab..c037ac90ce7f 100644
> > > > --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> > > > +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> > > > @@ -60,6 +60,26 @@ properties:
> > > >       description:
> > > >         See include/dt-bindings/dt-bindings/phy/phy-qcom-qmp.h
> > > > 
> > > > +  orientation-switch:
> > > > +    description:
> > > > +      Flag the PHY as possible handler of USB Type-C orientation switching
> > > > +    type: boolean
> > > > +
> > > > +  ports:
> > > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > > +    properties:
> > > > +      port@0:
> > > > +        $ref: /schemas/graph.yaml#/properties/port
> > > > +        description: Output endpoint of the PHY
> > > > +
> > > > +      port@1:
> > > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > > +        description: Incoming endpoint from the USB controller
> > > 
> > > Do you really need this one ?
> > > 
> > > The controller doesn't process orientation switching.
> > > 
> > 
> > I don't have a need for it, as we can deal with role switching by
> > connecting connector/port@0 to the dwc3.
> > 
> > But if we ever have a need to describe the dwc3 -> QMP -> connector path
> > in the of_graph I think it would look prettier to have USB input as
> > port@1 and DP input as port@2...
> 
> I think it would be great to have port@1 for USB SS and port@2 for DP,
> otherwise we need to add 2 endpoints as I sent in
> https://lore.kernel.org/all/20230503-topic-sm8450-graphics-dp-next-v1-1-d1ee9397f2a6@linaro.org/
> since we split USB HS and SS streams on SM8[345]50 platforms.
> 

Right, so let's keep port@1 and port@2 in the binding, and then we can
choose to connect port@1 to DWC3 or not...

Regards,
Bjorn

> > 
> > Do you have a concern with keeping it around in the DT (the
> > implementation doesn't need to care)?
> > 
> > Regards,
> > Bjorn
> 
