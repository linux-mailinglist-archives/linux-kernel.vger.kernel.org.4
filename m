Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8D66F0CB9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344049AbjD0Two (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243780AbjD0Twm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:52:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6580F1FD0;
        Thu, 27 Apr 2023 12:52:41 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RJgArL029210;
        Thu, 27 Apr 2023 19:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=qcppdkim1;
 bh=k1Q5/yUWRQrzFbPHUJT44yq1btB2RoW2DzUM6RMUWLk=;
 b=CaaayBjvyqGOab2Naf8kNsbZYQ7g2ayZOJkkKvhlZwg3O/EDtc4YvPdXcA4RDx3YvIYM
 Twv8qnChfHmRHe+T+5yy9ZRW1c+Jw1P+g3O7Iv5nl8DpbZy6zHmkeLmgEnFNgpW9N7ba
 ZvgviLWFyG5EEAj5b7e4NOT8BUNCBELLuLywv2SpxH6PKNFW8khuZftDSs01NpX+MDnC
 01Dd/yVfg/sQ3F//nyuDt/35YFkdOWMwTG8UrO2aLawMtxtI53NZleyY5zbDbhMVN7pu
 k7RGzcT/p+jAZDAV3zTAuGO2K0iIrM3EvCXY55i88OnIno+p32mYhaIWXor6blwzBYkR Ww== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q7m4y9vfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 19:52:34 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33RJqXBq024360
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 19:52:33 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 27 Apr 2023 12:52:33 -0700
Date:   Thu, 27 Apr 2023 12:52:32 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bryan O'Donoghue <pure.logic@nexus-software.ie>
CC:     Vinod Koul <vkoul@kernel.org>,
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
Message-ID: <20230427195232.GB870858@hu-bjorande-lv.qualcomm.com>
References: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
 <20230425034010.3789376-2-quic_bjorande@quicinc.com>
 <CAJB8c06H+3pxoUGXWOXyCgtbOj6y0OhSxb9dvoTo1b6iChy7ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJB8c06H+3pxoUGXWOXyCgtbOj6y0OhSxb9dvoTo1b6iChy7ng@mail.gmail.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nidE7ShXRPBsMTqQHBIcJxHWm-fRDF6U
X-Proofpoint-ORIG-GUID: nidE7ShXRPBsMTqQHBIcJxHWm-fRDF6U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_09,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1011 mlxlogscore=999
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304270174
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 11:21:29AM +0100, Bryan O'Donoghue wrote:
> On Tue, Apr 25, 2023 at 4:40 AM Bjorn Andersson
> <quic_bjorande@quicinc.com> wrote:
> >
> > The QMP combo phy can be connected to a TCPM, a USB controller and a
> > DisplayPort controller for handling USB Type-C orientation switching
> > and propagating HPD signals.
> >
> > Extend the binding to allow these connections to be described.
> >
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> >  .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    | 51 +++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> > index 3cd5fc3e8fab..c037ac90ce7f 100644
> > --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> > +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> > @@ -60,6 +60,26 @@ properties:
> >      description:
> >        See include/dt-bindings/dt-bindings/phy/phy-qcom-qmp.h
> >
> > +  orientation-switch:
> > +    description:
> > +      Flag the PHY as possible handler of USB Type-C orientation switching
> > +    type: boolean
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: Output endpoint of the PHY
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > +        description: Incoming endpoint from the USB controller
> 
> Do you really need this one ?
> 
> The controller doesn't process orientation switching.
> 

I don't have a need for it, as we can deal with role switching by
connecting connector/port@0 to the dwc3.

But if we ever have a need to describe the dwc3 -> QMP -> connector path
in the of_graph I think it would look prettier to have USB input as
port@1 and DP input as port@2...

Do you have a concern with keeping it around in the DT (the
implementation doesn't need to care)?

Regards,
Bjorn
