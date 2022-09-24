Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F3C5E8BEF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 13:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbiIXLzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 07:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiIXLzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 07:55:15 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E3E2251B;
        Sat, 24 Sep 2022 04:55:13 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id hy2so5448962ejc.8;
        Sat, 24 Sep 2022 04:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=F98fTUaqz/xgAnbNOjVz2gYVeA9O9kAzBF55v8LQ+9U=;
        b=PuDVLGVns39/bq1zoea1OIaiY/wKkRFJ5R96SLuxh40U9n+/AzFSKB7qeM8akTEXke
         3ZH5Z4NWpkcYsd4u0QdobmSJ8VXRB6/6ddFX5Y57D+VkRkyqDuIDsclrlmzB1EcGeA1U
         +1r9RLXvmTujAABLGG6vinBnprZPv27Y+fSlf7xjz4Ku4gnlzZ2DsFb9nS5Kp5swBB/s
         2XVgSQS/V8w1obJ7FFWFcXFvzBT/EvYbfI25QePU5mTNVWLlemuiTYTe9txAsN+cuVKB
         qhqbGKL90kWp1za33LjaJDvJvtuueIQsz1fjCl8Dc8wb/io6SpKylKIhcw0meLEVjKf8
         DnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=F98fTUaqz/xgAnbNOjVz2gYVeA9O9kAzBF55v8LQ+9U=;
        b=j9ds+AnIB1EWFfTDvLfJt4sKrP05ght1TiD5wMDVTtrtikoJwjMhCwCP/0RaLB/hBa
         tJoV2ReNOPRTWBSTNMo1A3gLQsEvFcizPWawM6MTq8f8K9Kl9m7BBT9J/rHUe5pNzto5
         s6/cEB/lcngMtURga09j3HNT8slS2Fpj8qSBlFUzuCpbSCan7wxAFOW5cZlugadgHpd0
         vGIBenYYGEj9jBIQsqJLCnduK/ZdNUh62QHScOM4nTWBofoz2itODHDc53H+cUfzH/vn
         WyUMbIGecZIraoHUR+VHGIzdRhM02N+hlngtu+4dVK6+VqRKLZaepjeaWj9kQEcuCpaN
         J5/w==
X-Gm-Message-State: ACrzQf1fnn0FINARXfpO767JRrYKtlYya9ceJ2pQTmkN62oQfaVe14aP
        kc0aS6z2BWyrFEuofnqJUuA=
X-Google-Smtp-Source: AMsMyM57L1MEFFetdqgTUmhOiUhQGK8B7QJ8BqsD2Xz0+ku2Q0dd0cXvixPefwbTeccTFMezEaybeQ==
X-Received: by 2002:a17:907:9807:b0:781:feee:f87c with SMTP id ji7-20020a170907980700b00781feeef87cmr10818222ejc.101.1664020511427;
        Sat, 24 Sep 2022 04:55:11 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:3929:d307:8379:1a1e? (2a02-a466-68ed-1-3929-d307-8379-1a1e.fixed6.kpn.net. [2a02:a466:68ed:1:3929:d307:8379:1a1e])
        by smtp.gmail.com with ESMTPSA id w8-20020a17090652c800b00780ab5a9116sm5388708ejn.211.2022.09.24.04.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Sep 2022 04:55:11 -0700 (PDT)
Message-ID: <f9e859f5-102f-c18a-ed83-ff83d223e410@gmail.com>
Date:   Sat, 24 Sep 2022 13:55:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4] usb: dwc3: Don't switch OTG -> peripheral if extcon is
 present
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <thinhn@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Sven Peter <sven@svenpeter.dev>
References: <20220403164907.662860-1-andrew.smirnov@gmail.com>
 <Yyw0K/hcTZ02UP+A@smile.fi.intel.com>
 <691c3073-5105-9a2b-e6f2-ea0a4b8aaea8@gmail.com>
 <CAHQ1cqGFFJ0gRbdN+DH0iJhcKc=eee8uNoDyfHEy00-CMgstiw@mail.gmail.com>
 <Yy3iAHLlS2emAmWn@smile.fi.intel.com>
 <CAHQ1cqHWZeVHp6QmsDw5bjVq=nknRVG5iETB0n4fMMLWginbLg@mail.gmail.com>
 <Yy4A7W9y4eeHOvco@smile.fi.intel.com>
 <CAHQ1cqG8KfZAFwvjkn1f+aKrOkPNKW=NJo-rz-Zqp+WFZLoF4g@mail.gmail.com>
