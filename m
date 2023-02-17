Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8333B69A57E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 07:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBQGJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 01:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBQGJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 01:09:20 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9912259712;
        Thu, 16 Feb 2023 22:09:18 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GNZNEJ002349;
        Fri, 17 Feb 2023 06:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JbkChnJ1PyNZz/5tAwUXEex3UKnTqTY8eohCSRwf1bM=;
 b=PJ/Rh2JG8TYXXfv0qY+B6A4udFaLaifwwbt6aqmyseYOSOmovpuQb1+9pbVbUPV50WhG
 Z9g57KaJ76vyldql1R1q9ICRwOr4y7PqQD/d/LWzR+WPs9CxaqBVT2zvXWgoRUo1jhRl
 CfbadZJCr/mY12zrk/BGdX1Ifhwc0Brep5Tv68H416+/iF58gZknJ4CyFQOlNATMeAgA
 N4UnGd4zZ6Og4WuahbkXJpywk3l3HXUHcnwRWcl8UDFQDRKyiievtI2xooG4l0QFrXnr
 wlhTzyPRsTrHy++AgNa1MsjjaE7ET2Jc7HW9mswGaD5s9YWvc7Br30NHZrEDLvHh3eX4 lA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ns85kc8mb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 06:09:00 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31H68x79031531
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 06:08:59 GMT
Received: from [10.239.155.136] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 16 Feb
 2023 22:08:55 -0800
Message-ID: <8b23c0e8-bcaa-6751-b09f-4865c1813dbb@quicinc.com>
Date:   Fri, 17 Feb 2023 14:08:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1] scsi: ufs: core: Add trace event for MCQ
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <quic_asutoshd@quicinc.com>, <quic_cang@quicinc.com>,
        <bvanassche@acm.org>, <mani@kernel.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>
