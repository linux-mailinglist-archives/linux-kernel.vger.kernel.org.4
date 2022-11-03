Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD105617531
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 04:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiKCDon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 23:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKCDoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 23:44:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF63014D1C;
        Wed,  2 Nov 2022 20:44:36 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A33a7nj022426;
        Thu, 3 Nov 2022 03:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=ZcWHqAEGAjOKGtkmsDwh5f5J8VCtHBxsiRN3InV05C0=;
 b=O+f83m7cTVPKN0UW7K1U1CwkMtOgvPw01Da0VW109Sx77showA4yYNra0NHSQVtMoHTg
 KMScOqRrDNco11hbPhUJzhT564imWAP7gP2MsRmI3qS2kp5+SvN/hVZJJaS9xpc59HGn
 xCI4Om92AB30ZhwPImGvilf6QnIGY2BAh03qgLwOt6jgzfkuz7XHErIkOudoKgRw1bxA
 IaC4vn8WHIjxf5DV4YaAR8vOU3Pck8KKc9X3CBBKn8DjdTXSWahYn6HckTCtN1HXo5S6
 g04wjNlDMARiJKM4LynaI+gWcNy7grQ2g9bh4BotyzfIDD8mN3amrmZCuf89yvm7hNHd vg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kkvyy94xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 03:44:15 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A33iESK026505
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Nov 2022 03:44:14 GMT
Received: from core-thresher1.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 2 Nov 2022 20:44:13 -0700
Date:   Wed, 2 Nov 2022 20:44:12 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Sibi Sankar" <quic_sibis@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/10] dt-bindings: interconnect: Add sm8350, sc8280xp
 and generic OSM L3 compatibles
Message-ID: <20221103034410.GB5525@core-thresher1.qualcomm.com>
References: <20221028034155.5580-1-quic_bjorande@quicinc.com>
 <20221028034155.5580-6-quic_bjorande@quicinc.com>
 <a364b343-fa19-348c-bc38-e8b44061890b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a364b343-fa19-348c-bc38-e8b44061890b@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mh42O8xuFCL6XvfAz10GflIXPuk7e-44
X-Proofpoint-ORIG-GUID: mh42O8xuFCL6XvfAz10GflIXPuk7e-44
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030024
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 06:12:29PM -0400, Krzysztof Kozlowski wrote:
> On 27/10/2022 23:41, Bjorn Andersson wrote:
> > Add EPSS L3 compatibles for sm8350 and sc8280xp, but while at it also
> > introduce generic compatible for both qcom,osm-l3 and qcom,epss-l3.
> > 
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> >  .../bindings/interconnect/qcom,osm-l3.yaml    | 22 +++++++++++++------
> >  1 file changed, 15 insertions(+), 7 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> > index bf538c0c5a81..ae0995341a78 100644
> > --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> > +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> > @@ -16,13 +16,21 @@ description:
> >  
> >  properties:
> >    compatible:
> > -    enum:
> > -      - qcom,sc7180-osm-l3
> > -      - qcom,sc7280-epss-l3
> > -      - qcom,sc8180x-osm-l3
> > -      - qcom,sdm845-osm-l3
> > -      - qcom,sm8150-osm-l3
> > -      - qcom,sm8250-epss-l3
> > +    oneOf:
> > +      items:
> 
> oneOf expects a list, so this should be "    - items"
> 

Ahh, thanks. Must have missed running the dt_binding_check on this one.

> > +        - enum:
> > +            - qcom,sc7180-osm-l3
> > +            - qcom,sc8180x-osm-l3
> > +            - qcom,sdm845-osm-l3
> > +            - qcom,sm8150-osm-l3
> > +        - const: qcom,osm-l3
> 
> The concept is good, but are you sure all SoCs will be compatible with
> generic osm-l3?

Per the current implementation yes, worst case if one or more of them isn't the
more specific compatible can be used to alter the behavior of that platform.

> Why not using dedicated compatible of one soc, e.g. the
> oldest here? We already did like that for BWMON, DMA and few others.
> 

Because if we say compatible = "qcom,sc8180x-osm-l3", "qcom,sdm845-osm-l3" and
there is a quirk needed for "qcom,sdm845-osm-l3" we're forced to add a "special
case" every other *-osm-l3 in the driver.

This way we can have a generic implementation for the qcom,osm-l3 and if we
realize that we need to quirk something for the oldest platform, we can do so
without affecting the others.

Regards,
Bjorn

> > +      items:
> > +        - enum:
> > +            - qcom,sc7280-epss-l3
> > +            - qcom,sc8280xp-epss-l3
> > +            - qcom,sm8250-epss-l3
> > +            - qcom,sm8350-epss-l3
> > +        - const: qcom,epss-l3
> >  
> >    reg:
> >      maxItems: 1
> 
> Best regards,
> Krzysztof
> 
