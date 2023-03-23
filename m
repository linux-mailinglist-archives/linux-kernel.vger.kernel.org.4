Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BAC6C5FCF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 07:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjCWGgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 02:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCWGgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 02:36:49 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A636120
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 23:36:48 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id cy23so82117386edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 23:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679553406;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KBuqC6g1/eaUnYvNFbBeCunU82oMiwEhP9a6uXkHuJM=;
        b=rXGRux3R7a9zkMUCQFz337/YkRWKdtX/1Dhbt69Gk/OchVsvcyqoc9/3QKbX3gbFMy
         49WoqDIv5HzBZcWivC6G49B5MkX6aW/JAzJtHezhhhWp0O+TMKp2FXaQEDZ4Pf1MVDFG
         APTKCMgLczc3JrsKAdE0T7CAhzTPM/mpnlU33YQYTVu5HDHEXp0dW0VumYdaJxx0hUlT
         VZ75H9jj0XaQOcqD9Y9Admben6MrZ57fvGxEg3zZSFNwRo2fMDV3pJuvMQrd+MwFezrK
         4vAeiK+xbvF1h32BcKOMWH7duIB1MdplBkCCrLBsaQbFvcr8zm0K6Vio/CIu1D3pDWDn
         m+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679553406;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBuqC6g1/eaUnYvNFbBeCunU82oMiwEhP9a6uXkHuJM=;
        b=q+Ajrb5X3X8uS24CGd1teZSf5nLJBIR4V3bepj0bWdfo8hYjmQMqSNwrTNkssYsVOt
         LIv4qL50r25+L37ThUCXlgg1TcPZelwgAO54qH5eE5WbanO7SGSzXvZTWH6DgYwDgREH
         EasOdtB0SIDe6qEQBEFB37cIn2rWy3WzJG5awitTmJVlHUEMFnRp3pfBye+kwNzV2Y96
         30BOPCY9ztnF30SWW8k7GiGvGdbAeKGWX8+cgt6WpdBKMkUuVf5OSqUASbnZTszaKlqH
         dnKAEam1LnzQAU5sKsDA/fFyTAOuffkGD9DWCi1s5ErUJCh2vp+iPIm/lpHIKVWFvLv4
         SZFw==
X-Gm-Message-State: AO0yUKUo9bDZcW5lQky4yRRPFgyz4SuRNGd7DnojIaXGPZ++ENenefj5
        S9A28w3DioFJPJoVJ5YJjP7mBw==
X-Google-Smtp-Source: AK7set+d2WHze2YcwYBEvlDICEdFc3/PIpuRwJpx1GCMubZK+HMKila+Et5cWOrBQLq6yP3xpn3ooA==
X-Received: by 2002:a17:906:c786:b0:939:4c86:d492 with SMTP id cw6-20020a170906c78600b009394c86d492mr4580173ejb.5.1679553406522;
        Wed, 22 Mar 2023 23:36:46 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a665:ed1e:3966:c991? ([2a02:810d:15c0:828:a665:ed1e:3966:c991])
        by smtp.gmail.com with ESMTPSA id kx1-20020a170907774100b0091fdd2ee44bsm8158330ejc.197.2023.03.22.23.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 23:36:46 -0700 (PDT)
Message-ID: <4957b3f0-46cb-9a11-8306-81cdf5fea293@linaro.org>
Date:   Thu, 23 Mar 2023 07:36:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v12 02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba
 SoC
Content-Language: en-US
To:     Brad Larson <blarson@amd.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
References: <20230323000657.28664-1-blarson@amd.com>
 <20230323000657.28664-3-blarson@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230323000657.28664-3-blarson@amd.com>
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

On 23/03/2023 01:06, Brad Larson wrote:
> AMD Pensando Elba ARM 64-bit SoC is integrated with this IP and
> explicitly controls byte-lane enables.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

