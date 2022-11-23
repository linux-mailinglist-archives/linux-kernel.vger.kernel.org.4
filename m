Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292BA63542F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbiKWJDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbiKWJDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:03:18 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AB2100B2B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:03:16 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id j16so27190505lfe.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lj5qM8HyY9yPvHfYz3RvhZJi/KrYTswvqs6RCRkYoUU=;
        b=hdw5NXv78GEDuDERgDIqOlpxuJTqcfYs4LLbA0s1YzzZIGq9kR1gw1DpIkLdb6s5cy
         bKA1PoiGqEdPaRae6SpkGDec7wGz8u3h/AIwCU/21tAcmtT8doWhTtyADI6MlOutrcA+
         J6WvQrnEq+wfo5+50rESDG21oH7Zy2ToeAIq+wOWhx5uVAm2ZLrtBuFqDC7DZPnoh7xl
         wlJvFqR2I22F+s2CbqrIrp/R96/4/bciWNa1OANOPG67eKZ3XjCKIE3MGJ56n699z2xk
         17vV7g8SOTWG/Fb68dB72EMCPOWIdOgAD+JDBjiuAmk0sSDl/2fCg3Qq+fq/aHCzSUKI
         y/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lj5qM8HyY9yPvHfYz3RvhZJi/KrYTswvqs6RCRkYoUU=;
        b=QPHjraAgp2OqnKfjSgH8RsGZK0j3FC3rrQNPW622vmomP3aYNiYo5+ymuVF+UxEfLp
         WkD9ynSV2pWPTcG+FnqsJbc+ELhKTZuS+2N8J7/CS60JWS1qI+qh6lI/3W+iIPhNtNg8
         TdxXpJRfQDSx8jIsAMPa5j4Nx1n5whJOuWnFwRB8m+nnQV6Qvt3xG2afb5EffVzkWzrs
         g/7tKx/LhdKNbFjgg264b6OyuFQFtvMdjN1YjYx2U1iKdH1JTQkCNagyopGY0aSj7XnK
         V8GizqHCdpDVEiAZr1hCAwQ7ZN/+46MY7fIjCxfYl55RfAw/ojg6PP/4EkL2lvB1P3iP
         Yx8Q==
X-Gm-Message-State: ANoB5pmYhLX/jzvYAIOctefRlKo5D+lCQrWqcv7R08OJ8qFqayZlNvqz
        2RfWLPqN+2WhSaBqkVH8NanUVg==
X-Google-Smtp-Source: AA0mqf5YZINXfyoHMvEKMXYYzTYl/T0856F2iwgRBsR9O5/Nm6Nm+W15mMPu0oipOaJPOJ/G1QGVXg==
X-Received: by 2002:a05:6512:2a98:b0:4b1:4612:6d06 with SMTP id dt24-20020a0565122a9800b004b146126d06mr8677897lfb.683.1669194195317;
        Wed, 23 Nov 2022 01:03:15 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u10-20020ac258ca000000b00499bf7605afsm2809973lfo.143.2022.11.23.01.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 01:03:14 -0800 (PST)
Message-ID: <cdb96213-ec91-11dc-73c5-63a266200ac6@linaro.org>
Date:   Wed, 23 Nov 2022 10:03:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 0/2] arm64: dts: Update cache properties for exynos/fsd
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Aswani Reddy <aswani.reddy@samsung.com>,
        Shashank Prashar <s.prashar@samsung.com>,
        Andi Shyti <andi@etezian.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20221123090109.74441-1-pierre.gondois@arm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221123090109.74441-1-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2022 10:01, Pierre Gondois wrote:
> v1:
>  - exynos: [1]
>  - fds: [2]
> v2:
>   No change.
>  - exynos: [3]
>  - fds: [4]
> v3:
>  - Update commit header for fds platform.
> 
> As requested by [5], resend patches updating the cache properties for the
> exynos/fsd platforms with:
> 1. Fixed subject.

No improvements in the subject.

Use subject prefixes matching the subsystem (git log --oneline -- ...).


Best regards,
Krzysztof

