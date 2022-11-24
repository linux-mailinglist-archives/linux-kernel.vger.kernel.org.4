Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA76E637D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 16:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiKXPye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 10:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiKXPye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 10:54:34 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B72E9C;
        Thu, 24 Nov 2022 07:54:33 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AOFIvje017461;
        Thu, 24 Nov 2022 15:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2BIvH7iayCMWg8gb27+0elQiVMFXFEltpHJSRz2KlDk=;
 b=aA0EkP+k130IMBZeo2tTvnIgvtitKEzGQRNlxlCdCXEcnUmdwE5wL9O6tKtFjbHfnTky
 TOdeoQSQiezv1mUTvhl8GWoMICvetd+yIFfNZWABIUjNu10zL/SwJMGis9Wjc7MlnLMR
 E6PePpCMNc5DoEsDCiiE+ltVy5GhSupYyUwTOxsgOmsCoh7784ifvFduVB0a+fvoqbed
 3SF1usUT/VshB+ZFznBWSmOPfjHg/Mmh2W+0Xl40eAZT8pA6zPyhVxOTNo8HHxrnuPjP
 CwH3AS/iJbQVE4n/gE8funRkIcVVgoNOzdFF0Pr/b2zTjKW0pFImbzyeMIY37A1A14EF +g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m1gxemxru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Nov 2022 15:54:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AOFsTgm016016
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Nov 2022 15:54:29 GMT
Received: from [10.50.29.33] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 24 Nov
 2022 07:54:23 -0800
Message-ID: <896278fb-1af8-609b-cd64-f3f59530e9b0@quicinc.com>
Date:   Thu, 24 Nov 2022 21:24:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 02/10] arm64: dts: qcom: Add base SM8550 dtsi
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20221124135646.1952727-1-abel.vesa@linaro.org>
 <20221124135646.1952727-3-abel.vesa@linaro.org>
 <351fa466-90cb-b73f-a2a4-749bc3529e22@quicinc.com>
 <0a119446-4ec1-46ce-68e5-f177f9cb49e3@linaro.org>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <0a119446-4ec1-46ce-68e5-f177f9cb49e3@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AF6WOsy388_CatpevdHadwR-eBCPZTuv
X-Proofpoint-ORIG-GUID: AF6WOsy388_CatpevdHadwR-eBCPZTuv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-24_11,2022-11-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxlogscore=960 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211240119
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/2022 9:10 PM, Konrad Dybcio wrote:
> 
> 
> On 24.11.2022 16:39, Sai Prakash Ranjan wrote:
>> Hi,
>>
>> On 11/24/2022 7:26 PM, Abel Vesa wrote:
>>> Add base dtsi for SM8550 SoC and includes base description of
>>> CPUs, GCC, RPMHCC, UART, interrupt controller, TLMM, reserved
>>> memory, RPMh PD, TCSRCC, ITS, IPCC, AOSS QMP, LLCC, cpufreq,
>>> interconnect, thermal sensor, cpu cooling maps and SMMU nodes
>>> which helps boot to shell with console on boards with this SoC.
>>>
>>> Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>> ---
>>
>> <snip>...
>>
>>> +    timer {
>>> +        compatible = "arm,armv8-timer";
>>> +        interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>>> +                 <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>>> +                 <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>>> +                 <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
>>
>> This last interrupt must be Hypervisor physical irq(10) and 12 is Hyp virtual irq, so please change it to 10. I guess you got this from downstream but it's not right and they don't boot kernel in EL2.
> Does non-CrOS 8550 FW allow Linux to boot in EL2?
> 

Sadly no, which is why this entry always gets wrong downstream.

Thanks,
Sai

