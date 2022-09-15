Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8B75B96D9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiIOJBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIOJBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:01:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C596513E13;
        Thu, 15 Sep 2022 02:01:41 -0700 (PDT)
Received: from [192.168.2.145] (unknown [109.252.122.187])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 14A926601DA4;
        Thu, 15 Sep 2022 10:01:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663232500;
        bh=Lg8x2KaZ7hVZZk80CwF+sAIarPY10iBqx4YldrZ0lBQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JClQMzpdHP5zg2xtxTM+w95zpFhhIREXMToaD23kFIwHp1JCmWip+il2XKCaUmZcj
         jWyD4qWzvBj4sGQb8sSsKzR1HKnjiqXlezttVC8ksv85MqZBpgxcJCpKlnO8plI6im
         A5BE7+2yj93Anf2p80UA3eYnrlDSUhYjForHis3jqP9K0RDlLnX8Wi+AnP5GSw6izW
         V9w4mJt1NYi2hJQC7sh2Cqw5Vo56nvpAmCf16oL1Sq7dRV2jvcMt0DJtoTN+FfwM1P
         RvJYem2xKo6dZPWXh0kWc6Gv626UTH5TvKSQDhnBWfUDHAT7O6vCszM7m/khU2kVun
         wOX7Cd/Z67l7g==
Message-ID: <f0e66966-b1c5-f130-54a4-ad63b77e1f26@collabora.com>
Date:   Thu, 15 Sep 2022 12:01:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v1] ARM: dts: sun8i: h3: orangepi-pc: Add CMA reserved
 memory node
Content-Language: en-US
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
References: <20220914151125.212876-1-dmitry.osipenko@collabora.com>
 <CAJiuCcefkre611=1UXEkwScN+bYSBhE_ivGzTK7ZMvp-j4MbRQ@mail.gmail.com>
 <1826631.tdWV9SEqCh@jernej-laptop>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <1826631.tdWV9SEqCh@jernej-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/14/22 21:34, Jernej Škrabec wrote:
> Dne sreda, 14. september 2022 ob 17:33:27 CEST je Clément Péron napisal(a):
>> Hi Dmitry,
>>
>> On Wed, 14 Sept 2022 at 17:12, Dmitry Osipenko
>>
>> <dmitry.osipenko@collabora.com> wrote:
>>> Add 256MB CMA node to the Orange Pi PC board. This fixes memory allocation
>>> failures for Cedrus video decoder on trying to play a 1080p video with
>>> gstreamer.
>>>
>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> ---
>>>
>>>  arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 14 ++++++++++++++
>>>  1 file changed, 14 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
>>> b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts index
>>> b96e015f54ee..e655346a9fb4 100644
>>> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
>>> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
>>> @@ -60,6 +60,20 @@ chosen {
>>>
>>>                 stdout-path = "serial0:115200n8";
>>>         
>>>         };
>>>
>>> +       reserved-memory {
>>> +               #address-cells = <1>;
>>> +               #size-cells = <1>;
>>> +               ranges;
>>> +
>>> +               linux,cma@40000000 {
>>> +                       compatible = "shared-dma-pool";
>>> +                       alloc-ranges = <0x40000000 0x40000000>;
>>> +                       size = <0x10000000>; /* 256MiB */
>>> +                       linux,cma-default;
>>> +                       reusable;
>>> +               };
>>> +       };
>>> +
>>
>> This change seems legit for all H3 boards and could be moved to the H3 dtsi,
>> no?
> 
> That's true. However, there is a reason why this node doesn't exist. One or 
> two H2+ boards (which use H3 dtsi) have only 256 MiB of RAM, so this can't 
> work with them. A few H3 boards have 512 MiB of RAM, so you eat basically half 
> of the RAM with that.

It's a "reusable" CMA, hence it won't be eaten. System is free to use
the reusable CMA. In practice, CMA may get populated with a pinned pages
over time, hence system will work fine, but CMA will get fragmented and
this may cause problems for a larger CMA allocations.

The main problem with 512M boards should be that they may not have a
suitable area for 256M CMA because it should be only either a low or
high part of the memory that might be busy at a boot time, and then
kernel will fail to boot.

> Additionally, contrary to A20 and similar SoCs, which 
> have such node, Cedrus can address whole RAM, so this is not strictly needed. 
> It's better to leave this decision to distribution. Some don't care about 
> Cedrus and some do a lot. Default size can be set via kernel config and it can 
> be overriden by kernel argument if necessary.

In my experience generic distributions usually don't care about
particular boards/devices. They ship a multiplatform kernel using
default config that has 64M for CMA and Cedrus doesn't work well with that.

BTW, the sunxi_defconfig doesn't specify CMA size at all, so it defaults
to 16M.

-- 
Best regards,
Dmitry

