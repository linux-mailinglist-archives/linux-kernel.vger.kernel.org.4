Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D006217AC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbiKHPIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbiKHPIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:08:11 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94365984B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 07:08:09 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id a15so21537773ljb.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 07:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dxuSjQQzX1RM95YkYXalJ1eZyx8ddLlbivHitTI2euw=;
        b=UDkV2KaRJwIbQGfRAf9vTI1RRf0tgbk7J70ljv4JduqyU7stB0Mnx+kzPaYRCqUU8C
         qkp5u7KSAw7jQML1Tfu3PliM8r+sZG18s4obfyG0o7U7LAPEC8jh9Uaa1d29JlIzEqbP
         GXS7dBE6yiKMSf8HDrSw/bo5qTOErtR99iHpsSVv8nY9v/Da4oko5bUtuhv2X/qkfnPv
         0BySFbxBIV316vZ2/uhD/qzDHg0bZnR3Q8X6fMZqyleh07c24IFp2ZbzgTezNJ361KiJ
         RGnVOCYCzM0wpIV1M653iX9Z3qQJrn03vbqbffY0OW+Ok5L+Wl6uAURiuGD1WLIyT3Tt
         qkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dxuSjQQzX1RM95YkYXalJ1eZyx8ddLlbivHitTI2euw=;
        b=czU707rD26Xe6Mi8N5BQsP47akWjWKagK8pr5dHAbxnjuK1WwMapdiMQJQps2ahLmb
         BEIAGyRc1dgxpzjHifSBpsdq5ZW0ohHoUVDwSqG5fAr2p2nHM5R/qjSz2sAKY3ocfQik
         6r/3ROzbr2EFMyL7x+ZxI0uudyjuQ6AAJrRdHGbeb8Lolt28hwLTs/djdexNXVTtM8Em
         BiVu1JeMha6kbDuMLHDek2YQsEtfFsScDlpj4HBSKQnSK35hY0KTlWEzkJQbFM/JV9kb
         h8zg6O0lgKKcGYUib+OJBnxjJh5fW6uxu0KJty/OqqItnLaUjkJC1591wvuaRs7HIMch
         9vSA==
X-Gm-Message-State: ACrzQf1GIzj0oit/QkIyYdqLcd0XGjF1GNaGD95NBox632WUe8qmc8vp
        aoUkUFYdJ/MJ+ghXPRUzpVzMIw==
X-Google-Smtp-Source: AMsMyM7koYXxWta2JrWEZEMkyOKz1kAmD5fKSddG0qWZ3clprpPepriJeX/xC31/PxrQgRAPOAXx5A==
X-Received: by 2002:a2e:8ecc:0:b0:277:34bb:ea2 with SMTP id e12-20020a2e8ecc000000b0027734bb0ea2mr6538534ljl.427.1667920088283;
        Tue, 08 Nov 2022 07:08:08 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id cf36-20020a056512282400b0049313f77755sm1809536lfb.213.2022.11.08.07.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 07:08:07 -0800 (PST)
Message-ID: <784c5975-661a-c71c-1489-229ada0a4e72@linaro.org>
Date:   Tue, 8 Nov 2022 16:08:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/5] dt-bindings: arm: uniphier: Add system controller
 bindings
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221107103410.3443-1-hayashi.kunihiko@socionext.com>
 <20221107103410.3443-2-hayashi.kunihiko@socionext.com>
 <48988a50-3c3d-7a85-af28-66f7842e5893@linaro.org>
 <3fcebf71-bdcb-8592-020c-4aa240a9e9a7@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3fcebf71-bdcb-8592-020c-4aa240a9e9a7@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2022 15:30, Kunihiko Hayashi wrote:
>>> +additionalProperties:
>>> +  type: object
>>
>> No, instead you should describe the children. This must me
>> additionalProperties: false
> 
> Each controller has different children, so need to define children
> for each controller using "if".

Then you should have different binding documents. Bindings should be
specific.

Best regards,
Krzysztof

