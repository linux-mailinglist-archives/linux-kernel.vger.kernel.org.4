Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4376B8A4C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 06:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCNF2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 01:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCNF2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 01:28:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06DE1815C;
        Mon, 13 Mar 2023 22:28:32 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32E3WnxR025985;
        Tue, 14 Mar 2023 05:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0zMo/C/ZBnYtaBHa+bdEoXXpbeMwYZnTOhyA+3iZwpQ=;
 b=Ip+jVh7m9PYh1BkHYcvn3L6HVpI8Z/1GMLj6kKx6Mm1bzQlTn09yFH5ex13S+dabytRc
 5mQkQ4sR3Rwcu27FwYUohh+D8eCUfSybjYJW/JAMI7b1jt6ZaANu2K0uP+o1AyXVQ0GX
 BkBCvhkdaBWVXzGcPDUVKifqRV7FyPBjnNlFSgiRpUlROEbeNSomRLGCEw63uxlGQn6X
 SFk3rYZgzvNcfCBu7/dWvRRbHPH6melQAbHo+AD6mVoe/jMvyeSLeE4Lp2MYq62Zwtxn
 18WVNT3uJt8S52yCPRNzaGzStK2Auh8Dycg1gZpSDYcQnQbrWPHz/6x86QEjtX9u5jbW fA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3paay393dx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 05:28:19 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32E5SIXS003628
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 05:28:18 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 13 Mar
 2023 22:28:16 -0700
Message-ID: <1bcdc3ec-5329-119e-87b7-c8cf51256dd0@quicinc.com>
Date:   Tue, 14 Mar 2023 10:58:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mm: mmap: remove newline at the end of the trace
To:     Minwoo Im <minwoo.im.dev@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <ZAu6qDsNPmk82UjV@minwoo-desktop>
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <ZAu6qDsNPmk82UjV@minwoo-desktop>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5WD2I_pVau7pKwe017_7CRX-cr7Ra6kp
X-Proofpoint-GUID: 5WD2I_pVau7pKwe017_7CRX-cr7Ra6kp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_13,2023-03-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 mlxlogscore=821 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303140048
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/11/2023 4:48 AM, Minwoo Im wrote:
> We already have newline in TP_printk so remove the redundant newline
> character at the end of the mmap trace.
> 
> <...>-345     [006] .....    95.589290: exit_mmap: mt_mod ...
> 
> <...>-345     [006] .....    95.589413: vm_unmapped_area: addr=...
> 
> <...>-345     [006] .....    95.589571: vm_unmapped_area: addr=...
> 
> <...>-345     [006] .....    95.589606: vm_unmapped_area: addr=...
> 
> to
> 
> <...>-336     [006] .....    44.762506: exit_mmap: mt_mod ...
> <...>-336     [006] .....    44.762654: vm_unmapped_area: addr=...
> <...>-336     [006] .....    44.762794: vm_unmapped_area: addr=...
> <...>-336     [006] .....    44.762835: vm_unmapped_area: addr=...
> 
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

> ---
>   include/trace/events/mmap.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/mmap.h b/include/trace/events/mmap.h
> index 216de5f03621..f8d61485de16 100644
> --- a/include/trace/events/mmap.h
> +++ b/include/trace/events/mmap.h
> @@ -35,7 +35,7 @@ TRACE_EVENT(vm_unmapped_area,
>   		__entry->align_offset = info->align_offset;
>   	),
>   
> -	TP_printk("addr=0x%lx err=%ld total_vm=0x%lx flags=0x%lx len=0x%lx lo=0x%lx hi=0x%lx mask=0x%lx ofs=0x%lx\n",
> +	TP_printk("addr=0x%lx err=%ld total_vm=0x%lx flags=0x%lx len=0x%lx lo=0x%lx hi=0x%lx mask=0x%lx ofs=0x%lx",
>   		IS_ERR_VALUE(__entry->addr) ? 0 : __entry->addr,
>   		IS_ERR_VALUE(__entry->addr) ? __entry->addr : 0,
>   		__entry->total_vm, __entry->flags, __entry->length,
> @@ -110,7 +110,7 @@ TRACE_EVENT(exit_mmap,
>   		       __entry->mt		= &mm->mm_mt;
>   	),
>   
> -	TP_printk("mt_mod %p, DESTROY\n",
> +	TP_printk("mt_mod %p, DESTROY",
>   		  __entry->mt
>   	)
>   );
