Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01E5641EF1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 19:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiLDShP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 13:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiLDShM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 13:37:12 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4BAD137;
        Sun,  4 Dec 2022 10:37:11 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-142b72a728fso11097934fac.9;
        Sun, 04 Dec 2022 10:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nLHKRMLDqOO1KM87cuPtuUoe7rvxHP3VMMZRkQ7/sIc=;
        b=BaaSBPfdiKkfFDor5PXCyMtDHBQBmx8FMH8wjnFx6WPpAvzNAX4xieVnNqNm2YeIj8
         xHDP0OLpPcx+zcNCCGFUHj//ZtVrMiTY+14Z42yAMjAkrK91ipPtxh1x/ApzajBPvE2y
         7NTtzjWM7p5bpEoLiE9W3LYIT6D0Ilcw+e8VPQWOpAlPOkyR2ogCbraVuQR0eXMgmSa5
         KIO3BBP5W26cHuLHVubO9pGxnGf4jsAvehETpwnqo7ab6JcJ0MxyM6pN4x47M3MQ8lmx
         9HeWcE5hKVeEFOdmmzNENA7XptMmDzMOf9Rc4REmJpGZb7I2nkDWHb9MBU35IHPs/97Y
         H8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nLHKRMLDqOO1KM87cuPtuUoe7rvxHP3VMMZRkQ7/sIc=;
        b=cKpFHnuW64l622U2EjSbLfnLXy3UpyxjQ3BJRLlGr4fZOQKM+UXeYPJbdqCwy+O8el
         DmbSPEuKQY5zOURrN88a2H5HJAE3gIcdlKQnIhVYDah+bc5JuAVGFY3WvoaMEgVAgXz1
         Hd9Pi3E3C0SYUlMsKcoxhtYQlgR32bvj0595HoahYquN9k6A8GgUt05vySkWSMleiFB5
         KwlzNAI2jnNwnT+4d0Daad1oOzc8Hc3eSrADRbdhS3HSm6S1Mj4XHlbVXkqV1KAaP1uw
         FzA/fyQEiUa42+JSw6WLKoVz6qCk1qHhso3IcxVBw2zPuolZwCrsRdLlxZAmBsBtg8jq
         qwVQ==
X-Gm-Message-State: ANoB5pnFem21A3a/UqOCbENGFgmElREDH22dDb6QKSXXn/+zUJC2Buqb
        VycjP03WlhiRC0JlrQ5KTcM=
X-Google-Smtp-Source: AA0mqf6igFWzCvqDbbN43mS1E+lmTn7sGnFTxwrbYBXMnPfV6JjxAmAtNy/grUeY0o2zrCN5rf+V8Q==
X-Received: by 2002:a05:6871:a691:b0:143:c3bf:be6d with SMTP id wh17-20020a056871a69100b00143c3bfbe6dmr16738733oab.103.1670179031179;
        Sun, 04 Dec 2022 10:37:11 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m24-20020a056870a11800b001447d74a58esm2144294oae.8.2022.12.04.10.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Dec 2022 10:37:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1085cc7c-00af-83f3-7da6-7820143b162e@roeck-us.net>
Date:   Sun, 4 Dec 2022 10:37:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Eddie James <eajames@linux.vnet.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
References: <Y4zfBRahZJ0QM758@zn.tnic>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: CONFIG_SENSORS_OCC_P8_I2C
In-Reply-To: <Y4zfBRahZJ0QM758@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/22 09:55, Borislav Petkov wrote:
> Hi,
> 
> make oldconfig asks me here on a x86 machine about this below and it
> looks like this should depend on some P8 config item so that it doesn't
> show on other architectures.
> 
> Right?
> 

I don't immediately see why this should depend on a P8 configuration.
The driver runs on a BMC, after all. My understanding is that a BMC can be
of any architecture. Is there a guarantee that there are and never will be
any x86 BMCs, and/or that BMCs are limited to a certain subset of
architectures ?

Thanks,
Guenter

> Thx.
> 
> CONFIG_SENSORS_OCC_P8_I2C:
> 
> This option enables support for monitoring sensors provided by the
> On-Chip Controller (OCC) on a POWER8 processor. However, this driver
> can only run on a baseboard management controller (BMC) connected to
> the P8, not the POWER processor itself. Communications with the OCC are
> established through I2C bus.
> 
> This driver can also be built as a module. If so, the module will be
> called occ-p8-hwmon.
> 
> Symbol: SENSORS_OCC_P8_I2C [=n]
> Type  : tristate
> Defined at drivers/hwmon/occ/Kconfig:6
>    Prompt: POWER8 OCC through I2C
>    Depends on: HWMON [=y] && I2C [=y]
>    Location:
>      -> Device Drivers
>        -> Hardware Monitoring support (HWMON [=y])
>          -> POWER8 OCC through I2C (SENSORS_OCC_P8_I2C [=n])
> Selects: SENSORS_OCC [=n]
> 

