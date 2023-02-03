Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982D86898E6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjBCMf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjBCMfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:35:18 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730B65FE5;
        Fri,  3 Feb 2023 04:35:09 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 313ANVlV026075;
        Fri, 3 Feb 2023 12:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mMBR5w+q1boHomjumnwZghbt93c2LBQycWI9O28G1Bw=;
 b=CPsxI74jIauecLH2Bfc3VrcDLfN7OjDae+wtVjSmmp8fXtlDHVBw6r32krn0Bb4uilJN
 z6nCzRuI7sN9H+PRak9fH3GCnGhqHycuuKk5l7BPjFngnpt/0pwxK62cN4Q6FSY1gfo8
 EXBl0JBnhhIOnHzdlZQZxurjN0GFvno/iSAIbdt/ri7yBbDFeBJz6mBos4BOGV2D010S
 d2xP7MCzI/rcjO8bqT9W3Q0AttMSBUFykHbtQRWd5vy64DChEwGCf5TTyXjbBPegX+SP
 KxB6fLS9IcQBiDwXJzQLi31G2jq6DdokpGEzwaJutPqH3G2xFLFGesj5pLDXzJYGv+D3 Sw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ngh1ka69c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 12:34:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 313CYkvl012258
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Feb 2023 12:34:46 GMT
Received: from [10.50.53.202] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 3 Feb 2023
 04:34:37 -0800
Message-ID: <b3c1e629-179f-d2c3-d3eb-3556a7df10ae@quicinc.com>
Date:   Fri, 3 Feb 2023 18:04:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V6 2/7] clk: qcom: Add Global Clock Controller driver for
 IPQ9574
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Devi Priya <quic_devipriy@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
References: <20230202150619.22425-1-quic_devipriy@quicinc.com>
 <20230202150619.22425-3-quic_devipriy@quicinc.com>
 <1d144aa4-6f0f-b10f-1d32-4acf4e06ae85@quicinc.com>
 <e34f36b0-35a8-0b77-e6ab-49851213108e@linaro.org>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <e34f36b0-35a8-0b77-e6ab-49851213108e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: s73mYnFUxvt8OOjaVYgOTjdnQIb7LJA5
X-Proofpoint-ORIG-GUID: s73mYnFUxvt8OOjaVYgOTjdnQIb7LJA5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_08,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030115
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/3/2023 4:25 PM, Konrad Dybcio wrote:
>
> On 3.02.2023 06:47, Kathiravan T wrote:
>> On 2/2/2023 8:36 PM, Devi Priya wrote:
>>> Add Global Clock Controller (GCC) driver for ipq9574 based devices
>>>
>>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>>> ---
> [...]
>
>>> +static int gcc_ipq9574_probe(struct platform_device *pdev)
>>> +{
>>> +    struct regmap *regmap;
>>> +    struct qcom_cc_desc ipq9574_desc = gcc_ipq9574_desc;
>>> +
>>> +    regmap = qcom_cc_map(pdev, &ipq9574_desc);
>>> +    if (IS_ERR(regmap))
>>> +        return PTR_ERR(regmap);
>>> +
>>> +    return qcom_cc_really_probe(pdev, &ipq9574_desc, regmap);
>>
>> can we use qcom_cc_probe as suggested here https://lore.kernel.org/linux-arm-msm/84f68577f5629e6ef6d6b14357a79f84.sboyd@kernel.org/ ?
> Yes we can.
>
> When you're answering a long long long long email, please cut off
> parts that you aren't replying to, I had to scroll and scroll and
> scroll and scroll to get to this sentence and I'm not even sure if
> you said something inbetween that I missed..


Got it, Thanks.


>
> Konrad
>>
>>> +}
>>> +
>>> +static struct platform_driver gcc_ipq9574_driver = {
>>> +    .probe = gcc_ipq9574_probe,
>>> +    .driver = {
>>> +        .name   = "qcom,gcc-ipq9574",
>>> +        .of_match_table = gcc_ipq9574_match_table,
>>> +    },
>>> +};
>>> +
>>> +static int __init gcc_ipq9574_init(void)
>>> +{
>>> +    return platform_driver_register(&gcc_ipq9574_driver);
>>> +}
>>> +core_initcall(gcc_ipq9574_init);
>>> +
>>> +static void __exit gcc_ipq9574_exit(void)
>>> +{
>>> +    platform_driver_unregister(&gcc_ipq9574_driver);
>>> +}
>>> +module_exit(gcc_ipq9574_exit);
>>> +
>>> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. GCC IPQ9574 Driver");
>>> +MODULE_LICENSE("GPL");
