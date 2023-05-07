Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5C36F976E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 10:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjEGIE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 04:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjEGIEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 04:04:22 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040BD11B6A
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 01:04:17 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50bc25f0c7dso6516314a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 01:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683446656; x=1686038656;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BzBNd9mB5wevctFzDqblL5y/HaLP/sCPOrJ09H89d90=;
        b=MVCuZl35RQPJZR23/XADAkTbybkeimBpPbbp8bfmqQUcSLKaLhQuJZK302ughK2VIb
         DFudRcnVlJvbpmMiSjCbF+v0h7V6T8OO7vVtU3SHmAEuprimh+U7b/Yds9oS1ZbK0o/q
         DNi/lkutV2coLlKQkgwWyKcloMOrme0Eil4ngwyrNn2isXzxQYbE5mTXI9vAwsnQ8Wq5
         8JTQoVE2357eL6P2AuWcGRSyq3VzGKG1FbrR+Db6W0kFmkSbB+FovQ5FqmJHct/pkZuj
         YJJS5nx+2+pKo5z5u3Jk4q0EoisFMZ06elsOKvYQUXS0zKokx5ZUt5Xs5gwmIWWT0KoT
         uaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683446656; x=1686038656;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BzBNd9mB5wevctFzDqblL5y/HaLP/sCPOrJ09H89d90=;
        b=eNkLo4iTSZcSv03YQGCM6nWEjiqNdfotTj4lyfgMSv5beZIkTDYm6tFLOR7idPVqhA
         hsXNy2xysWr/NlB7uMIAEHNRW1Qe70cqtxWgUGWGl2/qi4Xwvvw3W8SJXE/NzXHwsppN
         xnofFUOENNc0iWr46Ecp7I158FsDyAolKThbbBlWMFpnBHmFPIYvfEuop7wWTv/GFe6y
         56AjQnZNe+ohVPC7X6iGP3rNsHvQ3Fuu92dATM05cISiQg8rm8wIAvNoITocbEPT+y8x
         GZ/236mpeEXEHUWpYlb3ZjvgeF0gn+gQgjIIV6csOPVl075kmPRzhqJskCFEkdyVf+MT
         N6jg==
X-Gm-Message-State: AC+VfDwBZGd3UwN4dmn88JYmMpC4OSPwZpgyo2JjEm/WA0NIBiG48vjT
        8T0jPPflU4HycjplV6cqYHTibw==
X-Google-Smtp-Source: ACHHUZ4vXTIy9jC51n4f4/F0174cdi8EwNzCcxOibShQXTs4ABy9qn7IdCrVQ2DUkSbtGpqA2QsFeA==
X-Received: by 2002:aa7:dd4e:0:b0:50b:fc7f:b281 with SMTP id o14-20020aa7dd4e000000b0050bfc7fb281mr5478735edw.1.1683446656431;
        Sun, 07 May 2023 01:04:16 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:183b:950f:b4d5:135a? ([2a02:810d:15c0:828:183b:950f:b4d5:135a])
        by smtp.gmail.com with ESMTPSA id d12-20020a056402516c00b0050bd2f16ef5sm4861843ede.84.2023.05.07.01.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 01:04:15 -0700 (PDT)
Message-ID: <99343862-6b6a-30ba-40e5-7f984434b1dc@linaro.org>
Date:   Sun, 7 May 2023 10:04:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 2/3] dt-bindings: arm: Add Coresight Dummy Trace
To:     Hao Zhang <quic_hazha@quicinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
References: <20230505092422.32217-1-quic_hazha@quicinc.com>
 <20230505092422.32217-3-quic_hazha@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230505092422.32217-3-quic_hazha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 11:24, Hao Zhang wrote:
> Add new coresight-dummy.yaml file describing the bindings required
> to define coresight dummy trace in the device trees.
> 
> Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
> ---
>  .../bindings/arm/arm,coresight-dummy.yaml     | 102 ++++++++++++++++++
>  1 file changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml
> new file mode 100644
> index 000000000000..126518863eea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml
> @@ -0,0 +1,102 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/arm,coresight-dummy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM Coresight Dummy component
> +
> +description: |
> +  Coresight Dummy Trace Module is for the specific devices that kernel
> +  don't have permission to access or configure, e.g., CoreSight TPDMs
> +  on Qualcomm platforms. So there need driver to register dummy devices
> +  as Coresight devices. It may also be used to define components that
> +  may not have any programming interfaces (e.g, static links), so that
> +  paths can be established in the driver. Provide Coresight API for
> +  dummy device operations, such as enabling and disabling dummy devices.
> +  Build the Coresight path for dummy sink or dummy source for debugging.
> +
> +  The primary use case of the coresight dummy is to build path in kernel
> +  side for dummy sink and dummy source.
> +
> +maintainers:
> +  - Mao Jinlong <quic_jinlmao@quicinc.com>
> +  - Tao Zhang <quic_taozha@quicinc.com>
> +  - Hao Zhang <quic_hazha@quicinc.com>
> +  - Yuanfang Zhang <quic_yuanfang@quicinc.com>
> +
> +properties:
> +  compatible:
> +    items:

You were asked to drop oneOf, not to replace with items. Drop items.
Drop oneOf. It's just enum.

> +      - enum:
> +          - arm,coresight-dummy-sink
> +          - arm,coresight-dummy-source
> +
> +  out-ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port:
> +        description: Output connection from the source to Coresight
> +          Trace bus.
> +        $ref: /schemas/graph.yaml#/properties/port
> +
> +  in-ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port:
> +        description: Input connection from the Coresight Trace bus to
> +          dummy sink, such as Embedded USB debugger(EUD).
> +        $ref: /schemas/graph.yaml#/properties/port
> +
> +required:
> +  - compatible
> +
> +if:
> +  # If the compatible contains the below value
> +  properties:
> +    compatible:
> +      contains:
> +        const: arm,coresight-dummy-sink
> +
> +then:
> +  required:
> +    - in-ports
> +
> +else:
> +  required:
> +    - out-ports

No improvements. Implement Rob's comments.

Best regards,
Krzysztof

