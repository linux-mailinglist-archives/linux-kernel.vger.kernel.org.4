Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB3A609FC2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiJXLHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiJXLGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:06:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B12E263E;
        Mon, 24 Oct 2022 04:05:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 532432B;
        Mon, 24 Oct 2022 04:05:52 -0700 (PDT)
Received: from [10.57.36.110] (unknown [10.57.36.110])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D4AD3F7B4;
        Mon, 24 Oct 2022 04:05:43 -0700 (PDT)
Message-ID: <5a8f9934-1959-7962-d575-e3c2f5bc6ade@arm.com>
Date:   Mon, 24 Oct 2022 12:05:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] arm64: dts: rockchip: rk356x: Fix PCIe register map
 and ranges
Content-Language: en-GB
To:     Mark Kettenis <mark.kettenis@xs4all.nl>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     megi@xff.cz, heiko@sntech.de, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        michael.riesch@wolfvision.net, frattaroli.nicolas@gmail.com,
        s.hauer@pengutronix.de, frank-w@public-files.de,
        ezequiel@vanguardiasur.com.ar, yifeng.zhao@rock-chips.com,
        jbx6244@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221005085439.740992-1-megi@xff.cz>
 <CAMdYzYrEXEqOmMeozGBbAAvrujZcOxLh4VYOmu5DSjPWTS-5zQ@mail.gmail.com>
 <20221005220812.4psu6kckej63yo2z@core> <4679102.Wku2Vz74k6@phil>
 <CAMdYzYq3S2rR3Kb61irpV9xHYijNiJY0mkVnJwPrpXzxg_Zh9g@mail.gmail.com>
 <20221021153913.l5ry6v4mcnzcmj2v@core>
 <CAMdYzYpYC6ME_ZYE65UWq__i+rit6_os-+do+JLmEL7y-jKr9g@mail.gmail.com>
 <20221021193248.2he6amnj7knk4biu@core>
 <87edv0sxup.fsf@bloch.sibelius.xs4all.nl>
 <CAMdYzYp6ShLqKxdiAjaRFiRF5i+wzfKiQvwPMzyQLAutWZbApg@mail.gmail.com>
 <875ygbsrf3.fsf@bloch.sibelius.xs4all.nl>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <875ygbsrf3.fsf@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-22 18:24, Mark Kettenis wrote:
