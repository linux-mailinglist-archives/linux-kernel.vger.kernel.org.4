Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F456A3F27
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjB0KHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjB0KHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:07:14 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E791E2AD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 02:07:12 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id e37so3094227wri.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 02:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Nsxevlo9XIw5q3mnw9u9AhqR6NTYzhuz0YftWRMvHew=;
        b=NDbGN3et9/mnN3haPMhulR5jj0TgVur9/HfZJLKx7RpqwVKMVvvLwPomFxtk+cWJLC
         cssqKGCjA8zKncQ62qTTjpCkO4OBFV+kJlkdXvXXwESMBt42loumc6GkOhQ2vClarTHc
         6pHKUg3pYLsLLtjy54+/NshA76eehGsBKnADO7QQslYp3bvtYtHwzE1S/AC9BLjGcVcD
         qM0LhMT4Q6kyV7v9ydTy7cb2VwJLCuv+alc2xihBR2BlhG8KORpNSyRAnSztaLiJ2epq
         W2jY30TnN8V9jJnbrLKKrcoKxIegOuA379zGwl9gtQtykZb0vQnM9iK/nIL8O7KkDwx9
         Bo3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nsxevlo9XIw5q3mnw9u9AhqR6NTYzhuz0YftWRMvHew=;
        b=WDV+Bzj58kjvoLNe7cg/i5UVkVSZf23C24OLieq9tsw9WkId6tqAcgqbTUgIUWzPlZ
         uO7zt3+vSHqoFvY9vFNFH8gsFJniYW3/eyqUlcGCecKe+1zkn09hshU/tkbo5wW+g4OB
         7Jh8TBtjxcsuxY9cLYao2VjskLAm7SlFKVMi82gP8v/fxCpFGeV4M/I/9yeZ7TjX63qL
         gKObiwndtfoqsqqCflHG9tVQegI33RA8I2XiK9XIkidKSSAR43SmTCkIbYuN04whMIf/
         GmI1WVS44/26Gx/VI6IhZA/wcBOSeVE/VDdAmCWWGnLv6NzrjryMl0NOzl+6M5JwHSux
         HLcw==
X-Gm-Message-State: AO0yUKXlg6VnoAuwlZPD+WSX0GVFwY72POkEmX9QhEOk26UsKe1G8R9p
        8JKNrtHZYa6sKT9eUmn8qAjpww==
X-Google-Smtp-Source: AK7set/wJKbd9qt2mIOgNl6IK492UP4h+NstK+X13zcw/O3pvbJuLqEkrddz0dZwyZ2kvPGMTckXhg==
X-Received: by 2002:adf:dfce:0:b0:2c7:1b3e:362c with SMTP id q14-20020adfdfce000000b002c71b3e362cmr9316362wrn.42.1677492430808;
        Mon, 27 Feb 2023 02:07:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a200:b8a1:f5df:d07e? ([2a01:e0a:982:cbb0:a200:b8a1:f5df:d07e])
        by smtp.gmail.com with ESMTPSA id b10-20020adfee8a000000b002c54c8e70b1sm6908585wro.9.2023.02.27.02.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 02:07:10 -0800 (PST)
Message-ID: <c4803c08-c74e-ed04-3f21-aa63e6c2e734@linaro.org>
Date:   Mon, 27 Feb 2023 11:07:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3] mtd: rawnand: meson: initialize struct with zeroes
Content-Language: en-US
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
References: <20230227095906.754178-1-AVKrasnov@sberdevices.ru>
Organization: Linaro Developer Services
In-Reply-To: <20230227095906.754178-1-AVKrasnov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2023 10:59, Arseniy Krasnov wrote:
> This structure must be zeroed, because it's field 'hw->core' is used as
> 'parent' in 'clk_core_fill_parent_index()', but it will be uninitialized.
> This happens, because when this struct is not zeroed, pointer 'hw' is
> "initialized" by garbage, which is valid pointer, but points to some
> garbage. So 'hw' will be dereferenced, but 'core' contains some random
> data which will be interpreted as a pointer. The following backtrace is
> result of dereference of such pointer:
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
> 
> Fixes: 1e4d3ba66888 ("mtd: rawnand: meson: fix the clock")
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>   drivers/mtd/nand/raw/meson_nand.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> index 5ee01231ac4c..30e326adabfc 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -991,7 +991,7 @@ static const struct mtd_ooblayout_ops meson_ooblayout_ops = {
>   
>   static int meson_nfc_clk_init(struct meson_nfc *nfc)
>   {
> -	struct clk_parent_data nfc_divider_parent_data[1];
> +	struct clk_parent_data nfc_divider_parent_data[1] = {0};
>   	struct clk_init_data init = {0};
>   	int ret;
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
