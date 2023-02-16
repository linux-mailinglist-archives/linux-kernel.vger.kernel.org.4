Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CB7699A12
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjBPQct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBPQcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:32:47 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636263BD88;
        Thu, 16 Feb 2023 08:32:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1676565146; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=RE3hY2M1j+lcLp/tsX98y11cg1I1hbDNxkXOopJjof+9TfdXNVGPnr3LpGH9otcElHnz9z0ygZ0K1ayn0/hbU+dJOO4gyYPomEB0rissGLlPzgT5JNGgTBJk7cNLVZGL7MgHVjqnVexUe8e3RGG6W8TMoM8sPY9c2XFUKDf40z0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1676565146; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=9OrrPP4Pzsaq9/1PN/JCMo/GyZLkEfrmoWTdV5kP+yw=; 
        b=f174fVJsDv/uV64R7vGWJP8koZC9yzFoXg8n+O5AAg5VI/CRvC8ghvDEyC/q0cxqw6SvydfjjlVlj1uvHfLy0FTPnkr16EP770+7U9hav0PFpHWeXIsWttBa4UkraapR3gk0syno1vD7ckl6vspKcnTowtafPUcCxCHzez0NZvU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1676565145;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=9OrrPP4Pzsaq9/1PN/JCMo/GyZLkEfrmoWTdV5kP+yw=;
        b=DMBec04GEIhshEHOFDr2LcQWPxn7IFMSWYMHaqc+wpe4WhOluNqerX3+1ChNYF/p
        4pMOi7odLzLPQ9Kt3/pYsqJ2BK/qieqKj77hlu6WHknCVvbpPR2x6uqWnp5tltcGKrI
        nYizgogLrbjnz7dp2d6Vu2W+1PZwhFRIsgC3hW3o=
Received: from [10.10.10.3] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1676565139786160.52083962416282; Thu, 16 Feb 2023 08:32:19 -0800 (PST)
Message-ID: <765313c2-c2d7-9450-aabd-29c471f82ce5@arinc9.com>
Date:   Thu, 16 Feb 2023 19:32:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/2] pinctrl: add mt7981 pinctrl driver
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Jianhui Zhao <zhaojh329@gmail.com>
References: <cover.1674693008.git.daniel@makrotopia.org>
 <ef5112946d16cacc67e65e439ba7b52a9950c1bb.1674693008.git.daniel@makrotopia.org>
 <88ef812b-b8e8-f640-f9f7-a1579ea69d31@arinc9.com>
 <Y+5ZSUURaK/hq1iq@makrotopia.org>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <Y+5ZSUURaK/hq1iq@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.02.2023 19:26, Daniel Golle wrote:
> On Thu, Feb 16, 2023 at 04:50:57PM +0300, Arınç ÜNAL wrote:
>> Hi Daniel,
>>
>> On 26.01.2023 03:34, Daniel Golle wrote:
>>> Add pinctrl driver for the MediaTek MT7981 SoC, based on the driver
>>> which can also be found the SDK.
>>>
>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>>> ---
>>>    drivers/pinctrl/mediatek/Kconfig          |    5 +
>>>    drivers/pinctrl/mediatek/Makefile         |    1 +
>>>    drivers/pinctrl/mediatek/pinctrl-mt7981.c | 1048 +++++++++++++++++++++
>>>    3 files changed, 1054 insertions(+)
>>>    create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt7981.c
>>>
>>> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
>>> index fed02c6fea062..f20c28334bcbf 100644
>>> --- a/drivers/pinctrl/mediatek/Kconfig
>>> +++ b/drivers/pinctrl/mediatek/Kconfig
>>> @@ -127,6 +127,11 @@ config PINCTRL_MT7622
>>>    	default ARM64 && ARCH_MEDIATEK
>>>    	select PINCTRL_MTK_MOORE
>>> +config PINCTRL_MT7981
>>> +	bool "Mediatek MT7981 pin control"
>>> +	depends on OF
>>> +	select PINCTRL_MTK_MOORE
>>> +
>>
>> Is there a reason why you removed these lines from v1?
> 
> Oh, that seemed to have happened by accident. Imho it'd be better
> to have these two lines there as well.

Agreed. I'm preparing some patches to move the pinctrl driver for the 
MediaTek MIPS SoCs here, this driver appears on the menuconfig even 
though it shouldn't. Will you fix this yourself, or I can do it and add 
it to my upcoming patch series.

Arınç
