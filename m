Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49D55E84B2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 23:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiIWVMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 17:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiIWVMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 17:12:31 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B12120BD7;
        Fri, 23 Sep 2022 14:12:30 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id lc7so3261508ejb.0;
        Fri, 23 Sep 2022 14:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ojRjE36+MTAv5OOswGHT+LhK+guJpPMj7V+6SoOv+Kg=;
        b=OoiZcPaPfUmKif2eq7AB5Dbvnx7ma+KANGQjHaET7N2Ez+gXyJaTKKcd7sDZCmbHN5
         pRbNqUgo5sa8stm0fqWX1FZyatBk80V3qIy75lHb1FwurrfKx5i1bxCca8zTlkM4sMdX
         N7OPSF9RaY6SbMXNHCH4PPf2mFVjrfFk3uDfK69TRqtRHeW8QYwu/S/7TvtjHn+KjnQ4
         C6CvEp5l1X/RkfOsXRB4Htj6CAfhNOl7whKdj+VFYht0yKEVjDEzDitsQVAUKZ8Nr37I
         z0RF4ciJeWwVKXodXhnbZytL6D5yT1NpglnnegYM5CiuB69xY3MZsE4FLXHqW51HtXDR
         +B8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ojRjE36+MTAv5OOswGHT+LhK+guJpPMj7V+6SoOv+Kg=;
        b=qTp93NDvU/kBs079/QrxyCVaKkMjuw6ZdSZCRVx0brKywLzjEN+/hqAt7CqSSjwcWb
         ye57wgb+ofE1AL9zqcCcJDImjGOUNGp374o9KwyOv+cG45bfmR5gY8QcBNH9Wu6Xujxq
         227wqPve25IXKavfZxttMmHh79B5WG5w2xu8W+ErS8OuZFKZ1/G3+wIir5bcX6f1uDuy
         nSacG8b7d2y4PQAYGJsfz8GHgtp1X3UP+RVKEhZXp33kigi/1UOnqO3mdBxKsZxmgLBV
         8kAOqS9fLpx2ibCA7g64ce8+je3ov94GaLRYj6vASPQYP2HcM2se56s++7VZmObFznNR
         2QHA==
X-Gm-Message-State: ACrzQf2YWQwRCcDWexhSPekN3gif8kISRyVODOMjx14KU7LLCAv6IlIk
        //dsJaoamPwsc0tqYfA/PB/39obwoU8=
X-Google-Smtp-Source: AMsMyM7kH0ihktK8yKszTg9OI7TV7vAdLNL1UjiVexRDCWSPWRbz+9cTS7FFw/MkiPddSvPv6LpXOQ==
X-Received: by 2002:a17:906:8a5a:b0:781:6a01:5ccc with SMTP id gx26-20020a1709068a5a00b007816a015cccmr8783280ejc.118.1663967549062;
        Fri, 23 Sep 2022 14:12:29 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:aa4d:dfcb:6827:51a9? (2a02-a466-68ed-1-aa4d-dfcb-6827-51a9.fixed6.kpn.net. [2a02:a466:68ed:1:aa4d:dfcb:6827:51a9])
        by smtp.gmail.com with ESMTPSA id tl2-20020a170907c30200b00782cd82db09sm714858ejc.106.2022.09.23.14.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 14:12:28 -0700 (PDT)
Message-ID: <47a0249c-e129-7e98-503d-4254f216e485@gmail.com>
Date:   Fri, 23 Sep 2022 23:12:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4] usb: dwc3: Don't switch OTG -> peripheral if extcon is
 present
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <thinhn@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
References: <20220403164907.662860-1-andrew.smirnov@gmail.com>
 <Yyw0K/hcTZ02UP+A@smile.fi.intel.com>
 <691c3073-5105-9a2b-e6f2-ea0a4b8aaea8@gmail.com>
 <CAHQ1cqGFFJ0gRbdN+DH0iJhcKc=eee8uNoDyfHEy00-CMgstiw@mail.gmail.com>
 <Yy3iAHLlS2emAmWn@smile.fi.intel.com>
From:   Ferry Toth <fntoth@gmail.com>
In-Reply-To: <Yy3iAHLlS2emAmWn@smile.fi.intel.com>
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

Hi,

