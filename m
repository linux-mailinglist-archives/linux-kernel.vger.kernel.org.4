Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EC8632101
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiKULos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiKULoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:44:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99D481024;
        Mon, 21 Nov 2022 03:44:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C33F01FB;
        Mon, 21 Nov 2022 03:44:43 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03D9A3F587;
        Mon, 21 Nov 2022 03:44:34 -0800 (PST)
Message-ID: <6ad8d02b-6dc5-6c25-c798-1270af655d41@arm.com>
Date:   Mon, 21 Nov 2022 11:44:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v1 1/9] dt-bindings: arm: Add support for DSB element
Content-Language: en-US
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
References: <1669018873-4718-1-git-send-email-quic_taozha@quicinc.com>
 <1669018873-4718-2-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1669018873-4718-2-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2022 08:21, Tao Zhang wrote:
> Add property "qcom,dsb-elem-size" to support DSB(Discrete Single
> Bit) element for TPDA. Specifies the DSB element size supported
> by each monitor connected to the aggregator on each port. Should
> be specified in pairs (port, dsb element size).
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
> index c46ddea..e3b58b5 100644
> --- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
> @@ -58,6 +58,13 @@ properties:
>       minItems: 1
>       maxItems: 2
>   
> +  qcom,dsb-elem-size:

minor nit: Couldn't this be qcom,dsb-element-size ? Its not too long 
from what we have and is more meaningful.

Otherwise,

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> +    description: |
> +      Specifies the DSB element size supported by each monitor
> +      connected to the aggregator on each port. Should be specified
> +      in pairs (port, dsb element size).
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +
>     clocks:
>       maxItems: 1
>   
> @@ -100,6 +107,8 @@ examples:
>          compatible = "qcom,coresight-tpda", "arm,primecell";
>          reg = <0x6004000 0x1000>;
>   
> +       qcom,dsb-elem-size = <0 32>;
> +
>          clocks = <&aoss_qmp>;
>          clock-names = "apb_pclk";
>   

