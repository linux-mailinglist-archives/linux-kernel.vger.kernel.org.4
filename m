Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F266D9C77
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239762AbjDFPea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238942AbjDFPe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:34:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE16B1BC0;
        Thu,  6 Apr 2023 08:34:27 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3368F4qv008920;
        Thu, 6 Apr 2023 15:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=SUxTxAWbPbT+ATUFJ3SOQUKdFTCdJ1wQh+3sgo3pTTU=;
 b=gwEzw8mbVN3CapDzdkiwa2OTaLWDRbn3UbAUFEZA12gr37jcrS1VUhlqWwBQTBGkge1N
 1zlZPCTOLvmf55RQ4ckKb5Kw0UVoMk7jH+6LTpl40dACqYWg9qj3m/fXm9e9Dd+zF507
 1mpSyDXklovwrD7QC6htXFq6WGIg2Kn99RpmPQMNHFX9Mn+8AU5JFOLLyTZMp2prsJio
 gxGgJl66EkoRKda6LjP5SVD57ma9p9t2p+CfwYKRB+dMvEXSJHgHuCGwOOCzCsSGgHmU
 YAnp7ko/AFmrtU+Zo28TWuGlHWkRLnN0V2Hjb/wL7THm//Nl56/+/9KxhXfIY3YGmF37 oA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pss7e94j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 15:34:00 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 336FXxV2012079
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Apr 2023 15:33:59 GMT
Received: from [10.216.2.94] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 6 Apr 2023
 08:33:56 -0700
Message-ID: <c8c8a5f4-8e5f-c7d3-76dd-ce184a4dcc02@quicinc.com>
Date:   Thu, 6 Apr 2023 21:03:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] tracing/synthetic: Make lastcmd_mutex static
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        kernel test robot <lkp@intel.com>,
        Tze-nan Wu <Tze-nan.Wu@mediatek.com>
References: <20230406111033.6e26de93@gandalf.local.home>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230406111033.6e26de93@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IzD20hwCJjDT6IK7c0VE83Cn5wEpcNua
X-Proofpoint-ORIG-GUID: IzD20hwCJjDT6IK7c0VE83Cn5wEpcNua
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_08,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060138
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/6/2023 8:40 PM, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The lastcmd_mutex is only used in trace_events_synth.c and should be
> static.
> 
> Link: https://lore.kernel.org/linux-trace-kernel/202304062033.cRStgOuP-lkp@intel.com/
> 
> Fixes: 4ccf11c4e8a8e ("tracing/synthetic: Fix races on freeing last_cmd")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

You have just beat me in pushing this.

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-- Mukesh

> ---
>   kernel/trace/trace_events_synth.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index f0ff730125bf..d6a70aff2410 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -44,7 +44,7 @@ enum { ERRORS };
>   
>   static const char *err_text[] = { ERRORS };
>   
> -DEFINE_MUTEX(lastcmd_mutex);
> +static DEFINE_MUTEX(lastcmd_mutex);
>   static char *last_cmd;
>   
>   static int errpos(const char *str)
