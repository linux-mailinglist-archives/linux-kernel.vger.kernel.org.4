Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0936AD69F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 05:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjCGE6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 23:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjCGE6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 23:58:42 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8723A844;
        Mon,  6 Mar 2023 20:58:40 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3274K9mO029171;
        Tue, 7 Mar 2023 04:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vFjE5xOnMxVr7p3UiclRPXyqsU9qOGNnIi+3kPQ1UJc=;
 b=mfd0nOA+TwkHBhK5aZypywWXqTgX0sfUGUhpkdQz81ph8q7Fh4/vWz5OodkL5DpSHcGJ
 KFB1IWhd6na1Oxsfatg77t2VEh+LMFA789VLx0YZECTC+pue8gIe0E7rBthpm3MP0xtU
 3nyyKBNCI9IN+Kp3f7ZYgD46wm2AzPsOfC1lL9Dpi43ohKTagk3vnzAL5cGaRvnEZ3Na
 CEPa6RWy0EpujbHF/IXf2PxG5e2JMpojlgfQP3VfN0u8pVfWa4PsDv54ER+uEY824aQ4
 wlCzY168YgoeN2BgJpXvGm0OE+YEJyxXbTSphzUzZ19n/8LVAYc8FXjJCsSaAmoejBGV 8Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p5x5c81wk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 04:58:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3274w39i011614
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 04:58:03 GMT
Received: from [10.50.8.76] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 6 Mar 2023
 20:57:58 -0800
Message-ID: <a93a16ec-2e56-1d0b-c326-25f490d8f5b5@quicinc.com>
Date:   Tue, 7 Mar 2023 10:27:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: Re: [PATCH 07/18] media: venus: core: Assign registers based on VPU
 version
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>
CC:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Vikash Garodia" <vgarodia@codeaurora.org>
References: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
 <20230228-topic-venus-v1-7-58c2c88384e9@linaro.org>
Content-Language: en-US
In-Reply-To: <20230228-topic-venus-v1-7-58c2c88384e9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OXgYLx-no7SvEyF_4F2i-TjGuwa8TpYM
X-Proofpoint-GUID: OXgYLx-no7SvEyF_4F2i-TjGuwa8TpYM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 clxscore=1015 adultscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070043
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/28/2023 8:54 PM, Konrad Dybcio wrote:
> IRIS2(_1) has a different register map compared to other HFI6XX-
> using VPUs. Take care of it.
>
> Signed-off-by: Konrad Dybcio<konrad.dybcio@linaro.org>
> ---
>   drivers/media/platform/qcom/venus/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index c13436d58ed3..bdc14acc8399 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -246,7 +246,7 @@ static int venus_enumerate_codecs(struct venus_core *core, u32 type)
>   
>   static void venus_assign_register_offsets(struct venus_core *core)
>   {
> -	if (IS_V6(core)) {
> +	if (IS_IRIS2(core) || IS_IRIS2_1(core)) {
>   		core->vbif_base = core->base + VBIF_BASE;
>   		core->cpu_base = core->base + CPU_BASE_V6;
>   		core->cpu_cs_base = core->base + CPU_CS_BASE_V6;

AR50_LITE also should be added here, as I see you have added the same to 
places where we are using V6 based registers.

if the base addresses are not assigned here properly. the register 
writing at other places will be wrong, ex: patch 05/18

Thanks,

Dikshita

