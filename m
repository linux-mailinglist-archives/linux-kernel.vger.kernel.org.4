Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DFD67AA4B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 07:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbjAYG1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 01:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjAYG1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 01:27:16 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412222D172;
        Tue, 24 Jan 2023 22:27:15 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30P5vmrE011898;
        Wed, 25 Jan 2023 06:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=E/bj1lHKr0Odd8XiV5lIZb/kA2JXlUbLazrJUTFc+Ds=;
 b=StoJVWkw3CzekS1n8Ur8uo5nmtB8BqwrP6dx+9xNLi4CxrGVZUd7Kp3yVEZcI5jHB49N
 YLhCsyenI2I80xyU5hgW5rB1NXi5Uxothxho//ydNODan8+/rOmUJN3nlAtx0QTluco4
 d3sNj26ru1ALJxukmuQsxfm6rJJi7eGwfp2pVMIZ89H86h/xHmTpo1BMGNBCD/gytaWc
 B9ODklUjIYGCXmG50kolO3VBr97OLZvNGBfFL/oPQbUBQkmURxVzMVXgJMLVB0IY8Rqn
 qDLHhRtH4nxA8HM2OYyFdN9sftm4k6MO27MOag9lQqbverBlqRae6MaK69798lejcvsE rA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89hk6jjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 06:27:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30P6RAWD011114
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 06:27:10 GMT
Received: from [10.110.119.13] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 22:27:09 -0800
Message-ID: <7d2b42ec-d149-626e-c848-2b2c7edbad93@quicinc.com>
Date:   Tue, 24 Jan 2023 22:27:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] rpmsg: glink: Release driver_override
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:REMOTE PROCESSOR MESSAGING (RPMSG) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230109223818.1706292-1-quic_bjorande@quicinc.com>
 <dc0e1609-a872-08e7-2801-0ece573181ad@quicinc.com>
 <20230118175042.GA3322341@hu-bjorande-lv.qualcomm.com>
From:   Chris Lew <quic_clew@quicinc.com>
In-Reply-To: <20230118175042.GA3322341@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KPbgFYIZ565OQlIeeMhpIBQHvBCfjBwc
X-Proofpoint-ORIG-GUID: KPbgFYIZ565OQlIeeMhpIBQHvBCfjBwc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_02,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 impostorscore=0 spamscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250058
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/2023 9:50 AM, Bjorn Andersson wrote:
> On Tue, Jan 17, 2023 at 05:01:01PM -0800, Chris Lew wrote:
>>
>>
>> On 1/9/2023 2:38 PM, Bjorn Andersson wrote:
>>> Upon termination of the rpmsg_device, driver_override needs to be freed
>>> to avoid leaking the potentially assigned string.
>>>
>>> Fixes: 42cd402b8fd4 ("rpmsg: Fix kfree() of static memory on setting driver_override")
>>> Fixes: 39e47767ec9b ("rpmsg: Add driver_override device attribute for rpmsg_device")
>>> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>>> ---
>>>    drivers/rpmsg/qcom_glink_native.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
>>> index 8620eea1dc8a..046271e439c5 100644
>>> --- a/drivers/rpmsg/qcom_glink_native.c
>>> +++ b/drivers/rpmsg/qcom_glink_native.c
>>> @@ -1454,6 +1454,7 @@ static void qcom_glink_rpdev_release(struct device *dev)
>>>    {
>>>    	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
>>> +	kfree(rpdev->driver_override);
>>
>> I see in Krzysztof's original patch to fix up the driver_override we do
>> kfree in other areas of rpmsg.
>>
> 
> Right, in the original patch what became driver_set_override() was open
> coded and hence there was a kfree().
> 
>> More of a just curious as to why don't we use the driver_set_override
>> function to clear the string? It's mentioned in the rpmsg header that the
>> helper should be used.
>>
>> --- include/linux/rpmsg.h
>>   * @driver_override: driver name to force a match; do not set directly,
>>   *                   because core frees it; use driver_set_override() to
>>   *                   set or clear it.
>>
> 
> Looking around the kernel, just calling kfree() in the release function
> seems to be how others are doing it as well. As such I presume that
> comment applies to the runtime state, rather than while we're cleaning
> things up.
> 
> Regards,
> Bjorn
> 

Got it - should be safe to follow how others are handling this in cleanup.

Reviewed-by: Chris Lew <quic_clew@quicinc.com>

>>>    	kfree(rpdev);
>>>    }
>>> @@ -1697,6 +1698,7 @@ static void qcom_glink_device_release(struct device *dev)
>>>    	/* Release qcom_glink_alloc_channel() reference */
>>>    	kref_put(&channel->refcount, qcom_glink_channel_release);
>>> +	kfree(rpdev->driver_override);
>>>    	kfree(rpdev);
>>>    }
>>>
