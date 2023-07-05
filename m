Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC80747FE1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjGEIkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjGEIkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:40:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CDDCA;
        Wed,  5 Jul 2023 01:40:36 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3656XBd5025380;
        Wed, 5 Jul 2023 08:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ZVU0p2+0BQwoe+S8fXe0KYfaEsvDANNRpvCk1y4/8jM=;
 b=KFFrsEI1KHVGRWFO/Xs/j2UtvLRSVkyWABAXp8d4QzQpF56Z1UdusI3gN5OkY6gotqB/
 ialioQsCBDtDDE+nd34m7/uZV5ybo5Kv+ldnF9Pi4w92O7f1r56G3rhkNAinYl/N4yTh
 i3stnfp9pghbWD4da5JhQLve6dI7ctCDHLecTQYnblDPr7u4IZnXT+2T0EaUyVd17aDw
 EjM+EIvrf31rrlV72r+IrCtni/qhKQhzZkWr011wMDIXWg2SeGlpn/rLK0JA6EmcclH9
 Nn576FN8Yvfp+sLG/FqkDNq7WC5FkHpvuhq5jM6jU2OitqdUmr7yV5DCYgS4DBQC9fPP NQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rn2cp8a3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 08:40:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3658eMOt018438
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jul 2023 08:40:22 GMT
Received: from [10.239.133.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 5 Jul
 2023 01:40:18 -0700
Message-ID: <109d67ab-590b-4f9d-f918-fc2ad0d1506f@quicinc.com>
Date:   Wed, 5 Jul 2023 16:39:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 0/3] Add support for a streaming interface for TMC ETR
To:     Mike Leach <mike.leach@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
References: <20230526153508.6208-1-quic_jinlmao@quicinc.com>
 <CAJ9a7VhoMFqzSnvfq=kJzoPbTS3nPenyWPE5t-n9j+G2CL3SGA@mail.gmail.com>
Content-Language: en-US
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <CAJ9a7VhoMFqzSnvfq=kJzoPbTS3nPenyWPE5t-n9j+G2CL3SGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9ppleuBPfc1-ybLrc8pv_kn1lpnn-wma
X-Proofpoint-ORIG-GUID: 9ppleuBPfc1-ybLrc8pv_kn1lpnn-wma
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_16,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1011 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050079
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

Sorry for the late response. Thanks for the comments.

On 5/30/2023 11:11 PM, Mike Leach wrote:
> Hi,
>
> I have a few general comments about this patch set.
>
> Firstly, I am assuming that this is a standard TMC, with the new byte
> monitor functionality implemented in the CSR block.
>
> Now that being the case, all the byte counter operations, the sysfs
> block_size, file ops to read the data and interrupt handling should be
> in the CSR driver, not the TMC driver.
> This counter is not part of a generic TMC device - but a specific
> hardware addition into your system. As such I would expect it to be in
> a separate driver.
>
> The specific enabling of the CSR counters from within the enable code
> of the TMC should be removed. If your device is set up correctly as a
> helper device with appropriate connections between TMC and CSR, then
> the enable operations can be handled automatically using the helper
> function mechnisms added in this patchset:-
> https://lists.linaro.org/archives/list/coresight@lists.linaro.org/thread/2BBWZCBJWP3AOLBJSB64I5727JZFA6QZ/
I will consider to use helper function mechanism for CSR device.
>
> I also see that you are assuming that you will be able to read the TMC
> memory faster than it fills - as there is no guard against overflow or
> detection when the TMC buffer wraps. Given the amount of trace that
> can be generated in a very short space of time, I cannot see how this
> can be guaranteed. Any undetected buffer wrap will result in
> significant decode failures.

It can't be guarantee that read the TMC memory faster than it fills. 
There could be
override issue happens. When issue happens, we usually suggest user to 
increase the buffer
size of the ETR to make the gap large enough for reading the data and 
filling the data to ETR.

>
> The normal sysfs read operations synchronise the DMA using a system
> call and read the RRP and RWP to ensure determine the start and end
> positions of the buffer. This cannot be done safely without stopping
> the TMC. Moreover, you are assuming that the buffer allocated is a
> contiguous flat mapped buffer, and not scatter gather.

When it is scatter gather mode, 4K data will be read each time. When it 
is flat mode,
the required length will be read.

>
> The change to the TMC core code - even if this operation could be
> guaranteed to be reliable, should be limited to extracting the data
> only - ensuring that the above constraints are observed.
>
> I'll comment inline in a couple of the other patches
>
> Thanks and Regards
>
> Mike
>
>
> On Fri, 26 May 2023 at 16:35, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>> This patch series is to add support for a streaming interface for
>> TMC ETR to allow for continuous log collection to secondary storage.
>> An interrupt based mechanism is used to stream out the data from the device.
>>
>> QDSS_CS_QDSSCSR_ETRIRQCTRL register is used to set the IRQ byte counter
>> value. The value of this registers defines the number of bytes that when moved by
>> the ETR AXI interface. It will casues an interrupt which can be used by an
>> userspace program to know how much data is present in memory requiring copy to some
>> other location. A zero setting disables the interrupt.A one setting
>> means 8 bytes, two 16 bytes, etc. In other words, the value in this
>> register is the interrupt threshold times 8 bytes. ETR must be enabled
>> when use this interrupt function.
>>
>> Sample:
>> echo 4096 > /sys/bus/coresight/devices/tmc_etr0/block_size
>> echo 1 > /sys/bus/coresight/devices/tmc_etr0/enable_sink
>> echo 1 > /sys/bus/coresight/devices/stm0/enabl_source
>>
>> cat /dev/byte-cntr > /data/qdss_etr.bin &
>>
>> The log collection will stop after disabling the ETR.
>>
>> Commit link:
>> https://git.codelinaro.org/clo/linux-kernel/coresight/-/commits/coresight-byte-cntr-v1
>>
>> Mao Jinlong (3):
>>    Coresight: Add driver to support for CSR
>>    coresight-tmc: byte-cntr: Add support for streaming interface for ETR
>>    dt-bindings: arm: Adds CoreSight CSR hardware definitions
>>
>>   .../testing/sysfs-bus-coresight-devices-tmc   |   7 +
>>   .../bindings/arm/qcom,coresight-csr.yaml      |  62 ++++
>>   drivers/hwtracing/coresight/Kconfig           |  12 +
>>   drivers/hwtracing/coresight/Makefile          |   3 +-
>>   .../hwtracing/coresight/coresight-byte-cntr.c | 304 ++++++++++++++++++
>>   .../hwtracing/coresight/coresight-byte-cntr.h |  49 +++
>>   drivers/hwtracing/coresight/coresight-csr.c   | 168 ++++++++++
>>   drivers/hwtracing/coresight/coresight-csr.h   |  59 ++++
>>   .../hwtracing/coresight/coresight-tmc-core.c  |  66 ++++
>>   .../hwtracing/coresight/coresight-tmc-etr.c   |   8 +-
>>   drivers/hwtracing/coresight/coresight-tmc.h   |  12 +-
>>   11 files changed, 745 insertions(+), 5 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-csr.yaml
>>   create mode 100644 drivers/hwtracing/coresight/coresight-byte-cntr.c
>>   create mode 100644 drivers/hwtracing/coresight/coresight-byte-cntr.h
>>   create mode 100644 drivers/hwtracing/coresight/coresight-csr.c
>>   create mode 100644 drivers/hwtracing/coresight/coresight-csr.h
>>
>> --
>> 2.17.1
>>
>
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org
