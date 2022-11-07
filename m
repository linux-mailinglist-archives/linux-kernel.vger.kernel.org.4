Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3614620457
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 00:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiKGX7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 18:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbiKGX7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 18:59:35 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891522F39E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 15:58:01 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id bj12so34307807ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 15:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=KoQ5mMnfTyshecGqJkuqumbdQJJkiGZBmemJrFJ11uw=;
        b=UfzZ/ZuV1of++iyZvgZsnjVciBfA9h8ArezX6IaVJ5PjjtF32/Oit4q/w/uPV51ghK
         JDR/dAiwN1vFT+bS9MRm9/mh9NMjv4OkDJU7NSg32Hjp+BaCBSdytFrDWrXvzz/YhFWv
         3neD/nQmclsimqMJvf2MBV6TAZoQQRdU3RFcdWMocyhqKp/jBquXxH+XE4+qiTL+VAQb
         Hr8iOw/vLk2kMNHQ7wCtbTAZzlxRvBn+AOKx5Owronr8q2o31aVZ1sScyLhbEcUbYk3O
         OV+tP+1HDlTnJDeGtVd7ZvZwGYd2yNph+cL82pMawzPwa2z+YEXNpdkV0HggiJeD3lJ9
         1C0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KoQ5mMnfTyshecGqJkuqumbdQJJkiGZBmemJrFJ11uw=;
        b=O3OKliL7zzWqrXmgwHbXA3M1anJFkXd1GqxuEvMJusnNdeq4eymLU0wZzlDF+aa0Aq
         gBEy/fYNYySMmqGBcFxbPHdtrhXpvAOsFGlhZIcR9ZMEzpsXaOzA95vVCezbWTZAKYLq
         euuagoQlR0aG2FDsPcVNnXbYqk3WrPTipRx2TYMfbYzPIsPMruDZiOzF1GlR/AvydvJr
         eZCweDt45s0OwbT0Gi/rzUwSYepg3rl2Pt9+kqsnxIVIm0iCp8viKTvRB3ObfMfvGVX+
         /YBUTCiubc2M6xR18+KEfFGOCY4w/p105Jy3HJxIG9GYjIl8U5kJXX12FHbgfOfU6dws
         EvDQ==
X-Gm-Message-State: ACrzQf1DWk41ej4LwdZs24VO9asPpbLSu/8j9tqHz1q5Gu2+GqLYAehF
        SKiMxPCVZ6y/FOK/wWbT2Ic=
X-Google-Smtp-Source: AMsMyM4RXRowhxVa8r+heyhKNkr4ZgVOkGzwZ8Xm9cnRiWb7W2GLFbj1GrNDi5caxUSz9wKTy5Vb5Q==
X-Received: by 2002:a17:907:a055:b0:7a4:48e1:65c3 with SMTP id gz21-20020a170907a05500b007a448e165c3mr49090169ejc.764.1667865478601;
        Mon, 07 Nov 2022 15:57:58 -0800 (PST)
Received: from localhost (188.29.219.200.threembb.co.uk. [188.29.219.200])
        by smtp.gmail.com with ESMTPSA id u12-20020a170906068c00b007919ba4295esm4004036ejb.216.2022.11.07.15.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:57:57 -0800 (PST)
References: <20221107202114.823975-1-y.oudjana@protonmail.com>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>
Subject: Re: [PATCH] regmap-irq: Use the new num_config_regs property in
 regmap_add_irq_chip_fwnode
In-reply-to: <20221107202114.823975-1-y.oudjana@protonmail.com>
Date:   Mon, 07 Nov 2022 23:58:01 +0000
Message-ID: <YRVTxVzmyHg9azsCXIwib22zfh2O3Xr6@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Yassine,

> Commit faa87ce9196d ("regmap-irq: Introduce config registers for irq
> types") added the num_config_regs, then commit 9edd4f5aee84 ("regmap-irq:
> Deprecate type registers and virtual registers") suggested to replace
> num_type_reg with it. However, regmap_add_irq_chip_fwnode wasn't modified
> to use the new property. Later on, commit 255a03bb1bb3 ("ASoC: wcd9335:
> Convert irq chip to config regs") removed the old num_type_reg property
> from the WCD9335 driver's struct regmap_irq_chip, causing a null pointer
> dereference in regmap_irq_set_type when it tried to index d->type_buf as
> it was never allocated in regmap_add_irq_chip_fwnode:

Whoops... My bad. Actually, d->type_buf shouldn't be accessed in this
configuration, the bug is in regmap_irq_set_type(). The access should
be guarded by "if (d->chip->type_in_mask || d->chip->num_type_reg)" to
prevent the NULL deref.

>
> Use num_config_regs in regmap_add_irq_chip_fwnode instead of num_type_reg,
> and fall back to it if num_config_regs isn't defined to maintain backward
> compatibility.
>
> Fixes: faa87ce9196d ("regmap-irq: Introduce config registers for irq types")
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  drivers/base/regmap/regmap-irq.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
> index 4ef9488d05cd..3de89795f584 100644
> --- a/drivers/base/regmap/regmap-irq.c
> +++ b/drivers/base/regmap/regmap-irq.c
> @@ -722,6 +722,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
>  	int i;
>  	int ret = -ENOMEM;
>  	int num_type_reg;
> +	int num_regs;
>  	u32 reg;
>
>  	if (chip->num_regs <= 0)
> @@ -796,14 +797,20 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
>  			goto err_alloc;
>  	}
>
> -	num_type_reg = chip->type_in_mask ? chip->num_regs : chip->num_type_reg;
> -	if (num_type_reg) {
> -		d->type_buf_def = kcalloc(num_type_reg,
> +	/*
> +	 * Use num_config_regs if defined, otherwise fall back to num_type_reg
> +	 * to maintain backward compatibility.
> +	 */
> +	num_type_reg = chip->num_config_regs ? chip->num_config_regs
> +			: chip->num_type_reg;

A chip that uses config regs doesn't need type_buf. If you check
regmap_irq_sync_unlock(), you'll see the contents of type_buf aren't
written to the registers unless num_type_reg > 0.

If type_in_mask is set, type_buf has a completely different meaning.
There are no type registers -- instead each trigger has its own IRQ
enable bit. The type_buf records which bit (= trigger type) is used
for the logical IRQ.

Regards,
Aidan

> +	num_regs = chip->type_in_mask ? chip->num_regs : num_type_reg;
> +	if (num_regs) {
> +		d->type_buf_def = kcalloc(num_regs,
>  					  sizeof(*d->type_buf_def), GFP_KERNEL);
>  		if (!d->type_buf_def)
>  			goto err_alloc;
>
> -		d->type_buf = kcalloc(num_type_reg, sizeof(*d->type_buf),
> +		d->type_buf = kcalloc(num_regs, sizeof(*d->type_buf),
>  				      GFP_KERNEL);
>  		if (!d->type_buf)
>  			goto err_alloc;
