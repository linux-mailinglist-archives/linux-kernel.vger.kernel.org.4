Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B446BB915
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjCOQHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjCOQHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:07:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F6D968C0;
        Wed, 15 Mar 2023 09:07:10 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FAMX5E030774;
        Wed, 15 Mar 2023 15:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=xb5P8YPq/H03NLXOC5oLXz7TjpMuUTiQFudiRNbQavI=;
 b=eQM1yFz78AdasNBt9QQFKjzjKXR7SUqCfx8dbSQA6vVTCvIxm+lr2OE99VYbHmwU86Dv
 JeROSJPxkWY4q9V1FSFj9zlc7ZtuGrQeLfm6+2qTE3amLw6TuTYN2ChVFqHQuOKOxorp
 /kwJOMIwbZ7DE0ig00M7rd3BVDNTTzJFpgqaOT3YRL02dormknWgVD2wn8Lp/wN579j8
 BMD/l+PCGjPBBVfoYwVS9vjZAH+HcR1ds3O19pdev/6u3w3ESFqAMCo2tN9v17//cxKF
 pnzit3PRfR3K/tmWmpItEceatKjQtRobdU+6oBsBH2h1dLL+ANFG4LkgpuLo2KSYsRYr dQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pb2ck2558-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 15:53:59 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32FFrwha029836
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 15:53:58 GMT
Received: from [10.216.36.238] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Mar
 2023 08:53:55 -0700
Message-ID: <1cb12058-f59e-1433-6ba6-f500be250996@quicinc.com>
Date:   Wed, 15 Mar 2023 21:23:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] ring-buffer: remove obsolete comment for
 free_buffer_page()
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@elte.hu>
CC:     <linux-trace-kernel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>,
        Mike Rapoport <mike.rapoport@gmail.com>
References: <20230315142446.27040-1-vbabka@suse.cz>
 <72de48c7-014d-80ac-51e9-ba22450f1d5b@quicinc.com>
In-Reply-To: <72de48c7-014d-80ac-51e9-ba22450f1d5b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tWTUwyx-G1ue8ABDjRD_AFNaeBsZipo_
X-Proofpoint-GUID: tWTUwyx-G1ue8ABDjRD_AFNaeBsZipo_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_08,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2302240000
 definitions=main-2303150133
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/2023 9:21 PM, Mukesh Ojha wrote:
> 
> 
> On 3/15/2023 7:54 PM, Vlastimil Babka wrote:
>> The comment refers to mm/slob.o which is being removed. It comes from

nit: mm/slob.c

-- Mukesh

> 
> 
>> commit ed56829cb319 ("ring_buffer: reset buffer page when freeing") and
>> according to Steven the borrowed code was a page mapcount and mapping
>> reset, which was later removed by commit e4c2ce82ca27 ("ring_buffer:
>> allocate buffer page pointer"). Thus the comment is not accurate anyway,
>> remove it.
>>
>> Reported-by: Mike Rapoport <mike.rapoport@gmail.com>
>> Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>> Fixes: e4c2ce82ca27 ("ring_buffer: allocate buffer page pointer")
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>   kernel/trace/ring_buffer.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
>> index af50d931b020..c6f47b6cfd5f 100644
>> --- a/kernel/trace/ring_buffer.c
>> +++ b/kernel/trace/ring_buffer.c
>> @@ -354,10 +354,6 @@ static void rb_init_page(struct buffer_data_page 
>> *bpage)
>>       local_set(&bpage->commit, 0);
>>   }
>> -/*
>> - * Also stolen from mm/slob.c. Thanks to Mathieu Desnoyers for pointing
>> - * this issue out.
>> - */
> 
> Thanks for the clean up.
> 
> Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
> 
> -- Mukesh
> 
>>   static void free_buffer_page(struct buffer_page *bpage)
>>   {
>>       free_page((unsigned long)bpage->page);
