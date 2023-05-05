Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060B16F8345
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjEEMua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjEEMu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:50:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0CDA1;
        Fri,  5 May 2023 05:50:27 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345CHDW8025318;
        Fri, 5 May 2023 12:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aD+qcCGrJp8zKWQgqR40XTDjzZ5ZkOMlUIl4zYjx5Yo=;
 b=IKfl9TWOR34xZLn9OCMsPSKeUsTOQ5J9mTFG/0lCTRewWi1Q3pmGqji98HeIUcwCuEXs
 f/SwZnv7GMsqWjP3Eh5SMKiNEft8GE9Jh3A9STeTpAjbay8TGkL28zHH6KozYuTBwgfE
 2RMsl5ru5mlsYvZzF+PSKN2gaepr6/YESwPh4SNYarU3ZPHWbuiN2H1S1PMdJ0oQuPR+
 5O5kNeO6XbMrOpoD9c9extbcgq/Mkb11aOWbdIE0gcu5JpK/9aJJBcA786gRTjuBFVgz
 ZGXorHwTYfkWpOxZTj3wWG9GhQn87hJkXCTiljDTCQh8WYL3LPCedPmAWCtilOvj08Mp IQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qce6mjf58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 12:49:52 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 345Cnpj6026316
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 May 2023 12:49:52 GMT
Received: from [10.216.37.178] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 5 May 2023
 05:49:47 -0700
Message-ID: <110eadd8-facd-09a8-2e8c-80811c2087fb@quicinc.com>
Date:   Fri, 5 May 2023 18:19:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 04/18] media: venus: Introduce VPU version distinction
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
 <20230228-topic-venus-v2-4-d95d14949c79@linaro.org>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <20230228-topic-venus-v2-4-d95d14949c79@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: q9k3_aTFB4oqMXOWnn6OzgNJfSHvmwXi
X-Proofpoint-ORIG-GUID: q9k3_aTFB4oqMXOWnn6OzgNJfSHvmwXi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_20,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050107
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/2023 1:31 PM, Konrad Dybcio wrote:
> The Video Processing Unit hardware version is the differentiator,
> based on which we should decide which code paths to take in hw
we -> video driver
> init. Up until now, we've relied on HFI versions, but that was

not just hw init, aspects like power sequence, buffer calculations, etc 
would

rely on hardware version.

Once the above comments are addressed, you can put

Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>

> just a happy accident between recent SoCs. Add a field in the
> res struct and add correlated definitions that will be used to
> account for the aforementioned differences.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/media/platform/qcom/venus/core.h | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 4f81669986ba..62c310b7dee6 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -48,6 +48,14 @@ struct bw_tbl {
>   	u32 peak_10bit;
>   };
>   
> +enum vpu_version {
> +	VPU_VERSION_AR50,
> +	VPU_VERSION_AR50_LITE,
> +	VPU_VERSION_IRIS1,
> +	VPU_VERSION_IRIS2,
> +	VPU_VERSION_IRIS2_1,
> +};
> +
>   struct venus_resources {
>   	u64 dma_mask;
>   	const struct freq_tbl *freq_tbl;
> @@ -71,6 +79,7 @@ struct venus_resources {
>   	const char * const resets[VIDC_RESETS_NUM_MAX];
>   	unsigned int resets_num;
>   	enum hfi_version hfi_version;
> +	enum vpu_version vpu_version;
>   	u8 num_vpp_pipes;
>   	u32 max_load;
>   	unsigned int vmem_id;
> @@ -481,6 +490,12 @@ struct venus_inst {
>   #define IS_V4(core)	((core)->res->hfi_version == HFI_VERSION_4XX)
>   #define IS_V6(core)	((core)->res->hfi_version == HFI_VERSION_6XX)
>   
> +#define IS_AR50(core)		((core)->res->vpu_version == VPU_VERSION_AR50)
> +#define IS_AR50_LITE(core)	((core)->res->vpu_version == VPU_VERSION_AR50_LITE)
> +#define IS_IRIS1(core)		((core)->res->vpu_version == VPU_VERSION_IRIS1)
> +#define IS_IRIS2(core)		((core)->res->vpu_version == VPU_VERSION_IRIS2)
> +#define IS_IRIS2_1(core)	((core)->res->vpu_version == VPU_VERSION_IRIS2_1)
> +
>   #define ctrl_to_inst(ctrl)	\
>   	container_of((ctrl)->handler, struct venus_inst, ctrl_handler)
>   
>
