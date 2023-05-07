Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8156F9978
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 17:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjEGPpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 11:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjEGPpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 11:45:21 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0072913856;
        Sun,  7 May 2023 08:45:19 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f1fe1208a4so1177580e87.2;
        Sun, 07 May 2023 08:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683474318; x=1686066318;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6cwLaiqaYx45levWACx9ZFz+HjMEh0/Q11DboFD6gYw=;
        b=bH+5sOpAeRoHmX1TnwEBS+wDE/f3xhHXj68z74KlY38CU5hYclw2iktZvgq7YpqKgq
         BIBEr904rYbas3cu7KCuqiye6npn8GPIdFVP/Kjoc990tvEmKf5Jn81nF5Wraf97+Zgn
         UzBd7HiGkE1rUrVoz0Dr3YaqbH7Ub8qqq6ADY32bVZ2b1aZzsVR7PYIxx2iZUcowRrEs
         drQEfxDTVazgcZeiPz9Do89gtwEN/PejQxEavS/ZRdur8wocYIhh4mJqMqxpNLcQ5pc3
         5AN6kX4F5hyz8gfwOyozLMo36OD0pQPUWTZgrvQYhSlfvifkL3KPnbYspY1SSnGoCsrS
         74lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683474318; x=1686066318;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6cwLaiqaYx45levWACx9ZFz+HjMEh0/Q11DboFD6gYw=;
        b=bcUaB5WoCJBFRRuCgCCkTPGQgv/RIkdI9RhjkZDSV9Ev2bVjU2TLdgsTs2GmHAakZF
         kT1mXoFuSjZm9EvfZP4ei96R7m4mWTgMa3XTPpiCIVTwJuGqVpvBU7b/uAd1kYjQ0oSe
         Ffx4ceHqYUg8nO556pGf39RYga3+S/sTsaPmO7jDfWzmqRORR7ujJxSwxZwDjfilDQ9q
         nfpPYXbm9mjw3zh9PtcYO+WYdxZnUTqdcbdyThKyGkeSnPZpGqcALgs5URaEXFGKd+9o
         vIbxktFtFGbk5np3/3slLrBpKGS8qNlkTLvkyg6D4fIWMZYVGgKrg3jPF89+RDOUD+gt
         4d8Q==
X-Gm-Message-State: AC+VfDy4FexM1TQx8NohpBiQe+26jj5iSlCNsNDKe2Moe6leDPBTC7hX
        NSMIIkLDcbo5Myq6tstS8xLGn1+yLl8=
X-Google-Smtp-Source: ACHHUZ5+BUHndmjFMBXFqWQxPpADU0+M7qdyueWRcvghHEVH9JNvP0lacfx6/qDMBNrBrnLwDBv5Bg==
X-Received: by 2002:ac2:5443:0:b0:4ec:a4b4:4731 with SMTP id d3-20020ac25443000000b004eca4b44731mr1802957lfn.68.1683474317967;
        Sun, 07 May 2023 08:45:17 -0700 (PDT)
Received: from [192.168.1.111] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id z14-20020ac24f8e000000b004e843d6244csm1016481lfs.99.2023.05.07.08.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 08:45:17 -0700 (PDT)
Message-ID: <1a18a026-6674-b838-ade4-9cff385e6007@gmail.com>
Date:   Sun, 7 May 2023 18:45:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] iio: bu27034: Reinit regmap cache after reset
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZFM7lE4ZuDrUTspH@fedora> <20230506190738.0b6e4b45@jic23-huawei>
 <453da7af-8a83-f302-eea6-159e6222f430@gmail.com>
 <20230507143602.08a11f12@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230507143602.08a11f12@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/23 16:36, Jonathan Cameron wrote:
> On Sun, 7 May 2023 13:16:57 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> On 5/6/23 21:07, Jonathan Cameron wrote:
>>> On Thu, 4 May 2023 07:59:00 +0300
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>
>> I think I've never temporarily bypassed the cache when I've used one :)
>> I need to check how this is done :)
>>
> 
> regcache_cache_bypass(map, true / false);

Thanks! This is a nice tool to have in my toolbox ;)

> 
> Combine this with the other patch into one clean fix / tidy up though.

Sure, thanks!

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

