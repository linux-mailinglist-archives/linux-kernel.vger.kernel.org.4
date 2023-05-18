Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20777080B6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 14:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjERMHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 08:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjERMHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 08:07:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996C511B;
        Thu, 18 May 2023 05:07:05 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IApF94003742;
        Thu, 18 May 2023 11:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9jPW0COVTa103eUbXMzw7PqESOOYzL9eKgtYnkkfys8=;
 b=Kb/ezHsWGTfrFtE1X4FINXOwNCQp9uwS6pF4FyRkykbnXLwyjW82NaawwsBG3k7z/q4H
 Pf2c1jUI3FkUjaYV3EvjVrbju+v4KLnOkApmPws0LQnuEVgT8VNi3de2dfIrkMwhS/OP
 x6634/72RNrjLpNkQPAs2LG4wK3mDxW7Rsm7KHBawZnAIklgbbUTahu9mEohAJ0WzCuh
 NAiQsRuwduXd/kLSIQJ4sa7jJkOh+HPsHM4WIxwrWpniDeEr4F552IsBbMHZnciHYu/Z
 U++PLDV0U2nUA5yffu6Ce7uKMpxkxJFgOcCtFykRjKA7s6ni/TBow0LTs6N5iWlxTdr1 qA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qn8d2h5yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 11:38:35 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34IBcXe5022571
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 11:38:34 GMT
Received: from [10.216.40.42] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 18 May
 2023 04:38:30 -0700
Message-ID: <d5b250f8-8a8e-6ee0-9cc1-22ae355a69ec@quicinc.com>
Date:   Thu, 18 May 2023 17:08:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] Revert "firmware: qcom_scm: Clear download bit during
 reboot"
Content-Language: en-US
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robimarko@gmail.com>
References: <1684408823-5898-1-git-send-email-quic_mojha@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1684408823-5898-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wYSq3hgazBcfNZjmdMxDZ6HV6RQXcP5e
X-Proofpoint-GUID: wYSq3hgazBcfNZjmdMxDZ6HV6RQXcP5e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_09,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180090
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Robert,

https://lore.kernel.org/linux-arm-msm/76943268-3982-deaf-9736-429dd51e01b0@gmail.com/

Would be good if you can provide your Tested-by ?

--Mukesh

On 5/18/2023 4:50 PM, Mukesh Ojha wrote:
> This reverts commit 781d32d1c970 as it causes regression(reboot
> does not work) for target like IPQ4019 that does not support
> download mode scm calls end to end.
> 
> Fixes: 781d32d1c970 ("firmware: qcom_scm: Clear download bit during reboot")
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>   drivers/firmware/qcom_scm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index fde33acd46b7..a4bb9265d9c0 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -1508,7 +1508,8 @@ static int qcom_scm_probe(struct platform_device *pdev)
>   static void qcom_scm_shutdown(struct platform_device *pdev)
>   {
>   	/* Clean shutdown, disable download mode to allow normal restart */
> -	qcom_scm_set_download_mode(false);
> +	if (download_mode)
> +		qcom_scm_set_download_mode(false);
>   }
>   
>   static const struct of_device_id qcom_scm_dt_match[] = {
