Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930EA6BCCEB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjCPKf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjCPKfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:35:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C7C9E509;
        Thu, 16 Mar 2023 03:35:15 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32G9SMHq028719;
        Thu, 16 Mar 2023 10:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=W3Tlrftt0yAjUTBVCg7DwbudT+xfc9oUHrxvoR5zQ2w=;
 b=UB6ahDQjPQZDktFQT1PQ03snbgk5BXlzSbKkCss61cA/J8iO7okE1bbcph0/jLI06QFe
 VTIS58hEiLpWT8KvPOKbauJuDsgG5Mb25VCgYQrdlEwsldyVW8YeZdWrA7t9XDMT2n62
 TYndC58G1QbHvAYEp33uDscq1fPupqOPwXjoo1hYsycT6t4hZ3UiDdphIultGKP4qL9F
 eVtaeUUK7IcrlgZBBxtm2MPxfwG5gR915nxMTXhrbnEq5Ly+tw3SsA7RUyCavpmNvROA
 u0ucqg4LyOZ9DIytGSbk7PKd1jmE+Qduzl8V1F71N9u5Lci+7InNZ1yWTHeqQXgoS1d0 Sw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pbpxshh7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 10:35:08 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32GAZ7QI026155
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 10:35:07 GMT
Received: from [10.216.13.67] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 16 Mar
 2023 03:35:03 -0700
Message-ID: <2c5f63ac-470e-51fa-4330-c9603eb9efcf@quicinc.com>
Date:   Thu, 16 Mar 2023 16:04:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] remoteproc: qcom_q6v5_mss: remove unnecessary (void*)
 conversions
Content-Language: en-US
To:     Yu Zhe <yuzhe@nfschina.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mathieu.poirier@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <liqiong@nfschina.com>
References: <20230316091902.20765-1-yuzhe@nfschina.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230316091902.20765-1-yuzhe@nfschina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KPrmjP2TBcREIWEb-VgZzDwYGavEJur4
X-Proofpoint-ORIG-GUID: KPrmjP2TBcREIWEb-VgZzDwYGavEJur4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_07,2023-03-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303160089
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/2023 2:49 PM, Yu Zhe wrote:
> Pointer variables of void * type do not require type cast.
> 
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> ---
>   drivers/remoteproc/qcom_q6v5_mss.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index ab053084f7a2..e7a67c8c16a0 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -1562,7 +1562,7 @@ static void qcom_q6v5_dump_segment(struct rproc *rproc,
>   
>   static int q6v5_start(struct rproc *rproc)
>   {
> -	struct q6v5 *qproc = (struct q6v5 *)rproc->priv;
> +	struct q6v5 *qproc = rproc->priv;
>   	int xfermemop_ret;
>   	int ret;
>   
> @@ -1604,7 +1604,7 @@ static int q6v5_start(struct rproc *rproc)
>   
>   static int q6v5_stop(struct rproc *rproc)
>   {
> -	struct q6v5 *qproc = (struct q6v5 *)rproc->priv;
> +	struct q6v5 *qproc = rproc->priv;
>   	int ret;
>   
>   	ret = qcom_q6v5_request_stop(&qproc->q6v5, qproc->sysmon);
> @@ -1662,7 +1662,7 @@ static int qcom_q6v5_register_dump_segments(struct rproc *rproc,
>   
>   static unsigned long q6v5_panic(struct rproc *rproc)
>   {
> -	struct q6v5 *qproc = (struct q6v5 *)rproc->priv;
> +	struct q6v5 *qproc = rproc->priv;
>   
>   	return qcom_q6v5_panic(&qproc->q6v5);
>   }
> @@ -1977,7 +1977,7 @@ static int q6v5_probe(struct platform_device *pdev)
>   	rproc->auto_boot = false;
>   	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
>   
> -	qproc = (struct q6v5 *)rproc->priv;
> +	qproc = rproc->priv;
>   	qproc->dev = &pdev->dev;
>   	qproc->rproc = rproc;
>   	qproc->hexagon_mdt_image = "modem.mdt";

Well, there is quite a few files under driver/remoteproc/ which has this 
kind of assignation.

Do you intend to do this for all ?

Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>

-- Mukesh
