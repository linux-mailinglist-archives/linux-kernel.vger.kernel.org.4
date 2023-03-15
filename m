Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8FD6BA99F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjCOHor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjCOHoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:44:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9823612BF0;
        Wed, 15 Mar 2023 00:44:23 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32F4tSLZ014017;
        Wed, 15 Mar 2023 07:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MnCZz38kzqLJScTGZXzpPP8AqHNxs8XsBNy8Q65MsNA=;
 b=JtAiVazhbFAZKg0CDtWcwDxuTpgAN0hr9hleE2yVDupSgq2GYdpAGgHR6+T2LYYqu4IG
 m1pz2cZMt2PN+oZqZFJLSaPs+FBokrUGDwujOW/HCivaMjulmlxbA32PwAuyt6DbBs4i
 aNmxd7q8bxgJzJKRkb01r5oTrs6DjhxohkyBDmPwsb5S2Jy+d2zrytCyrN5FgnpQO1gh
 idAsv7lvJssLWKjsZnP2t5g/y+rmhI7jOrfp9DQQ/mlYSOR65j9M4JOiFOMqjYRQ8Abe
 JCbELDxnUtGA9PtAeEBuM4L9erH8y031R/AdVE3Sdk8GmmXIFL5evmrop3nJQkZaJF1A Iw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pb2cr0v0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 07:43:38 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32F7hbCR020945
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 07:43:37 GMT
Received: from [10.239.155.136] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Mar
 2023 00:43:33 -0700
Message-ID: <c1d9e985-9948-6620-d311-cfc590fe89b2@quicinc.com>
Date:   Wed, 15 Mar 2023 15:43:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v6] scsi: ufs: core: Add trace event for MCQ
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, <quic_asutoshd@quicinc.com>,
        <quic_cang@quicinc.com>, <quic_nguyenb@quicinc.com>,
        <mani@kernel.org>, <stanley.chu@mediatek.com>,
        <adrian.hunter@intel.com>, <beanhuo@micron.com>,
        <avri.altman@wdc.com>, <junwoo80.lee@samsung.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>
References: <1678792580-3178-1-git-send-email-quic_ziqichen@quicinc.com>
 <70bf37fb-bc66-d341-7c2d-bf1785ba464f@acm.org>
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
In-Reply-To: <70bf37fb-bc66-d341-7c2d-bf1785ba464f@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hPAoTDQ1ysPVbZKryAbrEJIW7seTbE10
X-Proofpoint-GUID: hPAoTDQ1ysPVbZKryAbrEJIW7seTbE10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_03,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150063
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

Sure, will fix it.


Best Regards,
Ziqi

On 3/15/2023 2:13 AM, Bart Van Assche wrote:
> On 3/14/23 04:15, Ziqi Chen wrote:
>>       TP_printk(
>> -        "%s: %s: tag: %u, DB: 0x%x, size: %d, IS: %u, LBA: %llu, 
>> opcode: 0x%x (%s), group_id: 0x%x",
>> -        show_ufs_cmd_trace_str(__entry->str_t), __get_str(dev_name),
>> -        __entry->tag, __entry->doorbell, __entry->transfer_len,
>> -        __entry->intr, __entry->lba, (u32)__entry->opcode,
>> -        str_opcode(__entry->opcode), (u32)__entry->group_id
>> +        "%s: %s: tag: %u, DB: 0x%x, size: %d, IS: %u, LBA: %llu, 
>> opcode: 0x%x (%s), group_id: 0x%x, hwq_id: %d",
>> +         show_ufs_cmd_trace_str(__entry->str_t), __get_str(dev_name),
>> +         __entry->tag, __entry->doorbell, __entry->transfer_len, 
>> __entry->intr,
>> +         __entry->lba, (u32)__entry->opcode, 
>> str_opcode(__entry->opcode),
>> +         (u32)__entry->group_id, __entry->hwq_id
> 
> The alignment of the TP_printk() arguments looks odd. Please make sure 
> that arguments 2 and later start in the same column as the opening 
> double quote (") instead of one column to the right of that double quote.
> 
> Thanks,
> 
> Bart.
> 
