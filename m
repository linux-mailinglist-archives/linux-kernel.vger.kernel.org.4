Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAEC60CFE6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiJYPEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJYPEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:04:44 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B8225F6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:04:42 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-36d2188004bso55502687b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIDYBntCwcqigFWBzgzoBqb70qxdwV582Zvg4u+caGg=;
        b=InVT3jHI/Awmc21gp+s1UqMNg4jNLqJdXF53ZHwwEyGJocKfUzqw8eInMyNhM3KAVc
         pMk9kGm5B8U0MgnHiXstOq8ShGsgnTL6/S183GmIvc6D2Gk69bjgpRfgLW2TkNbhI4Mr
         9ZqOfsypoV/mWl0SVvJGXmv5GY1syl1UzwCMn1y/3lpcebveIa7dpATHkHMHKPC2T2IV
         IlxnPYyF4VQ2Qu4c7uMm6x21I1WBpsqU3xnHu3t5npP1XYEfExHnGKLKG8eVoH9bAVjz
         s115Rs0vvuhdGfrra0nQCyKuPXt4vvRUJOaxC6Yt/0oNKfOi0WIAeoXj/gTokpIqsvPQ
         Sa4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIDYBntCwcqigFWBzgzoBqb70qxdwV582Zvg4u+caGg=;
        b=QngO2wjMB/H+RiMHamTTbOaqXiOX2rRkBAiss1QBzF16Yz1VsKckuEQ44RmwCZoIUI
         uDl7nhAW8veDNmAvgg85P7RNAU5Md7Ech0Ht7iRz4cqWHKQwuJFbrYFhfAl25v4FElC4
         s4hW84kGVm3cMRKwb7ulwSBrJBdu8wXqP5CxiiTMfea/xqBKfnOnT4XlSmdhrt+wsIck
         1UD0n2l2/+dFGHWPS3XF50VQMnZtvLMgM6+ngdUjelsZqpo/Y5U5rDAK1vQ/+MsgEtf+
         41o3qQBSRSocEq3ywc+m3bsxISgjjgJDYdnqCQPhtlheriTXioh/MBPsI4oYi4GaR5Fb
         tLdg==
X-Gm-Message-State: ACrzQf2FVtS9vONZiBX98bt8ihvm7WK9YH/S57yUS6UAlbF8NRBd2NLh
        fwpLUevfOjmXK1mgoBxwOe8dFWk7/YKV0iiCYiIVuw==
X-Google-Smtp-Source: AMsMyM6CHFpp1/K+VWJa+LD9QuWxogeHwKezLlHYsMt14kD6I1ffPgi1e9y+ORltTt4NBsqrBAOGXWzTadGibxliRgc=
X-Received: by 2002:a0d:c981:0:b0:330:dc03:7387 with SMTP id
 l123-20020a0dc981000000b00330dc037387mr34492289ywd.380.1666710281795; Tue, 25
 Oct 2022 08:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20221021080231.1076-1-peter.ujfalusi@gmail.com>
In-Reply-To: <20221021080231.1076-1-peter.ujfalusi@gmail.com>
From:   Nicolas Frayer <nfrayer@baylibre.com>
Date:   Tue, 25 Oct 2022 17:04:30 +0200
Message-ID: <CANyCTtRy1noPo1NnFqJFUdFcwZEKKtg+ew6gO_up40S8KbaERA@mail.gmail.com>
Subject: Re: [PATCH] soc: ti: k3-ringacc: Allow the driver to be built as module
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc:     nm@ti.com, ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, grygorii.strashko@ti.com,
        khilman@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven. 21 oct. 2022 =C3=A0 09:53, Peter Ujfalusi
<peter.ujfalusi@gmail.com> a =C3=A9crit :
>
> The ring accelerator driver can be built as module since all depending
> functions are exported.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

Reviewed-by: Nicolas Frayer <nfrayer@baylibre.com>
Tested-by: Nicolas Frayer <nfrayer@baylibre.com>