>> From: Peter Geis <pgwipeout@gmail.com>
>> Date: Sat, 22 Oct 2022 08:19:57 -0400
> 
> Hello Peter,
> 
>> On Fri, Oct 21, 2022 at 4:52 PM Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>>>
>>>> Date: Fri, 21 Oct 2022 21:32:48 +0200
>>>> From: Ondřej Jirman <megi@xff.cz>
>>>>
>>>> On Fri, Oct 21, 2022 at 12:48:15PM -0400, Peter Geis wrote:
>>>>> On Fri, Oct 21, 2022 at 11:39 AM Ondřej Jirman <megi@xff.cz> wrote:
>>>>>>
>>>>>> On Fri, Oct 21, 2022 at 09:07:50AM -0400, Peter Geis wrote:
>>>>>>> Good Morning Heiko,
>>>>>>>
>>>>>>> Apologies for just getting to this, I'm still in the middle of moving
>>>>>>> and just got my lab set back up.
>>>>>>>
>>>>>>> I've tested this patch series and it leads to the same regression with
>>>>>>> NVMe drives. A loop of md5sum on two identical 4GB random files
>>>>>>> produces the following results:
>>>>>>> d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
>>>>>>> fad97e91da8d4fd554c895cafa89809b  test-rand2.img
>>>>>>> 2d56a7baa05c38535f4c19a2b371f90a  test-rand.img
>>>>>>> 74e8e6f93d7c3dc3ad250e91176f5901  test-rand2.img
>>>>>>> 25cfcfecf4dd529e4e9fbbe2be482053  test-rand.img
>>>>>>> 74e8e6f93d7c3dc3ad250e91176f5901  test-rand2.img
>>>>>>> b9637505bf88ed725f6d03deb7065dab  test-rand.img
>>>>>>> f7437e88d524ea92e097db51dce1c60d  test-rand2.img
>>>>>>>
>>>>>>> Before this patch series:
>>>>>>> d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
>>>>>>> d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
>>>>>>> d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
>>>>>>> d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
>>>>>>> d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
>>>>>>> d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
>>>>>>> d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
>>>>>>> d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
>>>>>>>
>>>>>>> Though I do love where this patch is going and would like to see if it
>>>>>>> can be made to work, in its current form it does not.
>>>>>>
>>>>>> Thanks for the test. Can you please also test v1? Also please share lspci -vvv
>>>>>> of your nvme drive, so that we can see allocated address ranges, etc.
>>>>>
>>>>> Good catch, with your patch as is, the following issue crops up:
>>>>> Region 0: Memory at 300000000 (64-bit, non-prefetchable) [size=16K]
>>>>> Region 2: I/O ports at 1000 [disabled] [size=256]
>>>>>
>>>>> However, with a simple fix, we can get this:
>>>>> Region 0: Memory at 300000000 (64-bit, non-prefetchable) [virtual] [size=16K]
>>>>> Region 2: I/O ports at 1000 [virtual] [size=256]
>>>>>
>>>>> and with it a working NVMe drive.
>>>>>
>>>>> Change the following range:
>>>>> 0x02000000 0x0 0x40000000 0x3 0x00000000 0x0 0x40000000>;
>>>>> to
>>>>> 0x02000000 0x0 0x00000000 0x3 0x00000000 0x0 0x40000000>;
>>>>
>>>> I've already tried this, but this unfrotunately breaks the wifi cards.
>>>> (those only use the I/O space) Maybe because I/O and memory address spaces
>>>> now overlap, I don't know. That's why I used the 1GiB offset for memory
>>>> space.
>>>
>>> Meanwhile, I have an NVMe drive that only works if mmio is completely
>>> untranslated.  This is an ADATA SX8000NP drive, which uses a Silicon
>>> Motion SM2260 controller.
>>>
>>> So for me, a working configuration has the following "ranges":
>>>
>>> ranges = <0x01000000 0x0 0x00000000 0x3 0x3fff0000 0x0 0x00010000>,
>>>           <0x02000000 0x0 0xf4000000 0x0 0xf4000000 0x0 0x02000000>,
>>>           <0x03000000 0x3 0x10000000 0x3 0x10000000 0x0 0x2fff0000>;
>>>
>>> This also needs changes to the "reg" propery:
>>>
>>> reg = <0x3 0xc0000000 0x0 0x00400000>,
>>>        <0x0 0xfe260000 0x0 0x00010000>,
>>>        <0x3 0x00000000 0x0 0x10000000>;
>>
>> Now this is interesting. I've been reading up on PCIe ranges and what
>> is necessary for things to work properly, and I found this interesting
>> article from ARM:
>> https://developer.arm.com/documentation/102337/0000/Programmers-model/Memory-maps/AP-system-memory-map/PCIe-MMIO-and-ECAM-memory-regions
>>
>> TLDR: We need a low region (below 4g) and a high region.
> 
> Well, that description applies to a specific ARM reference design.
> And it appears that the PCIe-RC used in that reference design does not
> support address translation.

Indeed, that's not an "interesting article", it's just documentation for 
some other system that isn't this one. In fact it's a system that 
strictly doesn't even *have* PCIe; the reference designs are not 
complete SoCs, and all that is being described there is the interconnect 
address map for the parts which are in place ready for a customer to 
stitch their choice of PCIe implementation to.

The equivalent for RK3568 is that you *do* have "low" and "high" PCIe 
windows at 0xfx000000 and 0x3xxx00000 respectively in the system 
interconnect address map. How the PCIe controllers choose to relate 
those system MMIO addresses to those to PCI Memory, I/O and Config space 
addresses is another matter entirely.

Robin.
