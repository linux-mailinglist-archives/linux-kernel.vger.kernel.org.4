Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9F35E6D16
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiIVUf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiIVUfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:35:18 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE178A3472;
        Thu, 22 Sep 2022 13:35:16 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id e18so15292870edj.3;
        Thu, 22 Sep 2022 13:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=HyErV8xzsYibE84V0H3iRbBpF8z8RVZNEiwzTBCN7y8=;
        b=dR5kGZWPEu0mY1SwV2krcuJ29s6VMwWy2Fjz7MTSx3JiJXUbCr2djLhSfBQCKuPy1Z
         Iz5K9E84fSg4kBed2amDxKbFM383ileuE0lf32qDeOp5GF62bezJUe5AoO/rs4pIORPS
         TFwzdgegNF4ulHHfJGIOPBfwDXiQVQaRUP0Fj0GBbb72iPiXk6VGJqz02Hfndma8ldev
         jvZBUxi91+v8V8BX66xzNcNAuKIsArtdxZGTmv6mlHyNMfkbB+YZd6o6flttJm+zKtIL
         ZLV1zcghLU3kYZD65mS+73PtoeTf17cEvruPAF4b8kZEH7zkrPVxPzB9sYEKwTbuQ8VM
         ih2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HyErV8xzsYibE84V0H3iRbBpF8z8RVZNEiwzTBCN7y8=;
        b=GSELlHqfFztH7fEjy67zfns0C63UFb/zOcJFovtWpMP9Ox48u483G7+vfX5v9ls3G4
         gxXiL6RcnVKAi0koVriH9tnbqGiqOOndxf0rjZ6CJZePRO/RKzd4xbB8La3jN6kIsAd0
         loC349z6f5vIHmipKc4hwR1ZGdkASOABcmUQr76dlG4ep/D0XiNPhUnCwZUDqgrJrOOa
         AnOoVK2RcTqGekHrdm7ubG/UpbtQFyxzSKvxBschkj8ChzkGVTNxSVW9nrPTGFZgXwVw
         gKnbsU7m14bdSqfBl7F1FJrUjtYG5RrCo0Ni3gvPBIwl/s25HNfPTtNWcFrZapyPOhNG
         OU1Q==
X-Gm-Message-State: ACrzQf1PAXTH3fAfush/YESq10LsSMCNhawsW4BG+H6UtjxfBg9aB/3Z
        IepnLwO4vYaTGHNTckBHXPc=
X-Google-Smtp-Source: AMsMyM7TCDplKaoppNc0fQRqs9Wvg+rXdawvxHSw7cwzvbEMrZuLVj0QUV528L+JVLxybOeU/mu1Tw==
X-Received: by 2002:a05:6402:1704:b0:44e:b523:585d with SMTP id y4-20020a056402170400b0044eb523585dmr5200704edu.22.1663878915153;
        Thu, 22 Sep 2022 13:35:15 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:14be:21e4:7385:ae7b? (2a02-a466-68ed-1-14be-21e4-7385-ae7b.fixed6.kpn.net. [2a02:a466:68ed:1:14be:21e4:7385:ae7b])
        by smtp.gmail.com with ESMTPSA id t22-20020a056402021600b00443d657d8a4sm4191694edv.61.2022.09.22.13.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 13:35:14 -0700 (PDT)
Message-ID: <580eb9fe-db26-ddd4-6368-c763bb4ebdba@gmail.com>
Date:   Thu, 22 Sep 2022 22:35:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4] usb: dwc3: Don't switch OTG -> peripheral if extcon is
 present
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <thinhn@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
References: <20220403164907.662860-1-andrew.smirnov@gmail.com>
 <Yyw0K/hcTZ02UP+A@smile.fi.intel.com>
 <691c3073-5105-9a2b-e6f2-ea0a4b8aaea8@gmail.com>
 <YyxjJxnbhroflkH6@smile.fi.intel.com>
