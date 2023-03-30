Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED2E6CFC75
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjC3HOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjC3HOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:14:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DD165BA;
        Thu, 30 Mar 2023 00:13:41 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32U3hOYi005087;
        Thu, 30 Mar 2023 07:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=6B16GjtCP8jmz8x2KKLApwXYgb+Wl4vnXGjbWAhATyI=;
 b=LwdBiR5XeKm6/VlzxnOrw8n0vz3NsmARiBdYOMEmGDwZNdS6YBtHi02E13931zLWSa2F
 /9e+wLZ14MqgBGJQ9CHqzFzBmHP+DWMW8yq+jzsRcHSVGokKXq7E2XR5eTWx/n673nY0
 hHAYmzeTMYnXADPnzV8+ZzQJ6YNygzaHQxFFJvrFeBu/jF6eY/Fiv6R4/19EZc6C2TL6
 cYEc+ilv61Dmafz3yeg+28XX/b8dwe26tjbwkQhmjoUzcSvFZurlFKZUpnOhMwuanI/9
 eLuNDV+4PH1EUqAvfs+Cn9jb36HNsz8CGPjSk7VEYZ3VsBzsOHQgx8FrHK0g4ipfAf61 Bg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pn2rqrm6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 07:13:28 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32U7DSv1003345
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 07:13:28 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 30 Mar 2023 00:13:21 -0700
Date:   Thu, 30 Mar 2023 12:43:17 +0530
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
Subject: Re: [PATCH v4 2/8] dt-bindings: phy: qcom,qmp-usb: Add IPQ9574 USB3
 PHY
Message-ID: <20230330071316.GC13508@varda-linux.qualcomm.com>
References: <cover.1679909245.git.quic_varada@quicinc.com>
 <4a21defe3320eb11d0e43bc7f02b3168ecefd458.1679909245.git.quic_varada@quicinc.com>
 <39356c59-7723-40df-08ba-cd563a7e066c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <39356c59-7723-40df-08ba-cd563a7e066c@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -c2unPo9kpCI8gT2WIRGck5ZYFaqhFgP
X-Proofpoint-GUID: -c2unPo9kpCI8gT2WIRGck5ZYFaqhFgP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_03,2023-03-30_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303300056
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 09:07:08AM +0200, Krzysztof Kozlowski wrote:
> On 27/03/2023 11:30, Varadarajan Narayanan wrote:
> > Add dt-bindings for USB3 PHY found on Qualcomm IPQ9574
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >  Changes in v4:
> > 	- Remove constraints not applicable to IPQ9574
> >  Changes in v3:
> > 	- Update other mandatory fields to accomodate IPQ9574
> >  Changes in v2:
> > 	- Updated sections missed in previous patch
> > ---
> >  .../bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml    | 25 ++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
> > index e81a382..aa5b58c 100644
> > --- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
> > +++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
> > @@ -21,6 +21,7 @@ properties:
> >      enum:
> >        - qcom,ipq6018-qmp-usb3-phy
> >        - qcom,ipq8074-qmp-usb3-phy
> > +      - qcom,ipq9574-qmp-usb3-phy
> >        - qcom,msm8996-qmp-usb3-phy
> >        - qcom,msm8998-qmp-usb3-phy
> >        - qcom,qcm2290-qmp-usb3-phy
> > @@ -122,8 +123,6 @@ required:
> >    - clock-names
> >    - resets
> >    - reset-names
> > -  - vdda-phy-supply
> > -  - vdda-pll-supply
> >
> >  additionalProperties: false
> >
> > @@ -204,6 +203,28 @@ allOf:
> >          compatible:
> >            contains:
> >              enum:
> > +              - qcom,ipq9574-qmp-usb3-phy
> > +    then:
> > +      properties:
> > +        clocks:
> > +          maxItems: 3
> > +        clock-names:
> > +          items:
> > +            - const: aux
> > +            - const: cfg_ahb
> > +            - const: pipe
>
> Isn't pipe the clock for child node?

Will be moving to a newer style binding (as specified in
qcom,sc8280xp-qmp-usb3-uni-phy.yaml). Will update accordingly
and post the patch.

Thanks
Varada

> Best regards,
> Krzysztof
>
