Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F35D6B20BE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjCIJ4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjCIJ4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:56:18 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACECF5FE9E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:56:16 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k37so747252wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 01:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678355775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qAAhw7lB1rrZvuMVfbBzujapn+/zsUej9eNIY9bSZoU=;
        b=yZjRzzdCXQLmFpt9E+bMwjZRnJQPVa5Fk3G2FgvPi2iwm1j8+mFjXrOOcHKW1G1J66
         lOl9przlR+A0LWj9hzkaC5wXbugy9h3g7+n86a8ktCU2jYovW1IiGKFZ2l2rhN0VQhSh
         XpW8RkXba7qEvRxI4QHi7FU+iYobJUFN0ibmMpjRhc5EAqs6wqRm42vpXvueF+t6S0zn
         esAT9tINPVEvwzdEyzTeYAbl9wsqy+wks2G9EZhmBa3Pc6aCWyEfjdbJ2XsWC9j7R5cZ
         355EbVkEyy1z0QPmblIqIkV2LzFUIN+dVVadaKjNXV0XCLBKGdMDi4M4sc6TfFpO3WmH
         +v/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678355775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qAAhw7lB1rrZvuMVfbBzujapn+/zsUej9eNIY9bSZoU=;
        b=AGefQeYoqgSyiOTFGd7Xt86GUIJh7dtpgCNebnxWQ+M/80bY4ob0p0uRP3328bQVUP
         wM5tPRTA9B+Zw/FBjHkwUrrSqQeolI0GVk5L+tIt/4ktYFZK1y+2/m2EH4NpasgOvizV
         p32rIgLLoXUdDyKKqyzmx51KDBH/hwtw6TX9ZCGvgeTCD+vghiX6xpVUqQJAMqHkh5tx
         z2aF0CHWueKTLGRoWMJ1CezXdQ0KJ3TMjENdSGpjQM6SMm9YHdS19Y87I5G5h36bE9jZ
         iD7YLryOPqT4wash4Pui+8/8DChMYQn97OM5MKVj28VSrDxUTzfA3e65Xq0PSkspuPnG
         qLVA==
X-Gm-Message-State: AO0yUKWytKnwIP/kUlhxKuazopHCwZxSHjhF7rUKw+dawnxnfMfjKe36
        wa1aYWxXfOoI5AXuY2jNw+KdyQ==
X-Google-Smtp-Source: AK7set9Lvl/llfXYHp3tq/QCtj3IQX+/nJeOjg3aANAt466Rv6k3E6M4mLBeqwJwkAPViMGxcGk+nw==
X-Received: by 2002:a05:600c:444a:b0:3eb:4162:7344 with SMTP id v10-20020a05600c444a00b003eb41627344mr19698192wmn.22.1678355775156;
        Thu, 09 Mar 2023 01:56:15 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id p7-20020a1c7407000000b003eaee9e0d22sm2015189wmc.33.2023.03.09.01.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 01:56:14 -0800 (PST)
Message-ID: <1a6b79fa-cf80-7ee9-fbdc-3543111ec191@linaro.org>
Date:   Thu, 9 Mar 2023 09:56:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V4 2/2] nvmem: add generic driver for devices with MMIO
 access
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20230228072936.1108-1-zajec5@gmail.com>
 <20230228072936.1108-3-zajec5@gmail.com>
 <7853ff04-02cf-9430-d84a-c8fe8b1d6725@linaro.org>
 <83c3e403-7e4c-a29a-95de-f30d74863769@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <83c3e403-7e4c-a29a-95de-f30d74863769@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/03/2023 15:42, Rafał Miłecki wrote:
> On 8.03.2023 14:31, Srinivas Kandagatla wrote:
>> Thanks for doing this,
> 
> Thank you for reviewing. Sadly it seems it still isn't clear if we can
> have this generic driver.

I don't mean to be rude, but TBH, I don't see any value for this ATM, it 
is going to add something that we need to keep updating for every user.

Unless anyone thinks otherwise.

> 
> I guess I missed some important questions or comments. In previous
> series we were discussing implementation details so I thought it's OK to
> have this driver after all. Not sure if I didn't waste time working on
> V4. I'll see if I can I address your concerns (see below).
Lets not waste your time for now, we can revist this once we have more 
users.

thanks,
srini
> 
> 
>> On 28/02/2023 07:29, Rafał Miłecki wrote:
>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>
>>> Some NVMEM devices can be accessed by simply mapping memory and reading
>>> from / writing to it. This driver adds support for a generic
>>> "mmio-nvmem" DT binding used by such devices.
>>>
>>> One of such devices is Broadcom's NVRAM. It's already supported (see
>>> NVMEM_BRCM_NVRAM) but existing driver covers both:
>>
>> What will happen to the old "brcm,nvram" compatible and the dt 
>> firmware that already have this node?
> 
> I treat backward compatibility with previouly used bindings very
> seriously. I'm going to keep it. I may make an attempt to drop it in
> few years if it's very unlikely to break any setups.
> 
> 
>> If there is only one user for this then one would object that why do 
>> we need this DT level of abstraction to start with?
>> If this is not the case please consider adding those patches to this 
>> series.
> 
> Existing Linux drivers prove that there is more hardware with MMIO based
> read access: brcm_nvram, mtk-efuse, uniphier-efuse. Migration of other
> drivers (mtk, unipher) is on hold as apparently there may be support for
> writing support soon. In any case this MMIO solution isn't completely
> unique to Broadcom.
> I don't have other patches to add to it right now.
> 
> 
>>> 1. NVMEM device access
>>> 2. NVMEM content parsing
>>>
>>> Once we get support for NVMEM layouts then existing NVRAM driver will
>>> get converted into a layout and generic driver will take over
>>> responsibility for data access.
>>>
>>
>> Even though this series is simple, but it is really confusing for two 
>> reasons.
>>
>> 1> Generic mmio nvmem bindings are incomplete and potentially 
>> change/evolve on every new user. Ex clks, regulators, endianess ... So 
>> it looks really fragile and incomplete to me as a generic bindings.
>> Is this want you are expecting?
> 
> All 3 existing hardware support MMIO reads without extra clocks or
> regulators. I'm not sure if endianess belongs to this layer. Isn't that
> NVMEM content thing?
> 
> I'm not claiming this driver is in its final and perfect state. For
> simple hardware that needs minor fixups we can add those later to this
> generic driver. Adding clocks should be possible, fine and easy.
> 
> I'm sure there will be more complex hardware that we will not be able
> to support with this driver. It's require another driver and I'm fine
> with that.
> 
> 
>> 2> As you mentioned that this will replace broadcom NVMRAM, but this 
>> patch does nothing in relation to updating that driver, so the code is 
>> dead as it is. If you are considering to use it for Broadcom NVMRAM, 
>> please add those patches to this series so that we could see the real 
>> user for this code.
> 
> Of course it does nothing because there are no layouts yet. I could
> migrate brcm_nvram into layout once there is layouts support.
> 
> I don't agree this code is dead. It support new binding. It works.
> Every new binding and its driver are "dead" until you add first DT
> users.
> 
> Here is real use:
> 
> nvmem@1eff0000 {
>      compatible = "mmio-nvmem";
>      reg = <0x1eff0000 0x10000>;
> };
> 
