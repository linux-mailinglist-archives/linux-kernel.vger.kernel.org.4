Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69C969A586
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 07:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjBQGLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 01:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBQGLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 01:11:43 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B670759714;
        Thu, 16 Feb 2023 22:11:42 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H5rcJq029216;
        Fri, 17 Feb 2023 06:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ugG6GOg7970Ju4+uu5sDfNaptVOYwt+MYMLuv6OGjC8=;
 b=Fib5TAbui7zStb6/MVvuL3r4Pz5QMeTMPEvSJMvJwy1AnBtmfOl1dk1IAUCVjujno5Cw
 COCoBXqEhySyL0DBUpsloExhtvlvL3WrmgQQr+fAQaTcolRCTfhejgj6wGbC4C4AqRQk
 05CspkfOQyk9vWY+FC0QcNGAhUJPH8gRMARXdpxe67NigEze1GshV7/TYpzQtc04gJ/L
 70dlbQwv+QvZlY9MRwPrcXS/4P9widIAZJhorIGxm++sHBlD585rF31mouRcz5rC/GFJ
 6PDO/9YKG/OVGR9SG7IS8nyLQvm8tHcNjKMEKq7PkKpaB79ICHqhBiq/cuxgowLmVtAm Og== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nswjpgwvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 06:11:20 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31H6BJVF027948
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 06:11:19 GMT
Received: from [10.239.155.136] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 16 Feb
 2023 22:11:15 -0800
Message-ID: <257dd9ff-26d3-72fb-729f-f0a04ff5f265@quicinc.com>
Date:   Fri, 17 Feb 2023 14:11:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1] scsi: ufs: core: Add trace event for MCQ
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, <quic_asutoshd@quicinc.com>,
        <quic_cang@quicinc.com>, <mani@kernel.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>
References: <1676515562-55805-1-git-send-email-quic_ziqichen@quicinc.com>
 <e318febd-8731-3289-e168-d566db82a5b2@acm.org>
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
In-Reply-To: <e318febd-8731-3289-e168-d566db82a5b2@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8NxYwFKtQkxLrNMcp4gs23AYk8vH7kEM
X-Proofpoint-ORIG-GUID: 8NxYwFKtQkxLrNMcp4gs23AYk8vH7kEM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_02,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170054
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/17/2023 1:44 AM, Bart Van Assche wrote:
> On 2/15/23 18:45, Ziqi Chen wrote:
>> diff --git a/include/trace/events/ufs.h b/include/trace/events/ufs.h
>> index 599739e..a406404e 100644
>> --- a/include/trace/events/ufs.h
>> +++ b/include/trace/events/ufs.h
>> @@ -10,6 +10,7 @@
>>   #define _TRACE_UFS_H
>>     #include <linux/tracepoint.h>
>> +#include <ufs/ufshcd.h>
>
> Would including <ufs/ufs.h> here be sufficient?
Hi Bart.

The struct ufs_hw_queue which be used by this change not be defined in 
ufs.h.

Best Regards,

Ziqi

>
> Thanks,
>
> Bart.
>
