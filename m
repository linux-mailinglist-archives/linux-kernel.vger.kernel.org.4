Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1E46EDB27
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 07:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbjDYFYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 01:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjDYFYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 01:24:05 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C504C0F;
        Mon, 24 Apr 2023 22:24:03 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2a7ac89b82dso50485071fa.1;
        Mon, 24 Apr 2023 22:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682400242; x=1684992242;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQhkG9xAytA2mlNSKXfOWr2pzT8B0inX1jNWQEbw998=;
        b=Haf5AuIYrwmCP+N3uXDNv1ED7H4RSsfgQjcQr4Ih5UkTjbPJzTRvMfs/6KAX2cuvWo
         dv7tPyZMG7CYdoBlOKBOPupH6BYdvMGU8wPcmYCuwn+wDqy3g9Afe7UPU0iqVw7ZnJZ0
         V2R6qEd6RUzdp/ge/F4MqD1a5m3BU+QYEcvKZZVYXxjxbCr+OY8a3jAvhhjLButJPUcQ
         I2yOqa4ey2rjQyaeuCIuG8CxH04+YsF79WS7lISymbEQJfJSRybmwYf/YUNtfkv9qLx3
         vaWhlWo++0kc548alTjykBr2rRs9U5eg/KTrHMwXnDhDkdsbXdIqQd1r6C3D6INmIxNw
         JKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682400242; x=1684992242;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bQhkG9xAytA2mlNSKXfOWr2pzT8B0inX1jNWQEbw998=;
        b=hEFtYoflW6yZV4VsX1UbVNfyMWLd2oxA5r/jEjFD6/euxvgCQdgW0ln2iamFmor5n8
         VmOvYBRAICxtgGjuyroieh4R9VVVwnUbYz6vQO/OmxBW1c6ZrQPOjKlxkcxmkUaaSO9+
         nUObH+3ENwWaSJaJGMYBoIP4jNyUwZHQWps4ZXmQEuT1JaXRUfEnrOxIyx99O+VYQiCd
         8Fmroy3SUoGX5ibhE0nkaZzEyRbDFx+fbwuRNEecLqlfb23jmN4y2KaovCfP0jdO9vLE
         iNgINarq1ff1qcTeOWbwVwASi1psIpxxeDfSU8Q5PhVlIrALmGRNEry2V/xqgPmqMDmq
         kIEw==
X-Gm-Message-State: AAQBX9f2NLeIuStz5f4WRyTWfYYkd57YxYUFapoosC7MI/WpYE5oFu1Y
        9nHT5NsxQZaFkWEzwhGOBfJpPWcoDDc=
X-Google-Smtp-Source: AKy350ZPHGuu6CvqVbeJ6Ijd4q3fcf9njPSPXBeEpI91IahRjlZMHpj4NxQg4pBvPEr4J3r1sBGkkA==
X-Received: by 2002:a2e:3313:0:b0:2aa:3bd0:59fa with SMTP id d19-20020a2e3313000000b002aa3bd059famr3418455ljc.12.1682400242183;
        Mon, 24 Apr 2023 22:24:02 -0700 (PDT)
Received: from [192.168.1.111] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id l26-20020a2e3e1a000000b002a8c7bd0798sm1965518lja.86.2023.04.24.22.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 22:24:01 -0700 (PDT)
Message-ID: <47998ed8-5160-69dd-1767-e1746971a9b9@gmail.com>
Date:   Tue, 25 Apr 2023 08:24:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1682340947.git.mazziesaccount@gmail.com>
 <d51d5e2b3eff65fd86aeb47840db9cd413d96668.1682340947.git.mazziesaccount@gmail.com>
 <ZEaeoxdWTknLz7lQ@smile.fi.intel.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 4/5] iio: light: ROHM BU27008 color sensor
In-Reply-To: <ZEaeoxdWTknLz7lQ@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/23 18:22, Andy Shevchenko wrote:
> On Mon, Apr 24, 2023 at 04:10:09PM +0300, Matti Vaittinen wrote:
>> The ROHM BU27008 is a sensor with 5 photodiodes (red, green, blue, clear
>> and IR) with four configurable channels. Red and green being always
>> available and two out of the rest three (blue, clear, IR) can be
>> selected to be simultaneously measured. Typical application is adjusting
>> LCD backlight of TVs, mobile phones and tablet PCs.
>>
>> Add initial support for the ROHM BU27008 color sensor.
>>   - raw_read() of RGB and clear channels
>>   - triggered buffer w/ DRDY interrtupt
> 
> ...
> 
> This...
> 
>> +#include <linux/bits.h>
> 
> ...is guaranteed to be included by this.
> 
>> +#include <linux/bitops.h>

Out of the curiosity - do we have a rule and rationale for explicitly 
including headers with 'stuff' we use Vs. trusting some header being 
included by another one? I've not thought much of this so I don't know 
if there are any pros/cons?

> ...
> 
>> +static const struct of_device_id bu27008_of_match[] = {
>> +	{ .compatible = "rohm,bu27008", },
> 
> Inner comma is not necessary to have.

Thanks.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

