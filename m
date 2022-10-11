Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBD15FBB9A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiJKTyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiJKTyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:54:16 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141DF7B786
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:54:14 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id de14so9644823qvb.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sslcfDW3BZnjxJOzXU+bZ3YMR6XY0q1cZ2iVJRTDRVk=;
        b=dPaAEuVDxDtXPEwzGLqsjaNTL+1KZKNie24yZ9SYlP5pHpnEXEvsgcLHNzjx/cQ1cn
         6q0zdfPrqGPUsI7EWFYgWRHumPQJQMxR5RLsiugtjXHZ+MAOxmk2o1I0AYaGdJjyFx08
         MxIItMJgpAHn9nPRJLRvMwo24tD/Yk96G9BxbP+2wyO3HI0DvRC+ocimKJ8u7Z3QNMSp
         0n23oak/JydBhAzXRluJC0/Z9MJIIKF+NSMKzEXIsGjmFa92c0Gu76VaZWl3xfIoDwbp
         Zc8tdUf95yxil6z5MXUkplWBCZxd7GhOHSVgxGXcyKRvRWU/lLifQ7xmLC3/KC9NMtky
         T7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sslcfDW3BZnjxJOzXU+bZ3YMR6XY0q1cZ2iVJRTDRVk=;
        b=Vz77d1MzvQDRHZ2soUZEac9hysy+W98SSHZcxdHLoB6oell02gVnC3bHFcnr0uepL4
         pOLY5UyMNF4GkVK4ZLgI9oD7YyjTcX85wgPqvzSkJeE4EIafHrHMHSEI2HBshVB5YSGn
         4R1zpg9ue6M1Hhy5DvZUa9kIs/5TGw88qbUhyIRuq2IhSLfk6J8z+zBqp6CB2a45JAmt
         4HEVd8/i7s+wgmYYwbH1tG/fSUg5cwTGMg1o2iJ8OvPmzDBpzQSD+xwdSc7xzTxbhWLM
         2HGpgxvR9xvyT9CcGfUvK6779pw2a6rJgHuQYbwuDD6zUCzLN5o3NPMVUvujlNPZSwt6
         58fQ==
X-Gm-Message-State: ACrzQf2tRtttq27Qy1qHBmeJRTvxgnDtgc6+YRtw5MweU7jvlBDNkLyS
        nhTYHvLO5qx4ZfvKkqNLLI4j1Q==
X-Google-Smtp-Source: AMsMyM5+aTQaWcFsQOU25ufUA3VeLfaxfhjr2Z6/mP3HOZlDLnAlkvbygkKOM06/oyBcHYBG0jAYEA==
X-Received: by 2002:a05:6214:5cc5:b0:4b3:e05a:bbb9 with SMTP id lk5-20020a0562145cc500b004b3e05abbb9mr14260326qvb.42.1665518053305;
        Tue, 11 Oct 2022 12:54:13 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id h10-20020a05620a284a00b006b9c9b7db8bsm13663527qkp.82.2022.10.11.12.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 12:54:12 -0700 (PDT)
Message-ID: <157f3d65-3cd1-043a-165d-a27b7d34ee65@linaro.org>
Date:   Tue, 11 Oct 2022 15:54:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 4/5] ARM: multi_v7_defconfig: Enable GXP SPI and PLREG
 Drivers
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20221011185525.94210-1-nick.hawkins@hpe.com>
 <20221011185525.94210-5-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221011185525.94210-5-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 14:55, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Adding support for the GXP SPI and PLREG Drivers.

This we see in the diff. You must explain why. Why are you doing it? Why
do we want it in the kernel?

> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 2 ++


Best regards,
Krzysztof

