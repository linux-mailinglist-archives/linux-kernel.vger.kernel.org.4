Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A1064CE95
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 18:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239218AbiLNRCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 12:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239212AbiLNRCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 12:02:46 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9455927FEC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 09:02:43 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id s25so7266034lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 09:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9oRZHjiGgdJt0T702JOAD3bybZtyoQnmzqZwZW3fut8=;
        b=ATRG7cWiFz/XrkcFItQzWg3lI5l3X2Rod19On+GGF9KogbvhdG5csn0uQWQmMyMR0N
         fGH44CbLTZNam+tPCaocQc2O5+59UJ8gYTiVrdNdfuuDolUmGsXFweCDO8DHb0Sp/qlk
         8b3aCwVmMGhc6+v0oPIVcQ8XC611BxL74nahgRiLSSmRqKmCTNXbm+2mK7aDzdNO2vLl
         z3c0TqgYFrX4ykRrJOz/MEb7yWwFTkxNcJFDAXRmAbt5GaKDstVKoBPB29cRiAhDaQf/
         BwohcpU0O4E4jwLweG6okUickdEUHI05De2kzePtHffDFOdy8VRMgC7sB1aWnoGJBFvM
         FrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9oRZHjiGgdJt0T702JOAD3bybZtyoQnmzqZwZW3fut8=;
        b=2tX5cNav1jBfge4ZJbXMR0+XUq9+4Irg/K1uI89fDFdUrVcrk/1Pq2iPRy8hX59kI4
         pcSFTwwG15EGsqw06JekUJ8mTte7wsGw3JW5dvOSa0hlG3i6Jrh5pREAheQcZuJuK20p
         NrserOZxeMp/whb+POdAKFpLgvWAYjoX+3Ib10wjWUTkhK3ke7v+FkZDrHIVN7/H59Tj
         00iqwIEQKw91ZOAiIaXqfhrM0NFWjV7xPPT+u6M52eXAa+kUe4eWgyA9viVRgQXoCZX9
         zigeUmwEuUQ/YgcfUSqclb0Jhaif2FwolOM6hjDfGjqD2sH1XPG9208h1ayk/T9bt6Np
         gBPQ==
X-Gm-Message-State: ANoB5pkejeBwqHJIc9shYZPcGe1tlELiWNhiZCrnfSoIC4Yx+7APCLks
        6fM4R+uvlOaIbLp+QAOHkNraxw==
X-Google-Smtp-Source: AA0mqf5MPi/D9ZHKNP3t+6+uB+nwhbrwqogdZiQkoXqbRhEC6+fK+/dNpJo1Uku035/inB1HJNnmNA==
X-Received: by 2002:a05:651c:10cc:b0:27b:620e:3dd with SMTP id l12-20020a05651c10cc00b0027b620e03ddmr2472538ljn.13.1671037361840;
        Wed, 14 Dec 2022 09:02:41 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p18-20020a2e9ad2000000b00279f3c58278sm666684ljj.51.2022.12.14.09.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 09:02:41 -0800 (PST)
Message-ID: <1697ded6-f04c-183b-4f92-ea4d5eb1c187@linaro.org>
Date:   Wed, 14 Dec 2022 18:02:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 1/3] drivers: hwmon: Add max31732 quad remote
 temperature sensor driver
Content-Language: en-US
To:     Sinan Divarci <Sinan.Divarci@analog.com>, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221214142206.13288-1-Sinan.Divarci@analog.com>
 <20221214142206.13288-2-Sinan.Divarci@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221214142206.13288-2-Sinan.Divarci@analog.com>
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

On 14/12/2022 15:22, Sinan Divarci wrote:
> The MAX31732 is a multi-channel temperature sensor that monitors its own
> temperature and the temperatures of up to four external diodeconnected
> transistors.

Use subject prefixes matching the subsystem (git log --oneline -- ...).
There is no such prefix as "drivers".

I did not review the code, but it is easily visible that it does not
conform to Linux coding style wrapping at 80. Wrap at 80.

Best regards,
Krzysztof

