Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D3B6C939B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 11:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjCZJhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 05:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbjCZJhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 05:37:21 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13901723
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 02:37:19 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id i5so24530774eda.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 02:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679823438;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=womt1sTjj98HBWC12qs0rQLizgn/XM7va5jl8pNY4ac=;
        b=GHkGxIaUDHD9EVehc6ie2OQuCwM40c0Sa/sF8VYs8OH+m5MpI3q68BwrNW2YOW+ipo
         cr8ES+JlIAq13MyMuLYnUBFfN4xtMwH0x+BZO/eD5KI//izd5SSS38fr7Qx44Q47Osf2
         wx3toJdDGo5LVoFftdIU24vVQIn8RpVXMhDydizeu2K+WBADhg4BQNQWFubeMA6aaztF
         KbNI93cdJebCDYh1WgyGa0VIw1YzUdWOeGLBlbOmv6u+uf3zDtGkgxXqcjiT/BdkBipL
         R5X8U6f7aLAJxgX0s6M2UAxge20lJpE3eyn0H9NF1XHvtJV0pqA9jASBh5tFolIMR0nF
         Qh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679823438;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=womt1sTjj98HBWC12qs0rQLizgn/XM7va5jl8pNY4ac=;
        b=sbLa1s2gL9w6kPn0hxNbAnTvtNmOPu08Y56kVWC+5n/ffiFi05VDM4v+wZrvOIzyCg
         kbyqpk7iuj42hQMf9gh9yL0X4kevlzAWMUiRWHk/81SugD9vAkPG4D0iz5wIEQfJDl1P
         xP/ku0lRNJMNYxxcZBXHg8S3SiOi9nPe0EyZqx2pLedd8wssS4OHXXRBEorg3qLHNimP
         36paMvQnrZd3Ajd0158K5EyQUBwKChdhdQxjfv22VPhimFeu/4H2i86yGMnBtY/DZT5n
         ktazSiAJ+5mOvaHYkaasYCNzvMqN/hbo02kZEeQU9XFqrbwc1notNeXDDE6RyQVGzui/
         v9YA==
X-Gm-Message-State: AAQBX9fjyPAl7UCaxzCnSwQbByW52MrCSyT7Em0qcieBBFKkGseGW6Kp
        1vr5uCZEEkcnimWyVu8pFb09Hg==
X-Google-Smtp-Source: AKy350aR88wKTInMhM2+4A7tNI6V5uRWI3jQ2Pt0sIPnZuOvt7Cl/gcLtj4c8VsNeo0rbho+lF/46A==
X-Received: by 2002:a05:6402:8d6:b0:502:2953:8ecb with SMTP id d22-20020a05640208d600b0050229538ecbmr5138565edz.13.1679823438181;
        Sun, 26 Mar 2023 02:37:18 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6cac:926d:a4f2:aa09? ([2a02:810d:15c0:828:6cac:926d:a4f2:aa09])
        by smtp.gmail.com with ESMTPSA id k12-20020a50ce4c000000b004af70c546dasm13284309edj.87.2023.03.26.02.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 02:37:17 -0700 (PDT)
Message-ID: <10930783-e1dd-5e75-a2cc-a09af862d949@linaro.org>
Date:   Sun, 26 Mar 2023 11:37:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] dt-bindings: clock: update rk3588 clock definitions
Content-Language: en-US
To:     Shane Francis <bigbeeshane@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230326001535.149539-1-bigbeeshane@gmail.com>
 <20230326001535.149539-2-bigbeeshane@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230326001535.149539-2-bigbeeshane@gmail.com>
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

On 26/03/2023 01:15, Shane Francis wrote:
> Some vendor uboot bootloaders use the target kernels
> DTB image to determine the target clock speeds for
> some PLLs, currently this can cause uboot to set the
> clock rate for gpll incorrectly on to cpll (breaking)

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586

> RGMII.
> 
> This change starts the PLL clock definitions from 1
> to correct this miss-match

Unfortunately the reason is not good enough for ABI break. Replace
vendor boot uboots with open-source one or just correct them (it's still
U-Boot so even for vendor one you have the source).

> 
> Signed-off-by: Shane Francis <bigbeeshane@gmail.com>
> ---
>  .../dt-bindings/clock/rockchip,rk3588-cru.h   | 1442 ++++++++---------
>  1 file changed, 721 insertions(+), 721 deletions(-)
> 
> diff --git a/include/dt-bindings/clock/rockchip,rk3588-cru.h b/include/dt-bindings/clock/rockchip,rk3588-cru.h
> index b5616bca7b44..d63b07d054b7 100644
> --- a/include/dt-bindings/clock/rockchip,rk3588-cru.h
> +++ b/include/dt-bindings/clock/rockchip,rk3588-cru.h
> @@ -12,727 +12,727 @@
>  
>  /* cru-clocks indices */
>  
> -#define PLL_B0PLL			0


Best regards,
Krzysztof

