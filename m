Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D7F6C8D97
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 12:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjCYLtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 07:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjCYLtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 07:49:07 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B417A13522
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 04:49:03 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r11so17631589edd.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 04:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679744942;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kQyYQJ5ADRdF9OVtRfx6rMZJz2Nfi45W36+555qY1PU=;
        b=JBA87vR3OI9LMt/L1FYtJpneL3XrGo/91n2B7ZT8MakWj/8yfzgUw5luR8Xuz8p69E
         0/egcylpxO3IGMXaAHKYPAqJYkZVObi+Zn22pFLkRuoRspFdcWPegE1+cUXfkzstPhey
         +uZaSdsJAKp3zPlpsk41+qm7KUEm/9pswRhfxZHImiwyETw+pgnSo1LxTcR6IVFZO4me
         kKtrpdPYIG1PyIZIx6WIdBv45uui1ex3gd2LUqoG+7kybfPYdJtlEF71//zaq1NTmaLm
         EwYTATLTIWaMkP3y2NUiUw8Z5xVPWsyClkmbZg5jdaEbdMUuUMLKSMo7JpXyb+/fniHP
         hPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679744942;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQyYQJ5ADRdF9OVtRfx6rMZJz2Nfi45W36+555qY1PU=;
        b=qRkNfjhp5Q0UMBYFcc4uVkLwJVancy/hDBJgm6xWfU5ZO072B3Yvg9LmW3u3lifNsU
         mbBKkp7FqV0su5WfgerXmODxExanoKR5SYLSYqT3YHAOD+WH5bUDh3YwWrqlWhpxp30z
         p+zBS1j71oBf6ZKWcw/ClvRMJWKn5ZMscqtYQGUytWELN0l7azpGov2mbBZUnZQg1VJl
         6AvEOzRYsRE3Hny+ns5+94+Hp7O+Nx5KQ63elyoCOwP/rTrfsVp6KBDDF0/noER7+IIZ
         H1lLYTjsvjpSgdtNXiyDSOFZtc5ec2xPmdGL5tSH0dphVV32PR3dyK0PQ07oQ2GIAnqh
         d71g==
X-Gm-Message-State: AAQBX9cgZt8T4suMWe40OHKJfRMQlSCFi8/meS4q9djQiZJlXfvO9Qti
        0wMiSWTo1lNaFL1N9T4VSVG/jw==
X-Google-Smtp-Source: AKy350YTzrkYAXqQjHWZV0xpJM6s5LAt6LbBiUANs0niqJlx14HXYukVYXfsZrnn/XNAv0K2o1tP1w==
X-Received: by 2002:a17:906:b159:b0:93d:b767:9fea with SMTP id bt25-20020a170906b15900b0093db7679feamr5292904ejb.31.1679744942194;
        Sat, 25 Mar 2023 04:49:02 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d230:b2c7:d55:c9c8? ([2a02:810d:15c0:828:d230:b2c7:d55:c9c8])
        by smtp.gmail.com with ESMTPSA id a25-20020a50c319000000b004bc15a440f1sm12215603edb.78.2023.03.25.04.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 04:49:01 -0700 (PDT)
Message-ID: <e51c200e-6de0-d516-3f32-28367b2f5a95@linaro.org>
Date:   Sat, 25 Mar 2023 12:49:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: Add Coresight Dummy Trace YAML
 schema
Content-Language: en-US
To:     Hao Zhang <quic_hazha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230324061608.33609-3-quic_hazha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2023 07:16, Hao Zhang wrote:
> Add new coresight-dummy.yaml file describing the bindings required
> to define coresight dummy trace in the device trees.
> 

Subject: drop second/last, redundant "YAML schema". The "dt-bindings"
prefix is already stating that these are bindings and all new must be DT
schema. You cannot add anything else, so this is redundant.


> Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
> ---
>  .../bindings/arm/qcom,coresight-dummy.yaml    | 118 ++++++++++++++++++
>  1 file changed, 118 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml
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
> +
> +description: |
> +  The Coresight Dummy component is for the specific devices that HLOS don't have
> +  permission to access or configure. Such as Coresight sink EUD, some TPDMs etc.
> +  So there need driver to register dummy devices as Coresight devices. Provide
> +  Coresight API for dummy device operations, such as enabling and disabling
> +  dummy devices. Build the Coresight path for dummy sink or dummy source for
> +  debugging.
> +
> +  The primary use case of the coresight dummy is to build path for dummy sink or
> +  dummy source.
> +
> +maintainers:
> +  - Mao Jinlong <quic_jinlmao@quicinc.com>
> +  - Tao Zhang <quic_taozha@quicinc.com>
> +  - Hao Zhang <quic_hazha@quicinc.com>
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - qcom,coresight-dummy
> +  required:
> +    - compatible

Why do you need the select?

> +
> +properties:
> +  $nodename:
> +    pattern: "^dummy_.*(sink|source)_[0-9]+.*$"

We do not enforce node names in individual bindings. Why do you need it?
Plus underscore is not even proper character...

> +  compatible:
> +    items:

Drop items. You have only one item, so no need for list.

> +      - const: qcom,coresight-dummy
> +
> +  qcom,dummy-sink:
> +    type: boolean
> +    description:
> +      Indicates that the type of this coresight node is dummy sink.

You just duplicated property name. Write something useful.

> +
> +  qcom,dummy-source:
> +    type: boolean
> +    description:
> +      Indicates that the type of this coresight node is dummy source.

You just duplicated property name. Write something useful.

> +
> +  out-ports:
> +    description: |

No need for |

> +      Output connections from the dummy source to Coresight Trace bus.
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port:
> +        description: Output connection from the dummy source to Coresight
> +            Trace bus.
> +        $ref: /schemas/graph.yaml#/properties/port
> +
> +  in-ports:
> +    description: |

Ditto

> +      Input connections from the CoreSight Trace bus to dummy sink.
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port:
> +        description: Input connection from the Coresight Trace bus to
> +            dummy sink.
> +        $ref: /schemas/graph.yaml#/properties/port
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +oneOf:
> +  - required:
> +      - qcom,dummy-sink
> +  - required:
> +      - qcom,dummy-source
> +
> +examples:
> +  # minimum dummy sink definition. dummy sink connect to coresight replicator.
> +  - |
> +    dummy_sink_1 {

Node names should be generic, so "sink"
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +      compatible = "qcom,coresight-dummy";
> +      qcom,dummy-sink;
> +
> +      in-ports {
> +        port {
> +          eud_in_replicator_swao: endpoint {
> +            remote-endpoint =
> +              <&replicator_swao_out_eud>;

Why line break after =?

> +          };
> +        };
> +      };
> +    };
> +
> +  # minimum dummy source definition. dummy source connect to coresight funnel.

If you use sentences, then start with capital letter.

> +  - |
> +    dummy_source_1 {
> +      compatible = "qcom,coresight-dummy";
> +      qcom,dummy-source;
> +
> +      out-ports {
> +        port {
> +          dummy_riscv_out_funnel_swao: endpoint {
> +            remote-endpoint =
> +              <&funnel_swao_in_dummy_riscv>;

Why line break?
> +          };
> +        };
> +      };
> +    };
> +
> +...

Best regards,
Krzysztof

