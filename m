Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10446A3B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 08:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjB0HLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 02:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjB0HLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 02:11:37 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCBAD306
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 23:11:34 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id d30so21634827eda.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 23:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frbLlxMEnwRtsGset75OyhS7x+4u6T2f1EALwgAMerg=;
        b=cTy1RwfRRCd9NHmmmOaC0numeQEU7k9RcBvcQ2l4repV6AEuMdkAmS5/t0ZCHdIL29
         Elu5jxkkFfQvOlEC9yYnRbLmLpyoFPTb9OQeyz/U3mnxLfNnsAlI2GvPS9yP6yMZkY1z
         ZPNH8s+aNs3i7X4WJjmFA+ErXAztvan4PpIWRKAFdvgZNYis4qOCuW6CGyl/79a1/jsJ
         0LWED68nyl/904kpXcVoQR7lm61K/OyzgV7mMzSNCmR326cd6xEx+EshgEr167nEPFqD
         ZadYKFNtHFwwBdjzxJGYW7r3JlqAVtDLkOSzM5gpA8qXCoHJmm0p0qZZbCSL5hzT2sgt
         NwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frbLlxMEnwRtsGset75OyhS7x+4u6T2f1EALwgAMerg=;
        b=T5456qUpxRlkkgYcC1ACDHkP5jvC2TKYvWzzavnO/VIVoa59Rn/o+ZSSwLFkIyGg0X
         4sqk5g3vDAUUPh0GVIcKU0v93QN0jurHhF+S6AqV8nsIpiiRlIZyc9YdhwVlMx0WrI+v
         8PcqaA37yDAdm3Glfssx+0om1v88EZPhTWr1OViLjrTSKc0cG6drhjg0jnCr1jAU/qRJ
         UJouTP5iOw7rySEgZgA3sCRYhhTBp0LJmkjbrhsmbLf15eRO3sg86ijPJiOeA1o0Gobd
         zmnQ1tYdAeryfDeV77FirZquuWgpCZrY2W8nBDMAHyj8CUKBQt71bdDvWekNzHW9YZIj
         a0vQ==
X-Gm-Message-State: AO0yUKXkuEAcg0eTkyxF5GbIrgmjw3iqYv1aWw5iZgh5m62Eiqnh5s0v
        nOAQkRdC5kEyKSTbN+xcBxnDZrySeevLOKMbCew=
X-Google-Smtp-Source: AK7set+rLuc9Y6Hm8HGd98W0i2r6/2bLRt7r/sEIXA6OMQu+IdQ3imVAWFJbvwm9PZQswnmV+iehn2WeAQCxuLRVLW4=
X-Received: by 2002:a17:906:48c9:b0:878:4a24:1a5c with SMTP id
 d9-20020a17090648c900b008784a241a5cmr14640944ejt.6.1677481892773; Sun, 26 Feb
 2023 23:11:32 -0800 (PST)
MIME-Version: 1.0
References: <20230226132500.3933232-1-void0red@gmail.com> <Y/w16PI4klfJaeXA@kadam>
In-Reply-To: <Y/w16PI4klfJaeXA@kadam>
From:   Kang Chen <void0red@gmail.com>
Date:   Mon, 27 Feb 2023 15:11:21 +0800
Message-ID: <CANE+tVpqZusCq4EXi7UV+jY0XBG+9x6UWh_JGCWKs3pZRMFBXA@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: add a null check of kzalloc in go_add_group_info_attr
To:     Dan Carpenter <error27@gmail.com>
Cc:     paskripkin@gmail.com, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dan,

Thanks for your review.
I noticed there is no error handling in the origin design (this call chain)=
.
go_add_group_info_attr returns a len-like value indicating the length
of pbuf.
I don't think throwing an error to the caller is a good idea, the caller
doesn't seem to care about it.
So inserting a netdev_dbg or pr_debug here might be enough.
Do you have a better idea?

Best regards,
Kang Chen


On Mon, Feb 27, 2023 at 12:47=E2=80=AFPM Dan Carpenter <error27@gmail.com> =
wrote:
>
> On Sun, Feb 26, 2023 at 09:25:00PM +0800, Kang Chen wrote:
> > kzalloc may fails, pdata_attr might be null and will cause
> > illegal address access later.
> >
> > Signed-off-by: Kang Chen <void0red@gmail.com>
> > ---
> >  drivers/staging/r8188eu/core/rtw_p2p.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r=
8188eu/core/rtw_p2p.c
> > index 93d3c9c43..802e1170a 100644
> > --- a/drivers/staging/r8188eu/core/rtw_p2p.c
> > +++ b/drivers/staging/r8188eu/core/rtw_p2p.c
> > @@ -31,6 +31,8 @@ static u32 go_add_group_info_attr(struct wifidirect_i=
nfo *pwdinfo, u8 *pbuf)
> >       struct sta_priv *pstapriv =3D &padapter->stapriv;
> >
> >       pdata_attr =3D kzalloc(MAX_P2P_IE_LEN, GFP_KERNEL);
> > +     if (!pdata_attr)
> > +             return 0;
>
> Return success here is not a good thing.  We have to fix the caller to
> check for errors.  (Fixing a bug half way just makes it harder to find
> the bug so it makes the situation worse).
>
> regards,
> dan carpenter
>
