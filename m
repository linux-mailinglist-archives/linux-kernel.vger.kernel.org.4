Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E18166AC12
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 16:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjANPUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 10:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjANPUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 10:20:47 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7547EC3;
        Sat, 14 Jan 2023 07:20:46 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30EFKOXx006257;
        Sat, 14 Jan 2023 15:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eRrrnsqQZpoenr+GsMtDm5/BbzFDfgVMUdEFgDWf/qc=;
 b=Ejt50UavAnFB4wRmkewBXCWQyPXZ62CrAWTb1S4AFKxH2d14uYF58D1jz9nRg2FY3BLd
 5XMr701e7oDOhe/NsL9pbi4ctF/L6unoBby1jE4EC447PLVBu657CAia6lT+RzKFCiJs
 RAt7lAKmeJ+xqJWZL0Y4YpO25ATTw7PxXhXQWjRf9d9dL3W1udxFZ9uf7dCtt+qJLdKA
 XF3KtBmGKWH7W+zkY2E3oaviSzj+yP9L6xCj0FR0CSmRtwHYbADYnQf+nxnLpqQhCwxB
 CyX88e/KGvAP6M/P2iJGPQB8fWbwPx/CKg9KPUi1TUfRfYxt1nZ2b+rqAYMQIaE6RGdW mQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n3npg8hp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Jan 2023 15:20:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30EFKNLJ030148
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Jan 2023 15:20:23 GMT
Received: from [10.253.35.131] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sat, 14 Jan
 2023 07:20:18 -0800
Message-ID: <9a37afab-7467-bd7c-3e19-e153bb452f36@quicinc.com>
Date:   Sat, 14 Jan 2023 23:19:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v16 0/8] Coresight: Add support for TPDM and TPDA
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20230106092119.20449-1-quic_jinlmao@quicinc.com>
 <6ead4016-a8a2-4572-8f75-682726d04479@arm.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <6ead4016-a8a2-4572-8f75-682726d04479@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xNvpvlI-4gI5KRdaBGYbxZOTN-epARdT
X-Proofpoint-ORIG-GUID: xNvpvlI-4gI5KRdaBGYbxZOTN-epARdT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-14_05,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301140110
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/10/2023 5:57 PM, Suzuki K Poulose wrote:
> On 06/01/2023 09:21, Mao Jinlong wrote:
>> This series adds support for the trace performance monitoring and
>> diagnostics hardware (TPDM and TPDA). It is composed of two major
>> elements.
>> a) Changes for original coresight framework to support for TPDM and 
>> TPDA.
>> b) Add driver code for TPDM and TPDA.
>>
>> Introduction of changes for original coresight framework
>> Support TPDM as new coresight source.
>> Since only STM and ETM are supported as coresight source originally.
>> TPDM is a newly added coresight source. We need to change
>> the original way of saving coresight path to support more types source
>> for coresight driver.
>> The following patch is to add support more coresight sources.
>>      coresight: core: Use IDR for non-cpu bound sources' paths.
>>
>> Introduction of TPDM and TPDA
>> TPDM - The trace performance monitoring and diagnostics monitor or 
>> TPDM in
>> short serves as data collection component for various dataset types
>> specified in the QPMDA(Qualcomm performance monitoring and diagnostics
>> architecture) spec. The primary use case of the TPDM is to collect data
>> from different data sources and send it to a TPDA for packetization,
>> timestamping and funneling.
>>       Coresight: Add coresight TPDM source driver
>>       dt-bindings: arm: Adds CoreSight TPDM hardware definitions
>>       coresight-tpdm: Add DSB dataset support
>>       coresight-tpdm: Add integration test support
>>
>> TPDA - The trace performance monitoring and diagnostics aggregator or
>> TPDA in short serves as an arbitration and packetization engine for the
>> performance monitoring and diagnostics network as specified in the QPMDA
>> (Qualcomm performance monitoring and diagnostics architecture)
>> specification. The primary use case of the TPDA is to provide
>> packetization, funneling and timestamping of Monitor data as specified
>> in the QPMDA specification.
>> The following patch is to add driver for TPDA.
>>       Coresight: Add TPDA link driver
>>       dt-bindings: arm: Adds CoreSight TPDA hardware definitions
>>
>> The last patch of this series is a device tree modification, which add
>> the TPDM and TPDA configuration to device tree for validating.
>>      ARM: dts: msm: Add tpdm mm/prng for sm8250
>>
>> Once this series patches are applied properly, the tpdm and tpda nodes
>> should be observed at the coresight path /sys/bus/coresight/devices
>> e.g.
>> /sys/bus/coresight/devices # ls -l | grep tpd
>> tpda0 -> ../../../devices/platform/soc@0/6004000.tpda/tpda0
>> tpdm0 -> ../../../devices/platform/soc@0/6c08000.mm.tpdm/tpdm0
>>
>> We can use the commands are similar to the below to validate TPDMs.
>> Enable coresight sink first.
>>
>> echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
>> echo 1 > /sys/bus/coresight/devices/tpdm0/enable_source
>> echo 1 > /sys/bus/coresight/devices/tpdm0/integration_test
>> echo 2 > /sys/bus/coresight/devices/tpdm0/integration_test
>> The test data will be collected in the coresight sink which is enabled.
>> If rwp register of the sink is keeping updating when do
>> integration_test (by cat tmc_etf0/mgmt/rwp), it means there is data
>> generated from TPDM to sink.
>>
>> There must be a tpda between tpdm and the sink. When there are some
>> other trace event hw components in the same HW block with tpdm, tpdm
>> and these hw components will connect to the coresight funnel. When
>> there is only tpdm trace hw in the HW block, tpdm will connect to
>> tpda directly.
>>         +---------------+                +-------------+
>>      |  tpdm@6c08000 |                |tpdm@684C000 |
>>      +-------|-------+                +------|------+
>>              |                               |
>>      +-------|-------+                       |
>>      | funnel@6c0b000|                       |
>>      +-------|-------+                       |
>>              |                               |
>>      +-------|-------+                       |
>>      |funnel@6c2d000 |                       |
>>      +-------|-------+                       |
>>              |                               |
>>              |    +---------------+          |
>>              +----- tpda@6004000  -----------+
>>                   +-------|-------+
>>                           |
>>                   +-------|-------+
>>                   |funnel@6005000 |
>>                   +---------------+
>>
>> This patch series depends on patch series:
>> "[v6,00/14] coresight: Add new API to allocate trace source ID values"
>> https://patchwork.kernel.org/project/linux-arm-kernel/cover/20221123195010.6859-1-mike.leach@linaro.org/ 
>>
>>
>> TPDM_TPDA commit tree:
>> https://git.codelinaro.org/clo/linux-kernel/coresight/-/commits/tpdm-tpda-v16 
>>
>>
>
> Please could you add a documentation for TPDA and TPDM under
> Documentation/tracing/coresight/ ?
>
> It need not be part of this series if you don't have to resend it.
>
Hi Suzuki,

Sure. I will add the documentation for TPDA and TPDM.

Could you please review patches below which don't have your reviewed by 
tag ?
If you have comments, I will update in next version along with the 
documentation for TPDA and TPDM.

Coresight: Add TPDA link driver
arm64: dts: qcom: sm8250: Add tpdm mm/prng

Thanks
Jinlong Mao
>
> Kind regards
> Suzuki
>
