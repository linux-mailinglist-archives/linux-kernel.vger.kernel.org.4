Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75DE6C60A2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjCWHZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjCWHZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:25:01 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0832EFF17
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:24:54 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id o12so82554593edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679556292;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7aipvafjjLK97hQq1M1+aKFzj870eMIthafBNa1UlW8=;
        b=vk1y0qQErHF68pGQeFp0zAZpHLDTx1HEIumAlovxGxapd/P6cSY2mCSFWB2ywwocLA
         b65AkCuIalo8x56dK5U19TpcWMokTC89gIBj4XNPtDzI5CUnwg25aKDTjBxjdhm73u/o
         ESe8pwhgbFt+kBLTCbRJfvyBe83G70vR8yMwCRGkChYCDgdqQrcEh1eSZstIDVtuRGzR
         1nR4/hyUNoj1kk/UVG4YZZZwZi22MxcH+MQLYT+2h3to8JWPdm9qHnEqtStFJBn4HvpO
         rvm/ZeHcKcphBmqDDKYUzFmKv/IAjQE7BoKvW9Bsxbd+hDpjuYQQ3Y80xenV3zzmItST
         sNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679556292;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7aipvafjjLK97hQq1M1+aKFzj870eMIthafBNa1UlW8=;
        b=fqIAEoKGSKFl6xVkuv0VxRerrXQrdwHsXQO3lY3rxlqrDJO4jOuwchTyn7Yznm2L8w
         qdbGQp1VgQWEHnQc6u+HlOU4zxGpm9QB2OD7X5E7idjO5NuRH7OFNgaLhHMdTiL3Ad3s
         gdQk5TtRl8bdqnE09rQQXIocuh6kaJovxo7R8gDSU9J8vc4SXJr09WDKSGQFW/6Dcb3G
         d7WduMnIGzSaWB3lpp2Sdkz26YKXay58EOb51JIPgDG0IhLEuxh6KKlHI9/vqgQpzqM2
         DKpXomFNbFPhZEitCitAvLYeysJI2WNjTSLCYp3xfEZAICCGiH/kvGhr0LaB39y25TB/
         +ozg==
X-Gm-Message-State: AO0yUKV3JNr0Nfw3oUlmHNdZmI8utA6r7wFWR+LC+0ZL9ar2kmDiJRsj
        LCQhw6MK8zAq9fculRGcTY7l2g==
X-Google-Smtp-Source: AK7set+NHWIImjZM/jhw7kzYeLDU9oIoj0+1vEz6iQvj2UjTwMEq7W3rX4D6U12tbtEWu4QfT22UIg==
X-Received: by 2002:a17:906:7cc8:b0:8b1:78bc:7508 with SMTP id h8-20020a1709067cc800b008b178bc7508mr8885663ejp.20.1679556292531;
        Thu, 23 Mar 2023 00:24:52 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a665:ed1e:3966:c991? ([2a02:810d:15c0:828:a665:ed1e:3966:c991])
        by smtp.gmail.com with ESMTPSA id n15-20020a170906118f00b0092421bf4927sm8381102eja.95.2023.03.23.00.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 00:24:52 -0700 (PDT)
Message-ID: <dfa8d83d-9254-4793-92b2-f247fb08b698@linaro.org>
Date:   Thu, 23 Mar 2023 08:24:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/2] dt-bindings: power: supply: bq256xx: Add
 ti,no-thermistor property
Content-Language: en-US
To:     Hermes Zhang <chenhuiz@axis.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Davis <afd@ti.com>
Cc:     linux-kernel@vger.kernel.org, kernel@axis.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20230323072347.438932-1-chenhuiz@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230323072347.438932-1-chenhuiz@axis.com>
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

On 23/03/2023 08:23, Hermes Zhang wrote:
> Add a new property ti,no-thermistor to indicate that no thermistor is
> connected to the TS pin of the chip.
> 
> Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
> ---
> 
> Notes:
>     v2: change property name to ti,no-thermistor

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.

Best regards,
Krzysztof

