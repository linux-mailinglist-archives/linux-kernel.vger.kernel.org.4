Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B69731FBF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238099AbjFOSJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237565AbjFOSJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:09:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D532D4E;
        Thu, 15 Jun 2023 11:09:27 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30af56f5f52so6041351f8f.1;
        Thu, 15 Jun 2023 11:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686852565; x=1689444565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPImEVscMojs9n7lKMKdyofc4xjY1xoflsUxQYw/6Tc=;
        b=QmRYT/l2vvGvs1/ND8lpYm14BMAW04Gz/Qh7LvvvDDIuttOKOdERGtbvpZvDCsF6la
         s9EoxJ/DCBiGh/c2u0b0eTxzM56kO+Ye53Hsbutz4BrZyfjeLhpxPPKjxNV6LQH04m6w
         uijrUDf0dbj+0O9KYIDYp1LvOf8M3/kdPT/kLakZtE2hLwKUzdZD61HbeYELetDhu7iZ
         hMwPBy7c94PT3pNyjnqopMW6MqczzYcgW+XrHq+sXWpqZdv9GluD6O9DYyCmSwTZvw4X
         KGNmd0uVZsjDb+08dhe8QtQCiUFQHvqktKkM5OfXPh+ucZEWA69OuRKGU1dgYqcFxrq7
         3mNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686852565; x=1689444565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPImEVscMojs9n7lKMKdyofc4xjY1xoflsUxQYw/6Tc=;
        b=JoAjVYYxVpC9Xak7281AmCoB2+I2Het1Aj/76FCUuUdCCTyYEDmum0a0JiqCN6x+xs
         ZjcHSD7u+FC2c4eXteg8P1iY/Vtbwy37AsqHmJH6xOUggYmM222CmhKVVcF7NNsEwb+B
         YSY9w1BBGqrl/tTIhKhyz4jvqpJMwF6Kimq3oyBm6kQOaXQruoGfNx/Jl/GngF/2NP+O
         pq4BElEe983IiJazry9SwJXU1/kxy0xgWeG/R1yoK/4VPINKqmWAuBlRZc4F0zM14Xx6
         btqLiTJw3aq+rwMEPlwBxMxVPaboY1vpWx4ZZQliDxAwYFTtv0Vt39Qpa7dmR/68j+vk
         xRSQ==
X-Gm-Message-State: AC+VfDyOs7LAWX/h6sfQppLDx+SRZK83xX4S0+gbVUf/7GQx3Zi4S/Eq
        uedoxtaXahLajcLDeyVCjlBff6yjIfPQvOwgs6kT+Dt6fMT1AA==
X-Google-Smtp-Source: ACHHUZ5ScKEXxs3N3riRpameibKwfQ5AgWGdRhPuq7vZ0BK5oQPEW/IWP2DdZoP9Jva/DF0QJH9x2fyXk/gMJei1FDU=
X-Received: by 2002:a5d:4743:0:b0:30e:19a8:4b15 with SMTP id
 o3-20020a5d4743000000b0030e19a84b15mr11748710wrs.30.1686852565052; Thu, 15
 Jun 2023 11:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230613004341.3540325-1-azeemshaikh38@gmail.com>
 <202306131229.B5F2D9F@keescook> <CADmuW3VEiseKt2UM9o9jzzR8nEawh1jxANyxdZcxk89U65pXEQ@mail.gmail.com>
 <202306141049.BF86FA8F1F@keescook>
In-Reply-To: <202306141049.BF86FA8F1F@keescook>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Thu, 15 Jun 2023 14:09:13 -0400
Message-ID: <CADmuW3UZ9+9DmXPEyitgn_8Rg7U-iGvV-wJ-ug7eW84JSti47g@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: function: printer: Replace strlcpy with strscpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Albert Briscoe <albertsbriscoe@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 1:51=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Wed, Jun 14, 2023 at 10:12:14AM -0400, Azeem Shaikh wrote:
> > On Tue, Jun 13, 2023 at 3:30=E2=80=AFPM Kees Cook <keescook@chromium.or=
g> wrote:
> > >
> > > On Tue, Jun 13, 2023 at 12:43:41AM +0000, Azeem Shaikh wrote:
> > [...]
> > > > -     result =3D strlcpy(page, opts->pnp_string, PAGE_SIZE);
> > > > -     if (result >=3D PAGE_SIZE) {
> > > > +     result =3D strscpy(page, opts->pnp_string, PAGE_SIZE);
> > > > +     if (result =3D=3D -E2BIG) {
> > >
> > > I think "< 1" might be a better test here.
> >
> > Curious, why "< 1" instead of "< 0"?
> >
> > > >               result =3D PAGE_SIZE;
> > > >       } else if (page[result - 1] !=3D '\n' && result + 1 < PAGE_SI=
ZE) {
>
> It's for this case above where "result" may be used in an array index,
> and if it's 0 or less, there will be a negative array index (due to the "=
-
> 1"). So, here, it needs to be "< 1" instead of the more traditional "< 0"=
.
>

Makes sense. Sent out a v2.
