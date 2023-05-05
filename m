Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABBC6F834E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjEEMxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjEEMxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:53:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CCD7D94;
        Fri,  5 May 2023 05:53:12 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345CFsBQ002685;
        Fri, 5 May 2023 12:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ar1kM1e1tLyKv9O+RaMugTwPmptBtCE+qx4uwas7fKw=;
 b=eXN0W7ckPUMPmSdwxtkPIL8BXAMGkJ5/wSkq7g+uNel40mukLIYdeK2kLLg3WEazJSty
 1kbLvdqk8/ZUOzjdY8mveMTLHKILXU2koZ70uYAFjqzwlMXHpeAISJj/4cBqps0mDhgL
 g23NG+EDDamDc4RWAUWaNBZTTVio3SvTLYohgp45bjmk9XlSbfl91hLK6xCimQ5rH9x9
 uElZixk6mAMmBGwo4W/RWiXZlTSGXYN526k0pFWOqTDZWXoFgj4n/0Iqdx9eLfhJnrsi
 ewL0HNoo4GX3x+lEsSmjOfsYbSr/sBosEDdtL42fA2nsiTadNZeZZiKsj/1lQfi7VExR 2A== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qcb24b4e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 12:52:39 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 345CqcUH019681
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 May 2023 12:52:38 GMT
Received: from [10.216.37.178] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 5 May 2023
 05:52:33 -0700
Message-ID: <4b17186f-fe85-e733-8242-85ff49ecb84a@quicinc.com>
Date:   Fri, 5 May 2023 18:22:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 05/18] media: venus: Add vpu_version to most SoCs
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
CC:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Marijn Suijten" <marijn.suijten@somainline.org>
References: <20230228-topic-venus-v2-0-d95d14949c79@linaro.org>
 <20230228-topic-venus-v2-5-d95d14949c79@linaro.org>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <20230228-topic-venus-v2-5-d95d14949c79@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fKTkCW46D0JvO7xgBe7EvIph_mmu1m77
X-Proofpoint-ORIG-GUID: fKTkCW46D0JvO7xgBe7EvIph_mmu1m77
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_20,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050107
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/4/2023 1:31 PM, Konrad Dybcio wrote:
> Add vpu_version where I was able to retrieve the information to
> allow for more precise hardware-specific code path matching.
>
> Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>   drivers/media/platform/qcom/venus/core.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 2ae867cb4c48..01671dd23888 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -684,6 +684,7 @@ static const struct venus_resources sdm845_res = {
>   	.vcodec_clks_num = 2,
>   	.max_load = 3110400,	/* 4096x2160@90 */
>   	.hfi_version = HFI_VERSION_4XX,
> +	.vpu_version = VPU_VERSION_AR50,
>   	.vmem_id = VIDC_RESOURCE_NONE,
>   	.vmem_size = 0,
>   	.vmem_addr = 0,
> @@ -709,6 +710,7 @@ static const struct venus_resources sdm845_res_v2 = {
>   	.vcodec_num = 2,
>   	.max_load = 3110400,	/* 4096x2160@90 */
>   	.hfi_version = HFI_VERSION_4XX,
> +	.vpu_version = VPU_VERSION_AR50,
>   	.vmem_id = VIDC_RESOURCE_NONE,
>   	.vmem_size = 0,
>   	.vmem_addr = 0,
> @@ -756,6 +758,7 @@ static const struct venus_resources sc7180_res = {
>   	.opp_pmdomain = (const char *[]) { "cx", NULL },
>   	.vcodec_num = 1,
>   	.hfi_version = HFI_VERSION_4XX,
> +	.vpu_version = VPU_VERSION_AR50,
>   	.vmem_id = VIDC_RESOURCE_NONE,
>   	.vmem_size = 0,
>   	.vmem_addr = 0,
> @@ -809,6 +812,7 @@ static const struct venus_resources sm8250_res = {
>   	.vcodec_num = 1,
>   	.max_load = 7833600,
>   	.hfi_version = HFI_VERSION_6XX,
> +	.vpu_version = VPU_VERSION_IRIS2,
>   	.num_vpp_pipes = 4,
>   	.vmem_id = VIDC_RESOURCE_NONE,
>   	.vmem_size = 0,
> @@ -866,6 +870,7 @@ static const struct venus_resources sc7280_res = {
>   	.opp_pmdomain = (const char *[]) { "cx", NULL },
>   	.vcodec_num = 1,
>   	.hfi_version = HFI_VERSION_6XX,
> +	.vpu_version = VPU_VERSION_IRIS2_1,
>   	.num_vpp_pipes = 1,
>   	.vmem_id = VIDC_RESOURCE_NONE,
>   	.vmem_size = 0,
>
