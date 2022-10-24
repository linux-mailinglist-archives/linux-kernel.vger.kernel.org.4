Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BA860B60A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbiJXSqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbiJXSqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:46:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC608958E;
        Mon, 24 Oct 2022 10:27:41 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id t25so1121601ejb.8;
        Mon, 24 Oct 2022 10:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/eVCAg3MBYd00s2yyl7DgTtrrb0tSrJ4c68oN1h9w7E=;
        b=dWa6dI5uCP4zJ4fO87i7erufj+h74Eryr600BTY2QUywiHyhBUFgAnaAcWtyOm9zAW
         y6PqOrHwesRzvwsMPXefrRMm2amR0AvkQSmElforbPJeEckFngzq3AAy5p7cSCichffm
         vHbSp1iAL1kt2edI6mn3RGydtnohDUjMQfHExBmT2Tf9bDS7TXo4F3wsgp0kcH/+dSvM
         hzhM1JvKHM0971moHtZcbshbeY4NrEFOQLsL2iIAylTU7fKsSv1XU65P/0wjTf1GUvTp
         MskaQ/RgkrOBjzdQANRQ3H05sH+Kr/Xy3kbeZQNlqI0+lA1mQN6F75jNpTzsiQDt2gjZ
         MRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/eVCAg3MBYd00s2yyl7DgTtrrb0tSrJ4c68oN1h9w7E=;
        b=MfM62COJRaF4l7A47boRqVF/DcuSekz6sMCv+YzmW0ERKOV0gz7k8GdNeq3iQY2tLO
         2tvh5QhqcxkqG/OFxftL/1RDBRT4p5+T7JiaDdm24m8fSwTLq6eCYCekeTFnjqJbqLpd
         nP9XGVdOa1zQz/mPaqywJN09v3E/ahv9NLT5GIlSZykHbzMDr4ad7TYaFNH1sFKaMCIe
         3VMEaEovd9ebqx6LSJtkrcr449Nz6itzIxiU69+avoVb+gnk76CTHuFeLfZHVxwxoKyr
         mqhIzpC/MwJ6nPnt8XHRLGjTww98nmTCxPp++ku8/Z+3zMiJLtHTM5b79fbheF6Hqh/p
         hJaA==
X-Gm-Message-State: ACrzQf1ej57HvbGCG0d5OZeD5vOcPKWQ81tGnHqytHX1eHpM+vb8otjV
        Q6OcU3pbNBSmzakKyL/I2yTdNfjOg48=
X-Google-Smtp-Source: AMsMyM5JiYdxj+YMynL4r8t87wNUbi9fWl1FfbAZ25oL1/gb1nPrxwU6zMHJW+gm9NEbgav7YUseiA==
X-Received: by 2002:a05:6512:150a:b0:4ab:11d7:4bc1 with SMTP id bq10-20020a056512150a00b004ab11d74bc1mr2216206lfb.447.1666620865418;
        Mon, 24 Oct 2022 07:14:25 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::2? (dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::2])
        by smtp.gmail.com with ESMTPSA id g25-20020a19ee19000000b004ac393ecc34sm343442lfb.302.2022.10.24.07.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 07:14:24 -0700 (PDT)
Message-ID: <4e93d298-922a-2647-299b-5592a571ea53@gmail.com>
Date:   Mon, 24 Oct 2022 17:14:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v5 2/3] iio: accel: Support Kionix/ROHM KX022A
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
References: <cover.1666614295.git.mazziesaccount@gmail.com>
 <758b00d6aea0a6431a5a3a78d557d449c113b21e.1666614295.git.mazziesaccount@gmail.com>
 <Y1aLIPkefcCZberw@smile.fi.intel.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Y1aLIPkefcCZberw@smile.fi.intel.com>
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

On 10/24/22 15:54, Andy Shevchenko wrote:
> On Mon, Oct 24, 2022 at 03:40:29PM +0300, Matti Vaittinen wrote:
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
> I think I gave you my tag, no?
> 

Sorry Andy. Yes you did. I forgot to add it - completely my bad.
If I need to respin I'll add it - if I don't need to respin, Jonathan, 
can you please add RBT from Andy if you merge this version?

Sorry for the hassle!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