Content-Language: en-US
From:   Ferry Toth <fntoth@gmail.com>
In-Reply-To: <YyxjJxnbhroflkH6@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Op 22-09-2022 om 15:29 schreef Andy Shevchenko:
> On Thu, Sep 22, 2022 at 12:23:04PM +0200, Ferry Toth wrote:
>> On 22-09-2022 12:08, Andy Shevchenko wrote:
>>> On Sun, Apr 03, 2022 at 09:49:07AM -0700, Andrey Smirnov wrote:
>>>> If the extcon device exists, get the mode from the extcon device. If
>>>> the controller is DRD and the driver is unable to determine the mode,
>>>> only then default the dr_mode to USB_DR_MODE_PERIPHERAL.
>>> According to Ferry (Cc'ed) this broke Intel Merrifield platform. Ferry, can you
>>> share bisect log?
git bisect start
# bad: [3d7cb6b04c3f3115719235cc6866b10326de34cd] Linux 5.19
git bisect bad 3d7cb6b04c3f3115719235cc6866b10326de34cd
# good: [4b0986a3613c92f4ec1bdc7f60ec66fea135991f] Linux 5.18
git bisect good 4b0986a3613c92f4ec1bdc7f60ec66fea135991f
# good: [c011dd537ffe47462051930413fed07dbdc80313] Merge tag 
'arm-soc-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect good c011dd537ffe47462051930413fed07dbdc80313
# good: [5d4af9c1f04ab0411ba5818baad9a68e87f33099] Merge branch 
'mv88e6xxx-fixes-for-reading-serdes-state'
git bisect good 5d4af9c1f04ab0411ba5818baad9a68e87f33099
# bad: [7a68065eb9cd194cf03f135c9211eeb2d5c4c0a0] Merge tag 
'gpio-fixes-for-v5.19-rc2' of 
git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
git bisect bad 7a68065eb9cd194cf03f135c9211eeb2d5c4c0a0
# bad: [54c2cc79194c961a213c1d375fe3aa4165664cc4] Merge tag 
'usb-5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
git bisect bad 54c2cc79194c961a213c1d375fe3aa4165664cc4
# good: [6a31a95135da0bb2c5349e49e37d76e9909ab7ea] staging: r8188eu: 
remove include/rtw_debug.h
git bisect good 6a31a95135da0bb2c5349e49e37d76e9909ab7ea
# good: [04d93b2b8bc7a68ec45a6a156f34a611ede5aa60] Merge tag 
'spdx-5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx
git bisect good 04d93b2b8bc7a68ec45a6a156f34a611ede5aa60
# good: [c069d2756c01ed36121fae6a42c14fdf1325c71d] serial: sifive: 
Sanitize CSIZE and c_iflag
git bisect good c069d2756c01ed36121fae6a42c14fdf1325c71d
# bad: [3120aac6d0ecd9accf56894aeac0e265f74d3d5a] usb: dwc2: gadget: 
don't reset gadget's driver->bus
git bisect bad 3120aac6d0ecd9accf56894aeac0e265f74d3d5a
# bad: [0f01017191384e3962fa31520a9fd9846c3d352f] usb: dwc3: Don't 
switch OTG -> peripheral if extcon is present
git bisect bad 0f01017191384e3962fa31520a9fd9846c3d352f
# good: [b8a19881337678c02bb3d72ae821602e1a4c377d] usb: gadget: u_audio: 
clean up some inconsistent indenting
git bisect good b8a19881337678c02bb3d72ae821602e1a4c377d
# good: [424bef51fa530389b0b9008c9e144e40c10e8458] usb: musb: Fix 
missing of_node_put() in omap2430_probe
git bisect good 424bef51fa530389b0b9008c9e144e40c10e8458

>>> I can but not right now. But what I did was bisect between 5.18.0 (good) and
>>> 5.19.0 (bad) then when I got near the culprit (~20 remaining) based on the
>>> commit message I tried 0f01017191384e3962fa31520a9fd9846c3d352f "usb: dwc3:
>>> Don't switch OTG -> peripheral if extcon is present" (bad) and commit before
>>> that (good).
5c29e864999763baec9eedb9ea5bd557aa4cbd77
>>> The effect of the patch is that on Merrifield (I tested with Intel Edison
>>> Arduino board which has a HW switch to select between host and device mode)
>>> device mode works but in host mode USB is completely not working.
>>>
>>> Currently on host mode - when working - superfluous error messages from
>>> tusb1210 appear. When host mode is not working there are no tusb1210
>>> messages in the logs / on the console at all. Seemingly tusb1210 is not
>>> probed, which points in the direction of a relation to extcon.
>>>
>>> Taking into account the late cycle, I would like to revert the change. And
>>> Ferry and I would help to test any other (non-regressive) approach).
>> I have not yet tested if a simple revert fixes the problem but will tonight.
> For clean revert you might need to revert the merge conflict fixes first:
> 8bd6b8c4b100 ("USB: fixup for merge issue with "usb: dwc3: Don't switch
> OTG -> peripheral if extcon is present"").

Tested successfully on Intel Merrifield with v6.0-rc6 with reverted:

8bd6b8c4 ("USB: fixup for merge issue with "usb: dwc3: Don't switch OTG -> peripheral if extcon is present"")

0f010171 ("usb: dwc3: Don't switch OTG -> peripheral if extcon is present")

I also tested on v5.19 which in addition requires a back port of

d4a0a189 ("phy: ti: tusb1210: Don't check for write errors when powering 
on")

>> I would be happy to test other approaches too.
