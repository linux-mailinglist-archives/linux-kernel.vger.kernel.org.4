Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D4264AA64
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbiLLWge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbiLLWg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:36:29 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FA017A9A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:36:28 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id qk9so32070175ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7WlhP+l7ysygOjw8JeHYZhjUTz55yAdhFRrx1WIpzYQ=;
        b=DGM361xSjlWsUcFQzdJhlOnKtTrNw6HlhOJUH6RjPZm2+Fpu5KFMW+c0WZVggL34eN
         jmJTtDWZPipQyM/peidtWF/JVMHKT9TzVuUjKM+KMvxWthslcs6p/16OJhoG7ivJft+T
         Ne0JePxGvuDKtc4hHh6Al2eRUcEU480IxAVYr4v/WAD28UwOj0EfyL1lcyyFkfXEF5WP
         UjiuZu9AckIeIGjS0Npe2NWMFMlzJRodKdVR2Z1iUdKRYHgen8eW2wEhJQUsWzHbAyty
         MCh6EduR53dyZNMKYz3eKTeaRn9p7C8UaTZX0Loc2VDPAFCAJ8xHFcF/bhQQNRhlfBth
         qEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WlhP+l7ysygOjw8JeHYZhjUTz55yAdhFRrx1WIpzYQ=;
        b=4eGKAdFWqA2kWDljtGJBIBNj8R/wKQxT6YuDz46OgWmruj1Ce353SuclQKnq2AlehA
         MIFAr8J+c+u48ZHe9ko3fyxdQ9kCSHfMX9cSvW/pao/MIZUO4oqPZuxZZGpPrKT5a2AR
         sgaFX8mZ6FhI7E+wJgOGd4LvDWqFDlMJw85HjG02rpBTU6qQhIVqJ3RBv1CYDPAgx1vp
         XzC3Vy7a5CarseyxR4X2aXP3gd7j80Ce2fpnp8PEBaZ1R1zuhaLPvAksi9yhaI++SewD
         4weG52jE/dZdrgYap8ysBFVA9DPXwzwxQiJtj+mCqMpJLCwqGJAIQvptf2ehDTnYDpkh
         rOHQ==
X-Gm-Message-State: ANoB5pna4Gsu/AJv7Hie3a2dZEizFyAK5tdGhU3A7UPhm8xMIoKrW/ap
        WsVid+BlgUMh9pf29UkWrndzFQ==
X-Google-Smtp-Source: AA0mqf6qREhjixkF/RMTbmutvuBG59uTKRpwKblJwLpiO9Tap2k0DZ14TncO7+FNARV7gGujveTzJg==
X-Received: by 2002:a17:907:9018:b0:7c0:e988:4157 with SMTP id ay24-20020a170907901800b007c0e9884157mr12258639ejc.40.1670884587374;
        Mon, 12 Dec 2022 14:36:27 -0800 (PST)
Received: from [192.168.1.115] ([185.126.107.38])
        by smtp.gmail.com with ESMTPSA id g17-20020a170906539100b007c16e083b01sm2070944ejo.9.2022.12.12.14.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 14:36:26 -0800 (PST)
Message-ID: <e6fba0ff-587d-ac0f-ded2-a650479a3ce0@linaro.org>
Date:   Mon, 12 Dec 2022 23:36:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH v3 17/19] irqchip/loongson-pch-msi: Use
 irq_domain_create_hierarchy()
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221209140150.1453-1-johan+linaro@kernel.org>
 <20221209140150.1453-18-johan+linaro@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20221209140150.1453-18-johan+linaro@kernel.org>
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
>   drivers/irqchip/irq-loongson-pch-msi.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

