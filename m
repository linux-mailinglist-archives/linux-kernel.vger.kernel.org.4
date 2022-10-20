Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913546055F5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 05:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJTDbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 23:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJTDbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 23:31:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC770165C8C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 20:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=FK9pfVH2MwuIme9II68lfWwQSqGVFiwYeu262/7JwAQ=; b=yxvxh/p1LlEBHyhtnmcdPkvaZe
        1dZyIkKWXDPptNDefT2fYC1qISkPSEl3HPmymmGi7NHD07HZ9TntO4stiY0CqviWcNNaWgWF5IIYY
        pxmXcZPrkNxAdQHl1DJLphWncekuVy/exv6VKOkmSu47fbVSGw2mflV+dXuqU8yZkinqErDU/a/CM
        QmlDrBzW7mhXJrtqfY0YJcjelbMFFP3n3kbhsmPkTV2kMLJXjIhrIW3EfDzyiqhiPTiC2CbNpFNHf
        stuoqLDtmllIjrcLS/1BCqzAWroLYQWaXfz30tJa6wb56LSIUMCWisupNzXfszeifStecppgMN8R6
        KAnnASrg==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olMHQ-009xYP-It; Thu, 20 Oct 2022 03:31:36 +0000
Message-ID: <e0fb158f-81af-8f3d-5d8b-c4c423feec6c@infradead.org>
Date:   Wed, 19 Oct 2022 20:31:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [GIT PULL] Backlight for v6.1
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Yz18QA27+gN0oaM3@google.com>
 <CAHk-=whK-q1W-X0q0f_nBJ9sKyta-DVJhEAS4BF_oKAVAUQ4Jw@mail.gmail.com>
 <Y0AmmR2NfKc/Y7Mb@google.com>
 <CAHk-=wg=hh8xkPjiySnjAyR66AG64eyZ1Y9gHw+MCs8uuSZReA@mail.gmail.com>
 <Y0HB3K8IRVhX5IvT@smile.fi.intel.com>
 <CAHk-=wixtjmiENLbc1=Hds3mMSjVRA3ZiwXN7yg8mw_1MCg_QQ@mail.gmail.com>
 <d66fa3ea-1efe-e7da-be80-89507067e2a9@redhat.com>
 <CAHk-=wgF_0+au4cz-ZmH4qOpgDWmmbJC101fh_RVAbsJRH7d-Q@mail.gmail.com>
 <189ed242-4ccb-4935-ede0-c5807d7b5083@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <189ed242-4ccb-4935-ede0-c5807d7b5083@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/22 05:58, Hans de Goede wrote:
> Hi,
> 
> On 10/9/22 01:23, Linus Torvalds wrote:
>> On Sat, Oct 8, 2022 at 12:59 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Yeah, I don't expect he driver to work on real hardware,
>>>
>>> I'm not sure what you mean here. I guess you mean that you
>>> do not expect to be able to test the driver on real hw
>>> yourself?
>>
>> Well, that too, but I really along the lines of "make it build as a
>> module when I2C_DESIGNWARE_PLATFORM is a module"
> 
> Actually because the driver only works properly when builtin the
> driver itself is a bool option not a tristate. So I am not sure
> if even if we change the the:
> 
>         depends on I2C_DESIGNWARE_PLATFORM=y
> 
> to:
> 
>         depends on I2C_DESIGNWARE_PLATFORM=y || COMPILE_TEST

That change worked for me.

drivers/mfd/intel_soc_pmic_crc.o is built and
drivers/i2c/busses/i2c-designware-platform.ko is built.

> it still will not be build with an "allmodconfig" build? I must
> admit I don't know what that does with bool options.

I don't see a problem...

but I didn't test all of the other x86 PMIC drivers.
They are all built as loadable modules since I didn't make any changes
to their Kconfig entries.

> If it says yes to bool options, then yes adding the " || COMPILE_TEST"
> will give you build coverage with an "allmodconfig" build and
> I would be happy to submit a patch adding this for all the affected
> x86 PMIC drivers.
> 
>> Because if it depends on some symbols from I2C_DESIGNWARE_PLATFORM,
>> and that one can be a module, then the Intel PMIC driver also needs to
>> be built as a module to just get the build coverage, at least.

I don't see intel_soc_pmic_crc.c using any direct calls into
i2c-designware-platform code. If it calls into it, it must be thru some
indirect pointers (?).
It's not causing any build problems once the "|| COMPILE_TEST"
change is made.  (I am build testing on linux-next-20221019.)

> See above, currently these are bool-s I guess we may be able to
> come up with some Kconfig magic where they can be build as module
> only when COMPILE_TEST is set ? Anyone now the right Kconfig magic
> for this ?
> 
>> And I can imagine that that will not work very well on actual hardware
>> with some of these core drivers that may want to initialize early?
> 
> Right, we want to enforce things, including the i2c controller driver
> to be build in because that is necessary on actual hw and allowing
> these to be build as modules has lead to bug reports in the past.
> 
>> But I'd love to at least have the build coverage.
> 
> I agree, see above for some gotchas though.
> 
> FWIW as a side-project I actively work on keeping these platforms working
> well with the latest mainline kernel, so I do build these with the latest
> rc kernels all the time.


-- 
~Randy
