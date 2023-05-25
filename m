Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A005D710AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240915AbjEYLV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240923AbjEYLVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:21:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED92A10B;
        Thu, 25 May 2023 04:21:09 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34P7DZkw025224;
        Thu, 25 May 2023 11:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MooyYDAvUXB80RnYai+sdhsfLxypM4HoagMpzLxnROc=;
 b=SkxNKFq9rACtbN1/c3m9ji9InCrHQPhBX+FmmauSPDNm2WdKFD80GvGT/ejINk452ZI3
 imswCYZGRBSGf1ud4lD3Kpxw9uctDNa4izU7SZfb2OGh9l4ep7JHKyRBBNeK4rYo1WIU
 DfKAp09b18gHx5Arujpn9fYcJycUCxSHmLJ6lgDmaJnL+LrnwvsfAJDtY9jtDvxf3jTd
 gvrxzAiFyJWb5TbxobdUMJn6xe+UlJ+1e3ZDUAFulDCi0BCSfB9z31Uo1d7LvHkmJejb
 Klv/y6xYtgq5X2I2Kox+hp7RxcoVLjK4Zqu4ymhFqalYyQJExDeUdGaZ5z9Fh6b2q8pm Gw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qt27n0jk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:21:06 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34PBL5KV030217
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:21:05 GMT
Received: from [10.216.30.6] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 25 May
 2023 04:21:02 -0700
Message-ID: <feeb18db-2d7f-5e3b-bc28-57291e2d4255@quicinc.com>
Date:   Thu, 25 May 2023 16:50:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH][next] media: venus: Replace one-element arrays with
 flexible-array members
Content-Language: en-US
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <ZGPk3PpvYzjD1+0/@work>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <ZGPk3PpvYzjD1+0/@work>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4aB8-jSm9D0D8usGY7eJcUsfEfQMTYYd
X-Proofpoint-GUID: 4aB8-jSm9D0D8usGY7eJcUsfEfQMTYYd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_06,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 suspectscore=0
 clxscore=1011 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250094
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/2023 1:47 AM, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element arrays with flexible-array
> members in multiple structures, and refactor the rest of the code,
> accordingly.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/291
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

The patch looks good to me. It would be nice if we can combine all the patches
related to flexible array handling in video driver in a single patch series. At
the moment, there are multiple patches with similar subject.

> ---
>  drivers/media/platform/qcom/venus/hfi_msgs.c |  4 ++--
>  drivers/media/platform/qcom/venus/hfi_msgs.h | 14 +++++++-------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
> index df96db3761a7..6efd78606d9b 100644
> --- a/drivers/media/platform/qcom/venus/hfi_msgs.c
> +++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
> @@ -233,7 +233,7 @@ static void hfi_sys_init_done(struct venus_core *core, struct venus_inst *inst,
>  		goto done;
>  	}
>  
> -	rem_bytes = pkt->hdr.size - sizeof(*pkt) + sizeof(u32);
> +	rem_bytes = pkt->hdr.size - sizeof(*pkt);
>  	if (rem_bytes <= 0) {
>  		/* missing property data */
>  		error = HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
> @@ -434,7 +434,7 @@ static void hfi_session_init_done(struct venus_core *core,
>  	if (!IS_V1(core))
>  		goto done;
>  
> -	rem_bytes = pkt->shdr.hdr.size - sizeof(*pkt) + sizeof(u32);
> +	rem_bytes = pkt->shdr.hdr.size - sizeof(*pkt);
>  	if (rem_bytes <= 0) {
>  		error = HFI_ERR_SESSION_INSUFFICIENT_RESOURCES;
>  		goto done;
> diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.h b/drivers/media/platform/qcom/venus/hfi_msgs.h
> index 510513697335..8c2e17b0d36f 100644
> --- a/drivers/media/platform/qcom/venus/hfi_msgs.h
> +++ b/drivers/media/platform/qcom/venus/hfi_msgs.h
> @@ -50,7 +50,7 @@ struct hfi_msg_event_notify_pkt {
>  	u32 event_id;
>  	u32 event_data1;
>  	u32 event_data2;
> -	u32 ext_event_data[1];
> +	u32 ext_event_data[];
>  };
>  
>  struct hfi_msg_event_release_buffer_ref_pkt {
> @@ -63,7 +63,7 @@ struct hfi_msg_sys_init_done_pkt {
>  	struct hfi_pkt_hdr hdr;
>  	u32 error_type;
>  	u32 num_properties;
> -	u32 data[1];
> +	u32 data[];
>  };
>  
>  struct hfi_msg_sys_pc_prep_done_pkt {
> @@ -81,7 +81,7 @@ struct hfi_msg_session_init_done_pkt {
>  	struct hfi_session_hdr_pkt shdr;
>  	u32 error_type;
>  	u32 num_properties;
> -	u32 data[1];
> +	u32 data[];
>  };
>  
>  struct hfi_msg_session_end_done_pkt {
> @@ -228,7 +228,7 @@ struct hfi_msg_session_parse_sequence_header_done_pkt {
>  	struct hfi_session_hdr_pkt shdr;
>  	u32 error_type;
>  	u32 num_properties;
> -	u32 data[1];
> +	u32 data[];
>  };
>  
>  struct hfi_msg_session_property_info_pkt {
> @@ -247,7 +247,7 @@ struct hfi_msg_session_release_buffers_done_pkt {
>  	struct hfi_session_hdr_pkt shdr;
>  	u32 error_type;
>  	u32 num_buffers;
> -	u32 buffer_info[1];
> +	u32 buffer_info[];
>  };
>  
>  struct hfi_msg_sys_debug_pkt {
> @@ -256,7 +256,7 @@ struct hfi_msg_sys_debug_pkt {
>  	u32 msg_size;
>  	u32 time_stamp_hi;
>  	u32 time_stamp_lo;
> -	u8 msg_data[1];
> +	u8 msg_data[];
>  };
>  
>  struct hfi_msg_sys_coverage_pkt {
> @@ -264,7 +264,7 @@ struct hfi_msg_sys_coverage_pkt {
>  	u32 msg_size;
>  	u32 time_stamp_hi;
>  	u32 time_stamp_lo;
> -	u8 msg_data[1];
> +	u8 msg_data[];
>  };
>  
>  struct venus_core;
