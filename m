Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533FA5BA9A6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 11:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiIPJoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 05:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiIPJno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 05:43:44 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FBBAA4DB
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 02:43:13 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b5so35084897wrr.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 02:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=NzvsBv6Vy0LayQRu2srUUWCYs5DHNCpJ/APAQxxwdIQ=;
        b=Vsk0YFgWXXN9oDQ0nv4Fbq8khNFKpoFKDiz32x8/+RlDM898xvgKkiI/s2uTFd72tL
         Rc1fYGbNQ8s62o3LfYTb8ZAg4Eq7SONzTs3WcQxwWAjgSDWxq5xGzk++3ap/aN93zkbC
         bR7eE44twUV83Xatg35B5jfLjhODPmBlAwUkh8q1cOYUBJTDkGr+Y1n+S3QeSjjKXpXV
         EYePLWJtPTUmDw0MSnMMR2by90MLyzTUkqSTQWm3PrX4Jy7lH2ufEbiHcrsMYKcLyhE7
         fEbrtUUBmvMaIkpr6s8QkRXffpXGkCv/IpETvo6lE/k3r2nKrQz3b6VDFCys292qSxFA
         uJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NzvsBv6Vy0LayQRu2srUUWCYs5DHNCpJ/APAQxxwdIQ=;
        b=lEU4d14qpTrHVA2gqjnA58Rs5W6AEsC355BtGWgucAtXzM60IpMuGDREWH/jbXXa18
         GJRHdTF+TQQ/EpVEf0uCUtsLQoQxf88ePeRi4fMlAyl2647/Ha0QVX7QB+QFm6n6HESx
         BX1RB/ukWS3TCkS0lu+kmyaaK6cgut4fmaCit9pS0vUjLi+bElVi7X9YJ9vDuTr7XtxC
         ZaT/9n20CsI0/rkYlB+rrub034ikwAtfBZd0G3bu9zKQ4VqnmIKGOgyJYm7Gyd4Jr3A8
         s+RGJIRPhkIm4XmzVe9tmn+HdgnEo8rZGlKAAcnXEWrbLtQAXyO9svWQcHK1MoCBC6AW
         Asxg==
X-Gm-Message-State: ACrzQf17zQVlYmJy9lprfhrPEk2HDZX/giIHhW6V1Int3bHxHak6Kv8Y
        NFLfSRQ1VP0Wl7ki0b+htAp3Hw==
X-Google-Smtp-Source: AMsMyM5wpu8dPAX8EIVJvLfSD8+RRDUjgzhvuoZPt5EHXVS69Hb97dz2+i+1d97ys60v/tFaUP07fg==
X-Received: by 2002:a05:6000:2c9:b0:22a:c481:20b with SMTP id o9-20020a05600002c900b0022ac481020bmr2349981wry.7.1663321392356;
        Fri, 16 Sep 2022 02:43:12 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.73])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c1c1000b003b492338f45sm1779049wms.39.2022.09.16.02.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 02:43:11 -0700 (PDT)
Message-ID: <c92f67a0-52f5-b5d1-8f65-d28b761d2620@linaro.org>
Date:   Fri, 16 Sep 2022 10:43:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 2/2] media: i2c: add support for ov4689
Content-Language: en-US
To:     Mikhail Rudenko <mike.rudenko@gmail.com>
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
References: <20220911200147.375198-1-mike.rudenko@gmail.com>
 <20220911200147.375198-3-mike.rudenko@gmail.com>
 <e3c0bafe-394c-e8cc-aba0-6eb480dc5b43@linaro.org> <87o7vgpa50.fsf@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <87o7vgpa50.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2022 21:40, Mikhail Rudenko wrote:
> 
> Hi Krzysztof,
> 
> On 2022-09-12 at 12:56 +02, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>> On 11/09/2022 22:01, Mikhail Rudenko wrote:
>>> +static const struct i2c_device_id ov4689_id[] = {
>>> +	{ "ov4689", 0 },
>>> +	{},
>>> +};
>>> +MODULE_DEVICE_TABLE(i2c, ov4689_id);
>>> +
>>> +static const struct of_device_id ov4689_of_match[] = {
>>> +	{ .compatible = "ovti,ov4689" },
>>> +	{},
>>> +};
>>> +MODULE_DEVICE_TABLE(of, ov4689_of_match);
>>> +
>>> +static struct i2c_driver ov4689_i2c_driver = {
>>> +	.driver = {
>>> +		.name = "ov4689",
>>> +		.pm = &ov4689_pm_ops,
>>> +		.of_match_table = of_match_ptr(ov4689_of_match),
>>
>> of_match_ptr is usually paired with maybe_unused, otherwise you will
>> have compile test warnings.
> 
> I see. I think we could also use `#if IS_ENABLED(CONFIG_OF)` around
> `ov4689_of_match` and the corresponding `MODULE_DEVICE_TABLE`. Is it
> appropriate here?

Would work, but ifdefs are not nice. Just use maybe_unused. Warnings
should disappear.

Best regards,
Krzysztof
