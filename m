Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44DB673180
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 07:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjASGD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 01:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjASGDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 01:03:22 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F23D654DB;
        Wed, 18 Jan 2023 22:03:21 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J4uixX031817;
        Thu, 19 Jan 2023 06:03:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Zx3+u7KVTEPOomdLGNzu3Yfrw+y7cJzEGjCDC8iStvE=;
 b=kp5hxlBWvSQ/XHtN8gZM2dxVD/d+rOycj0N/x0XmYisSkav1zMH9TALNcvDamMe3AazQ
 gtTnrrAtSX6v2Uxj8d5ZRzHY6n7yja5UgXiSwjspplrvkJk0vGq7K+/T9FeDQyOIT4Rj
 8gLaCfpvCfVa6rcvsLBX66xaCS2aRAJtJBw/lmYOlaS02xDLOkiDYjFLPf+T1qTbQUNU
 jjyJuBAaMtY3+alt3drJqa+I6dyDSMCZOEPyL7kEjAOLlOLvD6meVh2S1glKW/Mnzn9j
 QbKueHKs3KddJX1yNvPm8IPyrpqWhRsx8P46H/C0TcIdLKIqFPeayQAdF+OMFZrztgQM Og== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n69uytn3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 06:03:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30J63C5F006659
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 06:03:12 GMT
Received: from [10.216.43.228] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 18 Jan
 2023 22:03:07 -0800
Message-ID: <96a20619-6253-3380-9a25-5f8d8b6a47cf@quicinc.com>
Date:   Thu, 19 Jan 2023 11:32:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: Re: [RESEND v3 4/4] clk: qcom: lpasscc-sc7280: Add resets for
 audioreach
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
 <6cea0a3f-08de-47d5-99d1-74b0d8c7b732@quicinc.com>
 <CAE-0n52ahKMzk0ho5jG1wxebm3ZE+Wfu_BunCaTR1WhN+J5jpw@mail.gmail.com>
Content-Language: en-US
Organization: Qualcomm
In-Reply-To: <CAE-0n52ahKMzk0ho5jG1wxebm3ZE+Wfu_BunCaTR1WhN+J5jpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8t5aiBsn8df7YEHofZN4oLrX8htXWwCL
X-Proofpoint-GUID: 8t5aiBsn8df7YEHofZN4oLrX8htXWwCL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190046
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/13/2023 1:05 AM, Stephen Boyd wrote:
> Quoting Srinivasa Rao Mandadapu (2023-01-11 23:53:23)
>> On 1/12/2023 2:54 AM, Stephen Boyd wrote:
>> Thanks for your time Stephen!!!
>>> Quoting Srinivasa Rao Mandadapu (2023-01-04 08:21:37)
>>>> diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc-sc7280.c
>>>> index 85dd5b9..1efb72d 100644
>>>> --- a/drivers/clk/qcom/lpasscc-sc7280.c
>>>> +++ b/drivers/clk/qcom/lpasscc-sc7280.c
>>>> @@ -102,6 +104,18 @@ static const struct qcom_cc_desc lpass_qdsp6ss_sc7280_desc = {
>>>>           .num_clks = ARRAY_SIZE(lpass_qdsp6ss_sc7280_clocks),
>>>>    };
>>>>
>>>> +static const struct qcom_reset_map lpass_cc_sc7280_resets[] = {
>>>> +       [LPASS_AUDIO_SWR_RX_CGCR] =  { 0xa0, 1 },
>>>> +       [LPASS_AUDIO_SWR_TX_CGCR] =  { 0xa8, 1 },
>>>> +       [LPASS_AUDIO_SWR_WSA_CGCR] = { 0xb0, 1 },
>>> Why are we adding these resets again? These are already exposed in
>>> lpassaudiocc-sc7280.c
>> As explained in previous versions, legacy path nodes are not being used
>> in ADSP based platforms, due to conflicts.
> What is legacy path nodes?
Legacy path nodes are for ADSP bypass use case such as nodes 
lpass_audiocc, lpass_core, etc.
>
>> Hence lpasscc node alone being used exclusively in ADSP based solution,
>> resets are added.
> I think I understand..
>
>> In probe also, these reset controls are enabled based on
>> "qcom,adsp-pil-mode" property.
>>
> but now I'm super confused! Please help me! We shouldn't have two
> different device nodes for the same physical hardware registers.
> Instead, we should have one node. The "qcom,adsp-pil-mode" property was
> supposed to indicate the different mode of operation.
>
> Maybe the audio clk and reset drivers on sc7280 are duplicating each
> other and one of them can be removed?

Yes agreed, that for controlling same registers from two different 
drivers is not good solution.

But, when we are validating ADSP solution, we have seen issues like ADSP 
is not coming out of reset with the existing bypass mode

clock drivers(lpassaudiocc_sc7280.c and lpasscoreecc_sc7280.c) enabled.

As per your suggestion, will try to address that  issues with 
"qcom,adsp-pil-mode" property and avoid duplicating reset control code

in lpasscc driver(lpasscc_sc7280.c).

