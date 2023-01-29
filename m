Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCBB67FE4C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 11:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjA2Kl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 05:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjA2Klz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 05:41:55 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A1A212AC
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 02:41:54 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so751386wms.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 02:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ABOPXo+vgZx0ugSosEN45asIKHRXs9VuvlJa6SU0Dis=;
        b=dkO0qH/zaSjAzdEj90pcW5ViVKz8qJeWHtIZnJQaQIO/BGjOf0rFOB+KQB9Ch8a96x
         C2/0l5o/wLooOB3YO6PsLEruoh8JvqpbzjopQcd2qApH3A4+HbIFw84g3syJ3Lq8Gm40
         W3xLcoPlOX7r3cfHVFNy5vX2Ssqs286OKOYWY3A7SkVRf9GLG08bGDoWa5IdQWFe3l+M
         RmPYCZwa0P84kxGY6XXV6rmmbxyruaBx98YcQKt1XwqNyp+kKyNQBBoFIuOmtW0NIFxv
         lw4GPQb07TAHEjF3Dk5dt/GtYE60xl6/q2ZTxQ/f1243Pasae6MSurhRR1w32f6xp+0q
         v6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ABOPXo+vgZx0ugSosEN45asIKHRXs9VuvlJa6SU0Dis=;
        b=Y+hFXo1ZU8pZPFKnnbecM1Kib6M4/cAAEqaV82h1lvKg8AjD07a9fbK/B86yWApJ8m
         JgKdhkeGW9Il9dyEvYAtPP3+BAuPIbcu+7CL0HqiqpRkq+cXIVSjuSWmcmADxSoeJ4lC
         vpERBOl0dRShHw5OsVjVZIfY5ht6Y78RMGXejVwVxHcb6i+D0y3O5vgCaywzN5KjoKEB
         qkN90Q56NeHcx52hdPwJjEv50vpIwHVeNlxMS1x5YTwjbIOWELDeKF71SHM8eNbd1ydb
         1QyA/XwBKlj8WJyf1qSHyT+p8nx1Z06UV4cdQFla28MKKPTvidDSVh5pwzp0mUHvVI2r
         QSnA==
X-Gm-Message-State: AO0yUKUtF68O99ncBw6ntZPkl64TMUwJ3UWOx1bUoxZRLeyltF0qtqxB
        RBVS6QQ/3Ls38+0ITfgfegqZMw==
X-Google-Smtp-Source: AK7set+k1n8Li7xTXQDAlFACNKneV85+M14FiXGZez6mvrj5+SAuqVREzJnWNHLw9K01lR39uBk6qQ==
X-Received: by 2002:a05:600c:1e85:b0:3dc:557f:6126 with SMTP id be5-20020a05600c1e8500b003dc557f6126mr1165942wmb.4.1674988913135;
        Sun, 29 Jan 2023 02:41:53 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f1-20020a7bc8c1000000b003c6bbe910fdsm14873836wml.9.2023.01.29.02.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 02:41:52 -0800 (PST)
Message-ID: <341373ac-b493-d44a-727d-aca3ff4421e4@linaro.org>
Date:   Sun, 29 Jan 2023 11:41:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/9] ARM: dts: exynos: move exynos-bus nodes out of soc in
 Exynos5420
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?Q?Martin_J=c3=bccker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20230125094513.155063-1-krzysztof.kozlowski@linaro.org>
 <20230125094513.155063-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230125094513.155063-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2023 10:45, Krzysztof Kozlowski wrote:
> The soc node is supposed to have only device nodes with MMIO addresses,
> as reported by dtc W=1:
> 
>   arch/arm/boot/dts/exynos5420.dtsi:1070.24-1075.5:
>     Warning (simple_bus_reg): /soc/bus-wcore: missing or empty reg/ranges property
> 
> and dtbs_check:
> 
>   exynos5420-arndale-octa.dtb: soc: bus-wcore:
>     {'compatible': ['samsung,exynos-bus'], 'clocks': [[2, 769]], 'clock-names': ['bus'], 'status': ['disabled']} should not be valid under {'type': 'object'}
> 
> Move the bus nodes and their OPP tables out of SoC to fix this.
> Re-order them alphabetically while moving and put some of the OPP tables
> in device nodes (if they are not shared).

Applied.

Best regards,
Krzysztof

