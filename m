Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F5670ECBD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 06:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239037AbjEXExy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 00:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEXExw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 00:53:52 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63F213E;
        Tue, 23 May 2023 21:53:50 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34O4UKeh005024;
        Wed, 24 May 2023 04:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vaaPbw1ARTGRfOskyv4NiuJF0uHBDUVCzB7VY4qNrqg=;
 b=amXzxzQvBkRRpLSzLoSoL023sqjbACekChdxJLyWtz2yHlYIP+jP5+VW8ryyxHJeeEa6
 rY4JKy3AjJ1veLws/g5w6rxNevfOG8GNOXDf8zrSPA8BIJNXabxYYUkcmCtQYi6iFL5L
 tGo/tqBDEv1O+hPS6zqJg95lN/5XJE4TZQFRyrHxVLcPqAwu9SYyzJ/8BpI1yfc+7PAs
 s/pny1qtTeg6vThaU5P3akumGm8/WktE34UcYjo2ZaSU+zx7gwKZO3Qf65QrAlLI3qHu
 vssRY6u2JpfA3i+a2MXMuHjh/JFMqc3KagynuVb9iWV3/dRswF0e4InVAT6LYfNyRFZ+ EA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qs42urt2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 04:53:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34O4riID026837
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 04:53:44 GMT
Received: from [10.50.55.115] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 23 May
 2023 21:53:41 -0700
Message-ID: <03a9eb97-0961-5031-debe-acea03ee68fd@quicinc.com>
Date:   Wed, 24 May 2023 10:23:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] venus: replace arrary index with enum for supported
 formats
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-media@vger.kernel.org>, <stanimir.k.varbanov@gmail.com>,
        <quic_vgarodia@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <mchehab@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <1684736229-30567-1-git-send-email-quic_dikshita@quicinc.com>
 <0f7a33c1-f894-adfe-94d7-89296893128f@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <0f7a33c1-f894-adfe-94d7-89296893128f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AyHwFdofocAfPoz6xvonnD5EJWk1iU0Q
