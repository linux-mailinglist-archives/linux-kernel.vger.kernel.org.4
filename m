Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B8862D838
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239692AbiKQKhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbiKQKhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:37:38 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983082FA;
        Thu, 17 Nov 2022 02:37:27 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AH9t0W2030509;
        Thu, 17 Nov 2022 10:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=A0kF2mv33zYz6as8P1ezwNp86SeA4WHr/I52tJT3BwU=;
 b=krofyBLgh+UMvPKmcZPHpaoAOu0stSYhdgh2RTIzjdrViru9y4JpQJSKOwZ25Vffp7cB
 LO9SX77TocrCyTHeI1Y3Cjy7N1OVLWHRPoq2+eBUKIn/Xnc2DdIbL/qOvCioSIgokfR6
 Ug7ObK2RB5pFChv1/9K5ADQ65paqmN5LErHRcZEHHj179Tbyrg9L5xRufYNKiqO+DRiS
 +ON3peGluRcera4IGPqwIvlou/uJuziZ1N8uL03SirVIVhZHU/q7Hs5cao6LliKbdIUO
 4PbHHafWNtcMfb/xkJoNDKpmgTt/rHIlt1Za/fHV9t3hM2ETIGx2b91zcHjlezoBw3HL Jw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kwg4sgmqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 10:36:51 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AHAanMi012167
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 10:36:50 GMT
Received: from [10.216.23.254] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 17 Nov
 2022 02:36:43 -0800
Message-ID: <18a2179d-11d1-33e2-a9e3-7aba36d9308e@quicinc.com>
Date:   Thu, 17 Nov 2022 16:06:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/2] remoteproc: qcom_q6v5_pas: disable wakeup on probe
 fail or remove
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        <linux-arm-msm@vger.kernel.org>
CC:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221111115414.153961-1-luca.weiss@fairphone.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20221111115414.153961-1-luca.weiss@fairphone.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0Tazmw7BWzvuaEqAfbDyZ-TESmTzLSij
X-Proofpoint-ORIG-GUID: 0Tazmw7BWzvuaEqAfbDyZ-TESmTzLSij
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/11/2022 5:24 PM, Luca Weiss wrote:
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
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

LGTM.
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
> ---
>   drivers/remoteproc/qcom_q6v5_pas.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 6afd0941e552..d830bf13c32c 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -557,6 +557,7 @@ static int adsp_probe(struct platform_device *pdev)
>   	adsp_pds_detach(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
>   free_rproc:
>   	rproc_free(rproc);
> +	device_init_wakeup(adsp->dev, false);
>   
>   	return ret;
>   }
> @@ -573,6 +574,7 @@ static int adsp_remove(struct platform_device *pdev)
>   	qcom_remove_smd_subdev(adsp->rproc, &adsp->smd_subdev);
>   	qcom_remove_ssr_subdev(adsp->rproc, &adsp->ssr_subdev);
>   	rproc_free(adsp->rproc);
> +	device_init_wakeup(adsp->dev, false);
>   
>   	return 0;
>   }