Content-Language: en-US
From:   Ferry Toth <fntoth@gmail.com>
In-Reply-To: <CAHQ1cqG8KfZAFwvjkn1f+aKrOkPNKW=NJo-rz-Zqp+WFZLoF4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Op 24-09-2022 om 03:27 schreef Andrey Smirnov:
> On Fri, Sep 23, 2022 at 11:54 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
>> On Fri, Sep 23, 2022 at 11:23:23AM -0700, Andrey Smirnov wrote:
>>> On Fri, Sep 23, 2022 at 9:42 AM Andy Shevchenko
>>> <andriy.shevchenko@intel.com> wrote:
>>>> On Thu, Sep 22, 2022 at 04:32:55PM -0700, Andrey Smirnov wrote:
>>>>> On Thu, Sep 22, 2022 at 3:23 AM Ferry Toth <fntoth@gmail.com> wrote:
>>>>>> On 22-09-2022 12:08, Andy Shevchenko wrote:
>>>>>> On Sun, Apr 03, 2022 at 09:49:07AM -0700, Andrey Smirnov wrote:
>>>> FYI: For now I sent a revert, but if we got a solution quicker we always
>>>> can choose the course of actions.
>>> I think we have another problem. This patch happened in parallel to mine
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.0-rc6&id=ab7aa2866d295438dc60522f85c5421c6b4f1507
>>>
>>> so my changes didn't have that fix in mind and I think your revert
>>> will not preserve that fix. Can you update your revert to take care of
>>> that too, please?
>>>
>>> I'm really confused how the above commit could be followed up by:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb/dwc3/drd.c?h=v6.0-rc6&id=0f01017191384e3962fa31520a9fd9846c3d352f
>>>
>>> the diffs in dwc3_drd_init seem contradictory
>> I'm not sure I follow. Your patch has been merged and after that some kind of
>> merge conflict was resolved by an additional change. To revert your stuff
>> cleanly we need to revert the merge update patch first. That's why revert is a
>> series of patches and not a single one. I have no idea how above mentioned
>> commit at all related to all this.
>>
>> Can you elaborate more, please?
>>
> It's not important to clarify, just me voicing my confusion, we have
> way too many threads of discussion already.
>
>>>>>> If the extcon device exists, get the mode from the extcon device. If
>>>>>> the controller is DRD and the driver is unable to determine the mode,
>>>>>> only then default the dr_mode to USB_DR_MODE_PERIPHERAL.
>>>>>>
>>>>>> According to Ferry (Cc'ed) this broke Intel Merrifield platform. Ferry, can you
>>>>>> share bisect log?
>>>>>>
>>>>>> I can but not right now. But what I did was bisect between 5.18.0 (good) and 5.19.0 (bad) then when I got near the culprit (~20 remaining) based on the commit message I tried 0f01017191384e3962fa31520a9fd9846c3d352f "usb: dwc3: Don't switch OTG -> peripheral if extcon is present" (bad) and commit before that (good).
>>>>>>
>>>>>> The effect of the patch is that on Merrifield (I tested with Intel Edison Arduino board which has a HW switch to select between host and device mode) device mode works but in host mode USB is completely not working.
>>>>>>
>>>>>> Currently on host mode - when working - superfluous error messages from tusb1210 appear. When host mode is not working there are no tusb1210 messages in the logs / on the console at all. Seemingly tusb1210 is not probed, which points in the direction of a relation to extcon.
>>>>>>
>>>>>> Taking into account the late cycle, I would like to revert the change. And
>>>>>> Ferry and I would help to test any other (non-regressive) approach).
>>>>>>
>>>>>> I have not yet tested if a simple revert fixes the problem but will tonight.
>>>>>>
>>>>>> I would be happy to test other approaches too.
>>>>> It's a bit hard for me to suggest an alternative approach without
>>>>> knowing how things are breaking in this case. I'd love to order one of
>>>>> those boards to repro and fix this on my end, but it looks like this
>>>>> HW is EOLed and out of stock in most places. If you guys know how to
>>>>> get my hands on those boards I'm all ears.
>>>> There are still some second hand Intel Edison boards flying around
>>>> (but maybe cost a bit more than expected) and there are also
>>>> Dell Venue 7 3740 tablets based on the same platform/SoC. The latter
>>>> option though requires more actions in order something to be boot
>>>> there.
>>> OK, I'll check e-bay just in case.
>>>
>>>> In any case, it's probably quicker to ask Ferry or me for testing.
>>>> (Although currently I have no access to the board to test OTG, it's
>>>>   remote device which I can only power on and off and it has always
>>>>   be in host mode.)
>>>>
>>>>> Barring that, Ferry can you dig more into this failure? E.g. is it this hunk
>>>>>
>>>>> @@ -85,7 +86,7 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
>>>>>                   * mode. If the controller supports DRD but the dr_mode is not
>>>>>                   * specified or set to OTG, then set the mode to peripheral.
>>>>>                   */
>>>>> -               if (mode == USB_DR_MODE_OTG &&
>>>>> +               if (mode == USB_DR_MODE_OTG && !dwc->edev &&
>>>>>                      (!IS_ENABLED(CONFIG_USB_ROLE_SWITCH) ||
>>>>>                       !device_property_read_bool(dwc->dev, "usb-role-switch")) &&
>>>>>                      !DWC3_VER_IS_PRIOR(DWC3, 330A))
>>>>> @@ -1632,6 +1633,51 @@ static void dwc3_check_params(struct dwc3 *dwc)
>>>>>          }
>>>>>   }
>>>>>
>>>>> that's problematic or moving
>>>> I think you wanted to revert only this line and test?
>>> Yes.
>> Ferry, can you try that (but I believe it won't help anyway, because I don't
>> see how we handle deferred probe).
>>
>>>>>   static int dwc3_probe(struct platform_device *pdev)
>>>>>   {
>>>>>          struct device           *dev = &pdev->dev;
>>>>> @@ -1744,6 +1790,13 @@ static int dwc3_probe(struct platform_device *pdev)
>>>>>                  goto err2;
>>>>>          }
>>>>>
>>>>> +       dwc->edev = dwc3_get_extcon(dwc);
>>>>> +       if (IS_ERR(dwc->edev)) {
>>>>> +               ret = PTR_ERR(dwc->edev);
>>>>> +               dev_err_probe(dwc->dev, ret, "failed to get extcon\n");
>>>>> +               goto err3;
>>>>> +       }
>>>>> +
>>>>>          ret = dwc3_get_dr_mode(dwc);
>>>>>          if (ret)
>>>>>                  goto err3;
>>>>>
>>>>> to happen earlier?
>>>> It is not always possible to have an extcon driver available, that's why in
>>>> some cases the probe of it defers. I dunno how your patch supposed to work
>>>> in that case.
>>> I'm not sure I understand what you mean. AFAIU the logic is that if
>>> the platform specifies the presence of extcon either via DT or, like
>>> Merrifield, via and explicit "linux,extcon-name" device property in
>>> the code then extcon is a mandatory component of the DRD stack and the
>>> driver is expected to be present for the whole thing to work.
>>> I don't
>>> think I really changed that logic with my patch, even after the revert
>>> dwc3_get_extcon() will be called as a part of a probing codepath,
>> But it's not true as proved by the experiment. So with your patch it doesn't
>> work anymore, so the logic _is_ changed.
>>
> I think you are jumping the gun here. We know that the patch breaks
> USB host functionality on Merrifield. We know that "Seemingly tusb1210
> is not probed". Do we know that dwc3.ko (I think that'd be the
> driver's name) is not probed? Did Ferry share that info with you in
> some other thread? I don't deny it is possible, but I don't think this
> is really clear at this moment to say definitively.

