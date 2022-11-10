Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BDA62433E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiKJN3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiKJN3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:29:44 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDBF2B1B3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:29:37 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id h10so1345278qvq.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EdhP8BcDkdu4NYZf2t0eCebWK07n0XJPuIalbtX9Hyg=;
        b=lnANyr3Ti2FkxxiAeDVj0aN7J3CiHmuEuPMhfaSOHlFRXrPLPk4ZGnMpOfXl0hQuIL
         j54348+RAEgPviVpy9lOq9Vp+ppBrl1+fotarDQwdEPPAYfqPwTm6WRv2xrZiAt0q3gn
         thR6zDxFIcFnv+XEvceEu1EW+wopZ7vmY5P6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EdhP8BcDkdu4NYZf2t0eCebWK07n0XJPuIalbtX9Hyg=;
        b=B4pFENwZoKlsCviErRpyG1qD2WloA7LueItVhDLkHIaSUQ5l7KXNEz3MsvzdsjmqIR
         8DEheJX1DtnhBLiT0F7d4ogrSy2/3pY3g7veZBTBCRRmVlSRLIefFt7E0oqQite5XrSN
         OsCLoYXLIcThJ2OgHwSGHFItW7L9MJpRl7Wq+LkH/eiNKDSEKiMs1mfCsGUcwlENfSix
         ZQxISoKrG0KCYiXoddjoBXCh2Q1EGF45gwAA612t/J5DG13FqDO4pRC7o+NcsDJ4Tl8t
         Mfh/AvnQY0oL0x5+q+cQhjwHb0mGiZikTssmGgdvfnWiQnOrdWHT3Mo0TPuJWwvsNLag
         hyXQ==
X-Gm-Message-State: ACrzQf3+BtvAMG1I4F4FrU2NL/Fm51yvgEK5vsS3yuCJEawbsAbmiWMi
        ThjzymDu0lGdKO+jPJSRyXD1OqfpQX01J3CI9N3fwBDkFblmxD9LE7w=
X-Google-Smtp-Source: AMsMyM6yikR7uCCO8X2hhqL4WAmquMxf1rpejO6f7BuzsIoecYsi8cW2uJnj5ZMmzeZ7mdS98P6K8ez1qbKLbsb/zjA=
X-Received: by 2002:a05:6214:62e:b0:4bb:7f43:1fd5 with SMTP id
 a14-20020a056214062e00b004bb7f431fd5mr58602950qvx.112.1668086976813; Thu, 10
 Nov 2022 05:29:36 -0800 (PST)
MIME-Version: 1.0
References: <20221110101241.10576-1-subhajit.ghosh@vixtechnology.com>
In-Reply-To: <20221110101241.10576-1-subhajit.ghosh@vixtechnology.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Thu, 10 Nov 2022 21:29:25 +0800
Message-ID: <CAJCx=g=qRd+WaCLOHwnEjg1Myg4Ng=PK0sxcGgEG9VT+VpondA@mail.gmail.com>
Subject: Re: [PATCH] iio: light: apds9960: Fix iio_event_spec structures
To:     Subhajit Ghosh <subhajit.ghosh@vixtechnology.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 6:13 PM Subhajit Ghosh
<subhajit.ghosh@vixtechnology.com> wrote:
>
> There is only one interrupt enable option for both ALS low and high
> thresholds, and one for both Proximity low and high thresholds.
>
> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@vixtechnology.com>
> ---
>  drivers/iio/light/apds9960.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index 4141c0fa7bc4..df9ccbcf0ffe 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -223,14 +223,16 @@ static const struct iio_event_spec apds9960_pxs_event_spec[] = {
>         {
>                 .type = IIO_EV_TYPE_THRESH,
>                 .dir = IIO_EV_DIR_RISING,
> -               .mask_separate = BIT(IIO_EV_INFO_VALUE) |
> -                       BIT(IIO_EV_INFO_ENABLE),
> +               .mask_separate = BIT(IIO_EV_INFO_VALUE),

Probably more concise to use the following, and you won't need to add
an additional item to the structs.

   .mask_separate = BIT(IIO_EV_INFO_VALUE),
   .mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE),

>         },
>         {
>                 .type = IIO_EV_TYPE_THRESH,
>                 .dir = IIO_EV_DIR_FALLING,
> -               .mask_separate = BIT(IIO_EV_INFO_VALUE) |
> -                       BIT(IIO_EV_INFO_ENABLE),
> +               .mask_separate = BIT(IIO_EV_INFO_VALUE),
> +       },
> +       {
> +               .type = IIO_EV_TYPE_THRESH,
> +               .mask_separate = BIT(IIO_EV_INFO_ENABLE),

Same here.

- Matt

>         },
>  };
>
> @@ -238,14 +240,16 @@ static const struct iio_event_spec apds9960_als_event_spec[] = {
>         {
>                 .type = IIO_EV_TYPE_THRESH,
>                 .dir = IIO_EV_DIR_RISING,
> -               .mask_separate = BIT(IIO_EV_INFO_VALUE) |
> -                       BIT(IIO_EV_INFO_ENABLE),
> +               .mask_separate = BIT(IIO_EV_INFO_VALUE),
>         },
>         {
>                 .type = IIO_EV_TYPE_THRESH,
>                 .dir = IIO_EV_DIR_FALLING,
> -               .mask_separate = BIT(IIO_EV_INFO_VALUE) |
> -                       BIT(IIO_EV_INFO_ENABLE),
> +               .mask_separate = BIT(IIO_EV_INFO_VALUE),
> +       },
> +       {
> +               .type = IIO_EV_TYPE_THRESH,
> +               .mask_separate = BIT(IIO_EV_INFO_ENABLE),
>         },
>  };
>
> --
> 2.34.1
>
>
> --
> This email is confidential. If you have received this email in error please
> notify us immediately by return email and delete this email and any
> attachments. Vix accepts no liability for any damage caused by this email
> or any attachments due to viruses, interference, interception, corruption
> or unauthorised access.
