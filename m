Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0591968637D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjBAKOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjBAKOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:14:09 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C1E976C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 02:14:08 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso981533wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 02:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KAhoNlTJho5ZnwZSN6lbqDoq8aHHdJxgOkFCOiCRGuk=;
        b=C9Djn4E/y+WbPQRSb7rGXC3bXUj0z5dMPW8UG+wZaFqKgTXv5ulrzV4PWTXkCNbSMG
         EsIuWK9c5t1oFnvPpxr1SJD4mrDc5mEI8+QNhkYILbyhKuivB9EtXKSc6+V55gvj3WBP
         mUy3/XGyYUbQbphVQ7NwfKETJKbkTmRJTAqoPke3kAqgnY9/vaJUKy6I7SRu6KfRzs5u
         uT7FCmDjhdxDTfD5JrQQO8pB4BYnpaTg8HhhPPF5a0sNZpGvp8GZvrPJTAix/f6cRLH9
         44Ej7oe+DnZb3DxMYYQNIhxy3fHGV9Le74DvnpL0TyTiit90UOCYTpE38QTk5S1QwpbZ
         CQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KAhoNlTJho5ZnwZSN6lbqDoq8aHHdJxgOkFCOiCRGuk=;
        b=wcO21I+gBZDtXguoTehZEKX/QbQ7yXXVfEcR3SgVRXsNmu98zg1RNM+YP/M1kd3DXM
         tM1ngJb0bVQTnEz3CeeLjJLtR/pLept2JteA3PSKQuGI4VzFSJNC3OP+Hk1CZ8GIVOCM
         nLtKIaXBz96L0YvYWb14DeOq74drstUw4kXQdccxy+Ptt5dY+FOigbX8eVJVBtSQ2NrG
         YQ4nh1uC6OfvxmQD32UkBCkhemkwSeMnwaGa0WA1/LmE/V6fs3taxzD1o4nkAxsL1n92
         RA29Fa6+fPrBaljxkOpury31rOVCCVZfYaCxX9fBF3xKGeE3jsU8bMpRY4TENZelMKe6
         HVIw==
X-Gm-Message-State: AO0yUKWWa/Q2zATNK7Iub1xGu4RPAiuQMAjR+vpauK207bXPb+aiAdF5
        zCLh1E2XYK95h3kXhfwWeEuNEw==
X-Google-Smtp-Source: AK7set/QB2ylCwztdMqI85o97PSgSoy4ia3dLIUk/CTPbDVz11aXGXi1yf3ARYrlnV6AKTfWyzezXQ==
X-Received: by 2002:a05:600c:3783:b0:3de:e8c5:d826 with SMTP id o3-20020a05600c378300b003dee8c5d826mr892459wmr.28.1675246446580;
        Wed, 01 Feb 2023 02:14:06 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c469000b003a84375d0d1sm1309737wmo.44.2023.02.01.02.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 02:14:06 -0800 (PST)
Message-ID: <307017b7-2ecf-2ce5-4031-27bb6f09feb1@linaro.org>
Date:   Wed, 1 Feb 2023 11:14:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/3] ARM: dts: aspeed: Add device tree for Ufispace
 NCPLite BMC
Content-Language: en-US
To:     Jordan Chang <jordan.chang@ufispace.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        robh+dt@kernel.org, jay.tc.lin@ufispace.com,
        eason.ys.huang@ufispace.com
References: <20230119102102.73414-1-jordan.chang@ufispace.com>
 <20230119102102.73414-4-jordan.chang@ufispace.com>
 <3e242c03-f8fd-2136-0263-2306acb9f610@linaro.org>
 <CAJ3czeT1O3iw2S_SK3z0C6dMiJ+-fUrWXPox4LJpJkMy_rVsJA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJ3czeT1O3iw2S_SK3z0C6dMiJ+-fUrWXPox4LJpJkMy_rVsJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2023 11:06, Jordan Chang wrote:
>>> +     gpio-keys {
>>> +             compatible = "gpio-keys";
>>> +
>>> +             fan-status-int-l {
>>
>> Does not look like you tested the DTS against bindings. Please run `make
>> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
>> for instructions).
>>
>> These will bring warnings. Missing generic name,
>>
> I have run the `make dtbs_check` command, and did not notice the warning
> message 'Missing generic name'. It shows lots of compatible failed messages.
> - /ahb/ftgmac@1e670000: failed to match any schema with compatible:

You can run it with DT_SCHEMA_FILES=gpio-keys

> 
>>> +                     label = "fan-status-int-l";
>>> +                     gpios = <&gpio0 ASPEED_GPIO(M, 2) GPIO_ACTIVE_LOW>;
>>> +                     linux,code = <ASPEED_GPIO(M, 2)>;
>>> +             };
>>> +

(...)

>>> +
>>> +&i2c4 {
>>> +     status = "okay";
>>> +
>>> +     psu@58 {
>>> +             compatible = "pmbus";
>>
>> Where is this compatible documented?
> Can not find the corresponding document.
>>
>> Did you run checkpatch? Did it pass without warnings?
> Yes, I did run the ./scripts/checkpatch.pl and there were two warnings left.
> - WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> - WARNING: line length of 104 exceeds 100 columns
> I just ignore those warnings that Joel has informed me in the previous
> mail loop.
> 

Hm, is it then correct compatible?


Best regards,
Krzysztof

