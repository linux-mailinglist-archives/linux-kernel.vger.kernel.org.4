Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A53E6F5139
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 09:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjECHXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 03:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjECHXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 03:23:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B98A40F1;
        Wed,  3 May 2023 00:23:33 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34373bkk011621;
        Wed, 3 May 2023 07:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=l5ho0+2Tdg9vkh2gnDbkeobPPiUBdSO6xXe3o5DM3rI=;
 b=nC/UK1eVv3rP2Uldd1rv7Ud+O6BWoalJxwbvJu/+mLTWYGvc3UpbIM10eIR+rUSpYdtP
 wFzaD/XJ4dKkuLllFJk4Yy7BF9GHGXIqNsoL4f0WWfo5FIAvmuHEcqfkwOVY4ATNihFp
 7lkUxM8Gs7soqO4odG/FD/E7WiFxwLjBkVczfUHPL4ptT5fGCmsH7o2mGHy9p2WWOhFg
 EC7BVeQ67LtbVd0up5Hu6CL6BCa4aoxTnVjCFZ3ULLCaq8NW2EwwKrJ4hgJh7Ikc1wDc
 g0WLsF2xAG1ogIrRnT48dl3e7rkY3vqsvCd7CcuatWzJ6XjVaY3u0zze0+gx/bjvZuLF 3Q== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qawcbb0ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 07:11:09 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3437B8dr013043
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 May 2023 07:11:08 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 3 May 2023 00:11:01 -0700
Date:   Wed, 3 May 2023 12:40:56 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Praveenkumar I <quic_ipkumar@quicinc.com>
Subject: Re: [PATCH 1/4] dt-bindings: thermal: tsens: Add ipq9574 compatible
Message-ID: <20230503071055.GB1087@varda-linux.qualcomm.com>
References: <cover.1682682753.git.quic_varada@quicinc.com>
 <3c6f7510d175ba5a3c81730b010f6c421b2fbf2d.1682682753.git.quic_varada@quicinc.com>
 <16443d11-7948-d224-cfef-b6c1b5c3d60d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <16443d11-7948-d224-cfef-b6c1b5c3d60d@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EffqsF124boSvbEDboyqwP3dI-PLeIOI
X-Proofpoint-ORIG-GUID: EffqsF124boSvbEDboyqwP3dI-PLeIOI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030058
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 09:08:49AM +0200, Krzysztof Kozlowski wrote:
> On 28/04/2023 16:52, Varadarajan Narayanan wrote:
> > From: Praveenkumar I <quic_ipkumar@quicinc.com>
> >
> > Qualcomm IPQ9574 has tsens v2.3.1 block, which is similar to IPQ8074 tsens.
> >
> > Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> > index d1ec963..8e2208c 100644
> > --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> > +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> > @@ -66,6 +66,7 @@ properties:
> >        - description: v2 of TSENS with combined interrupt
> >          enum:
> >            - qcom,ipq8074-tsens
> > +          - qcom,ipq9574-tsens
>
> Your drive change indicates they are compatible, so make them
> compatible. 9574 followed by 8074.

Not able to understand. You want IPQ9574 to use "qcom,ipq8074-tsens"
instead of adding a "qcom,ipq9574-tsens" and no need to add an extra
entry to the driver like

	}, {
		.compatible = "qcom,ipq9574-tsens",
		.data = &data_ipq8074,
	}, {

Thanks
Varada


> Best regards,
> Krzysztof
>
