Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B3B69DE43
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 11:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjBUKzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 05:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbjBUKzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 05:55:00 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E54522DD9;
        Tue, 21 Feb 2023 02:54:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1676976888; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=KjPMeoyqZu4ErEypKV+XJEq7SuWGgDzzP8XEsMvJlnjUl5PgSP8+YeXekiswzGaK1pKuJt1TqndiJ8OMwTf37dE2B4tK8N1LbVrR12PpuRTe/e99AbOyCJZMDAK45sVpiKNpKE4OBxhIU03RZ4TgU8cRo6ZAdTmOY0kH0EixsXo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1676976888; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=+kAe8bhUK7GfO+tPODkq1rfj3mCfxHEC3ZKDGaPAiLk=; 
        b=j0in2oaFknUWsrI5/CV/nx7NQ8z5ipesvl2mV5n+Gpx5OXzkHZ4YaFlChTeCkFL5/jTuNUkP+SxCXzFJMBWI2y0e5/GTofVlMhimkNwQJofElC/v2fSXpnj5FJrQUVoMbeR+yqO5qyNu40pODUFmjNSuL9FfpIJ6XJCFZNeL8x4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1676976888;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=+kAe8bhUK7GfO+tPODkq1rfj3mCfxHEC3ZKDGaPAiLk=;
        b=IhdUcjKEHHREgfODat6WKVHP8Ibx8hW9c52OifGmJ4mnA+gfpYq8bkB3Qg1mEVKp
        BwZP3VTiEgHGKiKdDJ8uroki5eQ8zVsN9/ueCaRqMUXvzLgPqjeZBfna5X1SyXxCfG1
        D4QqZUX1vh+xPFdMVkQmyvT574CFPDd4ocYxIOYI=
Received: from [10.10.10.3] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1676976886766984.3835080966479; Tue, 21 Feb 2023 02:54:46 -0800 (PST)
Message-ID: <03ae6aab-1492-f8df-2432-cfca52a44131@arinc9.com>
Date:   Tue, 21 Feb 2023 13:54:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] mips: ralink: make SOC_MT7621 select PINCTRL
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, erkin.bozoglu@xeront.com
References: <20230221092435.22069-1-arinc.unal@arinc9.com>
 <20230221092435.22069-2-arinc.unal@arinc9.com>
 <CAMhs-H9qLw6uhjPnFWovQBMFe38y95Q_VvG8Bj9wovSR+1J_2g@mail.gmail.com>
 <85a39e81-51a3-e90f-622e-f2cc7528aa92@arinc9.com>
 <CAMhs-H_eLwxjA7-EKGSyKOZLQF05N-FNASZWtGgsV2S=txU=yQ@mail.gmail.com>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <CAMhs-H_eLwxjA7-EKGSyKOZLQF05N-FNASZWtGgsV2S=txU=yQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.02.2023 13:21, Sergio Paracuellos wrote:
> On Tue, Feb 21, 2023 at 11:09 AM Arınç ÜNAL <arinc.unal@arinc9.com> wrote:
>>
>> On 21.02.2023 12:38, Sergio Paracuellos wrote:
>>> Hi Arınç,
>>>
>>> On Tue, Feb 21, 2023 at 10:24 AM <arinc9.unal@gmail.com> wrote:
>>>>
>>>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>>>
>>>> Currently, out of every Ralink SoC, only the dt-binding of the MT7621 SoC
>>>> uses pinctrl. Because of this, PINCTRL is not selected at all. Make
>>>> SOC_MT7621 select PINCTRL.
>>>>
>>>> Remove PINCTRL_MT7621, enabling it for the MT7621 SoC will be handled under
>>>> the PINCTRL_MT7621 option.
>>>>
>>>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>>>> ---
>>>>    arch/mips/ralink/Kconfig | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
>>>> index 06031796c87b..83e61e147b90 100644
>>>> --- a/arch/mips/ralink/Kconfig
>>>> +++ b/arch/mips/ralink/Kconfig
>>>> @@ -54,7 +54,7 @@ choice
>>>>                   select HAVE_PCI
>>>>                   select PCI_DRIVERS_GENERIC
>>>>                   select SOC_BUS
>>>> -               select PINCTRL_MT7621
>>>> +               select PINCTRL
>>>>
>>>>                   help
>>>>                     The MT7621 system-on-a-chip includes an 880 MHz MIPS1004Kc
>>>> --
>>>> 2.37.2
>>>>
>>>
>>> Which git tree are you working against? CONFIG_SOC_MT7621 is not
>>> selecting PINCTRL_MT7621 at all in v6.2 [0]. I think it should select
>>
>> mips/linux.git mips-next tree.
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/log/
> 
> I see :). Thanks!
> 
>>
>>> 'PINCTRL_MT7621' and the 'select PINCTRL' stuff added inside the
>>> PINCTRL_RALINK option in [1].
>>
>> I'm working on that, although not exactly the way you describe here, on
>> this branch of mine.
> 
> So, in which way do you get PINCTRL_MT7621 automatically selected for
> this SoC now? I think looking into the Kconfig for ralink pinctrl [0]
> all of them at the end need the missing PINCTRL option to be added and
> all of them are currently selecting PINCTRL_RALINK . Hence just adding
> the PINCTRL option inside PINCTRL_RALINK looks convenient.

PINCTRL_RALINK won't appear on the menuconfig unless PINCTRL is enabled. 
So this'd be pointless.

 From what I see on other MIPS and ARM platforms, PINCTRL is supposed to 
be enabled at the platform option, like CONFIG_RALINK. However, the 
Ralink SoCs except MT7621, or rather the DTs for them, do not use the 
pinctrl driver so I only enable it for MT7621, and keep it optional for 
the remaining SoCs.

MediaTek pinctrl kconfig enables the pinctrl driver specific to the SoC 
by default, if the said SoC is enabled. I'm keeping this method when 
moving ralink pinctrl to mediatek with the series below.

So once the pinctrl driver is defined on the DTs for the remaining SoCs, 
we can just put PINCTRL under CONFIG_RALINK and everything will work fine.

> 
>>
>> https://github.com/arinc9/linux/commits/ralink-pinctrl
> 
> Wow! Tons of changes here ;-). Keep going!!

Thanks a lot, I've started to refactor everything Ralink. With this 
series, I finalise the work on pinctrl.

Arınç
