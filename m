Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842A46EE5A0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbjDYQVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbjDYQVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:21:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C26C92684;
        Tue, 25 Apr 2023 09:21:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E2F24B3;
        Tue, 25 Apr 2023 09:22:19 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD31A3F587;
        Tue, 25 Apr 2023 09:21:31 -0700 (PDT)
Message-ID: <45bc13a8-1442-2dd3-b9ea-1ed2f5962bac@arm.com>
Date:   Tue, 25 Apr 2023 17:21:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
Content-Language: en-GB
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Santiago Esteban <Santiago.Esteban@microchip.com>,
        Cristian Birsan <Cristian.Birsan@microchip.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-actions@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-omap@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@axis.com, linux-aspeed@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel@dh-electronics.com, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org,
        linux-oxnas@groups.io, linux-arm-msm@vger.kernel.org,
        linux-unisoc@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-realtek-soc@lists.infradead.org
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <CAFr9PXkgrRe-=E=GhNnZ4w1x_FMb97-_RmX6ND1vEd74_TbZSw@mail.gmail.com>
 <4ff4f171-c5f8-87af-aad1-5e7686292288@microchip.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <4ff4f171-c5f8-87af-aad1-5e7686292288@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2022 9:50 am, Nicolas Ferre wrote:
> Ansuel, All,
> 
> On 28/03/2022 at 10:55, Daniel Palmer wrote:
>> Hi Ansuel
>>
>> On Mon, 28 Mar 2022 at 09:09, Ansuel Smith <ansuelsmth@gmail.com> wrote:
>>>
>>> Hi,
>>> as the title say, the intention of this ""series"" is to finally 
>>> categorize
>>> the ARM dts directory in subdirectory for each oem.
>>
>> While I agree with this change and think it's for the good (browsing
>> the ARM dts directory at the moment is frustrating..) I think
>> buildroot and others need to be told about this as it'll potentially
>> break their kernel build scripting for ARM and probably messes up the
>> configs they have for existing boards.
> 
> This aspect mustn't be underestimated and I anticipate lots of issues 
> during a long time on this particular topic of "build systems".
> 
> Another aspect is CI and public or private testing farms we all have 
> running.

Yet another is if this affects what `make dtbs_install` does (I don't 
know for sure, but I'd be inclined to suspect it might). Some distros 
use that to deliver the DTBs as part of their kernel package, so if 
paths suddenly change it could break end users' bootloader setups too.

Thanks,
Robin.

> These aspects always refrained me to change anything in the naming 
> scheme of our DT files, but if we go in this direction, we must really 
> be prepared and I'm still not convince it's worth it...
> 
> 
> If this has to happen, I would also like to queue some file name changes 
> to do all modifications in one go in order to lower the annoyance level 
> of those who would need to adapt to those changes.
> 
> BTW, is there a common scheme for dts/dtsi file naming? Is it more 
> enforced in one way or another for arm64 in a sense that I can take some 
> norm as an example?
> 
> [..]
> 
> Best regards,
>    Nicolas
> 
> 
> 
