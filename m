Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A152623D76
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiKJIZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbiKJIZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:25:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB401EEEE;
        Thu, 10 Nov 2022 00:25:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3E7061DCB;
        Thu, 10 Nov 2022 08:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF0FC433C1;
        Thu, 10 Nov 2022 08:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668068753;
        bh=//1Of4vPGHatF3Be5os2F6FZCfBq9FQoStjfPpeDOco=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZBoKSkeQcwCUM/rVT3249YeXYB90uP181eqym7EfGQyFvucZf0M52Rjkwrg2RI99B
         bDYhVX4juY9eyXNxob0rEUs40DNTSpJGpor8GDhTMHF0kJZA5tEvfMz+8vfxHeq39W
         2Kvs7Z14ThbnT6Xa/a6VBY1c+zn8m6qQws1JlbQO4uMCyE8nL9ShT9k4MVOy5cFZQo
         yAaJiYh0S1z1GAlD/hX8Ofl84Z3dZnKs+TWf73pScj6kBdskmPFMm3iO1QYxcc00BC
         kIVPirPiAxSkHev0lQ/p52YwHpe2Vysbc+aMBu/iuQXbO0k3wXMhvf76xINCpD5t0Q
         4AyH8yTuhICGw==
Message-ID: <1126f2ec-10ec-852c-b002-119781b91b58@kernel.org>
Date:   Thu, 10 Nov 2022 09:25:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [Patch v2 1/3] arm: exynos: Add new compatible string for
 Exynos3250 SoC.
To:     Aakarsh Jain <aakarsh.jain@samsung.com>,
        'Krzysztof Kozlowski' <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        stanimir.varbanov@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, smitha.t@samsung.com
References: <CGME20221109034803epcas5p26644fa402ff1837754b61c1a307b2bb8@epcas5p2.samsung.com>
 <20221109035507.69086-1-aakarsh.jain@samsung.com>
 <5741e444-00b3-16f6-d012-f2b77cf8b0b2@linaro.org>
 <001101d8f449$c78f8010$56ae8030$@samsung.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <001101d8f449$c78f8010$56ae8030$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2022 15:44, Aakarsh Jain wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>> Sent: 09 November 2022 14:31
>> To: Aakarsh Jain <aakarsh.jain@samsung.com>; linux-arm-
>> kernel@lists.infradead.org; linux-media@vger.kernel.org; linux-
>> kernel@vger.kernel.org; devicetree@vger.kernel.org
>> Cc: m.szyprowski@samsung.com; andrzej.hajda@intel.com;
>> mchehab@kernel.org; hverkuil-cisco@xs4all.nl;
>> ezequiel@vanguardiasur.com.ar; jernej.skrabec@gmail.com;
>> benjamin.gaignard@collabora.com; krzysztof.kozlowski+dt@linaro.org;
>> stanimir.varbanov@linaro.org; dillon.minfei@gmail.com;
>> david.plowman@raspberrypi.com; mark.rutland@arm.com;
>> robh+dt@kernel.org; krzk+dt@kernel.org; andi@etezian.org;
>> alim.akhtar@samsung.com; aswani.reddy@samsung.com;
>> pankaj.dubey@samsung.com; smitha.t@samsung.com
>> Subject: Re: [Patch v2 1/3] arm: exynos: Add new compatible string for
>> Exynos3250 SoC.
>>
>> On 09/11/2022 04:55, Aakarsh Jain wrote:
>>> Since,MFC v7 support was added for Exynos5420 and Exynos
>>> 3250 SoC with same compatible string "samsung,mfc-v7".As both SoCs
>>> having different hardware properties and having same compatible string
>>> for both SoCs doesn't seems to be correct.
>>> New compatible is added for Exynos3250 SOC which will differentiate
>>> the node properties for both SoCs which support MFC v7.
>>>
>>> Reviewed-by: Tommaso Merciai
>> <tommaso.merciai@amarulasolutions.com>
>>> Suggested-by: Alim Akhtar <alim.akhtar@samsung.com>
>>> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
>>> ---
>>>  Documentation/devicetree/bindings/media/s5p-mfc.txt | 9 +++++----
>>
>> Use subject prefixes matching the subsystem (git log --oneline -- ...).
>>
> As with recent commits on Documentation/devicetree/bindings/media/s5p-mfc.txt with git log --oneline --  ,  subject prefix doesn't seems to be consistent.
> 
> b1394dc151cb media: s5p-mfc: Adding initial support for MFC v10.10
> 60641e22599a [media] s5p-mfc: Use preallocated block allocator always for MFC v6+
> 003611334d55 [media] s5p-mfc: Add support for MFC v8 available in Exynos 5433 SoCs
> 0da658704136 ARM: dts: convert to generic power domain bindings for exynos DT
> 77634289286a ARM: dts: Update clocks entry in MFC binding documentation
> 2eae613b95a7 ARM: EXYNOS: Add MFC device tree support

s5p-mfc is not a subsystem.

git log --oneline  -- Documentation/devicetree/bindings/media/

media: dt-bindings: NAME_OF_FILE:


> 
> Closest is ARM: dts.

This is not ARM subsystem and not a DTS file.

> so what is your suggestion on this?
> 
> Anyway we are in a process of converting this txt file to yaml . 
> 

Best regards,
Krzysztof

