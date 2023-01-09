Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCD3661EED
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjAIHCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjAIHCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:02:34 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C556361;
        Sun,  8 Jan 2023 23:02:33 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3095owJx026432;
        Mon, 9 Jan 2023 07:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pfJd5qQtkOUbtXiAaRsi/EQgAdGNlunkVWcnafYdPUA=;
 b=ZVzPgbsJcz7pE8qjT/dwLcCfnpSmAmpkIS1z8RInkXEKYFwWjK4coJ2USbV9kCkUUhW9
 m97E/JoN4OeBtcAd2OrDhng2r31XJ422a/OrLim5cguEf0Uz3q1DGQ7XnS0JkgGCFUMv
 HBy2sYvW71tsCC1ALKO8pLOUNI4QDDzYd5AMxPiQBlAp9Y1zXG+en8/EWvLDbiBDE7ld
 7X3CfdDmLUga3qBT3TmDmudr4HxBW97hYZvKKSyfxceOQoUiuoB/wijEgNJQPinnuH+F
 Lj4N9OTHozXshzNuRLEs4HLl07f19aHcEC6lhjdyTPbah7iZ1S+hNtRMPjU/pqrWENts rA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mxyq0akqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 07:02:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30972GDP001056
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 07:02:16 GMT
Received: from [10.253.38.13] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 8 Jan 2023
 23:02:10 -0800
Message-ID: <a75af1ab-b035-d81a-f4e7-e837e9986f68@quicinc.com>
Date:   Mon, 9 Jan 2023 15:02:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v16 0/8] Coresight: Add support for TPDM and TPDA
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
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
        Bjorn Andersson <andersson@kernel.org>
References: <20230106092119.20449-1-quic_jinlmao@quicinc.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <20230106092119.20449-1-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: H0xNItxxKbGQPs1FQ4X9xOez7ivejn8M
X-Proofpoint-ORIG-GUID: H0xNItxxKbGQPs1FQ4X9xOez7ivejn8M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_02,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1011 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090049
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

TPDM_TPDA commit tree: 
https://git.codelinaro.org/clo/linux-kernel/coresight/-/commits/tpdm-tpda-v16 


Here is our TPDM and TPDA commit tree. You can use this link to review 
patches.

Thanks

Jinlong Mao

