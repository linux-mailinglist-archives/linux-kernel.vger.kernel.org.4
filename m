Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49655E95AE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 21:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiIYTVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 15:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiIYTVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 15:21:09 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E542C640;
        Sun, 25 Sep 2022 12:21:05 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l14so10094271eja.7;
        Sun, 25 Sep 2022 12:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=loVHzVX6nTcrkFCHK+hdkB4lGDVwRORB0+shLXBc1jE=;
        b=UCWwJn82SYOg9TvD9OeohQWoinfQZplQu2Ayihf2d06Oc9xuyf/CdS2v5jj8h2xEPG
         XV+zfwaK3w6Ybt+8sOWnZULgoWbCjmndt7bWCh3Sx/sgQ7ytUhnseRIFDAL3ydmoRpRv
         v4pLYx7aBh0vx3NFJumdWNYa0lGR01Z1FpTmYQAk3ADosKSJgtIccgpktEtfMunKRkUY
         4tK9vuJp0VcRiSW69QOOrYOsKzsLZzj3eOTFjF+90Df0L1+GDLLYwdTEWxyGfm5jjxQP
         g8F3toXqkwPoDNFLnX73bmNN2YVG3NPGbYKAIP0netJxwVtILMtZXHbf+XJWxIZ3GidA
         q/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=loVHzVX6nTcrkFCHK+hdkB4lGDVwRORB0+shLXBc1jE=;
        b=QlmY1GSGj0j58R+R+hzCnMCylkO8uDUZouH2NiebYwkwlixpFg+zHcCV5LAxn9zcp5
         DAve8nuKl38lUlxuM8gnY3dUtZUQUY2mTDOMGWIfyo3H+bwV9kk4Fmtf3WUWGg7WCpf1
         BGVcSuTyBnQ7mplgq24etPe+Fa9EwDJe/QTWCmTHQIsu4fWButzJxqy9RZAgtcKx2259
         pA1K3w3gCYGZfpeiWG7Ag/Fv5UEhgAy3Da/7pVS3gqcDNvyHocyhHZYKmeSIuYB6MxZZ
         yiabKyvLGfCo/LYxza7IUQzDjQ57fIsanvfc02NwMsXEZbn9YQQZKfYUwF9S5TZGXtgk
         +1Hw==
X-Gm-Message-State: ACrzQf11CeJPD1CLkoPQno8i7/CNN22CFVvoJ/C4qcmO2PTaaaVYoZom
        t/PxduayxEew2AaCVRcLi+o=
X-Google-Smtp-Source: AMsMyM5y/v7pdAhOwEnMBsbBlITpVabvE/dpfL02hsRQg3RPeRrPdgRJD2pEBE3IA93IynXsmQNb5w==
X-Received: by 2002:a17:907:d27:b0:782:cc3:8e87 with SMTP id gn39-20020a1709070d2700b007820cc38e87mr14714609ejc.94.1664133663821;
        Sun, 25 Sep 2022 12:21:03 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:264c:5f27:753d:909e? (2a02-a466-68ed-1-264c-5f27-753d-909e.fixed6.kpn.net. [2a02:a466:68ed:1:264c:5f27:753d:909e])
        by smtp.gmail.com with ESMTPSA id f25-20020a50ee99000000b00456efa875fesm4031704edr.55.2022.09.25.12.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 12:21:03 -0700 (PDT)
Message-ID: <331b5644-e204-8915-cd08-bd4fabbfcb49@gmail.com>
Date:   Sun, 25 Sep 2022 21:21:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4] usb: dwc3: Don't switch OTG -> peripheral if extcon is
 present
Content-Language: en-US
From:   Ferry Toth <fntoth@gmail.com>
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
 <966ef528-455c-5180-fc63-ea77cb933af1@gmail.com>
In-Reply-To: <966ef528-455c-5180-fc63-ea77cb933af1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Promising results below.

