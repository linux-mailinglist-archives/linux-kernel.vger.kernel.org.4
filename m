Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F976C6585
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjCWKpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjCWKp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:45:29 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2BB38B61;
        Thu, 23 Mar 2023 03:42:40 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id de37so1122024qkb.7;
        Thu, 23 Mar 2023 03:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679568158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1ukCKsDgFcPZFfnc9+1Y2+3qjOHKCSVpyoQBHH5dIk=;
        b=PNLBOXAIEpdTB9+nVFw/kZ23WIhkGOIWW8FJzIbg3k/L7zUP3/kCBsgDpHJBrvYDoM
         J1K8dMZOUQohJ8wCutBv6HvLEmsIXb6SP7v4nmSXaXOPSQnM8mmEic9WacVDV/ca5ZmD
         Iw64nUdxlR0DHPpGyO63E7iZ52nVvTuEaCZWQEtaGmAfO/fzVuBMx4y0c6EskmhzlXrr
         HEqQqN57t7omtH5xvDih+ooGHG1DV4awMJElYvVtC5goUF+zfGMR/aqihx2C83bVsWjl
         K6XjKp6qZfhbd76Ahx9umRr5IjQiCEwqhcj3Q0E52/sBZblGGinckBMS9qjowO6zkNHA
         psIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679568158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1ukCKsDgFcPZFfnc9+1Y2+3qjOHKCSVpyoQBHH5dIk=;
        b=MtQXl8uuxcxgEXXrFiCnModpINRqXsx5EKDgChsZDj0etqrDawFUvn3FBoOASQKYwx
         7zDMCerxtBC5SE4WAOBESGIkfqv+tHbQG01DIy10YP0JQthJpiMpE0nDezg531TegSsb
         ID1XUe2DTHpjhdKTVW0m3lzmD1OAyCkAsSCIBtxJYdzw6wFbEhAVZok0L8p644xO1I17
         BGsLTwIKSI0dCvtIA5b0bZhF+CXUvpXq29uqeJf1+s3LJkr35AvXzaNafiTpNLytf1nY
         dEj4uzHEpl4Jv7QZRL0mzfspxfKdJRPiXHGO3J+hLurmtLnOAWK9fWFulTKs41r+1AFB
         AQ+g==
X-Gm-Message-State: AO0yUKXJeCFXWWKKY4i5cBn0L1KDkCVmo9JUWj9d9kXydiXbNMZYshrb
        zSFeWZ94Bwq1qYP3BnLqeV5H2TQnqWjwR5sY8rE=
X-Google-Smtp-Source: AK7set/uZCTBlSBdj0bNaxo/NWlc3GzK+9sX4uUPNBStnSnEqu0bsF9ELXNisHDidQhcGE23OETguUN4F+LqRkXaiHY=
X-Received: by 2002:a37:a9d0:0:b0:743:9b78:d97e with SMTP id
 s199-20020a37a9d0000000b007439b78d97emr1439983qke.14.1679568158542; Thu, 23
 Mar 2023 03:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230323000657.28664-1-blarson@amd.com> <20230323000657.28664-14-blarson@amd.com>
In-Reply-To: <20230323000657.28664-14-blarson@amd.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Mar 2023 12:42:02 +0200
Message-ID: <CAHp75VfRr_O2=vr4-5dG0nUpkCXPHtxD2z7tP-ryMM8N+RNv_g@mail.gmail.com>
Subject: Re: [PATCH v12 13/15] mmc: sdhci-cadence: Add AMD Pensando Elba SoC support
To:     Brad Larson <blarson@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 2:10=E2=80=AFAM Brad Larson <blarson@amd.com> wrote=
:
>
> Add support for AMD Pensando Elba SoC which explicitly
> controls byte-lane enables on writes.
>
> Select MMC_SDHCI_IO_ACCESSORS for MMC_SDHCI_CADENCE which
> allows Elba SoC sdhci_elba_ops to overwrite the SDHCI
> IO memory accessors


> +/* Elba control register bits [6:3] are byte-lane enables */
> +#define ELBA_BYTE_ENABLE_MASK(x)       ((x) << 3)


> +static void elba_priv_writel(struct sdhci_cdns_priv *priv, u32 val,
> +                            void __iomem *reg)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&priv->wrlock, flags);
> +       writel(ELBA_BYTE_ENABLE_MASK(0xf), priv->ctl_addr);

GENMASK(3, 0) ?

> +       writel(val, reg);
> +       spin_unlock_irqrestore(&priv->wrlock, flags);
> +}

...

> +       byte_enables =3D GENMASK(1, 0) << (reg & 0x3);

   unsigned u32 shift =3D reg & GENMASK(1, 0);

   byte_enables =3D GENMASK(1, 0) << shift;

?

...

> +       byte_enables =3D BIT(0) << (reg & 0x3);

In a similar way?

   unsigned u32 shift =3D reg & GENMASK(1, 0);

   byte_enables =3D BIT(0) << shift;

--=20
With Best Regards,
Andy Shevchenko
