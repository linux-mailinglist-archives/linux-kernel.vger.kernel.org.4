Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF1171971E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjFAJh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjFAJhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:37:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B966134;
        Thu,  1 Jun 2023 02:37:50 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35158eBY001802;
        Thu, 1 Jun 2023 09:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=W/k5FMFIiDVmSGnrut0ZiBHdp2E7/iWBsuAHGK4OneQ=;
 b=aaR8TJV7UT/UKozPBCcuyI1lja+jXwzkpPudkB7Ycv5s4DNAwOwaL4o1D5/sWDSxUhA7
 qHjXDZEa7IxXFFKTEl3maZfhaucbAq+hhUpS1z97FmewH9VQtbt57/KdRhjg2LrpD3CM
 wbubUrh6DgKdq7OxMfFCJKhlTYvP5ghcE49wjgPK/K4xh/akJcsLPku/H5A7FkfiX4En
 n7JTgQS6cCqJDscIPbc0fhgcwVsg6CBUIiToqtfQ9yGhVgd0ZfIjjYY4OI+wk4EvrKMJ
 OzynjYjIRbWMrQEDT0DvRNYXfb6mHeMLg1R7dB0NB4ryoa9MyvGJya3abwT6BCz6mFJZ 1A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxbt8hjf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 09:37:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3519bHEC030133
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 09:37:17 GMT
Received: from [10.50.56.241] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 1 Jun 2023
 02:37:12 -0700
Message-ID: <a04910bf-f8f3-dc15-5ce8-7300ac6a060c@quicinc.com>
Date:   Thu, 1 Jun 2023 15:07:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 15/17] media: venus: Introduce accessors for remapped
 hfi_buffer_reqs members
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Hans Verkuil <hans.verkuil@cisco.com>
CC:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Marijn Suijten" <marijn.suijten@somainline.org>
References: <20230228-topic-venus-v4-0-feebb2f6e9b8@linaro.org>
 <20230228-topic-venus-v4-15-feebb2f6e9b8@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230228-topic-venus-v4-15-feebb2f6e9b8@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9N_jhD34ycGEc9-UQGieCFxrOfeFRvZD
X-Proofpoint-ORIG-GUID: 9N_jhD34ycGEc9-UQGieCFxrOfeFRvZD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_06,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2306010085
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/2023 6:00 PM, Konrad Dybcio wrote:
> Currently we have macros to access these, but they don't provide a
> way to override the remapped fields. Replace the macros with actual
> get/set pairs to fix that.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>

