Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE700663F93
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbjAJL4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjAJL4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:56:19 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F69A15F1C;
        Tue, 10 Jan 2023 03:56:18 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30A9stBk016840;
        Tue, 10 Jan 2023 11:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=szV5uSi2lewecbhIhUNYInP6JwNl6YUB0TxKUWgBMj8=;
 b=COlt0u4omcrTXpav+cWJ8qbFQw4Fsk/b1pVIf0i7L3/x/LzrJ6wPeiz0x98SWjVb+axa
 83gSpdG3ImWUMwowfF7ONXtVPnUEpufh6efQtWuvkPkJsdkuvPLNV0jYHLONHMRX7Yum
 nbSC3aaCL8oKTk12HQEwKZy2LrZ7dh2QgIjbajiyK+j6l9ddqNqv5osPrqqtyGV0mXc3
 NRvY0YOF7z3rgW3jbkVCxz/mQ6LkiRY5Stg79XgwrTaX0xryrEnzmZuW2dXpmDSczb7b
 MbrFUU5Z6xG3nnLlDzAHsLR5RZ7q6lkb3iUu9aD6f4Ep77aksfrCyrhpjtdVyBAiCWVP mA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n13cngk7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 11:56:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30ABuDqL028238
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 11:56:13 GMT
Received: from [10.50.61.82] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 10 Jan
 2023 03:56:10 -0800
Message-ID: <e2ac0fa4-28f0-f4d8-e02a-b2a5d6131a48@quicinc.com>
Date:   Tue, 10 Jan 2023 17:26:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V0 1/1] bootconfig: Increase max size of bootconfig from
 32 KB to 256 KB for DCC support
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1673261071.git.quic_schowdhu@quicinc.com>
 <654357bcbfd3974072a558c494a51edafaa73e1a.1673261071.git.quic_schowdhu@quicinc.com>
 <20230110001820.5ca81344286f614ed4ccec77@kernel.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <20230110001820.5ca81344286f614ed4ccec77@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -35SDsFvE0ty9eDrUPpPm93SYwHNP34g
X-Proofpoint-GUID: -35SDsFvE0ty9eDrUPpPm93SYwHNP34g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_03,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=986 adultscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100072
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/2023 8:48 PM, Masami Hiramatsu (Google) wrote:
> On Mon, 9 Jan 2023 20:01:05 +0530
> Souradeep Chowdhury <quic_schowdhu@quicinc.com> wrote:
> 
>> Increasing the memory size of bootconfig to be able to handle a max number of
>> 8192 nodes to be fitted in memory size of 256KB.
> 
> Sorry, but you missed the 'xbc_node::data' stores the index of the data and
> that is uint16_t. So the XBC_DATA_MAX is fixed limitation.
> 
> The number of nodes (XBC_NODE_MAX) can be expanded because I just decided it
> to keep the pre-compiled array size ~8KB. Maybe expanding it to 64KB just
> increase the size of kernel on init memory (and freed after boot).
> 
> Could you tell me why you need such a big data for your DCC?
> 
> Thank you,

DCC is a debugging tool used in qcom which is needed to debug crashes
that can happen at boot-time. For debugging purposes a large number of
registers need to be configured in DCC driver which is to be fed via the
bootconfig file. For that we need to expand the nodes as well as memory
for using bootconfig.
Can you let us know the changes that you suggest for doing the same? Is 
it fine to just increase the XBC_NODE_MAX, do we also need to
change the uint16_t to u32 for proper storing of index values?


> 
>>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> ---
>>   include/linux/bootconfig.h | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
>> index 1611f9d..64d233b 100644
>> --- a/include/linux/bootconfig.h
>> +++ b/include/linux/bootconfig.h
>> @@ -55,11 +55,11 @@ struct xbc_node {
>>   } __attribute__ ((__packed__));
>>   
>>   #define XBC_KEY		0
>> -#define XBC_VALUE	(1 << 15)
>> -/* Maximum size of boot config is 32KB - 1 */
>> +#define XBC_VALUE	(1 << 18)
>> +/* Maximum size of boot config is 256KB - 1 */
>>   #define XBC_DATA_MAX	(XBC_VALUE - 1)
>>   
>> -#define XBC_NODE_MAX	1024
>> +#define XBC_NODE_MAX	8192
>>   #define XBC_KEYLEN_MAX	256
>>   #define XBC_DEPTH_MAX	16
>>   
>> -- 
>> 2.7.4
>>
> 
> 
