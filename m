Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD4C733E8D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 08:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjFQGAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 02:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFQGAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 02:00:54 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6017B10DD;
        Fri, 16 Jun 2023 23:00:51 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b44b5adfd3so1088838a34.3;
        Fri, 16 Jun 2023 23:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686981650; x=1689573650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsMcBAzokADfDQj+dcl9riTWGJRFeO6KPrhVYaZaLbE=;
        b=cqV1VAc+CW2y1q0B8H7xLgWwrIaPt3xH5+65rvlVgf0kDgE1PntwzmcLropSCHsc3w
         3NKol9XRS9po/LXhn9Wc4qphPQPZna6Jw/MXk4/P/au2Zn7DDtyPQm7+kz4NkUpcp98e
         lxRZ+HHRp8N6CV3R8kd0KUjJMTDobcEdV7UJ5pnuZVj16tfgXXjhPJs5xHdsJm5woN/W
         RYAGdwpY4op1V1EZuTo5RfgHUUdimgqaJhxlxBuTJz2nwboELmizMX88zLKBSHmgMHWh
         r5lcUtEwe32NcowAZYELFM2jvcnCIb1yfEzokglgJ72UsnL6fULRX0gbD8IqKRPWvubz
         E0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686981650; x=1689573650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsMcBAzokADfDQj+dcl9riTWGJRFeO6KPrhVYaZaLbE=;
        b=e2BPvwGTm1+1cngp5wL/4cU8dRu2J/01nvX/9j23g3gpfzQLguUzuP6JBK3py8EbVk
         q1nLzN8li6S5czuu+4d+Ktw8a1BVr6yGTE0+pqy6Xx+jiwKZs9FaOCPRKkdjgjWeboz+
         MAzZ8zhq/dZHwFuhQELLnIKYsZtIS/zQqolDGuuxqluEhjD9e7HoRoTg472+IJmtKXpC
         JrI+J+FbjM0SSYrDCIKhHgX4di8xVpCONd0xtWC0NvDTNFpY7AWsVlLg83Fwt0d+K8hj
         K7zkx+P0JdDziDoa5m5l0i4ysHVuUPU0baQ4ER+f+AsmE0lytcFtM1Vy7U4K17gPqNuE
         cteg==
X-Gm-Message-State: AC+VfDyvbfvPpz31j8QZ+9B5FDdM9YuOwG5N5WZ6+BEQJEp3CDnXPVI1
        yWv5DWMkB2LiHr3R7bvcPP/IsGTOcM9/X/EV6CM=
X-Google-Smtp-Source: ACHHUZ7M+3ahl8aA1MWs6d/uUu4V7qCSK+MWXW+1JTHNn93McFFieptDJhDlxwwDNFj+LBvLv4HgNni2E3XkOJKI6m8=
X-Received: by 2002:a54:470a:0:b0:398:45e0:38c0 with SMTP id
 k10-20020a54470a000000b0039845e038c0mr4306200oik.15.1686981650571; Fri, 16
 Jun 2023 23:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhs-H_GjHU+r33oeytXiyu+bgGTrGL8Ck=DbsMYnqC-XBNYYw@mail.gmail.com>
 <TYAP286MB0315C2088627FB035A5D43D6BC59A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYAP286MB0315C2088627FB035A5D43D6BC59A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 17 Jun 2023 08:00:39 +0200
Message-ID: <CAMhs-H_sHWu_uFMbjzB2APU=aYv6d4gnXD9xw=ANigTXDjQzzg@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] clk: ralink: add clock and reset driver for MTMIPS SoCs
To:     Shiji Yang <yangshiji66@outlook.com>
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

On Sat, Jun 17, 2023 at 7:51=E2=80=AFAM Shiji Yang <yangshiji66@outlook.com=
> wrote:
>
> Thank you for your quick reply!
>
> >> >+      {
> >> >+              .compatible =3D "ralink,mt7620a-sysc",
> >> >+              .data =3D &mt7620_clk_data,
> >> >+      },
> >> >+      {
> >> >+              .compatible =3D "ralink,mt7620-sysc",
> >> >+              .data =3D &mt7620_clk_data,
> >> >+      },
> >> >+      {
> >>
> >> I am confused about the difference between `ralink,mt7620-sysc` and
> >> `ralink,mt7620a-sysc`. Do you mean mt7620n?
> >> https://www.mediatek.com/products/home-networking/mt7620n-a
> >
> >There is no real difference. As you can see both of them use the same
> >'mt7620_clk_data' but since both compatible strings already exist
> >somewhere I introduced both of them.
> >arch/mips/boot/dts/ralink
>
> If they are the same, perhaps `mt7620a` also need to be checked in mtmips=
_clk_regs_init().
> Or just remove compatible string of `mt7620a` and update dtsi files?

We are planning to properly port dts files from openWRT into the
mainline kernel and also update the current out of date files which
already exist on tree, so we will take care of this kind of details
then.

>
> >+static void __init mtmips_clk_regs_init(struct device_node *node,
> >+                                      struct mtmips_clk_priv *priv)
> >+{
> >+      u32 t;
> >+
> >+      if (!of_device_is_compatible(node, "ralink,mt7620-sysc"))
> >+              return;
> >+
> >+      /*
> >+       * When the CPU goes into sleep mode, the BUS
> >+       * clock will be too low for USB to function properly.
> >+       * Adjust the busses fractional divider to fix this
> >+       */
> >+      regmap_read(priv->sysc, SYSC_REG_CPU_SYS_CLKCFG, &t);
> >+      t &=3D ~(CLKCFG_FDIV_MASK | CLKCFG_FFRAC_MASK);
> >+      t |=3D CLKCFG_FDIV_USB_VAL | CLKCFG_FFRAC_USB_VAL;
> >+      regmap_write(priv->sysc, SYSC_REG_CPU_SYS_CLKCFG, t);
> >+}
> >+
>
> If we choose to update dts file. We can also remove the legacy
> "ralink,rt2880-reset" compatible string by the way.

Ditto.

>
> >+static const struct of_device_id mtmips_clk_of_match[] =3D {
> >+      { .compatible =3D "ralink,rt2880-reset" },
> >+      { .compatible =3D "ralink,rt2880-sysc" },
> >+      { .compatible =3D "ralink,rt3050-sysc" },
> >+      { .compatible =3D "ralink,rt3050-sysc" },
> >+      { .compatible =3D "ralink,rt3352-sysc" },
> >+      { .compatible =3D "ralink,rt3883-sysc" },
> >+      { .compatible =3D "ralink,rt5350-sysc" },
> >+      { .compatible =3D "ralink,mt7620a-sysc" },
> >+      { .compatible =3D "ralink,mt7620-sysc" },
> >+      { .compatible =3D "ralink,mt7628-sysc" },
> >+      { .compatible =3D "ralink,mt7688-sysc" },
> >+      {}
> >+};
>
> Thanks,
>     Shiji Yang

Thanks,
    Sergio Paracuellos
