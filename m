Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720F467DE35
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 08:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjA0HFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 02:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjA0HFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 02:05:42 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0409B;
        Thu, 26 Jan 2023 23:05:40 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30R5xDcp003124;
        Fri, 27 Jan 2023 07:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qQJNXVgNP1UA8TsDPsVHW14jVOFRW08SKjTUqwMNI8k=;
 b=J4nm8XLP0FIk6vrZVQsrYb5LNCr8wE6177TMOwDwwgGBvXl6xNHBoWOEyQtg7EnPrHuI
 Qp3lPPySn+N4SwWqqRqfv4p2Z/TeFYn94XYcWllb/zc8iD6g2Exz64a/I2yN79HS4qy1
 /TmgVQP4f+TIjspa/JDZG/e1N4cGBBm0Et4XF6Zi59crqcF/vQE2WB1Pu9jGssWmtJ2K
 JqYENbMPZVCqLnVg+UCR9JLCcCzKWBu6sbRULi5RPx++NTTjP0yaTbERF3VRT8nbDLwv
 Y4D9cyp/WRPZ3ObA38VhYSosc1fVh/CsgOdJr265H6pSn+on9UiKOogbZZtjwvUNmBSx Dg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nbp1va3re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 07:05:19 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30R75Hs3024102
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 07:05:17 GMT
Received: from [10.216.47.84] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 26 Jan
 2023 23:05:13 -0800
Message-ID: <e5ecc40f-f8f8-ec6b-b8b8-fb7734878de8@quicinc.com>
Date:   Fri, 27 Jan 2023 12:35:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 31/35] Documentation: trace: correct spelling
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
References: <20230127064005.1558-1-rdunlap@infradead.org>
 <20230127064005.1558-32-rdunlap@infradead.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230127064005.1558-32-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wzf3II9ocFfsMzIKsBUjlud5OOLLrGt8
