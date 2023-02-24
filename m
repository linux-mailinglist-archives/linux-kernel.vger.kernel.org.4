Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE1B6A2247
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 20:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjBXTTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 14:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjBXTTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 14:19:16 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947F07292;
        Fri, 24 Feb 2023 11:19:14 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OCG7Nc012848;
        Fri, 24 Feb 2023 19:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=IGd2NCh6HKgvvTS62VAjy8ePxKCYXoUvB7NuZI5A0GE=;
 b=ATvOfxjDxHD98IPqKtat4E3PzMdKZgapQVcX+z82M5j2rDz1X8uqeEgh09Wa9ATXk0A8
 QY8Cz0BtVH4gvzoZ85Ai0BxHPmrRQthxeHslneEWjJG0dBA+sqIMSpLGtd5uI5MigglM
 CImrwK6FYcogoUUR29a06SPZFSw64t4/hpY8RP+I/8di00Kz/2OXqPII7FpXNhkD4kAc
 23JsGlXg+KjgpG4mdi6UXo5soo2KyX9MN/6/7K9uzpTyOZ2bkf5ELK5LrLcVuWIqV0hN
 8ifF2gOOOlQBuyta3LYVP+PJbEn7+u34gWSMXZXAA6O00yzN1hpMQSn+W3sFRLMA7x5d RQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nxw3d99un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 19:19:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31OJJ0C0013201
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 19:19:00 GMT
Received: from [10.110.60.51] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 24 Feb
 2023 11:18:59 -0800
Message-ID: <51ad9ff8-dbfa-7476-b208-f47e8d54fc20@quicinc.com>
Date:   Fri, 24 Feb 2023 11:18:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 0/2] add V1.1 dsc_helper fucntion
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <andersson@kernel.org>
CC:     <quic_abhinavk@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1677265287-7765-1-git-send-email-quic_khsieh@quicinc.com>
Content-Language: en-US
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <1677265287-7765-1-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: w2BbetFI0CNeq-dLZXoGAtiz-rCjfXKI
X-Proofpoint-ORIG-GUID: w2BbetFI0CNeq-dLZXoGAtiz-rCjfXKI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_14,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=886 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240153
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this series

I am going to re post it as RFC.


kuogee

On 2/24/2023 11:01 AM, Kuogee Hsieh wrote:
> Add V1.1 dsc function and have dsi use it instead of hardcode value
>
> Kuogee Hsieh (2):
>    drm/msm/dpu: add dsc helper functions
>    drm/msm/dsi: use new dpu_dsc_populate_dsc_config()
>
>   drivers/gpu/drm/msm/Makefile                   |   1 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.c | 209 +++++++++++++++++++++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.h |  28 ++++
>   drivers/gpu/drm/msm/dsi/dsi_host.c             |  78 ++-------
>   drivers/gpu/drm/msm/msm_drv.h                  |   7 +
>   5 files changed, 257 insertions(+), 66 deletions(-)
>   create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.c
>   create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.h
>
