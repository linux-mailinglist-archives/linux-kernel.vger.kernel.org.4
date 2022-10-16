Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9A06002EF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 20:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiJPSpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 14:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJPSpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 14:45:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D222E9C0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 11:45:08 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r13so15207770wrj.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 11:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7hUvasE44hYvxTOWnqZWHCPPhE7X3bpjcc2vJnBfH9k=;
        b=GkIABXBkGaCcT8QxtzXzhV9grSN8SBpQawQoAT5Mdeo/+A/EniJe0JJdxaKF8dVx/r
         79aITc+u+mbuGJMR83E63bCgVhKnQTbhL1yw0RtZtuE2M7zzF8FLqJ7wHkhHytJzskvJ
         ZUPj67+ntIO42TcasDiN3EgZe3G+7GnKViS9dMo+0WKcIX2hueO0wakb4ozXJ2vkjUZx
         eKlC7MPvUBU7ZSuNVBihxYunjwEMxddgBa1g4OUrl9Fpk9eAEVHoeHs/WB/3ag17Nvrp
         zBX9TnjcTcWsPPNFnZu+UY0Moh/7+AHBdmufMfgP4mS6po/G7atqt3c/ukpfxcKDKfzp
         B1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hUvasE44hYvxTOWnqZWHCPPhE7X3bpjcc2vJnBfH9k=;
        b=FjoTnJufJD0yib9dnVpFrU5hEQDNlKcfVTBhvvij4KCe6kOzZSSrbQSJkTXovj9Dps
         5VK66BqlG8Z0QtDrrL0Jm+XKtUVqZJ7LjdvM8P1Uq7WwajzTYhCneSeiDYb+AY8/KuRs
         veaiLl904bnnOR4033fBYahfGBnmGzqAxyk24km6htWzWkHmU9umyc1zGGQYyXht35zT
         X2EPh6U8ae9vLkSqrnzzHzny+6V+Ci2X1v3htQENp0IYjVlM7o1f6eAf5i46jvZSF+j6
         rT7qaSvogi3qreUS4hY3QsuGaY1mRYj06V7dbYMrd2f0kd/FVt+iPQVPz9ztnFxQ+AHe
         X23w==
X-Gm-Message-State: ACrzQf2fjCtB1JxhZVF9sJvzIcsoeZdF4Ipgsf/HrcTnuZ3v2caarRYw
        DRyjfl2zOe2ewORFdpUwusc=
X-Google-Smtp-Source: AMsMyM6pjjFkyK6gzqx0jvtbLOA6j8uP0x7RX2AKopsDGd5fFVz43GdMFJob65/DMMJQliJvpTgZyw==
X-Received: by 2002:a5d:4683:0:b0:22e:6be0:dfc6 with SMTP id u3-20020a5d4683000000b0022e6be0dfc6mr4311024wrq.573.1665945907145;
        Sun, 16 Oct 2022 11:45:07 -0700 (PDT)
Received: from [192.168.1.104] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id g17-20020a05600c4ed100b003b4ac05a8a4sm17339177wmq.27.2022.10.16.11.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 11:45:06 -0700 (PDT)
Message-ID: <c0afd086-156e-7414-2082-a13f6a728f8f@gmail.com>
Date:   Sun, 16 Oct 2022 20:45:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 00/10] staging: r8188eu: led layer fix and cleanups
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221015151115.232095-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221015151115.232095-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/22 17:11, Martin Kaiser wrote:
> Here's another series to clean up the led layer and fix a problem with
> leds during suspend/resume on some devices.
> 
> Martin Kaiser (10):
>    staging: r8188eu: fix led register settings
>    staging: r8188eu: handle rtw_write8 errors in SwLedOn
>    staging: r8188eu: fix status updates in SwLedOff
>    staging: r8188eu: SwLedOn needs no padapter parameter
>    staging: r8188eu: SwLedOff needs no padapter parameter
>    staging: r8188eu: remove two unused defines
>    staging: r8188eu: don't include rtw_led.h from rtw_cmd.h
>    staging: r8188eu: remove padapter from struct led_priv
>    staging: r8188eu: set two more state variables
>    staging: r8188eu: summarize tx/rx and scan blinking
> 
>   drivers/staging/r8188eu/core/rtw_led.c    | 62 +++++++----------------
>   drivers/staging/r8188eu/include/rtw_cmd.h |  5 --
>   drivers/staging/r8188eu/include/rtw_led.h |  2 -
>   3 files changed, 18 insertions(+), 51 deletions(-)
> 

Apply Patch:
"staging: r8188eu: remove bLedLinkBlinkInProgress"
before this series.

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
