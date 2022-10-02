Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BDD5F2390
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 16:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiJBOZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 10:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJBOZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 10:25:56 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D723BC43;
        Sun,  2 Oct 2022 07:25:54 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c2so6950727lfb.10;
        Sun, 02 Oct 2022 07:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=gxTqR0Ey2zRGFAUJiTDVmDjU/UZZW0WZ5gZEg22u3Wk=;
        b=jGnsuOP2BMD7JALE54C+npRn7uDNrfknnPc4XoFlhqP3O5ytopAP9/R8NwM3PMwoBv
         zT2lZBhtCf1RkuHWXEgu1A1qvGdG1a+qfDnAYS3nQHPYqv/uB/MTY0pN+PtY/gKlGimJ
         K1wkNPbnwxpkwq0eysMLflHyfPL0fOXNPmhdu9HjFbQosJTdyViC1f8xEz/SAEAxlZOJ
         zhALucQNra65JJZNjp2KrNFhaosfTTLaZ65L4W+/HTSMhTHeIFrtV9a3MfNhk9/czVH6
         GRutJpvguYne9QMTdBoHiXHDEf7u9rkHUnILZW9/dbEXz8jW+8NmG+HJiDEt/5fM1fAe
         iX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gxTqR0Ey2zRGFAUJiTDVmDjU/UZZW0WZ5gZEg22u3Wk=;
        b=KLC6RE5HlP7kP0QpzKvOs0iffa5wlSCREyA57zoaF/6vxkRvWhbUmolSpN8Hua4XVy
         zY2jC30BsOiuMxpJvwCGbPmiBrrLTvqXXA3WBFt4s6EWepUfHjLvRKcsCJtXAvM2OJJ2
         xbhXBvtsIvUt7GhEoO2zsyZkhU7kp6kyBWv4vinByU5dsisxYeSr1YfXmHixBuFlI6+g
         W4d+b4napEFnMlnPvIGBzDSG0hqa7K6KuNWo7ZCXqnab44COoGHWODot8846a7j2s3Ek
         eTHp7PnRFPMqJWWaLCsD6ouOhiYcTsHMYYbAqYdheGIDobQJ8Uy/job1hor/mnJs3E/5
         WrPw==
X-Gm-Message-State: ACrzQf2F3HfPSY/XLpUv1YMZ6uUKG+1qOCK2CyHKRej9ydVkLvP+OVUP
        O/xDD3LWFdwOy/lYhsBwk58=
X-Google-Smtp-Source: AMsMyM7m7VInrlw3wi4/yW200f1frbq/JSXeri3ENLMmDbOyWr8ifLVIGnHwkYh+TbO6im/nsFplgw==
X-Received: by 2002:ac2:5cd1:0:b0:4a2:291a:9460 with SMTP id f17-20020ac25cd1000000b004a2291a9460mr1803288lfq.203.1664720752562;
        Sun, 02 Oct 2022 07:25:52 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id a18-20020a05651c031200b0026c5579c64csm648964ljp.89.2022.10.02.07.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 07:25:51 -0700 (PDT)
Message-ID: <3ebe3c45-e951-678b-ea55-89c5bf62e8bc@gmail.com>
Date:   Sun, 2 Oct 2022 17:25:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFT PATCH v2 2/2] iio: Fix unsafe buffer attributes
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Mihail Chindris <mihail.chindris@analog.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev
References: <cover.1664610071.git.mazziesaccount@gmail.com>
 <614bb5336c2922578da60a43570f42018623557a.1664610071.git.mazziesaccount@gmail.com>
 <20221002145644.16db3aec@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20221002145644.16db3aec@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/22 16:57, Jonathan Cameron wrote:
> On Sat, 1 Oct 2022 10:44:23 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The iio_triggered_buffer_setup_ext() was changed by
>> commit 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_attr")
>> to silently expect that all attributes given in buffer_attrs array are
>> device-attributes. This expectation was not forced by the API - and some
>> drivers did register attributes created by IIO_CONST_ATTR().
>>
>> The added attribute "wrapping" does not copy the pointer to stored
>> string constant and when the sysfs file is read the kernel will access
>> to invalid location.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Fixes: 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_attr")
> 
> Hi Matti,
> 
> This feels like we are doing too much in one go.
> I would start with fixes for each individual driver, then once those are in we
> come around again and do the refactor.
> 
> So for the first patch set (one per driver) just siwtch to yor new
> dev_attr but still use a struct attribute * array.
> Second series then does the refactor so we don't introduce any new instances
> in future. More churn but the code to backport is more tightly confined.

Agreed. Besides, backporting the fix to stable will be much easier that 
way. I'll split this for v3. Thanks for the input!


Yours,
	--Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

