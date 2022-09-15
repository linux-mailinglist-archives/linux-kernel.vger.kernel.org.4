Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DB15B999C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiIOLae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiIOLa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:30:28 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5379A29828;
        Thu, 15 Sep 2022 04:30:27 -0700 (PDT)
Received: from [192.168.1.138] ([37.4.248.23]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MybbH-1pXDsH1aov-00z1Yd; Thu, 15 Sep 2022 13:30:04 +0200
Message-ID: <ebb86dfa-2f89-dddc-0864-42fc4d2e9386@i2se.com>
Date:   Thu, 15 Sep 2022 13:30:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/7] clk: bcm: rpi: Add a function to retrieve the
 maximum
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Emma Anholt <emma@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Dom Cobley <popcornmix@gmail.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220815-rpi-fix-4k-60-v1-0-c52bd642f7c6@cerno.tech>
 <20220815-rpi-fix-4k-60-v1-2-c52bd642f7c6@cerno.tech>
 <20220914155035.88E45C433C1@smtp.kernel.org>
 <50e8f1e8-806a-3599-7cbe-0c7d4bec1c51@i2se.com>
 <20220914180508.0EDD9C433D6@smtp.kernel.org>
 <c221873f-f230-0cce-e120-7e3cc732cf00@i2se.com>
 <20220914181458.C6FCCC433C1@smtp.kernel.org>
 <ecfe17be-5d81-3456-9a86-77acc848f95f@i2se.com>
 <20220915075459.d2snlbwkingwnbh3@penduick>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220915075459.d2snlbwkingwnbh3@penduick>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:zlHowfxGiySVfzpiYYs6x9gC/xpTLorrvFqCMJk6TXlgJZcBk8J
 7X1L4o/wo/VMgbEbInTkJmCCsmnUpqEJwk4Ecy4NxSg0eK5NU3MowOJoRsbrZxGz1fUAT41
 Xkqw628RsEcm2U5ZszgTQbuThgoiB2gH3Csf+VQ/VpCFCVZ94QcjO2rb7rBSqemwEXQycRI
 xVuzYLoQSPVBC+DJP7fiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PW7kU/WbNdk=:Kvmxj0vUvx4PxV/Qub80P7
 Y3lR0erxRPjRx06o7bucHjVHgIs+ymWq1+FvpQ9Y30c8bRgZEZ4CEtBbT0waj94uQfkltKRYW
 snFd0eH7iELC5KmHX+5H2CGxvMk796Suy7Ak7ckKwlOHYPSmnvdNH+X3DKiHVrBU52MiIE8LA
 CdF+EXErwXObmuHRrLwX6kd43Frr9AisXs2KWNlr+jotDfd68C/lzKKMZJhsrq0zPFfdGy3Qj
 WvNJndDahfxgcrSy3rjh0T2Oq8WkO8vS3U5XLIVGf9GbTOgiDmWwHXflwBS17lT0DP8HMduWV
 Tw+OzBEkvsG0wH+UthdHq6WiRa9Rbq1UP/JJNmiYIdCgme0Ihxq8FxunsjNzlPkO/j9coxvlj
 G+5LwODKCDX9uWamDXmA4bYWcejPxrIW2mUXJAFZHB23pGzb7NizUocz2WzFM5mERCgUwFaW6
 17O1ba8HmEByQwdm8QKbmZ/pTD4DOKdfD2kFEEsR+0wNd0M5yVogNmtZbf0wfJi50zMAULLhY
 KZw9wffA7c8mnwjfQ4el9bk2VbfPowORZFepZ2HtbKHrOCpxx8A8i7FQ2iZMuGmBpf/fL6vUY
 Z9T4zZAzV+CIaHlPrQIJmECm2FZ9jMfXF9FRtjCdmmhatyqSHaLQkEE05ZuHW0g9wXg+FZj9N
 +6jmt+lWLe2ZjRvqxxEup2N9gEWJawRw50jivqVixtxLR9YFs3XzIIXQZDssKtpYV/Xg/2maa
 AD/k7HoxmBg/mrgSph9E49+elHwxQ+jgzNlWsFZbPEevmaydBxSGkPr9K5x78zikcTYdlSZa2
 tguDrG0GkmOIrbGOK6F5P4czQHsUw==
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Am 15.09.22 um 09:54 schrieb Maxime Ripard:
> On Wed, Sep 14, 2022 at 08:26:55PM +0200, Stefan Wahren wrote:
>> Am 14.09.22 um 20:14 schrieb Stephen Boyd:
>>> Quoting Stefan Wahren (2022-09-14 11:09:04)
>>>> Am 14.09.22 um 20:05 schrieb Stephen Boyd:
>>>>> Quoting Stefan Wahren (2022-09-14 10:45:48)
>>>>>> Am 14.09.22 um 17:50 schrieb Stephen Boyd:
>>>>>>> Furthermore, I wonder if even that part needs to be implemented.  Why
>>>>>>> not make a direct call to rpi_firmware_property() and get the max rate?
>>>>>>> All of that can live in the drm driver. Making it a generic API that
>>>>>>> takes a 'struct clk' means that it looks like any clk can be passed,
>>>>>>> when that isn't true. It would be better to restrict it to the one use
>>>>>>> case so that the scope of the problem doesn't grow. I understand that it
>>>>>>> duplicates a few lines of code, but that looks like a fair tradeoff vs.
>>>>>>> exposing an API that can be used for other clks in the future.
>>>>>> it would be nice to keep all the Rpi specific stuff out of the DRM
>>>>>> driver, since there more users of it.
>>>>> Instead of 'all' did you mean 'any'?
>>>> yes
>>> Why?
>> This firmware is written specific for the Raspberry Pi and not stable from
>> interface point of view. So i'm afraid that the DRM driver is only usable
>> for the Raspberry Pi at the end with all these board specific dependencies.
> I'm open for suggestions there, but is there any other bcm2711 device
> that we support upstream?
I meant the driver as a whole. According to the vc4 binding there are 
three compatibles bcm2835-vc4, cygnus-vc4 and bcm2711-vc5. Unfortunately 
i don't have access to any of these Cygnus boards, so i cannot do any 
regression tests or provide more information to your question.
> If not, I'm not sure what the big deal is at this point. Chances are the
> DRM driver won't work as is on a different board.
>
> Plus, such a board wouldn't be using config.txt at all, so this whole
> dance to find what was enabled or not wouldn't be used at all.
My concern is that we reach some point that we need to say this kernel 
version requires this firmware version. In the Raspberry Pi OS world 
this is not a problem, but not all distributions has this specific 
knowledge.
>
>> Emma invested a lot of time to make this open source and now it looks that
>> like that more and more functionality moves back to firmware.
> What functionality has been moved back to firmware?
This wasn't a offense against your great work. Just a slight warning 
that some functions of clock or power management moved back into 
firmware. We should watch out, but maybe i emote here.
>
> Maxime
