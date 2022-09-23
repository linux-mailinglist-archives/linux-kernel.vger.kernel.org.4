Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B9F5E82E8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 22:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiIWUK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 16:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiIWUKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 16:10:25 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFFFA50FF;
        Fri, 23 Sep 2022 13:10:23 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z13so1584735edb.13;
        Fri, 23 Sep 2022 13:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Rife9CbrAXGV4TDzGx5xu7cA82JicPZAdeC3DcB6lPs=;
        b=AhqApkQ5zfxpVJjpNRBSlzy33N57WtIiBKbGxw10B/wApWm5YdLxIUI3kAcyXj4Ikl
         ghDGeIp0pCi3RzzbK8axBFjlITyQfazv4mBc6AlPfY+j20OHcEndhvqRhgl3etBQItrW
         C+7YaQfkm3PYKwFz34EZXK0IXWOLet58tDSbC8n+5cZG8vKjEbkWKeEEKLxvDSojNHRj
         z6ajDshnU4mwm2g+h87sqGC//KIHjGkPHugEkN5fMBlRcXv4mdgi1WMN5qLS+Nw44FSp
         Kqwzl/nn4m06ggLcV3lL/1wN+ryfN9e+N1Z5Z9LTNkBslhxul2Q/O76/VWINxdnYdMPt
         U3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Rife9CbrAXGV4TDzGx5xu7cA82JicPZAdeC3DcB6lPs=;
        b=wmKcpIWJil9iFrqgg4noOlQZUCBtTmunpxLYx6sy4UHO+QkJc2219V5LFlxFdagAhI
         J+CnFZNCf3DjVMtfwXQBCEUqXZoUmgCdPY1IRflJD5IPbnPsHlBT6Fc4i6o+lwqKXy9I
         BsW00geeGMMUzfWZR9rSwsSZvFiYNd7/NW097m1tcl+uJIvObPbzq5AqfIu2h1xjnkAb
         HOVFvajZfiLJ1/ADklWn3dh2dXeDaYd1sloX6/2kM8QVItDOMO6L18Xug5Jp/Bs1l1GN
         XbTj04KiQ1nKo3XZPb5GkoEY9LSVrthOAwzpS/8fkKWWqOvs0wQWhjnlB0EvO2Cvbx4q
         eqXw==
X-Gm-Message-State: ACrzQf1Vr8uPzdHRS/M1F526eJAwpVUAdiUFfBLFABXLR9IPegK2oprp
        aS6lwkohNDjQjlv6E+jCafE=
X-Google-Smtp-Source: AMsMyM5Yev9XAvMzm4d6u0rO65VSKmQw7C+XPd3zSx9d6JqmdPCM2PdbOmcTZWn/vwZcG6HhVFTpCg==
X-Received: by 2002:a05:6402:5409:b0:44f:1e05:1e8 with SMTP id ev9-20020a056402540900b0044f1e0501e8mr10192649edb.373.1663963821894;
        Fri, 23 Sep 2022 13:10:21 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:316d:c3e0:552f:ad5a? (2a02-a466-68ed-1-316d-c3e0-552f-ad5a.fixed6.kpn.net. [2a02:a466:68ed:1:316d:c3e0:552f:ad5a])
        by smtp.gmail.com with ESMTPSA id f19-20020a056402195300b004531b137e4bsm6200153edz.67.2022.09.23.13.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 13:10:21 -0700 (PDT)