Op 23-09-2022 om 18:42 schreef Andy Shevchenko:
> On Thu, Sep 22, 2022 at 04:32:55PM -0700, Andrey Smirnov wrote:
>> On Thu, Sep 22, 2022 at 3:23 AM Ferry Toth <fntoth@gmail.com> wrote:
>>> On 22-09-2022 12:08, Andy Shevchenko wrote:
>>> On Sun, Apr 03, 2022 at 09:49:07AM -0700, Andrey Smirnov wrote:
> FYI: For now I sent a revert, but if we got a solution quicker we always
> can choose the course of actions.
>
>>> If the extcon device exists, get the mode from the extcon device. If
>>> the controller is DRD and the driver is unable to determine the mode,
>>> only then default the dr_mode to USB_DR_MODE_PERIPHERAL.
>>>
>>> According to Ferry (Cc'ed) this broke Intel Merrifield platform. Ferry, can you
>>> share bisect log?
>>>
>>> I can but not right now. But what I did was bisect between 5.18.0 (good) and 5.19.0 (bad) then when I got near the culprit (~20 remaining) based on the commit message I tried 0f01017191384e3962fa31520a9fd9846c3d352f "usb: dwc3: Don't switch OTG -> peripheral if extcon is present" (bad) and commit before that (good).
>>>
>>> The effect of the patch is that on Merrifield (I tested with Intel Edison Arduino board which has a HW switch to select between host and device mode) device mode works but in host mode USB is completely not working.
>>>
>>> Currently on host mode - when working - superfluous error messages from tusb1210 appear. When host mode is not working there are no tusb1210 messages in the logs / on the console at all. Seemingly tusb1210 is not probed, which points in the direction of a relation to extcon.
>>>
>>> Taking into account the late cycle, I would like to revert the change. And
>>> Ferry and I would help to test any other (non-regressive) approach).
>>>
>>> I have not yet tested if a simple revert fixes the problem but will tonight.
>>>
>>>
>>> I would be happy to test other approaches too.
>>
>> It's a bit hard for me to suggest an alternative approach without
>> knowing how things are breaking in this case. I'd love to order one of
>> those boards to repro and fix this on my end, but it looks like this
>> HW is EOLed and out of stock in most places. If you guys know how to
>> get my hands on those boards I'm all ears.
> There are still some second hand Intel Edison boards flying around
> (but maybe cost a bit more than expected) and there are also
> Dell Venue 7 3740 tablets based on the same platform/SoC. The latter
> option though requires more actions in order something to be boot
> there.
>
> In any case, it's probably quicker to ask Ferry or me for testing.
> (Although currently I have no access to the board to test OTG, it's
>   remote device which I can only power on and off and it has always
>   be in host mode.)
>
>> Barring that, Ferry can you dig more into this failure? E.g. is it this hunk
>>
>> @@ -85,7 +86,7 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
>>                   * mode. If the controller supports DRD but the dr_mode is not
>>                   * specified or set to OTG, then set the mode to peripheral.
>>                   */
>> -               if (mode == USB_DR_MODE_OTG &&
>> +               if (mode == USB_DR_MODE_OTG && !dwc->edev &&
>>                      (!IS_ENABLED(CONFIG_USB_ROLE_SWITCH) ||
>>                       !device_property_read_bool(dwc->dev, "usb-role-switch")) &&
>>                      !DWC3_VER_IS_PRIOR(DWC3, 330A))
>> @@ -1632,6 +1633,51 @@ static void dwc3_check_params(struct dwc3 *dwc)
>>          }
>>   }
>>
>> that's problematic or moving
> I think you wanted to revert only this line and test?

On v6.0-rc6 and reverting manually only this line

- if (mode == USB_DR_MODE_OTG && !dwc->edev &&

+ if (mode == USB_DR_MODE_OTG &&

host mode still does not work (no change visible).

>
>>   static int dwc3_probe(struct platform_device *pdev)
>>   {
>>          struct device           *dev = &pdev->dev;
>> @@ -1744,6 +1790,13 @@ static int dwc3_probe(struct platform_device *pdev)
>>                  goto err2;
>>          }
>>
>> +       dwc->edev = dwc3_get_extcon(dwc);
>> +       if (IS_ERR(dwc->edev)) {
>> +               ret = PTR_ERR(dwc->edev);
>> +               dev_err_probe(dwc->dev, ret, "failed to get extcon\n");
>> +               goto err3;
>> +       }
>> +
>>          ret = dwc3_get_dr_mode(dwc);
>>          if (ret)
>>                  goto err3;
>>
>> to happen earlier?
> It is not always possible to have an extcon driver available, that's why in
> some cases the probe of it defers. I dunno how your patch supposed to work
> in that case.
>
>> Does tracing the "mrfld_bcove_pwrsrc" driver (the
>> excton provider in this case AFIACT) show anything interesting?
> I believe there is nothing interesting.
>
