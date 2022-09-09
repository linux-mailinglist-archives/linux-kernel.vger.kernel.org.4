Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E275B3D29
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiIIQjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiIIQjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:39:08 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76835142DA2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 09:39:07 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id bn9so2508903ljb.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 09:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=C8EFOrarFgcH9AimKTDz/kV+dDC4aGl58YpTJdmNSjU=;
        b=m4xdA0A0cbvAzvVI69pUofSXJcUZHq8o/kzFhmSVtGPDXMsaRHIbqvCF4PdTp0UAI7
         S+F0Q4RnehEwjK0N+6Fcy9N/PLicbeQawYrjQj91X3xXHpetqLKwnZKZ9qEORyxnYaXD
         mV1KQHXAz75M3s5YnXyC08gKAyRuDa+I6amGAaxshpuUHpEBYZ3Mlf2qV5peTmqSbk58
         7KAtuRMokdnJ7LOZJqxAgVL9TFh+AgPUNwNayVXO8GKj7uP9uDoE7oIzNZcDbi8JNWs8
         Epq8tJ4sotYEql6Jn/3O7I4ORZ+uj+w6fw9Y3eP72ogq9vpkMb96soZfTxZdDGGO0o9e
         ImGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=C8EFOrarFgcH9AimKTDz/kV+dDC4aGl58YpTJdmNSjU=;
        b=oKelvLbOQA9VzZMfef25khq1vX2VlEg299mrL82yU5VONul3layclyv29vHyqI+IyN
         xMO+ZmpfxfUJeD8SCZRgQEkF9ofRqkB+BoExhQFklv6Cmjx1DBSzCkROhm5PM5QllphJ
         5dwGxsDc/XkZhLOVkZHF8m3wzteKLyR89aSWVa+Gpm9WXJk1Wy7/2MXBocby8Ub3Vm0n
         ZOlRh627DNxcidx2SiZfWP1Psg8UMxpgDxai0OZe4bpc8ZQDU62Ip6aq0r2wVswlXrN0
         ZuaRroTw/0q5pTvLII01OTWh+2DTjxmlFqRkrgKvfvLSpc+ej37OxK+5MTdAE6Tq/A9g
         waaQ==
X-Gm-Message-State: ACgBeo0dnhZEop3beOnosgi3hDsrzuqJwxJzy70ekXT23hAVtjveyrrj
        XjRAyjLrPfRPB2DIMI7ERG9oLw==
X-Google-Smtp-Source: AA6agR4SNJRWarydZ5VLp359Lgv+QR+yZRAFXcH/WrnxMJMgK9lSw/Vl7ODP9YCBx7Qb7RooCS+bLg==
X-Received: by 2002:a05:651c:1cd:b0:261:bef9:ada8 with SMTP id d13-20020a05651c01cd00b00261bef9ada8mr4128624ljn.387.1662741545867;
        Fri, 09 Sep 2022 09:39:05 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 6-20020a05651c00c600b0026ac3fedd20sm139001ljr.86.2022.09.09.09.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 09:39:05 -0700 (PDT)
Message-ID: <7585e56e-0983-de27-7c1b-9ec30898d4bd@linaro.org>
Date:   Fri, 9 Sep 2022 18:39:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: pwm: tegra: Document Tegra234 pwm binding
Content-Language: en-US
To:     Sandipan Patra <spatra@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bbasu@nvidia.com, kyarlagadda@nvidia.com
References: <20220909155258.17908-1-spatra@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220909155258.17908-1-spatra@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 17:52, Sandipan Patra wrote:
> The PWM controller blocks are identical to ones found on the
> Tegra194 SoC. No driver changes are required and compatible string
> "nvidia,tegra194-pwm" will be used as a fallback.
> 
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> ---
> V4: Mention fallback compatible

The patch is not titled v4.

> 
>  Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> index 74c41e34c3b6..331c1e66e8fa 100644
> --- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> @@ -9,7 +9,7 @@ Required properties:
>    - "nvidia,tegra132-pwm", "nvidia,tegra20-pwm": for Tegra132
>    - "nvidia,tegra210-pwm", "nvidia,tegra20-pwm": for Tegra210
>    - "nvidia,tegra186-pwm": for Tegra186
> -  - "nvidia,tegra194-pwm": for Tegra194
> +  - "nvidia,tegra194-pwm": for Tegra194, Tegra234

No differences here. You sent something old...

Best regards,
Krzysztof
