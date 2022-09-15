Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DB15BA28F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiIOWEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIOWEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:04:32 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524522635;
        Thu, 15 Sep 2022 15:04:31 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u18so32561347lfo.8;
        Thu, 15 Sep 2022 15:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date;
        bh=xlT85NiSss8JUeEPEAh4JqoYnygSarUD1xdRUwkFSgE=;
        b=XJMCDQ1QiOt/r4Wg4MMl3gKCKc2j5ZXPWsE4Mj4u3mh190cP5dycmSVpuYxRsNerdh
         Mmc5ZmLtOBeaDgu0zAyrM3mA7//X3+2fzRCbWALFUqIH7c9gzIt5M5Q6POkEfVTh8ZoM
         UjC0Ouzei/3w5r3B6Calb52klBtKX4hp8B1pW4922kyEC/tG7cHvOmsF5vqn89OOfU9/
         NKZxUjZGK5ddRyfgq2Nd0WzNyfPQiO92YlWooV2MYchCpx5qdCii0oqVjOxtQ2jUHunr
         Loyo3hAaLuj3yUaYs9tSfQky1dMAWJ2uXgZ32cMobs4CXRhqWgRMFJsjz5dPgMJOvWYM
         aXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date;
        bh=xlT85NiSss8JUeEPEAh4JqoYnygSarUD1xdRUwkFSgE=;
        b=BUitepbWEBDuP2+43EJIGIDDv44wCVXJQMKVG8/ydc1Ua4AZAb13JKcipjxtz7UdYx
         2wz6vWrfuaByoWzzuTUgXHGA7i1ZVUkJpUoiE4WNEi+WobHOrFQc/60knsb3LAwZEjzK
         DzZ/ewW648MaBvLE/YFqmE3gP9pPkccvN8sMVZN/ltBanlFniakiNEW1O/nBMqY38zoY
         HQiMiNGHaJwzB58jVdTNir+ZPiSFySsxpIWhCYr8hQYC1hfGfBTRLS7wo9iFY6eCwNdI
         OvCNjas3nm2JpqHXeSXKe22ncqbdrahchJAwzJBTj5TXNEVWtn9t4flOR1ktgs8/q5Fl
         WRWQ==
X-Gm-Message-State: ACrzQf3QSTXubeM/D4QsS6R0qLNO/c2d3D6CcjRqTxIOk5FGUD1MUXZ0
        cbSP4xzSI1tngEdIOGCQDLlu+R9Tf7xIIQ==
X-Google-Smtp-Source: AMsMyM6CQeNfOyg73Royjnt9ZvVZW+kflVtHIjP4gyJnLtdgFK1fbX90pHvLTpc1x4ktD6h308xXqw==
X-Received: by 2002:ac2:464b:0:b0:49e:b29c:2b04 with SMTP id s11-20020ac2464b000000b0049eb29c2b04mr632486lfo.127.1663279469388;
        Thu, 15 Sep 2022 15:04:29 -0700 (PDT)
Received: from razdolb (95-31-185-216.broadband.corbina.ru. [95.31.185.216])
        by smtp.gmail.com with ESMTPSA id d21-20020a056512369500b00499f700430fsm2943325lfs.224.2022.09.15.15.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 15:04:28 -0700 (PDT)
References: <20220911200147.375198-1-mike.rudenko@gmail.com>
 <20220911200147.375198-3-mike.rudenko@gmail.com>
 <e3c0bafe-394c-e8cc-aba0-6eb480dc5b43@linaro.org>
User-agent: mu4e 1.9.0; emacs 28.1
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Shawn Tu <shawnx.tu@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Scally <djrscally@gmail.com>,
        Christian Hemp <c.hemp@phytec.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Vasut <marex@denx.de>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] media: i2c: add support for ov4689
Date:   Thu, 15 Sep 2022 23:40:00 +0300
In-reply-to: <e3c0bafe-394c-e8cc-aba0-6eb480dc5b43@linaro.org>
Message-ID: <87o7vgpa50.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Krzysztof,

On 2022-09-12 at 12:56 +02, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> On 11/09/2022 22:01, Mikhail Rudenko wrote:
>> +static const struct i2c_device_id ov4689_id[] = {
>> +	{ "ov4689", 0 },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(i2c, ov4689_id);
>> +
>> +static const struct of_device_id ov4689_of_match[] = {
>> +	{ .compatible = "ovti,ov4689" },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, ov4689_of_match);
>> +
>> +static struct i2c_driver ov4689_i2c_driver = {
>> +	.driver = {
>> +		.name = "ov4689",
>> +		.pm = &ov4689_pm_ops,
>> +		.of_match_table = of_match_ptr(ov4689_of_match),
>
> of_match_ptr is usually paired with maybe_unused, otherwise you will
> have compile test warnings.

I see. I think we could also use `#if IS_ENABLED(CONFIG_OF)` around
`ov4689_of_match` and the corresponding `MODULE_DEVICE_TABLE`. Is it
appropriate here?

>> +	},
>> +	.probe = ov4689_probe,
>> +	.remove	= ov4689_remove,
>> +	.id_table = ov4689_id,
>> +};
>> +
>> +module_i2c_driver(ov4689_i2c_driver);
>> +
>> +MODULE_DESCRIPTION("OmniVision ov4689 sensor driver");
>> +MODULE_LICENSE("GPL");
>
>
> Best regards,
> Krzysztof


--
Best regards,
Mikhail Rudenko
