Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E0767B647
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbjAYPwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbjAYPv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:51:58 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF9B5975A;
        Wed, 25 Jan 2023 07:51:53 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PEP7B4030492;
        Wed, 25 Jan 2023 15:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Ot3thYC/XF960Hm4CCL8hZjS2AUE9XkW1K+tW89TnXg=;
 b=j3XjAWjmmitofe6f7v7wRCAN+q81GZLuePym9+Bn5377FTG/XGTIWIUwM7bMGaxbbTNe
 vUoX9oc6N6ylVzNtYtVgVr9f9gNFIOfSp3C3sOQPwX5+fEd1dSuS9S9bLnf3EcVMnx+0
 mbJIfNWC73UX5XqRq8IlWYw8LkdxaiG3o7mA3ABA9Nz8UGFU4VMwrE4Kqa4vodPOV6xC
 RqRnkNQJvbDg7JhidIrFRv66RwtM6UMv5uPaPn6R8DppB/tUoZqsx+9wxUmVjEg0kwvb
 zX9m5I9ePSQv8POPCUuUyh6ehikdnUcmYhzz3Eeq0Mv+sorwKZ+Z/gsxpU3oWcYqWoeU CQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3napvhhgdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 15:51:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30PFp1La011821
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 15:51:01 GMT
Received: from [10.50.43.172] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 25 Jan
 2023 07:50:52 -0800
Message-ID: <bbd084bf-b670-6121-5173-373e3c91b955@quicinc.com>
Date:   Wed, 25 Jan 2023 21:20:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 04/10] dt-bindings: clock: Add Qualcomm IPQ5332 GCC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <robimarko@gmail.com>, <quic_gurus@quicinc.com>,
        <bhupesh.sharma@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230125104520.89684-1-quic_kathirav@quicinc.com>
 <20230125104520.89684-5-quic_kathirav@quicinc.com>
 <ccddc46f-b007-4e0c-9c1f-df2c13d459eb@linaro.org>
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <ccddc46f-b007-4e0c-9c1f-df2c13d459eb@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eGeuIrkmqau1Mo9Fudal6J6rV-ngOgyJ
X-Proofpoint-ORIG-GUID: eGeuIrkmqau1Mo9Fudal6J6rV-ngOgyJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_10,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 adultscore=0 impostorscore=0 mlxscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250141
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/25/2023 4:43 PM, Krzysztof Kozlowski wrote:
> On 25/01/2023 11:45, Kathiravan Thirumoorthy wrote:
>> From: Kathiravan T <quic_kathirav@quicinc.com>
>>
>> Add binding for the Qualcomm IPQ5332 Global Clock Controller.
>>
>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>> ---
> Thank you for your patch. There is something to discuss/improve.


Thanks for taking time to review the patch.


>
>> +  clocks:
>> +    items:
>> +      - description: Board XO clock source
>> +      - description: Sleep clock source
>> +      - description: PCIE 2lane PHY pipe clock source
>> +      - description: PCIE 2lane x1 PHY pipe clock source (For second lane)
>> +      - description: USB PCIE wrapper pipe clock source
>> +
>> +  clock-names:
>> +    items:
>> +      - const: xo
>> +      - const: sleep_clk
>> +      - const: pcie_2lane_phy_pipe_clk
>> +      - const: pcie_2lane_phy_pipe_clk_x1
>> +      - const: usb_pcie_wrapper_pipe_clk
>> +
>> +required:
>> +  - compatible
> clocks are required


Ack.


>
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    clock-controller@1800000 {
>> +      compatible = "qcom,ipq5332-gcc";
>> +      reg = <0x01800000 0x80000>;
>> +      #clock-cells = <1>;
>> +      #power-domain-cells = <1>;
>> +      #reset-cells = <1>;
>> +    };
>> +...
>> diff --git a/include/dt-bindings/clock/qcom,gcc-ipq5332.h b/include/dt-bindings/clock/qcom,gcc-ipq5332.h
>> new file mode 100644
>> index 000000000000..a305c648b724
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/qcom,gcc-ipq5332.h
> Filename should match bindings/compatible.


Ack.


>
>
> Best regards,
> Krzysztof


Thanks,

Kathiravan T.

