Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82D069A838
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjBQJgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBQJgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:36:35 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFD24B507
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:36:33 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id l11so2506966edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GU0ICBhpvnQYr6wSJpl7PgiO+1zQ6Jplz+XKZNYyw0c=;
        b=DQi0iGzW90bwPBJVFlzQmcJJhx5znA03K1p+knmQUUlEtnu+cUEONtEytRXelJfgeK
         aSw9Hr8gCUQYmamBbTKihG6X+4GfOOcLhkQ0lFAhkUBbGa/yYlVbitwV/xbLvgMM/xZe
         2HJa9hCNKcLI/wEr1evCCyVMndGIMb1kV9xOAXTbPKShe2sngMOq511hsusO6vPKetVd
         xLyWtlMn+xCC+Fsv1bxl4MSSoKDRKzjVMZH/p1Wvflhc5CuLMLuvOlWeyZ/F0IUToHfG
         0xBU9GyAtmIoj3nMdW/VouGfjiujtuzj56yzLCTOSjBS5w/A6y8FB9uHx/VWf9z4T3UD
         zPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GU0ICBhpvnQYr6wSJpl7PgiO+1zQ6Jplz+XKZNYyw0c=;
        b=WQFVd0zxcl/xysd1rwfaHrFm7CX4Ecp2Y/Xx/A0wSKv2utC+mWaRaTN7KvIZuBfKrJ
         i4S+rYcCh33MtbQD+OMDLDb28IV6bB2xJjePtT4L/80IBfiiEDsi3ko18Xo46FXcWGQT
         uIs0NIJ0XjUq1mcXzXTZYRv6lnaiCjRgMB6NiZl+uTj1gsXevI9tfzVWeDf9LHK3pMgy
         oFSv+Q1I9N5JxwRq2IoEeMPWr+GRcPMqo+TOjLglWmlmthZBsGLGua2AkfFpCWMWJkFI
         /449PIxKj0Oyw/2AhZ4JPtMFGZNKr33MlrL12B/xNPHu8pW1Sb1XqJcfScQp2lrLmHzW
         mhYQ==
X-Gm-Message-State: AO0yUKV8b5sEXGPlty8TOShQ9ag6hRakOpGudG/JUe+lOQPMTzVzsN+E
        cO4D75ovxSeqoncJZzX99A+e6g==
X-Google-Smtp-Source: AK7set9WHvq2QzcES6AFBaP4hqU6AoTt2UahTFoQ9xlX2MDkwiMB/ijltt6IwZBxvOkoU7k1QYT6rw==
X-Received: by 2002:a17:906:1cc7:b0:8af:5752:691f with SMTP id i7-20020a1709061cc700b008af5752691fmr9156715ejh.76.1676626592480;
        Fri, 17 Feb 2023 01:36:32 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id jy2-20020a170907762200b008787134a939sm1934404ejc.18.2023.02.17.01.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 01:36:32 -0800 (PST)
Message-ID: <cec5a521-bf3a-7cd3-4516-4f4a1b9e1661@linaro.org>
Date:   Fri, 17 Feb 2023 10:36:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add driver for TI ADS1100 and
 ADS1000
Content-Language: en-US
To:     Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
References: <20230217093128.8344-1-mike.looijmans@topic.nl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230217093128.8344-1-mike.looijmans@topic.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2023 10:31, Mike Looijmans wrote:
> The ADS1100 is a 16-bit ADC (at 8 samples per second).
> The ADS1000 is similar, but has a fixed data rate.

Subject: Drop "driver for"

> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
> 
>  .../bindings/iio/adc/ti,ads1100.yaml          | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
> new file mode 100644
> index 000000000000..ad30af8453a1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads1100.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI ADS1100/ADS1000 single channel I2C analog to digital converter
> +
> +maintainers:
> +  - Mike Looijmans <mike.looijmans@topic.nl>
> +
> +description: |
> +  Datasheet at: https://www.ti.com/lit/gpn/ads1100
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ads1100
> +      - ti,ads1000

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

Best regards,
Krzysztof

