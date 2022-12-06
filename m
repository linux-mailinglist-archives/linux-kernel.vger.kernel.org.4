Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BD7644D9C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 21:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiLFU7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 15:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLFU7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 15:59:42 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FFB2F028;
        Tue,  6 Dec 2022 12:59:40 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id d6so25583221lfs.10;
        Tue, 06 Dec 2022 12:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UpMc+/BC3gmHVc2NYwVAUDbM6fSZdcDC5PUMhunP1hU=;
        b=UxathvI7GH0Ei6fmKQkz3kX1KEysFTgkL2egw5WFbAV0U0rkNvK0emEJD3iLFOFioM
         r9QHlvLU8Ml6EhbW0DJF09b7GUPeKrfaFM3YH75vDphBAFItnhEjJe3isGwaDAxFwAJ/
         ZV3A2kZ99LdSj6UQx+Xi0Dn1+5SL3vGYO2/Nw5GAYvmZ0tXYBKfxkZIl2Fm61HT5IF4k
         thiHUoyZHiNPX3HGLn0fMcl1tpM5C6xz1m+hw4pXOOJZMoOwC8/A1JiHqv4DSpwdmViK
         /Rmj7h9/py+GL+OHKteZktQFvp+QAwdJgXBMvcMGS57BetAOmUvzQ6ptwfU5UpI55Em8
         WW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpMc+/BC3gmHVc2NYwVAUDbM6fSZdcDC5PUMhunP1hU=;
        b=a3G/5C5dvecSBKB8FPJ/O5nngjgR6qV2CQtvCh+p9V7PkSUaRu3+vk2o6iaigY2AGp
         DkuNUEMSK6/EL0nrJu2ZjndFSLOjRM5g3kNG4Qhzfz75VHoXen6zHJbaiO0l6wNmTKyh
         dSxSBNoFVhUAGHAMuGp4Qv2gNJdbcyp6hUwfsw5uet8UvSOyp1C7eee1G0ucY3jhvEMw
         AdLp36dztIeKX4aJ90qt1urs8S0rwgRYZrWsl+mbh87sHVdUKm61Nya+/U1bJ7gYivx9
         nKLeY1ZXEEILa/A9YVAHt5cszP3AqfiM/sHfUL87C32mRt6qEXMMaB1taLfdJICiHMYb
         cXKQ==
X-Gm-Message-State: ANoB5pmtrioVDuZJME1eGuDxLoNKR1sVXA41xl6KP9K75YWYIUrmH/LH
        icfXH5RBsQFtqvkIT134eAs=
X-Google-Smtp-Source: AA0mqf5272ez/Ay/mUTXPEX4pG6QcJI5pNzKnuFaJP7uMwV3WKGB8ACg6a6Oajd3PrsPQp5gjZRJNg==
X-Received: by 2002:ac2:44c6:0:b0:4b5:7640:1a with SMTP id d6-20020ac244c6000000b004b57640001amr3255238lfm.140.1670360379057;
        Tue, 06 Dec 2022 12:59:39 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id y2-20020a0565123f0200b004a46a9cebe2sm2604588lfa.289.2022.12.06.12.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 12:59:38 -0800 (PST)
Date:   Tue, 6 Dec 2022 23:59:36 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>, hdegoede@redhat.com,
        axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        Sergey.Semin@baikalelectronics.ru, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ata: libahci_platform: ahci_platform_find_clk: oops,
 NULL pointer
Message-ID: <20221206205936.m7qkfk777s46vh54@mobilestation>
References: <20221206083416.705111-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206083416.705111-1-anders.roxell@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 09:34:16AM +0100, Anders Roxell wrote:
> When booting a arm 32-bit kernel with config CONFIG_AHCI_DWC enabled on
> a am57xx-evm board. This happens when the clock references are unnamed
> in DT, the strcmp() produces a NULL pointer dereference, see the
> following oops, NULL pointer dereference:
> 
> [    4.673950] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [    4.682098] [00000000] *pgd=00000000
> [    4.685699] Internal error: Oops: 5 [#1] SMP ARM
> [    4.690338] Modules linked in:
> [    4.693420] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc7 #1
> [    4.699615] Hardware name: Generic DRA74X (Flattened Device Tree)
> [    4.705749] PC is at strcmp+0x0/0x34
> [    4.709350] LR is at ahci_platform_find_clk+0x3c/0x5c
> [    4.714416] pc : [<c130c494>]    lr : [<c0c230e0>]    psr: 20000013
> [    4.720703] sp : f000dda8  ip : 00000001  fp : c29b1840
> [    4.725952] r10: 00000020  r9 : c1b23380  r8 : c1b23368
> [    4.731201] r7 : c1ab4cc4  r6 : 00000001  r5 : c3c66040  r4 : 00000000
> [    4.737762] r3 : 00000080  r2 : 00000080  r1 : c1ab4cc4  r0 : 00000000
> [...]
> [    4.998870]  strcmp from ahci_platform_find_clk+0x3c/0x5c
> [    5.004302]  ahci_platform_find_clk from ahci_dwc_probe+0x1f0/0x54c
> [    5.010589]  ahci_dwc_probe from platform_probe+0x64/0xc0
> [    5.016021]  platform_probe from really_probe+0xe8/0x41c
> [    5.021362]  really_probe from __driver_probe_device+0xa4/0x204
> [    5.027313]  __driver_probe_device from driver_probe_device+0x38/0xc8
> [    5.033782]  driver_probe_device from __driver_attach+0xb4/0x1ec
> [    5.039825]  __driver_attach from bus_for_each_dev+0x78/0xb8
> [    5.045532]  bus_for_each_dev from bus_add_driver+0x17c/0x220
> [    5.051300]  bus_add_driver from driver_register+0x90/0x124
> [    5.056915]  driver_register from do_one_initcall+0x48/0x1e8
> [    5.062591]  do_one_initcall from kernel_init_freeable+0x1cc/0x234
> [    5.068817]  kernel_init_freeable from kernel_init+0x20/0x13c
> [    5.074584]  kernel_init from ret_from_fork+0x14/0x2c
> [    5.079681] Exception stack(0xf000dfb0 to 0xf000dff8)
> [    5.084747] dfa0:                                     00000000 00000000 00000000 00000000
> [    5.092956] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    5.101165] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    5.107818] Code: e5e32001 e3520000 1afffffb e12fff1e (e4d03001)
> [    5.114013] ---[ end trace 0000000000000000 ]---
> 
> Add an extra check in the if-statement if hpriv-clks[i].id.
> 
> Fixes: 6ce73f3a6fc0 ("ata: libahci_platform: Add function returning a clock-handle by id")
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/ata/libahci_platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index ddf17e2d266c..b9e336bacf17 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -109,7 +109,7 @@ struct clk *ahci_platform_find_clk(struct ahci_host_priv *hpriv, const char *con
>  	int i;
>  
>  	for (i = 0; i < hpriv->n_clks; i++) {
> -		if (!strcmp(hpriv->clks[i].id, con_id))
> +		if (hpriv->clks[i].id && !strcmp(hpriv->clks[i].id, con_id))

I also thought to add the con_id check or if it's null then return a
first clock descriptor with null id. But since there is no users of
such semantic at this stage it's ok to accept the fix as is. It will
at least prevent the kernel from oopsing on the unnamed clocks.
So thanks for the patch

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

>  			return hpriv->clks[i].clk;
>  	}
>  
> -- 
> 2.35.1
> 
> 
