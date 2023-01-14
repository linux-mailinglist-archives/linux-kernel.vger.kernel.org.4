Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BD866AB28
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 12:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjANLYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 06:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjANLYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 06:24:08 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F174769F;
        Sat, 14 Jan 2023 03:24:07 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MA844-1pR9Ir05Ck-00Bcor; Sat, 14 Jan 2023 12:23:51 +0100
Message-ID: <4b01c9ae-1603-6f42-431d-1158286557b5@i2se.com>
Date:   Sat, 14 Jan 2023 12:23:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] pinctrl: bcm: bcm2835: Switch to use
 ->add_pin_ranges()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
References: <20230113171051.19309-1-andriy.shevchenko@linux.intel.com>
 <916654ca-e70f-5663-f3a3-9b370c24aea9@i2se.com>
 <Y8HNpokX5qCQTRqu@smile.fi.intel.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <Y8HNpokX5qCQTRqu@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6HKAfuNQkaBL9orJNFnJWW+PACCYyx98Cn1d4oFQCAd5tGj93Fk
 xcWGVZ/wlrd8FN1VmUHvj9pmlUGqcyQKJydlPJuJ0O4w7Lp32lkkue5Hzt6YmL3ah2aYJ4T
 0P5yHBUcOxc32dXI3v0Q9iKkQM1+HXS2ooySbtPOtyaqJHart2SEPK05IhvU/+kvWRu2Rb8
 ke+diAtd9wU+WJxOCWoDQ==
UI-OutboundReport: notjunk:1;M01:P0:ZW4NK6Ra+8Q=;9XIQMnrNtwC35e4tgE10nkovu6+
 O+vVi7ZEAxButdOpskyzbMGwVxGX4hop43zoLCB4j3dx2r07XKp0dTefmr+Rw6SWBbAaF57hz
 JnXw5I5XFCAjNrW5n2ixsCaYjoxvf42LQOisz7KiY3p60mjRX4MZIInL9Sya5dXJNXN/Nemvv
 vg5ODh6VrQGTZ96FWjBYFKidYuyWZJorHAE1MvsK60nvwBGFrgOyga0ErgKve8EWxcSZczuDs
 KdvgdFIn0y4gzEx/WH5Il2qMcsOsSUI4TUEIMFRdg/5/wZNA50sIqt2cH72Mk678sKjKc9qVQ
 WIubwXDfcvv9Kd9kjjUR/oibgFQhIBA5cM96tLGI7XJXfH7/zYu/GDOUqI63oL7wAiXnfsjiO
 dfDHFGTRIfKZjm/Xe0Sq3hEAhUZUDnIeyptUCWyV1TWwZ2K2sFQsy+3nb4g7hitTcbX7MYZt2
 GjvhUg8ClI1+qq2+1Iyl9UUoeEpzJoaXV27ddfvGrqPHZwa6Wtp12psJcuYSFC0TIsPMt+Z2H
 6D9raVBv4DXqdGNNRazAKkIq+H+wTuhxWoR2UcqR6II/uy4w2NmqpwEWg234kFlW2/gvZXEov
 HPbSCSjmP3L5J3Nded7jahulbAg2mZ1nPjkzP4e+8lZcN0fgPwZbTLdBwxWG/OspNxFCI1bwp
 GW88xHhyGCbSRFhXCpxX8k6aALg2ig9gT2dD/qvaUg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Am 13.01.23 um 22:31 schrieb Andy Shevchenko:
> On Fri, Jan 13, 2023 at 09:13:23PM +0100, Stefan Wahren wrote:
>> Am 13.01.23 um 18:10 schrieb Andy Shevchenko:
> ...
>
>>> v2: fixed compilation issues (LKP), Cc'ed to the author of original code
>>>
>>> Btw, the commit d2b67744fd99 ("pinctrl: bcm2835: implement hook for
>>> missing gpio-ranges") seems problematic in the fist place due to
>>> odd of_node_put() call. I dunno how that part had been tested, or
>>> how it's supposed to work, i.e. where is the counterpart of_node_get().
>>> Anyway this change drops it for good.
>> The countpart is in of_pinctrl_get(). I was just following the pattern like
>> in other drivers like gpio-rockchip. The original commit has been tested by
>> Florian Fainelli and me. I'm not sure if it's safe to drop it completely.
> Please, elaborate how of_pinctrl_get() increases refcount of the parameter.
> Maybe I'm looking into a wrong place?
>
>> Btw this is not the only platform affected by the gpio-ranges compatibility
>> issue [1].
> This is the only one that uses unnecessary added callback.

i didn't have access to any of the other platforms which were also 
affected. So i thought providing a general solution would be good idea. 
I wasn't aware of add_pin_ranges().

Since i was annoyed that nobody cared about DTB backward compatibility, 
i send out a RFC series to fix the GPIO hog regression which breaks the 
LEDs on the Raspberry Pi. Nobody complained about it.

>
>>> Perhaps we can check gpio-ranges property presence inside the GPIO
>>> library, so this ->add_pin_ranges() won't be called at all.
>> I thought this could be very platform specific, so i implemented a hook. But
>> yes my initial hack modified gpiolib-of [2].
> The point is that possibly documentation of ->add_pin_ranges() should be
> amended to take care of the cases like this. We don't need two or more
> hooks to do the same, esp. taking into account that OF specific doesn't
> cover other cases.
>
>> [1] - https://patchwork.kernel.org/project/linux-arm-msm/patch/20180412190138.12372-1-chunkeey@gmail.com/
>>
>> [2] - https://lore.kernel.org/linux-arm-kernel/75266ed1-666a-138b-80f1-ae9a06b7bdf3@i2se.com/
>>
>>> Also I would like to understand the dance around checking for pin
>>> control device. The original commit lacks of comments in the non-trivial
>>> code.
> Any comment on this?
Do you mean the NULL check? of_pinctrl_get() could return NULL, but 
pinctrl_dev_get_devname() directly access the dev member.
