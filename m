Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F30C699BE7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjBPSJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBPSJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:09:39 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D155505EF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:09:37 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 84DB95FD10;
        Thu, 16 Feb 2023 21:09:35 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1676570975;
        bh=z5UG361hCIWFEkGyGnVDugO/SaElkWLy0fUsxj+i3NU=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=d0wvCXoFrHsB9M1elFZFVOHrP2h1+bgtqOUAgW5xhTTkDMFkwtkayiziGyEuxNBaK
         s0MqPpa9AtmOesCgcDHqjwmFjg8zxmEJwyk/murcRHsN9Ke0Vr8jS+apJvk7zdeHlD
         y8iyxXG69iUJlvdGshhRaJqeHgxNfLmarC+I/RFFAaGQhVtbgw5HxwVAwBxIvkwpVe
         1wNT8iFVZL9yQ2ZwK2peNGf4G7wINkszNA12o3jNXOWsuAybB+2Aj5rhXHEc8R447e
         5ZvDHGeHwkNZwRD35WmyVFEQeIeBdZCkJZ84h6MAekpSqdQZ2azuCKBMsUgSSHuivR
         KsJgIjDN1eDhQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu, 16 Feb 2023 21:09:34 +0300 (MSK)
Date:   Thu, 16 Feb 2023 21:09:34 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     =?utf-8?B?0JrRgNCw0YHQvdC+0LIg0JDRgNGB0LXQvdC40Lk=?= 
        <AVKrasnov@sberdevices.ru>
CC:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH] mtd: rawnand: meson: initialize struct with zeroes
Message-ID: <20230216180934.52xup4bvvmttzwpz@CAB-WSD-L081021>
References: <8881a365-e218-916a-e68d-d889797279be@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8881a365-e218-916a-e68d-d889797279be@sberdevices.ru>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/02/16 08:39:00 #20868660
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 08:57:32PM +0300, Краснов Арсений wrote:
> This structure must be zeroed, because it's field 'hw->core' is used as
> 'parent' in 'clk_core_fill_parent_index()', but it will be uninitialized.
> The following backtrace is result of the dereference of such pointer:
> 
> [    1.081319]  __clk_register+0x414/0x820
> [    1.085113]  devm_clk_register+0x64/0xd0
> [    1.088995]  meson_nfc_probe+0x258/0x6ec
> [    1.092875]  platform_probe+0x70/0xf0
> [    1.096498]  really_probe+0xc8/0x3e0
> [    1.100034]  __driver_probe_device+0x84/0x190
> [    1.104346]  driver_probe_device+0x44/0x120
> [    1.108487]  __driver_attach+0xb4/0x220
> [    1.112282]  bus_for_each_dev+0x78/0xd0
> [    1.116077]  driver_attach+0x2c/0x40
> [    1.119613]  bus_add_driver+0x184/0x240
> [    1.123408]  driver_register+0x80/0x140
> [    1.127203]  __platform_driver_register+0x30/0x40
> [    1.131860]  meson_nfc_driver_init+0x24/0x30

I suppose it would be better to have 'fixes' tag here, like:

Fixes: 1e4d3ba66888 ("mtd: rawnand: meson: fix the clock")

> 
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  drivers/mtd/nand/raw/meson_nand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> index 5ee01231ac4c..30e326adabfc 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -991,7 +991,7 @@ static const struct mtd_ooblayout_ops meson_ooblayout_ops = {
>  
>  static int meson_nfc_clk_init(struct meson_nfc *nfc)
>  {
> -	struct clk_parent_data nfc_divider_parent_data[1];
> +	struct clk_parent_data nfc_divider_parent_data[1] = {0};
>  	struct clk_init_data init = {0};
>  	int ret;

-- 
Thank you,
Dmitry
