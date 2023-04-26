Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C124D6EEFA7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239735AbjDZHzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239618AbjDZHzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:55:49 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E53CE74;
        Wed, 26 Apr 2023 00:55:45 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 29180809C;
        Wed, 26 Apr 2023 15:55:43 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 26 Apr
 2023 15:55:43 +0800
Received: from [192.168.125.124] (113.72.145.137) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 26 Apr
 2023 15:55:42 +0800
Message-ID: <a55a9491-20a8-1f4a-200a-a0f1d7ae03bf@starfivetech.com>
Date:   Wed, 26 Apr 2023 15:55:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 4/4] riscv: dts: starfive: add tdm node and sound card
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
References: <20230420024118.22677-1-walker.chen@starfivetech.com>
 <20230420024118.22677-5-walker.chen@starfivetech.com>
 <20230421-dropper-upstage-200ae7e47092@spud>
 <607f3604-056c-6f3a-b154-0f298b870811@starfivetech.com>
 <20230424-roundness-everybody-659599d44963@spud>
 <CAJM55Z9a9N8Zm2cuh8gzZNcYBENO5WE6GmRXOsaYbOcv0srz-Q@mail.gmail.com>
Content-Language: en-US
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <CAJM55Z9a9N8Zm2cuh8gzZNcYBENO5WE6GmRXOsaYbOcv0srz-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.137]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/26 4:57, Emil Renner Berthing wrote:
> On Mon, 24 Apr 2023 at 18:27, Conor Dooley <conor@kernel.org> wrote:
>> On Mon, Apr 24, 2023 at 11:21:11AM +0800, Walker Chen wrote:
>> >
>> >
>> > On 2023/4/22 0:50, Conor Dooley wrote:
>> > > Hey Walker,
>> > >
>> > > On Thu, Apr 20, 2023 at 10:41:18AM +0800, Walker Chen wrote:
>> > >> Add the tdm controller node and sound card for the StarFive JH7110 SoC.
>> > >
>> > > Is this one of these waveshare things + a visionfive 2?
>> > > https://www.waveshare.com/wm8960-audio-hat.htm
>> >
>> > Hey Conor,
>> > I'm glad to receive your comments.
>> >
>> > Now we are using this board + VisionFive2 :
>> > https://wiki.seeedstudio.com/ReSpeaker_2_Mics_Pi_HAT/
>> >
>> > >
>> > > I'm a bit lost as to why this needs a whole new board, should it not
>> > > just be an overlay that you can apply to the existing dts?
>> > >
>> > > Taking this to an extreme, should I expect to see a new devicetree for
>> > > everything RPi hat that you decide to use with a VisionFive 2?
>> >
>> > For your response, I did some thinking. Because wm8960 codec is not integrated
>> >  on the VisionFive2 board, perhaps using overlay is a better way.
>>
>> Aye. I think so too. From my PoV, if this particular seeed audio board
>> is something you're bundling with VisionFive 2 boards on your storefront
>> etc, then I'm fine with taking it as an in-tree overlay.
>> If it is just a "random" RPi hat (that happens to be exactly what you
>> need for testing the audio drivers), then I don't know where to draw a
>> line for what is & what is not acceptable for inclusion.
>>
>> In both cases, it's Emil's call.
> 
> I'm not aware of any shop bundling the VF2 with an audio board. I
> agree: please don't add device trees for combinations of VF2s and
> hats. That should be an overlay.
> 
> /Emil

Since you guys agree, so let's do it this way.
Thanks.

Best regards,
Walker
