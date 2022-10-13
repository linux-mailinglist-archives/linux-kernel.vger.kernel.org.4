Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2E25FD970
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiJMMpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJMMpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:45:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC30EC518;
        Thu, 13 Oct 2022 05:45:45 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29DCeiIK031317;
        Thu, 13 Oct 2022 12:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=x4cDAWwTdbIxERlfUArQEX1yqFkrDe+/Si6r20vmSOA=;
 b=S7NXmI5FPfZNu/KGEAoiVYMTjyWwBsWaHQXYN73Yb+3n4aD6Ob1kqxoXlR8kBZm1aCmB
 bkvBkNajw1ElvhViNkPVgoLi4vCwslZjfxc4IPuJ2xAQ/Kld9DzfbV/5QzD6114ZtbMR
 iJu/jXBUNQyf9klJAdi+V0249XZd4uUMMbym8kfqAIMu6aSQD2C6Pt5l0iHSxmxzVb85
 +NiT9SgHnNkYcBv6FCizsl1i3fUV0SOPbz/LDSK7dizJUibezvZ5ml8M0lPR97Z1Simq
 043bZj6od11tN9sWpxJvAUUBQhylp1SG/iHkSu1VKrmva8gi2RdEnoe/Rk4FS4NjOS7Q uQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k6br7s0v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 12:45:35 +0000
Received: from nasanex01c.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29DCjYAd031712
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 12:45:34 GMT
Received: from [10.216.35.42] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 13 Oct
 2022 05:45:31 -0700
Message-ID: <c4046ec3-6832-9167-30a8-dfb1dc3139fc@quicinc.com>
Date:   Thu, 13 Oct 2022 18:15:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] remoteproc: core: Auto select rproc-virtio device id
Content-Language: en-US
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shengjiu.wang@gmail.com>
References: <1665628087-20829-1-git-send-email-shengjiu.wang@nxp.com>
 <154222f3-39e4-a545-d820-fc3d6a8b2ab6@foss.st.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <154222f3-39e4-a545-d820-fc3d6a8b2ab6@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2D1730j9BGlbKr5G5Lf_v62o3QZAi3-Y
X-Proofpoint-ORIG-GUID: 2D1730j9BGlbKr5G5Lf_v62o3QZAi3-Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_08,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1011 spamscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210130075
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/13/2022 1:57 PM, Arnaud POULIQUEN wrote:
> Hi Shengju,
> 
> On 10/13/22 04:28, Shengjiu Wang wrote:
>> With multiple remoteproc device, there will below error:
>>
>> sysfs: cannot create duplicate filename '/bus/platform/devices/rproc-virtio.0'
> 
> Good catch!
> Previously the device created was
> /sys/class/remoteproc/remoteproc0/remoteproc0#vdev0buffer/
> 
> So with your fix it become something like
> /bus/platform/devices/rproc-virtio.2.auto
> 
> 
> This works fine on my platform, also when creating two virtio devices for one
> remoteproc device.
>   
> Just a remark, could be nice to indicate in the commit message the result of
> your patch, means the name of the files created.

Agree with the suggestion of putting the output in commit message.

LGTM.
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

> 
> With that:
> Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> 
> Thanks,
> Arnaud
> 
> 
>>
>> The rvdev_data.index is duplicate, that cause issue, so
>> need to use the PLATFORM_DEVID_AUTO instead.
>>
>> Fixes: 1d7b61c06dc3 ("remoteproc: virtio: Create platform device for the remoteproc_virtio")
>> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>> ---
>>   drivers/remoteproc/remoteproc_core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>> index 8768cb64f560..03a26498e879 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -509,7 +509,7 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
>>   	rvdev_data.rsc_offset = offset;
>>   	rvdev_data.rsc = rsc;
>>   
>> -	pdev = platform_device_register_data(dev, "rproc-virtio", rvdev_data.index, &rvdev_data,
>> +	pdev = platform_device_register_data(dev, "rproc-virtio", PLATFORM_DEVID_AUTO, &rvdev_data,
>>   					     sizeof(rvdev_data));
>>   	if (IS_ERR(pdev)) {
>>   		dev_err(dev, "failed to create rproc-virtio device\n");
