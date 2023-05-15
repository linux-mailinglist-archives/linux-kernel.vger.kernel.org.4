Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70333702611
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 09:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238702AbjEOH3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 03:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240214AbjEOH3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 03:29:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C31D9;
        Mon, 15 May 2023 00:29:11 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34F7JgV7014710;
        Mon, 15 May 2023 07:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KHTzhT+XgalBzcWl78u0uoUyarGO7y9QKQvm1l7UtLk=;
 b=IALfZY8+4c4zYRnEgqybQO+lKVCi3fUHM+arLnsQR6ZBb/zUhjXTV8SdJIVERFU+lgwG
 wKuif4vzFvo/bHndFGef7WF+Mf8qo4grV9Cq+J2/mHCVEEkGEQXY3ONIvf6zuU02NrUR
 mh7NT9z5cVw+JwOYwPmQ4BAycI6EbJ/sZvbXcNYLkktEW7AowdzrNufFfMlkcetmtxhz
 U+2Mi8okw7RK3oCl2bkRrBRTydBliBKsWOEUZQzSgV+HWYeFxtBaO/5ykZ+X7W0mp2lk
 r5xqGjGdhYRpGwgYestmhKlOgR44Qgh7hictL2PBfsxNwKAAmag09DjTqvcLsWAV1Yif mw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qj2n2b0fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 07:29:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34F7T2qR021837
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 07:29:02 GMT
Received: from [10.216.63.235] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 15 May
 2023 00:28:26 -0700
Message-ID: <783ec6ea-425c-882a-47bf-d0a38dcc3bb2@quicinc.com>
Date:   Mon, 15 May 2023 12:58:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq9574: Enable crypto nodes
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_poovendh@quicinc.com>
References: <20230512090134.9811-1-quic_anusha@quicinc.com>
 <20230512090134.9811-3-quic_anusha@quicinc.com>
 <845fc080-154f-6799-65e3-a62fc8652b80@linaro.org>
From:   Anusha Canchi <quic_anusha@quicinc.com>
In-Reply-To: <845fc080-154f-6799-65e3-a62fc8652b80@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Gle8WE6nTQAQEThAtXwo8PsUA9glG5kS
X-Proofpoint-GUID: Gle8WE6nTQAQEThAtXwo8PsUA9glG5kS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=892 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150066
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/12/2023 2:52 PM, Krzysztof Kozlowski wrote:
> On 12/05/2023 11:01, Anusha Rao wrote:
>> Enable crypto support for ipq9574.
>>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> index fea15f3cf910..3cda5aa8d03c 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> @@ -123,6 +123,26 @@
>>   			clock-names = "core";
>>   		};
>>   
>> +		cryptobam: dma-controller@704000 {
>> +			compatible = "qcom,bam-v1.7.0";
>> +			reg = <0x00704000 0x20000>;
>> +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
>> +			#dma-cells = <1>;
>> +			qcom,ee = <1>;
>> +			qcom,controlled-remotely;
>> +		};
>> +
>> +		crypto: crypto@73a000 {
>> +			compatible = "qcom,crypto-v5.1";
> This compatible is deprecated. Take a look at the bindings - I think you
> miss bindings for your SoC, which you should then use here.
Okay, will address in next spin.

Thanks,
Anusha
> Best regards,
> Krzysztof
>

