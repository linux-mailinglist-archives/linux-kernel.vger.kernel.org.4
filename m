Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052E15FDAFB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiJMNgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJMNgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:36:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438891F63E;
        Thu, 13 Oct 2022 06:36:40 -0700 (PDT)
Received: from [192.168.2.145] (unknown [109.252.119.114])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 315026602366;
        Thu, 13 Oct 2022 14:36:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665668199;
        bh=X7JRg8hHNWiepllAE6ql0iHxp27/0MrDM/na+P0JU3A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VPj2ZtF73KX1i6aG7uKowJM1vurmzivbSm+hMLPhA16GoykO3OpeqP4zBe/ULXps9
         V0hrQfoYLyXFh95Xn6Oy1wnPwSSVKEIbDE5vWa2+DHWvVf9O8x4CYMz3UN+bJS703r
         VjBgYnZS6UyEGq1+lZ/1ee8TZ833t1aSMpBzr8TYTpdn4xd+NYhqXcv4WLZoXtHp9Q
         oBFjgYP9TpZ3xJEYo+zOL+qG5t5GVi+DKZotaeNwARytdWeQsuZ0WM4HFEPUa/KW1J
         jujAdBohgoJYC07ENoZ0tg3z/hgiSSUSTe/6Z98yrFe8B+bWNVQCV/nIUzw+MrxVsR
         FbNbqCHQCNAQQ==
Message-ID: <57b73b51-ce07-0612-14fb-8b76bb52e3dc@collabora.com>
Date:   Thu, 13 Oct 2022 16:36:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v1] ARM: dts: sun8i: h3: orangepi-pc: Add CMA reserved
 memory node
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
References: <20220914151125.212876-1-dmitry.osipenko@collabora.com>
 <1826631.tdWV9SEqCh@jernej-laptop>
 <f0e66966-b1c5-f130-54a4-ad63b77e1f26@collabora.com>
 <2057585.bB369e8A3T@kista>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <2057585.bB369e8A3T@kista>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 01:17, Jernej Škrabec wrote:
> Hi,
> 
> Dne četrtek, 15. september 2022 ob 11:01:36 CEST je Dmitry Osipenko 
> napisal(a):
>> Hi,
>>
>> On 9/14/22 21:34, Jernej Škrabec wrote:
>>> Dne sreda, 14. september 2022 ob 17:33:27 CEST je Clément Péron 
> napisal(a):
>>>> Hi Dmitry,
>>>>
>>>> On Wed, 14 Sept 2022 at 17:12, Dmitry Osipenko
>>>>
>>>> <dmitry.osipenko@collabora.com> wrote:
>>>>> Add 256MB CMA node to the Orange Pi PC board. This fixes memory
>>>>> allocation
>>>>> failures for Cedrus video decoder on trying to play a 1080p video with
>>>>> gstreamer.
>>>>>
>>>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>>>> ---
>>>>>
>>>>>  arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 14 ++++++++++++++
>>>>>  1 file changed, 14 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
>>>>> b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts index
>>>>> b96e015f54ee..e655346a9fb4 100644
>>>>> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
>>>>> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
>>>>> @@ -60,6 +60,20 @@ chosen {
>>>>>
>>>>>                 stdout-path = "serial0:115200n8";
>>>>>         
>>>>>         };
>>>>>
>>>>> +       reserved-memory {
>>>>> +               #address-cells = <1>;
>>>>> +               #size-cells = <1>;
>>>>> +               ranges;
>>>>> +
>>>>> +               linux,cma@40000000 {
>>>>> +                       compatible = "shared-dma-pool";
>>>>> +                       alloc-ranges = <0x40000000 0x40000000>;
>>>>> +                       size = <0x10000000>; /* 256MiB */
>>>>> +                       linux,cma-default;
>>>>> +                       reusable;
>>>>> +               };
>>>>> +       };
>>>>> +
>>>>
>>>> This change seems legit for all H3 boards and could be moved to the H3
>>>> dtsi, no?
>>>
>>> That's true. However, there is a reason why this node doesn't exist. One
>>> or
>>> two H2+ boards (which use H3 dtsi) have only 256 MiB of RAM, so this can't
>>> work with them. A few H3 boards have 512 MiB of RAM, so you eat basically
>>> half of the RAM with that.
>>
>> It's a "reusable" CMA, hence it won't be eaten. System is free to use
>> the reusable CMA. In practice, CMA may get populated with a pinned pages
>> over time, hence system will work fine, but CMA will get fragmented and
>> this may cause problems for a larger CMA allocations.
>>
>> The main problem with 512M boards should be that they may not have a
>> suitable area for 256M CMA because it should be only either a low or
>> high part of the memory that might be busy at a boot time, and then
>> kernel will fail to boot.
>>
>>> Additionally, contrary to A20 and similar SoCs, which
>>> have such node, Cedrus can address whole RAM, so this is not strictly
>>> needed. It's better to leave this decision to distribution. Some don't
>>> care about Cedrus and some do a lot. Default size can be set via kernel
>>> config and it can be overriden by kernel argument if necessary.
>>
>> In my experience generic distributions usually don't care about
>> particular boards/devices. They ship a multiplatform kernel using
>> default config that has 64M for CMA and Cedrus doesn't work well with that.
> 
> It still can be overriden using cma= kernel argument.

The point of the DT change is to make system usable out-of-the-box for
casual (non kernel developer) users.

>> BTW, the sunxi_defconfig doesn't specify CMA size at all, so it defaults
>> to 16M.
> 
> That can be easily changed, someone just need to send patch. Historically, 
> from A20 times, default choice for CMA size was 96 MiB. Good choice, and in my 
> opinion also maximum, is 128 MiB. That's enough for 1080p. 256 MiB is really 
> only needed for 4k content, which only H3 and its variants support, from what 
> I can tell.

128M wasn't enough for playing 1080p h265 big_bug_bunny. Practically it
doesn't matter how big CMA area is, as long as it's "shared".

In my experience 256M CMA is a good choice for devices with 1G RAM.
Bigger CMA may cause problems for initrd, depending on a bootlaoder version.

-- 
Best regards,
Dmitry

