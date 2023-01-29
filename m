Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6BD67FE70
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 12:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjA2LJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 06:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjA2LJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 06:09:29 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530541BAF0;
        Sun, 29 Jan 2023 03:09:28 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30TB127F012329;
        Sun, 29 Jan 2023 11:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gU1WtSJOvhwTzCbkguNX6JpVqBEroAEsjBAyhD6rxBk=;
 b=FLpBTsYhB/hMBJ/q3/PIrNjzSbwE1tVD4UbSXUGLO5NTbRuIIc0gCejQSEzxesVtjpve
 lfOqzYVCRF2e9Ow+Ddw+BPBIEJAJT/b3znF8XN/+ITdKtXY/jnoWt2JtagMGkqlE40SC
 aF5tGbae8Vf5skTPUuqanW86xUJ6y6knHyCA6rWLfoFQbFvBE4R8IrSGYp0+UquQMjOr
 rYZ+IJX1hRA97BtZfWGcoaErAZNSQBtYgEK0uqtoMSfhfEfxd0vdCwXBnH2JQF3bFjXD
 2v87GbQx+RxM66IFe9Y0S1DdpoXSBeE09I+GdJgtRllpbDA4Z6/+pshmt6b6AAezhjDp mQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncs2x21yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 11:09:18 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30TB9HYN017902
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 11:09:17 GMT
Received: from [10.216.24.113] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 29 Jan
 2023 03:09:14 -0800
Message-ID: <3a4675f8-c182-a98c-38e8-be1b4480f612@quicinc.com>
Date:   Sun, 29 Jan 2023 16:39:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 1/2] dt-bindings: mfd: qcom,tcsr: Add compatible for
 sm8450
Content-Language: en-US
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1673513697-30173-1-git-send-email-quic_mojha@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1673513697-30173-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rXiT2MOt0SJdPP3-7b65_fu3kG4DgKqE
X-Proofpoint-GUID: rXiT2MOt0SJdPP3-7b65_fu3kG4DgKqE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-29_09,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=825 impostorscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301290108
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Jones

Jones,

Can this patch be taken into your tree ?

-Mukesh

On 1/12/2023 2:24 PM, Mukesh Ojha wrote:
> Document the qcom,sm8450-tcsr compatible.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
> Change in v3:
>    - Align with new format mentioned at
>      Documentation/devicetree/bindings/arm/qcom-soc.yaml
> 
> Change in v2:
>    - Considering here it as v2 as this patch came out from comment
>      made on its v1 https://lore.kernel.org/lkml/c5dc8042-717b-22eb-79f6-d18ab10d6685@linaro.org/
> 
> 
>   Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> index adcae6c..4290062 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> @@ -26,6 +26,7 @@ properties:
>             - qcom,sdm630-tcsr
>             - qcom,sdm845-tcsr
>             - qcom,sm8150-tcsr
> +          - qcom,sm8450-tcsr
>             - qcom,tcsr-apq8064
>             - qcom,tcsr-apq8084
>             - qcom,tcsr-ipq6018
