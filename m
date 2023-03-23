Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980A86C6001
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 07:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjCWGxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 02:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjCWGxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 02:53:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894F21F5C2;
        Wed, 22 Mar 2023 23:53:20 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N6KDpa016196;
        Thu, 23 Mar 2023 06:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=2b/5067R9GHcy29L7fsJhopZDL7DjzKE9imXFmh9BrY=;
 b=mHeSVT3BslTA6jzuzvCq1F/UQQkrZR3kUGUreWCafnkQ8R1hqLpw3W1/ZMJMA8fNPtC0
 utT+uiiUG8i6XxLfX7nb59BiaLvDfOgNes2/XdBcq0oZvcdRYvQQ1pK9L2/7o+D5EdPa
 cYoK9XR6c8ZhQhrDjryfaAxo6w2mGO9dsnnA6HqFl/a+Uz0aR7mqzTuHBMBeET3b4gPL
 ec3Vhl5HZX48OysXWQhdCDxwLkEgQMScWye16Ud/3WSM+PUw6oClEErKy6AVU8P+fd1g
 Tuz0MQ+jg9i2RojsbKYXEqdb+6A5zXXSNMKOMzvHqxCzeBl40w33Amx2H8c9FW4Irg+g pA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pg3c9a22c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 06:53:12 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32N6rBHI009152
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 06:53:11 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 22 Mar 2023 23:53:05 -0700
Date:   Thu, 23 Mar 2023 12:23:01 +0530
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
Subject: Re: [PATCH v3 2/8] dt-bindings: phy: qcom,qmp-usb: Add IPQ9574 USB3
 PHY
Message-ID: <20230323065300.GB19800@varda-linux.qualcomm.com>
References: <cover.1679479634.git.quic_varada@quicinc.com>
 <e34d8eddc1dda8bb0ff840a7dd18ca4dd6c62d22.1679479634.git.quic_varada@quicinc.com>
 <c52a329d-8683-de82-9b55-209b99ac36c0@linaro.org>
 <20230323063705.GA19800@varda-linux.qualcomm.com>
 <a8c3f324-0231-2180-8464-a3bfc663f743@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a8c3f324-0231-2180-8464-a3bfc663f743@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NA7dAzEcAnRdzB5xSAN5Zb_fXrFfX3BR
X-Proofpoint-ORIG-GUID: NA7dAzEcAnRdzB5xSAN5Zb_fXrFfX3BR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230052
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 07:42:37AM +0100, Krzysztof Kozlowski wrote:
> On 23/03/2023 07:37, Varadarajan Narayanan wrote:
> > On Wed, Mar 22, 2023 at 10:52:44PM +0100, Krzysztof Kozlowski wrote:
> >> On 22/03/2023 11:44, Varadarajan Narayanan wrote:
> >>> Add dt-bindings for USB3 PHY found on Qualcomm IPQ9574
> >>>
> >>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> >>>
> >>> ---
> >>>  Changes in v2:
> >>> 	- Updated sections missed in previous patch
> >>> ---
> >>>  .../bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml    | 22 ++++++++++++++++++++++
> >>>  1 file changed, 22 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
> >>> index e81a382..beae44c 100644
> >>> --- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
> >>> +++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
> >>> @@ -21,6 +21,7 @@ properties:
> >>>      enum:
> >>>        - qcom,ipq6018-qmp-usb3-phy
> >>>        - qcom,ipq8074-qmp-usb3-phy
> >>> +      - qcom,ipq9574-qmp-usb3-phy
> >>>        - qcom,msm8996-qmp-usb3-phy
> >>>        - qcom,msm8998-qmp-usb3-phy
> >>>        - qcom,qcm2290-qmp-usb3-phy
> >>> @@ -204,6 +205,27 @@ allOf:
> >>>          compatible:
> >>>            contains:
> >>>              enum:
> >>> +              - qcom,ipq9574-qmp-usb3-phy
> >>> +    then:
> >>> +      properties:
> >>> +        clocks:
> >>> +          maxItems: 2
> >>
> >> toplevel defines minItems as 3, so are you sure this works? Did you test it?
> >
> > Yes, this is tested. Able to do I/O.
>
> Bindings do not impact on whether you can or can not do IO, so I meant
> tested as DTS is compliant with bindings. I assume it was not, so please
> test bindings and DTS before sending new version.
> see Documentation/devicetree/bindings/writing-schema.rst for instructions

Sorry. Misunderstood the question. Yes, I ran make dtbs_check and
got these messages. But couldn't relate them with the
minItems/maxItems mismatch...

	phy@7d000: clocks: [[8, 93], [8, 102]] is too short
	phy@7d000: clock-names: ['aux', 'cfg_ahb'] is too short

Will fix it now. Thanks for the clarification.

> > We only have 2 items. Is it ok change the minItems to 2?
>
> Yes, because you must update top level (and maybe other) constraints to
> correct ones. Just test the code...

Ok.

Thanks
Varada

>
>
> Best regards,
> Krzysztof
>
