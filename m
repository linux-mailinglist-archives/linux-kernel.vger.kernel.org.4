Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01926868C2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbjBAOpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjBAOp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:45:29 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FEB69B1B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 06:45:03 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l8so12855392wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 06:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D3cxAKq3W6GNmm99bqwhkQT0fOr9iLLRhZZR6J2sGvQ=;
        b=F7lRECosIkJ3E5HvHCJYzmL5WrWrxDsrCO537GZjANosTWxVk9cd8NON8083pm+KdC
         kSVqpnGfX/PzU3OZ8R1oPcJJEk+a0YSjKTmt5/5CCnl3eQElf42BTeFFBERDWWI8/h4R
         FBCjdQaUET8GbGYpj8WZ2hKW1wVjREC8ZAQvM5DjKqntuFvPYlU6ayyQfBXUb3dEa/Xz
         qYrvr9iMKfgifFswnFUCm2z54vQHocY7VRFZa/4PwPrzjkTktUWpsudU0xKhyRHJvhvP
         oobSqeGI0vk1fPAbEjhoB0ORLVPAHHNF71eV9uweva1KHXCkUZ5bVCfKZ8q+yAFEjW2I
         7S5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3cxAKq3W6GNmm99bqwhkQT0fOr9iLLRhZZR6J2sGvQ=;
        b=mTZF27k0pyS+AyvyldIMxDw00TkFYk6ZhZh//81kslrcWbrDAviiGKcmapPX1eo2Sr
         V//bZighQp1LnzNZrKXhm/FAX6sfGjgHvA4E1pH3pxCjgyUXFVl4VUHzaJLGWLu3HHuz
         l+H37kBlwqJhUXa7UfoQ6JvP7y/+rzv5gp6pBP8sqBW1nZLcAD/FFD5KhVwKqivJYPvg
         KhoPCZW/+B6u7aEMcvXfvkY5A5dY/bcEWYyd6Wf4MyVeYxZaE/4N6NkL2WhUoM9ZkMVO
         TDVgtIPOc3X4QVpomSk62sserPiuTAEhXpUxQ8VpKDYvSUZthk5BhdIFDCU90N9BbTi8
         VXPA==
X-Gm-Message-State: AO0yUKURgmBEBVO25ZTgKfE3DAJyNi66OcI0eel+Beab3pN5ls5EQfNX
        kDAKtDzt5t14hLe5uV7aGDgN8g==
X-Google-Smtp-Source: AK7set/je/28Ve1sxehfaX5nK3YqtyP3YXDQHPF2Xn/Ma37QbEgVUVA1hCsoLo4QKRhVfzlmwg5adw==
X-Received: by 2002:a05:600c:4e4f:b0:3dd:1c45:a90e with SMTP id e15-20020a05600c4e4f00b003dd1c45a90emr2490817wmq.25.1675262701628;
        Wed, 01 Feb 2023 06:45:01 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p11-20020a1c544b000000b003dc4fd6e624sm2037613wmi.19.2023.02.01.06.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 06:45:00 -0800 (PST)
Message-ID: <9dc413ab-c8a4-f248-d714-8c96346bd186@linaro.org>
Date:   Wed, 1 Feb 2023 15:44:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 3/5] drivers: iio: adc: Add ADI MAX77541 ADC Support
Content-Language: en-US
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20230201103534.108136-1-okan.sahin@analog.com>
 <20230201103534.108136-4-okan.sahin@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230201103534.108136-4-okan.sahin@analog.com>
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

On 01/02/2023 11:35, Okan Sahin wrote:
> The MAX77541 has an 8-bit Successive Approximation Register (SAR) ADC
> with four multiplexers for supporting the telemetry feature.
> 
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/adc/Kconfig        |  11 ++
>  drivers/iio/adc/Makefile       |   1 +
>  drivers/iio/adc/max77541-adc.c | 200 +++++++++++++++++++++++++++++++++
>  3 files changed, 212 insertions(+)
>  create mode 100644 drivers/iio/adc/max77541-adc.c
> 

The comment about subject prefixes applies also here and to other patches.

Best regards,
Krzysztof