> ---
>  drivers/soc/ti/Kconfig      |  2 +-
>  drivers/soc/ti/k3-ringacc.c | 29 ++++++++++++++++++++++++++---
>  2 files changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
> index 7e2fb1c16af1..e009d9589af4 100644
> --- a/drivers/soc/ti/Kconfig
> +++ b/drivers/soc/ti/Kconfig
> @@ -63,7 +63,7 @@ config TI_SCI_PM_DOMAINS
>           rootfs may be available.
>
>  config TI_K3_RINGACC
> -       bool "K3 Ring accelerator Sub System"
> +       tristate "K3 Ring accelerator Sub System"
>         depends on ARCH_K3 || COMPILE_TEST
>         depends on TI_SCI_INTA_IRQCHIP
>         help
> diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
> index f7bf18b8229a..e011412f2975 100644
> --- a/drivers/soc/ti/k3-ringacc.c
> +++ b/drivers/soc/ti/k3-ringacc.c
> @@ -7,7 +7,7 @@
>
>  #include <linux/dma-mapping.h>
>  #include <linux/io.h>
> -#include <linux/init.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> @@ -336,6 +336,11 @@ struct k3_ring *k3_ringacc_request_ring(struct k3_ri=
ngacc *ringacc,
>
>         mutex_lock(&ringacc->req_lock);
>
> +       if (!try_module_get(ringacc->dev->driver->owner)) {
> +               mutex_unlock(&ringacc->req_lock);
> +               return NULL;
> +       }
> +
>         if (id =3D=3D K3_RINGACC_RING_ID_ANY) {
>                 /* Request for any general purpose ring */
>                 struct ti_sci_resource_desc *gp_rings =3D
> @@ -380,6 +385,7 @@ struct k3_ring *k3_ringacc_request_ring(struct k3_rin=
gacc *ringacc,
>         return &ringacc->rings[id];
>
>  error:
> +       module_put(ringacc->dev->driver->owner);
>         mutex_unlock(&ringacc->req_lock);
>         return NULL;
>  }
> @@ -616,6 +622,8 @@ int k3_ringacc_ring_free(struct k3_ring *ring)
>  no_init:
>         clear_bit(ring->ring_id, ringacc->rings_inuse);
>
> +       module_put(ringacc->dev->driver->owner);
> +
>  out:
>         mutex_unlock(&ringacc->req_lock);
>         return 0;
> @@ -1450,6 +1458,7 @@ static const struct of_device_id k3_ringacc_of_matc=
h[] =3D {
>         { .compatible =3D "ti,am654-navss-ringacc", .data =3D &k3_ringacc=
_data, },
>         {},
>  };
> +MODULE_DEVICE_TABLE(of, k3_ringacc_of_match);
>
>  struct k3_ringacc *k3_ringacc_dmarings_init(struct platform_device *pdev=
,
>                                             struct k3_ringacc_init_data *=
data)
> @@ -1544,12 +1553,26 @@ static int k3_ringacc_probe(struct platform_devic=
e *pdev)
>         return 0;
>  }
>
> +static int k3_ringacc_remove(struct platform_device *pdev)
> +{
> +       struct k3_ringacc *ringacc =3D dev_get_drvdata(&pdev->dev);
> +
> +       mutex_lock(&k3_ringacc_list_lock);
> +       list_del(&ringacc->list);
> +       mutex_unlock(&k3_ringacc_list_lock);
> +       return 0;
> +}
> +
>  static struct platform_driver k3_ringacc_driver =3D {
>         .probe          =3D k3_ringacc_probe,
> +       .remove         =3D k3_ringacc_remove,
>         .driver         =3D {
>                 .name   =3D "k3-ringacc",
>                 .of_match_table =3D k3_ringacc_of_match,
> -               .suppress_bind_attrs =3D true,
>         },
>  };
> -builtin_platform_driver(k3_ringacc_driver);
> +module_platform_driver(k3_ringacc_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("TI Ringacc driver for K3 SOCs");
> +MODULE_AUTHOR("Grygorii Strashko <grygorii.strashko@ti.com>");
> --
> 2.38.1
>
