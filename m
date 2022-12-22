Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903AB654683
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiLVTYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiLVTYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:24:12 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5003710574;
        Thu, 22 Dec 2022 11:24:07 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.22]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1McGp2-1oaBkV0WbM-00ch3S; Thu, 22 Dec 2022 20:23:47 +0100
Message-ID: <b710ab80-dbf8-a275-0bd5-1fc47d5b9526@i2se.com>
Date:   Thu, 22 Dec 2022 20:23:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/4] staging: vc04_services: Stop leaking platform
 device on error path
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adrien Thierry <athierry@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <error27@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20221222191500.515795-1-umang.jain@ideasonboard.com>
 <20221222191500.515795-2-umang.jain@ideasonboard.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20221222191500.515795-2-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:wkhbUhEGFd+YC6YMT2JP1+tXJhrxlgXS53ayd432cfW1mxpGac6
 QmJmS8Q9CXEOYY1DrLue7WhSBo4bUW+d5E1KLUsl1BUu8q8359XUeVzFweWtmAgzV5iw0ZF
 p6BBsf87+G0NjGC9vj6QSKr5Rg0Q6K4k5GNsdx1ZvU4CgUkP+EztJ+Tzd4IuF+ER890A1XY
 r643sfPazB36ipX7LIpJA==
UI-OutboundReport: notjunk:1;M01:P0:QTjoEqdTvvk=;/rEI4mmjAeo26f+wP76/Ygoi/s2
 fuqwCGys58WZH7RoHm3GYbHbv8oq8Xxu2h60OVNxJoW1m3r8KwdDysNPoVMAFiAq3w3aVyFy2
 nOsiWpOh7+Bl9jtP4CtI5GHCA3aR9C3InZhalzh3FBw2HGSOuV+FCEMfLH6LdUvl3xO714iyN
 vFJskXODCdwbS/ld7BEK6ezpY0LmKfVBkLTBr9USnBDPPDA0ZFg08Zv2MH2I/XqAGobqQPJ4r
 l6TJV9k6XpxLuCiqcb/767lg/KlziqA3V/lF2BLUr2HsQ/twJPzH57LGH2WYx4okEc8kUbkQE
 3kjaNyKziFVF1s5crlR6Di52wuJiHP5ey4yscTVs9NGBNyLdwL9Fdzq0EZctFhP1Drj7Fk9FN
 npPqGo4gv0hrohnLPQIk4lpSAA4Hl5cI0bRI3vBlODN5iyXVKIKNjy0D8J6fD2UIxrh75QvS6
 NasYJKk5m1TqDoWgdiMkAM3OehBpyiFRnP8jVVT/vcP31RL1a4NsfURwgP4K1qBoiP80Y61HQ
 mEX4T27Sa+nArVZRYlgIIsmHi+BVGNpPxPIHcRuLsEKciF1pAJdbSiyYJbnWH5DA+oPNyMHt7
 8cygGEXNn7oxwL7e4ZKgpeIHty74g5y7yNXoaqPs+zUm4x9Mb6W6pTWXBl+N50ZJv9vHrylnA
 RHPp2jWqKBTc8LGc7Tz2LujWGNrZqBQ1XKZoHps7ng==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Am 22.12.22 um 20:14 schrieb Umang Jain:
> vchiq driver registers the child platform devices in
> vchiq_register_child(). However, in the registration error code path,
> currently the driver is leaking platform devices by not destroying the
> return platform device. Plug this leak using platform_device_put() as
> mentioned in the documentation for platform_device_register().
>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index dc33490ba7fb..fc7ea7ba97b2 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -1779,6 +1779,7 @@ vchiq_register_child(struct platform_device *pdev, const char *name)
>   	child = platform_device_register_full(&pdevinfo);
>   	if (IS_ERR(child)) {
>   		dev_warn(&pdev->dev, "%s not registered\n", name);
> +		platform_device_put(child);
why should we free an error?
>   		child = NULL;
>   	}
>   
