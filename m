Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5B46753A5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjATLrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjATLrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:47:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F7499515B;
        Fri, 20 Jan 2023 03:46:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2D5D1FB;
        Fri, 20 Jan 2023 03:47:06 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BAA83F71A;
        Fri, 20 Jan 2023 03:46:22 -0800 (PST)
Message-ID: <70d32270-cd55-0c7e-2a3f-394b452ce532@arm.com>
Date:   Fri, 20 Jan 2023 11:46:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v17 0/9] Coresight: Add support for TPDM and TPDA
Content-Language: en-US
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
References: <20230117145708.16739-1-quic_jinlmao@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230117145708.16739-1-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2023 14:56, Mao Jinlong wrote:
> This series adds support for the trace performance monitoring and
> diagnostics hardware (TPDM and TPDA). It is composed of two major
> elements.
> a) Changes for original coresight framework to support for TPDM and TPDA.
> b) Add driver code for TPDM and TPDA.
> 

...

> Mao Jinlong (9):
>    coresight: core: Use IDR for non-cpu bound sources' paths.
>    Coresight: Add coresight TPDM source driver

https://lore.kernel.org/r/20230120095301.30792-1-quic_jinlmao@quicinc.com

>    dt-bindings: arm: Add CoreSight TPDM hardware
>    coresight-tpdm: Add DSB dataset support
>    coresight-tpdm: Add integration test support
>    Coresight: Add TPDA link driver

https://lore.kernel.org/r/20230120095301.30792-2-quic_jinlmao@quicinc.com

>    dt-bindings: arm: Adds CoreSight TPDA hardware definitions
>    Documentation: trace: Add documentation for TPDM and TPDA

I have queued patches 1-8, to the coresight next branch.

https://git.kernel.org/coresight/c/758d638667d4

>    arm64: dts: qcom: sm8250: Add tpdm mm/prng

I assume this ^ would go in via soc tree.



Thanks
Suzuki

> 
>   .../testing/sysfs-bus-coresight-devices-tpdm  |  13 +
>   .../bindings/arm/qcom,coresight-tpda.yaml     | 129 +++++++++
>   .../bindings/arm/qcom,coresight-tpdm.yaml     |  93 +++++++
>   .../trace/coresight/coresight-tpda.rst        |  52 ++++
>   .../trace/coresight/coresight-tpdm.rst        |  43 +++
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
>   15 files changed, 1118 insertions(+), 12 deletions(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>   create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
>   create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
>   create mode 100644 Documentation/trace/coresight/coresight-tpda.rst
>   create mode 100644 Documentation/trace/coresight/coresight-tpdm.rst
>   create mode 100644 drivers/hwtracing/coresight/coresight-tpda.c
>   create mode 100644 drivers/hwtracing/coresight/coresight-tpda.h
>   create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.c
>   create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.h
> 

