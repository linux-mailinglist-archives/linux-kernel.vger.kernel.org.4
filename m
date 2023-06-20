Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D46A7376DE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 23:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjFTV5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 17:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFTV5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 17:57:50 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FDC107;
        Tue, 20 Jun 2023 14:57:49 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KLvMo5004932;
        Tue, 20 Jun 2023 21:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=19TJ2pJemAtAw7vnSuSEyq+CEd+TRYUzI0XXaVONu3c=;
 b=J8VpndoeW6mOiNe9WhmKjn9euyTSmvWwvWq1XoT3KajYxM2xzgCbcT3fLqYi9LL1newo
 FxXSnfSIFPg97gPplQcLdNDQ7WR11ChA2LgPipE4RkUpW/ikO/sw1Ab3aqpxPnEi2nRI
 0ne4qbsnslRwc45SmWcRfywoztyb7/sEqRfv/5hihsPYvF+yjij7ubcBAeUFXPIUBDrK
 dXzkOdK4erT7KiJnuTH3Wzs9CsPdZD3rR/owxUi7v2vPBxnJ8BYpIjzSqNgpFmPa9l5x
 tjHRZcfE7sCMho+kSU7XoDhX0CEGgdlaJOqk6VY6Gz3xRTWRDWMxM2QwwS0NTU3T/mIK Mw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rb8f6hv7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 21:57:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35KLvikK017749
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 21:57:44 GMT
Received: from [10.111.161.191] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 20 Jun
 2023 14:57:43 -0700
Message-ID: <37dcbd3c-1e41-023c-8bbd-19cf9c9f151b@quicinc.com>
Date:   Tue, 20 Jun 2023 14:57:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH RESEND v2] interconnect: drop unused icc_get() interface
To:     Johan Hovold <johan+linaro@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Odelu Kukatla <quic_okukatla@quicinc.com>
References: <20230523095248.25211-1-johan+linaro@kernel.org>
Content-Language: en-US
From:   Mike Tipton <quic_mdtipton@quicinc.com>
In-Reply-To: <20230523095248.25211-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c6bC6S3MzGJ0YvHkFxWGjUPqzwGhnWS-
X-Proofpoint-ORIG-GUID: c6bC6S3MzGJ0YvHkFxWGjUPqzwGhnWS-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_16,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxlogscore=626 mlxscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1011 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200198
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/2023 2:52 AM, Johan Hovold wrote:
> The icc_get() interface can be used to lookup an interconnect path based
> on global node ids. There has never been any users of this interface and
> all lookups are currently done from the devicetree.
> 
> Remove the unused icc_get() interface.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> 
> Hi Georgi,
> 
> I just noticed that this patch never made it into 6.4 along with the
> rest of the series:
> 
> 	https://lore.kernel.org/lkml/20230306075651.2449-23-johan+linaro@kernel.org/
> 
> This interface is still unused in mainline and should be removed so
> resending the patch again.
> 
> Johan
> 
> 
>   drivers/interconnect/core.c  | 52 ++----------------------------------
>   include/linux/interconnect.h |  8 ------
>   2 files changed, 2 insertions(+), 58 deletions(-)
> 

We have downstream debug/test modules that removing icc_get() will 
break. I'd like to get equivalent debug support in mainline, but until 
then I'd prefer we not remove this.

Our debug module adds debugfs files for requesting a path and voting BW 
to it. The path is defined by supplying the raw src_id / dst_id and 
calling icc_get() for them. This allows us to issue any request to any 
path from debugfs without needing to recompile or reflash devicetree. We 
use this extensively.

That said, I don't like the current implementation of icc_get(). It 
should take strings for src/dst rather than integer IDs. This would be 
similar to other interfaces like clk_get() and regulator_get(). And 
would allow users to specify their path in debugfs using logical names 
rather than raw integers.

I suspect having a mainline approach for voting paths from debugfs would 
be useful to others as well. There are similar debugfs control 
mechanisms in other frameworks already, e.g. clock.

Instead of removing icc_get() immediately, can we wait for a future 
patch series that adds debugfs as a consumer?
