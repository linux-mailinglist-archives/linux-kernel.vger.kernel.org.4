Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D872E6D0B88
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjC3Qkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjC3Qkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:40:47 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D69ACA2E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:40:45 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o24-20020a05600c511800b003ef59905f26so12173296wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680194444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kz/2H/BTIuKLAKXpo3BrU6LM5Cbhbn/nr7Y/43JgHBo=;
        b=ZlHh9rnbOioBf3nV/3JYjFE5Qh/bXo4StWdfNEsfuVogmTWridktEfoOhrvWpVNNhE
         0z/X0MYaJjK/QYT4ITLVIUdplXX/DuXksJC0IpeVKtHOrPLMJe9eSvHXtK4aOFvf4tZs
         /AbEoXyA7m4P/L9dHHblxxWiEqpMvlOY5GomHTzf+A7mUydBq8mvV4Xac+jQ3DUw+m7d
         M7bxCvgbaGFMHEPdtiAa6ky4qk4LVn0KlYFTszccyx+U9QZE1gLR26fPAJN9gaLHkJpX
         WQORjeI04LW5T5Q3kvDg17MPl5M4+c/QRypn5gBwOkQH/rvgvQ4KM27LU9sBhn9IdM+7
         8UVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680194444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kz/2H/BTIuKLAKXpo3BrU6LM5Cbhbn/nr7Y/43JgHBo=;
        b=64Clxq7cUQOXS0k0qWRIbwVVY7mAcxBw0jI4qPw1C1dRC3uq2c79CnwVrqts2k6S86
         AIJZ2nYRGIYrD1eBnszgzfWXb9j7qIU/01thex6KuBU18td14i85YKgYdlkPyTX4ssL4
         0yx6gl/PBsaFy3Av045WrQ3ArUVTtV3ID38PCLMGdril95T8jZtZRJoNgE+Mx1+kDErO
         z9807tzFg49SccscO/NNcGbxfjv8/f2s7cUHKp+x/0f5Ru8mnPZBqfjGusvNZXbuoOUu
         WCi+vQW9KfUK1oJ92bS172wVt3f3imOfcWcgUYSLb4mtw+O4XsB8x6vm7xmAvwXFIA2E
         JcBw==
X-Gm-Message-State: AO0yUKWuRaoKQhSBnL97yEHBOcqKxIkQKg6An9pESQ/FgTcsa1ojkMyV
        2LSnOjXcRFXnZyAAugdFaveoMw==
X-Google-Smtp-Source: AK7set+T5+LX8G1drB7duDYdeQf04Abk5u9lOdEbqBzlttJPRn/c1AIIE43phBoZUQBtKJJiVWYC7Q==
X-Received: by 2002:a7b:c8d0:0:b0:3eb:39e7:35fe with SMTP id f16-20020a7bc8d0000000b003eb39e735femr17905942wml.30.1680194443891;
        Thu, 30 Mar 2023 09:40:43 -0700 (PDT)
Received: from [172.20.10.2] ([37.166.66.243])
        by smtp.gmail.com with ESMTPSA id w20-20020a05600c475400b003f034c76e85sm3545852wmo.38.2023.03.30.09.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 09:40:43 -0700 (PDT)
Message-ID: <cad25e0a-9594-3d5e-79e7-fd00a80f67ac@linaro.org>
Date:   Thu, 30 Mar 2023 18:40:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 18/21] ARM: drop SMP support for ARM11MPCore
Content-Language: en-GB
To:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, guoren <guoren@kernel.org>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S . Miller" <davem@davemloft.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-oxnas@groups.io" <linux-oxnas@groups.io>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org,
        "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Daniel Golle <daniel@makrotopia.org>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-19-arnd@kernel.org>
 <d7f36a28-0cae-a035-791b-363754aefeee@linaro.org>
 <6a5bd3a3-87e0-4a24-89ca-d265b0817a95@app.fastmail.com>
From:   Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <6a5bd3a3-87e0-4a24-89ca-d265b0817a95@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 30/03/2023 à 12:03, Arnd Bergmann a écrit :
> On Thu, Mar 30, 2023, at 09:48, Neil Armstrong wrote:
>> On 27/03/2023 14:13, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> The cache management operations for noncoherent DMA on ARMv6 work
>>> in two different ways:
>>>
>>>    * When CONFIG_DMA_CACHE_RWFO is set, speculative prefetches on in-flight
>>>      DMA buffers lead to data corruption when the prefetched data is written
>>>      back on top of data from the device.
>>>
>>>    * When CONFIG_DMA_CACHE_RWFO is disabled, a cache flush on one CPU
>>>      is not seen by the other core(s), leading to inconsistent contents
>>>      accross the system.
>>>
>>> As a consequence, neither configuration is actually safe to use in a
>>> general-purpose kernel that is used on both MPCore systems and ARM1176
>>> with prefetching enabled.
>>>
>>> We could add further workarounds to make the behavior more dynamic based
>>> on the system, but realistically, there are close to zero remaining
>>> users on any ARM11MPCore anyway, and nobody seems too interested in it,
>>> compared to the more popular ARM1176 used in BMC2835 and AST2500.
>>>
>>> The Oxnas platform has some minimal support in OpenWRT, but most of the
>>> drivers and dts files never made it into the mainline kernel, while the
>>> Arm Versatile/Realview platform mainly serves as a reference system but
>>> is not necessary to be kept working once all other ARM11MPCore are gone.
>>
>> Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
>>
>> It's sad but it's the reality, there's no chance full OXNAS support will
>> ever come upstream and no real work has been done for years.
>>
>> I think OXNAS support can be programmed for removal for next release,
>> it would need significant work to rework current support to make it acceptable
>> before trying to upstream missing bits anyway.
> 
> Ok, thanks for your reply!
> 
> To clarify, do you think we should plan for removal after the next
> stable release (6.3, removed in 6.4), or after the next LTS
> release (probably 6.6, removed in 6.7)? As far as I understand,
> the next OpenWRT release (23.x) will be based on linux-5.15,
> and the one after that (24.x) would likely still use 6.1, unless
> they skip an LTS kernel.

I think it's ok to remove it ASAP, or at least before the next LTS,
not having SMP makes the platform barely usable so the earliest is the best.

Neil

> 
>       Arnd

