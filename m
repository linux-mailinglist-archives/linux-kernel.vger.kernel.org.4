Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3738F638EE3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 18:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiKYRQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 12:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiKYRQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 12:16:16 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3870E51327
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 09:16:15 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bs21so7714756wrb.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 09:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D5t5pk/Tw2Avo20xT44DfzVJuCpgbHlNJ6TbleqnB8c=;
        b=nIX/RrPlgp/BOtELVRhcFd6OE1QFdwbFsoHrePhw1cx9839H3Ixo+BgSJFMGF+jzO7
         TOo8dOoN798NqveINmFSHegz/B7bGBM5mkNQlCPyrc4/Gf87XRVv21qPPSOxfJSdpgEM
         2qe0v+t43jzB0fXsBfd0jGTYProEBC9XYQzywO37nclhh9o+aItgx/NTsSbn0Ydo7NN8
         DIDKRUyTUJsRQ/EKC3LnCTX+R5z2vcPGK5M7UxYkQHgEYSaTfaFpLqV6Roh2wtj/Q7Yg
         MQeu89ncHiSTtHfogJ2nW2SYe6HfsRyp8Qwst4nc6gTj1lq+Z5vHNZ42ujPmwk+a64P9
         TysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5t5pk/Tw2Avo20xT44DfzVJuCpgbHlNJ6TbleqnB8c=;
        b=qFOtigYMhNQsLevMCc4ap2bjSnyvjvxsXyTQsNix4UsPDzpaEwxetT7P1yBx9DRWB7
         DMlrrYNliS+ufSa3xz1dC4WwFw+3obYOXu3UEQFHmnPX6gPWSNNTYC5FhjaGPEQ0y3Rk
         HJpJI/9W8LcB7W8kMt/9BKvD2KGjl/VqNFOJtYYbofD42Ygo3bwOEA7u1JpS2JEDogZi
         H14S2hInymBWVfNbTDpuabHhJvCgmJwpstUAjJik4xiM1fAXaZ53Rdq0+S+m7gYcNeID
         GR1E9axgdKVKWkX3hxeLCWWtmcWxKMe+8RuEHTGrXW5HJILX3HP6Pfg2eFMkjz5jHdIv
         mylA==
X-Gm-Message-State: ANoB5pmKk8I798XdQS5LgtmAR+i+JJ05iCxsyOhYluTI8LlhMsWTdraD
        334JojEqQMYWIlFeFNM4f8/4mA==
X-Google-Smtp-Source: AA0mqf7Rcx3H1sfAYSftgETBIQmzgTPqE79fmZWHKA/WNteq3AkzMFTo1swYpB3H3F1/pas4fOKOhg==
X-Received: by 2002:a5d:5b19:0:b0:241:dea3:ad48 with SMTP id bx25-20020a5d5b19000000b00241dea3ad48mr14423755wrb.357.1669396573516;
        Fri, 25 Nov 2022 09:16:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:84a5:7e09:b15:f1fe? ([2a01:e0a:982:cbb0:84a5:7e09:b15:f1fe])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b003c6f8d30e40sm10667777wmq.31.2022.11.25.09.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 09:16:13 -0800 (PST)
Message-ID: <c8d9e319-238c-8c33-f146-90d292cf63d5@linaro.org>
Date:   Fri, 25 Nov 2022 18:16:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] ARM: dts: meson: align LED node names with dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221125144120.476933-1-krzysztof.kozlowski@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20221125144120.476933-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2022 15:41, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern:
> 
>    meson8-minix-neo-x8.dtb: gpio-leds: 'blue' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm/boot/dts/meson8-minix-neo-x8.dts | 2 +-
>   arch/arm/boot/dts/meson8b-ec100.dts       | 2 +-
>   arch/arm/boot/dts/meson8b-odroidc1.dts    | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 

<snip>


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

