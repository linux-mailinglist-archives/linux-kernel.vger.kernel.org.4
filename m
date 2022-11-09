Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923A162247D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 08:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiKIHNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 02:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiKIHNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 02:13:15 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF9D1EC5A;
        Tue,  8 Nov 2022 23:13:12 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A96jRIX010936;
        Wed, 9 Nov 2022 07:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=g8RahjOIHtnUr3YD67XYH2Fp3rXTDCOsyvpeEo9ChQU=;
 b=Hz7G4ESeVxJlvbj6QewqRAYX8vFyygzjdqa4LripMiAIUyfHcvXs4eFpMnR3WgIKhVAz
 GXBap7xWiuEcLmHjLEp3q/XLWkdLDNUoMA0h+tPNT3CXj70qGllE6sSYPQT5W22mWN8L
 i8L3tFVhMPnQMECVt7QNGgvMoRW3YAA8ha2TJvWzxYl2eo6p2cJA6lU5i2ql3UQ0rTpP
 R7YX37JAzOhqNaHl1lqtcs1coLhEAXVjo7bYD5Mez8nqubH3tsx2bk6ooWy0XeJiu9Bs
 U2ARK7tsIZZCY9zCui/0NgXygUOTWp7QlbmDHl5VAzFovIYFKb+9VjLQfBO3UTWNEzTA xQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kr6b4073f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 07:13:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A97D0gt003853
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Nov 2022 07:13:00 GMT
Received: from [10.79.43.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 8 Nov 2022
 23:12:56 -0800
Message-ID: <d84bd07e-e243-98a3-bbe0-9a61e326c5d9@quicinc.com>
Date:   Wed, 9 Nov 2022 12:42:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC 2/2] firmware: arm_scmi: Add SCMI QTI Memlat vendor protocol
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <cristian.marussi@arm.com>,
        <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>, <quic_avajid@quicinc.com>,
        <Souvik.Chakravarty@arm.com>
References: <1667451512-9655-1-git-send-email-quic_sibis@quicinc.com>
 <1667451512-9655-3-git-send-email-quic_sibis@quicinc.com>
 <20221103102444.c5ngcxupohwdzntf@bogus>
 <20221103103726.kdepm7jeb2gnncnb@bogus>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20221103103726.kdepm7jeb2gnncnb@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: O-iIeNTz3GkvzQO7TeYA17dZ8C7PklfW
X-Proofpoint-ORIG-GUID: O-iIeNTz3GkvzQO7TeYA17dZ8C7PklfW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_02,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211090056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Sudeep,

Thanks for taking time to review the series.

On 11/3/22 16:07, Sudeep Holla wrote:
> On Thu, Nov 03, 2022 at 10:24:44AM +0000, Sudeep Holla wrote:
>> On Thu, Nov 03, 2022 at 10:28:32AM +0530, Sibi Sankar wrote:
>>> Add support for the SCMI QTI memlat (memory latency) vendor protocol.
>>> The QTI memlat vendor protocol takes in several tuneables including the
>>> IPM ratio (Instructions Per Miss), bus bandwidth requirements and PMU
>>> maps to enable frequency scaling of various buses (L3/LLCC/DDR) performed
>>> by the memory latency governor running on the CPUSS Control Processor.
>>>
>>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>>> ---
>>>   drivers/firmware/arm_scmi/Kconfig              |  10 +
>>>   drivers/firmware/arm_scmi/Makefile             |   1 +
>>>   drivers/firmware/arm_scmi/qcom_memlat_vendor.c | 269 +++++++++++++++++++++++++
>>>   include/linux/scmi_protocol.h                  |  36 ++++
>>>   4 files changed, 316 insertions(+)
>>>   create mode 100644 drivers/firmware/arm_scmi/qcom_memlat_vendor.c
>>>
>>> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
>>> index a14f65444b35..814a3fc37dc1 100644
>>> --- a/drivers/firmware/arm_scmi/Kconfig
>>> +++ b/drivers/firmware/arm_scmi/Kconfig
>>> @@ -136,6 +136,16 @@ config ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
>>>   
>>>   endif #ARM_SCMI_PROTOCOL
>>>   
>>> +config QTI_SCMI_MEMLAT_PROTOCOL
>>> +	tristate "Qualcomm Technologies, Inc. SCMI MEMLAT vendor Protocol"
>>> +	depends on ARM_SCMI_PROTOCOL && QCOM_CPUCP_MBOX
>>
>> If you have set the transport correctly, there should be no need for any
>> such dependency.

ack

>>
>>> +	help
>>> +	  The SCMI QTI memlat vendor protocol adds support for the frequency
>>> +	  scaling of buses (L3/LLCC/DDR) by the QTI HW memlat governor running
>>> +	  on the CPUSS Control Processor (CPUCP).
>>> +
>>> +	  Say Y here if you want to build this driver.
>>> +
>>
>> I don't think it is scalable to have a config option for each vendor+protocol
>> Kconfig. IMO just one config for all qcom vendor protocol please.

ditto

>>
> 
> Sorry pressed send too early before I could write the main part :(.
> Can you please also add the driver using this protocol in the next revision.
> What framework does that fit in ? Devfreq ? I am very much interested in
> that as it helps in distributing the responsibility across these correctly.
> I think that could be one of the reason I don't like all the information
> dump you have in the DT binding proposed in the provider node. It needs to
> move out but in order to understand where to, we need full picture here.
> So please provide the same.
> 

As of now it would just be a simple SoC platform driver which passes on
the tuneables and starts the memlat governor on the SCP firmware. I'll
include it in the next re-spin.


> Also it doesn't hurt to describe in detail: what theses "several tuneables"
> are and where are they expected to arrive from or targeted to ?

ack

> Is CPUSS Control Processor responsible for CPU DVFS or not ?
> Does it just control DVFS of L3/LLCC and DDR or is there a bigger list ?

CPUSS CP is responsible for CPU DVFS but it's not done through
SCMI (it's done through the qcom-cpufreq-hw driver). Memory latency
protocol is meant to control the DVFS of memory buses. So it could
be one or all of them and the supported list for that particular
SoC was meant to be passed through the qcom,bus-type array as
described in the bindings.

- Sibi

> All these information matters as your current DT proposal seem to be
> tightly coupled with only few of these.
> 
> --
> Regards,
> Sudeep
