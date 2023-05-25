Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A029C710BEB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241067AbjEYMUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbjEYMUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:20:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D036BA9;
        Thu, 25 May 2023 05:20:45 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PBsBUj014490;
        Thu, 25 May 2023 12:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=k3qaQS4GW84r0yD1F67/cnga9OVKE+qDqR3ifiCAPzY=;
 b=DkodyQwxU/dQ4QXVKQXMuom+rtWaPpL/Lb3uqV0kbmJf5+VFq33BP6JXWias8hh2wQW2
 m2k1o4Dix+tyAomhe57vhzRz5H7UCNJwH6r6pMrcbuOssZDKaU6mFEg28P6tNQefFHXE
 pIoB8dDmXIFincZ6hNviUZXCdC34btAdb5Fux/AFSdtB8jEgEEFOsNd/QcY/BUFD6YnI
 dsPmFFTugbkvyd16mvZ2SivAOz9iucfUTrrHCiZKMZ7vpUqBFgebgrIu3iJjCH6AaTls
 3FN44hzZKP7Zl5Xme4FNUv0oYLR1QqPn0rFuGNZhoVMzbXrOW4ygFImB2C5E5etEnptK yg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qt29frngh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 12:20:39 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34PCKdCW023141
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 12:20:39 GMT
Received: from [10.216.30.6] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 25 May
 2023 05:20:36 -0700
Message-ID: <29a1cd75-4552-8026-c73a-6a4fefd8d2fd@quicinc.com>
Date:   Thu, 25 May 2023 17:50:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2][next] media: venus: hfi_cmds: Use struct_size()
 helper
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
 <fd52d6ddce285474615e4bd96931ab12a0da8199.1684278538.git.gustavoars@kernel.org>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <fd52d6ddce285474615e4bd96931ab12a0da8199.1684278538.git.gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tiMu4AUHYTTlyF8GXSfM3_XSTfi0GIh1
X-Proofpoint-ORIG-GUID: tiMu4AUHYTTlyF8GXSfM3_XSTfi0GIh1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_06,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=615 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305250101
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/17/2023 4:44 AM, Gustavo A. R. Silva wrote:
> Prefer struct_size() over open-coded versions of idiom:
> 
> sizeof(struct-with-flex-array) + sizeof(typeof-flex-array-elements) * count
> 
> where count is the max number of items the flexible array is supposed to
> contain.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

The patch looks good. As stated in previous patch, lets combine this into a
single series.

> ---
>  drivers/media/platform/qcom/venus/hfi_cmds.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
> index 21d1b3c90dc0..3f74d518ad08 100644
> --- a/drivers/media/platform/qcom/venus/hfi_cmds.c
> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
> @@ -209,8 +209,8 @@ int pkt_session_set_buffers(struct hfi_session_set_buffers_pkt *pkt,
>  		}
>  	} else {
>  		pkt->extradata_size = 0;
> -		pkt->shdr.hdr.size = sizeof(*pkt) +
> -			bd->num_buffers * sizeof(u32);
> +		pkt->shdr.hdr.size = struct_size(pkt, buffer_info,
> +						 bd->num_buffers);
>  		for (i = 0; i < pkt->num_buffers; i++)
>  			pkt->buffer_info[i] = bd->device_addr;
>  	}
> @@ -251,8 +251,8 @@ int pkt_session_unset_buffers(struct hfi_session_release_buffer_pkt *pkt,
>  
>  		pkt->extradata_size = 0;
>  		pkt->shdr.hdr.size =
> -				sizeof(struct hfi_session_set_buffers_pkt) +
> -				bd->num_buffers * sizeof(u32);
> +			struct_size((struct hfi_session_set_buffers_pkt *)0,
> +				    buffer_info, bd->num_buffers);
>  	}
>  
>  	pkt->response_req = bd->response_required;
