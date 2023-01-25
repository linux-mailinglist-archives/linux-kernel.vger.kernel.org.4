Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E8067AAE2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 08:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbjAYH2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 02:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbjAYH2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 02:28:18 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E644A30188
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 23:28:16 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d14so12401850wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 23:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0juD3Z6CRCmdLHAmguPHCfD9MzYp+16yRKaiS/m80wE=;
        b=hJxiagec1rMDmnWfW5Db4ImIGKsN81dLF361HfBJP8gONdeMsQyVbgsv7K0lPF+6FT
         YD3DGQd8VLYNojWtfWnDmovrjYzRRV8h74Bq+5b65qUON8i5QrRbdvw0ZbMbPOCyO8FJ
         yZNbD8ZWFKyi+jn1oyL7JMVdFx6Npj5RpjZozks7cLPnw2soJDZ7F6VTPpqgYH2zI2Kk
         3JyxsqEzKEnRU6LN3haphIkjU7qd1bprZTL7m5w1ngAP0ZhCsM6JtiqG4VfW13QzJjBC
         +JqSq7CQnBEBerxs6/Gi60UodIESSToTeelYUJgURCdi07LHNfhSmBPOM1i3aFy+v2gZ
         1n9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0juD3Z6CRCmdLHAmguPHCfD9MzYp+16yRKaiS/m80wE=;
        b=h5OpHP4/RHwFLI/MiTTfS8h0MAvt5eBlq6jzeUhI6feK7KCLkqUvPAm8WVyoTZIXiS
         z0EYR0DWAbkyI6lBCxPCO+l6VPofMDuYXqIFr0DsK/sYcwFjymsHYkC00OJE64jHs2VY
         h+0Y+cwaXltlCtPEHslKRyEML4VbZ2pinQW5Ga56IJ+n9xV1ffkxZyDl6zX1lV8zmLLm
         rBf5jGlUgcKnbJ8wPEp7i0lh5UQmPUPXVJkXeSOrSd9iSiAxsN4S/Vjmpysb1w7q37NP
         bRfyq4j6PBtQYwKiZWQeGX+SiFKsfEO6ekWq6t1zFzDeT2UAJOBHW25Iot2bf0KepAs6
         qadw==
X-Gm-Message-State: AO0yUKW913fhC1zWCtnyv4dEsQacXXHl5ftvqvuz5sBWv8gc/L89sLoJ
        B/xRcPTaYtTQ+5rb3Yss4hkVCw==
X-Google-Smtp-Source: AK7set9lUBCjZ9+aqMQcWhmoChQgZw7gc5KBt4C0vQo4fYLZ0wwqlOF3vMs9z66OwHjipriVA7x0sQ==
X-Received: by 2002:a5d:4f87:0:b0:2bf:b2c2:e122 with SMTP id d7-20020a5d4f87000000b002bfb2c2e122mr3656874wru.29.1674631695385;
        Tue, 24 Jan 2023 23:28:15 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g16-20020adffc90000000b002882600e8a0sm3788880wrr.12.2023.01.24.23.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 23:28:14 -0800 (PST)
Message-ID: <e053aa6d-8a0b-b0ea-85e7-a1b35fd00e53@linaro.org>
Date:   Wed, 25 Jan 2023 08:28:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 2/2] dt-bindings: display: simple-framebuffer: Document
 physical width and height properties
Content-Language: en-US
To:     Rayyan Ansari <rayyan@ansari.sh>, Rob Herring <robh@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        ~postmarketos/upstreaming@lists.sr.ht, asahi@lists.linux.dev,
        janne@jannau.net, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20230121153544.467126-1-rayyan@ansari.sh>
 <20230121153544.467126-3-rayyan@ansari.sh>
 <CAL_JsqL+G=Cxkc2j_NowznpqNAnixrU+-6SdccFbpMaP6OYSqQ@mail.gmail.com>
 <cdf32cb0-4529-6bbd-fdda-ae641d141ee5@ansari.sh>
 <20230123175339.GA2019900-robh@kernel.org>
 <3d448210-e9d2-b0ee-e009-535bb0bb760d@ansari.sh>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3d448210-e9d2-b0ee-e009-535bb0bb760d@ansari.sh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2023 23:19, Rayyan Ansari wrote:
> On 23/01/2023 17:53, Rob Herring wrote:
>> On Sun, Jan 22, 2023 at 05:25:38PM +0000, Rayyan Ansari wrote:
>>> On 22/01/2023 15:36, Rob Herring wrote:
>>>> On Sat, Jan 21, 2023 at 9:36 AM Rayyan Ansari <rayyan@ansari.sh> wrote:
>>>>>
>>>>
>>>> Why do you need this change?
>>>>
>>>> The 'simple-framebuffer' contains data on how the bootloader
>>>> configured the display. The bootloader doesn't configure the display
>>>> size, so this information doesn't belong here. The information should
>>>> already be in the panel node, so also no point in duplicating it here.
>>>>
>>>>> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
>>>>> ---
>>>>>    .../devicetree/bindings/display/simple-framebuffer.yaml   | 8 ++++++++
>>>>>    1 file changed, 8 insertions(+)
>>>
>>> Hi Rob,
>>>
>>> There is the usecase that Hans has mentioned, but I have also mentioned
>>> another usecase previously.
>>>
>>> Adding the width-mm and height-mm properties allows user interfaces such as
>>> Phosh (https://puri.sm/posts/phosh-overview/) to scale correctly to the
>>> screen. In my case, a panel node is not available and the aforementioned
>>> interface is in fact running on the SimpleDRM driver (which binds to the
>>> simple-framebuffer device).
>>
>> Why is the panel node not available? Why not add it? Presumably it is
>> not there because you aren't (yet) using the simple-panel driver (and
>> others that would need). But presumably you will eventually as I'd
>> imagine turning the screen off and back on might be a desired feature.
> 
> It requires more than using the simple-panel driver: first the SoC side 
> display hardware needs to be brought up, then a panel driver that 
> implements the proper DCS initialisation sequence needs to be written 
> (which is currently not fully known).
> 
>>
>> So why add a temporary DT property that's tied to your *current* kernel? > The DT should not be tightly coupled to the kernel.
> 
> I'm not sure what you mean by it being "tightly coupled" to the kernel.

It means that you used current Linux driver support (or lack) for some
hardware as an argument for bindings. If you add later the driver, the
bindings should be changed? Answer is: not. Bindings should be
independent of Linux drivers, thus whatever kernel is missing now, is
not an argument in favor of this property.

Best regards,
Krzysztof