Op 24-09-2022 om 23:29 schreef Ferry Toth:
> Hi,
>
> One more test
>
> Op 23-09-2022 om 20:23 schreef Andrey Smirnov:
>> On Fri, Sep 23, 2022 at 9:42 AM Andy Shevchenko
>> <andriy.shevchenko@intel.com> wrote:
>>> On Thu, Sep 22, 2022 at 04:32:55PM -0700, Andrey Smirnov wrote:
>>>> On Thu, Sep 22, 2022 at 3:23 AM Ferry Toth <fntoth@gmail.com> wrote:
>>>>> On 22-09-2022 12:08, Andy Shevchenko wrote:
>>>>> On Sun, Apr 03, 2022 at 09:49:07AM -0700, Andrey Smirnov wrote:
>>> FYI: For now I sent a revert, but if we got a solution quicker we 
>>> always
>>> can choose the course of actions.
>>>
>> I think we have another problem. This patch happened in parallel to mine
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.0-rc6&id=ab7aa2866d295438dc60522f85c5421c6b4f1507 
>>
>>
>> so my changes didn't have that fix in mind and I think your revert
>> will not preserve that fix. Can you update your revert to take care of
>> that too, please?
>>
>> I'm really confused how the above commit could be followed up by:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb/dwc3/drd.c?h=v6.0-rc6&id=0f01017191384e3962fa31520a9fd9846c3d352f 
>>
>>
>> the diffs in dwc3_drd_init seem contradictory
>>
>>>>> If the extcon device exists, get the mode from the extcon device. If
>>>>> the controller is DRD and the driver is unable to determine the mode,
>>>>> only then default the dr_mode to USB_DR_MODE_PERIPHERAL.
>>>>>
>>>>> According to Ferry (Cc'ed) this broke Intel Merrifield platform. 
>>>>> Ferry, can you
>>>>> share bisect log?
>>>>>
>>>>> I can but not right now. But what I did was bisect between 5.18.0 
>>>>> (good) and 5.19.0 (bad) then when I got near the culprit (~20 
>>>>> remaining) based on the commit message I tried 
>>>>> 0f01017191384e3962fa31520a9fd9846c3d352f "usb: dwc3: Don't switch 
>>>>> OTG -> peripheral if extcon is present" (bad) and commit before 
>>>>> that (good).
>>>>>
>>>>> The effect of the patch is that on Merrifield (I tested with Intel 
>>>>> Edison Arduino board which has a HW switch to select between host 
>>>>> and device mode) device mode works but in host mode USB is 
>>>>> completely not working.
>>>>>
>>>>> Currently on host mode - when working - superfluous error messages 
>>>>> from tusb1210 appear. When host mode is not working there are no 
>>>>> tusb1210 messages in the logs / on the console at all. Seemingly 
>>>>> tusb1210 is not probed, which points in the direction of a 
>>>>> relation to extcon.
>>>>>
>>>>> Taking into account the late cycle, I would like to revert the 
>>>>> change. And
>>>>> Ferry and I would help to test any other (non-regressive) approach).
>>>>>
>>>>> I have not yet tested if a simple revert fixes the problem but 
>>>>> will tonight.
>>>>>
>>>>>
>>>>> I would be happy to test other approaches too.
>>>>
>>>> It's a bit hard for me to suggest an alternative approach without
>>>> knowing how things are breaking in this case. I'd love to order one of
>>>> those boards to repro and fix this on my end, but it looks like this
>>>> HW is EOLed and out of stock in most places. If you guys know how to
>>>> get my hands on those boards I'm all ears.
>>> There are still some second hand Intel Edison boards flying around
>>> (but maybe cost a bit more than expected) and there are also
>>> Dell Venue 7 3740 tablets based on the same platform/SoC. The latter
>>> option though requires more actions in order something to be boot
>>> there.
>>>
>> OK, I'll check e-bay just in case.
>>
>>> In any case, it's probably quicker to ask Ferry or me for testing.
>>> (Although currently I have no access to the board to test OTG, it's
>>>   remote device which I can only power on and off and it has always
>>>   be in host mode.)
>>>
>>>> Barring that, Ferry can you dig more into this failure? E.g. is it 
>>>> this hunk
>>>>
>>>> @@ -85,7 +86,7 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
>>>>                   * mode. If the controller supports DRD but the 
>>>> dr_mode is not
>>>>                   * specified or set to OTG, then set the mode to 
>>>> peripheral.
>>>>                   */
>>>> -               if (mode == USB_DR_MODE_OTG &&
>>>> +               if (mode == USB_DR_MODE_OTG && !dwc->edev &&
>>>>                      (!IS_ENABLED(CONFIG_USB_ROLE_SWITCH) ||
>>>> !device_property_read_bool(dwc->dev, "usb-role-switch")) &&
>>>>                      !DWC3_VER_IS_PRIOR(DWC3, 330A))
>>>> @@ -1632,6 +1633,51 @@ static void dwc3_check_params(struct dwc3 *dwc)
>>>>          }
>>>>   }
>>>>
>>>> that's problematic or moving
>>> I think you wanted to revert only this line and test?
>> Yes.
>>
>>>>   static int dwc3_probe(struct platform_device *pdev)
>>>>   {
>>>>          struct device           *dev = &pdev->dev;
>>>> @@ -1744,6 +1790,13 @@ static int dwc3_probe(struct platform_device 
>>>> *pdev)
>>>>                  goto err2;
>>>>          }
>>>>
>>>> +       dwc->edev = dwc3_get_extcon(dwc);
>>>> +       if (IS_ERR(dwc->edev)) {
>>>> +               ret = PTR_ERR(dwc->edev);
>>>> +               dev_err_probe(dwc->dev, ret, "failed to get 
>>>> extcon\n");
>>>> +               goto err3;
>>>> +       }
>>>> +
>>>>          ret = dwc3_get_dr_mode(dwc);
>>>>          if (ret)
>>>>                  goto err3;
>>>>
>>>> to happen earlier?
>
> I tried moving dwc3_get_extcon after dwc3_get_dr_mode like so::
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 8c8e32651473..3bf370def546 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1843,6 +1843,10 @@ static int dwc3_probe(struct platform_device 
> *pdev)
>          goto err2;
>      }
>
> +    ret = dwc3_get_dr_mode(dwc);
> +    if (ret)
> +        goto err3;
> +
>      dwc->edev = dwc3_get_extcon(dwc);
>      if (IS_ERR(dwc->edev)) {
>          ret = PTR_ERR(dwc->edev);
> @@ -1850,10 +1854,6 @@ static int dwc3_probe(struct platform_device 
> *pdev)
>          goto err3;
>      }
>
> -    ret = dwc3_get_dr_mode(dwc);
> -    if (ret)
> -        goto err3;
> -
>      ret = dwc3_alloc_scratch_buffers(dwc);
>      if (ret)
>          goto err3;

