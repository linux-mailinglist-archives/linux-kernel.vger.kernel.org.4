Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E1F62F1AE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241913AbiKRJqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241826AbiKRJpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:45:50 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73508FB09;
        Fri, 18 Nov 2022 01:45:17 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AI85SGH018382;
        Fri, 18 Nov 2022 09:44:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qJcgPrWmyUGAvxfDNNVSIhf4sBSL9JlTHQDB5bAYbXc=;
 b=DUjD6nqbUs4zs+b93QMpvfaMOpNqn4pTNWqQ0rveSDbgLecmRc280DdgT7aPdC8RtKEW
 BNqorR26FudNIVaqQj3OWvIoNFd51kV70GblZJMvRrjC8+0GV4x6E+CuZemWYXDsq1Oq
 gAhivChUenrqa3GMB9v70OYOJU76g5UoMBzcIRwlmAGc6pH37gYLSsKGV3xpkEaQ9nEg
 C87sYqjI1flaan6LnFiZyx30XY0z8egEVg7KbrCkeOHLUFzBToCWHigaytC83Bopqg/T
 uHjxeSY/tpWPvDC8wGKUvgjc5X3N0zx+/yqxM/q8k7tXBM52FeOYAk6KgT6EBr4JmWlj GQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kx0se97wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 09:44:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AI9ieq8021646
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 09:44:40 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 18 Nov
 2022 01:44:36 -0800
Message-ID: <4b190ca0-5a0b-d937-0a08-0ffe34a75ff8@quicinc.com>
Date:   Fri, 18 Nov 2022 15:14:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] remoteproc: qcom_q6v5_pas: disable wakeup on probe
 fail or remove
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        <linux-arm-msm@vger.kernel.org>
CC:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221118090816.100012-1-luca.weiss@fairphone.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20221118090816.100012-1-luca.weiss@fairphone.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rWDUaxdhaHhSnB_4Kf-2LGj_4mM-FOTz
X-Proofpoint-ORIG-GUID: rWDUaxdhaHhSnB_4Kf-2LGj_4mM-FOTz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211180058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/18/22 14:38, Luca Weiss wrote:
> Leaving wakeup enabled during probe fail (-EPROBE_DEFER) or remove makes
> the subsequent probe fail.
> 
> [    3.749454] remoteproc remoteproc0: releasing 3000000.remoteproc
> [    3.752949] qcom_q6v5_pas: probe of 3000000.remoteproc failed with error -17
> [    3.878935] remoteproc remoteproc0: releasing 4080000.remoteproc
> [    3.887602] qcom_q6v5_pas: probe of 4080000.remoteproc failed with error -17
> [    4.319552] remoteproc remoteproc0: releasing 8300000.remoteproc
> [    4.332716] qcom_q6v5_pas: probe of 8300000.remoteproc failed with error -17
> 
> Fix this by disabling wakeup in both cases so the driver can properly
> probe on the next try.
> 
> Fixes: a781e5aa5911 ("remoteproc: core: Prevent system suspend during remoteproc recovery")
> Fixes: dc86c129b4fb ("remoteproc: qcom: pas: Mark devices as wakeup capable")
> Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>

> ---
> Changes in v2:
> * move new line before rproc_free which frees 'adsp' as well
> * pick up tags
> 
>   drivers/remoteproc/qcom_q6v5_pas.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 6afd0941e552..67f5152e2398 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -556,6 +556,7 @@ static int adsp_probe(struct platform_device *pdev)
>   detach_proxy_pds:
>   	adsp_pds_detach(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
>   free_rproc:
> +	device_init_wakeup(adsp->dev, false);
>   	rproc_free(rproc);
>   
>   	return ret;
> @@ -572,6 +573,7 @@ static int adsp_remove(struct platform_device *pdev)
>   	qcom_remove_sysmon_subdev(adsp->sysmon);
>   	qcom_remove_smd_subdev(adsp->rproc, &adsp->smd_subdev);
>   	qcom_remove_ssr_subdev(adsp->rproc, &adsp->ssr_subdev);
> +	device_init_wakeup(adsp->dev, false);
>   	rproc_free(adsp->rproc);
>   
>   	return 0;
