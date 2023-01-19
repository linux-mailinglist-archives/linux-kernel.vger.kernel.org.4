Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFC8673FF7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjASR3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjASR27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:28:59 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13EE7E4A6;
        Thu, 19 Jan 2023 09:28:48 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mzyi6-1oXrRJ0Xt0-00x5OC; Thu, 19 Jan 2023 18:28:31 +0100
Message-ID: <b16c0134-b8a6-573c-4ad9-c4620fc98d5c@i2se.com>
Date:   Thu, 19 Jan 2023 18:28:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 0/4] gpiolib: get rid of exessive
 ->of_gpio_ranges_fallback()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
References: <20230113215352.44272-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230113215352.44272-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Z/9yRM+iSc0SiMv8AvZINVzfAQcaGFv+QRJ7oGfjFC54VAuylI3
 SZ+qYsKsxV8vBPVklmO4e1rMYuo9nzLtQhBbfcyPxiTGNNLskPL/KZ+0SYCJPYzgZxt7m4k
 AmbL8bbXoSuf6KFDx1NtrDeLJHRh2jrGqXh0fDqkD4yTdwFkrjWH/vFMvLT/3Mq0qrAtSor
 ARoRFfmTZoHfPqrRp5NIQ==
UI-OutboundReport: notjunk:1;M01:P0:YJCObP7Zmsg=;+MbDRnIRKM8+p3rT3vi2DFL1Bgf
 0wt5aJSJ1ijrbN4WRR/lMzwLoMM+st/vv34oy7RQz9lPj3xZboy1H5uVuSthsvFP8xl5IlwyV
 DjbATypWLO8mb2Nbu7A1icqezGH0Dcyl1RMQ/Vmf6ESOn3Nz0tN8LqIA0jRhoi+b3AqxscjXm
 pm6dDJzUyQAllVZH6x3DgiJ8Xqqq32Fnv1kmw9kJmvegs7McGvsmUGdxScU48dtKKsS/feFwk
 3W9GD5pCdArZq8R5+DMKV4l4Bsv0GQm0tBpQXT3LJfAYqZk4utKpw5l/yqTsxP24uTQiQ2VYX
 VU/e/n07+RHZ8cswk2xo9d/0K0mReEjkSf0YTFBUc7zunD8KripOQ1/D354LNSjQKNuu9AKvv
 PSLO4aHXTEr6gDDxHwjmO6oplpNMyN3eNtKKAAJYdGnDSF8bCsownj0qSBAIt5cwUwXky9tR1
 fUeculjxGrCiqkxCwTBTQXH/LCAkqWXP03wChJrXUZGI/JYEmy+7RWNXokV70DwHbK9cQrCty
 xe/57X/C9/qISYHBghaddqf/Td5MB+vnwYmVeeRpOIyjOUBuk1eXYE89MPtCxQC+pjN4eW8Se
 Km3LnbdjDAhbbGBBYcxYsqK8qLaUwhXU+r7AGuezaKbtwuRAzPw2bkHo7xdDaYkaj6Hj++/Wm
 2K8eJBKK45VvLdxKnN29b7x3xgJWEMx7xOFUYAgusQ==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Am 13.01.23 um 22:53 schrieb Andy Shevchenko:
> The ->of_gpio_ranges_fallback() repeats the idea that lies behind
> ->add_pin_ranges(), while the latter covers more cases that the former
> hook. Drop the former one for good.

i successful tested booting of this series with multi_v7_defconfig on 
Raspberry Pi 4 (with and without gpio-ranges in DTB):

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

>
> Changelog v3:
> - moved check of the property presense to GPIO library
> - split out the refcount fix in a separate patch
> - added cover letter
>
> Andy Shevchenko (4):
>    gpiolib: Check "gpio-ranges" before calling ->add_pin_ranges()
>    pinctrl: bcm2835: Remove of_node_put() in
>      bcm2835_of_gpio_ranges_fallback()
>    pinctrl: bcm2835: Switch to use ->add_pin_ranges()
>    Revert "gpiolib: of: Introduce hook for missing gpio-ranges"
>
>   drivers/gpio/gpiolib-of.c             |  5 -----
>   drivers/gpio/gpiolib.c                |  8 ++++++++
>   drivers/pinctrl/bcm/pinctrl-bcm2835.c | 10 ++++------
>   include/linux/gpio/driver.h           | 12 ------------
>   4 files changed, 12 insertions(+), 23 deletions(-)
>
