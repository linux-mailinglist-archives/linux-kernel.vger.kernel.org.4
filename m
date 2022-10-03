Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8B65F36A3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 21:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiJCTqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 15:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiJCTqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 15:46:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7736219C28;
        Mon,  3 Oct 2022 12:46:44 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 293HcVkA026450;
        Mon, 3 Oct 2022 19:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hsJ2wsMyRb5X70rxD3U+ZD1H9sqg7ZneJCDcKQBr4xU=;
 b=RMmsI3A9XQBuXlCPm5bjHxsbBqRnp2RdkS3B0zqb5IdKNC4IeT32AeAkXddLypZCZMwF
 7Wg43e9jXEiSmnZWzUFT6cb4srxgf8pDrc+NQ4bEYkAp2+NmfRiliG+4CmmqqyTpbXOk
 3YDuFz0cRMthQwYHRyWSepqXJMWo5UHNfFBImQ0IxpfpZSlUcpuDWjFPqHh2lv2cP32D
 pnhnIK2ybZy2PEyTwv1kYzzuX2XhdUrsgFbSwCUNZ15C9KQlV07Q0pq2teiwFwDfmvoz
 fcgVIAygLnTcNSuYXwSS/DGsD9/wa7N2E1SXmF6UgePyKelzOoc3qE371KYOMGKwcZ2g qA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jxeqtvy2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Oct 2022 19:46:39 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 293JkcF5009570
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Oct 2022 19:46:38 GMT
Received: from [10.110.93.213] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 3 Oct 2022
 12:46:36 -0700
Message-ID: <d3302ea9-c453-8fb9-4944-cb5431aa48c9@quicinc.com>
Date:   Mon, 3 Oct 2022 14:46:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 5/5] dt-bindings: clock: Introduce pdc bindings for
 QDU1000 and QRU1000
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221001030403.27659-1-quic_molvera@quicinc.com>
 <20221001030403.27659-6-quic_molvera@quicinc.com>
 <CAA8EJpof5JFDN978t98JxJgd2e+8VVDkXbexvNegA+2jY+tN=Q@mail.gmail.com>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <CAA8EJpof5JFDN978t98JxJgd2e+8VVDkXbexvNegA+2jY+tN=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XR7b9G-CvNTBnWM91qqb1nkoko1yx11F
X-Proofpoint-GUID: XR7b9G-CvNTBnWM91qqb1nkoko1yx11F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=944
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210030119
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/1/2022 1:58 AM, Dmitry Baryshkov wrote:
> On Sat, 1 Oct 2022 at 06:04, Melody Olvera <quic_molvera@quicinc.com> wrote:
>> Add compatible fields for QDU1000 and QRU1000 pdcs.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml      | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
>> index b6f56cf5fbe3..5c7b790db7e0 100644
>> --- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
>> @@ -33,6 +33,8 @@ properties:
>>            - qcom,sm8150-pdc
>>            - qcom,sm8250-pdc
>>            - qcom,sm8350-pdc
>> +          - qcom,qdu1000-pdc
>> +          - qcom,qru1000-pdc
> Alphabetic sorting please. q comes before s.
Will do.
>
>>        - const: qcom,pdc
>>
>>    reg:
>> --
>> 2.37.3
>>
Thanks,

Melody

