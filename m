Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3356564AA74
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiLLWll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbiLLWle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:41:34 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D933DF41
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:41:31 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id gh17so32066715ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SqygdlW0rQpciWh8EWAHVXf1mOFoeCzEUMhXZ9vVKLw=;
        b=K/KWqvbj6DqEu5FQEWyELyGPCPM7j28nR1dlQgOsz33jZtKvbf38aPJZimcRICR6Ow
         dwpSL62MQHFB49yTds5rML2y6lBNF+qAxQMrzGhGi+JividVruGjeMaG1OK0Y9x2ru/E
         mOa2ictsM8r/IyubOuUMeJGGOpEVTjIEdlsxaq7Dl5Src9LNxUfanLkoyHYkuj8xWSBx
         wEXNLlgT/GAkF92QWSVF/kwTD6vZkEDpADEhzmGJdV0nEmJ/HReV9Lerjq1r32BFGcjw
         /24yM+oPdWCXGYHyXzMJSdOEtIoTT2Izcz2aRxQXeqPWhkumz4sB0wUdjsu094A3xkyj
         bSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SqygdlW0rQpciWh8EWAHVXf1mOFoeCzEUMhXZ9vVKLw=;
        b=RS3C3gLRDv0MkVoPhhkBhD3+LE7vbIXRZ1efmJxV+2U5RPoyvdzO2kE2/G0OIu3dTq
         BrGq5qDXhf4XsaoA/H7DZ3gKu+52Z4LOBonicSpRIOw1jkNWZoKx+gH0eXe2Qbf8BBjs
         GmwVwbef4yddGjcD46aZonRJ4oxy5nmTfalFlaiM1N2oAzQULrY3eJwTt/zpSpwmdPe2
         btXbQf9zNWUMqbckzUE/1NK2b10BbDqJMHNryBWdh9TkRRVZtn6xDwI836m5Zplcw68f
         ScrJDalePFUHDcaovTXcwexSlQg8vqbYLvKGNQmygqRBq6wC6zhNeVAjEA/uVApXslpV
         75OQ==
X-Gm-Message-State: ANoB5pmf6MAJg6S0rgwjTyIfYTyVED+p7OCkGYOlX9ce8OELCWnzc+QF
        h+cZjHvc6+2lGltzQigA8vF6Xw==
X-Google-Smtp-Source: AA0mqf6ohqUuW54TtlaZvv5FmpQcplLc85SLKSLWjxdY1OjldWbUbNDG6WGF5XnQGVSywyPYWN9ryg==
X-Received: by 2002:a17:907:2e01:b0:7c1:4785:d650 with SMTP id ig1-20020a1709072e0100b007c14785d650mr11176129ejc.26.1670884890059;
        Mon, 12 Dec 2022 14:41:30 -0800 (PST)
Received: from [192.168.1.115] ([185.126.107.38])
        by smtp.gmail.com with ESMTPSA id m24-20020a1709066d1800b007c0d64c1886sm3791149ejr.33.2022.12.12.14.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 14:41:29 -0800 (PST)
Message-ID: <9009b652-a422-7cef-ecf5-ab5ef5706892@linaro.org>
Date:   Mon, 12 Dec 2022 23:41:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH v3 12/19] x86/apic: Use irq_domain_create_hierarchy()
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221209140150.1453-1-johan+linaro@kernel.org>
 <20221209140150.1453-13-johan+linaro@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20221209140150.1453-13-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
>   arch/x86/platform/uv/uv_irq.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

