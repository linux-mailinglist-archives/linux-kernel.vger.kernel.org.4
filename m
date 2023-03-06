Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7056AB9D6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjCFJ17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjCFJ15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:27:57 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BBD1FF7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:27:55 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id f31so8507875vsv.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 01:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678094874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u23YGdtz08BtcxfyGtNAoD9JB3zMPixrGi2haHM+DPQ=;
        b=O9WxhgaLFAaJgKfc9TwZLUBn2suBND7ZVszQ62VdCM9WMop+yAYsY5z8TaX+OVPxK6
         9EnOBMOllcOfJsN+APm3f+fhNzBSuhBIRtUrRpllolb8tDi6N3cYdkVHn6nq6ya0X84X
         g3iAM76zr5Ehv+A9SLpCB+snOTrNs1dO84FUbc2BFyOL88PVHz9hk4imkd8LPRALga++
         zCswG3CH2xRnUq2Il5w6RtwFYBy/PsQzqUAViEcfAixTbfH+FmdmvxyEwVMoSwmrqTJt
         NHP8hPlsQAeWfiDeNeFZgd0HY3FxPZmQ18l5D+hxrABh7frT+dA4EUtVmYh08WJnaXRO
         oeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678094874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u23YGdtz08BtcxfyGtNAoD9JB3zMPixrGi2haHM+DPQ=;
        b=786nevBzU/qTOpJUPMQ2kSBfBBQZ1pS4soaUQsiPjLqu04+RvpZvippUWEzXqHMJD7
         Ss3W22qHObl96Ol9wHeJZYvjUiCcRrdGwAt1SI5rUjX1gPvBxXMGh7l5kEdvgtGNunQk
         HbR7b4PR0dCcS8SC9LHOjWgvpjYprR52hzB/QajOLyqWd8o4c82pKRmd8hqDeoTZ16z0
         B4y57KXOfxpIABSz4TaPxoa/I3MND9EnntWPg85WdcIwCvvsJLa2eeiypIZlyz3a+3za
         nyMZlJkgQaEN2bPxBiBs/AUnOOGdC1bh3huj8wkA+SwvJeBCWxLofRc5AOFRHyBC43VK
         AkxQ==
X-Gm-Message-State: AO0yUKXcAyiixyX/ePTEkiMb6Qz9k4a2a94JnFSsPs4StVtNnDDJinFS
        MxBFRtOvr3RTzY4jGLTkXcpZBE7yps5rK/xcdYBIhw==
X-Google-Smtp-Source: AK7set9nV4Thuk0m6NGIRlR+kPaMTUIh7loOPqYPe95SB7yEHfXOmLn+JdlcC2Vl0p4+97hrzlagMIdGIgtkhqHyjak=
X-Received: by 2002:a67:e089:0:b0:411:f6d4:1be9 with SMTP id
 f9-20020a67e089000000b00411f6d41be9mr6647774vsl.5.1678094874626; Mon, 06 Mar
 2023 01:27:54 -0800 (PST)
MIME-Version: 1.0
References: <20230306024523.248216-1-dzm91@hust.edu.cn>
In-Reply-To: <20230306024523.248216-1-dzm91@hust.edu.cn>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 6 Mar 2023 10:27:43 +0100
Message-ID: <CAMRc=MdWn_XKZZp9cC056xi8O=ghrZnuX-GAWasWukzDjnM3ow@mail.gmail.com>
Subject: Re: [PATCH] drivers: i2c: remove dead code in davinci_i2c_probe
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Sekhar Nori <nsekhar@ti.com>, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 3:48=E2=80=AFAM Dongliang Mu <dzm91@hust.edu.cn> wro=
te:
>
> From the comment of platform_get_irq, it only returns non-zero IRQ
> number and negative error number, other than zero.
>
> Fix this by removing the if condition.
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  drivers/i2c/busses/i2c-davinci.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-da=
vinci.c
> index c836cf884185..9750310f2c96 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -764,11 +764,8 @@ static int davinci_i2c_probe(struct platform_device =
*pdev)
>         int r, irq;
>
>         irq =3D platform_get_irq(pdev, 0);
> -       if (irq <=3D 0) {
> -               if (!irq)
> -                       irq =3D -ENXIO;
> +       if (irq < 0)
>                 return dev_err_probe(&pdev->dev, irq, "can't get irq reso=
urce\n");
> -       }
>
>         dev =3D devm_kzalloc(&pdev->dev, sizeof(struct davinci_i2c_dev),
>                         GFP_KERNEL);
> --
> 2.39.2
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
