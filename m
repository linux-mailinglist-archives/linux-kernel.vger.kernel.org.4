Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A918666BD8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 08:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbjALHxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 02:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239582AbjALHxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:53:41 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35732D3;
        Wed, 11 Jan 2023 23:53:40 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30C507nG031933;
        Thu, 12 Jan 2023 07:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Z2E17IM8wAOkzE3bOMcYE5ko48avJ+SntFtszHOnGuc=;
 b=SiifzYuwUFICBPEh5dFp+77i6wvq0Imjzup0t8Vj9EPRcgPSkSLUFZN4i3FM2sCHgafq
 bWnHN9gr+GqHyifPlzcIAdtN5pOFyctKOKS3cz5MKtssfYUYac7Kf5rd6NUWzmWlGCc4
 gg7unVrCIzL1K5kcf7nbZiWLHovIETI0rIkJ1PkJP1Xa2BUfHyYC4DUz59UtA/M85l6M
 DPyVEyvfFuMvwS/NyPAFv9sPtYbO9FSgZJ9rDpslxHqs25WhoplWy8+5mHafQHLM9q5Y
 hVTAp+vxSQcIbzqXDykbnxr29Qo1Y/jVk20G3PWhmmtKiVuwR1DhZNvMMcXsxVhobxz1 cw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1kbqbaxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 07:53:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30C7rUru013433
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 07:53:30 GMT
Received: from [10.216.26.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 11 Jan
 2023 23:53:26 -0800
Message-ID: <6cea0a3f-08de-47d5-99d1-74b0d8c7b732@quicinc.com>
Date:   Thu, 12 Jan 2023 13:23:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND v3 4/4] clk: qcom: lpasscc-sc7280: Add resets for
 audioreach
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <broonie@kernel.org>,
        <konrad.dybcio@somainline.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mturquette@baylibre.com>,
        <quic_plai@quicinc.com>, <quic_rohkumar@quicinc.com>,
        <robh+dt@kernel.org>
References: <1672849297-3116-1-git-send-email-quic_srivasam@quicinc.com>
 <1672849297-3116-5-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n51AZCa9K_uY=ikTLqV-g_MsSA6Lv=Zq1LMrF-wVhR8_pg@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAE-0n51AZCa9K_uY=ikTLqV-g_MsSA6Lv=Zq1LMrF-wVhR8_pg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SKRscNP94S3IzVaPS207vQZG7rWJWdq_
X-Proofpoint-ORIG-GUID: SKRscNP94S3IzVaPS207vQZG7rWJWdq_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_04,2023-01-11_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120055
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/12/2023 2:54 AM, Stephen Boyd wrote:
Thanks for your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2023-01-04 08:21:37)
>> The clock gating control for TX/RX/WSA core bus clocks would be required
>> to be reset(moved from hardware control) from audio core driver. Thus
>> add the support for the reset clocks in audioreach based clock driver.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
>> ---
>>   drivers/clk/qcom/lpasscc-sc7280.c | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc-sc7280.c
>> index 85dd5b9..1efb72d 100644
>> --- a/drivers/clk/qcom/lpasscc-sc7280.c
>> +++ b/drivers/clk/qcom/lpasscc-sc7280.c
>> @@ -12,10 +12,12 @@
>>   #include <linux/regmap.h>
>>
>>   #include <dt-bindings/clock/qcom,lpass-sc7280.h>
>> +#include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
>>
>>   #include "clk-regmap.h"
>>   #include "clk-branch.h"
>>   #include "common.h"
>> +#include "reset.h"
>>
>>   static struct clk_branch lpass_top_cc_lpi_q6_axim_hs_clk = {
>>          .halt_reg = 0x0,
>> @@ -102,6 +104,18 @@ static const struct qcom_cc_desc lpass_qdsp6ss_sc7280_desc = {
>>          .num_clks = ARRAY_SIZE(lpass_qdsp6ss_sc7280_clocks),
>>   };
>>
>> +static const struct qcom_reset_map lpass_cc_sc7280_resets[] = {
>> +       [LPASS_AUDIO_SWR_RX_CGCR] =  { 0xa0, 1 },
>> +       [LPASS_AUDIO_SWR_TX_CGCR] =  { 0xa8, 1 },
>> +       [LPASS_AUDIO_SWR_WSA_CGCR] = { 0xb0, 1 },
> Why are we adding these resets again? These are already exposed in
> lpassaudiocc-sc7280.c

As explained in previous versions, legacy path nodes are not being used 
in ADSP based platforms, due to conflicts.

Hence lpasscc node alone being used exclusively in ADSP based solution, 
resets are added.

In probe also, these reset controls are enabled based on 
"qcom,adsp-pil-mode" property.

