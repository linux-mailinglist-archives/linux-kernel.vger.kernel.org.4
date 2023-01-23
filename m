Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C7F677603
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjAWIDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjAWIDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:03:01 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66E610A88
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:02:59 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id z5so9940846wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L+/LEyafvrzRBNQfwpLMrHaX/IXg4RLqYhGHRgZfqdY=;
        b=hztSdvYoPxAlYSgA8cwKOLMwmFNOZ3wWzZuYWZMqGEEjd29lEpflmWYbVIqwLN3Wd+
         oMFmRi2TG5/tlaacBoXpZh32jtyOu0boeNiGmn344gEtmW1x+lmSbWCo0hWaAOQHv2m6
         wGsYGLjj+1uYVy85O5AL6zGiv+YrnCYrW04CyZXZhxIgWNNVXm/maQqN6vIwJqPz6qCp
         711eSuSJBelqXAq59jS4sOMsN83c4+s3htPM+NRveQn46QjAwkHaQ6qUfRfcJUC9iXIf
         TAhxdgtSIdPOWT0uEsfZRW9wQu7QK7jincukPeLjpAeryl+KMejJnaboRzFXjVYFHxIm
         G/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+/LEyafvrzRBNQfwpLMrHaX/IXg4RLqYhGHRgZfqdY=;
        b=fjU/LMfrRGlo2DHuA1UBtmaiL9+VcRNKs+fYFwD4gj1lqO5SxGze5cVklGKmRKb/8f
         wBm3BNqL0tOV9XZIT8Mfyp04osuhZ279TpJLrqQolzLNZ7JUqTRi4Dn2gDXPJe+N0oKa
         Tyi+qq+SEpUUw/E2fCQvalZLdaPwTS+HJqmZmFWka1xEx2wNA8E+OkljHkjao3RrJ3Iq
         obrOumWYghAbV5yfPuxKh/EZ/HHfM1B+2P8HD5WdfB5L3Xkuttw02qdJKyZ6wgCrMvnQ
         KNAQlSgowE8GrtoYJspx/fjWm/KoAoNqAB+wqSvK5n+1+PqlyQPFoP+JIGGBcoP1iSDV
         BZQA==
X-Gm-Message-State: AFqh2kpMUxT4Nz3UOTIfBGG9Jnp6s9BrqagP4YgsDTGF7646/zWgCxN0
        lKCjj3pXp5m9BsORMdip+GPtxg==
X-Google-Smtp-Source: AMrXdXuFrk//CycjPiIHVrOZNJgUIMs9Ab6DxODQhSd31W8UwCpUudB20q2U9jMNWs1eK7Ub5lPZVg==
X-Received: by 2002:a05:6000:1f14:b0:2ba:f3a5:d0fe with SMTP id bv20-20020a0560001f1400b002baf3a5d0femr19682048wrb.63.1674460978415;
        Mon, 23 Jan 2023 00:02:58 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bt14-20020a056000080e00b0027cb20605e3sm18169155wrb.105.2023.01.23.00.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 00:02:57 -0800 (PST)
Message-ID: <8f657c8c-ddc0-cc9f-bab1-fee0d83fd02d@linaro.org>
Date:   Mon, 23 Jan 2023 09:02:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 02/15] dt-bindings: vendor-prefixes: add Ambarella prefix
Content-Language: en-US
To:     Li Chen <lchen@ambarella.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230123073305.149940-1-lchen@ambarella.com>
 <20230123073305.149940-3-lchen@ambarella.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230123073305.149940-3-lchen@ambarella.com>
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

On 23/01/2023 08:32, Li Chen wrote:
> Add vendor prefix for Ambarella, Inc.
> 
> Signed-off-by: Li Chen <lchen@ambarella.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

