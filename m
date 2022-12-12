Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54CF64AA78
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbiLLWmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbiLLWl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:41:59 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0CA1B9FF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:41:54 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id m18so32033003eji.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WU3mAWKHah7f5cn/9LK1A0sGZayOaeYggQzG2/Nasyk=;
        b=TvcYH862sVsa6sMzd5bsiS7lzGRY1ARFG7NOhmCnA+U3DKC2jwyWBoV/rXDbH8lTj6
         vWmoYIGpS5248r7tUrVsYhsc4dnBQKWLJupPps1oP4su1Kin7173/hFL71U21m2jaccp
         kYKjR6Yca2Ca9GqjjJscthKYLyXzBIsVP/OsoeVVM3RI8nLXryvr86ylSNIh7aSQ47kv
         3j38annxmozxwtJ3YkHrkEiVPht9UXilx5oXroqqoMbh1RXCKysadE9KqYYerl3uVFRH
         yAPdysLka4fkj4o1o+EOOs/wvIGavTQLHHj7TDNj/Rwt6Zm42f09fyhu8rltHtHtmhAd
         Xh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WU3mAWKHah7f5cn/9LK1A0sGZayOaeYggQzG2/Nasyk=;
        b=3AHeYoDOrEUVb1UFkiqN+oI3Rthyh1JfhGOgyos1mh9To5B7dah7KYctE5ePOsreTe
         WTQ4Pk8BfB1zqgKmPhtpImGjeIxOJuLn9oCt+7aXAzuQBJLnycre4b+pyZW8r//wFeMQ
         1iOxs+fbYhvJuc89s0duTjK+TNsz4gyEtwoHQ76wpKeS2IWF0chfzj3JF8J4rBMqrJkr
         kLELYCBJbOidSA4Iw0k3KADFimwA4SLzaCWZfHKvTMhZqK669Yethr9AFOsSk/PkdyBJ
         dWzvHntKYPoc1IjQhpITERIS0HJU0dzLyE9lLa1mb9jgLvam1+w9bSxZNuaEiSbH6art
         2GXQ==
X-Gm-Message-State: ANoB5pmqJ58kdDSWOhJ40i894pTynBYKcoHGIOuta9fdmSr2xCyherVL
        r/bDz3netn40L5Ynh6LOMlIDkw==
X-Google-Smtp-Source: AA0mqf6+0Nqj9S6J+i5RAccGr7GoxwdmoERl5p+Q02OYkWJKoTkLDczYvW5snGTNovE/ASrNnhxDLQ==
X-Received: by 2002:a17:906:4154:b0:7c1:639:6b42 with SMTP id l20-20020a170906415400b007c106396b42mr15436504ejk.62.1670884913195;
        Mon, 12 Dec 2022 14:41:53 -0800 (PST)
Received: from [192.168.1.115] ([185.126.107.38])
        by smtp.gmail.com with ESMTPSA id h22-20020a170906591600b007bdc2de90e6sm3756374ejq.42.2022.12.12.14.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 14:41:52 -0800 (PST)
Message-ID: <1c3a4d62-7111-dd21-a2e4-350a3d26c0a2@linaro.org>
Date:   Mon, 12 Dec 2022 23:41:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH v3 13/19] irqchip/alpine-msi: Use
 irq_domain_add_hierarchy()
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221209140150.1453-1-johan+linaro@kernel.org>
 <20221209140150.1453-14-johan+linaro@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20221209140150.1453-14-johan+linaro@kernel.org>
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
> Use the irq_domain_add_hierarchy() helper to create the hierarchical
> domain, which both serves as documentation and avoids poking at
> irqdomain internals.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/irqchip/irq-alpine-msi.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

