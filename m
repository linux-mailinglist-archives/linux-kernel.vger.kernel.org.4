Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4D76BC9B8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjCPIsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCPIsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:48:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDD92CFEA;
        Thu, 16 Mar 2023 01:47:59 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32G25JGx002378;
        Thu, 16 Mar 2023 08:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OFM1jK7AWk+GpIGI+cgtuL1o87J82wUVsSZC0QhXseA=;
 b=BMR5MqIz06p5RwqpqF5esxpbwh5a1fT6ePnrJerhu1Q6Ot8v6gwAIFo5LtE9J/MO1bra
 wgox1x4dkIpBlCrhQf/nQzfk7PnEYOejDTHouYNLqhGuWrwy7GtMnAs+us+k3sgY7oDl
 S1R+9EOQ9qwz2EB01pLBenSPasYneh6q7jxAkMfEmWQJ7rfIFHL/S1rx+M5c0/WV9Kqh
 Pmv72Fha06A5q3FeBo9ov3laz8GlmpTG6Qf1kckg09DvronaFXFZI1x1ZZmomY2kCRTu
 mR5yf+TbuURJ+PKJNfX3B8IITSKYkDo5OVSF1fn9uU4eNrFOAXlFE56nEEUOolkB3mn3 8w== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pbpy3h82a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 08:47:45 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32G8liLV002408
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 08:47:44 GMT
Received: from [10.216.13.67] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 16 Mar
 2023 01:47:39 -0700
Message-ID: <326b9bac-0e83-336d-ac3f-09656625301c@quicinc.com>
Date:   Thu, 16 Mar 2023 14:17:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH -next] remoteproc/mtk_scp: Fix one kernel-doc comment
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, <andersson@kernel.org>
CC:     <mathieu.poirier@linaro.org>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20230316084011.99613-1-yang.lee@linux.alibaba.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230316084011.99613-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HzU3uBjeUrqkUoaqLOj3OZuPSJwlyCNl
X-Proofpoint-ORIG-GUID: HzU3uBjeUrqkUoaqLOj3OZuPSJwlyCNl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_06,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 mlxlogscore=974 impostorscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303160074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/2023 2:10 PM, Yang Li wrote:
> Fixs the function name in kernel-doc comments to clear the below

nit: Fix

> warning:
> 
> drivers/remoteproc/mtk_scp_ipi.c:136: warning: expecting prototype for scp_ipi_lock(). Prototype was for scp_ipi_unlock() instead
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4544
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   drivers/remoteproc/mtk_scp_ipi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/mtk_scp_ipi.c b/drivers/remoteproc/mtk_scp_ipi.c
> index fc55df649b40..9c7c17b9d181 100644
> --- a/drivers/remoteproc/mtk_scp_ipi.c
> +++ b/drivers/remoteproc/mtk_scp_ipi.c
> @@ -125,7 +125,7 @@ void scp_ipi_lock(struct mtk_scp *scp, u32 id)
>   EXPORT_SYMBOL_GPL(scp_ipi_lock);
>   
>   /**
> - * scp_ipi_lock() - Unlock after operations of an IPI ID
> + * scp_ipi_unlock() - Unlock after operations of an IPI ID
>    *
>    * @scp:	mtk_scp structure
>    * @id:		IPI ID

Otherwise LGTM.

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-- Mukesh
