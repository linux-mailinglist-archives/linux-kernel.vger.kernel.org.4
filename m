Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B331702CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241902AbjEOMlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241510AbjEOMja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:39:30 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98B0210E;
        Mon, 15 May 2023 05:36:39 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id EEBD224DC7D;
        Mon, 15 May 2023 20:36:32 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 15 May
 2023 20:36:33 +0800
Received: from [192.168.125.124] (113.72.146.187) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 15 May
 2023 20:36:32 +0800
Message-ID: <29a30bab-1736-5a57-7bdf-3282d90a6a57@starfivetech.com>
Date:   Mon, 15 May 2023 20:36:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 3/3] riscv: dts: starfive: add the node and pins
 configuration for tdm
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20230511091549.28003-1-walker.chen@starfivetech.com>
 <20230511091549.28003-4-walker.chen@starfivetech.com>
 <cd7803a2-38a0-c498-467f-1ef802645527@starfivetech.com>
 <20230515-dragonish-diffuser-48a1c6f4c8ae@wendy>
Content-Language: en-US
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <20230515-dragonish-diffuser-48a1c6f4c8ae@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.146.187]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/15 16:58, Conor Dooley wrote:
> On Mon, May 15, 2023 at 04:44:54PM +0800, Walker Chen wrote:
> 
>> Hi Conor / Emil,
>> 
>> Based on our discussion a few days ago, the new version of patch for dts looks like this,
>> Please help to review and provide your comments if you feel free.
> 
>> On 2023/5/11 17:15, Walker Chen wrote:
> 
> It's only been 4 days chief, of which 2 were the weekend, you don't need
> to bump it yet! You'd be better off asking one of your co-workers to
> review the content, instead of me. I'll happily apply the patch, with
> appropriate review, once the dt-binding has been applied by Mark. I do
> not have the capacity to review the detail of individual patches adding
> peripherals unfortunately.
> Getting your co-workers to look at your patches, and doing the same for
> theirs, is almost always a good idea for speeding up the process

Oh, Conor, perhaps I was too eager to finish the work quickly. Sorry for that!
Maybe I need to ask my co-worker to review firstly as you said.

Best regards,
Walker
