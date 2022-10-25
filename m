Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E0960CA45
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiJYKqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiJYKqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:46:09 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6999B105CC6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 03:46:07 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bs21so4195417wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 03:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i+8AFzb0QvutmrInvEcPVE6xbGlo8PJlTtfn9aefrYQ=;
        b=MgCRBCFH2vNFDbd/zjXk7zqkzEN8/WGngLeR91FZXh6H7ZLcapO8GernsN6P/jzJbL
         DHqYERSzx33YN0Gfjntoi1ApYcwvZ3kY2rnGgA2fxrc3LY3lmgdbwgLmccn0InVcNMZN
         SGvCsXz4/L09rBMW/nz/RKkIJTh+rpofjr5NWWFw9To6eBMSBxS6o0XrhTMI4EN1Rw4y
         MGxyVzb7dsjD1OX5+ZN0YQ8CkaS423VITClbXAhGJDuM7JZWzCKM7yUpqf4Yzkgrl3le
         7SztacFBlW+LXFF/742dwrhJlbYoFlA0DNBf32gjF5cdEWkNom5HJF9+4uvIQcdzzyKX
         kb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i+8AFzb0QvutmrInvEcPVE6xbGlo8PJlTtfn9aefrYQ=;
        b=rOH07dcRBHTa9gaD0Vq/pgJKcUxugq3mciI+evsiojAsHMwKA27ZHf5rG0m3v8R5ck
         KToxYUhT3IiLloalkhEw56ElegMfMmZIJu1yBaExzHtRT8OI1McU+zZHa7o7wCcn+fd9
         ndnjDt6c6UqIFGYUa63eU+GBXN0/DgpCOI9cKOqc9PS16xmlXAs52WE2KEaXH96eRfs1
         P4cVTsEYk/8EYbnM4KaZ7SQEjNXISei80VE7MmLYK/AXmzTJfkRWxA3I0aIEGTqPSWLo
         5Zq6vhJkdYermHQLOpk95qosonhJpEurHmy169neHz/XjLVUjD1FN5gHOgROCAyvyu+o
         /dTA==
X-Gm-Message-State: ACrzQf1yQ6HPcmgUE3P1kYZXdPHwG26c2dal115ZZeBO/ahjUbh/833k
        cQ2ByAVcc1cIbdpNhogd/aqyDw==
X-Google-Smtp-Source: AMsMyM4lYr49SZPTSwaHPHxdwFT3VT/aLcxvjtGgdeFGAc/V+Y+5S2Cx8mrMmfeOld4LMkZrAHizEA==
X-Received: by 2002:adf:dd12:0:b0:236:6ef7:dacf with SMTP id a18-20020adfdd12000000b002366ef7dacfmr7425515wrm.204.1666694766063;
        Tue, 25 Oct 2022 03:46:06 -0700 (PDT)
Received: from [192.168.1.115] ([185.126.107.38])
        by smtp.gmail.com with ESMTPSA id w17-20020adfcd11000000b002366b17ca8bsm2532264wrm.108.2022.10.25.03.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 03:46:05 -0700 (PDT)
Message-ID: <3daf3a70-ce48-ce42-58d6-ec49ce1cd9f1@linaro.org>
Date:   Tue, 25 Oct 2022 12:46:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH 5/5] pwm: jz4740: Use regmap_{set,clear}_bits
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     od@opendingux.net, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
References: <20221024205213.327001-1-paul@crapouillou.net>
 <20221024205213.327001-6-paul@crapouillou.net>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20221024205213.327001-6-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/22 22:52, Paul Cercueil wrote:
> Simplify a bit the code by using regmap_set_bits() and
> regmap_clear_bits() instead of regmap_update_bits() when possible.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>   drivers/pwm/pwm-jz4740.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

