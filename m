Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7057D700834
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240725AbjELMkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241082AbjELMkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:40:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA3014363;
        Fri, 12 May 2023 05:40:10 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CCdiJn009400;
        Fri, 12 May 2023 12:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PgACuCtI1ti1B/gYlBNib693xDWclHD81/gAYngwhOQ=;
 b=TyHboXe1U2KazKPX5EniL+JaQrJBDQuJrxw9h3RkidC8/yGtXTWN82FKmnRLQd6flTz7
 ivc5/ET7lwo+6GbjWChrqYy46CAIB+WUTd7rZrQxVyZ7T87MYHYwfeFyeqU6+sTdVZns
 xYOnHa2rkSOryUfc/BJbBuHiOUyJUGYVGRG/wHnkJiylrxOvFOH/w4WZfrjLJoYD+g4/
 RcmG85XCqGJ2TEVq5spKenj6XL3CtnLTp1LD/skMRRZUeNhN8Au80ceATA5YBmXqIpZp
 iAbZWWM9TtXaNiOLT1E5hUBIKiNzB7cC8qO3VNeW8ik1WRhtV62p123EGms8Ii8LPwGo vg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qhfww0qsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 12:39:57 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34CCdumr016963
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 12:39:56 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 12 May
 2023 05:39:53 -0700
Message-ID: <50f9263f-eb29-acc8-9fe4-c02480d6dfb6@quicinc.com>
Date:   Fri, 12 May 2023 18:09:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] soc: qcom: Rename ice to qcom_ice to avoid module name
 conflict
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        <manivannan.sadhasivam@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20230512123632.3024857-1-abel.vesa@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230512123632.3024857-1-abel.vesa@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Gs07vwTxq8hrScAZ3OtUhXX6ojUgfDPD
X-Proofpoint-GUID: Gs07vwTxq8hrScAZ3OtUhXX6ojUgfDPD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 clxscore=1011 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120106
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/12/2023 6:06 PM, Abel Vesa wrote:
> The following error was reported when building x86_64 allmodconfig:
> 
> error: the following would cause module name conflict:
>    drivers/soc/qcom/ice.ko
>    drivers/net/ethernet/intel/ice/ice.ko
> 
> Seems the 'ice' module name is already used by some Intel ethernet
> driver, so lets rename the Qualcomm Inline Crypto Engine (ICE) from
> 'ice' to 'qcom_ice' to avoid any kind of errors/confusions.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 2afbf43a4aec ("soc: qcom: Make the Qualcomm UFS/SDCC ICE a dedicated driver")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>

-- Mukesh
> ---
> 
> Changes since v1:
>   * changed filename from qcom-ice.c to qcom_ice.c (with underscore)
>     to be in line with other Qcom SoC drivers.
> 
>   drivers/soc/qcom/Makefile              | 2 +-
>   drivers/soc/qcom/{ice.c => qcom_ice.c} | 0
>   2 files changed, 1 insertion(+), 1 deletion(-)
>   rename drivers/soc/qcom/{ice.c => qcom_ice.c} (100%)
> 
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 0f43a88b4894..cacf3113ec3c 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -32,4 +32,4 @@ obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
>   obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
>   obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
>   obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
> -obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= ice.o
> +obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom_ice.o
> diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/qcom_ice.c
> similarity index 100%
> rename from drivers/soc/qcom/ice.c
> rename to drivers/soc/qcom/qcom_ice.c
