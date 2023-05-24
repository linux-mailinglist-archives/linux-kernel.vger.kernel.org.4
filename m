Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFC070ED0E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 07:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239344AbjEXF15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 01:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjEXF1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 01:27:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BDF13E;
        Tue, 23 May 2023 22:27:53 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34O5QJMQ011402;
        Wed, 24 May 2023 05:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vDRlbCPueHl+m8WtGe+G1vGaIcLuvwNJ0UbZoqCVEc0=;
 b=QXoCVMQch7LvvVFKg6nD4rTAUdUKkfjc4PsppUClxRYNfNrqQU8GtXGU4g7rQ+GbXDtx
 eSx4M328aAR7wtWLYr9LDSWQ9vVxpPyHXVDBs3/gnIYmX5iPBt2Kl0s/a8jYHyhMVKcM
 WVn//4FE0D28FKDyIM7HvWPZEDilcx1NjIhVAaBFsOb5vJD4qTdZeAKO7Xq5rIY3ZkT0
 iNWFq8N3QkU+5f8DNMEHm39wgNN8OAjgr10lRSSjclPyrAYzVoNmZElbMXAgyyQUAupy
 ikHOpBo/W/6waIbnoH32r1MvTazBtpz4vjx60AN5fStDlILlXDA77KmtREK25os4t2f+ ZA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qscaur0fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 05:27:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34O5RdS0010827
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 05:27:39 GMT
Received: from [10.216.39.178] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 23 May
 2023 22:27:32 -0700
Message-ID: <28a4d1e6-224d-9ecb-6b94-cffc3ecb408d@quicinc.com>
Date:   Wed, 24 May 2023 10:57:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V3 4/4] arm64: dts: qcom: ipq9574: Enable crypto nodes
To:     <bhupesh.sharma@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <thara.gopinath@gmail.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-arm-msm@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_poovendh@quicinc.com>
References: <20230518141105.24741-1-quic_anusha@quicinc.com>
 <20230518141105.24741-5-quic_anusha@quicinc.com>
 <93db4ee5-4fb8-f159-0cf4-ec1669c36dd1@linaro.org>
From:   Anusha Canchi <quic_anusha@quicinc.com>
In-Reply-To: <93db4ee5-4fb8-f159-0cf4-ec1669c36dd1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4xb4uA5YvSKQvmVFDQ08UJ5O6mIQuv41
X-Proofpoint-GUID: 4xb4uA5YvSKQvmVFDQ08UJ5O6mIQuv41
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_02,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240045
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/2023 2:23 PM, bhupesh.sharma@linaro.org wrote:
> On 5/18/23 7:41 PM, Anusha Rao <quic_anusha@quicinc.com> wrote:
>> Enable crypto support for ipq9574.
>>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> ---
>>   Changes in V3:
>>     - No change.
>>
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi 
>> b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> index fea15f3cf910..6e52d35a6a15 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> @@ -123,6 +123,26 @@
>>               clock-names = "core";
>>           };
>>   +        cryptobam: dma-controller@704000 {
>> +            compatible = "qcom,bam-v1.7.0";
>
> Please confirm if this is "qcom,bam-v1.7.4" or "qcom,bam-v1.7.0". If 
> "qcom,bam-v1.7.4" please use the newer compatible format.
Sure, will update.

Thanks,
Anusha
>
> Thanks,
> Bhupesh
>
>> +            reg = <0x00704000 0x20000>;
>> +            interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
>> +            #dma-cells = <1>;
>> +            qcom,ee = <1>;
>> +            qcom,controlled-remotely;
>> +        };
>> +
>> +        crypto: crypto@73a000 {
>> +            compatible = "qcom,ipq9574-qce", "qcom,ipq4019-qce", 
>> "qcom,qce";
>> +            reg = <0x0073a000 0x6000>;
>> +            clocks = <&gcc GCC_CRYPTO_AHB_CLK>,
>> +                 <&gcc GCC_CRYPTO_AXI_CLK>,
>> +                 <&gcc GCC_CRYPTO_CLK>;
>> +            clock-names = "iface", "bus", "core";
>> +            dmas = <&cryptobam 2>, <&cryptobam 3>;
>> +            dma-names = "rx", "tx";
>> +        };
>> +
>>           tlmm: pinctrl@1000000 {
>>               compatible = "qcom,ipq9574-tlmm";
>>               reg = <0x01000000 0x300000>;
>>

