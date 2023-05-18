Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAD7707B56
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 09:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjERHr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 03:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjERHry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 03:47:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69F42690;
        Thu, 18 May 2023 00:47:52 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I7Klao006364;
        Thu, 18 May 2023 07:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0rnd9wlqpv8lZd9eNQMBYgfQQDwq/ErFAT8Dgq3EFkg=;
 b=NlLiP4v3nlKCAV93Usi5tD+wChuLf4PWBjOQUYlLmyGtkezVbZu/FpHJXXqm3hSb+nEd
 BUDBHbFa1UbwiwgGhXT9YqEkwjt0hUC8Rj7NzGdF2E7nz55SphQaquGyzh1HUYDYLDQL
 8PkWgzzMa8Hppr8854aKzIGjo+qk6bNG+jGK9KO4auwjYCxpqiXnru6G/8ECDYHNX6Va
 xDPE4dVSfUBfLp4mhppU6TQPd6QuXbZB+yMs/lDkzSK4aM6AXcgZn4MB4e+O6hLCzF8E
 4VbbkWjT6x3MpNcamhCTPvpVelKarx9U45msVq3+g3X0Gwg0Yto5iiNe3Wtqavgidz4Z xQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qn8a60qtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 07:47:46 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34I7lj0x025342
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 07:47:45 GMT
Received: from [10.216.40.42] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 18 May
 2023 00:47:41 -0700
Message-ID: <c503c773-137c-0d76-9762-7ea6d3ee868c@quicinc.com>
Date:   Thu, 18 May 2023 13:17:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] remoteproc: qcom: pas: mark adsp_segment_dump() static
To:     Arnd Bergmann <arnd@kernel.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        "Yogesh Lal" <quic_ylal@quicinc.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230516202332.560123-1-arnd@kernel.org>
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230516202332.560123-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IMxnHTjoLvy3pepom3P7UCNuwnAoOiFf
X-Proofpoint-ORIG-GUID: IMxnHTjoLvy3pepom3P7UCNuwnAoOiFf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_05,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 clxscore=1011 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305180059
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/2023 1:53 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The function has no other callers and should not be globally defined.
> Making it static avoids this warning:
> 
> drivers/remoteproc/qcom_q6v5_pas.c:108:6: error: no previous prototype for 'adsp_segment_dump'
> 
> Fixes: a376c10d45a8 ("remoteproc: qcom: pas: Adjust the phys addr wrt the mem region")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This seems to be posted already

https://lore.kernel.org/lkml/20230507144826.193067-1-krzysztof.kozlowski@linaro.org/

-- Mukesh

> ---
>   drivers/remoteproc/qcom_q6v5_pas.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index e34d82b18a67..a1d69721a0e7 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -105,8 +105,9 @@ struct qcom_adsp {
>   	struct qcom_scm_pas_metadata dtb_pas_metadata;
>   };
>   
> -void adsp_segment_dump(struct rproc *rproc, struct rproc_dump_segment *segment,
> -		       void *dest, size_t offset, size_t size)
> +static void adsp_segment_dump(struct rproc *rproc,
> +			      struct rproc_dump_segment *segment,
> +			      void *dest, size_t offset, size_t size)
>   {
>   	struct qcom_adsp *adsp = rproc->priv;
>   	int total_offset;
