Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A0D710B60
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241033AbjEYLrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240984AbjEYLrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:47:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41037191;
        Thu, 25 May 2023 04:47:36 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PB8L4Q007263;
        Thu, 25 May 2023 11:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hEUWdeTi4mK21GVCqOIEwdQER9Z8iC6hcSsvbzwM8GQ=;
 b=X6IpyKohDn94298t+/21q02G6O+5ACYLEDyOVCuadEHvO6AE8TVK5oHHsxXxMlSY55D+
 K58S8fKUvcfo/SY+snp6lM3sP9tJhSmmkdwJp7cAn1KE6vHURlZFc48Rk0gbXIDsuSAI
 7FOX80k8tfXgogYv3wTevYlSrEB0zjB134PZV1+kZdKU4Ei71mi2cewlpIzQP7KWG8w/
 dRdYFsTJICH07Nu8HH3rLqmbjhs8hf/pJg8Sr8WCggYvsORqQ6buq3jgFFwZNdw00+R3
 xSjjuuAKm5/1rMkPhulDusuYiXNRNcshFcWx9dSzvHrBrTZKHeFNUFzkRr17rhcPsy0+ TQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qt02a8vum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:47:32 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34PBlU7j024750
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:47:31 GMT
Received: from [10.216.30.6] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 25 May
 2023 04:47:27 -0700
Message-ID: <723574d9-3c43-987e-9638-6d8ff58b1809@quicinc.com>
Date:   Thu, 25 May 2023 17:17:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2][next] media: venus: hfi_cmds: Replace one-element
 array with flexible-array member
Content-Language: en-US
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <cover.1684278538.git.gustavoars@kernel.org>
 <e4b13d7b79d1477e775c6d4564f7b23c4cf967f2.1684278538.git.gustavoars@kernel.org>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <e4b13d7b79d1477e775c6d4564f7b23c4cf967f2.1684278538.git.gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Y1woQtVZtUntwXPbPWweBtSuAsKzA8uL
X-Proofpoint-ORIG-GUID: Y1woQtVZtUntwXPbPWweBtSuAsKzA8uL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_06,2023-05-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 mlxscore=0 phishscore=0 adultscore=0 impostorscore=0 mlxlogscore=959
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250098
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/2023 4:44 AM, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element arrays with flexible-array
> members in struct hfi_session_set_buffers_pkt, and refactor the rest of
> the code, accordingly.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/292
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

The patch looks good. As stated in previous patch, lets combine this into a
single series.

> ---
>  drivers/media/platform/qcom/venus/hfi_cmds.c | 12 ++++++------
>  drivers/media/platform/qcom/venus/hfi_cmds.h |  2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
> index bc3f8ff05840..21d1b3c90dc0 100644
> --- a/drivers/media/platform/qcom/venus/hfi_cmds.c
> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
> @@ -200,8 +200,8 @@ int pkt_session_set_buffers(struct hfi_session_set_buffers_pkt *pkt,
>  		struct hfi_buffer_info *bi;
>  
>  		pkt->extradata_size = bd->extradata_size;
> -		pkt->shdr.hdr.size = sizeof(*pkt) - sizeof(u32) +
> -			(bd->num_buffers * sizeof(*bi));
> +		pkt->shdr.hdr.size = sizeof(*pkt) +
> +			bd->num_buffers * sizeof(*bi);
>  		bi = (struct hfi_buffer_info *)pkt->buffer_info;
>  		for (i = 0; i < pkt->num_buffers; i++) {
>  			bi->buffer_addr = bd->device_addr;
> @@ -210,7 +210,7 @@ int pkt_session_set_buffers(struct hfi_session_set_buffers_pkt *pkt,
>  	} else {
>  		pkt->extradata_size = 0;
>  		pkt->shdr.hdr.size = sizeof(*pkt) +
> -			((bd->num_buffers - 1) * sizeof(u32));
> +			bd->num_buffers * sizeof(u32);
>  		for (i = 0; i < pkt->num_buffers; i++)
>  			pkt->buffer_info[i] = bd->device_addr;
>  	}
> @@ -243,8 +243,8 @@ int pkt_session_unset_buffers(struct hfi_session_release_buffer_pkt *pkt,
>  			bi->extradata_addr = bd->extradata_addr;
>  		}
>  		pkt->shdr.hdr.size =
> -				sizeof(struct hfi_session_set_buffers_pkt) -
> -				sizeof(u32) + (bd->num_buffers * sizeof(*bi));
> +				sizeof(struct hfi_session_set_buffers_pkt) +
> +				bd->num_buffers * sizeof(*bi);
>  	} else {
>  		for (i = 0; i < pkt->num_buffers; i++)
>  			pkt->buffer_info[i] = bd->device_addr;
> @@ -252,7 +252,7 @@ int pkt_session_unset_buffers(struct hfi_session_release_buffer_pkt *pkt,
>  		pkt->extradata_size = 0;
>  		pkt->shdr.hdr.size =
>  				sizeof(struct hfi_session_set_buffers_pkt) +
> -				((bd->num_buffers - 1) * sizeof(u32));
> +				bd->num_buffers * sizeof(u32);
>  	}
>  
>  	pkt->response_req = bd->response_required;
> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
> index 99bc0b6db67c..ba74d03eb9cd 100644
> --- a/drivers/media/platform/qcom/venus/hfi_cmds.h
> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
> @@ -117,7 +117,7 @@ struct hfi_session_set_buffers_pkt {
>  	u32 extradata_size;
>  	u32 min_buffer_size;
>  	u32 num_buffers;
> -	u32 buffer_info[1];
> +	u32 buffer_info[];
>  };
>  
>  struct hfi_session_get_sequence_header_pkt {
