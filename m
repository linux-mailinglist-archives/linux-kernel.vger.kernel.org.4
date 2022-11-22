Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1157F633D6D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiKVNUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbiKVNUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:20:08 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9618363CE5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:20:06 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y24so15553274edi.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skymem-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOzIbrFIOKeJXJT4ID/MUCczRZmmy/MUgRjL2diXaTc=;
        b=exKArqMppRWvzwf3ELZJ+WIimhqTiI0eQUPBRXmFBulCFmneBcH9Du2QIac/RFgtB0
         ykN9/Me7ltc8TFWhmNzPiQ3qYQlvB1977JR+h9ccv4Lc6MXyLPV7gModyDCR2xukjiIf
         F9nSWGWjCA7aYQVANWKilM4s//f5IpoT8mTc6UZy8pKVGi+SjIufo3LoYBNsT8PLqBYO
         VA81jm9pDN0AZj2/68Zb88mPhJYrEiIS3D7ZXF2FqxLSrsPcxbW/088aIm8ubbbXiz4Y
         dTGGnv5rUGkfowZVNtCbk/5HsZzuvL9bnDmQ224JipcbMZrK7a0ze8FzosN5yb+e6zGt
         6yiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOzIbrFIOKeJXJT4ID/MUCczRZmmy/MUgRjL2diXaTc=;
        b=m2xflkTrPGl35LMwMEwfrEcB695gZ43GiRNN0AkAOwyWc7Ae7hrDtOH6iKcKCOmqpg
         twee/m5rNE3g0t5eQMN7T44vek50jjxIT46R2Bedw/f8qst/pZJ7TIjB9czB+dTWvOyu
         qewVvYL+6pNMERQ6jPohqhI4Lk+gROt8WBJ29j3XeiYIPgaHq/sIwJ90rP4LVIKHxf4R
         Yx+AMSWiGWhsr8uDMOXNYcSCkZBeG0s9Nq5249eOcP0bwRoo6FSr/QZqcPOCHOQLGj/A
         AeYKEFvBd7TuMr8ziReCqHeDgrZIdcj83ivQegJrfRFNwPJ0362lT3gpUgrMqNsWwvPM
         s52Q==
X-Gm-Message-State: ANoB5pn7/veU3rwDlfZCOU3mrWE1EazCw50z6e3tLzjixJQz5nlTclhJ
        jNQccNDG5dKoSLgiDcSzqBQ2kTpKgsCKoLnwKWNtTA==
X-Google-Smtp-Source: AA0mqf6RIQN3NAIPq8n53brtdf2c7RBwC0dm3F1Hg3vcuzZA+yL7BZxfmN50fae3ZbC8cj8CDbzO4XEicnkv+Bo+9Ew=
X-Received: by 2002:a05:6402:5d5:b0:464:fa1:9ece with SMTP id
 n21-20020a05640205d500b004640fa19ecemr21917763edx.262.1669123205084; Tue, 22
 Nov 2022 05:20:05 -0800 (PST)
MIME-Version: 1.0
References: <20221122131248.23738-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20221122131248.23738-1-lukas.bulwahn@gmail.com>
From:   Info Skymem <info@skymem.com>
Date:   Tue, 22 Nov 2022 14:19:54 +0100
Message-ID: <CAKvd=_ivRY1kDZYqygm2ZQCrcWV4f7RJjTdgw2i27gW9aUjCVA@mail.gmail.com>
Subject: Re: [PATCH] wifi: b43: remove reference to removed config B43_PCMCIA
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        b43-dev@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi,
thank you for your information.

On our website you can find email addresses of companies and people.
https://www.skymem.info

In short, it=E2=80=99s like Google for emails.

Best regards,
Robert,
Skymem team

On Tue, Nov 22, 2022 at 2:15 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wro=
te:
>
> Commit 399500da18f7 ("ssb: pick PCMCIA host code support from b43 driver"=
)
> removes the config B43_PCMCIA.
>
> Clean up the last reference to this removed config B43_PCMCIA in the
> b43_print_driverinfo() function.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  drivers/net/wireless/broadcom/b43/main.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wirel=
ess/broadcom/b43/main.c
> index 298febbdffc0..92ca0b2ca286 100644
> --- a/drivers/net/wireless/broadcom/b43/main.c
> +++ b/drivers/net/wireless/broadcom/b43/main.c
> @@ -5784,15 +5784,12 @@ void b43_controller_restart(struct b43_wldev *dev=
, const char *reason)
>
>  static void b43_print_driverinfo(void)
>  {
> -       const char *feat_pci =3D "", *feat_pcmcia =3D "", *feat_nphy =3D =
"",
> +       const char *feat_pci =3D "", *feat_nphy =3D "",
>                    *feat_leds =3D "", *feat_sdio =3D "";
>
>  #ifdef CONFIG_B43_PCI_AUTOSELECT
>         feat_pci =3D "P";
>  #endif
> -#ifdef CONFIG_B43_PCMCIA
> -       feat_pcmcia =3D "M";
> -#endif
>  #ifdef CONFIG_B43_PHY_N
>         feat_nphy =3D "N";
>  #endif
> @@ -5803,9 +5800,8 @@ static void b43_print_driverinfo(void)
>         feat_sdio =3D "S";
>  #endif
>         printk(KERN_INFO "Broadcom 43xx driver loaded "
> -              "[ Features: %s%s%s%s%s ]\n",
> -              feat_pci, feat_pcmcia, feat_nphy,
> -              feat_leds, feat_sdio);
> +              "[ Features: %s%s%s%s ]\n",
> +              feat_pci, feat_nphy, feat_leds, feat_sdio);
>  }
>
>  static int __init b43_init(void)
> --
> 2.17.1
>
>
> _______________________________________________
> b43-dev mailing list
> b43-dev@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/b43-dev
