Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC0A5EE1CA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbiI1QXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbiI1QXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:23:18 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8BA56B85;
        Wed, 28 Sep 2022 09:23:10 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d42so21249634lfv.0;
        Wed, 28 Sep 2022 09:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ENny02jrZKVbgPfzbkbRE4ZovlzNI+xmygHZLGPqIBs=;
        b=ZtknbgmU/wmbcYwSVkoJB+W1EHC/7KVOArUns8X67T/KOCkbeed1buC3ysC9Phfwfi
         ifQ9jpg5aQLgZQEQvWcamMuhilITQTXz4qnEAuPQoouDK+5gcyTD0NinNArywTuVVGki
         bnoCGDAX32g12eoedEj2Q5wE4jQ0Wzl+ZICavftNxBx0GTr6VAGnXkIQQnEqgPlN9h5F
         PL1x61LC9+KI06GHyaPnwnfoPUlD/dkp6kSg/4uPADRgMrZfDv1Nt93sFjswxM8h6E+p
         0LF0GiJ6bcvKD8phn8SNduNvjHAK5McCCqZmZbtc1WY+Dx3rJgQZNcGtCoCMhaysAb59
         gLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ENny02jrZKVbgPfzbkbRE4ZovlzNI+xmygHZLGPqIBs=;
        b=QpMQUlu+Sjhh/W357+iACLr+yq9Rq02OAIpVprcaNtjJGoasA44NISGIzq7rgSnrSv
         G+0muW/VGrIYsTuNdWpSDJiYJ8t6MTPpxUHrIRwNlQ4cGU9gmIXSvhRQ77KIuz2OwSa7
         8QpdEm7jD/a0/7EkfrGOXV+vgL1D/7r32R4y7eZnAxBb6QbDn7QVIbagGMdbbxzCTdBd
         9JaWgfW0mTqC33jhqMatTSNVW5N620Z3TcafsEcnXSEBdlLiDQ1Iw2WTh9DLJbkbB8V5
         W2jt7Tcb9ZkEt2xp2s71zofFNMdFPiooWXWFF/WLUeq2UW688TiZfYAHzwZoMIaulKk6
         vS9g==
X-Gm-Message-State: ACrzQf1UQ5sdkU1Elp/Q8wNXRZgp4vouWYbWNFNcRlnjiIMxAoCDBk1R
        NF1eCYceGpkr0AVwMMHi03A=
X-Google-Smtp-Source: AMsMyM5gtxklHbrdm1xdQqDlFiUiLhPp7YuJAm3I62QCBKtAMamqNsiIC8L5zDr5KDF8j5icQVK0sA==
X-Received: by 2002:a05:6512:104f:b0:4a1:b0e9:dd25 with SMTP id c15-20020a056512104f00b004a1b0e9dd25mr9371959lfb.454.1664382188690;
        Wed, 28 Sep 2022 09:23:08 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id u20-20020a197914000000b0049ade93ad24sm511834lfc.156.2022.09.28.09.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 09:23:07 -0700 (PDT)
Message-ID: <e3abc0a9-ad5b-f6ef-8cba-0b4c6c8325c0@gmail.com>
Date:   Wed, 28 Sep 2022 19:23:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>
References: <cover.1663760018.git.mazziesaccount@gmail.com>
 <fe1088cebb0de70bcb99af517004c1816b696825.1663760018.git.mazziesaccount@gmail.com>
 <20220922180339.30138141@jic23-huawei>
 <3eea7954-3faf-3fc9-7507-c318488c5524@gmail.com>
 <YzRU9aRNReonSqbg@smile.fi.intel.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <YzRU9aRNReonSqbg@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 9/28/22 17:06, Andy Shevchenko wrote:
> On Wed, Sep 28, 2022 at 02:14:14PM +0300, Matti Vaittinen wrote:
>> On 9/22/22 20:03, Jonathan Cameron wrote:
>>> On Wed, 21 Sep 2022 14:45:35 +0300
> 
> ...
> 
>>>> +		dev_err(dev, "no regmap\n");
>>>
>>> Use dev_err_probe() for all dev_err() stuff in probe paths.
>>> It ends up cleaner and we don't care about the tiny overhead
>>> of checking for deferred.
>>
>> This one bothers me a bit. It just does not feel correct to pass -EINVAL for
>> the dev_err_probe() so the dev_err_probe() can check if -EINVAL !=
>> -EPROBE_DEFER. I do understand perfectly well the consistent use of
>> dev_err_probe() for all cases where we get an error-code from a function and
>> return it - but using dev_err_probe() when we hard-code the return value in
>> code calling the dev_err_probe() does not feel like "the right thing to do"
>> (tm).
>>
>> Eg, I agree that
>> return dev_err_probe(dev, ret, "bar");
>> is nice even if we know the function that gave us the "ret" never requests
>> defer (as that can change some day).
>>
>> However, I don't like issuing:
>> return dev_err_probe(dev, -EINVAL, "bar");
> 
> This case specifically was added into documentation by 7065f92255bb ("driver
> core: Clarify that dev_err_probe() is OK even w/out -EPROBE_DEFER").

Yes. And this is exactly what I meant with:
 >> Eg, I agree that
 >> return dev_err_probe(dev, ret, "bar");
 >> is nice even if we know the function that gave us the "ret" never 
requests
 >> defer

There is still (in my opinion) a significant difference if we call:
 >> return dev_err_probe(dev, -EINVAL, "bar");

- where we really hard-code the -EINVAL as a parameter to the 
dev_err_probe()

>> Well, please let me know if you think the dev_err_probe() should be used
>> even in cases where we hard code the return to something...
> 
> And this should be, of course, maintainer's decision.

Ultimately, yes.

Best Regards
	--Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
