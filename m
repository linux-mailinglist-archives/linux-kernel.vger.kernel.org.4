Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8234F5FFEBE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 12:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJPKuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 06:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiJPKt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 06:49:58 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DF5F032;
        Sun, 16 Oct 2022 03:49:33 -0700 (PDT)
Message-ID: <701b9128-a15d-9e5c-e1a9-afe7c1426bec@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1665917371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Sv1qw59Ku0GY3oWMLShbeY9jAwijXXVk6qfdGGXaB8=;
        b=kmyOK4TXeXM1stc6mA19YEXHBzNvpnE+YiBR6WzMa7XOBVqy67Hqe9g9U94+LK0NTV+DQb
        dJ3vBA5kvXPkAe7XVVMe2uBhevyu9h0G/OOY4+OZ2cEUZCsXbLGPQMlGFZGitWESQRBZsg
        GxmEpdAXSxlnxohQbRx+xMrycSZR+fyjVMZ7h1fGDaKHLP2v2YtxAaeabKebULfCg1nEdE
        kE5jSS1WPqn33wDVAa8SCUbcUgvHWrh5Y8Tf/IwOFT/tMd1dVr/zwXvfHHeA2iZ+WOj9vk
        gxUVe6Qaga2OxAQ6XeOUv5idoKOd6m1PZsU7cDFSKc+6FUHHKm2iSP3EKsx2YA==
Date:   Sun, 16 Oct 2022 12:49:29 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 00/13] Add support for the Hardkernel ODROID-M1 board
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Dongjin Kim <tobetter@gmail.com>
References: <20220930051246.391614-1-aurelien@aurel32.net>
 <8e84786d-8ae9-0f51-3438-24fb340199c6@manjaro.org>
 <Y0GA92rYss1Wslgr@aurel32.net> <Y0sAXpecR7AVSOBI@aurel32.net>
Content-Language: da-DK
From:   Dan Johansen <strit@manjaro.org>
Organization: Manjaro ARM
In-Reply-To: <Y0sAXpecR7AVSOBI@aurel32.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=strit@manjaro.org smtp.mailfrom=strit@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 15.10.2022 kl. 20.47 skrev Aurelien Jarno:
> On 2022-10-08 15:53, Aurelien Jarno wrote:
>> On 2022-10-08 14:11, Dan Johansen wrote:
>>> Den 30.09.2022 kl. 07.12 skrev Aurelien Jarno:
>>>> On the ODROID forum, Dongjin Kim said he is not planning to submit a new
>>>> version of the patchset adding support for the Hardkernel ODROID-M1
>>>> board. I therefore decided to address the issues reported during the
>>>> initial review, and I also did some small fixes either because some
>>>> things changed in the meantime on the kernel side or because I noticed
>>>> some warning or issues when using the hardware.
>>>>
>>>> I continued writing some additional patches to complete the ODROID M1
>>>> DTS to almost fully support the hardware, the drivers being already
>>>> present in the kernel.
>>>>
>>>> This new version includes feedback from the linux-rockchip mailing list
>>>> and from the Odroid forum.
>>>>
>>>> Changes since v2:
>>>> * Renamed "Rockchip RK3568 Hardkernel ODROID-M1" into "Hardkernel Odroid
>>>>     M1" and fix the sorting.
>>>> * Fix sorting of arch/arm64/boot/dts/rockchip/Makefile
>>>> * Collected Acked-by and Tested-by
>>> Even though I added my Tested-by to this series, it seems I didn't test it
>>> on eMMC.
>>>
>>> This fails to boot for me on eMMC, but works on SD card and NVMe.
>> Thanks for the feedback. I do not have an eMMC, so this the only part
>> from the patchset that I haven't been able to test.
>>
>> First of all, which version have you tested? The v2 includes fixes for
>> the eMMC, there was a conflict with the NOR flash. If the problem is
>> still there in the v2, could you please send the boot log or the error
>> message?
> Sorry I meant v3 above. Anyway in the meantime I have bought an eMMC,
> and I confirm that:
> - it does no work with the v2 due to a conflict with the NOR flash
>    driver
> - it does work with the v3
>
> Therefore can you please retry with the v3?

Just tried with v3 applied and can confirm, that eMMC does work in that. 
Thanks.

So we can re-add my:

Tested-by: Dan Johansen <strit@manjaro.org>

>
> Thanks
> Aurelien
>
-- 
Kind regards
*Dan Johansen*
Project lead of the *Manjaro ARM* project
Manjaro-ARM <https://manjaro.org>
