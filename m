Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09DD64C9BB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238474AbiLNNH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238502AbiLNNHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:07:52 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E5F15838
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:07:46 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bp15so10292183lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UxFvJ5yILEbKmEb0g4GXgsQ6Gn2FjkzpKDnB0GaBVKA=;
        b=QLPQMJNQVxwwGYrpuGhINVtm2ygZjDhGgsSXw1S47NWf6fSUfbfJOgTumt7Lhu4iFy
         qys2EJnQ/2AFBLjbkDI3DaMVw4M0Fs+nqoY3HQXG0Jrsruvs+EJ3SC7/1XPayEBuQ1CN
         hjUw5vY4I1exDTQpKDKoIexXAWcU3Vvh+eYTqRawBqE1wNpMzaIarr4Ch09lyJXuhR6r
         rn9/v/zA9li6/yzw8KQZ67dI1Jxs37/jcqDxx0UU3zejowES3WmJOD+dd4EYv7G60dHp
         ANbksW0WXMPO3JyX7CDiBPJgTAScH2ajwu7MxYC4soYzJk8BZrPX3P0k0ywNe7Q8scd/
         siIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UxFvJ5yILEbKmEb0g4GXgsQ6Gn2FjkzpKDnB0GaBVKA=;
        b=mnU1BYrhhhrz5NGEjeDNh8I7FoPcoaG5G5fAmEr99GiRvx6GtjWyvcB1kVf4iszeAy
         V54Uv8bqeOtZvMRMnh6QCPUqSnThSFjyiqqiT2A+Pm0otK3krFh66h7A2gV3jtUBJOx6
         /TkpsGiCilDfVPlG/l4zU+OU0dPNsMCFmt/5t7ttF8Whr7bSBKX0P9XqYt4gtxvlXHZr
         Ee2HGAw6xh3A6s10++qMacfjA5TwN5z7W8cffD03kgNjIaKwZpvJniOXLasxOP4m+o0B
         Z+o1z9TUayPphkx96tLwXppfmmg41suUN0+MVrfuETDBRXJn/Gkafkvn0MqZffKQ6uoZ
         Fkjg==
X-Gm-Message-State: ANoB5pmMUQaKn/NdUeKXuwT7Kh+oXmYXbLxLQx527XkCU9VcJpvIk+KJ
        1XaxqRFbKyBUQFdR2vGXkkPl4Q==
X-Google-Smtp-Source: AA0mqf7/d8FABL0kuN5nbJ7lUH8ThjOSPmav6hXaFMvchKZVWrBEHXEfmbYGuz4GxGpPr+zwRJLWhg==
X-Received: by 2002:ac2:5550:0:b0:4b5:71c4:8cb with SMTP id l16-20020ac25550000000b004b571c408cbmr5732770lfk.12.1671023265166;
        Wed, 14 Dec 2022 05:07:45 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bf6-20020a056512258600b00498f570aef2sm801176lfb.209.2022.12.14.05.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 05:07:44 -0800 (PST)
Message-ID: <f84697af-3b19-c0aa-2faf-ea624746ea1a@linaro.org>
Date:   Wed, 14 Dec 2022 14:07:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 17/17] dt-bindings: soc: socionext: Add UniPhier AHCI
 glue layer
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
 <20221213082449.2721-18-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213082449.2721-18-hayashi.kunihiko@socionext.com>
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

On 13/12/2022 09:24, Kunihiko Hayashi wrote:
> Add DT binding schema for components belonging to the platform-specific
> AHCI glue layer implemented in UniPhier SoCs.
> 
> This AHCI glue layer works as a sideband logic for the host controller,
> including core reset, PHYs, and some signals to the controller.
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

