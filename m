Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B86A621BBF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbiKHSUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbiKHSTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:19:37 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98476748C9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:18:54 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id u11so22352036ljk.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 10:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sDWT0PL/4KXXDToUD40yIU/+wrcwjrvF7uRNukxVXJA=;
        b=WHbmYRT877uK/TloB4yPwXY2BRn57sUN99nAejEkzNrStvjIMzunsnYwZqbsms31/T
         PI4xQZBO8swkFdD7IMcsXF8RVEeU9D9oGum6THhjRv+9hz6pRdC76gkaqEhKXGeA8HM0
         +mrhk4dlduR9ZTqvE9qKEHSByi1BzajV2aQzye+UfGfvzNAqmljjp8SBTSF4k7j9Wk6h
         FScFVE8MzR8kSipD4C+7TM1O8PFudmTUfjaV8uhGrOco30LN15UiZdiAGhenyLjYd+CZ
         Gc1/okjfIC6r8u9eP/3P3USRe8fCrIRzCayy0RKYsFcXIzFSwCDUrYKlG6yZDGVnW/t+
         NXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sDWT0PL/4KXXDToUD40yIU/+wrcwjrvF7uRNukxVXJA=;
        b=Vhtrj7BMNz0Em3A8/9AOHCbc60537+d/cySG7xkN8zLQxUmit0pxNlty2KK2HzV08g
         kJYDqJuqKgspFox7UA7Vqzw5q3aGQYerMZ6rc69BDgOEzoB3eYOueUTcoUwTCJCR3Oxe
         9O09M7aM0qQzpAoipazxHdWCVajvdtE8e6uTasff9fcnu9nZa5098hvWhDGBkG5r6aPY
         Hm4YOyzmGrFBu9a8AOvydkeJ2btYQtLGp92DahRl2m5N6Q1jvBaKmoKZrXBHUkNg7lu5
         9AWZ6MNWISSnvyIeKE6yT6Xm8S4vXRd13I9aGhLgES2NuZqHZ6vywDWv5jLff+ekA6uo
         EA+g==
X-Gm-Message-State: ACrzQf1Gf8f4Nc76sc7PfmvMaJ4SyC1LQqQZflWmGUz3Kn+MBsfonCkQ
        JqyVu0ZH0xux89W+3rwD/wFnWQ==
X-Google-Smtp-Source: AMsMyM4xMW1vaNWEl6xEQM/JwxXg90zcbJn3yVl0wpvhkrIai1pUFSgsPS74S3+R2EF9sjFNDXfs3w==
X-Received: by 2002:a2e:8317:0:b0:277:b4d:d379 with SMTP id a23-20020a2e8317000000b002770b4dd379mr19574935ljh.401.1667931533027;
        Tue, 08 Nov 2022 10:18:53 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id 10-20020ac25f0a000000b00499fe9ce5f2sm1880460lfq.175.2022.11.08.10.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 10:18:52 -0800 (PST)
Message-ID: <4aaca060-ba53-d387-c556-db485b74fbf1@linaro.org>
Date:   Tue, 8 Nov 2022 19:18:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] arm64: dts: ti: k3-j721s2: Add support for ADC nodes
Content-Language: en-US
To:     Bhavya Kapoor <b-kapoor@ti.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, vigneshr@ti.com, nm@ti.com,
        piyali_g@ti.com
References: <20221108073252.35169-1-b-kapoor@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221108073252.35169-1-b-kapoor@ti.com>
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

On 08/11/2022 08:32, Bhavya Kapoor wrote:
> J721S2 has two instances of 8 channel ADCs in MCU domain. Add DT nodes
> for 8 channel ADCs for J721S2.
> 
> Enable ADCs present on J721S2 soc.
> 
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---

And this is a v2? Or resend? Or something else?

Best regards,
Krzysztof

