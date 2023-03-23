Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717BA6C665E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjCWLSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjCWLSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:18:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F8844489;
        Thu, 23 Mar 2023 04:18:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 554364B3;
        Thu, 23 Mar 2023 04:18:53 -0700 (PDT)
Received: from [10.57.53.151] (unknown [10.57.53.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E3AD3F766;
        Thu, 23 Mar 2023 04:18:06 -0700 (PDT)
Message-ID: <e6ad7301-09ea-93e0-929e-86e0eb0a02e7@arm.com>
Date:   Thu, 23 Mar 2023 11:18:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v3 01/11] dt-bindings: arm: Add support for DSB element
 size
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org
References: <1679551448-19160-1-git-send-email-quic_taozha@quicinc.com>
 <1679551448-19160-2-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1679551448-19160-2-git-send-email-quic_taozha@quicinc.com>
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

On 23/03/2023 06:03, Tao Zhang wrote:
> Add property "qcom,dsb-elem-size" to support DSB(Discrete Single
> Bit) element for TPDM. The associated aggregator will read this
> size before it is enabled. DSB element size currently only
> supports 32-bit and 64-bit.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   .../devicetree/bindings/arm/qcom,coresight-tpdm.yaml          | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
> index 5c08342..d9b6b613 100644
> --- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
> @@ -44,6 +44,15 @@ properties:
>       minItems: 1
>       maxItems: 2


>   
> +  qcom,dsb-element-size:
> +    description:
> +      Specifies the DSB(Discrete Single Bit) element size supported by
> +      the monitor. The associated aggregator will read this size before it
> +      is enabled. DSB element size currently only supports 32-bit and 64-bit.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 32
> +    maximum: 64

Shouldn't this be something like oneOf ? It is not a range, but one of
those two specific values ?

Suzuki


