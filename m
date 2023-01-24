Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8846791EC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 08:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjAXH2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 02:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAXH2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 02:28:07 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1175E974C;
        Mon, 23 Jan 2023 23:28:05 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30O7OPln026293;
        Tue, 24 Jan 2023 07:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KwQ/PtpYUTz+cVdN4b3hZ/Dm5u2vC7+yvEKnwB3nkAA=;
 b=PS6PoZCpSi3B5YUgjUt0VCH2FSsVBbgrEXJLdKMOUew2dgGxjzZae6oGyOg9dsEu9scL
 o/sCPGpSyUYi1dZa5fZhaOEpZxCMj6MNk6pLI0zMQb/iAtcI1pHIduLb/hsOIpMq+149
 +FYBevsmSikxwHlz/qK54206eVkZdDWMAOtwDW70ug+4560bkpXDllnUpEZd7FkJVMaM
 V7xpr4LRpN2DLDBPgSI1dt3pd96cmlk2urXZ+Dym2xvZzT5e0DxouZ5jsoazhCQGv8oP
 5DzUwm1TAqN41MA4pVHIRyBCPm6qlIaeyp5e+BG0ylMkGO2zpVqITQX0JHqvRnXaRsEG Gw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89dncfdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 07:27:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30O7RGuG011025
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 07:27:16 GMT
Received: from [10.216.24.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 23 Jan
 2023 23:27:07 -0800
Message-ID: <2852fc37-284f-6534-f163-45b37b153db1@quicinc.com>
Date:   Tue, 24 Jan 2023 12:57:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/7] clk: qcom: Add Global Clock Controller driver for
 IPQ9574
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <tdas@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230110121316.24892-1-quic_devipriy@quicinc.com>
 <20230110121316.24892-3-quic_devipriy@quicinc.com>
 <de346d71-1fe7-e357-d220-d4468e4bb933@linaro.org>
 <afd2e5c8-fa5a-ac1f-4ede-4ab1f91c0d0d@quicinc.com>
 <9bdf757d-1fa0-106f-eb77-7f2a8593213f@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <9bdf757d-1fa0-106f-eb77-7f2a8593213f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: STEphrwkEN8UcQaS1cFm2yXVFfi5Dkf-
X-Proofpoint-ORIG-GUID: STEphrwkEN8UcQaS1cFm2yXVFfi5Dkf-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240068
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/2023 7:39 PM, Konrad Dybcio wrote:
> 
> 
> On 13.01.2023 14:21, Devi Priya wrote:
>>
>>
>> On 1/10/2023 6:07 PM, Konrad Dybcio wrote:
>>>
>>>
>>> On 10.01.2023 13:13, devi priya wrote:
>>>> Add Global Clock Controller (GCC) driver for ipq9574 based devices
>>>>
>>>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>>>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>>>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>>>> ---
> [...]
> 
>>>> +static struct clk_branch gcc_blsp1_qup6_i2c_apps_clk = {
>>>> +    .halt_reg = 0x07024,
>>>> +    .clkr = {
>>>> +        .enable_reg = 0x07024,
>>>> +        .enable_mask = BIT(0),
>>>> +        .hw.init = &(struct clk_init_data) {
>>>> +            .name = "gcc_blsp1_qup6_i2c_apps_clk",
>>>> +            .parent_hws = (const struct clk_hw *[]) {
>>>> +                    &blsp1_qup6_i2c_apps_clk_src.clkr.hw },
>>>> +            .num_parents = 1,
>>>> +            .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>> Sounds very much like a hack..
>> Got it, will remove the clock entry as it is not being used in linux
> I'm not sure removing it is the best option, somebody might have a
> funky board where they use this particular QUP for I2C for whatever
> reason and then the clock would have to be re-added..
Sure, Understood
This clock is used by the RPM component to communicate with PMIC and we
would add the critical flag here

> Thanks for addressing all of the review comments so thoroughly!
> 
> Konrad

Best Regards,
Devi Priya
