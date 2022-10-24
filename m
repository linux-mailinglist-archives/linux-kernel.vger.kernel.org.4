Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B66460B90C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiJXUAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbiJXT6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:58:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6184227FEA0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:21:12 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OExpHJ009824;
        Mon, 24 Oct 2022 15:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PlcXHkBrxmN97ovQQxSCas24croEt3LEwoazrgeWeDY=;
 b=mz4iM78+ickj1bi8NugmqIbWqGZ3WyVTQNs7cY3NNvcyCuXpAG6FRx1GiJkoAgwZCBtM
 +fxO+lhUFJJpzpuX7100CmHcpn0ROp1NAREgRUP0KuwlzLVZdtxqcbRkdqztPdNDZysT
 gBw1s2c6g9J5O+s/lDQnt6NtvGbuz8A/mhklALp8su0w6iIkNlhApgOxXWr/2gMzmdpV
 I/h8a6MBlVUHDoUB5JNXeiMt60Be3c9h4pTuqsZ8Z0M+sMUpHNeAQeONUrvtGmDoocBt
 AAHz/VyQ7W9k2n4il/8Rhm4Va+KHY4S7tD++hLMWBv2Oj/remP3gCZL5jHm3hcWde+6o +g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kc7utbth1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 15:01:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29OF1aox006308
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 15:01:36 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 24 Oct
 2022 08:01:34 -0700
Message-ID: <99e661b4-938f-c26a-07e9-0dcf03e9b27a@quicinc.com>
Date:   Mon, 24 Oct 2022 09:01:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [RFC PATCH 1/3] drivers/accel: add new kconfig and update
 MAINTAINERS
Content-Language: en-US
To:     Oded Gabbay <ogabbay@kernel.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>
CC:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
References: <20221022214622.18042-1-ogabbay@kernel.org>
 <20221022214622.18042-2-ogabbay@kernel.org>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20221022214622.18042-2-ogabbay@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: noR2Z3tU4-_4Xl8UI7eVfw6pbH_LOgvH
X-Proofpoint-GUID: noR2Z3tU4-_4Xl8UI7eVfw6pbH_LOgvH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240091
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/2022 3:46 PM, Oded Gabbay wrote:
> Add a new Kconfig for the accel subsystem. The Kconfig currently
> contains only the basic CONFIG_ACCEL option that will be used to
> decide whether to compile the accel registration code as part of the
> drm core functionality.
> 
> I have taken the liberty to appropriate the dri-devel mailing list and
> the dri-devel IRC channel for the accel subsystem.
> 
> Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
> ---
>   MAINTAINERS           |  8 ++++++++
>   drivers/Kconfig       |  2 ++
>   drivers/accel/Kconfig | 24 ++++++++++++++++++++++++
>   3 files changed, 34 insertions(+)
>   create mode 100644 drivers/accel/Kconfig
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cf0f18502372..790d472801d5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6820,6 +6820,14 @@ F:	include/drm/drm*
>   F:	include/linux/vga*
>   F:	include/uapi/drm/drm*
>   
> +DRM COMPUTE ACCELERATORS DRIVERS AND FRAMEWORK
> +M:	Oded Gabbay <ogabbay@kernel.org>
> +L:	dri-devel@lists.freedesktop.org
> +S:	Maintained
> +C:	irc://irc.oftc.net/dri-devel
> +T:	git https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/accel.git
> +F:	drivers/accel/

I'm willing to assist with reviews, etc.  While I appreciate your 
efforts to drive this, you shouldn't be taking on everything going 
forward. Feel free to add me (or don't) to this entry as you see fit.