Message-ID: <e1b8f8f0-69db-b1eb-f542-54f700a42a38@gmail.com>
Date:   Fri, 23 Sep 2022 22:10:19 +0200
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
Content-Language: en-US
From:   Ferry Toth <fntoth@gmail.com>
In-Reply-To: <CAHQ1cqHWZeVHp6QmsDw5bjVq=nknRVG5iETB0n4fMMLWginbLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Op 23-09-2022 om 20:23 schreef Andrey Smirnov:
> On Fri, Sep 23, 2022 at 9:42 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
>>
>> On Thu, Sep 22, 2022 at 04:32:55PM -0700, Andrey Smirnov wrote:
>>> On Thu, Sep 22, 2022 at 3:23 AM Ferry Toth <fntoth@gmail.com> wrote:
>>>> On 22-09-2022 12:08, Andy Shevchenko wrote:
>>>> On Sun, Apr 03, 2022 at 09:49:07AM -0700, Andrey Smirnov wrote:
>>
>> FYI: For now I sent a revert, but if we got a solution quicker we always
>> can choose the course of actions.
>>
> 
> I think we have another problem. This patch happened in parallel to mine
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.0-rc6&id=ab7aa2866d295438dc60522f85c5421c6b4f1507
> 
> so my changes didn't have that fix in mind and I think your revert
> will not preserve that fix. Can you update your revert to take care of
> that too, please?
> 
> I'm really confused how the above commit could be followed up by:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb/dwc3/drd.c?h=v6.0-rc6&id=0f01017191384e3962fa31520a9fd9846c3d352f
> 
> the diffs in dwc3_drd_init seem contradictory
> 
>>>> If the extcon device exists, get the mode from the extcon device. If
>>>> the controller is DRD and the driver is unable to determine the mode,
>>>> only then default the dr_mode to USB_DR_MODE_PERIPHERAL.
>>>>
>>>> According to Ferry (Cc'ed) this broke Intel Merrifield platform. Ferry, can you
>>>> share bisect log?
>>>>
>>>> I can but not right now. But what I did was bisect between 5.18.0 (good) and 5.19.0 (bad) then when I got near the culprit (~20 remaining) based on the commit message I tried 0f01017191384e3962fa31520a9fd9846c3d352f "usb: dwc3: Don't switch OTG -> peripheral if extcon is present" (bad) and commit before that (good).
>>>>
>>>> The effect of the patch is that on Merrifield (I tested with Intel Edison Arduino board which has a HW switch to select between host and device mode) device mode works but in host mode USB is completely not working.
>>>>
>>>> Currently on host mode - when working - superfluous error messages from tusb1210 appear. When host mode is not working there are no tusb1210 messages in the logs / on the console at all. Seemingly tusb1210 is not probed, which points in the direction of a relation to extcon.
>>>>
>>>> Taking into account the late cycle, I would like to revert the change. And
>>>> Ferry and I would help to test any other (non-regressive) approach).
>>>>
>>>> I have not yet tested if a simple revert fixes the problem but will tonight.
>>>>
>>>>
>>>> I would be happy to test other approaches too.
>>>
>>>
>>> It's a bit hard for me to suggest an alternative approach without
>>> knowing how things are breaking in this case. I'd love to order one of
>>> those boards to repro and fix this on my end, but it looks like this
>>> HW is EOLed and out of stock in most places. If you guys know how to
>>> get my hands on those boards I'm all ears.
>>
>> There are still some second hand Intel Edison boards flying around
>> (but maybe cost a bit more than expected) and there are also
>> Dell Venue 7 3740 tablets based on the same platform/SoC. The latter
>> option though requires more actions in order something to be boot
>> there.
>>
> 
> OK, I'll check e-bay just in case.

I see one Edison + Arduino board on eBay $99.99

>> In any case, it's probably quicker to ask Ferry or me for testing.
>> (Although currently I have no access to the board to test OTG, it's
>>   remote device which I can only power on and off and it has always
>>   be in host mode.)
>>
>>> Barring that, Ferry can you dig more into this failure? E.g. is it this hunk
>>>
>>> @@ -85,7 +86,7 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
>>>                   * mode. If the controller supports DRD but the dr_mode is not
>>>                   * specified or set to OTG, then set the mode to peripheral.
>>>                   */
>>> -               if (mode == USB_DR_MODE_OTG &&
>>> +               if (mode == USB_DR_MODE_OTG && !dwc->edev &&
>>>                      (!IS_ENABLED(CONFIG_USB_ROLE_SWITCH) ||
>>>                       !device_property_read_bool(dwc->dev, "usb-role-switch")) &&
>>>                      !DWC3_VER_IS_PRIOR(DWC3, 330A))
>>> @@ -1632,6 +1633,51 @@ static void dwc3_check_params(struct dwc3 *dwc)
>>>          }
>>>   }
>>>
>>> that's problematic or moving
>>
>> I think you wanted to revert only this line and test?
> 
> Yes.
> 
>>
>>>   static int dwc3_probe(struct platform_device *pdev)
>>>   {
>>>          struct device           *dev = &pdev->dev;
>>> @@ -1744,6 +1790,13 @@ static int dwc3_probe(struct platform_device *pdev)
>>>                  goto err2;
>>>          }
>>>
>>> +       dwc->edev = dwc3_get_extcon(dwc);
>>> +       if (IS_ERR(dwc->edev)) {
>>> +               ret = PTR_ERR(dwc->edev);
>>> +               dev_err_probe(dwc->dev, ret, "failed to get extcon\n");
>>> +               goto err3;
>>> +       }
>>> +
>>>          ret = dwc3_get_dr_mode(dwc);
>>>          if (ret)
>>>                  goto err3;
>>>
>>> to happen earlier?
>>
>> It is not always possible to have an extcon driver available, that's why in
>> some cases the probe of it defers. I dunno how your patch supposed to work
>> in that case.
> 
> I'm not sure I understand what you mean. AFAIU the logic is that if
> the platform specifies the presence of extcon either via DT or, like
> Merrifield, via and explicit "linux,extcon-name" device property in
> the code then extcon is a mandatory component of the DRD stack and the
> driver is expected to be present for the whole thing to work. I don't
> think I really changed that logic with my patch, even after the revert
> dwc3_get_extcon() will be called as a part of a probing codepath, so
> if the a missing driver is causing a probe deferral it should still be
> happening, unless I missed something.
> 
>>
>>> Does tracing the "mrfld_bcove_pwrsrc" driver (the
>>> excton provider in this case AFIACT) show anything interesting?
>>
>> I believe there is nothing interesting.
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
>>
>>