X-Proofpoint-GUID: wzf3II9ocFfsMzIKsBUjlud5OOLLrGt8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_03,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 clxscore=1011 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270065
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/2023 12:10 PM, Randy Dunlap wrote:
> Correct spelling problems for Documentation/trace/ as reported
> by codespell.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
> Cc: linux-trace-kernel@vger.kernel.org
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>   Documentation/trace/coresight/coresight-etm4x-reference.rst |    2 +-
>   Documentation/trace/events.rst                              |    6 +++---
>   Documentation/trace/fprobe.rst                              |    2 +-
>   Documentation/trace/ftrace-uses.rst                         |    2 +-
>   Documentation/trace/hwlat_detector.rst                      |    2 +-
>   Documentation/trace/rv/runtime-verification.rst             |    2 +-
>   Documentation/trace/uprobetracer.rst                        |    2 +-
>   7 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff -- a/Documentation/trace/coresight/coresight-etm4x-reference.rst b/Documentation/trace/coresight/coresight-etm4x-reference.rst
> --- a/Documentation/trace/coresight/coresight-etm4x-reference.rst
> +++ b/Documentation/trace/coresight/coresight-etm4x-reference.rst
> @@ -675,7 +675,7 @@ Bit assignments shown below:-
>       reconstructed using only conditional branches.
>   
>       There is currently no support in Perf for supplying modified binaries to the decoder, so this
> -    feature is only inteded to be used for debugging purposes or with a 3rd party tool.
> +    feature is only intended to be used for debugging purposes or with a 3rd party tool.
>   
>       Choosing this option will result in a significant increase in the amount of trace generated -
>       possible danger of overflows, or fewer instructions covered. Note, that this option also
> diff -- a/Documentation/trace/events.rst b/Documentation/trace/events.rst
> --- a/Documentation/trace/events.rst
> +++ b/Documentation/trace/events.rst
> @@ -903,7 +903,7 @@ functions can be used.
>   
>   To create a kprobe event, an empty or partially empty kprobe event
>   should first be created using kprobe_event_gen_cmd_start().  The name
> -of the event and the probe location should be specfied along with one
> +of the event and the probe location should be specified along with one
>   or args each representing a probe field should be supplied to this
>   function.  Before calling kprobe_event_gen_cmd_start(), the user
>   should create and initialize a dynevent_cmd object using
> @@ -983,7 +983,7 @@ The basic idea is simple and amounts to
>   layer that can be used to generate trace event commands.  The
>   generated command strings can then be passed to the command-parsing
>   and event creation code that already exists in the trace event
> -subystem for creating the corresponding trace events.
> +subsystem for creating the corresponding trace events.
>   
>   In a nutshell, the way it works is that the higher-level interface
>   code creates a struct dynevent_cmd object, then uses a couple
> @@ -1056,7 +1056,7 @@ to add an operator between the pair (her
>   appended onto the end of the arg pair (here ';').
>   
>   There's also a dynevent_str_add() function that can be used to simply
> -add a string as-is, with no spaces, delimeters, or arg check.
> +add a string as-is, with no spaces, delimiters, or arg check.
>   
>   Any number of dynevent_*_add() calls can be made to build up the string
>   (until its length surpasses cmd->maxlen).  When all the arguments have
> diff -- a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
> --- a/Documentation/trace/fprobe.rst
> +++ b/Documentation/trace/fprobe.rst
> @@ -111,7 +111,7 @@ saved at function entry and passed to ex
>           the instruction pointer of @regs may be different from the @entry_ip
>           in the entry_handler. If you need traced instruction pointer, you need
>           to use @entry_ip. On the other hand, in the exit_handler, the instruction
> -        pointer of @regs is set to the currect return address.
> +        pointer of @regs is set to the correct return address.
>   
>   Share the callbacks with kprobes
>   ================================
> diff -- a/Documentation/trace/ftrace-uses.rst b/Documentation/trace/ftrace-uses.rst
> --- a/Documentation/trace/ftrace-uses.rst
> +++ b/Documentation/trace/ftrace-uses.rst
> @@ -193,7 +193,7 @@ FTRACE_OPS_FL_RECURSION
>   	Not, if this flag is set, then the callback will always be called
>   	with preemption disabled. If it is not set, then it is possible
>   	(but not guaranteed) that the callback will be called in
> -	preemptable context.
> +	preemptible context.
>   
>   FTRACE_OPS_FL_IPMODIFY
>   	Requires FTRACE_OPS_FL_SAVE_REGS set. If the callback is to "hijack"
> diff -- a/Documentation/trace/hwlat_detector.rst b/Documentation/trace/hwlat_detector.rst
> --- a/Documentation/trace/hwlat_detector.rst
> +++ b/Documentation/trace/hwlat_detector.rst
> @@ -14,7 +14,7 @@ originally written for use by the "RT" p
>   kernel is highly latency sensitive.
>   
>   SMIs are not serviced by the Linux kernel, which means that it does not
> -even know that they are occuring. SMIs are instead set up by BIOS code
> +even know that they are occurring. SMIs are instead set up by BIOS code
>   and are serviced by BIOS code, usually for "critical" events such as
>   management of thermal sensors and fans. Sometimes though, SMIs are used for
>   other tasks and those tasks can spend an inordinate amount of time in the
> diff -- a/Documentation/trace/rv/runtime-verification.rst b/Documentation/trace/rv/runtime-verification.rst
> --- a/Documentation/trace/rv/runtime-verification.rst
> +++ b/Documentation/trace/rv/runtime-verification.rst
> @@ -31,7 +31,7 @@ In Linux terms, the runtime verification
>   *RV monitor* abstraction. A *RV monitor* includes a reference model of the
>   system, a set of instances of the monitor (per-cpu monitor, per-task monitor,
>   and so on), and the helper functions that glue the monitor to the system via
> -trace, as depicted bellow::
> +trace, as depicted below::
>   
>    Linux   +---- RV Monitor ----------------------------------+ Formal
>     Realm  |                                                  |  Realm
> diff -- a/Documentation/trace/uprobetracer.rst b/Documentation/trace/uprobetracer.rst
> --- a/Documentation/trace/uprobetracer.rst
> +++ b/Documentation/trace/uprobetracer.rst
> @@ -55,7 +55,7 @@ Synopsis of uprobe_tracer
>   
>     (\*1) only for return probe.
>     (\*2) this is useful for fetching a field of data structures.
> -  (\*3) Unlike kprobe event, "u" prefix will just be ignored, becuse uprobe
> +  (\*3) Unlike kprobe event, "u" prefix will just be ignored, because uprobe
>           events can access only user-space memory.
>   
>   Types


Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
