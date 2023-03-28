Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97BC6CBA71
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjC1JYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjC1JYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:24:18 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448FB5B9C;
        Tue, 28 Mar 2023 02:24:13 -0700 (PDT)
Received: from [192.168.1.155] ([92.225.143.37]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MGi6m-1pc5Lj18Gw-00DswJ; Tue, 28 Mar 2023 11:23:17 +0200
Message-ID: <716362db-7355-7f10-6b8b-ee59ad22db41@metux.net>
Date:   Tue, 28 Mar 2023 11:23:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] drivers/gpio : Remove redundant
 platform_set_drvdata().
Content-Language: tl
To:     Lizhe <sensor1010@163.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl, geert+renesas@glider.be, info@metux.net,
        rjui@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        f.fainelli@gmail.com, sbranden@broadcom.com, shc_work@mail.ru,
        j-keerthy@ti.com, hoan@os.amperecomputing.com,
        fancer.lancer@gmail.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, kaloz@openwrt.org,
        khalasa@piap.pl, keguang.zhang@gmail.com, daniel@thingy.jp,
        romain.perier@gmail.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, grygorii.strashko@ti.com,
        ssantosh@kernel.org, khilman@kernel.org, mani@kernel.org,
        ludovic.desroches@microchip.com, andy@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, jonathanh@nvidia.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, michal.simek@xilinx.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-unisoc@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-tegra@vger.kernel.org
References: <20230319115925.1317654-1-sensor1010@163.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
In-Reply-To: <20230319115925.1317654-1-sensor1010@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ujdla9v/iyjL3L1Cm+XjJDsalTUKxgU24jiOGfnRDDlv+6BxEBk
 28H46E0XI7p7p9qVjalxDWlIy6xfzIDACEQPVcoEKmfJeBTZUDYzWzsBgiTF5sK7xKSXsMU
 6Ne5GFLPg3iF8SZpcov4SyijjbvxZuHNNahhvxW/b6vh/XwvP38kR4/h5+o9k+BYKi+yuY4
 IR9s2WsFAuBtirUVyTm1A==
UI-OutboundReport: notjunk:1;M01:P0:MoGEpRKG1bo=;5T7PdYmcLG5pYfzDf8wQM6gX+1u
 u6+1T7eGv8suLuqhFsVIQetTiIHhQeLdoWrYLOJykRD4kcwK9iIB1R2Ca6YAta5bggT8ITXWp
 kcxl0zTa4ujpJwuro9HKDULm2lmwI2kytGe/Zytpl54o/yMIIfUHys1TRdUugR2GX5JoEVusy
 m7NL6/bKinALAavCcvyl+yWz8iEFkUCGAjBkwRq6GcK+Vfn59Qf7Ix0NssyHKIRXiJfCpVcYl
 7WLb8jY8RcqzNuiTT5NZi/D4uEktukiHS3sOhJzbf5a+yfLg8nyEdQeUaPxU7XogDjK1cGIM/
 bC0jFNv8FWtQgNYeKhBQsMaLJlgnU4mLgu4ZlCnW0VNCVrkT/t77bdnYZ+KGrOMV1hX+5ytNP
 dsbmjC+D8CuFxyPhuO51HbjyV24/bG7u/ai8V0eGP7FsUxZTQ90poeILm6KZOgK51Kw3FAQBc
 gUDTVLam3E6T6uEH35Ub1whNqJ/lmrSwrzT+Z+ytclVP+A6Y5ePVGynFAYBCpEsZ7qgJECWYH
 1haSxsR64jHGcikbbyr5rWTWWvJo93rP4HizhuoFUdiHRjpcjDIhHCAMJ/uu+wWQ+3GznrxTb
 PuQWQXNZ9dTYb627WNCdmUGhCKlnju8FIAE5EJGm2qPT8TFuZldhrSZWZ1sdxgKTFRe7VoUBk
 AGpHH9uEKGUANhP09xvX5f9fbGpGuwMmmasM0yXdMA==
X-Spam-Status: No, score=0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.03.23 12:59, Lizhe wrote:

Hi,

> platform_set_drvdata() is redundant in these functions.
> the purpose of calling this function is to place data
> in *driver_data. but the data is not retrieved in these
> functions

I appreciate your contribution, but I have to NAK for the gpio-amd-fch 
driver: it would at least create a memleak (driver core can't free the
driver_data when the driver is unloaded).

In general, patches to drivers should be splitted per driver, unless 
there's a hard reason to do otherwise. That's important for the
individual maintainers being able to review patches to their drivers.
If each maintainer can only ack on pieces of the patch, somebody else
would need to split out those things that could be picked. Really too
complicated.


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