X-Proofpoint-GUID: AyHwFdofocAfPoz6xvonnD5EJWk1iU0Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_02,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240040
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/2023 1:32 PM, Konrad Dybcio wrote:
> 
> 
> On 22.05.2023 08:17, Dikshita Agarwal wrote:
>> Use enums to list supported formats for encoder and decoder
>> instead of array index which was a error prone design.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> ---
> Thanks a lot.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
>>  drivers/media/platform/qcom/venus/core.h | 16 ++++++++
>>  drivers/media/platform/qcom/venus/vdec.c | 63 +++++++++++++++++++-------------
>>  drivers/media/platform/qcom/venus/venc.c | 31 +++++++++-------
>>  3 files changed, 72 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
>> index 12a42fb..e988ed4 100644
>> --- a/drivers/media/platform/qcom/venus/core.h
>> +++ b/drivers/media/platform/qcom/venus/core.h
>> @@ -83,6 +83,22 @@ struct venus_resources {
>>  	const char *fwname;
>>  };
>>  
>> +enum venus_fmt {
>> +	VENUS_FMT_NV12			= 0,
>> +	VENUS_FMT_QC08C			= 1,
>> +	VENUS_FMT_QC10C			= 2,
>> +	VENUS_FMT_H264			= 3,
>> +	VENUS_FMT_VP8			= 4,
>> +	VENUS_FMT_VP9			= 5,
>> +	VENUS_FMT_HEVC			= 6,
>> +	VENUS_FMT_VC1_ANNEX_G		= 7,
>> +	VENUS_FMT_VC1_ANNEX_L		= 8,
>> +	VENUS_FMT_MPEG4			= 9,
>> +	VENUS_FMT_MPEG2			= 10,
>> +	VENUS_FMT_H263			= 11,
>> +	VENUS_FMT_XVID			= 12,
> Nit: I don't think the '= n' is necessary here, as it doesn't
> map to anything in hw/fw (or does it?)
> 
> Konrad
> 
Yes, It doesn't. Will remove in next patch.

Thanks,
Dikshita

>> +};
>> +
>>  struct venus_format {
>>  	u32 pixfmt;
>>  	unsigned int num_planes;
>> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
>> index c6f0fd08..bab985b 100644
>> --- a/drivers/media/platform/qcom/venus/vdec.c
>> +++ b/drivers/media/platform/qcom/venus/vdec.c
>> @@ -30,69 +30,82 @@
>>   * - future firmware versions could add support for >1 planes
>>   */
>>  static const struct venus_format vdec_formats[] = {
>> -	{
>> +	[VENUS_FMT_NV12] = {
>>  		.pixfmt = V4L2_PIX_FMT_NV12,
>>  		.num_planes = 1,
>>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
>> -	}, {
>> +	},
>> +	[VENUS_FMT_QC08C] = {
>>  		.pixfmt = V4L2_PIX_FMT_QC08C,
>>  		.num_planes = 1,
>>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
>> -	}, {
>> +	},
>> +	[VENUS_FMT_QC10C] = {
>>  		.pixfmt = V4L2_PIX_FMT_QC10C,
>>  		.num_planes = 1,
>>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
>> -	}, {
>> -		.pixfmt = V4L2_PIX_FMT_MPEG4,
>> +	},
>> +	[VENUS_FMT_H264] = {
>> +		.pixfmt = V4L2_PIX_FMT_H264,
>>  		.num_planes = 1,
>>  		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>>  		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
>> -	}, {
>> -		.pixfmt = V4L2_PIX_FMT_MPEG2,
>> +	},
>> +	[VENUS_FMT_VP8] = {
>> +		.pixfmt = V4L2_PIX_FMT_VP8,
>>  		.num_planes = 1,
>>  		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>>  		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
>> -	}, {
>> -		.pixfmt = V4L2_PIX_FMT_H263,
>> +	},
>> +	[VENUS_FMT_VP9] = {
>> +		.pixfmt = V4L2_PIX_FMT_VP9,
>>  		.num_planes = 1,
>>  		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>>  		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
>> -	}, {
>> -		.pixfmt = V4L2_PIX_FMT_VC1_ANNEX_G,
>> +	},
>> +	[VENUS_FMT_HEVC] = {
>> +		.pixfmt = V4L2_PIX_FMT_HEVC,
>>  		.num_planes = 1,
>>  		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>>  		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
>> -	}, {
>> -		.pixfmt = V4L2_PIX_FMT_VC1_ANNEX_L,
>> +	},
>> +	[VENUS_FMT_VC1_ANNEX_G] = {
>> +		.pixfmt = V4L2_PIX_FMT_VC1_ANNEX_G,
>>  		.num_planes = 1,
>>  		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>>  		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
>> -	}, {
>> -		.pixfmt = V4L2_PIX_FMT_H264,
>> +	},
>> +	[VENUS_FMT_VC1_ANNEX_L] = {
>> +		.pixfmt = V4L2_PIX_FMT_VC1_ANNEX_L,
>>  		.num_planes = 1,
>>  		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>>  		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
>> -	}, {
>> -		.pixfmt = V4L2_PIX_FMT_VP8,
>> +	},
>> +	[VENUS_FMT_MPEG4] = {
>> +		.pixfmt = V4L2_PIX_FMT_MPEG4,
>>  		.num_planes = 1,
>>  		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>>  		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
>> -	}, {
>> -		.pixfmt = V4L2_PIX_FMT_VP9,
>> +	},
>> +	[VENUS_FMT_MPEG2] = {
>> +		.pixfmt = V4L2_PIX_FMT_MPEG2,
>>  		.num_planes = 1,
>>  		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>>  		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
>> -	}, {
>> -		.pixfmt = V4L2_PIX_FMT_XVID,
>> +	},
>> +	[VENUS_FMT_H263] = {
>> +		.pixfmt = V4L2_PIX_FMT_H263,
>>  		.num_planes = 1,
>>  		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>>  		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
>> -	}, {
>> -		.pixfmt = V4L2_PIX_FMT_HEVC,
>> +	},
>> +	[VENUS_FMT_XVID] = {
>> +		.pixfmt = V4L2_PIX_FMT_XVID,
>>  		.num_planes = 1,
>>  		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>>  		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
>>  	},
>> +
>>  };
>>  
>>  static const struct venus_format *
>> @@ -1575,8 +1588,8 @@ static const struct hfi_inst_ops vdec_hfi_ops = {
>>  static void vdec_inst_init(struct venus_inst *inst)
>>  {
>>  	inst->hfi_codec = HFI_VIDEO_CODEC_H264;
>> -	inst->fmt_out = &vdec_formats[8];
>> -	inst->fmt_cap = &vdec_formats[0];
>> +	inst->fmt_out = &vdec_formats[VENUS_FMT_H264];
>> +	inst->fmt_cap = &vdec_formats[VENUS_FMT_NV12];
>>  	inst->width = frame_width_min(inst);
>>  	inst->height = ALIGN(frame_height_min(inst), 32);
>>  	inst->crop.left = 0;
>> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
>> index 4666f42..b60772c 100644
>> --- a/drivers/media/platform/qcom/venus/venc.c
>> +++ b/drivers/media/platform/qcom/venus/venc.c
>> @@ -32,28 +32,33 @@
>>   * - future firmware versions could add support for >1 planes
>>   */
>>  static const struct venus_format venc_formats[] = {
>> -	{
>> +	[VENUS_FMT_NV12] = {
>>  		.pixfmt = V4L2_PIX_FMT_NV12,
>>  		.num_planes = 1,
>>  		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>> -	}, {
>> -		.pixfmt = V4L2_PIX_FMT_MPEG4,
>> +	},
>> +	[VENUS_FMT_H264] = {
>> +		.pixfmt = V4L2_PIX_FMT_H264,
>>  		.num_planes = 1,
>>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
>> -	}, {
>> -		.pixfmt = V4L2_PIX_FMT_H263,
>> +	},
>> +	[VENUS_FMT_VP8] = {
>> +		.pixfmt = V4L2_PIX_FMT_VP8,
>>  		.num_planes = 1,
>>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
>> -	}, {
>> -		.pixfmt = V4L2_PIX_FMT_H264,
>> +	},
>> +	[VENUS_FMT_HEVC] = {
>> +		.pixfmt = V4L2_PIX_FMT_HEVC,
>>  		.num_planes = 1,
>>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
>> -	}, {
>> -		.pixfmt = V4L2_PIX_FMT_VP8,
>> +	},
>> +	[VENUS_FMT_MPEG4] = {
>> +		.pixfmt = V4L2_PIX_FMT_MPEG4,
>>  		.num_planes = 1,
>>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
>> -	}, {
>> -		.pixfmt = V4L2_PIX_FMT_HEVC,
>> +	},
>> +	[VENUS_FMT_H263] = {
>> +		.pixfmt = V4L2_PIX_FMT_H263,
>>  		.num_planes = 1,
>>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
>>  	},
>> @@ -1416,8 +1421,8 @@ static int m2m_queue_init(void *priv, struct vb2_queue *src_vq,
>>  
>>  static void venc_inst_init(struct venus_inst *inst)
>>  {
>> -	inst->fmt_cap = &venc_formats[3];
>> -	inst->fmt_out = &venc_formats[0];
>> +	inst->fmt_cap = &venc_formats[VENUS_FMT_H264];
>> +	inst->fmt_out = &venc_formats[VENUS_FMT_NV12];
>>  	inst->width = 1280;
>>  	inst->height = ALIGN(720, 32);
>>  	inst->out_width = 1280;
