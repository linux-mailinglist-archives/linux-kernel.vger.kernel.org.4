Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C4F6C44DB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjCVIZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCVIZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:25:02 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B125C9ED
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:24:59 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id o12so69450697edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679473498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=szoZw3xvlaA8/xVMQ7gPUlc6BTRG3JxqG4Ue5578gh8=;
        b=D8ixaQuHPM1so5P6msuMk3k2tOzaWMpYyFyf6dSVUmxV7RgYiqUd8Mxlif2f8zI+Mf
         Wng3clmtwujrvveIwUo1d91T7dAdMWnkQ9W3lVWnX+TB70HbuHYHovpZkIz5vp0Jp+pR
         s68+VJPftQdJUsTdZhVc2NzC80bxC1sI2R//FZKffVn3+tRrBy03W/35uJpZmfMzNm9I
         K7scbA1RKZ04H6dVBI+vjCFkALFx44GtA1qs1WR5ywYMa740uHZS8nb1K4IKNUqLLQ4X
         +0+BXV33JgeEpgQ/bpD94QFqcrGlUL2Q7kWNbEPWNZa7aAuupqITyZB99CchT59ECmwK
         JQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679473498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=szoZw3xvlaA8/xVMQ7gPUlc6BTRG3JxqG4Ue5578gh8=;
        b=WtSlSVRvF/MpVuc3KKciJkc9JwgeRz8xuKgY3Lv4/mPYUmjOBYDFFk9tg2B60JiQiJ
         BhcR4i/ZINVM01a3r9RI17E419Xw0GemkrVsUMKUIauf8X5NQXNQglxtTQdhvIL85a+0
         9M1n18JZqliBTSYe6QxT3hbVprAcT8SED8A/9FOgxApz16bAWWnCqvBTakuAf5/lUVx/
         P+pivDaazCMMw27xWWNqsxqAyral9Og8hy4SO6LegrUTiv6CYjrikpBjOV5zsNbKM86t
         UCqE0bZGEM3IpBCUrNwsnTKli5EsE1qYxubHIwo+x0yaIxFxWSwoMNd2TONAxaho3v/x
         y8Rg==
X-Gm-Message-State: AO0yUKUJaazmlFYKlGrYgYydCjJr0biAxbFqf+Rwvn4qW9ptb7dE47lw
        yafffaaQUxxJF4Crb3WILjmChA==
X-Google-Smtp-Source: AK7set/z+TPpqbhYmWlz7QK/AKzno5EuRw2/ZLLKTKC0bmmMzcrOImyCU4d6DttsufEOay4I2ShZxA==
X-Received: by 2002:a17:907:c306:b0:8b1:fc1a:7d21 with SMTP id tl6-20020a170907c30600b008b1fc1a7d21mr7716808ejc.5.1679473498053;
        Wed, 22 Mar 2023 01:24:58 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5050:151b:e755:1c6? ([2a02:810d:15c0:828:5050:151b:e755:1c6])
        by smtp.gmail.com with ESMTPSA id v15-20020a170906858f00b0093229e527cdsm6393171ejx.42.2023.03.22.01.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 01:24:57 -0700 (PDT)
Message-ID: <9f5a7213-8a31-afed-f4aa-b45b6e277be4@linaro.org>
Date:   Wed, 22 Mar 2023 09:24:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/8] dt-bindings: regulator: max77658: Add ADI
 MAX77643/54/58/59 Regulator
Content-Language: en-US
To:     Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sre@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     Nurettin.Bolucu@analog.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230322055628.4441-1-Zeynep.Arslanbenzer@analog.com>
 <20230322055628.4441-2-Zeynep.Arslanbenzer@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230322055628.4441-2-Zeynep.Arslanbenzer@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2023 06:56, Zeynep Arslanbenzer wrote:
> Add ADI MAX77643/MAX77654/MAX77658/MAX77659 Regulator devicetree document.
> 
> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> ---
>  .../regulator/adi,max77658-regulator.yaml     | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/adi,max77658-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/adi,max77658-regulator.yaml b/Documentation/devicetree/bindings/regulator/adi,max77658-regulator.yaml
> new file mode 100644
> index 000000000000..1d097eddcd98
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/adi,max77658-regulator.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/adi,max77658-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Regulator for MAX77658 PMICs family from ADI
> +
> +maintainers:
> +  - Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> +  - Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> +
> +description: |
> +  This is part of the MAX77658 MFD device. For more details
> +  see Documentation/devicetree/bindings/mfd/adi,max77658.yaml.
> +
> +  The regulators is represented as a sub-node of the PMIC node on the device tree.

There is no select/compatible here, so this makes little sense as
separate binding. Make it part of parent schema instead.

Best regards,
Krzysztof

