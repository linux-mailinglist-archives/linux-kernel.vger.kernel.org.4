Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00CA6F5086
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 09:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjECHAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 03:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjECHAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 03:00:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBE83C29;
        Wed,  3 May 2023 00:00:42 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3434HMgS002393;
        Wed, 3 May 2023 07:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=rlGeiNC24oO+kOGemdbbUnr0ZHU/OEeAhqGE896RQQM=;
 b=flxwcjC2E76tsXRqh6xETW9b+865r3XjPEMSjFssYH3+IvB2zVKTJ5GfiDjES54FvvoJ
 6X3gPB18PS98BfaMBMSvL3G3u3CyomC6QjUoU2tQWUa7kowJcfdJexIL2hHd5TlDXp45
 v36f4rXfihTAc+lg5GQpTXThMoB0Ci8Z4D6c6EjM2F8RIgMNlcU/eIXpPR52qDDFEDA2
 QmyLhbsC+Y05Yg4KBVPmGZPOlH1l/AGn68Oo9xdOm0WiIjp5kHcfNnpoC0XbqwLlqd8s
 HnkKsK6zda2TWdT7NPRk6Y55e6gfqFiYwNf6sN3JQH83gXjVoYjFQmjL1e/guUShs9VP Fw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qbeb2rpap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 07:00:37 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34370akI026681
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 May 2023 07:00:36 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 3 May 2023 00:00:31 -0700
Date:   Wed, 3 May 2023 12:30:27 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Praveenkumar I <quic_ipkumar@quicinc.com>
Subject: Re: [PATCH v1 1/4] dt-bindings: thermal: tsens: Add ipq9574
 compatible
Message-ID: <20230503070026.GA1087@varda-linux.qualcomm.com>
References: <cover.1683027347.git.quic_varada@quicinc.com>
 <cbf916e31b00e0e0599a3012a84a4740df89f4e0.1683027347.git.quic_varada@quicinc.com>
 <6fbdd628-89f6-e34f-1b6e-b36e8fbd2346@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6fbdd628-89f6-e34f-1b6e-b36e8fbd2346@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SE77ZD9AvemMaEpbG1zUlMyktjE3ycL3
X-Proofpoint-GUID: SE77ZD9AvemMaEpbG1zUlMyktjE3ycL3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2305030057
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 08:34:45AM +0200, Krzysztof Kozlowski wrote:
> On 03/05/2023 06:45, Varadarajan Narayanan wrote:
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
>
> I saw already v1, so this looks like v2, not v1. Please add changelog
> describing what you changed here.

No code change between v1 and v2 w.r.t this patch. The 4th patch
alone in this series has code changes between v1 and v2.

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
> This is a friendly reminder during the review process.
>
> It seems my previous comments were not fully addressed. Maybe my
> feedback got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all
> requested changes or keep discussing them.
>
> Thank you.

Sorry. Looks like I missed https://lore.kernel.org/lkml/20230502080611.GB26126@varda-linux.qualcomm.com/T/#m42a9b77be2ceddf1adc90c07f487929fcf2dbc0f
Will take that input and post a new version.

Thanks
Varada

> Best regards,
> Krzysztof
>
