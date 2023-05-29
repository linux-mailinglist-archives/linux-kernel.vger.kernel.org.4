Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA74C714CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjE2PVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjE2PVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:21:06 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD011CF
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 08:21:03 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-30aa76048fbso2088535f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 08:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685373662; x=1687965662;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TBUyi7GtvvTumLP5OPVjGqROpV802wvk7yxqnFgwTHY=;
        b=Msn7AW1khWORLn/oD/9VF15pkuplmldeqTa1sZH7PRTWzL9284dima5XY3ropCTDrd
         WkoMXDtdqR2n738N6PCPiPJ7E+Q8wE750FrMkHSK3SzZACRvtCw5iA2sX1itxo2rxocV
         Fryn5uTbDazceFQSQs0WI+0snyV8iQ1u0Lvd1K0VD4vQE+Gpxg5byq/SO/4P3c9QRBMR
         Tmv9l3R0W2rhDamU+x4TbngiA/DTWk3G47cgTVkWibvno3Ok+m2yBUFrPuNpCjRUbMbq
         lWtstpgFgaVncvS0Yj0/IPViUMLvBEpXEGMMunEziBT4rQZZ4A4MOaa+Lfxd8h2+fOYq
         sB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685373662; x=1687965662;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBUyi7GtvvTumLP5OPVjGqROpV802wvk7yxqnFgwTHY=;
        b=JzGeW4n4G6Kbyofd/hHhMgt3/oGmVJ9BqO5tpjw7Tf6DD64hnxTga6DC1mfCOdvHQJ
         Y4vWfmxi6QcFN4guHwryO5j7OlWuXs8ElszO/FH9SGv2angbEIb7xmQmD3aXsZ0pW4wU
         hKg3r0iE5wEupMgeB6/EGW0jhl2h2vUSRyU9tqCMyHdc6pBDgbEI9wwDc+XB63/4lBtn
         DPQjVDXmduqVnVs6ZLrdqpr/UUVvz4WBHnsICsFG5sdp+nkBw+X/2S3OS6DGkagNDG3N
         mSEaV6irTvk84KcWhvvgaAVen5lDEGHefk143Rg3yvkxOfIvAurXE70cwGXyVarTcio6
         lfYA==
X-Gm-Message-State: AC+VfDz+JahUDQdTfWdNauh8Kym4ikjufP+AxqVBftVIuHfp/+f/COZV
        kWlOroNYDc1EEXAarIafgYjrmQ==
X-Google-Smtp-Source: ACHHUZ5QsPruAv4u4ZJBUO5E7KlnTJFL6JDOEHss86t1fBqmlCJvSruzkrQftYsvmoGskysj74HOAA==
X-Received: by 2002:a5d:4e82:0:b0:30a:eadb:791b with SMTP id e2-20020a5d4e82000000b0030aeadb791bmr2551244wru.29.1685373662138;
        Mon, 29 May 2023 08:21:02 -0700 (PDT)
Received: from [192.168.1.91] (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id y4-20020a056000108400b0030abe7c36b1sm241306wrw.93.2023.05.29.08.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 08:21:01 -0700 (PDT)
Message-ID: <2c970ea3-e927-4ea1-f378-a600e834cc9d@baylibre.com>
Date:   Mon, 29 May 2023 17:21:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/2] gpio: tps65219: add GPIO support for TPS65219 PMIC
Content-Language: en-US
To:     andy.shevchenko@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>
References: <20230511-tps65219-add-gpio-support-v3-0-19837a34d820@baylibre.com>
 <20230511-tps65219-add-gpio-support-v3-1-19837a34d820@baylibre.com>
 <ZHD3VtFDYUyy_Std@surfacebook>
From:   jerome Neanne <jneanne@baylibre.com>
In-Reply-To: <ZHD3VtFDYUyy_Std@surfacebook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/05/2023 20:15, andy.shevchenko@gmail.com wrote:
> ...
> 
> Missing bits.h
> 
>> +#include <linux/gpio/driver.h>
>> +#include <linux/mfd/tps65219.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>

Thanks for your review.Just to be sure on this particular point:
Your recommendation here it to include explicitly bits.h.

I can see BIT_MASK(n) defined in linux/bits.h
BIT(n) is defined in vdso/bits.h
 From what I can see, BIT(n) is broadly used across kernel but 
BIT_MASK(n) sounds to be the Linux strict way...

In current version I'm using BIT(n) macro not BIT_MASK(n).
Do you recommend to replace every BIT(n) currently used with BIT_MASK(n)?
Sorry for asking dumb questions. Just trying to make sure I 
correctly/fully understand your feedback... And do it all right for the 
next iteration.

Regards,
Jerome.
