Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E7D607745
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 14:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiJUMsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 08:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJUMrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 08:47:52 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD81F2681D8;
        Fri, 21 Oct 2022 05:47:26 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j4so5023738lfk.0;
        Fri, 21 Oct 2022 05:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bR/IhUckEHa0IuDp4LpofYq5xrM/m2D7Ojkw4Y/+w3U=;
        b=TLM+JtUNdSTDgYochS4bQIpw/lUzMOmCYgxgRZCX0Ul1bbmUk4FG/vnbEmLgH7hdWz
         2x7dlQropn+4X7pJeyQIB9Tc2AZ2/ojxRIyZ4KchxtnR8JHfNlFny/A18Anl4JjVp13k
         +gurWy6lzRogPbwNIJnOiMVIsBP9VOj84wMIXXdkyUXb8HFA9B4gkBw89Hck1BL0P4dZ
         QrrfnErkVO0WwfOR8GToORjbJ+agqUF/PLKnA0HfFBvYdwtZ0/lx7025ehOMrTS03XsL
         MRfCx0laknxasZ5uOFPGe7h7IvDrTkwBaPxVh7KW4Y+kmcHVW9bSUYZPCbXhmi+SzkyF
         YmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bR/IhUckEHa0IuDp4LpofYq5xrM/m2D7Ojkw4Y/+w3U=;
        b=5zInzImfg3kfkwQ6s0R4mGH5PBuqV0/GeGDciLW9fWyZoZMEtxzsp7qNQBcP6jKBhi
         funO1IYTsFOPpcwLh0WwKZJYka3GsHV9vyWmO87qqxOciv1srmCjgMLuXvaucAsseBqO
         jm/MH81PJa4m/RL5sgyDl6840xS+bOBdy0tyZ1f/zCuwlJYKXcUmFbIVb1wXhp+/JK6u
         kf2Le1VhtSWeZaSj+bqejoA5u2hOkrTN0lLKMIrRgWLf6/BKJubpSWyx1GZy1emOgDEx
         hHPqhGK0HDyk2EDREHunuJHzT5WeZ2FrJkbQyRnlyqti+N2y8OauN9JcciQgn1O3Y0IZ
         /P+Q==
X-Gm-Message-State: ACrzQf0lMp6VojRoDLMwyOaWRYkZiRHxA02j5GS0MhYeJLU0V3Ed7ZGm
        V109EyooLiAjikJppBn73n8=
X-Google-Smtp-Source: AMsMyM6Y0EJ9fKVz8wvZSCc6WuQtwmnn//WLkH4s1Kd1TwrsGcVuo+mXNhDHLhIurlPR+3TjhPdzSQ==
X-Received: by 2002:ac2:4db8:0:b0:4a4:5e0e:b75e with SMTP id h24-20020ac24db8000000b004a45e0eb75emr6343437lfe.64.1666356443312;
        Fri, 21 Oct 2022 05:47:23 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::2? (dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::2])
        by smtp.gmail.com with ESMTPSA id 6-20020ac25f46000000b00492d064e8f8sm3136967lfz.263.2022.10.21.05.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 05:47:22 -0700 (PDT)
Message-ID: <82dcb300-5cf9-db86-2264-ba3b04a50ed0@gmail.com>
Date:   Fri, 21 Oct 2022 15:47:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 2/3] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1666350457.git.mazziesaccount@gmail.com>
 <7baf3dd482ab1db0d8a3676d6d5d3e4ab7f3cf9d.1666350457.git.mazziesaccount@gmail.com>
 <Y1KTibIKKz/KdJDj@smile.fi.intel.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Y1KTibIKKz/KdJDj@smile.fi.intel.com>
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

On 10/21/22 15:41, Andy Shevchenko wrote:
> On Fri, Oct 21, 2022 at 02:22:49PM +0300, Matti Vaittinen wrote:
>> KX022A is a 3-axis accelerometer from ROHM/Kionix. The sensor features
>> include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,
>> tap/motion detection, wake-up & back-to-sleep events, four acceleration
>> ranges (2, 4, 8 and 16g), and probably some other cool features.
>>
>> Add support for the basic accelerometer features such as getting the
>> acceleration data via IIO. (raw reads, triggered buffer [data-ready] or
>> using the WMI IRQ).
>>
>> Important things to be added include the double-tap, motion
>> detection and wake-up as well as the runtime power management.
> 
> While I have some disagreements on some code
> pieces, this version is okay to go I think.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for the thorough review Andy.

> Below a few nit-picks in case it needs to be a v5.

Just a note that I do agree with these 'nits'. I'll fix them if I need 
to respin the series.

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

