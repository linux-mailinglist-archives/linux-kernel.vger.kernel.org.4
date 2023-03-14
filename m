Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE336B8EE2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCNJkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCNJkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:40:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D8021292;
        Tue, 14 Mar 2023 02:40:06 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32E3Y1nI013689;
        Tue, 14 Mar 2023 09:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=M9xKy/8yo2UJKxTJy7iMWhvOIWBeXFv18E8f9hp8k0U=;
 b=Ytt0WSNGGQIaKmKHLp2t58Qkx9SKzMkx4/DtNXYFeJzNab2NaUbSfK6zu27pk3QXp3s0
 itvnyKyTQ+tAHMFA48Ta05lzN8pKPlc1bmx4UQBo2CYBzAO8kpYHuci+N5GlQ0lZr6FM
 fs+hWtqFeIwjL1HSgQOW0Yir7GqIJuYB/lQ+zLd+L1Yr6v/XuRX6gfloc6DlZgWyZkwF
 pD550bgY7DPO8fXctIT16BvzVBhqcb4X+8RkWcpAhOuvRArQ+p+DNNbjeIwxT/m/ICDB
 4l1v70uGk6llxGUp9BAui2awtGbRH9rjfEigJH1ajDHnOPoasUp6IAtmuJNirxx06HFr Ig== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pa6n32fgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 09:34:18 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32E9YHB5010446
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 09:34:17 GMT
Received: from [10.239.155.136] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 14 Mar
 2023 02:34:13 -0700
Message-ID: <26b84239-3b52-6e42-2d17-a34933cab13e@quicinc.com>
Date:   Tue, 14 Mar 2023 17:34:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5] scsi: ufs: core: Add trace event for MCQ
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
References: <1678699023-6645-1-git-send-email-quic_ziqichen@quicinc.com>
 <5ee20e75-8a61-be89-5302-45f390a0cbd6@acm.org>
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
In-Reply-To: <5ee20e75-8a61-be89-5302-45f390a0cbd6@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _gJlGZCi3m2dyS7YHXGDaCKqobbuTDjQ
X-Proofpoint-GUID: _gJlGZCi3m2dyS7YHXGDaCKqobbuTDjQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_03,2023-03-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303140081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Bart, will address your comments and update new version V6 soon.

Best Regards,
Ziqi

On 3/14/2023 5:09 AM, Bart Van Assche wrote:
> On 3/13/23 02:16, Ziqi Chen wrote:
>> Added a new trace event to record MCQ relevant information
>> for each request in MCQ mode, include hardware queue ID,
>> SQ tail slot, CQ head slot and CQ tail slot.
> 
> Added a new trace event ... -> Add the MCQ information in the existing 
> trace event ...
> 
>  From Documentation/process/submitting-patches.rst: "Describe your 
> changes in imperative mood, e.g. "make xyzzy do frotz"".
> 
>> Changes to v1:
>> - Adjust the order of fileds to keep them aligned.
>                          ^^^^^^
>                          fields?
> 
>> -    u32 intr, doorbell;
>> +    u32 doorbell = 0, hwq_id = 0;
>> +    u32 intr;
> 
> Since hwq_id can be assigned the value -1, shouldn't its type be changed 
> from u32 into int, int16_t or int32_t?
> 
>> +    struct ufs_hw_queue *hwq = NULL;
> 
> Is this pointer only used inside one branch of the if-statement below? 
> If so, can it be moved under "if (is_mcq_enabled(hba)) {"?
> 
>> +        "%s: %s: tag: %u, DB: 0x%x, size: %d, IS: %u, LBA: %llu, 
>> opcode: 0x%x (%s), group_id: 0x%x, hqid: %d",
> 
> Consider changing "hqid" into "hwq_id" to make the trace information 
> easier to understand.
> 
> Thanks,
> 
> Bart.
