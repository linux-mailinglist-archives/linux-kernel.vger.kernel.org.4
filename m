Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF1861751E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 04:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiKCDh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 23:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiKCDhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 23:37:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492401408F;
        Wed,  2 Nov 2022 20:37:53 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A32Kjra010807;
        Thu, 3 Nov 2022 03:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=7d5DQ2aJU83RE1U2XYB1vydBkrBxFxM1P93WKomtemo=;
 b=oYQSdiSK6go0bJzBpjfc4XyI9fK1Lnv1/BMjnmALzhOAgy6IEBsTEY3Qr3EYguVAYeXA
 SVgCw5eii5qYWp6IaxB+7IMsWlJ1/8S1JznBxd9N53+gVa6qCE9NxxYC4QbXn4ogFYLp
 ZjhTEY2rPrZzk2WEWpRz357w7y4XoVsIe552Jz6dsS5BSG3xKWBlUDMXBvZGhsH6twBH
 CAHQXvWFDjbn2cwX1dIR1DXN8pj3ffrIUhRuCssX+HFY6C5X8K/izYIhHvp6FUMJcfcQ
 1LBEbEQhEa2CjA9NQ6knQAYGWmhX7qoF+i4HdXv3CWVr2qu0Zn0Is83ib2bMLAjHcnTq VA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kktuxa4g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 03:37:46 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A33bjiZ015922
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Nov 2022 03:37:45 GMT
Received: from core-thresher1.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 2 Nov 2022 20:37:44 -0700
Date:   Wed, 2 Nov 2022 20:37:43 -0700
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
Subject: Re: [PATCH 09/10] dt-bindings: interconnect: qcom,msm8998-bwmon: Add
 sc8280xp bwmon instances
Message-ID: <20221103033741.GA5525@core-thresher1.qualcomm.com>
References: <20221028034155.5580-1-quic_bjorande@quicinc.com>
 <20221028034155.5580-10-quic_bjorande@quicinc.com>
 <0ada5a42-02f4-50ce-e65c-1a5fa9966900@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0ada5a42-02f4-50ce-e65c-1a5fa9966900@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3c9-EHKsGTHxTc0UNIVkB987Oyo-bTyi
X-Proofpoint-GUID: 3c9-EHKsGTHxTc0UNIVkB987Oyo-bTyi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211030023
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 06:15:50PM -0400, Krzysztof Kozlowski wrote:
> On 27/10/2022 23:41, Bjorn Andersson wrote:
> > The sc8280xp platform has two BWMON instances, one v4 and one v5. Extend
> > the existing qcom,msm8998-bwmon and qcom,sc7280-llcc-bwmon to describe
> > these.
> > 
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> >  .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> > index be29e0b80995..223cd6ecf279 100644
> > --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> > +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> > @@ -25,9 +25,14 @@ properties:
> >        - items:
> >            - enum:
> >                - qcom,sc7280-cpu-bwmon
> > +              - qcom,sc8280xp-bwmon
> 
> qcom,sc8280xp-cpu-bwmon
> To match sc7280. I think it's better than my initial choice for
> qcom,sdm845-bwmon without the cpu part.
> 

As discussed back then, we omitted "cpu" because there where multiple instances
of the bwmon block. Would you prefer we give it the "cpu" compatible and
potentially us it for non-cpu measurements?

Regards,
Bjorn
