Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714F3690304
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjBIJO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjBIJOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:14:54 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6825B92
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 01:14:53 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ba1so1072682wrb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 01:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w6LkxZ/ozleS6gLSs0StGzehaVAeduo5o/LmquXsG8k=;
        b=lih8dgUGhVGc8S80Uh5n8I03OQ7SCoC28FUFGZ5BTXupIfHRzzxlvfgxP4aegEZh+8
         ljHXXoIjqF5QurcowNHngIg/gyQBTDmPJk0gGVzMG7x0WJu2BdV6r+gHQCDSY3Zcmitz
         QfiJGEFprgx7VNIod8/r8uC/GkuXk859Nh6VSKHOUoETmooJUasQfK/kIIQpNApDpQie
         qgWDzQWliPk1jD5iakJcwb9tutiIa6upxniMAxl+S6VnU4eQvngdRMuiywsAMLqT7Zgb
         leBxQkjAsO3tw8MJdiJOdzmqhBkeIyc6bj2CTQvN/OAKjFi9mkAFGBLCXUOcnLfXxJsd
         +knQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w6LkxZ/ozleS6gLSs0StGzehaVAeduo5o/LmquXsG8k=;
        b=5v0GxTLRUAX4HaMXDXvda/BTrUT1QPFLQRWbpHt2SzXmQuZi4EuFvo/dSk/g+R86vw
         ImqXqEMae7nOuqhkPh0a7h2dZPjdUTPQDPehmDToRml1GLzofMDnjrXrr7byshRkH9la
         /OF+RcaIkXvlkCoJbmIGLJcKLq2f6HlSUT7sNVxjEuub8HKVK/J7AqXsF7mwA4N4gmKd
         GUTGuH6C7Zo1UHhdVtJJKihHC84i7NYC7XFn7wW3R/r3UFmcN2xxN/rkX0eql0UA0WJm
         2tUVxkgnY8ZpZ98O0DDDPtpegAKTIJKpSXPZs+98ZPN+d3RdEG7rne9OJgRNnD3vJ2fu
         AXjA==
X-Gm-Message-State: AO0yUKUmIrCRp9GLsue3lQjdftyi/Obb8W20ioH7elWMgILYTycrXnx/
        DZ60P4gxWJ2bhluOEChQkeIuZQ==
X-Google-Smtp-Source: AK7set9MKJaV9uooZiLHtE9y2zvn5dEl+dTyYB7cId1QM2tDmoDalVOi6rUSBC9nrIoaL1PTa7Ln0g==
X-Received: by 2002:a5d:5545:0:b0:2c5:3cfa:f7dc with SMTP id g5-20020a5d5545000000b002c53cfaf7dcmr576923wrw.7.1675934091566;
        Thu, 09 Feb 2023 01:14:51 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h1-20020a056000000100b002c405e19010sm764853wrx.11.2023.02.09.01.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 01:14:51 -0800 (PST)
Message-ID: <ec412378-ae31-e199-b5a1-f37a4731f31a@linaro.org>
Date:   Thu, 9 Feb 2023 10:14:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: mmc: Add resets property to cadence SDHCI
 binding
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230209014211.17816-1-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230209014211.17816-1-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2023 02:42, Kunihiko Hayashi wrote:
> Cadence SDHCI controller allows reset control support on UniPhier SoC.
> Add resets property to cadence SDHCI binding.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index d3dce4d6c168..adacd0535c14 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -29,6 +29,9 @@ properties:
>    clocks:
>      maxItems: 1
>  
> +  resets:
> +    maxItems: 1

This looks specific to UniPhier, doesn't it?

Best regards,
Krzysztof

