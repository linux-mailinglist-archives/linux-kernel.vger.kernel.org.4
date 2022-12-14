Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F9A64C88F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238356AbiLNMA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238359AbiLNMAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:00:03 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C909233A3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:59:24 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id x28so10036163lfn.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8O/vW9WSKsHkZK0ykTgQ1QEzHkmmFKIznSejf9tyvWs=;
        b=WJ8TKFAXZjvQw0UVY1xJ8cGh6fO3cBzDk8hy3FACDWH04zCHHMzn4imY/AnpciSiWt
         YBdlAqlr7yzRn0C9S0tpg9u075BMHSABwXf0B6KEF8h4RbZ77TicHC0Ak/J6lIF+hQ0K
         n93fA+cnwkxClUVcvIH9sqlRbm4pn90M4mEiPFw2O4/0PLf2htIQony04cPkxoPeMPvj
         7yZUYROnbsYVBEC/Yjti1oYuRxyyBZyp2ynjUpbYiv5Q7muKDRQc/BANqWe4+tQzRN7E
         jLYrUdT9AXfqxgl6jL/mzwT8yNDGdxAurlWX7MakFjXuVoOl/RIGhKOUJ+OlHn/Wc6zi
         KVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8O/vW9WSKsHkZK0ykTgQ1QEzHkmmFKIznSejf9tyvWs=;
        b=BQTlNH+sIZXOXiO0QydtSsMwDx5LIczQ3xC05xopyTAsx1TuzdASeZB1fh58xruHKv
         oKZ99OErTjU8G/MIMAFB0muVLVlmh7i9J/4UkJQ5dzQxHA7+TVFghWze58qfet5QiKLf
         7OKj9vbNjbLViikW6i4pJsvGpqhCD4QQY7+MS3XIhwQDphwkLct6HDEfU1vjDJsiIuAr
         LG0AHwNcKJ0YJ6p6CA6c1YZq4RQ/6g/3v5JU6+YLcQ6dkRhOl1Tf1KaM6O92a0tv9iID
         RnVnSvl3ZDjxgHp7KRgraqvFrhUsVjyIpizQ5O7aML5R03BCsdWMWNsTlUCTzYvQW1V4
         nJEw==
X-Gm-Message-State: ANoB5pmzT5eRlsLNBxIlaZuZZLnelCKlXZwNEjx076FONnYgMGbAmKZh
        gPgtXa9KciqnLR0CgAnSH8PG/A==
X-Google-Smtp-Source: AA0mqf7jxVEC3HyZvvPv5fwRRGcINPJQYYlkNqgDNylF7UF7gthNhPIWCijByNhe55lN9vx/Xw9RNg==
X-Received: by 2002:a05:6512:308a:b0:4b6:f51e:b8b6 with SMTP id z10-20020a056512308a00b004b6f51eb8b6mr2332142lfd.56.1671019163235;
        Wed, 14 Dec 2022 03:59:23 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id x2-20020a056512078200b004b577fdce62sm777188lfr.158.2022.12.14.03.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 03:59:22 -0800 (PST)
Message-ID: <9e602e50-143e-b50d-047e-c5ff05363929@linaro.org>
Date:   Wed, 14 Dec 2022 12:59:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 1/5] dt-bindings: dma: ti: k3-bcdma: Add bindings for
 BCDMA CSI RX
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221213164304.1126945-1-vigneshr@ti.com>
 <20221213164304.1126945-2-vigneshr@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213164304.1126945-2-vigneshr@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2022 17:43, Vignesh Raghavendra wrote:
> AM62A SoC has a dedicated BCDMA that serves Camera Serial Interface
> (CSI) IP. Add new compatible for the same. Unlike system
> BCDMA, this instance only has RX DMA channels and lack TX or block copy
> channel. Thus make those properties optional. Additionally CSI RX has
> independent power domain, add the binding for the same.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
> v3:
> Add min/max constraints for reg-names and reg on per compatible basis
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

