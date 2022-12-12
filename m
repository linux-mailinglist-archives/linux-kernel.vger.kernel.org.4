Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A70D64AA7F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbiLLWnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbiLLWmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:42:46 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D28F5F72
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:42:44 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id i9so2383550edj.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mG38vQpvA5iccE80A+eCvu435+Ju1Dt0GScT4GJHyIA=;
        b=sVQLLedTvObWUJpjwiWHWO0FBf9i4r0HfaVwpyZyNf0HdOGTRVXT3YYQYbx1rvR2Vs
         Hvj37s1n3Gf3hbvb3nql5GrU5xapgkoFId9+F6ELEnI7BN+D2keFG9LX2A80x8Uoo14B
         6cYXuMIyVS/WWnwV0qQED1fXGWjHy+a2Onx8UShXbDEbgAf0yvuxXqefU4yfcZ++vXIp
         uwy+oWeYEYU9Sn8ToQ2MbZqUrTXVlpaI27UxJQguUYMY2trOcWULUhF/aNNLjX5xLB6M
         8CfdJPpy1caOMupBdP8H9qLN9uYWLITSzyvsIF6IoACHY4eKGcKEnz1z3dZopqimtvIt
         3VDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mG38vQpvA5iccE80A+eCvu435+Ju1Dt0GScT4GJHyIA=;
        b=YTEicpuzREh4Y8eoSkRy/0mj0wanpDnA4ijZTR3xHoDpdc5SqYBEWf8grMGlEZMk1o
         4sYmQGJTaBF7fAA66AJEnt0Lj455ODWIU8unQy5ti3L4U/ALlsXuUmr4RVXExpm/lBS4
         E5WrJ2h3oG+l1kOEgxxalAPHxHUi2STkaS7U+xhyB8kTziW/EwzDXlEc6cfILontPfcl
         6WCvTC2Yw4g4ngTm2W9YV6/MMd/6ejxJ9T4RQaLqa1+9YAo7ZIZwD8DcWL230VvJPoie
         ci1d4t+B7mXd7Ul+uABm9oHw0Zu6A9e8yhnJ1DP1QPf6f7zNbjdsFgKPfilVJB2IRuog
         iuJA==
X-Gm-Message-State: ANoB5pnjim2ePj0DP4cw59m7PwO1EcK/jskomlXJOz5YjFcfmY60Q52N
        aPSR0Te5XZLE+qAJYraD+X4zeA==
X-Google-Smtp-Source: AA0mqf5YYi27giRG9AgrDoPYAP5CkuSmhAtXGnYQE82X3BdQxLfFlu6jo+vuaBLOnFCQ+f+pb/8zUg==
X-Received: by 2002:a05:6402:22fc:b0:470:18a8:3ca6 with SMTP id dn28-20020a05640222fc00b0047018a83ca6mr2019481edb.23.1670884962368;
        Mon, 12 Dec 2022 14:42:42 -0800 (PST)
Received: from [192.168.1.115] ([185.126.107.38])
        by smtp.gmail.com with ESMTPSA id d24-20020a05640208d800b0046ab2bd784csm4201575edz.64.2022.12.12.14.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 14:42:42 -0800 (PST)
Message-ID: <db784006-c13a-636a-50a0-765fd51db509@linaro.org>
Date:   Mon, 12 Dec 2022 23:42:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH v3 16/19] irqchip/gic-v3-mbi: Use
 irq_domain_create_hierarchy()
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221209140150.1453-1-johan+linaro@kernel.org>
 <20221209140150.1453-17-johan+linaro@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20221209140150.1453-17-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/22 15:01, Johan Hovold wrote:
> Use the irq_domain_create_hierarchy() helper to create the hierarchical
> domain, which both serves as documentation and avoids poking at
> irqdomain internals.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/irqchip/irq-gic-v3-mbi.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