I am not sure. I have dwc3 builtin. And intel_soc_pmic_mrfld and 
extcon-intel-mrfld as a module.

But with the USB host broken this returns nothing:

root@yuna:~# journalctl -k -b -0 | grep -i dwc

While with the 2 reverts (and host working):

root@yuna:~# journalctl -k -b -1 | grep -i dwc
Sep 22 22:57:38 yuna kernel: tusb1210 dwc3.0.auto.ulpi: GPIO lookup for 
consumer reset
...

Sep 22 22:57:38 yuna kernel: debugfs: Directory 'dwc3.0.auto' with 
parent 'ulpi' already present!
...

Sep 22 22:57:39 yuna kernel: tusb1210 dwc3.0.auto.ulpi: error -110 
writing val 0x41 to reg 0x80

Like I mentioned before, when host works I get warnings and errors on 
the console as well as in the logs.

I also get this one, but believe that is related to another problem, 
something in hub.c. Which happens when the host works as a hub is plugin 
there.

Sep 22 22:57:39 yuna kernel: DMA-API: dwc3 dwc3.0.auto: cacheline 
tracking EEXIST, overlapping mappings aren't supported

>>>        so
>>> if the a missing driver is causing a probe deferral it should still be
>>> happening, unless I missed something.
>> The merge fix removes deferred probe by some reason.
>>
>>>>> Does tracing the "mrfld_bcove_pwrsrc" driver (the
>>>>> excton provider in this case AFIACT) show anything interesting?
>>>> I believe there is nothing interesting.
>> --
>> With Best Regards,
>> Andy Shevchenko
>>
>>
