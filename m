Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E776B5B8EDE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 20:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiINS1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 14:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiINS1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 14:27:20 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015197F12F;
        Wed, 14 Sep 2022 11:27:18 -0700 (PDT)
Received: from [192.168.1.138] ([37.4.248.23]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MRBWU-1ovg7f3USi-00NEK9; Wed, 14 Sep 2022 20:26:55 +0200
Message-ID: <ecfe17be-5d81-3456-9a86-77acc848f95f@i2se.com>
Date:   Wed, 14 Sep 2022 20:26:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/7] clk: bcm: rpi: Add a function to retrieve the
 maximum
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Emma Anholt <emma@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-arm-kernel@lists.infradead.org,
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
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220914181458.C6FCCC433C1@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Jdbn9l5qqOJBkSd1SY2bvvuP2Ym2CUnbxrLNTbE0hMBbezREtUX
 PONUJGkCg6O2kO1NrusmJNEgGKQnKBvjmf9dmooJloHaYQRvGe3sroXSsy8g2WAGT3Jk0t5
 JL70HuVKcivVe5Kyyw6V3hH/9qr6repOuUTitCbbdDhyfKhit25nNIds9qT9+EnJpZXpeJw
 GI54zvLErdpZbGKcI8/2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hskLTalVQtQ=:nbx/JndvyB55KImHVHVm1y
 3jIW3SqWIZDBMxHR7yGSoWA3Vrj2HkYEviCppmAh6Vopf25/5hH+oSgjRtTvOdI/eKuPkPknq
 B8XMDTpeSFMDxD6MCHU/xW1i6cTAs+CDUSSobtN5GxF9T+wlWZnXUyr5iolk7emO6GC2tKIGc
 KMpaUKr89GNV/5zkX13m12YcMIZJO6vFuwscl3daU79Zf+VBSG6iy84qR5Zm4h0tUUQINGlRp
 TZihTWfi4fulrvq3igEzOb375083nhYEJK8y73oGuHUcK/Yghej7k5EbVt/PWd8rgu/5rxqjA
 4wLeeWKX38IFWHtjokF3o2Kz5Ems6Ecb5xR+ZqNelwx5f4IBJJnQBSs7CrQVYgr4VV1e913Wp
 qs1UIcIo92I8yK1eFs67kEiLz9BHsMG20CXKhcCKl/GQOZGPY6Uj3gEDKm3E2CMrxD18A7mVB
 pBqnZUQABm2EiVO0A6AYJ90DqL/gcDrD/anV/Hq91EqK4GbEe/7b8DNABw/P5qWzD6wydYJ3U
 +vIGSA7jsBM77cBUwNgJKc7y4ZAVtEgbjiLcvTmZsgMk6sQD4klttZ4zpChpYrVrJPezztGPl
 mxJDmphEWhidMankvZsusM13kQUCELYwbsRSQt89LdAZZo3L40DoFZjlKDqiS854F4R9M+9Yn
 1PMHpeQWSPjys14PaQh2UyXSRpKoyfs/P0jbbYG4JAGoXo8b/+uLXima31WlqbO225jxS3Xkt
 aGRv7B8QqCQjFwsUdORJodiDmNbs9o7W3fSLq/wqG87rxl5F32j4GzYrlHV9XhynAucf40vgY
 soQtGWTNo13VCePbw2xFLYl1WYOkw==
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 14.09.22 um 20:14 schrieb Stephen Boyd:
> Quoting Stefan Wahren (2022-09-14 11:09:04)
>> Am 14.09.22 um 20:05 schrieb Stephen Boyd:
>>> Quoting Stefan Wahren (2022-09-14 10:45:48)
>>>> Am 14.09.22 um 17:50 schrieb Stephen Boyd:
>>>>> Furthermore, I wonder if even that part needs to be implemented.  Why
>>>>> not make a direct call to rpi_firmware_property() and get the max rate?
>>>>> All of that can live in the drm driver. Making it a generic API that
>>>>> takes a 'struct clk' means that it looks like any clk can be passed,
>>>>> when that isn't true. It would be better to restrict it to the one use
>>>>> case so that the scope of the problem doesn't grow. I understand that it
>>>>> duplicates a few lines of code, but that looks like a fair tradeoff vs.
>>>>> exposing an API that can be used for other clks in the future.
>>>> it would be nice to keep all the Rpi specific stuff out of the DRM
>>>> driver, since there more users of it.
>>> Instead of 'all' did you mean 'any'?
>> yes
> Why?
This firmware is written specific for the Raspberry Pi and not stable 
from interface point of view. So i'm afraid that the DRM driver is only 
usable for the Raspberry Pi at the end with all these board specific 
dependencies. Emma invested a lot of time to make this open source and 
now it looks that like that more and more functionality moves back to 
firmware.
