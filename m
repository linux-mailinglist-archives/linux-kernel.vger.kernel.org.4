Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB596797D7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 13:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbjAXMYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 07:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbjAXMYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:24:16 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A3E39BA1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 04:23:46 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso10802892wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 04:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QkTslYMiKbk7wM257ny2CAnZjADL3oZfRoJOLk54k/Y=;
        b=fzwSE+w049j/XzsIp7VUc9Q4DMyKfqq3Fp9d7DWaBMheW9x2sAs/MEIqyXhSwh2Ov+
         lHJkJNtaj2yX0tcWoYrO94slISdmHHwqb5BJPTm0+aVrRe17mD3+ouSS5nqgx17rmuWW
         P3WgVVhT2eNj5WfW1CsxGFGRQgREq/ge11+AXiKBtdgqqWe+RwvPWzwiN6gIMVxXeBZq
         Jsaf6aqpsdKgVx1p4407eetShAwkNMocLtr4P0EvGNrYCE72VI0cUNEjOSfQbSbc6k0h
         FlcoIj+kxvNDX0HFC6VC613tx/fb/Rw27XhuLn2fhJ+aeKbL76OMuE5mOyBKRKPJZPfa
         jIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QkTslYMiKbk7wM257ny2CAnZjADL3oZfRoJOLk54k/Y=;
        b=5klGwTYEWFwSaajk3BQ4nDYcTrtHJPYrdxpP6LUp8MT1tqI8k6YzXhOCs5Hx6EzKZz
         7s2QAPG/SjFQ0mLVjmwswh+4hVkruzqriG6Kln7xbPp6DhpeC45pRMvUdTJ82iTy80gP
         6JLbCQ1vAvtwD/YNTJkyMzOnlsWkNvx8JuEw/MDQ+ZY5UKDc3UFNEC3ujer4GVsJ3eCd
         HHKqRs7FaOaJrm98kWg96e6YPuOHMliTsDUW8xpM/+yrw3wGAsKo73Yd+88qd2UolBt5
         Xvv0zPBpWap0Hia7tIQDt8qxaHCduNDYcn028ppREeCc3bhIBCi3fVVl87VLwtEZ+H29
         8njQ==
X-Gm-Message-State: AFqh2krVoHugxF7rAT5Hd10VHBytHLCti3M547jTxJ+Z3YMyRG0LeUfY
        cd72r19VKW3sufzN85BtvkXmIw==
X-Google-Smtp-Source: AMrXdXuHLbuyQsCikp2sixdbE7T4vLrvn3duH3fx+F/wRHrodHvlBxYaP9Buh5DxlemteuWNTR2HPQ==
X-Received: by 2002:a05:600c:601c:b0:3d3:4f56:62e1 with SMTP id az28-20020a05600c601c00b003d34f5662e1mr27626827wmb.27.1674563006565;
        Tue, 24 Jan 2023 04:23:26 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y11-20020a1c4b0b000000b003daffc2ecdesm13175479wma.13.2023.01.24.04.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 04:23:26 -0800 (PST)
Message-ID: <cfc6b527-3293-b2aa-fd37-f2112b0bfb92@linaro.org>
Date:   Tue, 24 Jan 2023 13:23:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] hwmon: (pmbus/tda38640) Add driver for Infineon TDA38640
 Voltage Regulator
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230124110111.3965317-1-Naresh.Solanki@9elements.com>
 <b4b11836-5a4b-a2b7-18e2-89ca26f19817@linaro.org>
 <05947e9f-0667-4565-b481-ca5635da4174@9elements.com>
 <d8fb3c45-435d-f080-6ba4-e9e4595f3638@linaro.org>
 <3993c666-7038-76f8-9216-3db23ca0bffb@9elements.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3993c666-7038-76f8-9216-3db23ca0bffb@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2023 13:19, Naresh Solanki wrote:
>>>>
>>>>> +static const struct of_device_id tda38640_of_match[] = {
>>>>> +	{ .compatible = "infineon,tda38640"},
>>>>> +	{ },
>>>>> +};
>>>>> +MODULE_DEVICE_TABLE(of, tda38640_of_match);
>>>>
>>>> Where is it used? You miss the user.
>>> I'm not sure if I get your question right.
>>> This chip is used in sbp1 board to power CPU rails.
>>
>> No, where is the data structure used (except module autoloading)?
> My use case is loading the driver base on DT. Not sure of other uses.

Where is it used in the code?

Best regards,
Krzysztof

