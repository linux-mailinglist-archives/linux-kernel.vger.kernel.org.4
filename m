Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20FB5E8E5B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 18:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbiIXQGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 12:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIXQGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 12:06:09 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CEF491E3;
        Sat, 24 Sep 2022 09:06:07 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z13so3783297edb.13;
        Sat, 24 Sep 2022 09:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=oIa/uQjVcFj+54eYY9is22hKyDuiFkRv25cGd97Fme0=;
        b=T11fFsSVxeZDb0sX5zohleHJG82vShX6zsqip2nExai2Vf+/QFxyjzYR35qIOv/3bu
         FTWkB+DBPZZ9eYdMAth3i7JSXppqTWhcPaFWgLctYZ6INV5W6AlMpdxRsQKxKKXToilW
         mmdzejGUMtSGwqSVwJvpdYz2LBHtRo6OW1Ughme8vSv4kme2zFYxXC/q5vHmZf+Ay/kf
         uq2Bvt2K99d+/DQEbRb0CM5m+oWCOC+5Kq4BYGwK87gLsdTNvSJaZlM438teZqmVglX+
         mIG952W1NsDsKPWojppyXwFgxwRUHiTMc/vFUvcxaBrn+K900n4mTCjXSTpATaZVEn89
         svDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=oIa/uQjVcFj+54eYY9is22hKyDuiFkRv25cGd97Fme0=;
        b=COO3r9oy9Rn9GurQnB7jvA/1i4wsGnXtydo4XhpjnLlOmePmV4agDg7vTEdUG0q1hn
         Yuo3Z6ST9Zsu22nK1LZxsIZveyLc5kMoB+JldK4PP3h6D704+iGFhsqNrPa/kQbnwpYB
         y2G5je2NqOlFPVUH92P7zBJqYUsnYs4oQ+gtdrDX7LBLH63iw7+Z85HJfa3CLfURsxRp
         qHQiNM3NMK57UjWBR8wyMZl5f5RGAVb7oM1PFkURWQUZlSzjmJTRKgMUWv7lufo/DodB
         PTnzOb2qcme4f7827MmfFuPIUQpr/SVOusINopQRRxJEtYe2+yIBha6s0fqz2Socv6XM
         inZg==
X-Gm-Message-State: ACrzQf2kKS75Awbwk38IyCUS84iw2FDxBRzXnybKmbH6vrjDhRpDndUm
        fBMNYsAPuJAvqo47sifQILQ=
X-Google-Smtp-Source: AMsMyM42Mcl1myOBoVMGcH8Ay7tYpKpPvj5UfPZ8mE6yCXT4ZrcaneoFYiucVZjz/5Q6W3jaVvTlOA==
X-Received: by 2002:aa7:d5c8:0:b0:44e:3eb1:a13f with SMTP id d8-20020aa7d5c8000000b0044e3eb1a13fmr14329704eds.220.1664035565809;
        Sat, 24 Sep 2022 09:06:05 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:e3aa:3811:305b:8a83? (2a02-a466-68ed-1-e3aa-3811-305b-8a83.fixed6.kpn.net. [2a02:a466:68ed:1:e3aa:3811:305b:8a83])
        by smtp.gmail.com with ESMTPSA id r9-20020a1709061ba900b0078258a26667sm3741429ejg.52.2022.09.24.09.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Sep 2022 09:06:05 -0700 (PDT)
Message-ID: <a911ac0c-561f-85ad-2bc7-c3ee54f8c7bc@gmail.com>
Date:   Sat, 24 Sep 2022 18:06:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4] usb: dwc3: Don't switch OTG -> peripheral if extcon is
 present
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <thinhn@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
References: <20220403164907.662860-1-andrew.smirnov@gmail.com>
 <Yyw0K/hcTZ02UP+A@smile.fi.intel.com>
 <691c3073-5105-9a2b-e6f2-ea0a4b8aaea8@gmail.com>
 <CAHQ1cqGFFJ0gRbdN+DH0iJhcKc=eee8uNoDyfHEy00-CMgstiw@mail.gmail.com>
 <Yy3iAHLlS2emAmWn@smile.fi.intel.com>
 <47a0249c-e129-7e98-503d-4254f216e485@gmail.com>
 <CAHQ1cqG7oL2sn=SRxp9se_h=rm+C6qYTkjp_DD1hPLBRPJpoGg@mail.gmail.com>
