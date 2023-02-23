Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E18D6A052B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbjBWJpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjBWJpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:45:17 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6854DBE5;
        Thu, 23 Feb 2023 01:45:16 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31N9Uwcj012832;
        Thu, 23 Feb 2023 09:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Gx3+mGmc7DFKhERodDYBVbeI5ialDo5msuhCKNGkjew=;
 b=EmD8ryUNkf7lncbZnsBvUQ3wjuzkdYv7ooxf2ft2cTQg4PIprEZL/CyHMH+LhFXYnWXm
 UWBcZCyIW66neSD5H/yaJ9ZZyHl0JrybuMGqvIwFXaGXwfW9y8UfGW4th/0S58j/zwKy
 +YWbLTPeQhuSfPRxMWja1Ji17egF/eFFXr3JCEtBxRCrT8fKMK8SbeZ4eRz+hmraH+fF
 +XTz1KoomCPzFUIBims52YveQzZcTXFU2LHB1Tc/AubDfFIZpR3le6r1kDsHp4uIO9ZV
 Jkp4s8KVMbNiAgkyBBq/sqYlKMxg5kfQH5BG/KZuGZKJU5Ges4lP5j37i+qExFKZqA/m mg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwywd0tnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 09:44:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31N9ilmo014950
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 09:44:47 GMT
Received: from [10.253.32.65] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 23 Feb
 2023 01:44:43 -0800
Message-ID: <d2b2f3c2-3e65-d98a-991d-40ae6fcddef9@quicinc.com>
Date:   Thu, 23 Feb 2023 17:44:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH v3] scsi: ufs: core: Add trace event for MCQ
To:     Ziqi Chen <quic_ziqichen@quicinc.com>, <quic_asutoshd@quicinc.com>,
        <bvanassche@acm.org>, <mani@kernel.org>,
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
References: <1677051569-81113-1-git-send-email-quic_ziqichen@quicinc.com>
Content-Language: en-US
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <1677051569-81113-1-git-send-email-quic_ziqichen@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: r3TlIyExX0722icxmLCJ93TqM887RsHb
X-Proofpoint-ORIG-GUID: r3TlIyExX0722icxmLCJ93TqM887RsHb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_05,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302230084
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/22/2023 3:39 PM, Ziqi Chen wrote:
> Added a new trace event to record MCQ relevant information
> for each request in MCQ mode, include hardware queue ID,
> SQ tail slot, CQ head slot and CQ tail slot.
>
> Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
reviewed-by:  Can Guo <quic_cang@quicinc.com>
>
> ---
> Changes to v2:
> - Shorten printing strings.
>
> Changes to v1:
> - Adjust the order of fileds to keep them aligned.
> ---
>   drivers/ufs/core/ufshcd.c  | 14 +++++++++++---
>   include/trace/events/ufs.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 59 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 3b3cf78..67cb90d 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -426,6 +426,7 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba, unsigned int tag,
>   	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
>   	struct scsi_cmnd *cmd = lrbp->cmd;
>   	struct request *rq = scsi_cmd_to_rq(cmd);
> +	struct ufs_hw_queue *hwq;
>   	int transfer_len = -1;
>   
>   	if (!cmd)
> @@ -456,9 +457,16 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba, unsigned int tag,
>   	}
>   
>   	intr = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
> -	doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
> -	trace_ufshcd_command(dev_name(hba->dev), str_t, tag,
> -			doorbell, transfer_len, intr, lba, opcode, group_id);
> +
> +	if (is_mcq_enabled(hba)) {
> +		hwq = ufshcd_mcq_req_to_hwq(hba, rq);
> +		trace_ufshcd_command_mcq(dev_name(hba->dev), str_t, tag,
> +				hwq, transfer_len, intr, lba, opcode, group_id);
> +	} else {
> +		doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
> +		trace_ufshcd_command(dev_name(hba->dev), str_t, tag,
> +				doorbell, transfer_len, intr, lba, opcode, group_id);
> +	}
>   }
>   
>   static void ufshcd_print_clk_freqs(struct ufs_hba *hba)
> diff --git a/include/trace/events/ufs.h b/include/trace/events/ufs.h
> index 599739e..604b2cd 100644
> --- a/include/trace/events/ufs.h
> +++ b/include/trace/events/ufs.h
> @@ -10,6 +10,7 @@
>   #define _TRACE_UFS_H
>   
>   #include <linux/tracepoint.h>
> +#include <ufs/ufshcd.h>
>   
>   #define str_opcode(opcode)						\
>   	__print_symbolic(opcode,					\
> @@ -307,6 +308,53 @@ TRACE_EVENT(ufshcd_command,
>   	)
>   );
>   
> +TRACE_EVENT(ufshcd_command_mcq,
> +	TP_PROTO(const char *dev_name, enum ufs_trace_str_t str_t,
> +		unsigned int tag, struct ufs_hw_queue *hwq, int transfer_len,
> +		u32 intr, u64 lba, u8 opcode, u8 group_id),
> +
> +	TP_ARGS(dev_name, str_t, tag, hwq, transfer_len, intr, lba, opcode, group_id),
> +
> +	TP_STRUCT__entry(
> +		__string(dev_name, dev_name)
> +		__field(enum ufs_trace_str_t, str_t)
> +		__field(unsigned int, tag)
> +		__field(u32, hwq_id)
> +		__field(u32, sq_tail)
> +		__field(u32, cq_head)
> +		__field(u32, cq_tail)
> +		__field(int, transfer_len)
> +		__field(u32, intr)
> +		__field(u64, lba)
> +		__field(u8, opcode)
> +		__field(u8, group_id)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(dev_name, dev_name);
> +		__entry->str_t = str_t;
> +		__entry->tag = tag;
> +		__entry->hwq_id = hwq->id;
> +		__entry->sq_tail = hwq->sq_tail_slot;
> +		__entry->cq_head = hwq->cq_head_slot;
> +		__entry->cq_tail = hwq->cq_tail_slot;
> +		__entry->transfer_len = transfer_len;
> +		__entry->intr = intr;
> +		__entry->lba = lba;
> +		__entry->opcode = opcode;
> +		__entry->group_id = group_id;
> +	),
> +
> +	TP_printk(
> +		"%s: %s: tag: %u, hqid: %d, size: %d, IS: %u, LBA: %llu, opcode: 0x%x (%s), group_id: 0x%x, sqt: %d, cqh: %d, cqt: %d",
> +		show_ufs_cmd_trace_str(__entry->str_t), __get_str(dev_name),
> +		__entry->tag, __entry->hwq_id, __entry->transfer_len,
> +		__entry->intr, __entry->lba, (u32)__entry->opcode,
> +		str_opcode(__entry->opcode), (u32)__entry->group_id,
> +		__entry->sq_tail, __entry->cq_head,  __entry->cq_tail
> +	)
> +);
> +
>   TRACE_EVENT(ufshcd_uic_command,
>   	TP_PROTO(const char *dev_name, enum ufs_trace_str_t str_t, u32 cmd,
>   		 u32 arg1, u32 arg2, u32 arg3),
