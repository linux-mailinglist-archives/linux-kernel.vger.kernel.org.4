Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA936B19A9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 03:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjCIC4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 21:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCIC4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 21:56:05 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD24738B0;
        Wed,  8 Mar 2023 18:56:03 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3290l3Zg004404;
        Thu, 9 Mar 2023 02:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HLldECmdExjhq46993MhUQCY8si2mDULKtG81aeLExc=;
 b=JMbhjKo+jUlbPJeW/KCsmqGnUiMcEeijuyGXKb7243hWmoRpmaJ3814rZ7CxUIwtAZE2
 GzK9WCxs4NGmD0ez3+oj8fOCdqKCAydfOJ5Tfmjdv9ZYeYSGTsdYfZXfJHU/gkBnvDuo
 fnndUxhF6sHNO7gmfJX52MWM8hA0+8fNWc3sH4V8RXO+0oOLn8F/2ZK861D8681LSw7y
 zIWO1zHx5gBhda8ub/OYpfcDwoN2Y2i/rtgRDjETm7jgtRg3ImdqXS28c1reEi3iSTt1
 7Emzcr4tvOCF0kHaRfF/AwFup/2A188+InvNVVFYNn1NAwsghXyS8wUQ7sGeSS89KttS 3Q== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6ycb92bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 02:44:24 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3292iNcP031073
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Mar 2023 02:44:23 GMT
Received: from [10.239.155.136] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 8 Mar 2023
 18:44:20 -0800
Message-ID: <f96b1867-142f-7fdc-8123-58fe3bdce844@quicinc.com>
Date:   Thu, 9 Mar 2023 10:44:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4] scsi: ufs: core: Add trace event for MCQ
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
References: <1677836154-29192-1-git-send-email-quic_ziqichen@quicinc.com>
 <67db2c6b-c3b0-c525-e6a9-2b2fe6c6adbb@acm.org>
 <f80fd91b-3a03-5c38-72c0-cd5c3edb33b8@quicinc.com>
 <8a83ec79-be04-ec5c-f3ef-67f64dc55f12@acm.org>
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
In-Reply-To: <8a83ec79-be04-ec5c-f3ef-67f64dc55f12@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8aeZATOU9Ckv_9taop9evzjRDr5kum0p
X-Proofpoint-ORIG-GUID: 8aeZATOU9Ckv_9taop9evzjRDr5kum0p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_15,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 mlxscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090022
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/2023 11:47 PM, Bart Van Assche wrote:
> On 3/6/23 21:53, Ziqi Chen wrote:
>> You are right,  users may hate it if the trace events for legacy mode 
>> and MCQ mode are different. But if I merge them into one event, it 
>> will print much invalid information as we can not add if-else into 
>> TP_printk().
>>
>> (For example:  in SDB legacy mode, you can see such invalid prints " 
>> hqid = 0 , sqt= 0, cqh=0, cqt = 0")
>>
>> Users may hate these invalid information.
>>
>> Anyway, I have made new version that merge 2 mode into one event, but 
>> are you sure we really need to use this way? if yes , I can push new 
>> version here.
>>
>> Or, could you give some suggestions if you have better way.
>>
>> Below is a piece of new version code , you can preview.
>>
>>      TP_fast_assign(
>>          __assign_str(dev_name, dev_name);
>>          __entry->str_t = str_t;
>>          __entry->tag = tag;
>>          __entry->doorbell = doorbell;
>>          __entry->hwq_id = hwq? hwq->id: 0;
>>          __entry->sq_tail = hwq? hwq->sq_tail_slot: 0;
>>          __entry->cq_head = hwq? hwq->cq_head_slot: 0;
>>          __entry->cq_tail = hwq? hwq->cq_tail_slot: 0;
>>          __entry->transfer_len = transfer_len;
>>          __entry->lba = lba;
>>          __entry->intr = intr;
>>          __entry->opcode = opcode;
>>          __entry->group_id = group_id;
>>      ),
>>
>>      TP_printk(
>>          "%s: %s: tag: %u, DB: 0x%x, size: %d, IS: %u, LBA: %llu, 
>> opcode: 0x%x (%s),"
>>          "group_id: 0x%x, hqid: %d, sqt: %d, cqh: %d, cqt: %d",
>>          show_ufs_cmd_trace_str(__entry->str_t), __get_str(dev_name), 
>> __entry->tag,
>>          __entry->doorbell, __entry->transfer_len, __entry->intr, 
>> __entry->lba,
>>          (u32)__entry->opcode, str_opcode(__entry->opcode), 
>> (u32)__entry->group_id,
>>          __entry->hwq_id,__entry->sq_tail, __entry->cq_head, 
>> __entry->cq_tail
>>      )
> 
> Hi Ziqi,
> 
> Please reply below the original e-mail instead of above. This is 
> expected on Linux kernel mailing lists.
> 
> Regarding your question: I propose to leave out the sq_tail, cq_head and 
> cq_tail information. That information may be useful for hardware 
> developers but is not useful for other users of the Linux kernel. So the 
> only piece of information that is left that is MCQ-specific is the 
> hardware queue index. I expect that users will be fine to see that 
> information in trace events.
> 
> How about reporting hardware queue index -1 for legacy mode instead of 
> 0? That will allow users to tell the difference between legacy mode and 
> MCQ mode from the trace events.
> 
> Thanks,
> 
> Bart.

Hi Bart,

Thanks for you suggestion. But the member hwq->id is an Unsigned 
integer. if you want to identify SDB mode and MCQ mode,  using "0" is 
enough, Or how about add string such as below?

ufshcd_command: MCQ: complete_rsp: 1d84000.ufshc: tag: 14, DB: 0x0, 
size: 32768, IS: 0, LBA: 5979448,opcode: 0x2a (WRITE_10),group_id: 0x0, 
hqid: 2

Ziqi
> 
