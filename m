Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D3D6C7CD7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjCXKr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjCXKri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:47:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08DBFFF31;
        Fri, 24 Mar 2023 03:47:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD63212FC;
        Fri, 24 Mar 2023 03:48:20 -0700 (PDT)
Received: from [10.57.55.150] (unknown [10.57.55.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12F863F6C4;
        Fri, 24 Mar 2023 03:47:32 -0700 (PDT)
Message-ID: <fed08b5e-737e-c253-38ac-5b29004b5eac@arm.com>
Date:   Fri, 24 Mar 2023 10:47:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: Add Coresight Dummy Trace YAML
 schema
To:     Hao Zhang <quic_hazha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-doc@vger.kernel.org
References: <20230324061608.33609-1-quic_hazha@quicinc.com>
 <20230324061608.33609-3-quic_hazha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230324061608.33609-3-quic_hazha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2023 06:16, Hao Zhang wrote:
> Add new coresight-dummy.yaml file describing the bindings required
> to define coresight dummy trace in the device trees.
> 
> Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
> ---
>   .../bindings/arm/qcom,coresight-dummy.yaml    | 118 ++++++++++++++++++
>   1 file changed, 118 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml
> new file mode 100644
> index 000000000000..7b719b084d72
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml
> @@ -0,0 +1,118 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +# Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/qcom,coresight-dummy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: QCOM Coresight Dummy component

As mentioned in the previous email, please make this Arm CoreSight. This
is not specific to Qcom, rather something the CoreSight driver exposes
as a dummy framework. Otherwise looks good to me.

Suzuki

