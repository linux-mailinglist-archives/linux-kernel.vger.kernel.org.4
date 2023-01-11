Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02792665924
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbjAKKi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbjAKKiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:38:12 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5581085
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:38:10 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id g19-20020a05600c4ed300b003d9eb1dbc0aso9311101wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jL8bdyRPY1NcExtbiegzjvNk1MnzQ71tWSU8fsf/VCg=;
        b=TMZ2c4LfuAn0iG1uB0odaHKYEIjH1TrkA59vsulAFrdwZlEPgcUg8WgUwJ+/r6EAEE
         7W0UNZ9UsGzLFRl/YFFmdaua4sub9Hv/UV1qcIpjUn4Y+7O04y+jM5Lg1RO8VCxLwLOn
         nD2XMr/LHL4TdMSbi4LME8nu7G3EqyxAgZEJx0hY/dsQ66QXsX6SkV19O10vslB5tK/a
         RLNwfjFfjYeeKj/rFOuln6dbYjkNWlBEXcDuCwEhK4dQbmCmYyoi6Hfm6YYfqWCKekSt
         JMEH/hRxCRgE0SXiN4q56yrGczFGzJ54dqF5uyb087kLZvjghmL2k8+rDxES8UWLTRF+
         V5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jL8bdyRPY1NcExtbiegzjvNk1MnzQ71tWSU8fsf/VCg=;
        b=WLov/6ImKw+ymH38EriEDdIjbPeFKGMLPn9icTCSCjK71+bSX4o0CQ7nfV7RQXjCoW
         ZedVt4+VUJa1E6pfsOuDruedTuHrVjOD/Z0dimKIADBCkhVTaoOIDpEIQzo1AisAB8iW
         Z1fRiXM6uowf3sID041LptIDZaT9Lch0hMPcGbNZ+R/wMgDPiPyEO958qC/2oFoxgN2l
         KNSKUZSs4dvEqcbii9bw+LKAWqtuAFy1mQmTYcwcnVz8C01SAl8/tYX3nGRDoqwsc0uZ
         /A1kQwoUcUMonOJHD0hQo8tZIGQdpHRF0OiBYQvyCtuqu+P7iRacnMDDagvmoVhdOWoS
         wZXQ==
X-Gm-Message-State: AFqh2kpt4j5MGl1NRoeHRXqc5KuU6xOHHmLFJVEwgK4etsohY6mMxKvo
        5KXpIitHqGRZlMcB5LQi0YoC0w==
X-Google-Smtp-Source: AMrXdXtMBZkDg5eU72KkLHfQX3lI/6XIjTLZFPJqac2B2TGmn77JlJmeUvXko1SMKMq8Pu25TunGIA==
X-Received: by 2002:a05:600c:ac8:b0:3d7:7cea:b410 with SMTP id c8-20020a05600c0ac800b003d77ceab410mr51917041wmr.33.1673433489574;
        Wed, 11 Jan 2023 02:38:09 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c358900b003cffd3c3d6csm19644020wmq.12.2023.01.11.02.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 02:38:09 -0800 (PST)
Message-ID: <98d2af06-8ef3-bb6b-1f29-4e33c1c748d6@linaro.org>
Date:   Wed, 11 Jan 2023 11:38:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] ARM: dts: Fix User button on stm32mp135f-dk
Content-Language: en-US
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230111100725.463136-1-amelie.delaunay@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230111100725.463136-1-amelie.delaunay@foss.st.com>
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

On 11/01/2023 11:07, Amelie Delaunay wrote:
> This patch fixes the following dtbs_check warning on stm32mp135f-dk:
> arch/arm/boot/dts/stm32mp135f-dk.dtb: gpio-keys: 'user-pa13' does not match any of the regexes: '^(button|event|key|switch|(button|event|key|switch)-[a-z0-9-]+|[a-z0-9-]+-(button|event|key|switch))$', 'pinctrl-[0-9]+'
> From schema: Documentation/devicetree/bindings/input/gpio-keys.yaml
> 
> It renames user-pa13 node into button-user so that it matches gpio-keys
> bindings.
> 
> Fixes: 57012d79fefd ("ARM: dts: stm32: add UserPA13 button on stm32mp135f-dk")
> 

No blank lines between the tags, but I would drop the Fixes anyway. This
is not a bug, but convention and coding style.

> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>  arch/arm/boot/dts/stm32mp135f-dk.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp135f-dk.dts b/arch/arm/boot/dts/stm32mp135f-dk.dts
> index 9ff5a3eaf55b..931877d6ddb9 100644
> --- a/arch/arm/boot/dts/stm32mp135f-dk.dts
> +++ b/arch/arm/boot/dts/stm32mp135f-dk.dts
> @@ -40,7 +40,7 @@ optee@dd000000 {
>  	gpio-keys {
>  		compatible = "gpio-keys";
>  
> -		user-pa13 {
> +		button-user {

Best regards,
Krzysztof

