Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75297429CA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjF2Pib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjF2Pi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:38:29 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDABC210B;
        Thu, 29 Jun 2023 08:38:27 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5440e98616cso506581a12.0;
        Thu, 29 Jun 2023 08:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688053107; x=1690645107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6D4ElwAUoWFBYqkUQqWeJ1DJdnnjS0BvVr/YXHqXEc=;
        b=YDrPc/2X9qLtEtsT0xmXJxGrAc0BiRFYkcO5iGZ9empNJhcIlm0Vw1phUi2vX0qWpY
         j8QLCqyo5q2P0XsNJX6pbTX/TsWdzjC0dZx8MzpcFi4DCler2Rn6ZF2f9Wf/MdIlIPMV
         YnCsDh0sSjokdcUAbalfAwQ4ELvRTOvOYRZt5jqQkJ1/5L1uIvmgyGU5KBfhq3Wg+FAv
         INHwu6Wpel9yKr0nNdyf+wzn9RRmC1gQLKtgmbrAExilxOWPr7bKayiY0tErhQW+uA2U
         +aK9Hkuhz5ZBUXQxvjyaP/1j8ptAnkJBlCt67w2zQ3QFQUykgv/mgsazYTyD7HDJO1lj
         qcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688053107; x=1690645107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6D4ElwAUoWFBYqkUQqWeJ1DJdnnjS0BvVr/YXHqXEc=;
        b=bax9BtRbwg56Q3aFcA0LFN6ZzjMZP2u7uPNFZXnxZoiTrUcTIIl3RQGR05xS1aAIZ7
         x7PtLiQWeGZm5Mmc1y7ZN0HcxZCnT5XT+Gtb7rW9vrMbYnB5sme/ib3M00uATXoLVyY9
         Klj4EYKSJ7rt4AQnfB9oldjAW+mAXvadoyHixUTbJ+G5f8QRO2X4YAAXKB6sEcrOOEG0
         JszK4IxrbzDUCOBZL0m/4MBXbhx+QQAyXlzD578ELG+erzkSy8/KUjpCsxFJ/ntrVml9
         98F4v92M37hjtOytps5QBnweJYFhELxpwscEtb1QpCMPB9iZxl6eY1oVw/7x70i2ht0k
         fwIA==
X-Gm-Message-State: AC+VfDzxGgfsJurO+z8rEukNyD8/RhoYoaCnCA/dVuZsd+9H62sIHFZK
        UFkbcXGR6+qPwCMVqlCb3cGsdy4MSDem+rRhSs7/uBam7Fednw==
X-Google-Smtp-Source: ACHHUZ4yw+zL4OfZnoL0RGXS0ImoUubd2VlrpxVkBPn3s/qZbjy/2xofoHLXMU1PxfSffZPtSf2tSbcvX5w4buFj8JE=
X-Received: by 2002:a05:6a20:12ca:b0:122:cb18:2e8c with SMTP id
 v10-20020a056a2012ca00b00122cb182e8cmr292225pzg.6.1688053107143; Thu, 29 Jun
 2023 08:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230629134306.95823-1-jonas.gorski@gmail.com> <CAKekbeuMjUPpzfgKrxgZzFpiQ4FbeYtBtbrzkWKeBy4u2Symhg@mail.gmail.com>
In-Reply-To: <CAKekbeuMjUPpzfgKrxgZzFpiQ4FbeYtBtbrzkWKeBy4u2Symhg@mail.gmail.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Thu, 29 Jun 2023 17:38:15 +0200
Message-ID: <CAOiHx=kh79=zBM=P8BhrU+3BHcgF71ZZdJR-hV9Tsm59=jELHw@mail.gmail.com>
Subject: Re: [PATCH] spi: bcm-qspi: return error if neither hif_mspi nor mspi
 is available
To:     Kamal Dasu <kamal.dasu@broadcom.com>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 at 17:07, Kamal Dasu <kamal.dasu@broadcom.com> wrote:
>
> On Thu, Jun 29, 2023 at 9:43=E2=80=AFAM Jonas Gorski <jonas.gorski@gmail.=
com> wrote:
> >
> > If neither a "hif_mspi" nor "mspi" resource is present, the driver will
> > just early exit in probe but still return success. Apart from not doing
> > anything meaningful, this would then also lead to a null pointer access
> > on removal, as platform_get_drvdata() would return NULL, which it would
> > then try to dereferce when trying to unregister the spi master.
> >
> > Fix this by unconditionally calling devm_ioremap_resource(), as it can
> > handle a NULL res and will then return a viable ERR_PTR() if we get one=
.
> >
> > The "return 0;" was previously a "goto qspi_resource_err;" where then
> > ret was returned, but since ret was still initialized to 0 at this plac=
e
> > this was a valid conversion in 63c5395bb7a9 ("spi: bcm-qspi: Fix
> > use-after-free on unbind"). The issue was not introduced by this commit=
,
> > only made more obvious.
> >
> > Fixes: fa236a7ef240 ("spi: bcm-qspi: Add Broadcom MSPI driver")
> > Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> > ---
> > Found by looking a the driver while comparing it to its bindings.
> >
> > Only build tested, not runtested.
> >
> >  drivers/spi/spi-bcm-qspi.c | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
> > index 6b46a3b67c41..d91dfbe47aa5 100644
> > --- a/drivers/spi/spi-bcm-qspi.c
> > +++ b/drivers/spi/spi-bcm-qspi.c
> > @@ -1543,13 +1543,9 @@ int bcm_qspi_probe(struct platform_device *pdev,
> >                 res =3D platform_get_resource_byname(pdev, IORESOURCE_M=
EM,
> >                                                    "mspi");
> >
> > -       if (res) {
> > -               qspi->base[MSPI]  =3D devm_ioremap_resource(dev, res);
> > -               if (IS_ERR(qspi->base[MSPI]))
> > -                       return PTR_ERR(qspi->base[MSPI]);
> > -       } else {
> > -               return 0;
> > -       }
>
> I would rather just do this in the else case
>
> } else {
>  -              return 0;
>  +             return -ENODEV;
> }
>
>  The change below does not check the return of
> platform_get_resource_byname() in my opinion rather relies on
> devm_ioremap_resource() doing the right thing.

This is how devm_ioremap_resource() is intended to be used, see e.g.
the example in its kernel documentation:

https://elixir.bootlin.com/linux/latest/source/lib/devres.c#L167

So I don't see what's wrong with relying on functions doing the right thing=
.

Also AFAIU the appropriate return code in this case would be rather
-EINVAL, not -ENODEV.

>
> > +       qspi->base[MSPI]  =3D devm_ioremap_resource(dev, res);
> > +       if (IS_ERR(qspi->base[MSPI]))
> > +               return PTR_ERR(qspi->base[MSPI]);
> >
> >         res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "bsp=
i");
> >         if (res) {
> > --
> > 2.34.1
> >

Regards,
Jonas
