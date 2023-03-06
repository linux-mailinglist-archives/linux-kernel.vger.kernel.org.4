Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B706ABB4A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjCFKMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjCFKMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:12:32 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963672411E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 02:11:59 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id s13so6012581uac.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 02:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678097497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HE+8pibrc6sLOKZ/p+IAeXF6PtsUcHKof8qicDz0pEE=;
        b=1Xa11x5NG/+5EyXyponCNpY/iT7IEHh+nUQqcH8K+W7kCOGp0w9zNaM7TzvrMD18qj
         gJlZkk6qYQ2usHpKSIsppIoPoDuWS9dws5PDyPsTmhpdMzfBHhg2PDd1RkxFFeyppuq4
         sBDDeCbdsuzm0DEzrP96snc4lBjVeAEhMisjN0O5odGZWfd/2SY9GbsIGFxuBJ0pICSA
         d2g3zRNoOCDcfn6VlHBUwe88IeuNGxGz8zVjhqaTL3ypTHLC5plbDrsnP3NfYgVAoIxa
         8NGR5q0Wfjt4ED/Tb7gwN557uIuSm1kNDDQ+N8/MNvgue7eahTXix45U7uIcfSBlcqWh
         sm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678097497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HE+8pibrc6sLOKZ/p+IAeXF6PtsUcHKof8qicDz0pEE=;
        b=Lh48D8DmmBOIwl53vfBnSTq99qfgDN8ANahrOdDnAUrskk/lptl+cG4AIGViN0T8Vu
         gJZW9RP5K3ir+uvQ5iBlgZCNuB2X1v5D3bqN7TePAdmkdvwVdfSoVjsSaMdp747kdGAK
         XPK564fSDREkLBOvPdPZFqRXaHbV2c4acP4rqGb8c5JWl5LiLZb628W/1JZGm6iOi2et
         S3qMvPHq+GCN2GtH7EfGD6K94UWuzAng+jFHbLnxeKKkCHNM7pNn9aTGt43a2VQikWkl
         AnP88JUyNss2q5bqi+Oz9g+h8Sq9LYjg1LnmtF9XNEI4zJ/PzQQRVrtrxWlMzrXXEH59
         Fm4g==
X-Gm-Message-State: AO0yUKUTQlo+0+APlKscdSSj5eYUIO/uadtuhg7/OCehq8252pSKA8+R
        eeGRSGMJSkLWivFeNs80c6BQLYAfbyNXAG5ZGZc7kg==
X-Google-Smtp-Source: AK7set/lNdPUCm9R6eAxbdwnbS9gYophK34alp7Zmw1mmE64hhaEUGnNRtwu5ZwMBRd5w6pA2mTOot12HagE90NaJoI=
X-Received: by 2002:a1f:914a:0:b0:401:4007:10c4 with SMTP id
 t71-20020a1f914a000000b00401400710c4mr6539107vkd.1.1678097497106; Mon, 06 Mar
 2023 02:11:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1677515341.git.william.gray@linaro.org> <bd501b4b5ff88da24d467f75e8c71b4e0e6f21e2.1677515341.git.william.gray@linaro.org>
In-Reply-To: <bd501b4b5ff88da24d467f75e8c71b4e0e6f21e2.1677515341.git.william.gray@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 6 Mar 2023 11:11:26 +0100
Message-ID: <CAMRc=MdkkO4DpdLJA4SkEbAFFrdDtfZBOtLFPmkTBnSMDz=gCQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] regmap-irq: Add no_status support
To:     broonie@kernel.org
Cc:     linus.walleij@linaro.org, andriy.shevchenko@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 5:54=E2=80=AFPM William Breathitt Gray
<william.gray@linaro.org> wrote:
>
> Some devices lack status registers, yet expect to handle interrupts.
> Introduce a no_status flag to indicate such a configuration, where
> rather than read a status register to verify, all interrupts received
> are assumed to be active.
>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> ---
> Changes in v2:
>  - Utilize memset32() to set status_buf for no_status case
>  - Utilize GENMASK() to generate status_buf mask
>  - Move no_status kernel doc line under runtime_pm line
>
>  drivers/base/regmap/regmap-irq.c | 22 +++++++++++++++-------
>  include/linux/regmap.h           |  2 ++
>  2 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regma=
p-irq.c
> index a8f185430a07..290e26664a21 100644
> --- a/drivers/base/regmap/regmap-irq.c
> +++ b/drivers/base/regmap/regmap-irq.c
> @@ -437,7 +437,10 @@ static irqreturn_t regmap_irq_thread(int irq, void *=
d)
>          * possible in order to reduce the I/O overheads.
>          */
>
> -       if (chip->num_main_regs) {
> +       if (chip->no_status) {
> +               /* no status register so default to all active */
> +               memset32(data->status_buf, GENMASK(31, 0), chip->num_regs=
);
> +       } else if (chip->num_main_regs) {
>                 unsigned int max_main_bits;
>                 unsigned long size;
>
> @@ -967,12 +970,17 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle=
 *fwnode,
>                         continue;
>
>                 /* Ack masked but set interrupts */
> -               reg =3D d->get_irq_reg(d, d->chip->status_base, i);
> -               ret =3D regmap_read(map, reg, &d->status_buf[i]);
> -               if (ret !=3D 0) {
> -                       dev_err(map->dev, "Failed to read IRQ status: %d\=
n",
> -                               ret);
> -                       goto err_alloc;
> +               if (d->chip->no_status) {
> +                       /* no status register so default to all active */
> +                       d->status_buf[i] =3D GENMASK(31, 0);
> +               } else {
> +                       reg =3D d->get_irq_reg(d, d->chip->status_base, i=
);
> +                       ret =3D regmap_read(map, reg, &d->status_buf[i]);
> +                       if (ret !=3D 0) {
> +                               dev_err(map->dev, "Failed to read IRQ sta=
tus: %d\n",
> +                                       ret);
> +                               goto err_alloc;
> +                       }
>                 }
>
>                 if (chip->status_invert)
> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> index a3bc695bcca0..c6d80d4e73de 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -1564,6 +1564,7 @@ struct regmap_irq_chip_data;
>   *                   the need for a @sub_reg_offsets table.
>   * @status_invert: Inverted status register: cleared bits are active int=
errupts.
>   * @runtime_pm:  Hold a runtime PM lock on the device when accessing it.
> + * @no_status: No status register: all interrupts assumed generated by d=
evice.
>   *
>   * @num_regs:    Number of registers in each control bank.
>   * @irqs:        Descriptors for individual IRQs.  Interrupt numbers are
> @@ -1630,6 +1631,7 @@ struct regmap_irq_chip {
>         unsigned int clear_on_unmask:1;
>         unsigned int not_fixed_stride:1;
>         unsigned int status_invert:1;
> +       unsigned int no_status:1;
>
>         int num_regs;
>
> --
> 2.39.2
>

Mark,

If this looks good to you, could you Ack it so that I can take it
through the GPIO tree?

Bart
