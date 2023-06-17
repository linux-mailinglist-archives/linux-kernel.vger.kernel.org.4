Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44AD733E22
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 07:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjFQFGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 01:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjFQFG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 01:06:28 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2DCC1;
        Fri, 16 Jun 2023 22:06:27 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-19f6211d4e1so1482795fac.1;
        Fri, 16 Jun 2023 22:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686978386; x=1689570386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vX49sxz34ou9QOf3MikdDGA8OxQlXk3aPn0JC16XvIE=;
        b=X9Pa7XlNRFHl3AZ2JwsTRSE4z5ytCDvcKo97sERlLfEzSVG8HfDkY4hkuuhomltsxK
         kk09IBEq+rmWbr+zlU2SA3UTCVlKIYz8m5VIk43ohwGjbdlBWuKWfkZy2s/UKb8Ic3hZ
         NvlM8vyQPuKS42MQ6AqvEFVDvs/icqWI/XJXaZrZXYwvHF+NUct7Vp3eLMbbT9NfL612
         zn4dAt4sMg6oLyo5TjUhHzKHJgOHH6WG90IPQuaIHznnm8CfUUj3jU4e/tpvbGt9OCJJ
         kQ9cK25av2aAt63UFyhpPcEhCLUWoaVat5Y9I+j1jvUV42Vmzj3UNLXHdwUd+02Z8Uep
         C0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686978386; x=1689570386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vX49sxz34ou9QOf3MikdDGA8OxQlXk3aPn0JC16XvIE=;
        b=UdTB4EKTXHqdTqG/kcBbHG79io92jFprYg3JAuiNrGnhWaymKGL0KXJR/QdqoNS29q
         NxA6ZQM6l7ONvSY2OodocLMtKGXFhtTy5XdwsjwbrfM+6Dl3jCdpKwSCoOmbEcctuJ1C
         GYBlyu73ckYdVXJzxd5nLs8YEKD9iXilCCdjeygLXhulsTMRjffrExZdNCJHOUhX4shN
         jXL8oHL/BRbnrZgJyr2S7WQBRIAZ/i2c1z0m3pnnesR40AT99MyNU+InKVyRg4mhbe/7
         TlGsznqsxOpf9kpaENecrMGHw3X2hKLARAq/AV25va1336Z6z7LSESqbGIqSLmrQqucb
         4wPQ==
X-Gm-Message-State: AC+VfDwuXBekI+oies62Pac/OI+QPOMXaRENpkpjHtKDtvpxawjb1/nM
        zuLe4cTIa5+A02z4O4SosJvYrSZn0OIpUAT/844=
X-Google-Smtp-Source: ACHHUZ79tIFKPw8q9waWiYAn1ZdMPWEc/9foR0BJAcUC43EF79QfxcCrdv8+Zh8jFBaOfwQtFh2uX3S8mtTByKTWb0o=
X-Received: by 2002:a05:6870:5415:b0:19e:7d07:ab9 with SMTP id
 d21-20020a056870541500b0019e7d070ab9mr723479oan.53.1686978386565; Fri, 16 Jun
 2023 22:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230418090312.2818879-3-sergio.paracuellos@gmail.com> <TYAP286MB0315C35BA080B686EB5EA980BC59A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYAP286MB0315C35BA080B686EB5EA980BC59A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 17 Jun 2023 07:06:15 +0200
Message-ID: <CAMhs-H_GjHU+r33oeytXiyu+bgGTrGL8Ck=DbsMYnqC-XBNYYw@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] clk: ralink: add clock and reset driver for MTMIPS SoCs
To:     yangshiji66@outlook.com
Cc:     arinc.unal@arinc9.com, devicetree@vger.kernel.org,
        john@phrozen.org, krzysztof.kozlowski+dt@linaro.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, sboyd@kernel.org, tsbogend@alpha.franken.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shiji Yang!

On Sat, Jun 17, 2023 at 6:51=E2=80=AFAM <yangshiji66@outlook.com> wrote:
>
> Thank you for taking care of these old amazing SoCs. When I ported these
> patches to OpenWrt, I found some issues.

Thanks for testing this!

>
> >+
> >+static const struct of_device_id mtmips_of_match[] =3D {
> >+      {
> >+              .compatible =3D "ralink,rt2880-sysc",
> >+              .data =3D &rt2880_clk_data,
> >+      },
> >+      {
> >+              .compatible =3D "ralink,rt3050-sysc",
> >+              .data =3D &rt3050_clk_data,
> >+      },
> >+      {
> >+              .compatible =3D "ralink,rt3052-sysc",
> >+              .data =3D &rt3052_clk_data,
> >+      },
> >+      {
> >+              .compatible =3D "ralink,rt3352-sysc",
> >+              .data =3D &rt3052_clk_data,
>
> It seems that there should be `.data =3D &rt3352_clk_data,`?

Good catch! Thanks!
>
> >+      },
> >+      {
> >+              .compatible =3D "ralink,rt3883-sysc",
> >+              .data =3D &rt3352_clk_data,
> >+      },
>
> And there should be `.data =3D &rt3883_clk_data,`?

True.

>
> >+      {
> >+              .compatible =3D "ralink,rt5350-sysc",
> >+              .data =3D &rt5350_clk_data,
> >+      },
> >+      {
> >+              .compatible =3D "ralink,mt7620a-sysc",
> >+              .data =3D &mt7620_clk_data,
> >+      },
> >+      {
> >+              .compatible =3D "ralink,mt7620-sysc",
> >+              .data =3D &mt7620_clk_data,
> >+      },
> >+      {
>
> I am confused about the difference between `ralink,mt7620-sysc` and
> `ralink,mt7620a-sysc`. Do you mean mt7620n?
> https://www.mediatek.com/products/home-networking/mt7620n-a

There is no real difference. As you can see both of them use the same
'mt7620_clk_data' but since both compatible strings already exist
somewhere I introduced both of them.

>
> >+              .compatible =3D "ralink,mt7628-sysc",
> >+              .data =3D &mt76x8_clk_data,
> >+      },
> >+      {
> >+              .compatible =3D "ralink,mt7688-sysc",
> >+              .data =3D &mt76x8_clk_data,
> >+      },
> >+      {}
> >+};
> >+
>
> Thanks,
>     Shiji Yang

Thomas, I am going to send v4 with all Reviewed-by and Acked-by tags
added as well as this two minor stuff fixed.

Thanks,
    Sergio Paracuellos
