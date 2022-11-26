Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A146063958F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 11:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiKZK6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 05:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKZK6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 05:58:35 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160A021E11;
        Sat, 26 Nov 2022 02:58:34 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id n20so15375027ejh.0;
        Sat, 26 Nov 2022 02:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pL7zVWiTsgNyl7j+jJ1knY9pWN9i54TOdRNgl4E4Rog=;
        b=NzLlasW+uIQaeQZYSk/zanc6x/CZPNAg/Rbko5xSu8N9BYs6UKv/oZV12ixtDMzpkb
         2xzYvV/unN67yNvTaWYmSwmL6B8HN2BcXl/3P/7E4YpuLmcAbzRRDhlSyPr35X9A6gNf
         LmKI7SI/XrabucH2FVgehvpJ/+ugqve2t9wwxUc6l52nhlK3gjzaUXKAnifErVEgk5bW
         xfSE6QavCPXSAHd4Uw39FfPY+c9FVOC+Tjzyn45lRXT5/YSdT1dFuAM9sB/4B2HkhsZR
         re8nfKxhu7AY6rPtkoFecLlV8/oCjXEEoAaLHu6zc5kQZLJqamGwakjRpEY7W7aN5lw1
         ErLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pL7zVWiTsgNyl7j+jJ1knY9pWN9i54TOdRNgl4E4Rog=;
        b=hx55m9RYnKDS9lUdFMoKS7HQxBjJknnOYpmBHvM5Cxp9LnMS2/FO8Aoet4/7D1PBoA
         CMLZRb7AyKZw9iv4xNXhx+Sy6cn+s0iOi1WnPRMeCSbFFsZ614OAB4356KjUeUWwyMAn
         Ge8a1YPhVt9EOYSLCKkhVC9veCI3miCfaY7NIwrrQICGsQvNH4GEkHVkXxe8bugXPLcS
         SL6/JLiC0Q9o4NMxQMw1ws5J91iHAxfHpfqLfB97QoQPubBoxLkFEA8HnsJvh4E8KNDu
         sr7UqkjWLtUHxMKgABO/fQIz4DBrNc+zJH/U2vz8PsPoZ5UFdMjIWJ6qSfHi10/w+9rz
         CXTQ==
X-Gm-Message-State: ANoB5pnkUr9/Jo3y6X1Dkiw6IEM4LGWFn98n699jYe4fRKrnvSo2k2O6
        xTKbpFrnha51KPI6EtPa/IPRNRISB6enC/SUii6ELnfrhwzR/g==
X-Google-Smtp-Source: AA0mqf5s4DghXx97Ml9tUaM+jCDRzhiBcVoLmfixm3Qpc+oaFMdCQHcECkKH6EQ50eCr7uF14dvTtaw7AonVS3NJWek=
X-Received: by 2002:a17:906:f113:b0:7ad:a030:7501 with SMTP id
 gv19-20020a170906f11300b007ada0307501mr36385998ejb.446.1669460313512; Sat, 26
 Nov 2022 02:58:33 -0800 (PST)
MIME-Version: 1.0
References: <20221125050807.1857479-1-shravan.chippa@microchip.com>
 <20221125050807.1857479-5-shravan.chippa@microchip.com> <Y4Dm//xBeYBijT4d@valkosipuli.retiisi.eu>
In-Reply-To: <Y4Dm//xBeYBijT4d@valkosipuli.retiisi.eu>
From:   shravan kumar <shravanmicrochip@gmail.com>
Date:   Sat, 26 Nov 2022 16:28:22 +0530
Message-ID: <CAOPdzVbXQLov1z1e3eqJ+nodtuc6GMj8LhQOAGkZJNw8VZ9h3Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] media: i2c: imx334: add default values in
 3840x2160@60 array
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     shravan kumar <shravan.chippa@microchip.com>,
        paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 9:50 PM Sakari Ailus <sakari.ailus@iki.fi> wrote:
>
> Hi Shravan,
>
> On Fri, Nov 25, 2022 at 10:38:05AM +0530, shravan kumar wrote:
> > From: Shravan Chippa <shravan.chippa@microchip.com>
> >
> > -If we have only one mode there is no need to update camera
> > reset(default) values when we initialize the camera
>
> How is this related to the patch?
>
> >
> > -If we have mutipull modes in this case we need all value to
> > write while camera initializing, so i will not effect other modes
> > while shifting dynamically
> >
> > -All default values for 3840x2160@60 updated becouse if we change
> > the mode we will not be able to recover the values, so add in
> > mode_3840x2160_regs[] array
>
> Please remove dashes in front of the paragrahs and use period in the end of
> sentences.
>
> Are these registers' values specific to this mode or are they different on
> different modes?

Yes, These are different for different mods
default values are matching with 3840x2160@60 mode
if we change mode dynamically we need to take care. so added.

Thanks,
Shravan

>
> >
> > Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> > ---
> >  drivers/media/i2c/imx334.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
> > index d3bb62c162b3..cd41df56ab7d 100644
> > --- a/drivers/media/i2c/imx334.c
> > +++ b/drivers/media/i2c/imx334.c
> > @@ -166,6 +166,7 @@ static const struct imx334_reg mode_3840x2160_regs[] = {
> >       {0x3288, 0x21},
> >       {0x328a, 0x02},
> >       {0x302c, 0x3c},
> > +     {0x302d, 0x00},
> >       {0x302e, 0x00},
> >       {0x302f, 0x0f},
> >       {0x3076, 0x70},
> > @@ -240,7 +241,26 @@ static const struct imx334_reg mode_3840x2160_regs[] = {
> >       {0x3794, 0x7a},
> >       {0x3796, 0xa1},
> >       {0x3e04, 0x0e},
> > +     {0x319e, 0x00},
> >       {0x3a00, 0x01},
> > +     {0x3A18, 0xBF},
> > +     {0x3A19, 0x00},
> > +     {0x3A1A, 0x67},
> > +     {0x3A1B, 0x00},
> > +     {0x3A1C, 0x6F},
> > +     {0x3A1D, 0x00},
> > +     {0x3A1E, 0xD7},
> > +     {0x3A1F, 0x01},
> > +     {0x3A20, 0x6F},
> > +     {0x3A21, 0x00},
> > +     {0x3A22, 0xCF},
> > +     {0x3A23, 0x00},
> > +     {0x3A24, 0x6F},
> > +     {0x3A25, 0x00},
> > +     {0x3A26, 0xB7},
> > +     {0x3A27, 0x00},
> > +     {0x3A28, 0x5F},
> > +     {0x3A29, 0x00},
> >  };
> >
> >  /* Supported sensor mode configurations */
>
> --
> Kind regards,
>
> Sakari Ailus
