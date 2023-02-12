Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2873B693852
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 17:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBLQLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 11:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBLQLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 11:11:23 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C92DE057;
        Sun, 12 Feb 2023 08:11:21 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31CFuDg2013216;
        Sun, 12 Feb 2023 16:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kNfy5wQpkTtMURp5286Q1lemGeJhipGcema3XxTJtTM=;
 b=SdTH73ESKze4zGF28B1YpZVicy6PJ3NIgPySNZmz8rourvujkOzBpRuIJAj9WMtEkLcf
 ZmSlCbKFHmU1U4y/NlpME/HXzDHnXHDTZ8M0qfr9LIumpRJYx+77fIIbZU0rWd+jP2S9
 KnqebHl9N/cwKvpQapbA2XPCCdjBjQJLW2n140D/mSZ10pQRcL/UsnYLfVSgEV3xIB5J
 Ynovg5mRcG6YHcNp8uv5qodOcUc3hrvW8vHcmF+d9R0cF1Ni7di92LhPqyG6HAla+NrA
 tuIfNvzvD8CAJsbjuSdY4YnUejyvKZBt1xsMCYe7FMF8PSchBHD+53tPgfVNEQOSs6uZ 4w== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np21ftc9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Feb 2023 16:11:11 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31CGBA0e017390
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Feb 2023 16:11:10 GMT
Received: from [10.216.50.155] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 12 Feb
 2023 08:11:07 -0800
Message-ID: <73474906-8376-9328-16c2-370a87477c6a@quicinc.com>
Date:   Sun, 12 Feb 2023 21:41:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] remoteproc: qcom: fix sparse warnings
Content-Language: en-US
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>, <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1675180866-16695-1-git-send-email-quic_mojha@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1675180866-16695-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WQXkNJfG5GrisyZVmNMJZfMHAJahg4WG
X-Proofpoint-ORIG-GUID: WQXkNJfG5GrisyZVmNMJZfMHAJahg4WG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-12_06,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 adultscore=0 spamscore=0 mlxlogscore=831 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302120145
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly reminder.

-Mukesh

On 1/31/2023 9:31 PM, Mukesh Ojha wrote:
> This patch try to address below sparse warnings.
> 
> drivers/remoteproc/qcom_common.c:126:27: warning: restricted __le32 degrades to integer
> drivers/remoteproc/qcom_common.c:133:32: warning: cast to restricted __le32
> drivers/remoteproc/qcom_common.c:133:32: warning: cast from restricted __le64
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>   drivers/remoteproc/qcom_common.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
> index 020349f..7133c1f 100644
> --- a/drivers/remoteproc/qcom_common.c
> +++ b/drivers/remoteproc/qcom_common.c
> @@ -123,14 +123,14 @@ static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsy
>   
>   	for (i = 0; i < seg_cnt; i++) {
>   		memcpy_fromio(&region, ptr + i, sizeof(region));
> -		if (region.valid == MD_REGION_VALID) {
> +		if (le32_to_cpu(region.valid) == MD_REGION_VALID) {
>   			name = kstrdup(region.name, GFP_KERNEL);
>   			if (!name) {
>   				iounmap(ptr);
>   				return -ENOMEM;
>   			}
>   			da = le64_to_cpu(region.address);
> -			size = le32_to_cpu(region.size);
> +			size = le64_to_cpu(region.size);
>   			rproc_coredump_add_custom_segment(rproc, da, size, NULL, name);
>   		}
>   	}
