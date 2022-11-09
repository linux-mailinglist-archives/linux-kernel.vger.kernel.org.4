Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CCD623013
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiKIQW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiKIQWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:22:55 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF7E1705E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 08:22:54 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id u2so26469029ljl.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 08:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w9DBQc/5dKXa1ET93Qb1zudE+cWUtfpHl+fK7TF/wvw=;
        b=PQrgsPzBm+nt4QIlMLQU9lO/Z/BDI0u6uh/lyA7xqgxRyEeS/K4w24CNwl0QxbSvxK
         LGjSlsX2N/boaup9pnwpB8aSQQ+JSWT6P6uNxJ8hlVkIeK4g9uzodJFOCyzrlZfdSrAc
         V66jj5FhfLEPUJUInS7u2MuR2CsdHUKM19JML+sWGRHpOvjWZ93+CZvxaN0wh5KjhYSb
         VIq0P4uBipcQ8KzXrtfbRNuAVI3fc+z4iVdQOovoW1irjfxPaas85LA4KBuWFRqcUgg2
         r/V6/DyA0uYfqPqmfY7MCNF8nPT67RlF33ZGE8qm2to+fm7ZDj3LHBHdCnsKtwwCmKfF
         tRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9DBQc/5dKXa1ET93Qb1zudE+cWUtfpHl+fK7TF/wvw=;
        b=nC6bU1dwdiglusd3S49AVIFRr2XTFPwDznFLFuHIybPlGCq8b2JHLQwN64dAt3Rtc7
         b2dyBEamSgZ8e+kzhlBcug5TjlbEN/NAZ3VTT9JeczzcLwrfspkPrJVkZB7ip2RaMC0N
         E97k2kh+UkD7g650iBUXflfwyS8jrsR6JOIQwe/FMLQGOj0d06e3HD1uw+iS3Lwd3bIU
         ry2mGffUC+ASzBCxkujVg4o6u4Hq1NZR8p5BrPpoQgqFYTX2Q4yItj+o0aBIb2xwnbnE
         2/qi2PoJEzIKOxfqlqB3KJcA0BnUZIp2Nune8uKFaQNmnV8ToJmWdGoXTEt/3RjMWyWp
         HJHA==
X-Gm-Message-State: ACrzQf1B/J+eQIW9toJ6mjq7GV94Dv0EEy0JGXyjEhVET+4XCwcduwUx
        H13shczEzwyYIu5s6Tvh47Soiw==
X-Google-Smtp-Source: AMsMyM4DA0Ra3IxLTRyHXuTQH71WtL/K0WEIrqvQjgKE7xUNK58r/sBTPFIrPd/VCXQl5AAnj0I49g==
X-Received: by 2002:a2e:b98d:0:b0:277:2f7f:a14c with SMTP id p13-20020a2eb98d000000b002772f7fa14cmr7539098ljp.96.1668010972253;
        Wed, 09 Nov 2022 08:22:52 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id k19-20020a2ea273000000b00277522fc29bsm2227353ljm.3.2022.11.09.08.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 08:22:51 -0800 (PST)
Message-ID: <3c530543-6d89-bf63-8734-7ccb02aede84@linaro.org>
Date:   Wed, 9 Nov 2022 17:22:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/5] ARM: dts: nanobone: Fix GPIO settings for RTS/CTS
 pins on UART3 & 4
Content-Language: en-US
To:     Mark Jackson <mpfj@newflow.co.uk>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221109160904.183147-1-mpfj@newflow.co.uk>
 <20221109160904.183147-2-mpfj@newflow.co.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221109160904.183147-2-mpfj@newflow.co.uk>
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

On 09/11/2022 17:09, Mark Jackson wrote:
> The NanoBone platform uses GPIO pins for RTS/CTS control.
> The DTS still uses the hardware RTS/CTS pins so this needs fixing.
> 
> Signed-off-by: Mark Jackson <mpfj@newflow.co.uk>
> ---
>  arch/arm/boot/dts/am335x-nano.dts | 8 ++++----

You still use a bit odd subject prefixes. What did the log tell you for
am335x files?

Best regards,
Krzysztof

