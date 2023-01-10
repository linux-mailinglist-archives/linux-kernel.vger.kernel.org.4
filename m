Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D2A663EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjAJLCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238597AbjAJLA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:00:28 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551D913D7B;
        Tue, 10 Jan 2023 02:58:11 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30A9sFa9016218;
        Tue, 10 Jan 2023 10:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dCbu8nMS+yxccJ8cjuGam6hyXa4XDby9jldchqH27mc=;
 b=diTBPUAtIsK3dY1+xxeFFvc80AIjjbzvA4P/H/OH0huIWJ1Fk+B+8XgXodJBRIvuMg9O
 Io+LJF8Y6ah6byFHvgZrburPij3AfwhiC/mMihzWlmRwtwLmyRHODkxGN6RAcGqFjeLx
 Jj6NegstlPZXpRIH0Ah5fUY5FB5/sk7BXHH9vlJIwajTVRsQkJpjusR+FCsFb/jyjWuK
 YbKwKDJTJNSGuqISY22pOdGTbX+spRs7hZ3ICcaGrp7Qq49kp7C/1cv23mpdtfK10Tp6
 cC8g0l1Q5FkhOXTq3GLXaZpkDR3X0iGhInMfddsGaQYDxMSTxZtGoxnOJXLa39eNJSWA lg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n13cngf3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 10:58:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30AAw36N022553
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 10:58:03 GMT
Received: from [10.50.61.82] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 10 Jan
 2023 02:58:01 -0800
Message-ID: <47278c99-0137-83f7-cf15-718b630450a7@quicinc.com>
Date:   Tue, 10 Jan 2023 16:27:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V0 1/1] bootconfig: Increase max size of bootconfig from
 32 KB to 256 KB for DCC support
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1673261071.git.quic_schowdhu@quicinc.com>
 <654357bcbfd3974072a558c494a51edafaa73e1a.1673261071.git.quic_schowdhu@quicinc.com>
 <20230109150951.ikdlkr6lmiapesmu@builder.lan>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <20230109150951.ikdlkr6lmiapesmu@builder.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gt9WbqnP_AJHqf3yNRt5AesTU9xiCfcz
X-Proofpoint-GUID: gt9WbqnP_AJHqf3yNRt5AesTU9xiCfcz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_03,2023-01-10_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100066
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/2023 8:39 PM, Bjorn Andersson wrote:
> On Mon, Jan 09, 2023 at 08:01:05PM +0530, Souradeep Chowdhury wrote:
>> Increasing the memory size of bootconfig to be able to handle a max number of
>> 8192 nodes to be fitted in memory size of 256KB.
>>
> 
> This states what the patch does, but not why.
> 
> The description you put in the cover letter does capture the why, but
> the cover-letter won't be part of the git history (and if it was,
> there's no reason to keep the motivation separate from the change). So
> please move the motivation into the commit message.
> 
> Also, there's generally no reason to have a cover-letter for a
> single patch "series". So please skip the --cover-letter.
> 
> Regards,
> Bjorn

Ack

> 
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
