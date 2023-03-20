Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA1B6C1266
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjCTMyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjCTMxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:53:39 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF41D10416;
        Mon, 20 Mar 2023 05:52:49 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a32so11969799ljr.9;
        Mon, 20 Mar 2023 05:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679316768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zCToRhyvamqpUChblok6lbeYTkxrxScmxRdGNZTiQXQ=;
        b=hXwQuDiR7xgFlpYbDYDX8VjJaFYLQuQ2cb/hE4kCQ3u7w0dMhJ3WnHPy59pTozkDOQ
         ThkjLKj3sNbISRTaG+7gC9BdVtN0+PQt5xu8RqTs1ixxO8GA9N/2herx/sNBwnI4JSmY
         UAd5UWjXHlGblFGXj6F6ceNtISGrha1L/pwV2F0sVitytDb5kywIgwCS049R+UiSrPBy
         dIL11sNyitVSrLW7lHx0DnwC48XHXYNa+M4GvjX66plt1ftUTNluNuW+rigKddarElR/
         Uv+qYtEKGWaAr+leddvnl3QQwKk2pI5QVcbyp9/udEYdZSceTdhUTIZvkgJOZG0+pCG2
         nQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679316768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCToRhyvamqpUChblok6lbeYTkxrxScmxRdGNZTiQXQ=;
        b=6wF/4KGQCAew3cU1/YhplhEP193Bou6yn2BBCgyiPooh+I+X4Yj5TwXT6tJPO7ffaM
         y7bSI56mDm+0UixhUCEdlb9xih1X7T7HqzPiWD0hR2GErojI2hCVe2JNEEVBcmg/EiG+
         T6KhXpYdUEugILN0AgC+RKp7N+cP30qhUww6o3ZexiBMUOd9vECq3ryJsM3Pu3ynup9l
         N4pxGrEJxuKuQo38/YjsoCN6o/rqXZMPwylqA9xyYWIqVdTDNN+xGZCefzGQGdnkoY8s
         LiZRq46CVcyheuuZYjmFcWnHFtQAs9vhtxdl4Ti1xQqSV30GH31qSjrQcI90KXyx1H6P
         +YIA==
X-Gm-Message-State: AO0yUKUL3QbetqJ7VualnIsFAlxO2Mun40AyPsnnSVsQK1kwApgnRyF9
        7WjbrCDPqIqJTs/rXODfcpIrXC9IyAY=
X-Google-Smtp-Source: AK7set9ABfMHLkdwBXy7qpN2dpsdelT7S9eqrnTc1mDgipV3LpikiNQJ1ZCO6//w0RHspkNadvxGMA==
X-Received: by 2002:a05:651c:50b:b0:298:a864:8c14 with SMTP id o11-20020a05651c050b00b00298a8648c14mr8117364ljp.10.1679316768151;
        Mon, 20 Mar 2023 05:52:48 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id r2-20020a2eb602000000b0029a1ccdc560sm1730478ljn.118.2023.03.20.05.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 05:52:47 -0700 (PDT)
Message-ID: <f2bb93af-da9c-cf16-2f07-90e653af662f@gmail.com>
Date:   Mon, 20 Mar 2023 14:52:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/3] iio: accel: kionix-kx022a: Add chip_info structure
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1679009443.git.mehdi.djait.k@gmail.com>
 <3ddca10a4c03c3a64afb831cc9dd1e01fe89d305.1679009443.git.mehdi.djait.k@gmail.com>
 <4c28925d-c07c-61b7-8863-9c00e6846687@gmail.com>
 <20230320123408.000008c0@Huawei.com>
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230320123408.000008c0@Huawei.com>
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

On 3/20/23 14:34, Jonathan Cameron wrote:
> On Mon, 20 Mar 2023 11:35:06 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> On 3/17/23 01:48, Mehdi Djait wrote:
>>
>> OTOH, to really benefit from this we should probably pull out the
>> regmap-configs from the kionix-kx022a.c. I am not really sure where we
>> should put it then though. Hence, if there is no good ideas how to split
>> the config and chip-info so they are only available/used where needed -
>> then I am also Ok with the current approach.
> 
> Definitely stick to current approach.  If I had the time I'd
> rip out all the code useing enums in match tables. It's bitten us
> a few times with nasty to track down bugs that only affect more obscure
> ways of binding the driver.
> 

Seems like Jonathan has a strong opinion on this. Please follow his and 
Andy's guidance on this one and forget my comment.


Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

