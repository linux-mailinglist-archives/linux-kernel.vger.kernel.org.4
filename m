Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706B46EC3E6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 05:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDXDVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 23:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDXDVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 23:21:19 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E534CE48;
        Sun, 23 Apr 2023 20:21:15 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 1951B807B;
        Mon, 24 Apr 2023 11:21:13 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 24 Apr
 2023 11:21:13 +0800
Received: from [192.168.125.124] (113.72.145.137) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 24 Apr
 2023 11:21:12 +0800
Message-ID: <607f3604-056c-6f3a-b154-0f298b870811@starfivetech.com>
Date:   Mon, 24 Apr 2023 11:21:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 4/4] riscv: dts: starfive: add tdm node and sound card
To:     Conor Dooley <conor@kernel.org>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
References: <20230420024118.22677-1-walker.chen@starfivetech.com>
 <20230420024118.22677-5-walker.chen@starfivetech.com>
 <20230421-dropper-upstage-200ae7e47092@spud>
Content-Language: en-US
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <20230421-dropper-upstage-200ae7e47092@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.137]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/22 0:50, Conor Dooley wrote:
> Hey Walker,
> 
> On Thu, Apr 20, 2023 at 10:41:18AM +0800, Walker Chen wrote:
>> Add the tdm controller node and sound card for the StarFive JH7110 SoC.
> 
> Is this one of these waveshare things + a visionfive 2?
> https://www.waveshare.com/wm8960-audio-hat.htm

Hey Conor,
I'm glad to receive your comments.

Now we are using this board + VisionFive2 :
https://wiki.seeedstudio.com/ReSpeaker_2_Mics_Pi_HAT/

> 
> I'm a bit lost as to why this needs a whole new board, should it not
> just be an overlay that you can apply to the existing dts?
> 
> Taking this to an extreme, should I expect to see a new devicetree for
> everything RPi hat that you decide to use with a VisionFive 2?

For your response, I did some thinking. Because wm8960 codec is not integrated
 on the VisionFive2 board, perhaps using overlay is a better way.

> 
> Also, it'd be nice to provide a Link: to where someone can find more
> info on this combination of items. Google for "wm8960 visionfive 2"
> gives me nothing, nor does "starfive audio card" etc.
> 
> Thanks,
> Conor.
> 
>> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
>> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
>> ---

Best regards,
Walker