Content-Language: en-US
From:   Ferry Toth <fntoth@gmail.com>
In-Reply-To: <CAHQ1cqG7oL2sn=SRxp9se_h=rm+C6qYTkjp_DD1hPLBRPJpoGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Maybe some inspiration below.

Op 24-09-2022 om 03:34 schreef Andrey Smirnov:
> On Fri, Sep 23, 2022 at 2:12 PM Ferry Toth <fntoth@gmail.com> wrote:
>> Hi,
>>
>> Op 23-09-2022 om 18:42 schreef Andy Shevchenko:
>>> On Thu, Sep 22, 2022 at 04:32:55PM -0700, Andrey Smirnov wrote:
>>>> On Thu, Sep 22, 2022 at 3:23 AM Ferry Toth <fntoth@gmail.com> wrote:
>>>>> On 22-09-2022 12:08, Andy Shevchenko wrote:
>>>>> On Sun, Apr 03, 2022 at 09:49:07AM -0700, Andrey Smirnov wrote:
>>> FYI: For now I sent a revert, but if we got a solution quicker we always
>>> can choose the course of actions.
>>>
>>>>> If the extcon device exists, get the mode from the extcon device. If
>>>>> the controller is DRD and the driver is unable to determine the mode,
>>>>> only then default the dr_mode to USB_DR_MODE_PERIPHERAL.
>>>>>
>>>>> According to Ferry (Cc'ed) this broke Intel Merrifield platform. Ferry, can you
>>>>> share bisect log?
>>>>>
>>>>> I can but not right now. But what I did was bisect between 5.18.0 (good) and 5.19.0 (bad) then when I got near the culprit (~20 remaining) based on the commit message I tried 0f01017191384e3962fa31520a9fd9846c3d352f "usb: dwc3: Don't switch OTG -> peripheral if extcon is present" (bad) and commit before that (good).
>>>>>
>>>>> The effect of the patch is that on Merrifield (I tested with Intel Edison Arduino board which has a HW switch to select between host and device mode) device mode works but in host mode USB is completely not working.
>>>>>
>>>>> Currently on host mode - when working - superfluous error messages from tusb1210 appear. When host mode is not working there are no tusb1210 messages in the logs / on the console at all. Seemingly tusb1210 is not probed, which points in the direction of a relation to extcon.
>>>>>
>>>>> Taking into account the late cycle, I would like to revert the change. And
>>>>> Ferry and I would help to test any other (non-regressive) approach).
>>>>>
>>>>> I have not yet tested if a simple revert fixes the problem but will tonight.
>>>>>
>>>>>
>>>>> I would be happy to test other approaches too.
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
>>> In any case, it's probably quicker to ask Ferry or me for testing.
>>> (Although currently I have no access to the board to test OTG, it's
>>>    remote device which I can only power on and off and it has always
>>>    be in host mode.)
>>>
>>>> Barring that, Ferry can you dig more into this failure? E.g. is it this hunk
>>>>
>>>> @@ -85,7 +86,7 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
>>>>                    * mode. If the controller supports DRD but the dr_mode is not
>>>>                    * specified or set to OTG, then set the mode to peripheral.
>>>>                    */
>>>> -               if (mode == USB_DR_MODE_OTG &&
>>>> +               if (mode == USB_DR_MODE_OTG && !dwc->edev &&
>>>>                       (!IS_ENABLED(CONFIG_USB_ROLE_SWITCH) ||
>>>>                        !device_property_read_bool(dwc->dev, "usb-role-switch")) &&
>>>>                       !DWC3_VER_IS_PRIOR(DWC3, 330A))
>>>> @@ -1632,6 +1633,51 @@ static void dwc3_check_params(struct dwc3 *dwc)
>>>>           }
>>>>    }
>>>>
>>>> that's problematic or moving
>>> I think you wanted to revert only this line and test?
>> On v6.0-rc6 and reverting manually only this line
>>
>> - if (mode == USB_DR_MODE_OTG && !dwc->edev &&
>>
>> + if (mode == USB_DR_MODE_OTG &&
>>
>> host mode still does not work (no change visible).
> Cool, thanks for checking that. Don't think I have any more
> experiments off the top of my head to run. I'll have to go read that
> code more. I'll reply in the thread if I have something new to
> try/say.

It seems the problem is not extcon directly. When I switch to device 
mode, usb gadgets are working fire. Also when I

# cat /sys/class/extcon/extcon0/state
USB=0
USB-HOST=1
SDP=0
CDP=0
DCP=0
ACA=0

USB-HOST changes nicely to 0 and back when I flip the switch.

Also, in host mode I normally have (and now with host mode not working 
it the same):

root@yuna:~# dmesg | grep -i usb
ACPI: bus type USB registered
...
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 1
xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 2
xhci-hcd xhci-hcd.1.auto: Host supports USB 3.0 SuperSpeed
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, 
bcdDevice= 6.00
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: xHCI Host Controller
usb usb1: Manufacturer: Linux 6.0.0-rc6-edison-acpi-standard xhci-hcd
usb usb1: SerialNumber: xhci-hcd.1.auto
hub 1-0:1.0: USB hub found
usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, 
bcdDevice= 6.00
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: xHCI Host Controller
usb usb2: Manufacturer: Linux 6.0.0-rc6-edison-acpi-standard xhci-hcd
usb usb2: SerialNumber: xhci-hcd.1.auto
hub 2-0:1.0: USB hub found

So, extcon works, xhci host controller "works". The problem may be no 
ulpi (tusb1210). Checking on 6.0-rc6 with host mode not working:

root@yuna:~# cat /sys/bus/ulpi/devices/dwc3.0.auto.ulpi/uevent
DEVTYPE=ulpi_device
MODALIAS=ulpi:v0000p0000
root@yuna:~# cat 
/sys/bus/ulpi/devices/dwc3.0.auto.ulpi/waiting_for_supplier
0
And on 5.15 with host mode working:

root@edison:~# cat /sys/bus/ulpi/devices/dwc3.0.auto.ulpi/uevent
DEVTYPE=ulpi_device
DRIVER=tusb1210
MODALIAS=ulpi:v0451p1508
root@edison:~#  cat 
/sys/bus/ulpi/devices/dwc3.0.auto.ulpi/waiting_for_supplier
cat: /sys/bus/ulpi/devices/dwc3.0.auto.ulpi/waiting_for_supplier: No 
such file or directory

Ulpi is there but is waiting for driver.

>>>>    static int dwc3_probe(struct platform_device *pdev)
>>>>    {
>>>>           struct device           *dev = &pdev->dev;
>>>> @@ -1744,6 +1790,13 @@ static int dwc3_probe(struct platform_device *pdev)
>>>>                   goto err2;
>>>>           }
>>>>
>>>> +       dwc->edev = dwc3_get_extcon(dwc);
>>>> +       if (IS_ERR(dwc->edev)) {
>>>> +               ret = PTR_ERR(dwc->edev);
>>>> +               dev_err_probe(dwc->dev, ret, "failed to get extcon\n");
>>>> +               goto err3;
>>>> +       }
>>>> +
>>>>           ret = dwc3_get_dr_mode(dwc);
>>>>           if (ret)
>>>>                   goto err3;
>>>>
>>>> to happen earlier?
>>> It is not always possible to have an extcon driver available, that's why in
>>> some cases the probe of it defers. I dunno how your patch supposed to work
>>> in that case.
>>>
>>>> Does tracing the "mrfld_bcove_pwrsrc" driver (the
>>>> excton provider in this case AFIACT) show anything interesting?
>>> I believe there is nothing interesting.
>>>
