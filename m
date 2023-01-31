Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCF26833EC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjAaRcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjAaRcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:32:12 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36A256ECA
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 09:32:09 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h16so14912721wrz.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 09:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9CuHKps70Th0JGwhWBmGqTShgEX6rGAigmrTuj9OLyU=;
        b=q5rHNABBlkdhViPW0OuYkpf6eOtoWTpfUk7Ka4ALSx978K1Mhc99XVzE9YfJG3JaTT
         Eeh6e6ZMxaXJn4cIU+KnxSQG5O4ek7y6gmv3BrjQCLPIqpo5g/fE6y81H9de/UsNE38v
         YksWjO8LSaOb1GQjTdFg6tvdjvDml897KbL1fs+XwpL+gTZCdORr8RMQwbBSDY6XI5nv
         hpWBhhedi4YdlUCg/i6cvkS+RVkBN6fmKVVtXcQrzhqyYLLeWz4MXhrORZX4NHVil9hc
         BA+OjWESMp0WUR75LZkmNhsT2btJwUWI+Yyg7MjJhI8oZq0SfHS61CTaxRuiuGm628Dc
         A/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9CuHKps70Th0JGwhWBmGqTShgEX6rGAigmrTuj9OLyU=;
        b=sLC4w7C5uMJ6wM9ALSo9q0mE/isGVQC0l+MskfoqvqMG51x75WEPmhE8LqKNQEHk5K
         Xt5KUwpFHIDqF9xIxPaiDiZwsSdesn8wJUIIkbt20rjcnmH+Sx0gY0i6e+SprjDHxDQJ
         ry0K/MjZWebGUyQk5Nz0YbdmGxhWmzevXCSPYQ9cyCe5NEAjptWK/YbjQIPfK7JRrjCk
         MMngQeOdL/zdH9tDsf33BYWIUyWPd15nDyerTXSb4ijBl9215UoNLs+stYJNCBbeLUmg
         207yuNgOFgPwRDi/WjpqpoIAB/2eMfnFQt7Qa/N0Qz6GVax44GR0pSUmKL/9jDt0LN0o
         we4g==
X-Gm-Message-State: AFqh2kruWUxsLMifLTrHifs3BudxDFbM4u0HWvrhQy41nIRI++pLHs9V
        y27RPiEQLsiH7cpeIueA/c6OTA==
X-Google-Smtp-Source: AMrXdXv8k8Tg3vIs2xhUZQj7w1uQ9ulfgatRSOVAT/xBwk1bew0zK3kfBW/5yEUINCGGSH/H+7iinw==
X-Received: by 2002:a5d:6a47:0:b0:2be:64bb:1d84 with SMTP id t7-20020a5d6a47000000b002be64bb1d84mr34046276wrw.24.1675186328393;
        Tue, 31 Jan 2023 09:32:08 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm14563771wrr.108.2023.01.31.09.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 09:32:07 -0800 (PST)
Message-ID: <a3fdb1a7-0585-6282-0b84-27c82a35244b@linaro.org>
Date:   Tue, 31 Jan 2023 18:32:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/8] dt-bindings: phy: samsung,dp-video-phy: deprecate
 syscon phandle
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        replicant@osuosl.org, Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org, phone-devel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?Q?Martin_J=c3=bccker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20230127194057.186458-1-krzysztof.kozlowski@linaro.org>
 <20230127194057.186458-3-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230127194057.186458-3-krzysztof.kozlowski@linaro.org>
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

On 27/01/2023 20:40, Krzysztof Kozlowski wrote:
> The DisplayPort phy is actually part of the Power Management Unit system
> controller, thus it should be its child, instead of sibling node with
> syscon phandle.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/phy/samsung,dp-video-phy.yaml        | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Hi Vinod,

It turns out, my previous patch (1/8, which I took via Samsung SoC)
actually depends on these here. Without these here it causes warning.
That 1/8 patch is already in soc tree and will be for v6.3. Will you be
taking these for v6.3? If not, could you Ack and I will take them.

Best regards,
Krzysztof

