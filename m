Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2476C54D4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 20:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjCVTWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 15:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjCVTWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 15:22:50 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8459564219
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 12:22:48 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eg48so77189289edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 12:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679512967;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nTKQ3ZygIopAvL2jDxWoG+gvCLOc1nUSNh2/VIjwflk=;
        b=J6UrzSOxIfsSAGfarsx/7WV1cN3Zaa1DcTuRkrAgrG0P3yJdRq4UhEaC5Oo89PYqbe
         Np//+H0K8YyWJ18GHp4Av68Eyr20MgiUMyOxJTjZxBImgvLcqmTFa7JmBTf2BauxGMux
         Js55BxNFMNSgGHtyXeAB560pXWbksRF2TokLTY/N/HGkCjIzmz7VC4xJO/+h5Dyc1pR4
         RoaS3Mi+MOhG9fFlqyLZntdPIlBajyujClXSlWZpQbULSEhJhUWtHo9lOz/ReaDuraHn
         HJ/vAJXts2P0yrtl8khYdLjThO3iPUhASpzXDtODe7Df76ZTE5uvgm/JtzYqXWy4f3K2
         YRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679512967;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTKQ3ZygIopAvL2jDxWoG+gvCLOc1nUSNh2/VIjwflk=;
        b=WkqTPpFNbgsAB3YP/o1XmW90RUQiSkmYS9STWUMc0M9ksi2Jce/AQG3V8JoNc1BwyU
         0jsGSNGcXyJq46IkJ2UUrgSOjEbYJXe+r452A9xMpOrXP3ZBErl0VfUsdJ6V311Ee1WN
         kXtAcrpma+larB3B3tbqo+33Dxa1OiuKFFg2VoV30sH1OlPIcNvfjOEwF2U+IS+cXN2+
         +PXugumYtsFOBpp+rxN5N8TXU7gaSEfcFbrh5g4YNJ5LCKvfxQo83EgD+thUr/BUVah9
         YlE+5EDjDc6BNPFnEOeqxwfGAjqVIpG3oULrgVUjzvjHyWzA5TiuwIc4V9HrSMBdeJnd
         WhXQ==
X-Gm-Message-State: AO0yUKV8bWsIJYdk3+8FKMtDj1Su/U3pw4wLTpTILz3RI49EQ9ywnxSu
        eOlqLWGEYTsRYrmstw8G1oDnEDD1UzYy9c/LLWg=
X-Google-Smtp-Source: AK7set+2geT/YIlyw08nwL32m20e6Y8ea7NV7M3LNBgLzXYsRty6f7SIjxzdEFic/yqzyAWm6zz2fA==
X-Received: by 2002:a17:906:606:b0:88a:2e57:9813 with SMTP id s6-20020a170906060600b0088a2e579813mr8377898ejb.33.1679512966999;
        Wed, 22 Mar 2023 12:22:46 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5050:151b:e755:1c6? ([2a02:810d:15c0:828:5050:151b:e755:1c6])
        by smtp.gmail.com with ESMTPSA id g5-20020a170906394500b0092fb818127dsm7681645eje.94.2023.03.22.12.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 12:22:46 -0700 (PDT)
Message-ID: <affc7a51-c29f-968e-c15d-ccd13b0c530e@linaro.org>
Date:   Wed, 22 Mar 2023 20:22:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] arm64: dts: tegra: drop serial clock-names and
 reset-names
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
References: <20230123151543.369724-1-krzysztof.kozlowski@linaro.org>
 <cd9d9983-3dd5-70dd-8155-1b7d856bf35f@linaro.org>
In-Reply-To: <cd9d9983-3dd5-70dd-8155-1b7d856bf35f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2023 17:59, Krzysztof Kozlowski wrote:
> On 23/01/2023 16:15, Krzysztof Kozlowski wrote:
>> The serial node does not use clock-names and reset-names:
>>
>>   tegra234-sim-vdk.dtb: serial@3100000: Unevaluated properties are not allowed ('clock-names', 'reset-names' were unexpected)
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Thierry, any comments? Can you pick it up?

Hm, so I guess it is for me?

Best regards,
Krzysztof