References: <1676515562-55805-1-git-send-email-quic_ziqichen@quicinc.com>
 <20230216122259.7f44be57@rorschach.local.home>
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
In-Reply-To: <20230216122259.7f44be57@rorschach.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YOQymxIh14aISoQmrBlpjlvDX2bPnVHn
X-Proofpoint-ORIG-GUID: YOQymxIh14aISoQmrBlpjlvDX2bPnVHn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_02,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170053
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/17/2023 1:22 AM, Steven Rostedt wrote:
> On Thu, 16 Feb 2023 10:45:55 +0800
> Ziqi Chen <quic_ziqichen@quicinc.com> wrote:
>
>> Added a new trace event to record MCQ relevant information
>> for each request in MCQ mode, include hardware queue ID,
>> SQ tail slot, CQ head slot and CQ tail slot.
>>
>> Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
>> ---
>>   drivers/ufs/core/ufshcd.c  | 15 ++++++++++++---
>>   include/trace/events/ufs.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 60 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
>> index 3b3cf78..0037f4f 100644
>> --- a/drivers/ufs/core/ufshcd.c
>> +++ b/drivers/ufs/core/ufshcd.c
>> @@ -426,6 +426,8 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba, unsigned int tag,
>>   	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
>>   	struct scsi_cmnd *cmd = lrbp->cmd;
>>   	struct request *rq = scsi_cmd_to_rq(cmd);
>> +	struct ufs_hw_queue *hwq;
>> +
>>   	int transfer_len = -1;
>>   
>>   	if (!cmd)
>> @@ -456,9 +458,16 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba, unsigned int tag,
>>   	}
>>   
>>   	intr = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
>> -	doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
>> -	trace_ufshcd_command(dev_name(hba->dev), str_t, tag,
>> -			doorbell, transfer_len, intr, lba, opcode, group_id);
>> +
>> +	if (is_mcq_enabled(hba)) {
>> +		hwq = ufshcd_mcq_req_to_hwq(hba, rq);
>> +		trace_ufshcd_command_mcq(dev_name(hba->dev), str_t, tag,
> It's better to move the processing of the "dev_name(hba->dev) into the
> trace event code. Maybe even just pass in hba.

Hi Steven,

it is a good idea, but if so do .we need to make same change to all 
other UFS trace events to stay the same style.

that would be a big change.

>
>> +				hwq, transfer_len, intr, lba, opcode, group_id);
>> +	} else {
>> +		doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
>> +		trace_ufshcd_command(dev_name(hba->dev), str_t, tag,
> Here too.
>
>> +				doorbell, transfer_len, intr, lba, opcode, group_id);
>> +	}
>>   }
>>   
>>   static void ufshcd_print_clk_freqs(struct ufs_hba *hba)
>> diff --git a/include/trace/events/ufs.h b/include/trace/events/ufs.h
>> index 599739e..a406404e 100644
>> --- a/include/trace/events/ufs.h
>> +++ b/include/trace/events/ufs.h
>> @@ -10,6 +10,7 @@
>>   #define _TRACE_UFS_H
>>   
>>   #include <linux/tracepoint.h>
>> +#include <ufs/ufshcd.h>
>>   
>>   #define str_opcode(opcode)						\
>>   	__print_symbolic(opcode,					\
>> @@ -307,6 +308,53 @@ TRACE_EVENT(ufshcd_command,
>>   	)
>>   );
>>   
>> +TRACE_EVENT(ufshcd_command_mcq,
>> +	TP_PROTO(const char *dev_name, enum ufs_trace_str_t str_t,
> So you would pass in the type of hba here.
>
>> +		unsigned int tag, struct ufs_hw_queue *hwq, int transfer_len,
>> +		u32 intr, u64 lba, u8 opcode, u8 group_id),
>> +
>> +	TP_ARGS(dev_name, str_t, tag, hwq, transfer_len, intr, lba, opcode, group_id),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(dev_name, dev_name)
> 		__string(dname, dev_name(hba->dev))
>
>> +		__field(enum ufs_trace_str_t, str_t)
>> +		__field(unsigned int, tag)
>> +		__field(u32, hwq_id)
>> +		__field(int, transfer_len)
>> +		__field(u32, intr)
>> +		__field(u64, lba)
>> +		__field(u8, opcode)
>> +		__field(u8, group_id)
>> +		__field(u32, sq_tail)
>> +		__field(u32, cq_head)
>> +		__field(u32, cq_tail)
> I bet the above has a lot of holes in it. The above is not packed, so
> make sure you count the size of each field and try to keep them aligned.

you are right, I will update in next version.

Thanks，

Ziqi

>
>
>
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(dev_name, dev_name);
> 		__assign_str(dname, dev_name(hba->dev));
>
>> +		__entry->str_t = str_t;
>> +		__entry->tag = tag;
>> +		__entry->hwq_id = hwq->id;
>> +		__entry->transfer_len = transfer_len;
>> +		__entry->intr = intr;
>> +		__entry->lba = lba;
>> +		__entry->opcode = opcode;
>> +		__entry->group_id = group_id;
>> +		__entry->sq_tail = hwq->sq_tail_slot;
>> +		__entry->cq_head = hwq->cq_head_slot;
>> +		__entry->cq_tail = hwq->cq_tail_slot;
>> +	),
>> +
>> +	TP_printk(
>> +		"%s: %s: tag: %u, hwq_id: %d, size: %d, IS: %u, LBA: %llu, opcode: 0x%x (%s), group_id: 0x%x, sq_tail_slot: %d, cq_head_slot: %d, cq_tail_slot: %d",
>> +		show_ufs_cmd_trace_str(__entry->str_t), __get_str(dev_name),
> 				__get_str(dname),
>
> -- Steve
>
>> +		__entry->tag, __entry->hwq_id, __entry->transfer_len,
>> +		__entry->intr, __entry->lba, (u32)__entry->opcode,
>> +		str_opcode(__entry->opcode), (u32)__entry->group_id,
>> +		__entry->sq_tail, __entry->cq_head,  __entry->cq_tail
>> +	)
>> +);
>> +
>>   TRACE_EVENT(ufshcd_uic_command,
>>   	TP_PROTO(const char *dev_name, enum ufs_trace_str_t str_t, u32 cmd,
>>   		 u32 arg1, u32 arg2, u32 arg3),
