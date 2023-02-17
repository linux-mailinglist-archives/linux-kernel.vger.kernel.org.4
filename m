Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D17269AFBA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjBQPqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjBQPqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:46:22 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7923C5ECAA;
        Fri, 17 Feb 2023 07:46:20 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H4pDKD017698;
        Fri, 17 Feb 2023 15:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XzYGMeAQ9VflYJUMCjFuSejUY1fv5UGqRk6/DRLJRhs=;
 b=T6+b7HrsQLCat6NXVwHWq+QdZvdP+hUiZT6cVC/xdLyOoVjcO5daADoAW8nF+vPdcilg
 EpexjuJAoSU0R1i9mSVnfkbv9vFPsnQlFmlTZJNACHe0NrT/E/3ormfb1/ToxfhDGFRP
 IjIS44xFzCgVBh7P7qPiXsSUdeLuA8QNo+mfSdIFs3d156yeJRERHgMI94ZgIlg29niw
 ij6gEnTkIF2FrNHVUux+U5fZPAzIRDDHPAukrZL5uMgfYYsotjIDqBzATxXebEEFZKBu
 L6jnosFloaoRP2ZisCbJyWLZcaNtGX56OUF8JnIky9hCu1Pcl2PHjHv2u77USiXT5P13 Fg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nsxe7t6pp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 15:46:11 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31HFkAN7019209
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 15:46:10 GMT
Received: from [10.216.18.25] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 17 Feb
 2023 07:46:07 -0800
Message-ID: <d21bf9e0-3216-4f0f-c0ed-b3e90566d805@quicinc.com>
Date:   Fri, 17 Feb 2023 21:16:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 5/6] tools/virtio: use canonical ftrace path
Content-Language: en-US
To:     Ross Zwisler <zwisler@chromium.org>, <linux-kernel@vger.kernel.org>
CC:     Ross Zwisler <zwisler@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-trace-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20230215223350.2658616-1-zwisler@google.com>
 <20230215223350.2658616-6-zwisler@google.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230215223350.2658616-6-zwisler@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VHOQqjvnzArkebpM_M4hrtBEz0K-fnUN
X-Proofpoint-ORIG-GUID: VHOQqjvnzArkebpM_M4hrtBEz0K-fnUN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_10,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=845 impostorscore=0 mlxscore=0
 priorityscore=1501 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302170140
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/16/2023 4:03 AM, Ross Zwisler wrote:
> The canonical location for the tracefs filesystem is at /sys/kernel/tracing.
> 
> But, from Documentation/trace/ftrace.rst:
> 
>    Before 4.1, all ftrace tracing control files were within the debugfs
>    file system, which is typically located at /sys/kernel/debug/tracing.
>    For backward compatibility, when mounting the debugfs file system,
>    the tracefs file system will be automatically mounted at:
> 
>    /sys/kernel/debug/tracing
> 
> A few spots in tools/virtio still refer to this older debugfs
> path, so let's update them to avoid confusion.
> 
> Signed-off-by: Ross Zwisler <zwisler@google.com>
> ---
>   tools/virtio/virtio-trace/README        |  2 +-
>   tools/virtio/virtio-trace/trace-agent.c | 12 ++++++++----
>   2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/virtio/virtio-trace/README b/tools/virtio/virtio-trace/README
> index b64845b823ab..cea29a2a4c0a 100644
> --- a/tools/virtio/virtio-trace/README
> +++ b/tools/virtio/virtio-trace/README
> @@ -95,7 +95,7 @@ Run
>   
>   1) Enable ftrace in the guest
>    <Example>
> -	# echo 1 > /sys/kernel/debug/tracing/events/sched/enable
> +	# echo 1 > /sys/kernel/tracing/events/sched/enable
>   
>   2) Run trace agent in the guest
>    This agent must be operated as root.
> diff --git a/tools/virtio/virtio-trace/trace-agent.c b/tools/virtio/virtio-trace/trace-agent.c
> index cdfe77c2b4c8..7e2d9bbf0b84 100644
> --- a/tools/virtio/virtio-trace/trace-agent.c
> +++ b/tools/virtio/virtio-trace/trace-agent.c
> @@ -18,8 +18,9 @@
>   #define PIPE_DEF_BUFS		16
>   #define PIPE_MIN_SIZE		(PAGE_SIZE*PIPE_DEF_BUFS)
>   #define PIPE_MAX_SIZE		(1024*1024)
> -#define READ_PATH_FMT	\
> -		"/sys/kernel/debug/tracing/per_cpu/cpu%d/trace_pipe_raw"
> +#define TRACEFS 		"/sys/kernel/tracing"
> +#define DEBUGFS 		"/sys/kernel/debug/tracing"
> +#define READ_PATH_FMT		"%s/per_cpu/cpu%d/trace_pipe_raw"
>   #define WRITE_PATH_FMT		"/dev/virtio-ports/trace-path-cpu%d"
>   #define CTL_PATH		"/dev/virtio-ports/agent-ctl-path"
>   
> @@ -120,9 +121,12 @@ static const char *make_path(int cpu_num, bool this_is_write_path)
>   	if (this_is_write_path)
>   		/* write(output) path */
>   		ret = snprintf(buf, PATH_MAX, WRITE_PATH_FMT, cpu_num);
> -	else
> +	else {
>   		/* read(input) path */
> -		ret = snprintf(buf, PATH_MAX, READ_PATH_FMT, cpu_num);
> +		ret = snprintf(buf, PATH_MAX, READ_PATH_FMT, TRACEFS, cpu_num);
> +		if (ret > 0 && access(buf, F_OK) != 0)
> +			ret = snprintf(buf, PATH_MAX, READ_PATH_FMT, DEBUGFS, cpu_num);
> +	}
> 


Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh


>   	if (ret <= 0) {
>   		pr_err("Failed to generate %s path(CPU#%d):%d\n",
