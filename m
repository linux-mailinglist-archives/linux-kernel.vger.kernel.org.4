Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1804C718FC2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 02:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjFAAz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 20:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjFAAz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 20:55:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFB312B;
        Wed, 31 May 2023 17:55:55 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3510fvof002832;
        Thu, 1 Jun 2023 00:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=bvuLLMRXfFK2/Zw/BcyuOeZgQFDiq7X3IIAWCop0yuo=;
 b=ku6zt+CCfxb/cN1vtZAyS06qo2MP+NzzkRkW6a9s6Tqp9OVTSGsggnX3A8sbnJJq3NV1
 px1AbCZlGFTJHTcfFZ8ZbtgEfnRyIJbn/FybaDZWsO+3hQ8HfOytI0zkjt7tXwcPXxNP
 iWiXpz7nWBHVYYi1C88FfVs9Uz99KTmZ1Uv5+r6QsER1A4QesTMOyBqYx1aigIlKFgJR
 lCj15nVQZAtEIGkwXzvVXjSuDspKqOixCdlzyRv/BzrSlsNxB6IQX3SxtSqmtSejwJ4S
 LDcJfYkI5rX4J4vVnVg6dlRxdKxZiSFXQZqBDVk7YvXVmelpQK7E4ppVPl1LuaRgQlio 4w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxc798hgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 00:55:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3510tkQf016235
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 00:55:46 GMT
Received: from [10.71.110.156] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 31 May
 2023 17:55:46 -0700
Message-ID: <98ffc5cd-7129-3128-1f83-d66b4fc8c78a@quicinc.com>
Date:   Wed, 31 May 2023 17:55:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v4 1/2] remoteproc: Introduce traces for remoteproc events
Content-Language: en-US
To:     Trilok Soni <quic_tsoni@quicinc.com>,
        <linux-remoteproc@vger.kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        "Satya Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>
References: <cover.1685486994.git.quic_gokukris@quicinc.com>
 <5c1744bc362fbc80615349f12c18c8ab5c4f0a6e.1685486994.git.quic_gokukris@quicinc.com>
 <b332eaf8-2528-ad71-9118-6627bf9ab7c1@quicinc.com>
From:   Gokul Krishna Krishnakumar <quic_gokukris@quicinc.com>
In-Reply-To: <b332eaf8-2528-ad71-9118-6627bf9ab7c1@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -0HWdsSuhOLjI2NaMfA_EkcNpwAsO2Om
X-Proofpoint-ORIG-GUID: -0HWdsSuhOLjI2NaMfA_EkcNpwAsO2Om
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_18,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 mlxlogscore=797
 adultscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010006
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/2023 2:51 PM, Trilok Soni wrote:
> On 5/31/2023 2:28 PM, Gokul krishna Krishnakumar wrote:
>> Adding Traces for the following remoteproc events:
>>     rproc_subdev_event,
>>     rproc_interrupt_event,
>>     rproc_load_event,
>>     rproc_start_event,
>>     rproc_stop_event
>>
>> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
>> ---
>>   drivers/remoteproc/Kconfig                    |   5 +
>>   drivers/remoteproc/Makefile                   |   1 +
>>   drivers/remoteproc/remoteproc_tracepoints.c   |  13 ++
>>   include/trace/events/remoteproc_tracepoints.h | 129 ++++++++++++++++++
>>   4 files changed, 148 insertions(+)
>>   create mode 100644 drivers/remoteproc/remoteproc_tracepoints.c
>>   create mode 100644 include/trace/events/remoteproc_tracepoints.h
>>
>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>> index a850e9f486dd..2ef4f527f1c1 100644
>> --- a/drivers/remoteproc/Kconfig
>> +++ b/drivers/remoteproc/Kconfig
>> @@ -365,6 +365,11 @@ config XLNX_R5_REMOTEPROC
>>         It's safe to say N if not interested in using RPU r5f cores.
>> +config REMOTEPROC_TRACEPOINTS
>> +    bool "Support for Remote Processor subsystem traces"
>> +    help
>> +      Say y to add traces to the remoteproc events.
> 
> More information here please. What information these traces provide? How 
> they can be useful to developers? More text will always be helpful.
> 
Say y to add traces to remoteproc events of interest such as the 
start/stop/crash events in a remote-processor and also sub-device 
stop/start events and there errors.
These traces can be useful while debugging errors with subsystem restart 
and draw an estimate on how long each event takes to run.

> ---Trilok Soni

How does this look.
Thanks,
Gokul
