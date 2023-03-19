Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD5C6C0198
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 13:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCSMZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 08:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjCSMZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 08:25:41 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C992B761
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:25:35 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y4so36946223edo.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679228734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZFpW7DvYItPfLOavEDwf4Jv4q9OdZqCjmJNXxWGKgnw=;
        b=wBl/FZVyPgenBUiH7+ZKEfBWanrTHgh5D7yMrsmn25uzyjc3atmJVo+aEnYW+Lb4lh
         KUXzNuZUdbRLn8V5LmgNWehFT37Ep2EhrX1jMRQ77Ejl5DayBiE0ldlwW2XrtSlssQZr
         WkMY2qgcA20/8tBonUvE3f4UB10yPesZnaZsuEzB+dsABBWritlLho4AL9br7K+6fkDe
         TWAKFLLqQKazItu3wky+V1Ce6aUW2WU2rBZxdlf3gihjZg8ZGg0mIbSy6JLHLurG/dm8
         vfFKXtEi74MGZOoVimxsztnJ28pP6nHaeF6L0yOunsaxz0o91zOqGS3NoXWtgOuaYjDC
         g+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679228734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFpW7DvYItPfLOavEDwf4Jv4q9OdZqCjmJNXxWGKgnw=;
        b=QTlAljy6QrW7k7qNVPbtQuF4nVPVdQQIYPfb4TsD+/Glqaf9b0U8QW2oP91h+StvDV
         RKehWHw/T7ahOKNzUeB3bT0BHroAu0dONIYm1P3tQTXHbkZoncpD4uJ2TYgA8CPX0z5x
         moiYqAB7JxP2O0gTJ8pCbBp6wlirOq+0RQ2tOa7NA8h+GqOEUZhi0WMutlAH9IjUyYVb
         Htu4X+fVMi+SywP7pdyYERBNWXL+EGshrUExOfSiihsUd6mVkyb2uNx/rIWJfxePdoRf
         eVd/8mcWtCfmwG6AHQKyJrMeaWiNEYxE5T7fJ8tLlJrgrC2qwZCD0fDJ62kuGAL8y3Jy
         +u0g==
X-Gm-Message-State: AO0yUKWrQENbRa/nzgM02x6jbg5DSzfoybiKrobbA4yAOlTEWci3H3rX
        200f8FLvPkhb5RdM3qNaraMawA==
X-Google-Smtp-Source: AK7set9aSrS8i0GCekJwdkTs9pBj5b6jS08qCGaGpkNZS1KjkYCsinLht12Zf3/m+HWtB30GSoHOWA==
X-Received: by 2002:a17:906:6b94:b0:932:8cd:1021 with SMTP id l20-20020a1709066b9400b0093208cd1021mr5697603ejr.33.1679228733967;
        Sun, 19 Mar 2023 05:25:33 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5b5f:f22b:a0b:559d? ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id g25-20020a50d0d9000000b00501c2a9e16dsm480036edf.74.2023.03.19.05.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 05:25:33 -0700 (PDT)
Message-ID: <bf3a25e8-7076-d023-3b67-4d6c65790bba@linaro.org>
Date:   Sun, 19 Mar 2023 13:25:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 4/6] dt-bindings: clock: jh7110-syscrg: Add PLL clock
 inputs
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230316030514.137427-1-xingyu.wu@starfivetech.com>
 <20230316030514.137427-5-xingyu.wu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230316030514.137427-5-xingyu.wu@starfivetech.com>
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

On 16/03/2023 04:05, Xingyu Wu wrote:
> Add PLL clock inputs from PLL clock generator.
> 
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

