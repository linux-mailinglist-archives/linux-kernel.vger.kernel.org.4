Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A950E7024A9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239762AbjEOG1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239761AbjEOG1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:27:32 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3155B2D4F
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:27:25 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-96adcb66f37so384321266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684132043; x=1686724043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fPH+8xvBh7NiA0Q/69MSU5S3kxpPxX+T6hvZkKu8gFc=;
        b=bq3jJGSEp9INUCx1XHGMmoRyFQACqzGSIl3W4kUwn8VkHgx/N8k8S9we6QD9nhYC1J
         aXHBJQML+9dC9xgZNlO7KTgCehQIv6L5Y08FbkVwgCzmyBT1tWWHJWrq3z2BJqRjv8gm
         fw/RhfjNnlh35OQ39j9MI8IqGFVCZgWG+4bceY39I+EneDAXiNWyeZ+HftVJ5FFRz0+t
         RTeBVju0xsxLvlwviFNlZt/CZD8HMaHB+v5dgAZRhkMtU8hzKUe8KZ/rrRqAqZU0cAeg
         4KmMKIgVHKcglZA7kDXMmPF9cgolZSCD7eOlPiWR3WRW52tEfZyLVbLIfOM5PLzJdiYe
         eWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684132043; x=1686724043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fPH+8xvBh7NiA0Q/69MSU5S3kxpPxX+T6hvZkKu8gFc=;
        b=UQRwIBGtctg6P4ZuZz4rbtVq+3+ool0P9GmoRjem504jk24tyneWyE6e1isXipq2vF
         c026ANsicDg+erv8FIBnknuwzf86wAyJvSIjxIToLpczdjiYsNSmkQX1ZOmKfxs0ikmp
         6QHNqqOT06AyOuyUjXVuY/bRh/bMQPtqbaYrWDWsqajqmX0Kdxsa/ODCHrhWVEmXR2B8
         DE7B7UGfc6tn3lkHYnap1KRACDV8mb4UytfChCU8CBSz/JXJCvu/F8wzYWA8jhuJ8fPV
         W0AFMuawWqgErfd+UIXxybMcwoABxON9zmTliVYLVRxZNJqvixvcxKa7Ry6l9wmxiRh+
         5qUQ==
X-Gm-Message-State: AC+VfDzDlAW+KChglctGAYcqo+nFeVub1fnyRlOHNSjOPWGntMVLTlup
        yRBI+RWSgEgV9epVpx/ZFQNc3Q==
X-Google-Smtp-Source: ACHHUZ6KhAPIFec8ZHcD908Z5f0wNboh61jxF1yxMAz9PexUx03rIa02ja5P3qimJ/lzKhVbLNL3UQ==
X-Received: by 2002:a17:907:8688:b0:96a:3005:61b7 with SMTP id qa8-20020a170907868800b0096a300561b7mr14216778ejc.74.1684132043675;
        Sun, 14 May 2023 23:27:23 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6470:25b8:7c2d:1992? ([2a02:810d:15c0:828:6470:25b8:7c2d:1992])
        by smtp.gmail.com with ESMTPSA id hf15-20020a1709072c4f00b008f89953b761sm9004330ejc.3.2023.05.14.23.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 May 2023 23:27:23 -0700 (PDT)
Message-ID: <fef0ac30-73c1-86a7-e114-0846ba735965@linaro.org>
Date:   Mon, 15 May 2023 08:27:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] clk: thead: add support for the T-HEAD TH1520 CCU
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, mturquette@baylibre.com,
        sboyd@kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Wei Fu <wefu@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Icenowy Zheng <uwu@icenowy.me>
References: <20230515054402.27633-1-frank.li@vivo.com>
 <20230515054402.27633-3-frank.li@vivo.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230515054402.27633-3-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 07:44, Yangtao Li wrote:
> Add support for th1520 in the clock framework.
> 
> Cc: Icenowy Zheng <uwu@icenowy.me>
> Cc: Wei Fu <wefu@redhat.com>
> Cc: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/clk/Kconfig                      |   6 +
>  drivers/clk/Makefile                     |   1 +
>  drivers/clk/clk-th1520.c                 | 999 +++++++++++++++++++++++
>  include/dt-bindings/clock/th1520-clock.h |  92 +++
>  4 files changed, 1098 insertions(+)

Please run scripts/checkpatch.pl and fix reported warnings.

Bindings are always separate patches.

Best regards,
Krzysztof

