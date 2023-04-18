Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAA96E5E40
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjDRKJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjDRKIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:08:55 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4924E3C2F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:08:51 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id xd13so37807346ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681812530; x=1684404530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CHTRuDZizZmh3JLZCo5lprJ34wrb3qJisxHDlzonFVQ=;
        b=IL9QQcBRXReGXfHqy0crh2FxCNKO1auiDipds27slpKbXHVXazCM6KG8qIo1FvRcxt
         iq9WJU9MycEAR+w87PKddU8wGGtQ3anbOKLaRUO5Uj77vcpjST+eNxWyoFKtpxwBNTn6
         G1ntWN0oiQjJnSREdUT7A/iCLtwacqzVXVbFzhVHDjS7r7M0vZ0dtMTHSwxhEnK3OSdy
         7or+H0TxJbxiZ+08cu+obndPVE/glYUYnb9oZlhzjyRdVmsQZjqtLd1O9T0MhpfJCHs0
         Z5Bc3nY0iDEq6teRKfyraaYCkBi7VT8B8GOAShTPUpUSi7ajgy1E1yX5wuVT5Fx3nj9F
         wNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681812530; x=1684404530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CHTRuDZizZmh3JLZCo5lprJ34wrb3qJisxHDlzonFVQ=;
        b=c/jmReDf9PWrysK7FRwQYqiwzI6f8UA9uRqxcq8c8LNI2uK48CVjdo0arFqLQLtNzm
         fcxV2CCj7WxDlbvQu4CACbqfCcmpvNOAf9xsNt8t2CxAmEESVIhbwpCQBHepXih32CMG
         hVGaYEZeRM9x0PijU6oWR09x3bXytaN/JEBZ+3lgOYRnutKnfZtWsntxmo60E0cUSar7
         s1JZjNuuSVvrgEdNkRsb7v5KA9TIKybb7QqWm87gNdjwdUVH8ENm50CMwq08gVks2WeY
         rxAyhtDnvkHfDVsaaoekSBYbSqKQsT+ErzDG9hpVLRowotSMNNlM3zEF2o8XIVYKq2EJ
         XUJw==
X-Gm-Message-State: AAQBX9f5PAI1cyCnjSUFkanhVQfyylEpQ1CkbU6Nni0Oaf2cCzBtqc58
        VVxhIkbLiFzjlOn9hm4Oh33zpg==
X-Google-Smtp-Source: AKy350Y6QKNYyStk/yeNY7V9U+pJgUn1EghZMLBG2sV9zSfpYxNv6bvXFckJUhC1XhExS9B0xAO02g==
X-Received: by 2002:a17:906:82c5:b0:94a:8e19:6aba with SMTP id a5-20020a17090682c500b0094a8e196abamr10589810ejy.21.1681812529724;
        Tue, 18 Apr 2023 03:08:49 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id kt2-20020a170906aac200b0094f6458157csm3300672ejb.223.2023.04.18.03.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 03:08:49 -0700 (PDT)
Message-ID: <4a250d8f-5771-4933-be99-5721c163fe8a@linaro.org>
Date:   Tue, 18 Apr 2023 11:08:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 2/7] dt-bindings: soundwire: qcom: add 16-bit sample
 interval
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Rob Herring <robh@kernel.org>
References: <20230418095447.577001-1-krzysztof.kozlowski@linaro.org>
 <20230418095447.577001-3-krzysztof.kozlowski@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230418095447.577001-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/04/2023 10:54, Krzysztof Kozlowski wrote:
> The port sample interval was always 16-bit, split into low and high
> bytes.  This split was unnecessary, although harmless for older devices
> because all of them used only lower byte (so values < 0xff).  With
> support for Soundwire controller on Qualcomm SM8550 and its devices,
> both bytes will be used, thus add a new 'qcom,ports-sinterval' property
> to allow 16-bit sample intervals.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini
> 
> Changes since v2:
> 1. Use uint16 for qcom,ports-sinterval.
>     DTS will be fixed in separate patchset.
> 2. Add tags.
> ---
>   .../bindings/soundwire/qcom,soundwire.yaml    | 20 +++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml b/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
> index 98c7fc7e1189..fb44b89a754e 100644
> --- a/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
> +++ b/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
> @@ -86,7 +86,7 @@ properties:
>     qcom,ports-sinterval-low:
>       $ref: /schemas/types.yaml#/definitions/uint8-array
>       description:
> -      Sample interval low of each data port.
> +      Sample interval (only lowest byte) of each data port.
>         Out ports followed by In ports. Used for Sample Interval calculation.
>         Value of 0xff indicates that this option is not implemented
>         or applicable for the respective data port.
> @@ -94,6 +94,17 @@ properties:
>       minItems: 3
>       maxItems: 16
>   
> +  qcom,ports-sinterval:
> +    $ref: /schemas/types.yaml#/definitions/uint16-array
> +    description:
> +      Sample interval of each data port.
> +      Out ports followed by In ports. Used for Sample Interval calculation.
> +      Value of 0xffff indicates that this option is not implemented
> +      or applicable for the respective data port.
> +      More info in MIPI Alliance SoundWire 1.0 Specifications.
> +    minItems: 3
> +    maxItems: 16
> +
>     qcom,ports-offset1:
>       $ref: /schemas/types.yaml#/definitions/uint8-array
>       description:
> @@ -220,10 +231,15 @@ required:
>     - '#size-cells'
>     - qcom,dout-ports
>     - qcom,din-ports
> -  - qcom,ports-sinterval-low
>     - qcom,ports-offset1
>     - qcom,ports-offset2
>   
> +oneOf:
> +  - required:
> +      - qcom,ports-sinterval-low
> +  - required:
> +      - qcom,ports-sinterval
> +
>   additionalProperties: false
>   
>   examples:
