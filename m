Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99366A3ADD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 06:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjB0Fvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 00:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB0Fvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 00:51:40 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A941A663;
        Sun, 26 Feb 2023 21:51:38 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bp25so7089661lfb.0;
        Sun, 26 Feb 2023 21:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pz1yizsyui2FqkdAA8FMl9zuctHHJgs12xaY9f2guwI=;
        b=CCpkojk5zNYu/f616oRSZP+In6HPCcNRFWO3jgWuieZE7gO+2/byzhSarlKjnr+u/y
         LDmJd27wp8rFljXbLNk3W85sk6C0qElg/umNI6+nYitY8MWD9SmR++bEorK0nAz067kM
         FufbqzELGoznT3Ivhsdzpg/Fy+REMy53OUBstITy46jcTFlQ3FaRmJ3nJehFpM0JyZ9K
         E3HDe/Ec2sYewjGCW1CcDB/OcX4avIVwyI+hR4PfKjSkTfkwpiG6zfm/CDEJMWIYw5tC
         TW3E+dERGVHipWAeU0QKQ6Z9vtP2eHtIFtFqO25Z+XGlj09OwDVjqy1FwY1jmD+ICfHS
         Hv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pz1yizsyui2FqkdAA8FMl9zuctHHJgs12xaY9f2guwI=;
        b=VWrgZdX8jJefBI+09xe6iBMC3CvO7Xgm7P0el6F5JRHMF+wq8S9NHo237yzqfGOgge
         IX6Kj6wPNs6dnr8IchkbNDR8VywbaRZHwBIXTXIZBLAj2d2lYA/dUbvK/pEW2JjqfHmE
         DHqkAYs9d9s3DacU5XnhyENchR0TidZM9jiV1lf3maE5WM5oLEfh3uYEbC18GgKGnpLG
         QJZMH0GCav5UF472ei8tHShjmBl594GipItbSt6k5B99WZbWrx4x54ceuIcbMl9aktjf
         /uOiHJ4CR1x4EU9iOrMCcNmfgU3QXfdPcuegy3/tjRUnYXhNBLna46A2uJ/IwQmnnSR4
         tbAg==
X-Gm-Message-State: AO0yUKUdToZ8gswI3fOhTxLicEwIwTGPVODe97vGjHh/D9RCuX4sNVbC
        Wtzhfi7ziab2YPWbAfNQG7o=
X-Google-Smtp-Source: AK7set8eVtDP59cMapvu5MoQb5HB8n3l+kpwMnV1leKmsKzj4Hc49bk96fv6pdCE55ymq/tPP3Kegw==
X-Received: by 2002:ac2:44b4:0:b0:4d1:616d:33a4 with SMTP id c20-20020ac244b4000000b004d1616d33a4mr7266170lfm.66.1677477096332;
        Sun, 26 Feb 2023 21:51:36 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id l29-20020ac24a9d000000b004d862e9b453sm788052lfp.196.2023.02.26.21.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 21:51:35 -0800 (PST)
Message-ID: <c2ad4682-16dc-6aa8-4931-d185f0d5332b@gmail.com>
Date:   Mon, 27 Feb 2023 07:51:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 6/6] MAINTAINERS: Add ROHM BU27034
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Liam Beguin <liambeguin@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1677080089.git.mazziesaccount@gmail.com>
 <8dbdf68749389605cc4dff396ddd66d27fdb2a0d.1677080089.git.mazziesaccount@gmail.com>
 <20230226134200.423649e1@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230226134200.423649e1@jic23-huawei>
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

On 2/26/23 15:42, Jonathan Cameron wrote:
> On Wed, 22 Feb 2023 18:16:18 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Add myself as a maintainer for ROHM BU27034 ALS driver.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>>   MAINTAINERS | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 43f5a024daa2..8d31ef852372 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -18090,6 +18090,11 @@ S:	Maintained
>>   F:	Documentation/devicetree/bindings/iio/light/bh1750.yaml
>>   F:	drivers/iio/light/bh1750.c
>>   
>> +ROHM BU27034 AMBIENT LIGHT SENSOR DRIVER
>> +M:	Matti Vaittinen <mazziesaccount@gmail.com>
> Whilst the wild cards stuff for IIO should also catch this, it's (fairly)
> conventional to still add the list entry to make it easy for
> people reading the file directly.

Good catch, thanks! Will add:
L:      linux-iio@vger.kernel.org

for v2.

-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

