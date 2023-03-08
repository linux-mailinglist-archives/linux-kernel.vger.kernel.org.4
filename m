Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1525A6B0D2C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjCHPob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjCHPoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:44:07 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06C31A674;
        Wed,  8 Mar 2023 07:43:00 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id z5so17039251ljc.8;
        Wed, 08 Mar 2023 07:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678290178;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOs0iyxhwHc1V8xriX+vpDIxtXfxz3jlhHgNbQ6dRkY=;
        b=KD42Vr+glYj1oCL8i0V2FYuzc9WtlLulVscKDIrjTKPoJxkIg6x11Y7p0Wv8iP4Sex
         yVFuv0chGe4+SbpPZnNUluOjDEDYorU0/ZKpwEUzngcG06SezQYFKim7c/OuQ4l8UVfw
         Ozke2M0wqNjmv6cN2MbU//+A6dCcHLdn+vjN682rehANzzLSASMTqq7tqBmTzYSyAo4z
         p5QDSYdLxmKU71+4B4TYs4xVT/utPFUosyspyE+LpPy7Fh47pbYnI/iFAL0TSFYjNu06
         4eVL4awgqVgYZWb1MNl3t8pJHcU8t5hnxyX/B0SxzwSG9jIyVmi56s10848a7afHKFk2
         Kp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678290178;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vOs0iyxhwHc1V8xriX+vpDIxtXfxz3jlhHgNbQ6dRkY=;
        b=yjMDMLqiXaTBJcbL4FsLXTZrjxSH98vdwO+zs3vex5angNFT0ibPH0eFiBey6vN8y6
         IQgoGNg0C2hQqYHRvQXpeLUWZXDN35v2yWPKvZIdBRAa5Rm0tE+WDiAwnOBlSH/DRxJP
         dosLfP4+J9n3ahSUK75TPWfOG5N3ramFxUwPgItZdFVUDhniokPKXoLew3zVvWMCVbmz
         LI0Co2ds9n8CGjceg1QADqvsentRqLw9bCtE70HjN4f36AORNwsrOBAviBP2GodAbfLe
         c8d7BdXOXoV0ODeCprGF4rJUClYOtrpiGBgfxvwswK09u5AnD1YGz74NM8VUK5IoYzZO
         BtHA==
X-Gm-Message-State: AO0yUKUpeOORp7tUTs7H4/nIk74dTOjGoMMWLRzicS2cdKvHlCfmnrW9
        Kp1Q8V+TRECDiI7ht5i4rOHfizrNxwg=
X-Google-Smtp-Source: AK7set9ANgxfUA3AnstqXs0zAbjnZVAktlqKsWKgvMz6DSCnyBEYt7t6Os79HTpsoPUzpt844g0qMg==
X-Received: by 2002:a2e:a26b:0:b0:295:bc01:6d98 with SMTP id k11-20020a2ea26b000000b00295bc016d98mr5849330ljm.48.1678290178143;
        Wed, 08 Mar 2023 07:42:58 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id d2-20020a2e96c2000000b00295a2d07558sm2620211ljj.112.2023.03.08.07.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 07:42:57 -0800 (PST)
Message-ID: <83c3e403-7e4c-a29a-95de-f30d74863769@gmail.com>
Date:   Wed, 8 Mar 2023 16:42:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH V4 2/2] nvmem: add generic driver for devices with MMIO
 access
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
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
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <7853ff04-02cf-9430-d84a-c8fe8b1d6725@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8.03.2023 14:31, Srinivas Kandagatla wrote:
> Thanks for doing this,

Thank you for reviewing. Sadly it seems it still isn't clear if we can
have this generic driver.

I guess I missed some important questions or comments. In previous
series we were discussing implementation details so I thought it's OK to
have this driver after all. Not sure if I didn't waste time working on
V4. I'll see if I can I address your concerns (see below).


> On 28/02/2023 07:29, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> Some NVMEM devices can be accessed by simply mapping memory and reading
>> from / writing to it. This driver adds support for a generic
>> "mmio-nvmem" DT binding used by such devices.
>>
>> One of such devices is Broadcom's NVRAM. It's already supported (see
>> NVMEM_BRCM_NVRAM) but existing driver covers both:
> 
> What will happen to the old "brcm,nvram" compatible and the dt firmware that already have this node?

I treat backward compatibility with previouly used bindings very
seriously. I'm going to keep it. I may make an attempt to drop it in
few years if it's very unlikely to break any setups.


> If there is only one user for this then one would object that why do we need this DT level of abstraction to start with?
> If this is not the case please consider adding those patches to this series.

Existing Linux drivers prove that there is more hardware with MMIO based
read access: brcm_nvram, mtk-efuse, uniphier-efuse. Migration of other
drivers (mtk, unipher) is on hold as apparently there may be support for
writing support soon. In any case this MMIO solution isn't completely
unique to Broadcom.
I don't have other patches to add to it right now.


>> 1. NVMEM device access
>> 2. NVMEM content parsing
>>
>> Once we get support for NVMEM layouts then existing NVRAM driver will
>> get converted into a layout and generic driver will take over
>> responsibility for data access.
>>
> 
> Even though this series is simple, but it is really confusing for two reasons.
> 
> 1> Generic mmio nvmem bindings are incomplete and potentially change/evolve on every new user. Ex clks, regulators, endianess ... So it looks really fragile and incomplete to me as a generic bindings.
> Is this want you are expecting?

All 3 existing hardware support MMIO reads without extra clocks or
regulators. I'm not sure if endianess belongs to this layer. Isn't that
NVMEM content thing?

I'm not claiming this driver is in its final and perfect state. For
simple hardware that needs minor fixups we can add those later to this
generic driver. Adding clocks should be possible, fine and easy.

I'm sure there will be more complex hardware that we will not be able
to support with this driver. It's require another driver and I'm fine
with that.


> 2> As you mentioned that this will replace broadcom NVMRAM, but this patch does nothing in relation to updating that driver, so the code is dead as it is. If you are considering to use it for Broadcom NVMRAM, please add those patches to this series so that we could see the real user for this code.

Of course it does nothing because there are no layouts yet. I could
migrate brcm_nvram into layout once there is layouts support.

I don't agree this code is dead. It support new binding. It works.
Every new binding and its driver are "dead" until you add first DT
users.

Here is real use:

nvmem@1eff0000 {
	compatible = "mmio-nvmem";
	reg = <0x1eff0000 0x10000>;
};

