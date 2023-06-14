Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A0B72FD9E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244354AbjFNL5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244330AbjFNL47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:56:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3581FCC;
        Wed, 14 Jun 2023 04:56:43 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35E9mBwC018778;
        Wed, 14 Jun 2023 11:56:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dQcVv9DjkkTgUb/PKALRSALMB212uPuisuPUeeq3Dnw=;
 b=DoWMyw90kuf8hC7uyWWGBj0Ls55XAjozi15Xem5v9DVT38/e3UEY+Ez+wLcTYBM8eS0K
 V+X35bpZCVz5b24t+Y46dIvDtBORd9nCCsomIVQ+cyxS7wxQ1eLiJtRVQ5qm8ycPKoUQ
 5DLrxbZBTwUh/q3A8ajLgyvxMt/PX/1L4R1UuZ/08/kkdQ4i+19yaDnzSrqJcIw2tW6t
 Ki4SL/6VEsJ86wtl4I4lT7Pg/6MVRcnUDEIgKUwAQ5FVDoK374giSp9qhUUmQKg1d/d6
 dtwOKvddVGvUzUjxHkxrucO37HFgeikLXRuoObZy7jTvXeKOtyO4TRyQhfGzxFts64eG qA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7b818b8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 11:56:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35EBucSr026919
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 11:56:38 GMT
Received: from [10.218.5.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 14 Jun
 2023 04:56:32 -0700
Message-ID: <572c2826-82e8-ccd5-c870-cfea99c759dc@quicinc.com>
Date:   Wed, 14 Jun 2023 17:26:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V3 2/5] clk: qcom: Remove support to set CAL_L field in
 lucid evo pll configure
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230601143430.5595-1-quic_jkona@quicinc.com>
 <20230601143430.5595-3-quic_jkona@quicinc.com>
 <1d29bc3f-12db-a676-56f8-b8c1a09063dc@linaro.org>
 <e9781cda-8eb4-99e0-8ed7-09c2534638e0@quicinc.com>
 <71d5758c-793a-3e9a-543f-19e326ecfcd4@linaro.org>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <71d5758c-793a-3e9a-543f-19e326ecfcd4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: B_VcgUFkFNnOkE7UT4BinNEJY6ZHKRdc
X-Proofpoint-GUID: B_VcgUFkFNnOkE7UT4BinNEJY6ZHKRdc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_07,2023-06-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140102
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/2023 6:18 PM, Konrad Dybcio wrote:
> 
> 
> On 9.06.2023 13:49, Jagadeesh Kona wrote:
>> Hi Dmitry,
>>
>> Thanks for your review!
>>
>> On 6/1/2023 8:16 PM, Dmitry Baryshkov wrote:
>>> On 01/06/2023 17:34, Jagadeesh Kona wrote:
>>>> For lucid evo and ole pll's the CAL_L, RINGOSC_CAL_L and L_VAL are
>>>> part of the same register, hence update the l configuration value
>>>> to include these fields across all the chipsets.
>>>>
>>>> Since the l configuration value now includes both L and CAL_L fields,
>>>> there is no need to explicitly set CAL_L field again in lucid evo pll
>>>> configure, Hence remove support to explicity set CAL_L field for evo pll.
>>>>
>>>> Fixes: 260e36606a03 ("clk: qcom: clk-alpha-pll: add Lucid EVO PLL configuration interfaces")
>>>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>> ---
>>>> Changes since V2:
>>>>    - Squashed update L val and remove explicit cal_l configuration to single patch
>>>>    - Updated L configuration for gpucc-sm8450 as well which was merged recently
>>>> Changes since V1:
>>>>    - Newly added.
>>>>
>>>>    drivers/clk/qcom/camcc-sm8450.c  | 24 ++++++++++++++++--------
>>>>    drivers/clk/qcom/clk-alpha-pll.c |  6 +-----
>>>>    drivers/clk/qcom/dispcc-sm8450.c |  6 ++++--
>>>>    drivers/clk/qcom/dispcc-sm8550.c |  6 ++++--
>>>>    drivers/clk/qcom/gpucc-sa8775p.c |  6 ++++--
>>>>    drivers/clk/qcom/gpucc-sm8450.c  |  6 ++++--
>>>>    6 files changed, 33 insertions(+), 21 deletions(-)
>>>
>>> I'd say, this is still not a correct solution from my point of view. A correct solution would be to follow the existing code and use constants for the constant values (of CAL_L, and RINGOSC_CAL_L).
>>>
>>
>> Sure, will keep the existing code as is and will remove this patch in the next series.
>>
>>>>
>>>> diff --git a/drivers/clk/qcom/camcc-sm8450.c b/drivers/clk/qcom/camcc-sm8450.c
>>>> index 51338a2884d2..6a5a08f88598 100644
>>>> --- a/drivers/clk/qcom/camcc-sm8450.c
>>>> +++ b/drivers/clk/qcom/camcc-sm8450.c
>>>> @@ -57,7 +57,8 @@ static const struct pll_vco rivian_evo_vco[] = {
>>>>    static const struct clk_parent_data pll_parent_data_tcxo = { .index = DT_BI_TCXO };
>>>>    static const struct alpha_pll_config cam_cc_pll0_config = {
>>>> -    .l = 0x3e,
>>>> +    /* .l includes CAL_L_VAL, L_VAL fields */
>>>> +    .l = 0x0044003e,
>>>>        .alpha = 0x8000,
>>>>        .config_ctl_val = 0x20485699,
>>>>        .config_ctl_hi_val = 0x00182261,
>>>> @@ -128,7 +129,8 @@ static struct clk_alpha_pll_postdiv cam_cc_pll0_out_odd = {
>>>>    };
>>
>> [skipped]
>>
>> Thanks & Regards,
>> Jagadeesh
> Another non-patch-related nit, you don't have to (and shouldn't) cut off
> parts of the email unless it helps you "get to the point". You can also
> include your signature after the last paragraph you reply with.
> 
> Konrad

Sure, will take care from now.

Thanks,
Jagadeesh
