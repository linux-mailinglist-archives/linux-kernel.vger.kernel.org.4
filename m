Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9345F0C17
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiI3M7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiI3M7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:59:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF01717CCF9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 05:59:17 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28UATAdI022360;
        Fri, 30 Sep 2022 12:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qf42gOQZjnzR+Zu5mNNVox1mp8az222ZElp1ZIW3TJg=;
 b=Rf/DVN/0ZiqpzhS36/6EWAFc0cunYH+RCMrBl+u9iWrGlbYQvqdgd66vXn7PiFBwU43t
 KTQ6ZVsIIkMxCPQfmf5adNYlBcAJ3DnM817e+wf4bMJ5593hqgLNHe9GvQWR88xWIKnv
 Bx8uHsbCmLFYnH30D288REfFk1XZ8d+n/WC1uOnTcb5ctQLFUVdTC4v/b3U8ijkFmIVc
 LuMTW3FIsgrhY6eJcnGIKrM4d0ktJ+ZIEwXOUXU2Jg4YuPQND/28EUm5MzyOmumsvgjW
 rsh+JxXjYYPYvVeSCXgQtytnJo1HcUmG0Wuyxe+xo/fhc61rA2iogMCc4ppXSNKVVKuO 7Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jwqj69ud7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 12:59:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28UCx8Ng009344
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 12:59:08 GMT
Received: from [10.216.38.137] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 30 Sep
 2022 05:59:05 -0700
Message-ID: <c81540cc-e485-0c45-9e4e-248d3279e1ea@quicinc.com>
Date:   Fri, 30 Sep 2022 18:29:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: Query regarding "firmware: arm_scmi: Free mailbox channels if
 probe fails"
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     <sudeep.holla@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_avajid@quicinc.com>
References: <cfa26ff3-c95a-1986-58fc-b49fc9be49d5@quicinc.com>
 <Yyx3IAcMX309QEjB@e120937-lin> <Yyx/DKcc7XupQmnx@e120937-lin>
From:   Shivnandan Kumar <quic_kshivnan@quicinc.com>
In-Reply-To: <Yyx/DKcc7XupQmnx@e120937-lin>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kp9RkQoWs_9oz4tRGd0LYo_tMxF-9gRP
X-Proofpoint-ORIG-GUID: kp9RkQoWs_9oz4tRGd0LYo_tMxF-9gRP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209300083
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Cristian,

Thanks for your support in providing the patch to try.

I found one race condition in our downstream mbox controller driver 
while accessing con_priv, when I serialized access to this, issue is not 
seen on 3 days of testing.

As you rightly mentioned that your provided patch will impact all the 
other users.

Also if  we take your provided patch, same race still exists while 
accessing con_priv in our downstream mbox controller so this issue will 
still be there.

So, we are planning to merge the patch( serialized access to con_priv) 
in our downstream mbox controller now.


Thanks,

Shivnandan


On 9/22/2022 8:58 PM, Cristian Marussi wrote:
> On Thu, Sep 22, 2022 at 03:54:31PM +0100, Cristian Marussi wrote:
>> On Thu, Sep 22, 2022 at 10:31:47AM +0530, Shivnandan Kumar wrote:
>>> Hi Cristian,
>>>
> Hi Shivnandan,
>   
> [snip]
>
>> Looking at the transport layer that you use, mailbox, I see that while
>> setup/free helpers are synchronized on an internal chan->lock, the RX
>> path inside the mailbox core is not, so I tried this:
>>
>>
>> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
>> index 4229b9b5da98..bb6173c0ad54 100644
>> --- a/drivers/mailbox/mailbox.c
>> +++ b/drivers/mailbox/mailbox.c
>> @@ -157,9 +157,13 @@ static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
>>    */
>>   void mbox_chan_received_data(struct mbox_chan *chan, void *mssg)
>>   {
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(&chan->lock, flags);
>>          /* No buffering the received data */
>>          if (chan->cl->rx_callback)
>>                  chan->cl->rx_callback(chan->cl, mssg);
>> +       spin_unlock_irqrestore(&chan->lock, flags);
>>   }
>>   EXPORT_SYMBOL_GPL(mbox_chan_received_data);
>>   
> ...sorry... a small change on the tentative above fix...
>
> ----8<------
>
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index 4229b9b5da98..6fbe183acdae 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -157,9 +157,13 @@ static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
>    */
>   void mbox_chan_received_data(struct mbox_chan *chan, void *mssg)
>   {
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&chan->lock, flags);
>          /* No buffering the received data */
> -       if (chan->cl->rx_callback)
> +       if (chan->cl && chan->cl->rx_callback)
>                  chan->cl->rx_callback(chan->cl, mssg);
> +       spin_unlock_irqrestore(&chan->lock, flags);
>   }
>   EXPORT_SYMBOL_GPL(mbox_chan_received_data);
>
> ------8<-----
>
> Thanks,
> Cristian
>
