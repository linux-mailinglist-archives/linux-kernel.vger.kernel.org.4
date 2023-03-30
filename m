Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1C06CFC85
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjC3HP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjC3HPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:15:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0282672A6;
        Thu, 30 Mar 2023 00:15:26 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32U4WN1A016233;
        Thu, 30 Mar 2023 07:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=53EwoSOqGcFv+GPKJMNnPLY5ppj7b/ty96gmmBLJBNU=;
 b=jsoK0HfLwbYj9wM9DCCkdYSQkZaF2kghWqkUeCtj6odyGHock1oRrtpD1tOyEdLL5vkw
 bvYZ4lC6Odf8VAPJ9kmantqbXC8Ce0oP8kFuLTDvUyXRNHZkZ/kBrOLJ5X4IXpozVozO
 keYed1xSKuHexdVVe5eau8azDzptApPw83Kjunw7sIjDhVm8TalhHmDiQdNwGTq0qehy
 4A7Hv8AQMoire0F+nAo4ldGTwBZeQNBQZXWEoDT5XDXDntIquihr/D2Ukqse3+xPO1r4
 rhN0XdU7xPibqbAFc1m21bSi6+5HWuTHmW09yvikkIN82r1/ENSrpEnc+ORHJNFP5csa IQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pmq1vae4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 07:15:11 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32U7FALO017238
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 07:15:10 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 30 Mar 2023 00:15:04 -0700
Date:   Thu, 30 Mar 2023 12:45:00 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_wcheng@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v4 3/8] dt-bindings: usb: dwc3: Add IPQ9574 compatible
Message-ID: <20230330071459.GD13508@varda-linux.qualcomm.com>
References: <cover.1679909245.git.quic_varada@quicinc.com>
 <526f822a4d2397284f70ba632d92feaa3db0143e.1679909245.git.quic_varada@quicinc.com>
 <a68c7693-9d43-0aa9-c77b-26183e5a0a06@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a68c7693-9d43-0aa9-c77b-26183e5a0a06@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3r039srvontuDpRgRZZeZKar5ZxYqgH7
X-Proofpoint-ORIG-GUID: 3r039srvontuDpRgRZZeZKar5ZxYqgH7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_02,2023-03-30_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=774
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303300057
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 09:11:38AM +0200, Krzysztof Kozlowski wrote:
> On 27/03/2023 11:30, Varadarajan Narayanan wrote:
> > Document the IPQ9574 dwc3 compatible.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >  Changes in v4:
> > 	- Update other relevant sections
> > 	- Remove constraints not applicable to IPQ9574
>
> No, that's not way to go. These are required.

Yes. Misinterpreted an earlier comment.
Will fix this.

> > ---
> >  .../devicetree/bindings/usb/qcom,dwc3.yaml         | 22 +++++++++++++++++++---
> >  1 file changed, 19 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> > index a2aabda..3fc8c3c 100644
> > --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> > +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> > @@ -17,6 +17,7 @@ properties:
> >            - qcom,ipq6018-dwc3
> >            - qcom,ipq8064-dwc3
> >            - qcom,ipq8074-dwc3
> > +          - qcom,ipq9574-dwc3
> >            - qcom,msm8953-dwc3
> >            - qcom,msm8994-dwc3
> >            - qcom,msm8996-dwc3
> > @@ -132,11 +133,8 @@ required:
> >    - "#address-cells"
> >    - "#size-cells"
> >    - ranges
> > -  - power-domains
> >    - clocks
> >    - clock-names
> > -  - interrupts
> > -  - interrupt-names
> >
> >  allOf:
> >    - if:
> > @@ -242,6 +240,24 @@ allOf:
> >          compatible:
> >            contains:
> >              enum:
> > +              - qcom,ipq9574-dwc3
> > +    then:
> > +      properties:
> > +        clocks:
> > +          maxItems: 5
> > +        clock-names:
> > +          items:
> > +            - const: sys_noc_axi
> > +            - const: anoc_axi
>
> Heh, do we really need entirely different clock names for each new variant?

Will fix and post a new patch.

Thanks
Varada

> Best regards,
> Krzysztof
>
