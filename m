Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF436A9B70
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 17:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjCCQQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 11:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCCQQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 11:16:41 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE1611167;
        Fri,  3 Mar 2023 08:16:39 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 323CvhM2027021;
        Fri, 3 Mar 2023 16:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gTPbXrLroShWk4Eefkk2daQUenN8urjbbeRVzXU/I4E=;
 b=H82+GNMYgek7C+PGAt+fBpPXvcNSNUW8RtuzUonqWYG12Cuyxrevyw71/5gJnTBsQ5bW
 Av0QadECgt/166kLKO+3U3lZYAHyhH+ZbRGqZv9nw9zF7csAcLeXfPjN1RIefOeF0VZd
 rrMcr6wkz9lOrdDIN8ivJLCuRjq4G4LxeaTHx0qY/QcPJNIlbqmVapU1b0uXL/xyYQuv
 eoHu4dQv5SzmXDWS196xLZcDh2oii78Zw218nL6ynh+10iFLGy94DjR1eNcL+r0zh5Px
 bP2oUiGzBUogrxSPOB25jOUM1DAq33hp+BRLS+DjT2ZdCht9NBlfZlzsIae94LHrvM2E Lg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p2veev3sc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 16:16:32 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 323GGVns018007
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Mar 2023 16:16:31 GMT
Received: from [10.216.34.86] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 3 Mar 2023
 08:16:29 -0800
Message-ID: <f21a6563-d86a-447f-6096-55b74c9c288e@quicinc.com>
Date:   Fri, 3 Mar 2023 21:46:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/3] ring_buffer: Change some static functions to void
Content-Language: en-US
To:     Uros Bizjak <ubizjak@gmail.com>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20230303151706.57851-1-ubizjak@gmail.com>
 <20230303151706.57851-2-ubizjak@gmail.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230303151706.57851-2-ubizjak@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hSDYyiCpBuVfz04TArGsyiwLImh92yLf
X-Proofpoint-GUID: hSDYyiCpBuVfz04TArGsyiwLImh92yLf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_03,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 bulkscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030140
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/3/2023 8:47 PM, Uros Bizjak wrote:
> The results of some static functions are not used. Change the
> type of these function to void and remove unnecessary returns.
> 
> No functional change intended.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>   kernel/trace/ring_buffer.c | 22 +++++++---------------
>   1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index af50d931b020..05fdc92554df 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1569,15 +1569,12 @@ static void rb_tail_page_update(struct ring_buffer_per_cpu *cpu_buffer,
>   	}
>   }
>   
> -static int rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
> +static void rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
>   			  struct buffer_page *bpage)
>   {
>   	unsigned long val = (unsigned long)bpage;
>   
> -	if (RB_WARN_ON(cpu_buffer, val & RB_FLAG_MASK))
> -		return 1;
> -
> -	return 0;
> +	RB_WARN_ON(cpu_buffer, val & RB_FLAG_MASK);
>   }
>   
>   /**
> @@ -1587,30 +1584,28 @@ static int rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
>    * As a safety measure we check to make sure the data pages have not
>    * been corrupted.
>    */
> -static int rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
> +static void rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
>   {
>   	struct list_head *head = rb_list_head(cpu_buffer->pages);
>   	struct list_head *tmp;
>   
>   	if (RB_WARN_ON(cpu_buffer,
>   			rb_list_head(rb_list_head(head->next)->prev) != head))
> -		return -1;
> +		return;
>   
>   	if (RB_WARN_ON(cpu_buffer,
>   			rb_list_head(rb_list_head(head->prev)->next) != head))
> -		return -1;
> +		return;
>   
>   	for (tmp = rb_list_head(head->next); tmp != head; tmp = rb_list_head(tmp->next)) {
>   		if (RB_WARN_ON(cpu_buffer,
>   				rb_list_head(rb_list_head(tmp->next)->prev) != tmp))
> -			return -1;
> +			return;
>   
>   		if (RB_WARN_ON(cpu_buffer,
>   				rb_list_head(rb_list_head(tmp->prev)->next) != tmp))
> -			return -1;
> +			return;
>   	}
> -
> -	return 0;
>   }
>   
>   static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
> @@ -4500,7 +4495,6 @@ rb_update_read_stamp(struct ring_buffer_per_cpu *cpu_buffer,
>   	default:
>   		RB_WARN_ON(cpu_buffer, 1);
>   	}
> -	return;
>   }
>   
>   static void
> @@ -4531,7 +4525,6 @@ rb_update_iter_read_stamp(struct ring_buffer_iter *iter,
>   	default:
>   		RB_WARN_ON(iter->cpu_buffer, 1);
>   	}
> -	return;
>   }
>   
>   static struct buffer_page *
> @@ -4946,7 +4939,6 @@ rb_reader_unlock(struct ring_buffer_per_cpu *cpu_buffer, bool locked)
>   {
>   	if (likely(locked))
>   		raw_spin_unlock(&cpu_buffer->reader_lock);
> -	return;
>   }
>   

Nice clean up, thanks.

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
>   /**
