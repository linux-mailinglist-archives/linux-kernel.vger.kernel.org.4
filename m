Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A9F70DB46
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjEWLNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEWLNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:13:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9594DC4;
        Tue, 23 May 2023 04:13:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F1F5139F;
        Tue, 23 May 2023 04:14:16 -0700 (PDT)
Received: from [10.57.84.70] (unknown [10.57.84.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61F1D3F6C4;
        Tue, 23 May 2023 04:13:29 -0700 (PDT)
Message-ID: <b404dc20-c460-ac3f-6659-8be7a7d32bfe@arm.com>
Date:   Tue, 23 May 2023 12:13:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RESEND 0/2] media: rockchip: rga: Add rk3568 support
Content-Language: en-GB
To:     Michael Tretter <m.tretter@pengutronix.de>,
        Diederik de Haas <didi.debian@cknow.org>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230119-rk3568-rga-v1-0-43d4d14365e6@pengutronix.de>
 <168466589373.900480.8086350880534437090.b4-ty@sntech.de>
 <2386524.2IynHR6iFi@prancing-pony> <20230522102953.GB23678@pengutronix.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230522102953.GB23678@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-22 11:29, Michael Tretter wrote:
> On Sun, 21 May 2023 21:32:51 +0200, Diederik de Haas wrote:
>> On Sunday, 21 May 2023 12:44:58 CEST Heiko Stuebner wrote:
>>> On Fri, 20 Jan 2023 10:14:21 +0100, Michael Tretter wrote:
>>>> The RGA2 on the Rockchip rk3568 is the same core as the RGA2 on the
>>>> Rockchip rk3288.
>>>>
>>>> This series adds the necessary device tree binding and node in the device
>>>> tree to enable the RGA2 on the Rockchip rk3568.
>>>>
>>>> I tested the driver with the GStreamer v4l2convert element on a Rock3
>>>> Model A board.
>>>>
>>>> [...]
>>>
>>> Applied, thanks!
>>>
>>> [1/2] media: dt-bindings: media: rockchip-rga: add rockchip,rk3568-rga
>>>        commit: 9b12ceb5a80d1fb45d293265de100e33b5843943
>>> [2/2] arm64: dts: rockchip: Add RGA2 support to rk356x
>>>        commit: 0c3391f8bb06b744df521651534cd99e3d77e0a8
>>
>> https://lore.kernel.org/all/TY3P286MB26115F60D273E840D36A610598CA9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM/
>>
>> indicated that there was a problem with device >= 4GB (RAM?):
>>> Since we have the over-4GB problem now, should we mark this problem as a
>>> TODO or something?
>>
>> I thought that was the reason that these patches weren't picked up before?
> 
> That's what I thought, too.
> 
>>
>> I have no insight into this problem, so I can't comment on the technical
>> aspects, but I had made a note for myself 'locally' about it.
> 
> Using the RGA2 with the driver in its current form on devices with more than 4
> GB system memory may lead to memory corruption as buffer addresses are
> silently truncated to 32 bits.

That's because the driver is completely broken and is not using the DMA 
API anywhere near properly. The fact that it's been getting away with it 
so far can be mostly put down to good luck and nobody using 
CONFIG_DMA_API_DEBUG.

> I'm not sure if that's actually a blocker for merging these patches.

If anything, hopefully getting more SoC support merged might provide 
more motivation for someone to fix the existing code :)

Robin.
