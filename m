Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FAB6CB76B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjC1GoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjC1Gnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:43:52 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B51330DE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:43:50 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id cn12so45400582edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679985829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nmTvziNt2VFrSmXaXHn7cfTQldiBzclyda4PoCjJxWE=;
        b=DPaN2l40XfdN9xbWxJI9FLfIuX9bVwJgZdpiuAH2PKxv20nB7cEwX+D0+QXFsj+zH9
         +R1BNX9t/VB8qVFQX5HRW8ldTicErtXgvtiRUpE7zBGyldIZP5WMRiHTutasVJh/FI1k
         +U6SCuoWIjlfn9DFlpm45jzH5IpyHbU/g6/OEdC7WV2Qw19yaBwU6RI10CZzUfrWiCga
         qmeHp8d+OVI0OgV5MdMsDiXhHo6wAkVBSHzkWHaMdQmrA82iwZKi05gRY3EIoeZyuwZq
         pt+R/cAjakQZJ+U2JdSc4cGhXofPFgzr4dqJVbVgSWSdtyq2N2+9d7Vl4u5O7fAJxF/3
         ziyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679985829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmTvziNt2VFrSmXaXHn7cfTQldiBzclyda4PoCjJxWE=;
        b=EOKELYDgfTOHgcBcXoMyGNxhhs4HaxtFkSiBB0VtrW2yoaV7Tqv42St5zB5a5fyZz4
         vk5tKGm93pLTY7lvvTruFQyR9XkjeqmdeGWDB0vLYCs9UBpIWVlDpAxZkmH4aeDbvPKV
         4mHSLWJcL33iniyX1uDWTf+OiJdiw6utinw1mU9hrSrKSsDeJ2FekbZDqxOYIHRQwnaw
         Lc1xaa0QkcBGpK3glSkg7Cdh31lCuckM9hxsJLY8EE9xchCH10zhsu2nRwG7b23GRyjb
         ZSOuMOBeRwuqzRtqci5M6pMVbyxrrxa6oSA+W39tjdYPtqlXgtTHz0RSvdnAKgzros3J
         3xLQ==
X-Gm-Message-State: AAQBX9cFFvZ6W3KIrsi8y2iOommquISqx2oAl3m8+88XXGKQ9Sjr4+sL
        Yeclheak2+yWh5rxML6IbbvoQA==
X-Google-Smtp-Source: AKy350ZHO7213F8SJfPOYH/2LqcuXOEigoE0IsXpMbVKyLHe8zZ/kqfEcihEQE/XDSC44GiNCdeFFg==
X-Received: by 2002:a17:906:b303:b0:933:48ce:73a5 with SMTP id n3-20020a170906b30300b0093348ce73a5mr14652999ejz.56.1679985829059;
        Mon, 27 Mar 2023 23:43:49 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9e92:dca6:241d:71b6? ([2a02:810d:15c0:828:9e92:dca6:241d:71b6])
        by smtp.gmail.com with ESMTPSA id s30-20020a50ab1e000000b004c5d1a15bd5sm15404666edc.69.2023.03.27.23.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 23:43:48 -0700 (PDT)
Message-ID: <07700bca-a717-aeb1-2658-a1dbda00affa@linaro.org>
Date:   Tue, 28 Mar 2023 08:43:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: reserved-memory: Drop unneeded quotes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20230327170122.4103518-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230327170122.4103518-1-robh@kernel.org>
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

On 27/03/2023 19:01, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

