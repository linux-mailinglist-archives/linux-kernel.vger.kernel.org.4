Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40E2670F8F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjARBIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjARBHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:07:18 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3293C24;
        Tue, 17 Jan 2023 17:01:07 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HNt2IQ003851;
        Wed, 18 Jan 2023 01:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BSHaOYw0kWSC5JTjpxcMKCWS430xiqp9tvd4qGTkfYE=;
 b=bUqyrgyptUZiXqOE4RET/JdJzHIAS+Qvube6lr8VxtUgaIDbX0NUDWvbDUKz7HUKegKh
 lUes4btsjr4x7qr8d1gdpkaEt2tyELjziRUarQKwsi+VAGvnCvU/wCJiq/IYegbN2D0T
 UqrMY3UhoYtF1gDQhOtVi+oqiw0s5HBZHa9gTeg7eKa8Ghjf9T/TdKy6b7hZ+xfbEUT8
 /6CE0GTUq56HaFd78+3ApbR3ArWcPG56/aSHC2Mr5+LmysTy0cWrk+v0FD1M/dW78Pzv
 UXmdcpcphm7KuxoQw+/zhKMujwrP/0v8yVUsrJBBA5+1LMQYsMTBArngLqYyDlrOoiOg pQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n5b18av4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 01:01:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30I113KO003926
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 01:01:03 GMT
Received: from [192.168.142.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 17 Jan
 2023 17:01:02 -0800
Subject: Re: [PATCH] rpmsg: glink: Release driver_override
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:REMOTE PROCESSOR MESSAGING (RPMSG) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230109223818.1706292-1-quic_bjorande@quicinc.com>
From:   Chris Lew <quic_clew@quicinc.com>
Message-ID: <dc0e1609-a872-08e7-2801-0ece573181ad@quicinc.com>
Date:   Tue, 17 Jan 2023 17:01:01 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230109223818.1706292-1-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AweWf2Q1Rb6VlTKUwyoEM91j9iiZSrGA
X-Proofpoint-ORIG-GUID: AweWf2Q1Rb6VlTKUwyoEM91j9iiZSrGA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_11,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301180005
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/2023 2:38 PM, Bjorn Andersson wrote:
> Upon termination of the rpmsg_device, driver_override needs to be freed
> to avoid leaking the potentially assigned string.
> 
> Fixes: 42cd402b8fd4 ("rpmsg: Fix kfree() of static memory on setting driver_override")
> Fixes: 39e47767ec9b ("rpmsg: Add driver_override device attribute for rpmsg_device")
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>   drivers/rpmsg/qcom_glink_native.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index 8620eea1dc8a..046271e439c5 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -1454,6 +1454,7 @@ static void qcom_glink_rpdev_release(struct device *dev)
>   {
>   	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
>   
> +	kfree(rpdev->driver_override);

I see in Krzysztof's original patch to fix up the driver_override we do 
kfree in other areas of rpmsg.

More of a just curious as to why don't we use the driver_set_override 
function to clear the string? It's mentioned in the rpmsg header that 
the helper should be used.

--- include/linux/rpmsg.h
  * @driver_override: driver name to force a match; do not set directly,
  *                   because core frees it; use driver_set_override() to
  *                   set or clear it.

>   	kfree(rpdev);
>   }
>   
> @@ -1697,6 +1698,7 @@ static void qcom_glink_device_release(struct device *dev)
>   
>   	/* Release qcom_glink_alloc_channel() reference */
>   	kref_put(&channel->refcount, qcom_glink_channel_release);
> +	kfree(rpdev->driver_override);
>   	kfree(rpdev);
>   }
>   
> 
