Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7D06CD42E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjC2IOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjC2IOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:14:15 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E656F44A7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:14:09 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bi9so19052884lfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680077648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6epDWvuA89IZftBOHmpRGI6nNmDhKZVL9v8m3KDYPMY=;
        b=KyikktgcRn+2oLGotGbR3cLkZ5AoQE+pkPvCnBj+4WY0K3ggGHjzQk/VtduH8nikOC
         rQqW1+1hJgYQh8xAZJN8Dyy2BZfTEvVObFm6cJO09yfEXm3JuVrgqaJfmNFK8rg0B9mk
         gptmmjRJL85VZ3IXZJUBSxECR68U+xspO1AjK16C20bavkiaI4+pyyQ7PiKCWGhdsnz7
         O9AZ3qWGnBEEVWMKWItA2msmnJCOViSe1ohnukmns8rfK5CtcWHiYkyPXmUaKejBSBqV
         /amR1c7K1TMpJgA00IPaWJ2mfcOgsI6aN5a7V4OWd5OnjO9StMQHbtX2DiJp5OFsxNMF
         kSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680077648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6epDWvuA89IZftBOHmpRGI6nNmDhKZVL9v8m3KDYPMY=;
        b=e/OidKROlIwDFhpkkh8KtS9FRfXsoSccfAgyNjwBUKkVzqFd3ud8xD+7x3xYIMEsB0
         bFJRfo/kyisUm3W4M3pOyaplDdjDec/Bt3Mnk+Vw87hXt25HKWMsaQ2oJvsIvLnXHLpt
         7rsQ5oWWDchsJTJl/bAajmYBA6cSKIrxvm1VAvu9zQgMxjVtfgifRdn3p2jLS+PTojJ0
         kGzfIWP5s+WvLdNsorumbJpzT4WC5oWetSGRESy6Gzy2J0riWLKaSXw4WzznVVTtGVCZ
         yQ6n2aLq0Kru/ch2H6K3WWiCSgQBl/QulfkIc+OX9ZfVtDHuoo+kDZ+4LaflywGPuYH5
         ABKw==
X-Gm-Message-State: AAQBX9dhiXLtlyjA7QFcHwN7JtwHYecl10FBP5mBsXabBpE1z2zeLbNb
        40rAIVleOpcSTxIfgKzXP0ZZvQ==
X-Google-Smtp-Source: AKy350ZWrzkfe66KC35c/EV/QpRnsJJJywHJ1ynk7vqTGq6hgUz6/3XMtXOvRUqooYqyqbvxk5ZCDg==
X-Received: by 2002:ac2:5ddb:0:b0:4de:d16f:3938 with SMTP id x27-20020ac25ddb000000b004ded16f3938mr5731648lfq.53.1680077648225;
        Wed, 29 Mar 2023 01:14:08 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id m15-20020a056512014f00b004d0b1327b75sm5405102lfo.61.2023.03.29.01.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 01:14:07 -0700 (PDT)
Message-ID: <3e907d9a-cfb9-343a-bca1-9de773c98724@linaro.org>
Date:   Wed, 29 Mar 2023 10:14:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 03/12] dt-bindings: clock: nuvoton: add binding for
 ma35d1 clock controller
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-4-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230328021912.177301-4-ychuang570808@gmail.com>
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

On 28/03/2023 04:19, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add the dt-bindings header for Nuvoton ma35d1, that gets shared
> between the clock controller and clock references in the dts.
> Add documentation to describe nuvoton ma35d1 clock driver.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

