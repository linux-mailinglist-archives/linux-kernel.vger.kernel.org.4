Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4566D6A8305
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCBM7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjCBM7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:59:00 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269E528215
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 04:58:47 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g3so11745030eda.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 04:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677761925;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2vVmmF2sI36t+dGidCoWeCzXUPaa6cM0yHfnPJQrwvs=;
        b=iyt20uqVFfkgyTkctVAvDZBFnnRN4DWQ+rcJp97tmuIUL6e1KbZdg5sPhd9wSNev92
         TPh6QuSgs9IhlckgwHWn63+pjXuXyNBOwXdOqdoohO2uudkYtCMNkSig0KpVRi4rwaHq
         VYud+w7JKGAId/rR6WmYMaWcMeg5n21FdL0EXP0F0DCxzd8S/c6CDfECsR/GKXkoOOFJ
         4qbSkcwU0k0rI4NfWgLP+dzAqWuvbgvJFl+9w7CPmiwFiIfgep9B4bTRez31pweIZiuB
         VeJFlU4ND0hlbFtj58Mc3P62nrWUqQ9raJy3cInOVy7o3bVdyGW5SQ9XD9VER0FAHUZ0
         M+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677761925;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2vVmmF2sI36t+dGidCoWeCzXUPaa6cM0yHfnPJQrwvs=;
        b=XASdmQ9f92o7jbhkfh7SxM47BmujNBwOsHE2xpcLvY37InDoJp/ohjff2EsSZzwYqk
         D9zaXcltc5T6NRjAE/r8SaWYReX9AJ6u8brQKZoK7P6PBuLdLzU+ngxqBG4cnHAsQkTf
         Q39Sk6zGQErfECvA8E42CHoLjBFVc/GcYxx0YA9cemVKvYdSy6KdLcY0yVqtL3TEDmEd
         a26c9i3JcMYQGgOe30cGr3mTTF30FN0JnAUdNmR+3Ve2fia4hIMcD6WLkQYxcaCoGUOK
         5gozPlVpEoH0EMR+YAb4OyOzGhLCXgBC+y3K1P2P/JfRq1b6bT0fsV1gpfW5aqHwPdxj
         /uLw==
X-Gm-Message-State: AO0yUKU3CE8xAoHqZ3Dsd3TKr+1vPsndy7QeiUXI7TzwWxreR7w9foQG
        C8Z58y3GCY+psl7wkIo8LzxmMw==
X-Google-Smtp-Source: AK7set9yzFoHBRZALvxYMI2qZ2Dhgl4YUhY3JtG91zpveRyK5yXkIoq9AHTSTjq6ovYpZ7Ra0ZwR7w==
X-Received: by 2002:aa7:c98c:0:b0:4ac:bdf3:36ca with SMTP id c12-20020aa7c98c000000b004acbdf336camr11290426edt.10.1677761925672;
        Thu, 02 Mar 2023 04:58:45 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d27-20020a50cd5b000000b004c0eac41829sm463097edj.63.2023.03.02.04.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 04:58:45 -0800 (PST)
Message-ID: <d29d44b2-3848-e64e-c397-9ccf6dba7eaa@linaro.org>
Date:   Thu, 2 Mar 2023 13:58:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 5/5] dt-bindings: gpio: Add Loongson-1 GPIO
To:     Keguang Zhang <keguang.zhang@gmail.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230302125215.214014-1-keguang.zhang@gmail.com>
 <20230302125215.214014-6-keguang.zhang@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230302125215.214014-6-keguang.zhang@gmail.com>
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

On 02/03/2023 13:52, Keguang Zhang wrote:
> Add devicetree binding document for Loongson-1 GPIO.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
> V1 -> V2: Use the same consistent quotes
>           Delete superfluous examples
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

