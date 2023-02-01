Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C13685F16
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 06:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjBAFkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 00:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBAFkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 00:40:47 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC70C2F7B6;
        Tue, 31 Jan 2023 21:40:45 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3114hVWK019045;
        Wed, 1 Feb 2023 05:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1ZQLY4JP9CFPZH5dg3QKURoMzTHYkPTIsf4DAw2H110=;
 b=nU8FtbXC92G9MgW05zlnHkVnwB1Jo6WqO1uF6rAQ8JPJrNQi25UQHREGnp4oGosuBHCb
 Hjw4Cw7snDtPs43TTQbPJGiuy6hjeCcl7phmEl++1F7o/A7TymK3ZSMCURPMJUAoj7G9
 yXRyZXSMmim7asNqt/T17r1vwBQZ2E1Hco1zRW3nPVCArEqci5y7OUcvro0Z9udqeis3
 LHRSqv6fOZCzeS+xketwVJ773gMEYvYZsoZGQcOtnoZ4UweCZzD+sbm2+JZeoX6RtiAP
 QG/DyRmqiSZbVLpP4wW83v2ZuSk2z4R1nqlYLRaiZkSl7S2NgOi+nIzJYC9/fvZcTqVa og== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3neua9b8wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 05:40:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3115eTVe002498
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 05:40:29 GMT
Received: from [10.50.28.88] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 31 Jan
 2023 21:40:22 -0800
Message-ID: <7997e4ec-cadf-3dbd-d5df-edda502b2613@quicinc.com>
Date:   Wed, 1 Feb 2023 11:10:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V2 8/9] arm64: dts: qcom: add IPQ5332 SoC and MI01.2 board
 support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <dmitry.baryshkov@linaro.org>, <marcel.ziswiler@toradex.com>,
        <nfraprado@collabora.com>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230130114702.20606-1-quic_kathirav@quicinc.com>
 <20230130114702.20606-9-quic_kathirav@quicinc.com>
 <c031fad0-8f3b-60dc-9429-7bd78ae8a2d0@linaro.org>
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <c031fad0-8f3b-60dc-9429-7bd78ae8a2d0@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kDgJIhXcKjnAVRylTMHsolfr7nCL_dtN
X-Proofpoint-ORIG-GUID: kDgJIhXcKjnAVRylTMHsolfr7nCL_dtN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_02,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302010048
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/1/2023 12:56 AM, Krzysztof Kozlowski wrote:
> On 30/01/2023 12:47, Kathiravan Thirumoorthy wrote:
>> From: Kathiravan T <quic_kathirav@quicinc.com>
>>
>> Add initial device tree support for the Qualcomm IPQ5332 SoC and
>> MI01.2 board.
>>
>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>
>> +		sdhc: mmc@7804000 {
>> +			compatible = "qcom,ipq5332-sdhci", "qcom,sdhci-msm-v5";
>> +			reg = <0x07804000 0x1000>, <0x07805000 0x1000>;
>> +
>> +			interrupts = <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "hc_irq", "pwr_irq";
>> +
>> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
>> +				 <&gcc GCC_SDCC1_APPS_CLK>,
>> +				 <&xo_board>;
>> +			clock-names = "iface", "core", "xo";
>> +			mmc-ddr-1_8v;
>> +			mmc-hs200-1_8v;
> No, our discussion did not finish. These are not properties of the SoC
> in most cases. Why do you say there are part of the SoC? Is your SoC
> coming with the same memory? Memory embedded in the SoC, not in the
> board? If yes, the status is incorrect.


Thanks. Got your point, will move the below properties to the board DTS 
in V3.

mmc-ddr-1_8v;
mmc-hs200-1_8v;
max-frequency = <192000000>;
bus-width = <4>;


>
>> +			max-frequency = <192000000>;
> Same
>
>
> Best regards,
> Krzysztof
>
