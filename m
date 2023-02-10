Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2195B691E96
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjBJLtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjBJLtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:49:23 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209D21E9EC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 03:49:22 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso6092311wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 03:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tB5gNRU/MbQprb8j0TWV5I2QJ6yglApm7jTfttA1W+s=;
        b=Fbaytt/6vfSC8HQfFnVPGnQtxX8HuwZli0T3ctHeBmMgZtzOJ2vvjhO1utdqYFrd11
         qFg7IF689kisIoiOgUgcOcLFKYoU7xqF+fpjxa8dMQlWInYH2rWYEj7TEgx3dRb1qdZO
         R2FTc2fT1A6WjwWTSDg7/RS3uk/Pj8edGTikvZHo6UVEqyDe7EMM0jb17C8OiFnaFXKd
         sJ1GdOB5+6FymExSar5JWNlOwFp/JBE3/3xvK0DW90bkr0QpbMxrujWgDPZBA8btRFmj
         mQ1ehUyi65l/sIi6giVg6C+wtziYgximwMyyVCxBXR3rIjiyoJidayBJLKXXxOgGsbZG
         N/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tB5gNRU/MbQprb8j0TWV5I2QJ6yglApm7jTfttA1W+s=;
        b=WqZbwOYfFdv2w6LS/iqyv2INNQ5yvgp7tauqEgAZxpl0s4j1p5VxdU8HAB9Dz/YcbR
         cgEHWLZlnxjt8qC1Fj5m+/BaZnFo6N/XM/P+4BdcWLhckp409jmE9hmq7VJfR9fTqLYz
         4t4f+oPpTFBDObN/VdmEhzSdksjEMn7tlbirYtm2dnY9L0XAjkNOiKbihjJ0sjnlKGT+
         Z4h0gzleEPLZQYtBD2U6P9UVOZD9h/prvDWhdXAVh8t+whNGx3/4x3GUwVfOiolW1I8y
         kr8kPiJApxQyG7jmd53jxNNf3LbB0aEMY87dIiX5ctlZolTxw5D8l1ZcH+Mm4Io73SaT
         bnMg==
X-Gm-Message-State: AO0yUKUYelwv/L906A2fKw84kUFrlI2r/AAPX1dIeDKrgXlRjUMRPe02
        oOT14gZxwKIaK0EXeCVeYfo6rtVVxw1DtFbs
X-Google-Smtp-Source: AK7set/1Gsg8u5EZA8fcBKB9kdH65gCgoUVWX3TMIqjLGRyl+q8jQhE4BO6X2f58xxHOBKcAVLyW1Q==
X-Received: by 2002:a05:600c:1d24:b0:3dc:55d9:ec8 with SMTP id l36-20020a05600c1d2400b003dc55d90ec8mr15856247wms.41.1676029760748;
        Fri, 10 Feb 2023 03:49:20 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b003dc43a10fa5sm5279319wmp.13.2023.02.10.03.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 03:49:20 -0800 (PST)
Message-ID: <985921d7-a07c-7ede-d1d3-82bd8a9553f0@linaro.org>
Date:   Fri, 10 Feb 2023 12:49:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 1/2] dt-bindings: gpio: nxp,pcf8575: add
 gpio-line-names
Content-Language: en-US
To:     Trevor Woerner <twoerner@gmail.com>, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
References: <20230210025132.36605-1-twoerner@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230210025132.36605-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2023 03:51, Trevor Woerner wrote:
> The devices described in this binding represent 8-bit and 16-bit i2c i/o
> expanders. Allow the user to specify names for up to 16 gpio lines.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
> changes since v2:


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

