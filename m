Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA754653189
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 14:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiLUNS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 08:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLUNSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 08:18:24 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB3D1EEFC;
        Wed, 21 Dec 2022 05:18:23 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BLCQhMa011655;
        Wed, 21 Dec 2022 13:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wjsYk5Xn3nuoj50vklfGDoOMhx7eOhLfE4x/GbRnJ5M=;
 b=FfuZWRpweFHcRHIiOYn7WqABNgBuqyAuvkgEHWDeK3yVWyKlG/wPGFl/iBIXSfZTl9LQ
 XpFay6K4ORVdNVpTfO/kJ4DPl8Z1hm8LdLc/6TBN+qCs7lTxa2FzjsIjgR160pMlzurR
 00ynZCXp5DLEGle7ZmroicUzsl9FhVN/A7XGasINxPTWXDHfmL6inQJFapftDm7H9Pqm
 1oKI95zzTYwK91DfqEdCRBtfKBWhptic0eN0xFzosi7rnMAZCWd1GKRvgKYCDNzCteC6
 qCdw70iJwIOpMnz2ZemqYFizCbSclTH1J3Ut6t3LLPbkIwlCI1W3LLdwMVAOr+yoDwMN Aw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mk39tbyfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 13:18:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BLDIFlW027031
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 13:18:15 GMT
Received: from [10.216.2.240] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 21 Dec
 2022 05:18:10 -0800
Message-ID: <e7edd629-986f-3e64-f9db-5ee68cf4e6f3@quicinc.com>
Date:   Wed, 21 Dec 2022 18:48:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] clk: qcom: lpasscc: Add resets for SC7280 audioreach
 clock controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <swboyd@chromium.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <quic_plai@quicinc.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
References: <1671618061-6329-1-git-send-email-quic_srivasam@quicinc.com>
 <1671618061-6329-3-git-send-email-quic_srivasam@quicinc.com>
 <efde6373-f788-5c0c-4712-7b9caf7ad3d4@linaro.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <efde6373-f788-5c0c-4712-7b9caf7ad3d4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qpNI6SHiaKOg6hbEzPiaOCumjl8VvSC9
X-Proofpoint-GUID: qpNI6SHiaKOg6hbEzPiaOCumjl8VvSC9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_07,2022-12-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212210109
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/21/2022 4:09 PM, Krzysztof Kozlowski wrote:
Thanks for your time Krzysztof!!!
> On 21/12/2022 11:21, Srinivasa Rao Mandadapu wrote:
>> The clock gating control for TX/RX/WSA core bus clocks would be required
>> to be reset(moved from hardware control) from audio core driver. Thus
>> add the support for the reset clocks in audioreach based clock driver.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> ---
>>   drivers/clk/qcom/lpasscc-sc7280.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc-sc7280.c
>> index 5c1e17b..d81d81b 100644
>> --- a/drivers/clk/qcom/lpasscc-sc7280.c
>> +++ b/drivers/clk/qcom/lpasscc-sc7280.c
>> @@ -12,10 +12,12 @@
>>   #include <linux/regmap.h>
>>   
>>   #include <dt-bindings/clock/qcom,lpass-sc7280.h>
>> +#include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
> These are bindings for different device.

They are not exactly for different device. It's for same device with 
ADSP enabled platforms.

Basically lpassaudiocc-sc7280.c and lpasscorecc-sc7280.c are for legacy 
path.

lpasscc-sc7280.c is for ADSP based AudioReach Solution.

>
>>   
>>   #include "clk-regmap.h"
>>   #include "clk-branch.h"
>>   #include "common.h"
>> +#include "reset.h"
>>   
>>   static struct clk_branch lpass_top_cc_lpi_q6_axim_hs_clk = {
>>   	.halt_reg = 0x0,
>> @@ -102,6 +104,18 @@ static const struct qcom_cc_desc lpass_qdsp6ss_sc7280_desc = {
>>   	.num_clks = ARRAY_SIZE(lpass_qdsp6ss_sc7280_clocks),
>>   };
>>   
>> +static const struct qcom_reset_map lpass_cc_sc7280_resets[] = {
>> +	[LPASS_AUDIO_SWR_RX_CGCR] =  { 0xa0, 1 },
>> +	[LPASS_AUDIO_SWR_TX_CGCR] =  { 0xa8, 1 },
>> +	[LPASS_AUDIO_SWR_WSA_CGCR] = { 0xb0, 1 },
> These are example the same - IDs and values - as
> qcom,sc7280-lpassaudiocc. Aren't you duplicating same control?

As explained above legacy path drivers and ADSP path drivers are 
enabled/used exclusively,

adding reset controls here.

>
> Best regards,
> Krzysztof
>