On 1/6/2023 5:21 PM, Mao Jinlong wrote:
> This series adds support for the trace performance monitoring and
> diagnostics hardware (TPDM and TPDA). It is composed of two major
> elements.
> a) Changes for original coresight framework to support for TPDM and TPDA.
> b) Add driver code for TPDM and TPDA.
>
> Introduction of changes for original coresight framework
> Support TPDM as new coresight source.
> Since only STM and ETM are supported as coresight source originally.
> TPDM is a newly added coresight source. We need to change
> the original way of saving coresight path to support more types source
> for coresight driver.
> The following patch is to add support more coresight sources.
>      coresight: core: Use IDR for non-cpu bound sources' paths.
>
> Introduction of TPDM and TPDA
> TPDM - The trace performance monitoring and diagnostics monitor or TPDM in
> short serves as data collection component for various dataset types
> specified in the QPMDA(Qualcomm performance monitoring and diagnostics
> architecture) spec. The primary use case of the TPDM is to collect data
> from different data sources and send it to a TPDA for packetization,
> timestamping and funneling.
>       Coresight: Add coresight TPDM source driver
>       dt-bindings: arm: Adds CoreSight TPDM hardware definitions
>       coresight-tpdm: Add DSB dataset support
>       coresight-tpdm: Add integration test support
>
> TPDA - The trace performance monitoring and diagnostics aggregator or
> TPDA in short serves as an arbitration and packetization engine for the
> performance monitoring and diagnostics network as specified in the QPMDA
> (Qualcomm performance monitoring and diagnostics architecture)
> specification. The primary use case of the TPDA is to provide
> packetization, funneling and timestamping of Monitor data as specified
> in the QPMDA specification.
> The following patch is to add driver for TPDA.
>       Coresight: Add TPDA link driver
>       dt-bindings: arm: Adds CoreSight TPDA hardware definitions
>
> The last patch of this series is a device tree modification, which add
> the TPDM and TPDA configuration to device tree for validating.
>      ARM: dts: msm: Add tpdm mm/prng for sm8250
>
> Once this series patches are applied properly, the tpdm and tpda nodes
> should be observed at the coresight path /sys/bus/coresight/devices
> e.g.
> /sys/bus/coresight/devices # ls -l | grep tpd
> tpda0 -> ../../../devices/platform/soc@0/6004000.tpda/tpda0
> tpdm0 -> ../../../devices/platform/soc@0/6c08000.mm.tpdm/tpdm0
>
> We can use the commands are similar to the below to validate TPDMs.
> Enable coresight sink first.
>
> echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
> echo 1 > /sys/bus/coresight/devices/tpdm0/enable_source
> echo 1 > /sys/bus/coresight/devices/tpdm0/integration_test
> echo 2 > /sys/bus/coresight/devices/tpdm0/integration_test
> The test data will be collected in the coresight sink which is enabled.
> If rwp register of the sink is keeping updating when do
> integration_test (by cat tmc_etf0/mgmt/rwp), it means there is data
> generated from TPDM to sink.
>
> There must be a tpda between tpdm and the sink. When there are some
> other trace event hw components in the same HW block with tpdm, tpdm
> and these hw components will connect to the coresight funnel. When
> there is only tpdm trace hw in the HW block, tpdm will connect to
> tpda directly.
>    
>      +---------------+                +-------------+
>      |  tpdm@6c08000 |                |tpdm@684C000 |
>      +-------|-------+                +------|------+
>              |                               |
>      +-------|-------+                       |
>      | funnel@6c0b000|                       |
>      +-------|-------+                       |
>              |                               |
>      +-------|-------+                       |
>      |funnel@6c2d000 |                       |
>      +-------|-------+                       |
>              |                               |
>              |    +---------------+          |
>              +----- tpda@6004000  -----------+
>                   +-------|-------+
>                           |
>                   +-------|-------+
>                   |funnel@6005000 |
>                   +---------------+
>
> This patch series depends on patch series:
> "[v6,00/14] coresight: Add new API to allocate trace source ID values"
> https://patchwork.kernel.org/project/linux-arm-kernel/cover/20221123195010.6859-1-mike.leach@linaro.org/
>
> TPDM_TPDA commit tree:
> https://git.codelinaro.org/clo/linux-kernel/coresight/-/commits/tpdm-tpda-v16
>
> Changes in V16:
> 1. Update device tree changes to match up with device tree bindings.
> 3. Update the copyright year to 2023.
>
> Changes in V15:
> 1. coresight-tpda: Add more comments in trace id function.
> 2. qcom,coresight-tpdm.yaml: Add more comments in description.
> 3. Push "arm64: dts: qcom: sm8250: Add coresight components" out this series.
>
> Changes in V14:
> rebase to "[v5,00/14] coresight: Add new API to allocate trace source ID values" and latest 6.x kernel
>
> Changes in V13:
> 1. Fix the conflicts when apply patches to the latest base line.
>
> Changes in V12:
> 1. Clear bits for atid before setting them and relese atid when tpda
> remove. -- Suzuki K Poulose <suzuki.poulose@arm.com>
>
> Changes in V11:
> 1. Change dev_info to dev_dbg in TPDM/TPDA drivers. -- Suzuki K Poulose <suzuki.poulose@arm.com>
> 2. Merge sysfs API change of integration_test to integration_test driver
> change. -- Suzuki K Poulose <suzuki.poulose@arm.com>
>
> Changes in V10:
> 1. Fix the error of TPDM yaml file. -- Rob Herring <robh@kernel.org>
>
> Changes in V9:
> 1. Rename yaml file for TPDM/TPDA and fix the error for the yaml files.
> -- Rob Herring <robh@kernel.org>
>
> Changes in V8:
> 1. Use spinlock to protect drvdata of TPDM/TPDA -- Suzuki K Poulose <suzuki.poulose@arm.com>
> 2. Use CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS as source type for TPDM -- Suzuki K Poulose <suzuki.poulose@arm.com>
> 3. Fix the warning for yaml file of TPDM/TPDA -- Rob Herring <robh@kernel.org>
>
> Changes in V7:
> 1. Update the commit title and move the changes to right place which
> is sorted by address for dtsi changes. -- Konrad Dybcio <konrad.dybcio@somainline.org>
>
> Changes in V6:
> 1. Update maintainers in tpdm/tpda yaml file. -- Mike Leach <mike.leach@linaro.org>
> 2. Set the .remove function pointer in the amba_driver structure
>     of tpdm/tpda driver. Add tpda_remove function for tpda driver. -- Mike Leach <mike.leach@linaro.org>
> 3. Define datasets of tpdm as unsigned long. -- Mike Leach <mike.leach@linaro.org>
> 4. Move all coresight nodes to sm8250.dtsi.
>     -- Mike Leach <mike.leach@linaro.org>;Konrad Dybcio <konrad.dybcio@somainline.org>
> 5. Remove CORESIGHT_TPDM_INTEGRATION_TEST config. -- Mike Leach <mike.leach@linaro.org>
>
> Changes in V5:
> 1. Keep the ETM source paths per-CPU and use IDR for other sources'
> paths. (Suzuki K Poulose <suzuki.poulose@arm.com>)
>
> Changes in V4:
> 1. Drop trace id for tpdm source as its trace atid is defined by the tpda.
> Allocate tpda's atid dynamically.  (Mike Leach)
>
> Changes in V3:
> 1. Use bitmap to assign the trace id. (Mathieu Poirier)
>
> Changes in V2:
> 1. Use IDR to store the path of sources. (Mathieu Poirier)
> 2. Only add integration_test/enable/disable for TPDM. No other configs.
> (Mathieu Poirier)
> 3. Move coresight dtsi changes to sm8250.dtsi. (Suzuki K Poulose)
>
> Mao Jinlong (8):
>    coresight: core: Use IDR for non-cpu bound sources' paths.
>    Coresight: Add coresight TPDM source driver
>    dt-bindings: arm: Adds CoreSight TPDM hardware
>    coresight-tpdm: Add DSB dataset support
>    coresight-tpdm: Add integration test support
>    Coresight: Add TPDA link driver
>    dt-bindings: arm: Adds CoreSight TPDA hardware definitions
>    arm64: dts: qcom: sm8250: Add tpdm mm/prng
>
>   .../testing/sysfs-bus-coresight-devices-tpdm  |  13 +
>   .../bindings/arm/qcom,coresight-tpda.yaml     | 129 +++++++++
>   .../bindings/arm/qcom,coresight-tpdm.yaml     |  93 +++++++
>   MAINTAINERS                                   |   1 +
>   arch/arm64/boot/dts/qcom/sm8250.dtsi          | 164 +++++++++++
>   drivers/hwtracing/coresight/Kconfig           |  23 ++
>   drivers/hwtracing/coresight/Makefile          |   2 +
>   drivers/hwtracing/coresight/coresight-core.c  |  42 ++-
>   drivers/hwtracing/coresight/coresight-tpda.c  | 211 ++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpda.h  |  35 +++
>   drivers/hwtracing/coresight/coresight-tpdm.c  | 259 ++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpdm.h  |  62 +++++
>   include/linux/coresight.h                     |   1 +
>   13 files changed, 1023 insertions(+), 12 deletions(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>   create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
>   create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
>   create mode 100644 drivers/hwtracing/coresight/coresight-tpda.c
>   create mode 100644 drivers/hwtracing/coresight/coresight-tpda.h
>   create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.c
>   create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.h
>
