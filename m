Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CAB6AE5E5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjCGQHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjCGQGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:06:43 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB7F2124
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:04:52 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327FwPZX032368;
        Tue, 7 Mar 2023 16:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MndgLlDfvq7xGhJY7rAHmrKVYNjpcE8PYvN0WTzUxn4=;
 b=gtbIQ9Kq4feFeS3WN5wLD3Uu9Bjzq1G9L+Dmm+Nw8OhOlzCrTRFra94TxVSNZptNaA4X
 UEHzTRMVWfUfWNX0EpIT31ojfMHzh9gPvnblZJ/GPV8vgg9or25aIOoXlF4MQSh3Etw7
 ZwSZ3jKqa+0JiEnhUDcgWCbF2QcgTT6jkelhQ7E1ewtQKrJdqXg8rsoM3jb2oBSlXU2G
 R08oNqqJIi3S3xRDkQDvkbpLdZ2gMIIgxUi787iWEjSnWs5TRBt36BaF0H8eh3z5ejiw
 zy5Hh4LWkokCtplzN71XlsG1VP3N66Tv2ynxzqZZFGScJkpID9RilQumVLyXEBWbL1gD fg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p68cqr169-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 16:03:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 327G3ocv007318
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 16:03:50 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Mar 2023
 08:03:49 -0800
Message-ID: <babfe305-04cd-7213-8e1e-8fbcb2da10ae@quicinc.com>
Date:   Tue, 7 Mar 2023 09:03:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] accel: Link to compute accelerator subsystem intro
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:     Oded Gabbay <ogabbay@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Melissa Wen <mwen@igalia.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Airlie <airlied@redhat.com>, Dylan Le <self@dylanle.dev>
References: <20230307043525.25660-1-bagasdotme@gmail.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20230307043525.25660-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 32oURlT5IH4tkNgWpBZIiHdsdButyQB7
X-Proofpoint-GUID: 32oURlT5IH4tkNgWpBZIiHdsdButyQB7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_11,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=314 impostorscore=0
 spamscore=0 clxscore=1011 phishscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070144
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/2023 9:35 PM, Bagas Sanjaya wrote:
> Commit 2c204f3d53218d ("accel: add dedicated minor for accelerator
> devices") adds link to accelerator nodes section of DRM internals doc
> (Documentation/gpu/drm-internals.rst), but the target doesn't exist.
> Instead, there is only an introduction doc for computer accelerator
> subsytem.
> 
> Link to that doc until there is documentation of accelerator internals.
> 
> Fixes: 2c204f3d53218d ("accel: add dedicated minor for accelerator devices")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
