Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6ABD6861CA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 09:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjBAIh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 03:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjBAIhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 03:37:24 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68E355A9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 00:37:21 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id m7so16510911wru.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 00:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oJIzkRW6nnSDw9Ed428dLxZMztI8zoQfCpSdVMFOs4U=;
        b=yiWY4yXYyEfkPc4hTBKFqpDLYeA2wtL5o5zpubpA2dxHEWn0wcrSIF/andG8rDMsTj
         ZuCLjcJSzw/uY3Q4hBFW2yBHavqhLUGnvEQdLQ8lQthXqCLVFW6oaFXxQnSRbH35hBrD
         Vfwya1K8ONCI0cR2anPlQutEKwrLpe80ZqM76FwJljIuuREXDbCO/3CaYT29JgTIkx8v
         bRR4XMvmSy8nVSruap8qQo0vkHDkLoY4KMDbGJBJw87YylZoUgN4zOP/8iazmwSuwp/4
         Q3IwhoZOAOYTImZpCt137eQKxXc/PrFzH6956V9kspM24+RNRfELjpKkY3cpIu3HVRCd
         V8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJIzkRW6nnSDw9Ed428dLxZMztI8zoQfCpSdVMFOs4U=;
        b=FxQmPnkaYZgXL+PT3udjpga8KLB+f7YeLbyiY9JamrMNVjsMXzW2lH1jwneHrpUDgL
         VArYeQzaKMH2fxc6tWANWFOa8D27FIHcJRp0QzrlSEIOx5P0gnWCpCPmUgW0/qabMw8V
         EeDoBEjn8j6TRhKJe5aK/vtMr7CLaeeZxrL8wiahP6G2Y6SSvctqsY9semXkMuGfqJLk
         MzSelFZTPeqZlaTNZArSnlDij8oJYY+UKvBx6sKXIuLaNsYbKCk1MhiYaMoLgChB6YsM
         lQMAcxiSEQYPVLy2OTQZ+KOMZfFvFxHQRnoXEBO5Osr2FBM7Ae+NqN0m/dIsDpjnMKUC
         cO7Q==
X-Gm-Message-State: AO0yUKXAbxXn1N4QCbecOxnH0D++uDuLgw+sO0ATPPq7MCYMyEndAV+S
        I5N68NCkrNswHDf/gk4nLhrd3A==
X-Google-Smtp-Source: AK7set8WMH7c/pfXoF8kz2sbwst4oAmViGYGg8YxONlEYVIJ0VQPbjhnGMLfJG+pMtv0jegfsrwmFA==
X-Received: by 2002:a05:6000:178d:b0:2bf:d411:a500 with SMTP id e13-20020a056000178d00b002bfd411a500mr2152296wrg.70.1675240640519;
        Wed, 01 Feb 2023 00:37:20 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id x7-20020a5d6b47000000b002bbed1388a5sm16843271wrw.15.2023.02.01.00.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 00:37:20 -0800 (PST)
Message-ID: <67ecd5d1-ab61-c9d2-b143-398a678a614d@linaro.org>
Date:   Wed, 1 Feb 2023 09:37:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v9 3/4] dt-bindings: input: pwm-beeper: add volume
Content-Language: en-US
To:     Manuel Traut <manuel.traut@mt.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
References: <20230130135650.1407156-1-manuel.traut@mt.com>
 <20230130135650.1407156-4-manuel.traut@mt.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230130135650.1407156-4-manuel.traut@mt.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2023 14:56, Manuel Traut wrote:
> Adds an array of supported volume levels and a default volume level.
> 
> Signed-off-by: Manuel Traut <manuel.traut@mt.com>
> ---
>  .../devicetree/bindings/input/pwm-beeper.yaml   | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.yaml b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
> index 1ebc3a46d934..ca9efab7efbf 100644
> --- a/Documentation/devicetree/bindings/input/pwm-beeper.yaml
> +++ b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
> @@ -25,6 +25,21 @@ properties:
>    beeper-hz:
>      description: bell frequency in Hz
>  
> +  volume-levels-bp:
> +    description: >

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

Best regards,
Krzysztof

