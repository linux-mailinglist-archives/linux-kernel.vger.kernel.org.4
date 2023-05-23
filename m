Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312F770DCC0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbjEWMka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjEWMk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:40:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF42109
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 05:40:24 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NCHSYa025380;
        Tue, 23 May 2023 12:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=bG7oMYZ82OM8p150pGvX8d/7w2k0OueQcAlpuvHqcB8=;
 b=UOsB4E2DyGuaOo5eteaDfUMQx1uG/j8WE0PF+iQsty8OKe0BoYiBB5KNjymtKx3p7nGR
 ZUeQkZhl/VKzgAxU6wUBqUthYumDmePE2EBmb+NOGwb5liPZoXVhlG1yZgulYPcD/7vq
 iGNmNUAQMy9K9fTYorBeDFNunANxSY10p2/QJw11pyTRaZK2oJrqx+A4i8bUD6DrKSif
 2lSfANNVl5TFmJAONAXrrA7woUPkfjGAGZrzQ4rcEnAsNnLQ+KRAivEmpBdS29mibjp3
 Q0q5dPEycqOsxC84rBtceHTusLqzX1Q7lXM8bSYOs/XY9NCcc3BvYZVy+bviIgSwsjnf eA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qr4wh3ana-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 12:40:14 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34NCeDjm015264
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 12:40:13 GMT
Received: from [10.216.0.254] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 23 May
 2023 05:40:10 -0700
Message-ID: <1dde2e80-c28d-5782-a5fa-c222af1db8bc@quicinc.com>
Date:   Tue, 23 May 2023 18:10:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] watchdog: set variables
 watchdog_soft,hardlockup_user_enabled storage-class-specifier to static
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, <akpm@linux-foundation.org>,
        <dianders@chromium.org>, <pmladek@suse.com>,
        <kernelfans@gmail.com>, <lecopzer.chen@mediatek.com>,
        <ldufour@linux.ibm.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20230523122324.1668396-1-trix@redhat.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230523122324.1668396-1-trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: x3yI_iJKaDWkNZbBeS3oqYAbw0tyQoR-
X-Proofpoint-GUID: x3yI_iJKaDWkNZbBeS3oqYAbw0tyQoR-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_08,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230099
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/2023 5:53 PM, Tom Rix wrote:
> smatch reports
> kernel/watchdog.c:40:19: warning: symbol
>    'watchdog_hardlockup_user_enabled' was not declared. Should it be static?
> kernel/watchdog.c:41:19: warning: symbol
>    'watchdog_softlockup_user_enabled' was not declared. Should it be static?
> 
> These variabled are only used in their defining file, so it should be static.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-- Mukesh

> ---
>   kernel/watchdog.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 877d8670f26e..237990e8d345 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -37,8 +37,8 @@ static DEFINE_MUTEX(watchdog_mutex);
>   
>   unsigned long __read_mostly watchdog_enabled;
>   int __read_mostly watchdog_user_enabled = 1;
> -int __read_mostly watchdog_hardlockup_user_enabled = WATCHDOG_HARDLOCKUP_DEFAULT;
> -int __read_mostly watchdog_softlockup_user_enabled = 1;
> +static int __read_mostly watchdog_hardlockup_user_enabled = WATCHDOG_HARDLOCKUP_DEFAULT;
> +static int __read_mostly watchdog_softlockup_user_enabled = 1;
>   int __read_mostly watchdog_thresh = 10;
>   static int __read_mostly watchdog_hardlockup_available;
>   
