Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC7B6735EE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjASKpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjASKo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:44:58 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9151646D4E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:44:57 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id z5so1420190wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8xlnawePa78ICFwjfjsW90f7mFfyeG73gzlxTncqwyE=;
        b=h5WDQK2D6C9l5TGsa7heKev8ShkmZ1JPY5cxwLtzRlVKbAZFrP1SjLeg6p7u0CzyX+
         ZtI98ciCrs1G6ED70BKYjH1OQt1qjnvI0ruFbP3KmYzNKqmODOiSrIu/SS/4e1B1Ja5+
         wLBlagSVGeherUSZGt2wnqhYfLeLmrYs/TVm6v9aNWTVzjgFf30B0wKbNCK3mI7LUGRZ
         GCEtgyUbTxLKvPThn23sDnde6Q5JUoEnbJ6/W23yxrQFfZzsgw6ntkcyzuKOpOjDNE6/
         dFiLBrO7Zg/s0EnMnMllp8N+jnRR8K4X1Al03LXNaNO8cYTZ6SM9xCElMxBS4u8YQxPt
         IMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xlnawePa78ICFwjfjsW90f7mFfyeG73gzlxTncqwyE=;
        b=m0V66wJlbSk8RPL81baDuqTpUU8R5R8ZuCrAsMklRAL3A3nd/QpccsLZ7q3tHHZ70f
         fld0faLVNQsPtnkcpF2BIcmVJY79MW14CTeS/aW6V3cWhY7qO6fLp8Vi3cIT6LgQUFoV
         5g4+QwSQkP8+cNVImef19fDYwXKfBj6lQGTQlEbRJEoqhLsuCY6t547LQD4MSxHzhEeC
         Rsa9FpZAVr4GbvyReXDbYkCRPLtgzdg8+tG+zb5I+3U4329iHv2B0vfL+EePSCK/AKGT
         u1zNkGwrT0DWlraKih0O+AnG+G5hQ2VQsvGpp7mtXBzoF60Wn533W2Omcc4LbJ8O7Ab4
         SK0A==
X-Gm-Message-State: AFqh2kpOSGypBdlCef3/aneXPcoynOXih9ZdeOGPHbnucikQz4sS9ZN3
        yc7/gPXHGjb2rEWCpdZU8NQf0w==
X-Google-Smtp-Source: AMrXdXvel3nvZiaEnBT/xHs7rT2NUHqn9HRzAttFMuh2VrOKEUaH5uPNdNIHlLOFA6xljS1sQgnihw==
X-Received: by 2002:a5d:68c5:0:b0:2bc:846a:8eb2 with SMTP id p5-20020a5d68c5000000b002bc846a8eb2mr8837850wrw.11.1674125096077;
        Thu, 19 Jan 2023 02:44:56 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600012c400b002bbb2d43f65sm30361062wrx.14.2023.01.19.02.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 02:44:55 -0800 (PST)
Message-ID: <cd7a2eac-5d70-6dcd-ddbd-317e1cbd7d23@linaro.org>
Date:   Thu, 19 Jan 2023 11:44:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 1/9] dt-bindings: arm: Add support for DSB element
Content-Language: en-US
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
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
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        Tao Zhang <taozha@qti.qualcomm.com>
References: <1674114105-16651-1-git-send-email-quic_taozha@quicinc.com>
 <1674114105-16651-2-git-send-email-quic_taozha@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1674114105-16651-2-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 08:41, Tao Zhang wrote:
> Add property "qcom,dsb-elem-size" to support DSB(Discrete Single
> Bit) element for TPDA. Specifies the DSB element size supported
> by each monitor connected to the aggregator on each port. Should
> be specified in pairs (port, dsb element size).
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Tao Zhang <taozha@qti.qualcomm.com>

You are the same person and it is still the same organization
(Qualcomm), right? Only one SoB.

> ---
>  .../bindings/arm/qcom,coresight-tpda.yaml          | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
> index 2ec9b5b..298db7f 100644
> --- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
> @@ -58,6 +58,26 @@ properties:
>      minItems: 1
>      maxItems: 2
>  
> +  qcom,dsb-element-size:
> +    description: |
> +      Specifies the DSB(Discrete Single Bit) element size supported by
> +      each monitor connected to the aggregator on each port. Should be
> +      specified in pairs <port, dsb element size>.

s/port/port number/

> +
> +      Note: The maximum value of the port number depends on how many
> +      input ports the current TPDA has. DSB element size currently only
> +      supports 32-bit and 64-bit.
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    items:

Are some reasonable maxItems known?

> +      items:
> +        - description: |
> +            "port" indicates TPDA input port number

What is "port"? You quoted it like it was some name of variable or
property. Where is then?

> +          minimum: 0
> +        - description: |
> +            "dsb element size" indicates dsb element size

"A" indicates A. This sentence does not make sense.

Also missing units.

s/dsb/DSB/

> +          minimum: 0
> +          maximum: 64
> +
>    clocks:
>      maxItems: 1
>  
> @@ -100,6 +120,8 @@ examples:
>         compatible = "qcom,coresight-tpda", "arm,primecell";
>         reg = <0x6004000 0x1000>;
>  
> +       qcom,dsb-element-size = <0 32>;
> +
>         clocks = <&aoss_qmp>;
>         clock-names = "apb_pclk";
>  

Best regards,
Krzysztof

