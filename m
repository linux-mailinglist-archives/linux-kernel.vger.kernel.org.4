Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEAE7254C0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbjFGGvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbjFGGvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:51:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509A41723;
        Tue,  6 Jun 2023 23:51:42 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3576KkIl024132;
        Wed, 7 Jun 2023 06:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DsxBAKx4WHu+Q0N5iregZCEQLAY8TuE8zUdpOTxCj38=;
 b=CwTxxf3EbFBLZYw3z6afwRbzXqPvo6FD6RopMwWEpmD29SBUV3lrY61ZFK1wiv1CCHFL
 4i/hEYaZ7BVucnbtoWpmZABC2GVHvnITteWe8+oBrYT2+NTPwtT+6vP9ZKdaHXONqiaM
 yyhmabODo4K1tSOQ1vfP2GOR2csa4eVyW9avnQNIGRrKfXYfN3OjdE7YRnnak8Ypm2jH
 JzrDUZlYSLI7tmv+HmYeyqnEHq1cPZfkgn8FII0FKX4/7TxF+MfsszXiKJrJGBt86i4f
 qJ/5JvVj3ilLLwS3YykgzX/NXwEbq9FkOT6l1YHlzIgODNpFOwpchhLS5VEQiaUcKGw3 /A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a76958x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 06:51:39 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3576pd0T028839
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 06:51:39 GMT
Received: from [10.204.67.150] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 6 Jun 2023
 23:51:36 -0700
Message-ID: <8752ee8f-c61a-b42d-f68f-8faa141d9294@quicinc.com>
Date:   Wed, 7 Jun 2023 12:21:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1] misc: fastrpc: Collect driver-remote processor
 transaction logs
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <ekangupt@qti.qualcomm.com>, <linux-kernel@vger.kernel.org>,
        <bkumar@qti.qualcomm.com>, <fastrpc.upstream@qti.qualcomm.com>
References: <1686070555-11154-1-git-send-email-quic_ekangupt@quicinc.com>
 <2023060608-junction-conclude-f607@gregkh>
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
In-Reply-To: <2023060608-junction-conclude-f607@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uBBiAtc43R7Jv_-jfQA8RfRkyvS_l60z
X-Proofpoint-GUID: uBBiAtc43R7Jv_-jfQA8RfRkyvS_l60z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_04,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306070055
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/6/2023 11:12 PM, Greg KH wrote:
> On Tue, Jun 06, 2023 at 10:25:55PM +0530, Ekansh Gupta wrote:
>> Add changes to collect driver-remote processor rpmsg transaction
>> logs. These logs will carry payload information for the rpmsg message
>> instance. These logs are channel specific and are collected in
>> channel context structure.
>>
>> These rpmsg transaction logs can help in improving debugability as
>> all requests from processes are getting captured in channel context
>> structure.
>>
>> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
>> ---
>>   drivers/misc/fastrpc.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 88 insertions(+)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 30d4d04..6447cee 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -104,6 +104,9 @@
>>   
>>   #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
>>   
>> +/* Length of glink transaction history to store */
>> +#define GLINK_MSG_HISTORY_LEN	(128)
>> +
>>   static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
>>   						"sdsp", "cdsp"};
>>   struct fastrpc_phy_page {
>> @@ -181,6 +184,28 @@ struct fastrpc_invoke_rsp {
>>   	int retval;		/* invoke return value */
>>   };
>>   
>> +struct fastrpc_tx_msg {
>> +	struct fastrpc_msg msg;	/* Msg sent to remote subsystem */
>> +	int rpmsg_send_err;	/* rpmsg error */
>> +	s64 ns;			/* Timestamp (in ns) of msg */
>> +};
>> +
>> +struct fastrpc_rx_msg {
>> +	struct fastrpc_invoke_rsp rsp;	/* Response from remote subsystem */
>> +	s64 ns;		/* Timestamp (in ns) of response */
>> +};
>> +
>> +struct fastrpc_rpmsg_log {
>> +	u32 tx_index;	/* Current index of 'tx_msgs' array */
>> +	u32 rx_index;	/* Current index of 'rx_msgs' array */
>> +	/* Rolling history of messages sent to remote subsystem */
>> +	struct fastrpc_tx_msg tx_msgs[GLINK_MSG_HISTORY_LEN];
>> +	/* Rolling history of responses from remote subsystem */
>> +	struct fastrpc_rx_msg rx_msgs[GLINK_MSG_HISTORY_LEN];
>> +	spinlock_t tx_lock;
>> +	spinlock_t rx_lock;
> 
> Why roll your own ring-buffer logic instead of using one of the many
> offerings that the kernel already provides for you?
> 
Thanks for your suggestion, Greg. I'm looking into using kernel offered
ring-buffer logic and I'll update it in v2.
> thanks,
> 
> greg k-h
