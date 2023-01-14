Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66E966AB1D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 12:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjANLIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 06:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjANLId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 06:08:33 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAE9659C;
        Sat, 14 Jan 2023 03:08:31 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MEmAX-1pVoSk1PzP-00GGUj; Sat, 14 Jan 2023 12:03:09 +0100
Message-ID: <55a87b32-803a-ceb3-4c31-ac818fe69596@i2se.com>
Date:   Sat, 14 Jan 2023 12:03:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 2/4] pinctrl: bcm2835: Remove of_node_put() in
 bcm2835_of_gpio_ranges_fallback()
Content-Language: en-US
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
 <20230113215352.44272-3-andriy.shevchenko@linux.intel.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230113215352.44272-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Q7jwe0zd23pn63SPpBcaoz+2C1kRVrLVSYSrwaom5qa3JoHNVN9
 36IOEe3aOYGi/q1SOOFknUgOaqHhASEgUWIvLtunSzbalX88EH5XEweU6tOH4E7olv2d/tC
 8q698TSPQ7ZwGJDxoiDFIpr/3I4kp2PMo0teLRIc9s5LantdcHPo2YKhyjtr8a4bP5Vev7L
 l+iq783ufTgYuWLrelJVg==
UI-OutboundReport: notjunk:1;M01:P0:zqzggyqo57g=;txd5mxU6QQXybbMnyfIaMytERhv
 lAlu4M7oZlEPmjSkTDZGbgHsV9wtfCbwGI8i/zNA2a7MXGAsjxbKG07A75y+v1fbP/18+Z/fG
 yUE7uo95dKmwHJ8UgCAhabicVmPLQDrgy2OpiUA93zXK0XdsNxRxrHGM82Gc2v+wCWAXF7JR2
 hI7fpP6ao9g/4F+frHWB56biB8ay5S29QYSjE3HBYQnZyQjAN5YJHt8EepxWmQ3THjFGvzsZ2
 buDsszNlJzp7TEdX4bsBpgXaHyu50rdiu7quFoIn5l5CMn53o5gjZiflaXXApA6nQc0rF5buY
 VsSoHMFgZVPa0a6c/PiWpVn8bRQmEfBSbyiSOwV+aeIkAYCeIWbpR5tJNQ1D3EA4J+CLkcIsW
 glSo2bmqdUFhvL0SsGekGaNc4SpSeAP706FzRA/nlnfu1fevt5gMOGiPbT+fo3ocwWO4xh9Bl
 u2McYsjljmo0ig2Mf8mSZ/Lk4p7ny79IQlJhYarQikg70VYZxzQXrvlwtnP/go4FmcLUrU8Kq
 XPHRmA6NvoDvp1NTHyzEzcEr/ZIjBe8OGE2w68ZJvEuTHTgoedpGvD4mi9RyyBeAnYZg6iF1+
 iO6DDKJ/mJhGmtcO5Gv5EDiy0Begnv1MRzpIz9iC6VIHraVwbSH5O5OzE2RDMWv3nAk6CkEDu
 Xi9NqC/0kxJWJeMk8hwZjkC3njgMBDlVh8Krg83SCg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Am 13.01.23 um 22:53 schrieb Andy Shevchenko:
> Remove wrong of_node_put() in bcm2835_of_gpio_ranges_fallback(),
> there is no counterpart of_node_get() for it.
>
> Fixes: d2b67744fd99 ("pinctrl: bcm2835: implement hook for missing gpio-ranges")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

thanks for fixing. It seems that i got confused by function name and 
usage in other driver.

Reviewed-by: Stefan Wahren <stefan.wahren@i2se.com>

> ---
>   drivers/pinctrl/bcm/pinctrl-bcm2835.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
> index 7857e612a100..c7cdccdb4332 100644
> --- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
> +++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
> @@ -363,8 +363,6 @@ static int bcm2835_of_gpio_ranges_fallback(struct gpio_chip *gc,
>   {
>   	struct pinctrl_dev *pctldev = of_pinctrl_get(np);
>   
> -	of_node_put(np);
> -
>   	if (!pctldev)
>   		return 0;
>   
