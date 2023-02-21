Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F1B69E17A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 14:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbjBUNi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 08:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjBUNiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 08:38:54 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DAA4688;
        Tue, 21 Feb 2023 05:38:53 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LCaYfB011019;
        Tue, 21 Feb 2023 13:38:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=occJZu2ZQyxtcntETgct/ixL3bzBb7hQ7vMRVwxAEAE=;
 b=CguiNXsjLOCgpR3xe30gWB9ryd5KZ4MkTyCbUPE+pw/6lZ0UiLpHIKYFRDdwiqCf/MWN
 qFYEIAkIkEXmKeJehPydE5/UawA3nhfsiKMDxakXFXCAie2pV/G96DcI8gZwAErQSiHK
 fNQxWnjbaRb8rBW3JjqSSk7kSrQvcqdSOR2n5O7TXE5SzGTxdtfGmImMMdAjEJdW/Xv7
 MPFl48sqR8L27dOTEmFeelZb7t0CpaaUvinm7uvLIIu0P5WqNsA79gdFKIpVA0yOeqV4
 rn+L/nxMtp78q9tCqA4ULsoPpBlGUceB89adw7KVnUC6ePJD0dXn0MTt1W8HzW14NSdE EQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nubb1wths-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 13:38:50 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31LDcnIb001528
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 13:38:49 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 21 Feb
 2023 05:38:46 -0800
Message-ID: <c8c1ae71-a85f-18cb-780d-fd2e055f8e26@quicinc.com>
Date:   Tue, 21 Feb 2023 19:08:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4] dt-bindings: mfd: qcom,tcsr: Add compatible for sm8450
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1675336284-548-1-git-send-email-quic_mojha@quicinc.com>
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1675336284-548-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TJEINiM2hSKkxPPcpAIyVxpiDdWrtSkw
X-Proofpoint-GUID: TJEINiM2hSKkxPPcpAIyVxpiDdWrtSkw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_08,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 mlxlogscore=679 malwarescore=0 priorityscore=1501 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302210116
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

friendly reminder.

-Mukesh
On 2/2/2023 4:41 PM, Mukesh Ojha wrote:
> Document the qcom,sm8450-tcsr compatible.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Change in v4:
>    - added Acked-by.
> 
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
