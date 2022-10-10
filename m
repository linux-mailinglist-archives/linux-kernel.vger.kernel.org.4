Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401735F9C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 11:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiJJJhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 05:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiJJJhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 05:37:04 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA637640;
        Mon, 10 Oct 2022 02:36:58 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id f37so15738897lfv.8;
        Mon, 10 Oct 2022 02:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nm0F1sSMUJ9fdz65rzhXe7v3qpKQDjjCCfQ7Okp8xuc=;
        b=gl6yVB2QcxSerh8SvMKGtqZD0FvjMXF6hxL1dDXx86UpxWmjaV1G23aEdVhY+/7s3s
         NICBg/nzN/OGs5hQ1/PvcihcJWukzN8SbIZPvHyfMxF9UntXvoEQSl49nGuatpFOR+1F
         NsiTiCtDrsfkOpDhcp3YOShxxyHzybwanQynYTAo/uA7xMyflZz/bh8moyTsXx7VJUJA
         CuAv7ZFlWM/7APUJZpL6UNyKGoygI3Ew2Z3+AqPA0/E/h3YZ/htkUnYQm3pGNUpRGPw0
         wB9z2k3tigxwgbKbZYdyTeNbCmninHXwvobh/d2tptUE0V7n0Mimx7tiEHH7t/yJNc+W
         llhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nm0F1sSMUJ9fdz65rzhXe7v3qpKQDjjCCfQ7Okp8xuc=;
        b=PZEXGFztqsqxtJaLKDE0snCSQXKu76Z+fYhOaZ9nc+3oUn/g0edL1eI5K6VJBmgSY1
         cNXISm1oWwRsv9ozjKxJvTQEOiR3+f375XVVJ78SPCLsDAgblJVAPuze7296Hl+EFA7Y
         +mxSRlzOpYfeSbcYQ7zQaqYCbXzavLETTEeC03jqLOSXsITu6T9vh+l6rBub9mA+4S+1
         nOqP+i8cOruupQu4zGRRr6OCqh/jlypT9YG83Lndeb+n9jaalcDf8R3R5+tjiMbcY/OI
         LwBuzXYCyvtyV/B5MrC7oARLHpDQ9IAde674k8yd+DSiRqnfPXNbiiEdQR32Avf8P0af
         +Xrg==
X-Gm-Message-State: ACrzQf1yAIl+ZlZKld2QxkMF30FzQou4HZpjngObvEnePR0JrrHQvZmX
        02AEhheXHMu5k2VKeJ60vIg=
X-Google-Smtp-Source: AMsMyM57/N4FnCS9z879rcxLoQe8DQEJlCizg9oxrgqjflT80JGrzZk2O1DY7ptuZC0hrJ9q9OcRQg==
X-Received: by 2002:a05:6512:3483:b0:4a2:bc90:af77 with SMTP id v3-20020a056512348300b004a2bc90af77mr4965393lfr.453.1665394616799;
        Mon, 10 Oct 2022 02:36:56 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id c22-20020a2e9d96000000b0026d920a8114sm1548747ljj.100.2022.10.10.02.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 02:36:56 -0700 (PDT)
Message-ID: <41abe9f6-d633-664a-db93-0580b23e44e1@gmail.com>
Date:   Mon, 10 Oct 2022 12:36:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFT PATCH v3 10/10] iio: Don't silently expect attribute types
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Claudiu.Beznea@microchip.com, matti.vaittinen@fi.rohmeurope.com,
        lars@metafoo.de, Michael.Hennerich@analog.com,
        cosmin.tanislav@analog.com, Eugen.Hristev@microchip.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        bleung@chromium.org, groeck@chromium.org,
        alexandru.ardelean@analog.com, nathan@kernel.org,
        miquel.raynal@bootlin.com, linmq006@gmail.com,
        u.kleine-koenig@pengutronix.de, paul@crapouillou.net,
        mihail.chindris@analog.com, gwendal@chromium.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev
References: <cover.1664782676.git.mazziesaccount@gmail.com>
 <63f54787a684eb1232f1c5d275a09c786987fe4a.1664782676.git.mazziesaccount@gmail.com>
 <c163203c-d87b-7e71-f582-964a99e37efb@microchip.com>
 <8ef99012-4959-a674-13c1-186b9c1c2cd4@gmail.com>
 <20221009183854.690e2780@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20221009183854.690e2780@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/22 20:38, Jonathan Cameron wrote:
> On Thu, 6 Oct 2022 15:53:52 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Hi Claudiu,
>>
>> On 10/6/22 11:35, Claudiu.Beznea@microchip.com wrote:
>>> On 03.10.2022 11:13, Matti Vaittinen wrote:
>>>> The iio_triggered_buffer_setup_ext() and the
>>>> devm_iio_kfifo_buffer_setup_ext() were changed by
>>>> commit 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_attr")
>>>> to silently expect that all attributes given in buffer_attrs array are
>>>> device-attributes. This expectation was not forced by the API - and some
>>>> drivers did register attributes created by IIO_CONST_ATTR().
>>>>
>>>> When using IIO_CONST_ATTRs the added attribute "wrapping" does not copy
>>>> the pointer to stored string constant and when the sysfs file is read the
>>>> kernel will access to invalid location.
>>>>
>>>> Change the function signatures to expect an array of iio_dev_attrs to
>>>> avoid similar errors in the future.
>>>>
>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>
>>> Tested-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>>>
>>> on SAMA5D2
>>>    
>>
>> Thanks a ton for the testing! I do _really_ appreciate it :) I am now
>> slightly more confident regarding the fix here - and a lot more
>> confident that we do have an actual bug (as you explained in the reply
>> to the first RFT) :)
> 
> You analysis was sound, so I've long been convinced ;)
> 
> Anyhow, one more coming through...
> AD4130 v9 patch had same issue and so will also need updating with this
> patch if it lands before yours.
> 
> Other than that static macro being ugly (which I can't improve on!)
> all looks good to me, but I'll let it sit a while longer. If nothing
> else I want to rebase the fixes-togreg tree on rc1 before putting the first
> part of this series on top of it then letting them soak in next for
> a few days,

Thanks Jonathan.

Can you please ping me if you want me to rebase/rework the series? (I 
may combine this with the kx022a-series then, but naturally not all 
patches in the series need to be applied at once. Eg, fixes can be taken 
in faster, kx022a part can be iterated, iterated, iterated... ;] ).

Yours
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

