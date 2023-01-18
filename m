Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D72670F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjARAxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjARAxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:53:13 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD653669E;
        Tue, 17 Jan 2023 16:41:48 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30I0MERL018012;
        Wed, 18 Jan 2023 00:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5MQzEZd4AeVhh3IUiPUmYg+RWHINIh1L+xW2wnfXCvc=;
 b=nuizibQ9tAfzZtQSfO9gjkK7eCCRv9FbEyh4d5fINoVnenLYexQOjfXecAy11ZE0jh6x
 n4ikjso5oGQ2EkwrvLHzvgoFUWIn/7iRdOjSsQmgIPDFpz17VVLBt2HPExu8nh5JvLQT
 0TuL1cl6qMA3h6oBNNIVSbme39gOq5q7cy8F6VWVNAfvMNd/GiKBkY2NSkNUph2fuJXd
 6W+2zeFIDC6QXAEA4u1tMxDs8v57q4z1g+KAMicoTKINL4FNI95vrNg8mIbWGANMh4L9
 dy4bKQ5g9pryI367L0MevW5Nc2IU1lXtTbPcva9tMwHQJU2elGXpY+ropqnhjPULaeaG eg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n3mm9xqnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 00:41:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30I0fjnR001310
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 00:41:45 GMT
Received: from [192.168.142.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 17 Jan
 2023 16:41:44 -0800
Subject: Re: [PATCH] rpmsg: glink: Include types in qcom_glink_native.h
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230109223745.1706152-1-quic_bjorande@quicinc.com>
From:   Chris Lew <quic_clew@quicinc.com>
Message-ID: <71789b4c-016d-835d-8b1e-3b962918eefc@quicinc.com>
Date:   Tue, 17 Jan 2023 16:41:23 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230109223745.1706152-1-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wwpOKSGOq4syHLVA27oW3sa0SXzCLuu_
X-Proofpoint-ORIG-GUID: wwpOKSGOq4syHLVA27oW3sa0SXzCLuu_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_11,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301180001
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/2023 2:37 PM, Bjorn Andersson wrote:
> Ensure that the used data types are available in qcom_glink_native.h, to
> silence LSP warnings.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Chris Lew <quic_clew@quicinc.com>

> ---
>   drivers/rpmsg/qcom_glink_native.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/rpmsg/qcom_glink_native.h b/drivers/rpmsg/qcom_glink_native.h
> index 624184fc458e..e9a8671616c7 100644
> --- a/drivers/rpmsg/qcom_glink_native.h
> +++ b/drivers/rpmsg/qcom_glink_native.h
> @@ -6,6 +6,8 @@
>   #ifndef __QCOM_GLINK_NATIVE_H__
>   #define __QCOM_GLINK_NATIVE_H__
>   
> +#include <linux/types.h>
> +
>   #define GLINK_FEATURE_INTENT_REUSE	BIT(0)
>   #define GLINK_FEATURE_MIGRATION		BIT(1)
>   #define GLINK_FEATURE_TRACER_PKT	BIT(2)
> @@ -24,6 +26,7 @@ struct qcom_glink_pipe {
>   		      const void *data, size_t dlen);
>   };
>   
> +struct device;
>   struct qcom_glink;
>   
>   struct qcom_glink *qcom_glink_native_probe(struct device *dev,
> 
