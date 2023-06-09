Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE67E7298B3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239361AbjFILvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238739AbjFILvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:51:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8870B3AAD;
        Fri,  9 Jun 2023 04:50:58 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359Av9T0024877;
        Fri, 9 Jun 2023 11:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=24lEg8bCMGcH8cHbp/wXPddAnU/D1pDxSHRdc8/G59I=;
 b=E9NKt82G82wAz+9A01jxkhx7Wgqm2ifTcaN2bO60fTjlu7tWVbgJooiKjQHsaxiTOKSD
 41DesTIXUixVa50IUqK6zYnvf1lTNYHXEFbkemSXxxd6XkbyL05GpRZdfYdTCHAS8BvN
 IYU385I7jAbNuyHie2HOVlQrgs6DGzlr9lHa+SVKUd8PwB3+Y6TIzO6euRd3QWJVTT6s
 2tYYg0HBZ677NgFVZUT2HLm1dG1YyjSzGErGIe5A5Q8CGus4q1i52xQYGAkZ25A/W07E
 k88VFHMnN1sO++Obm0+JdNitide8JS6N5eHFUSjkST75woIFedv0nGELPx4VzdEp9Lot ug== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r3w7drqh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 11:50:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 359BoR31014281
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jun 2023 11:50:27 GMT
Received: from [10.218.22.90] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 9 Jun 2023
 04:50:21 -0700
Message-ID: <1a6d46e4-7ec4-262c-dc3b-fc9c988f979e@quicinc.com>
Date:   Fri, 9 Jun 2023 17:20:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V2 3/6] clk: qcom: clk-alpha-pll: Remove explicit CAL_L
 configuration for EVO PLL
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
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
References: <20230525172142.9039-1-quic_jkona@quicinc.com>
 <20230525172142.9039-4-quic_jkona@quicinc.com>
 <6e1d098d-03b9-aa63-a0bf-6cf748a0db0d@linaro.org>
 <7074f718-a3d5-8a03-3830-77a5a0b15500@linaro.org>
 <df7ab6f7-6c5e-9a7d-8d9b-09ff32da34d6@quicinc.com>
 <c60bb4d9-1b53-6c60-8b9d-13069bdff882@linaro.org>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <c60bb4d9-1b53-6c60-8b9d-13069bdff882@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: y3TdAal3_8cUXyTGX4wfpfBn9VT8LGxB
X-Proofpoint-ORIG-GUID: y3TdAal3_8cUXyTGX4wfpfBn9VT8LGxB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_08,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 phishscore=0 adultscore=0 mlxlogscore=601
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090100
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thanks for your review!

On 6/1/2023 8:13 PM, Dmitry Baryshkov wrote:
> On 01/06/2023 17:33, Jagadeesh Kona wrote:
>> Hi Dmitry, Konrad,
>>
>> On 5/26/2023 9:23 PM, Dmitry Baryshkov wrote:
>>> On 26/05/2023 12:33, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 25.05.2023 19:21, Jagadeesh Kona wrote:
>>>>> In lucid evo pll, the CAL_L field is part of L value register 
>>>>> itself, and
>>>>> the l value configuration passed from clock controller driver includes
>>>>> CAL_L and L values as well. Hence remove explicit configuration of 
>>>>> CAL_L
>>>>> for evo pll.
>>>>>
>>>>> Fixes: 260e36606a03 ("clk: qcom: clk-alpha-pll: add Lucid EVO PLL 
>>>>> configuration interfaces")
>>>>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>>>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>>> ---
>>>> Oh that isn't obvious at first sight, nice find!
>>>>
>>>> I'd suggest a different solution though:
>>>>
>>>> #define LUCID_EVO_PLL_L_LVAL    GENMASK(..
>>>> #define LUCID_EVO_PLL_L_CAL_L    GENMASK(..
>>>>
>>>> lval = FIELD_PREP(LUCID_EVO_PLL_L_LVAL, config->l) |
>>>>         FIELD_PREP(LUCID_EVO_PLL_L_CAL_L, config->cal_l);
>>>>
>>>> This would make the separation between the two parts more explicit
>>>>
>>>> however
>>>>
>>>> config->l would then represent the L value and not the end value
>>>> written to the L register
>>>
>>> Yes. I think there should be separate config->l and config->cal_l 
>>> values (and probably ringosc_cal_l, basing on the comment in the 
>>> source).
>>> Thanks for your suggestions. In all recent chipsets, L & CAL_L fields 
>> are encapsulated in the same register, so we feel it is better to 
>> directly pass the combined configuration value in config->l itself and 
>> program it directly into register without any additional handling 
>> required in pll driver code.
> 
> My feeling is that it is better to split it, since these are the 
> different fields. The value .l = 0x4444003e doesn't mean anything per se.
> 
> Three values are much more meaningful:
> .l = 0x3e,
> .cal_l = 0x44,
> .ringosc_cal_l = 0x44,
> 
> Not to mention that this way you don't have to touch pll configuration 
> for the existing Lucid EVO PLL. Not to mention that for the Lucid ole 
> PLLs the cal_l and ringosc_cal_l values seem to be static (0x44), so 
> there is no need to put them to the variable data.
> 

Sure, will keep the existing code as is and will remove this patch in 
the next series.

>>
>> Also the evo pll code is currently reused for both lucid evo and ole 
>> pll's. Lucid ole PLL has an additional RINGOSC_CAL_L field along with 
>> L, CAL_L fields in the same L register. By passing combined 
>> configuration value in config->l itself, we feel we can avoid all the 
>> additional handling required in PLL code.
>>
>>> Just a question: is camcc-sm8550 using the same PLL type or is it 
>>> some kind of subtype of lucid_evo PLL?
>>>
>> No, it is not the same lucid evo PLL. It uses lucid ole PLL.
> 
> Then please don't reuse the clk_lucid_evo_pll_configure() call.
> You can add a new one, which will handle L/CAL_L/RINGOSC_CAL_L differences.
> 

The only difference between evo and ole pll configure is extra 
RINGOSC_CAL_L programming needed only for ole pll. We can achieve the 
same with clk_lucid_evo_pll_configure() itself by directly including 
RINGOSC_CAL_L field in L configuration for OLE PLL's.

Thanks & Regards,
Jagadeesh
