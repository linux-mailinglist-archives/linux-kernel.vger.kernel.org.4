Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C4B6C95BF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 16:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjCZOrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 10:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjCZOrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 10:47:00 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E22469D
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 07:46:59 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id i5so26024209eda.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679842018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HFfrjCvrpWX6CnF+HF1tJ28DSs/1vxlz9uEimUmt+gQ=;
        b=Ntvb7K1nveWCIADlOJbiB8IYh3RmF/JSbKaJlmFXBxW54uMgTPUKheiECZTWdE+nLv
         c4jWoOMHP4dNki94qSmlfEPmCdXfQNYBLGMArFXA/BtrPnwy6x1NOdQ5Yyh5JWfjzjct
         y7L42zXKiid6qLsMe1VgAR4oJ7hNRq+lwHZ9j2FWwSoHbcxoy+rk+jnffT2QhhPG1OsL
         3o1T9gwji6ZdIIxItLYzFZ1sD388Rxr/mTpifTHVyv/Hz7CORTc5x1jZP1Dx+Qs47BRd
         dowz2z9T2mb/x7eRNggOvGRvBVLdVf+l+qlTqXmetbotX19ftL4r1gc0fho3Sn7lQ85l
         kdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679842018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFfrjCvrpWX6CnF+HF1tJ28DSs/1vxlz9uEimUmt+gQ=;
        b=nAmjfA3VEWbylpuEm8ClKqpXZaDT+CPSLTg6kHEf32zE9j0jkNxUxPUrhFoGk5RrCK
         pa4tczTiLjEza6zjrgN6/m5N0bBBGOZUTRxTcmaqhd7IE1J+AOyvb5gydSRrmrR4W7RM
         okHxNj8OMwFl5x6G7nwlgAcZbmyv+OcVJWZCMoN/Nz++JTqq6CmFTg/jNNaWgEg5QLHs
         4eFCf8k5oo2CzrXsnBPXOjGua0nLY5Aw3ayrVHdkB4xbvFvyCAd4f+4N8lI5CCJt2eQF
         0Nz/fdnimBtslx8RcWdi4SvUCX+UYUMfZDnZDNOgbau1f8gy7EQT+tiXbbSW0tqsc6w3
         BiVw==
X-Gm-Message-State: AAQBX9f9VhLBcw3Rz/fuiVZPi2bE6fNSBWka4ZeWbFdJPAr93FYPBouL
        hMDLm/bb2M/Fa2tJI5phDZu1Xw==
X-Google-Smtp-Source: AKy350ZQ1GaV8yhLr5q+kh5hsJpJhRqSpymNZuY/9YV2yeQJgeVnFVWC6RmHZCX03m93Hnyu6YMN4g==
X-Received: by 2002:a17:906:6702:b0:878:72f7:bd99 with SMTP id a2-20020a170906670200b0087872f7bd99mr9000974ejp.6.1679842018063;
        Sun, 26 Mar 2023 07:46:58 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:eca3:3b8f:823b:2669? ([2a02:810d:15c0:828:eca3:3b8f:823b:2669])
        by smtp.gmail.com with ESMTPSA id n3-20020a170906088300b009327ed171f2sm12237730eje.129.2023.03.26.07.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 07:46:57 -0700 (PDT)
Message-ID: <324e710d-de76-23dc-de4b-d34e32e63aca@linaro.org>
Date:   Sun, 26 Mar 2023 16:46:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3] ASoC: dt-bindings: alc5632: Convert to dtschema
To:     Saalim Quadri <danascape@gmail.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        daniel.baluta@nxp.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
References: <20230323130511.16367-1-danascape@gmail.com>
 <20230326131039.19190-1-danascape@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230326131039.19190-1-danascape@gmail.com>
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

On 26/03/2023 15:10, Saalim Quadri wrote:
> Convert the ALC5632 audio codec bindings to DT schema.

You got comment about threading. Do not ignore it.

> 
> Signed-off-by: Saalim Quadri <danascape@gmail.com>
> ---

Where is the changelog? What happened here?

>  .../devicetree/bindings/sound/alc5632.txt     | 43 -------------


> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        alc5632: codec@1a {

No improvements here.

> +            compatible = "realtek,alc5632";
> +            reg = <0x1a>;
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +        };
> +    };

Best regards,
Krzysztof

