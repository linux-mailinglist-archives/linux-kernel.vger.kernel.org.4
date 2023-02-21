Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F4169DD75
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbjBUJ4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjBUJ4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:56:17 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C6025E1F;
        Tue, 21 Feb 2023 01:55:45 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31L3c368006086;
        Tue, 21 Feb 2023 09:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Eq62Q0wbpo7pHylv0FcNCCpESKRGyazEgASQmrp3l8Y=;
 b=YszRfKMJZyP92x8kLF/QJYqBgIn2LiqZfL9syGCXfDvjzF5P7jwjKxvqr3oiaUYN92sy
 Dz18HlfD/CAjoy3+99LEm+SecNwzn/IqnB2U8JnmqprTcN8ZCCFp/M5t7+m++iRSxMQ7
 lyd2kR6JcnyXKgpyKmI6tjnShw20nK270czOHkX1CDXBC7NT2Cz9lCft3MuiKhCh5SIC
 SPqjClCQNwK2RJ3rygtNwWxjZBhEzf5bWDtHvcxO4mzM2phZwObQQXIhhd7BwWXUqhd6
 Qh7hNTqUlMRkMkk2L0gfVQdP33DDgl7CZxEoC5dd1KrLesq16EQhJ0dtbPq6hcaUTC66 Iw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ntnpgfhhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 09:55:22 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31L9tKkN018817
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 09:55:20 GMT
Received: from [10.239.155.136] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 21 Feb
 2023 01:55:16 -0800
Message-ID: <d21f21f4-eabb-a30d-8251-9acaefb379e3@quicinc.com>
Date:   Tue, 21 Feb 2023 17:55:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] scsi: ufs: core: Add trace event for MCQ
Content-Language: en-US
To:     Bean Huo <huobean@gmail.com>, <quic_asutoshd@quicinc.com>,
        <quic_cang@quicinc.com>, <bvanassche@acm.org>, <mani@kernel.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>,
        <quic_ziqichen@quicinc.com>
CC:     <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>
References: <1676959630-35504-1-git-send-email-quic_ziqichen@quicinc.com>
 <614c6437-d0ba-a75f-8f65-6b47dab0ff99@gmail.com>
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
In-Reply-To: <614c6437-d0ba-a75f-8f65-6b47dab0ff99@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qRWBxcL2gl11Etivy2JJcazoShKtM3YU
X-Proofpoint-GUID: qRWBxcL2gl11Etivy2JJcazoShKtM3YU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_05,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 clxscore=1011
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210084
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bean，

looks reasonable，I will update in next version. Thanks~


On 2/21/2023 5:49 PM, Bean Huo wrote:
> On 21.02.23 7:07 AM, Ziqi Chen wrote:
>> +
>> +    TP_printk(
>> +        "%s: %s: tag: %u, hwq_id: %d, size: %d, IS: %u, LBA: %llu, 
>> opcode: 0x%x (%s), group_id: 0x%x, sq_tail_slot: %d, cq_head_slot: 
>> %d, cq_tail_slot: %d",
>
> Hi Ziqi,
>
> Looks good to me, just one thing,  the above print strings can be 
> shortened?
>
> hwq_id-->hdid
> sq_tail_slot-->sqt
> cq_tail_slot->sqt
> cq_head_slot->cqh
>
>
> Kind regards,
> Bean
>
>> + show_ufs_cmd_trace_str(__entry->str_t), __get_str(dev_name),
>> +        __entry->tag, __entry->hwq_id, __entry->transfer_len,
>> +        __entry->intr, __entry->lba, (u32)__entry->opcode,
>> +        str_opcode(__entry->opcode), (u32)__entry->group_id,
>> +        __entry->sq_tail, __entry->cq_head, __entry->cq_tail
>> +    )

Best Regards,

Ziqi

