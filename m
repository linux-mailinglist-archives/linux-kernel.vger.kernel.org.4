Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69FD7298D1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239455AbjFIL5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238820AbjFIL5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:57:07 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F053594
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 04:56:34 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-976a0a1a92bso311034366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 04:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686311781; x=1688903781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oYrIxCV5eN1GYZDJEJ1UfI92aRFL2OYEZ4NP6sPPE2c=;
        b=LO+fORubTVhmrOyNTWIDUURXux/NlOjg6bPwDxETFP0wrzbqPmSJH579qNs6TW9Dy/
         kZUXic95WuWnCLXNRivrshUhTP8eHvUuzi3fP/8jbEHRSqLfIdV/VRUW3KlOy5d5wgc7
         GqNUDBVs4TaECJ1Scp/WsddYlkFwsx4dgKGE3fPANBz/M+NrHmnoqsjA33Oy1Syy+u9x
         VieIWj1BMAx8bMcXUSxhIkZaUZBR5lc5Bc6WgLmZ7R0PVBIg1i9XmdB6JNKneuc8uf4+
         o0vww0+nzpd+h1nhfMZDhvkscVZLjlVFZA2X6uoZKbVFxjw2GsNxV6lpXMPLimtr0lyP
         IbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686311781; x=1688903781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oYrIxCV5eN1GYZDJEJ1UfI92aRFL2OYEZ4NP6sPPE2c=;
        b=f87aCLLX738HDMd0+7gTLe4iU3WzfH7sy4Q+s3i3A2AYv502Ax3epJpNSMm9iCZNxa
         +a4i9zGRLWzU8HkiFa2NaBYWkrgHFS9amE6StgU0VCwcOsgAR80EGgtjtPcKSmX3duP2
         SsV0/B3HD7a+IaULOsPXdmroJJzmFJsW3+NZeH/Dz3VtuITlNEpNcVJFOXPaLG8UwjsD
         GzdiaDcTPOGp8GysmVNec7rwkHs4bR6Mx+X19HQ9kD+H2AVud/RIyYHNQCnewRfh4VsS
         3QFExHJjJpr1yhVHARlavlQ1NhZm2BqR+p6I1s/nJG9ud1U7Y2IrrSnzijtjZNjJIqzT
         xu6g==
X-Gm-Message-State: AC+VfDxEhMlBZE8tj8+6H2qkuYPw4gCzzgkY341GKzHIbFn6tg+vwcxQ
        Jz2hE/Fes230XZfQ+Hq30Fbe9Q==
X-Google-Smtp-Source: ACHHUZ7kFcjPb/Bl918mM98lpkRB6MU3jCR+A5T5xmYDhf2Kx350E1NZgAXUcmyAU0dnBFyQ5CpUHQ==
X-Received: by 2002:a17:907:789:b0:978:ab6b:afd4 with SMTP id xd9-20020a170907078900b00978ab6bafd4mr1639295ejb.43.1686311781136;
        Fri, 09 Jun 2023 04:56:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id b14-20020a1709064d4e00b00974638e4a98sm1207167ejv.24.2023.06.09.04.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 04:56:20 -0700 (PDT)
Message-ID: <f3607725-b08c-8d96-02f8-f8f89af8e8b1@linaro.org>
Date:   Fri, 9 Jun 2023 13:56:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: AW: [PATCH 2/2] tty: serial: samsung_tty: Fix a memory leak in
 s3c24xx_serial_getclk() when iterating clk
Content-Language: en-US
To:     Walter Harms <wharms@bfs.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Abraham <thomas.abraham@linaro.org>,
        Kukjin Kim <kgene.kim@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
References: <e4359d5ef206f5b349c1d15a515a1205e78dda55.1686285892.git.christophe.jaillet@wanadoo.fr>
 <93bf8f574310256fcea50e5c5a62b5c37e20bb14.1686285892.git.christophe.jaillet@wanadoo.fr>
 <f31523d7270d4a1f82d96b7891ed13e6@bfs.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f31523d7270d4a1f82d96b7891ed13e6@bfs.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2023 10:57, Walter Harms wrote:
> 
> while we are here ....
> 
> perhaps INT_MAX from kernel.h ?
> 
> int   deviation = (1 << 30) - 1;
> 
> the part before looks a bit strange
> 
> if (ourport->info->has_divslot) {
>                         unsigned long div = rate / req_baud;
> 
>                         /* The UDIVSLOT register on the newer UARTs allows us to
>                          * get a divisor adjustment of 1/16th on the baud clock.
>                          *
>                          * We don't keep the UDIVSLOT value (the 16ths we
>                          * calculated by not multiplying the baud by 16) as it
>                          * is easy enough to recalculate.
>                          */
> 
>                         quot = div / 16;
>                         baud = rate / div;
> because
>    baud=rate/rate/req_baud = req_baud
> can this be simplyfied ? (or is the numeric required  ?)
> 
> 
> Homebrew abs()  kernel.h has a abs() can we use it here ?
> 
>             if (calc_deviation < 0)
>                         calc_deviation = -calc_deviation;
> 
> to the patch:
> 
> +                       /*
> +                        * If we find a better clk, release the previous one, if
> +                        * any.
> +                        */
> +                       if (!IS_ERR(*best_clk))
> +                               clk_put(*best_clk);
> 
> the intentions are good. *best_clk is user supplied (and should be NULL)
> filled & released in the next round but IMHO must be valid (is clk).
> so no need to check. (ntl clk_put seems to handle NULL and ERR )
>    if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
>                 return;

Don't top-post.

Anyway, I don't understand what you want to say here.

Best regards,
Krzysztof

