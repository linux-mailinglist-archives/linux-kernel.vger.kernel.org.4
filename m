Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DFE640B87
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbiLBRA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbiLBQ7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:59:52 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17761E0749
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:59:44 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id d3so6071825ljl.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 08:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p5AjNgRxYvWSo311L8Fi4s9BaU+vEEAJHGgsgNjup4c=;
        b=LiuLpp6NWIYpx8WnrXcmJnrtRC6AZtTj+sx0kDPAakQeZGn7DrsuRuEWUYYBl5Oieg
         lf2c2JQctnaj6IVKiYAtNdlr14SHxlF1Yw2OTyY2+MHow3ElvvYcmMebVMc3zMmvF4GI
         F5WiumLtHBUB4RnnQL2kYgPKvweSzxn4dTCgPYWceNSjEEt/ntrMLxdoBB89JeXUp0e1
         l6TtZHeUlGWJV4JuJOww7x5/ueQOo1P+ccLhrVCZkeU9GaUFsyl/MF8V9+dm2k6dZ4Ma
         36lX4LNXI3GYqtpBkEDcAum37gHaLj71GU/iuf0EuuZrXYEK3nVRlIXhVxOqqIXakIAd
         vhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p5AjNgRxYvWSo311L8Fi4s9BaU+vEEAJHGgsgNjup4c=;
        b=FSeZ+uEms8c+4YxhAU08tHqRHYmT3shi8cUEowpoRQgVvZhDoBg1CLrrsN9gVbJZ/a
         3mCbrWFQlgAe7DS83/tPE6IVmVZET/L1ecXPrrP8I5UElPSXpvWWIBDGNYn7Q08b75Wi
         xVOqxu7/vonb/IPu1on9zVpZ9jH46nuD3pzB1hesHMgMCRwtC/9TP1GGuR1gB3SEtg3Q
         6HVB20rYHMLyLvETQnQAxNrKBvqDO9qLj5EywHyMenW48hLqDhKpgwWRkdTZMXGDSbgC
         jYvA0pS3KGhuya9fOU/ZnxZV1Aik2755W/QlUPFk7U0aUVTtCszGIigw6vW0BHEmaV99
         ss/g==
X-Gm-Message-State: ANoB5pliJ/wfFpjRc8B0gVUKZj7IJVRqXdeb5Fk8WoUY5EbxT1FBZiYH
        XrMrA+cxAJIjhNRRnCvo1lG9EQ==
X-Google-Smtp-Source: AA0mqf7tBivANnXLrt8YurPNNcPk/uUa+ztwsqUGeaOFl+uqqBuSjIc5H16gudiUuNxpcPgZ+0WWxw==
X-Received: by 2002:a2e:b90a:0:b0:278:ec8b:4783 with SMTP id b10-20020a2eb90a000000b00278ec8b4783mr18166032ljb.91.1670000382408;
        Fri, 02 Dec 2022 08:59:42 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z22-20020a2e3516000000b00278a21bb7b9sm143991ljz.100.2022.12.02.08.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 08:59:41 -0800 (PST)
Message-ID: <feb6d0d3-706f-b726-dd13-9ed665a52f9d@linaro.org>
Date:   Fri, 2 Dec 2022 17:59:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/6] dt-bindings: usb: Add binding for Genesys Logic
 GL850G hub controller
Content-Language: en-US
To:     Icenowy Zheng <uwu@icenowy.me>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20221202081647.3183870-1-uwu@icenowy.me>
 <20221202081647.3183870-3-uwu@icenowy.me>
 <b4ddf139-5604-bd04-e309-d7bc15e9d23b@linaro.org>
 <2f0f31551d361cf23abdd2c4117f2feb84e2b1a8.camel@icenowy.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2f0f31551d361cf23abdd2c4117f2feb84e2b1a8.camel@icenowy.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2022 17:54, Icenowy Zheng wrote:
> 在 2022-12-02星期五的 10:02 +0100，Krzysztof Kozlowski写道：
>> On 02/12/2022 09:16, Icenowy Zheng wrote:
>>> The Genesys Logic GL850G is a USB 2.0 Single TT hub controller that
>>> features 4 downstream ports, an internal 5V-to-3.3V LDO regulator
>>> (can
>>> be bypassed) and an external reset pin.
>>>
>>> Add a device tree binding for its USB protocol part. The internal
>>> LDO is
>>> not covered by this and can just be modelled as a fixed regulator.
>>>
>>> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
>>> ---
>>> Changes in v2:
>>> - Misc fixes suggested by Krzysztof, including property
>>> descriptions,
>>>   single-item "items" and fixing the example's gpio property.
>>> - Fixed $id.
>>>
>> (...)
>>
>>> +
>>> +examples:
>>> +  - |
>>> +    usb {
>>> +        dr_mode = "host";
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +
>>> +        hub: hub@1 {
>>> +            compatible = "usb5e3,608";
>>> +            reg = <1>;
>>> +            reset-gpios = <&pio 7 2>;
>>
>> Use GPIO flags. What did you fix in the example?
> 
> It used to be here, but using it needs another include, which I don't
> think it necessary here.

The header is necessary for the flags...

> 
> Maybe I should just drop this line in the example?

It's useful. The example should be rather complete, not just compatible
and reg.

Different problem - you miss maxItems for the GPIOs.

Best regards,
Krzysztof

