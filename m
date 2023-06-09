Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D8D729879
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238762AbjFILtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjFILth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:49:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190651A2;
        Fri,  9 Jun 2023 04:49:36 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359B76Hr007692;
        Fri, 9 Jun 2023 11:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9iNEzxZcA2n7WfjPAMtIQuGjmo7X+UhXwONmGLbWsWo=;
 b=htTeTUFkKE04vFXgYrcK23c0FP7bhGOm9a5ZtZZao+aPVbJ492nuHBMSZzP1hCf4/obJ
 70RTQ4cBoi1QyO/0C5SdK02xUK++p5WcT3gON9vACBIVk/LxIqWw1zWt7MLoKqiAUrCp
 BW1bUciH1VKLpstTho0xEYDyVNtdBZFM1/oe40AXtNHWhUNrmzSroTZ5O48brZeBk1HT
 nPw07obTI4dPG42vqOaDziqB77nvO/eP0HU7FxOuiAezpkiLZhe1xoEUSARtbC04ytV/
 gxbnuyX9nieFDRMuLMwPzeTa7/5fIcGuVHE6F+45EMJbrFaheTxJQOHSY3yWaI5tZGxU Vw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r3t70h0en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 11:49:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 359BnTM1002529
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jun 2023 11:49:29 GMT
Received: from [10.218.22.90] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 9 Jun 2023
 04:49:23 -0700
Message-ID: <e9781cda-8eb4-99e0-8ed7-09c2534638e0@quicinc.com>
Date:   Fri, 9 Jun 2023 17:19:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V3 2/5] clk: qcom: Remove support to set CAL_L field in
 lucid evo pll configure
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
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
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <1d29bc3f-12db-a676-56f8-b8c1a09063dc@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: njf2o6aYKAmo_2LT01s3Nfo0-MesG3mh
X-Proofpoint-ORIG-GUID: njf2o6aYKAmo_2LT01s3Nfo0-MesG3mh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_08,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090100
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thanks for your review!

On 6/1/2023 8:16 PM, Dmitry Baryshkov wrote:
> On 01/06/2023 17:34, Jagadeesh Kona wrote:
>> For lucid evo and ole pll's the CAL_L, RINGOSC_CAL_L and L_VAL are
>> part of the same register, hence update the l configuration value
>> to include these fields across all the chipsets.
>>
>> Since the l configuration value now includes both L and CAL_L fields,
>> there is no need to explicitly set CAL_L field again in lucid evo pll
>> configure, Hence remove support to explicity set CAL_L field for evo pll.
>>
>> Fixes: 260e36606a03 ("clk: qcom: clk-alpha-pll: add Lucid EVO PLL 
>> configuration interfaces")
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> ---
>> Changes since V2:
>>   - Squashed update L val and remove explicit cal_l configuration to 
>> single patch
>>   - Updated L configuration for gpucc-sm8450 as well which was merged 
>> recently
>> Changes since V1:
>>   - Newly added.
>>
>>   drivers/clk/qcom/camcc-sm8450.c  | 24 ++++++++++++++++--------
>>   drivers/clk/qcom/clk-alpha-pll.c |  6 +-----
>>   drivers/clk/qcom/dispcc-sm8450.c |  6 ++++--
>>   drivers/clk/qcom/dispcc-sm8550.c |  6 ++++--
>>   drivers/clk/qcom/gpucc-sa8775p.c |  6 ++++--
>>   drivers/clk/qcom/gpucc-sm8450.c  |  6 ++++--
>>   6 files changed, 33 insertions(+), 21 deletions(-)
> 
> I'd say, this is still not a correct solution from my point of view. A 
> correct solution would be to follow the existing code and use constants 
> for the constant values (of CAL_L, and RINGOSC_CAL_L).
> 

Sure, will keep the existing code as is and will remove this patch in 
the next series.

>>
>> diff --git a/drivers/clk/qcom/camcc-sm8450.c 
>> b/drivers/clk/qcom/camcc-sm8450.c
>> index 51338a2884d2..6a5a08f88598 100644
>> --- a/drivers/clk/qcom/camcc-sm8450.c
>> +++ b/drivers/clk/qcom/camcc-sm8450.c
>> @@ -57,7 +57,8 @@ static const struct pll_vco rivian_evo_vco[] = {
>>   static const struct clk_parent_data pll_parent_data_tcxo = { .index 
>> = DT_BI_TCXO };
>>   static const struct alpha_pll_config cam_cc_pll0_config = {
>> -    .l = 0x3e,
>> +    /* .l includes CAL_L_VAL, L_VAL fields */
>> +    .l = 0x0044003e,
>>       .alpha = 0x8000,
>>       .config_ctl_val = 0x20485699,
>>       .config_ctl_hi_val = 0x00182261,
>> @@ -128,7 +129,8 @@ static struct clk_alpha_pll_postdiv 
>> cam_cc_pll0_out_odd = {
>>   };

[skipped]

Thanks & Regards,
Jagadeesh
