Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADDB5FB01F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 12:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiJKKFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 06:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJKKFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 06:05:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A1A25C42
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 03:05:02 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29B8sWaB022147;
        Tue, 11 Oct 2022 10:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=531PP2slAzevmF8cBzq78LE4QxMYe3eymOF5fHWH9cM=;
 b=WC0/AsWWR46u3dgfi3rQfWfjhA1cpFGJ4WC1XIHTWEUKr05FKmkGqLoGE41aXkCiEpKm
 wQoiEyuLuP/yaasgEPCh7uxI1XeAsC1z//meVxrfVzLa6I+sNweji7MXPUqR2TBjkyfm
 lD8h/5yf4xLfnaVWzzJ7cK5dmyNfUfC0UTHx2/Ga1Z206FF2xNjjMV8elneQ+K+hzAfM
 cyS73qm1p1FsfQ6gtZ4FFakH7i47JNIRDvIs68xo0VyOoSN0FJHhjZfdmQ+DEyQCSb6m
 ATvQvESyZjW94tFCM8rlMU9IHbAATWeOYkeFg1csW1U0uk36o5/Xg4zrI2mpFfzuUXHZ JQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k4rxc9quq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 10:04:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29BA4qU3021902
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 10:04:52 GMT
Received: from [10.216.14.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 11 Oct
 2022 03:04:50 -0700
Message-ID: <b1de7e87-9590-3aad-d62b-167a7685746a@quicinc.com>
Date:   Tue, 11 Oct 2022 15:34:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Query regarding "firmware: arm_scmi: Free mailbox channels if
 probe fails"
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     <sudeep.holla@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <quic_rgottimu@quicinc.com>
References: <cfa26ff3-c95a-1986-58fc-b49fc9be49d5@quicinc.com>
 <Yyx3IAcMX309QEjB@e120937-lin> <Yyx/DKcc7XupQmnx@e120937-lin>
 <c81540cc-e485-0c45-9e4e-248d3279e1ea@quicinc.com>
 <YzriGCLf+MFNGO2n@e120937-lin>
Content-Language: en-US
From:   Shivnandan Kumar <quic_kshivnan@quicinc.com>
In-Reply-To: <YzriGCLf+MFNGO2n@e120937-lin>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mTi2pUms4kXM99u23PKxuV3NuS55JEUX
X-Proofpoint-GUID: mTi2pUms4kXM99u23PKxuV3NuS55JEUX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-11_03,2022-10-10_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210110056
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Cristian,

 >>Ok, just out of curiosity, once done, can you point me at your 
downstream public sources so I can see the issue and the fix that you 
are applying to your trees ?

https://source.codeaurora.org/quic/la/kernel/msm-5.10/tree/drivers/soc/qcom/qcom_rimps.c?h=KERNEL.PLATFORM.1.0.r1-07800-kernel.0

I have added lock while accessing con_priv inside irq handler and 
shutdown function.


I have one input regarding timeout from firmware, can we enable BUG on 
response  time out in function do_xfer based on some debug config 
flag,this will help to debug firmware timeout issue faster.

We will only enable that config flag during internal testing.


Thanks,

Shivnandan

On 10/3/2022 6:52 PM, Cristian Marussi wrote:
> On Fri, Sep 30, 2022 at 06:29:02PM +0530, Shivnandan Kumar wrote:
>> hi Cristian,
> Hi Shivnandan,
>> Thanks for your support in providing the patch to try.
>>
>> I found one race condition in our downstream mbox controller driver while
>> accessing con_priv, when I serialized access to this, issue is not seen on 3
>> days of testing.
> Good to hear that you find the issue.
>
>> As you rightly mentioned that your provided patch will impact all the other
>> users.
>>
>> Also if  we take your provided patch, same race still exists while accessing
>> con_priv in our downstream mbox controller so this issue will still be
>> there.
>>
> Yes indeed, even though I think that race in the mailbox core between RX path
> and chan_free could still be theoretically possible it does not seem to me
> appropriate to try to fix it now that you cannot reproduce it anymore and
> no other mailbox user has ever raised this concern (even though, as said, the
> proper solution to that race wont probably be directly in the mailbox-core as
> in my experimental two liners..)
>
>> So, we are planning to merge the patch( serialized access to con_priv) in
>> our downstream mbox controller now.
>>
> Ok, just out of curiosity, once done, can you point me at your downstream public
> sources so I can see the issue and the fix that you are applying to your trees ?
>
> Thanks,
> Cristian