After trying to understand the code a bit, I successfully tested the 
following move:

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 8c8e32651473..4a38cff8cb16 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1843,13 +1843,6 @@ static int dwc3_probe(struct platform_device *pdev)
          goto err2;
      }

-    dwc->edev = dwc3_get_extcon(dwc);
-    if (IS_ERR(dwc->edev)) {
-        ret = PTR_ERR(dwc->edev);
-        dev_err_probe(dwc->dev, ret, "failed to get extcon\n");
-        goto err3;
-    }
-
      ret = dwc3_get_dr_mode(dwc);
      if (ret)
          goto err3;
@@ -1867,6 +1860,13 @@ static int dwc3_probe(struct platform_device *pdev)
      dwc3_check_params(dwc);
      dwc3_debugfs_init(dwc);

+    dwc->edev = dwc3_get_extcon(dwc);
+    if (IS_ERR(dwc->edev)) {
+        ret = PTR_ERR(dwc->edev);
+        dev_err_probe(dwc->dev, ret, "failed to get extcon\n");
+        goto err5;
+    }
+
      ret = dwc3_core_init_mode(dwc);
      if (ret)
          goto err5;

This moves dwc3_get_extcon() until after dwc3_core_init() but just 
before dwc3_core_init_mode(). AFAIU initially dwc3_get_extcon() was 
called from within dwc3_core_init_mode() but only for case 
USB_DR_MODE_OTG. So with this change order of events is more or less 
unchanged.

Due to move I modified goto to err5, not sure if that is correct.

Thoughts? Can we get something like this in quick or should we revert first?