> ---
>  drivers/media/platform/qcom/venus/helpers.c    |  2 +-
>  drivers/media/platform/qcom/venus/hfi_helper.h | 61 ++++++++++++++++++++++----
>  drivers/media/platform/qcom/venus/hfi_msgs.c   |  2 +-
>  drivers/media/platform/qcom/venus/vdec.c       |  8 ++--
>  drivers/media/platform/qcom/venus/vdec_ctrls.c |  2 +-
>  drivers/media/platform/qcom/venus/venc.c       |  4 +-
>  drivers/media/platform/qcom/venus/venc_ctrls.c |  2 +-
>  7 files changed, 63 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index 1822e85ab6bf..b70bd3dac4df 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -189,7 +189,7 @@ int venus_helper_alloc_dpb_bufs(struct venus_inst *inst)
>  	if (ret)
>  		return ret;
>  
> -	count = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);
> +	count = hfi_bufreq_get_count_min(&bufreq, ver);
>  
>  	for (i = 0; i < count; i++) {
>  		buf = kzalloc(sizeof(*buf), GFP_KERNEL);
> diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
> index 0abbc50c5864..e4c05d62cfc7 100644
> --- a/drivers/media/platform/qcom/venus/hfi_helper.h
> +++ b/drivers/media/platform/qcom/venus/hfi_helper.h
> @@ -1170,14 +1170,6 @@ struct hfi_buffer_display_hold_count_actual {
>  	u32 hold_count;
>  };
>  
> -/* HFI 4XX reorder the fields, use these macros */
> -#define HFI_BUFREQ_HOLD_COUNT(bufreq, ver)	\
> -	((ver) == HFI_VERSION_4XX ? 0 : (bufreq)->hold_count)
> -#define HFI_BUFREQ_COUNT_MIN(bufreq, ver)	\
> -	((ver) == HFI_VERSION_4XX ? (bufreq)->hold_count : (bufreq)->count_min)
> -#define HFI_BUFREQ_COUNT_MIN_HOST(bufreq, ver)	\
> -	((ver) == HFI_VERSION_4XX ? (bufreq)->count_min : 0)
> -
>  struct hfi_buffer_requirements {
>  	u32 type;
>  	u32 size;
> @@ -1189,6 +1181,59 @@ struct hfi_buffer_requirements {
>  	u32 alignment;
>  };
>  
> +/* On HFI 4XX, some of the struct members have been swapped. */
> +static inline u32 hfi_bufreq_get_hold_count(struct hfi_buffer_requirements *req,
> +					    u32 ver)
> +{
> +	if (ver == HFI_VERSION_4XX)
> +		return 0;
> +
> +	return req->hold_count;
> +};
> +
> +static inline u32 hfi_bufreq_get_count_min(struct hfi_buffer_requirements *req,
> +					   u32 ver)
> +{
> +	if (ver == HFI_VERSION_4XX)
> +		return req->hold_count;
> +
> +	return req->count_min;
> +};
> +
> +static inline u32 hfi_bufreq_get_count_min_host(struct hfi_buffer_requirements *req,
> +						u32 ver)
> +{
> +	if (ver == HFI_VERSION_4XX)
> +		return req->count_min;
> +
> +	return 0;
> +};
> +
> +static inline void hfi_bufreq_set_hold_count(struct hfi_buffer_requirements *req,
> +					     u32 ver, u32 val)
> +{
> +	if (ver == HFI_VERSION_4XX)
> +		return;
> +
> +	req->hold_count = val;
> +};
> +
> +static inline void hfi_bufreq_set_count_min(struct hfi_buffer_requirements *req,
> +					    u32 ver, u32 val)
> +{
> +	if (ver == HFI_VERSION_4XX)
> +		req->hold_count = val;
> +
> +	req->count_min = val;
> +};
> +
> +static inline void hfi_bufreq_set_count_min_host(struct hfi_buffer_requirements *req,
> +						 u32 ver, u32 val)
> +{
> +	if (ver == HFI_VERSION_4XX)
> +		req->count_min = val;
> +};
> +
>  struct hfi_data_payload {
>  	u32 size;
>  	u8 data[1];
> diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
> index 3d5dadfa1900..7cab685a2ec8 100644
> --- a/drivers/media/platform/qcom/venus/hfi_msgs.c
> +++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
> @@ -99,7 +99,7 @@ static void event_seq_changed(struct venus_core *core, struct venus_inst *inst,
>  		case HFI_PROPERTY_CONFIG_BUFFER_REQUIREMENTS:
>  			data_ptr += sizeof(u32);
>  			bufreq = (struct hfi_buffer_requirements *)data_ptr;
> -			event.buf_count = HFI_BUFREQ_COUNT_MIN(bufreq, ver);
> +			event.buf_count = hfi_bufreq_get_count_min(bufreq, ver);
>  			data_ptr += sizeof(*bufreq);
>  			break;
>  		case HFI_INDEX_EXTRADATA_INPUT_CROP:
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 063a8b0d357b..2a1e038f92cf 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -899,13 +899,13 @@ static int vdec_num_buffers(struct venus_inst *inst, unsigned int *in_num,
>  	if (ret)
>  		return ret;
>  
> -	*in_num = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);
> +	*in_num = hfi_bufreq_get_count_min(&bufreq, ver);
>  
>  	ret = venus_helper_get_bufreq(inst, HFI_BUFFER_OUTPUT, &bufreq);
>  	if (ret)
>  		return ret;
>  
> -	*out_num = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);
> +	*out_num = hfi_bufreq_get_count_min(&bufreq, ver);
>  
>  	return 0;
>  }
> @@ -1019,14 +1019,14 @@ static int vdec_verify_conf(struct venus_inst *inst)
>  		return ret;
>  
>  	if (inst->num_output_bufs < bufreq.count_actual ||
> -	    inst->num_output_bufs < HFI_BUFREQ_COUNT_MIN(&bufreq, ver))
> +	    inst->num_output_bufs < hfi_bufreq_get_count_min(&bufreq, ver))
>  		return -EINVAL;
>  
>  	ret = venus_helper_get_bufreq(inst, HFI_BUFFER_INPUT, &bufreq);
>  	if (ret)
>  		return ret;
>  
> -	if (inst->num_input_bufs < HFI_BUFREQ_COUNT_MIN(&bufreq, ver))
> +	if (inst->num_input_bufs < hfi_bufreq_get_count_min(&bufreq, ver))
>  		return -EINVAL;
>  
>  	return 0;
> diff --git a/drivers/media/platform/qcom/venus/vdec_ctrls.c b/drivers/media/platform/qcom/venus/vdec_ctrls.c
> index fbe12a608b21..7e0f29bf7fae 100644
> --- a/drivers/media/platform/qcom/venus/vdec_ctrls.c
> +++ b/drivers/media/platform/qcom/venus/vdec_ctrls.c
> @@ -79,7 +79,7 @@ static int vdec_op_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
>  	case V4L2_CID_MIN_BUFFERS_FOR_CAPTURE:
>  		ret = venus_helper_get_bufreq(inst, HFI_BUFFER_OUTPUT, &bufreq);
>  		if (!ret)
> -			ctrl->val = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);
> +			ctrl->val = hfi_bufreq_get_count_min(&bufreq, ver);
>  		break;
>  	default:
>  		return -EINVAL;
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index b60772cc2cdc..d2e2d3108752 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -1207,7 +1207,7 @@ static int venc_verify_conf(struct venus_inst *inst)
>  		return ret;
>  
>  	if (inst->num_output_bufs < bufreq.count_actual ||
> -	    inst->num_output_bufs < HFI_BUFREQ_COUNT_MIN(&bufreq, ver))
> +	    inst->num_output_bufs < hfi_bufreq_get_count_min(&bufreq, ver))
>  		return -EINVAL;
>  
>  	ret = venus_helper_get_bufreq(inst, HFI_BUFFER_INPUT, &bufreq);
> @@ -1215,7 +1215,7 @@ static int venc_verify_conf(struct venus_inst *inst)
>  		return ret;
>  
>  	if (inst->num_input_bufs < bufreq.count_actual ||
> -	    inst->num_input_bufs < HFI_BUFREQ_COUNT_MIN(&bufreq, ver))
> +	    inst->num_input_bufs < hfi_bufreq_get_count_min(&bufreq, ver))
>  		return -EINVAL;
>  
>  	return 0;
> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
> index 7468e43800a9..d9d2a293f3ef 100644
> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
> @@ -358,7 +358,7 @@ static int venc_op_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
>  	case V4L2_CID_MIN_BUFFERS_FOR_OUTPUT:
>  		ret = venus_helper_get_bufreq(inst, HFI_BUFFER_INPUT, &bufreq);
>  		if (!ret)
> -			ctrl->val = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);
> +			ctrl->val = hfi_bufreq_get_count_min(&bufreq, ver);
>  		break;
>  	default:
>  		return -EINVAL;
> 
