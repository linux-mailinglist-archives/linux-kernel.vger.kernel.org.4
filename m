Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6F85F4CDD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 01:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiJDXxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 19:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJDXxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 19:53:50 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3755F7C6;
        Tue,  4 Oct 2022 16:53:49 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294NjQZN021822;
        Tue, 4 Oct 2022 23:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7sIaGt5RW6txQtkzPaHVb28p1gFIFEWXixdkRB8Zcys=;
 b=ozcZqgsI5PZE8TxZbC7nq2S/U4nr0+50sJGzgMRifBnu1MwP7KmkSodRynPLPBZzZE/m
 4bz9uco0MYliO4hWRa+3ZC0qi9fDh1up4/kBPCv42P6ttxHCJdtNzO583TQvqlf5z0vn
 4hP48dUV9IVP+7Vvc/ITvjXRfMnJeCbSq8ArORs8bMn3mrZeg79XGJqvatHkn+prsreD
 8P+2tyCfSyc+ByOj157qClVhtRnu1uZds1xTtkvLkSgPGJXcOVgFFYfgdihlxdXteaIf
 cn/9ZJct6NUxUHIAiABXjgtnEuTlNKBS816lL1zXZUtjUCINyQy6Vu4ukq5viz6u8iWW 3g== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k0syqrg7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 23:53:36 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 294NrZYA009612
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Oct 2022 23:53:35 GMT
Received: from [10.110.114.145] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 16:53:34 -0700
Message-ID: <7f161062-fe7a-05a0-2719-c92ab58f5ac6@quicinc.com>
Date:   Tue, 4 Oct 2022 16:53:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH v4 10/14] gunyah: sysfs: Add node to describe supported
 features
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Will Deacon" <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Arnd Bergmann" <arnd@arndb.de>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
 <20220928195633.2348848-11-quic_eberman@quicinc.com>
 <YzbbxuInZwILaflH@kroah.com>
Content-Language: en-US
In-Reply-To: <YzbbxuInZwILaflH@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DYtvgx6IWL7muc7U4wXzwIhgWLIMmbuw
X-Proofpoint-ORIG-GUID: DYtvgx6IWL7muc7U4wXzwIhgWLIMmbuw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_09,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=822 mlxscore=0 phishscore=0 impostorscore=0 suspectscore=0
 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040153
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/2022 5:06 AM, Greg Kroah-Hartman wrote:
> On Wed, Sep 28, 2022 at 12:56:29PM -0700, Elliot Berman wrote:
>> Add a sysfs node to list the features that the Gunyah hypervisor and
>> Linux supports. For now, Linux support cspace (capability IDs) and
>> message queues, so only report those..
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   Documentation/ABI/testing/sysfs-hypervisor-gunyah | 15 +++++++++++++++
>>   drivers/virt/gunyah/sysfs.c                       | 15 +++++++++++++++
>>   2 files changed, 30 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-hypervisor-gunyah b/Documentation/ABI/testing/sysfs-hypervisor-gunyah
>> index 7d74e74e9edd..6d0cde30355a 100644
>> --- a/Documentation/ABI/testing/sysfs-hypervisor-gunyah
>> +++ b/Documentation/ABI/testing/sysfs-hypervisor-gunyah
>> @@ -1,3 +1,18 @@
>> +What:		/sys/hypervisor/gunyah/features
>> +Date:		October 2022
>> +KernelVersion:	6.1
>> +Contact:	linux-arm-msm@vger.kernel.org
>> +Description:	If running under Gunyah:
>> +		Space separated list of features supported by Linux and Gunyah:
>> +		"cspace": Gunyah devices
>> +		"doorbell": Sending/receiving virtual interrupts via Gunyah doorbells
>> +		"message-queue": Sending/receiving messages via Gunyah message queues
>> +		"vic": Interrupt lending
>> +		"vpm": Virtual platform management
>> +		"vcpu": Virtual CPU management
>> +		"memextent": Memory lending/management
>> +		"trace": Gunyah hypervisor tracing
> 
> Please no.  Why do you really need this type of list?  What hypervisor
> will NOT have them all present already?  Who will use this file and what
> will it be used for?
> 
> sysfs files should just be 1 value and not need to be parsed.  Yes, we
> have lists of features at times, but really, you need a very very good
> reason why this is the only way this information can be exposed and who
> is going to use it in order to be able to have this accepted.
> 


We're currently at phase where all the features implemented so far as 
considered part of the "base" featureset. We're thinking of future 
features implemented in Gunyah: userspace might need to know that some 
hypervisor feature is present and that it should make use of the feature 
instead of some fallback behavior.

I can drop this and it should be OK IMO to introduce it later if needed. 
The lack of the "gunyah/features" node would be sufficient for a 
userspace program to know that some new feature isn't present.

> thanks,
> 
> greg k-h
