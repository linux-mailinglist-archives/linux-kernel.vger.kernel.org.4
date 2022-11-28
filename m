Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD7863B416
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbiK1VRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbiK1VRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:17:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4861B495;
        Mon, 28 Nov 2022 13:17:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72389B80E9A;
        Mon, 28 Nov 2022 21:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D31AC433D7;
        Mon, 28 Nov 2022 21:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669670264;
        bh=wR2vdYn7jxfskOVqXRDFR2xx2Bh5pit2zrFi6YtSvFA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=r+pIGF/O69EpN3z6euPpIMgazagQE7FEA6RWFRgsVQYtt8TLAaZ9FEWYFPTYD6+OC
         FTJRX2CvpbxoGy8xZ2as10rOn6NE7W7S+UAl9O5Y5U1JWEKTHTeRYP0SyLPGVxlHSw
         eOfTKqKtJ8BZ+PtDxt4h542vz13uyGbYVzvhfJoR3eJyFtNqeX18G+F8Z0WWz/sROq
         UcL1HrjboQojqRU8uctCQbCUyg545fvt+jrRG2DOj5r/Xxir4mKaEPwmI+eiMlYppS
         Dt5BgKPdOopYmwT8jha9ECjs4a6HTNsnKyfB8TFd9zd2qEHItHOhHyuE11WGfYh+Xe
         D9CiPaGAa33WA==
Message-ID: <6aad3b63-498e-b13a-af49-b5af0d4e721e@kernel.org>
Date:   Mon, 28 Nov 2022 21:17:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 12/12] riscv: defconfig: Enable the Allwinner D1
 platform and drivers
Content-Language: en-US
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Samuel Holland <samuel@sholland.org>, palmer@dabbelt.com
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Stanislav Jakubek <stano.jakubek@gmail.com>
References: <20221125234656.47306-1-samuel@sholland.org>
 <20221125234656.47306-13-samuel@sholland.org> <Y4JBa52o4Yemv/uj@spud>
 <11740765.nUPlyArG6x@diego>
From:   Conor Dooley <conor@kernel.org>
In-Reply-To: <11740765.nUPlyArG6x@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2022 21:11, Heiko Stübner wrote:
> Am Samstag, 26. November 2022, 17:40:11 CET schrieb Conor Dooley:
>> On Fri, Nov 25, 2022 at 05:46:56PM -0600, Samuel Holland wrote:
>>> Now that several D1-based boards are supported, enable the platform in
>>> our defconfig. Build in the drivers which are necessary to boot, such as
>>> the pinctrl, MMC, RTC (which provides critical clocks), SPI (for flash),
>>> and watchdog (which may be left enabled by the bootloader).
>>
>> All of that looks good.
>>
>>> Other common
>>> onboard peripherals are enabled as modules.
>>
>> This I am not sure about though. I'll leave that to Palmer since I'm
>> pretty sure it was him that said it, but I thought the plan was only
>> turning on stuff required to boot to a console & things that are
>> generally useful rather than enabling modules for everyone's "random"
>> drivers. Palmer?
> 
> Isn't the defconfig meant as a starting point to get working systems
> with minimal config effort? At least that was always the way to go on arm
> so far :-) .
> 
> So having boot-required drivers built-in with the rest enabled as modules
> for supported boards will allow people to boot theirs without headaches.
> 
> Disabling unneeded drivers if you're starved for storage space in a special
> project is always easier than hunting down all the drivers to enable for a
> specific board. 

I wouldn't mind being able to turn on all the PolarFire SoC stuff and
yeah, that would be the way that arm64 does it. But I do recall hearing
that I should not turn stuff on this way, when I initially tried to
turn stuff on via selects, got a nack and asked if I could do this instead.

But it may be that I misremember, which is why I appealed to the Higher
Powers for clarification :)
