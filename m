Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070616C9CBE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjC0HuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbjC0Htz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:49:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9172DE1;
        Mon, 27 Mar 2023 00:49:54 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R7T4h4032155;
        Mon, 27 Mar 2023 07:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/c2reEat/wJZOjBAjPDX8NUM19PVHExcK5yTwg99PXI=;
 b=WYTv/YKevq6N4+dqRYnCMsXPQ8MABYhKCueHT3au3fKPW6aOe14odYq41jywrNdt1RZy
 wgpWeKthupIaJLSrztPM2HvaiNlIMf0KYy4hERDwF8PBbaMX71c57FiH/syuL8E9C+V9
 GXbD6Y5RLf2jVhn1u7s8kuuaGZ2EUl2hcqUAGOjtSLAekgwr3y+nVZujuc/dVrzrIWly
 HiPoONO81fjJq9jh//kaPwwIJOF4W+zR6xFeeGXWGMaboBMfxokd4Th12TnkVBsdiA8n
 kq0pd2ePTexjeKO1s2GQt5po4k0g63tM/ixi3x80Zb3d9ZZ04jvjAp7eDDUmOTXca5lr bA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3phsqqkr8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 07:49:42 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32R7nfNc028602
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 07:49:41 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Mar
 2023 00:49:36 -0700
Message-ID: <b04c49b1-3eb2-e4f8-63f4-6613bf9225af@quicinc.com>
Date:   Mon, 27 Mar 2023 15:49:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 08/11] coresight-tpdm: Add nodes to configure pattern
 match output
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
References: <1679551448-19160-1-git-send-email-quic_taozha@quicinc.com>
 <1679551448-19160-9-git-send-email-quic_taozha@quicinc.com>
 <b3bb6dc1-ceeb-0116-055b-25a27da8ab38@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <b3bb6dc1-ceeb-0116-055b-25a27da8ab38@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9L_uUI6PGy6PSwz476lM4wuQsGV0sFeS
X-Proofpoint-ORIG-GUID: 9L_uUI6PGy6PSwz476lM4wuQsGV0sFeS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 clxscore=1015 mlxscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270062
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 3/24/2023 1:27 AM, Suzuki K Poulose wrote:
> On 23/03/2023 06:04, Tao Zhang wrote:
>> Add nodes to configure trigger pattern and trigger pattern mask.
>> Each DSB subunit TPDM has maximum of n(n<7) XPR registers to
>> configure trigger pattern match output. Eight 32 bit registers
>> providing DSB interface trigger output pattern match comparison.
>> And each DSB subunit TPDM has maximum of m(m<7) XPMR registers to
>> configure trigger pattern mask match output. Eight 32 bit
>> registers providing DSB interface trigger output pattern match
>> mask.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 24 +++++++
>>   drivers/hwtracing/coresight/coresight-tpdm.c       | 84 
>> ++++++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-tpdm.h       |  8 +++
>>   3 files changed, 116 insertions(+)
>>
>> diff --git 
>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> index 094d624..c06374f 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> @@ -71,3 +71,27 @@ Description:
>>           value 1: Start EDCMR register number
>>           value 2: End EDCMR register number
>>           value 3: The value need to be written
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_trig_patt_val
>> +Date:        March 2023
>> +KernelVersion    6.3
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:
>> +        (Write) Set the trigger pattern value of DSB tpdm.
>> +        Read the trigger pattern value of DSB tpdm.
>> +
>> +        Accepts the following two values.
>> +        value 1: Index number of XPR register
>> +        value 2: The value need to be written
>
> minor nit: What values are acceptable ? Otherwise looks fine.

I will update this in the next patch series.


Tao

>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
