Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5673B6B6606
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 13:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjCLMma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 08:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjCLMm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 08:42:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0CA4FF3C;
        Sun, 12 Mar 2023 05:42:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AC0B60F07;
        Sun, 12 Mar 2023 12:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D9DC433EF;
        Sun, 12 Mar 2023 12:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678624943;
        bh=OFQdNglFI1NSHGUTJ5ckoAxc4WHC7HuhP+EF7KanK/4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PltZMWCMOypqC6ZHwTFD8bjEUjYQ8jO+tPUrIY4apSGPHU16hGsCnsduNrEaHFSdK
         6fNuhnN9xv0FtG3RAJ0Ofm57ut/e2Y9D+tPzRbKEyDBykY85Gjm8+xuLdccA9UA3jZ
         aO74F7PYbhGz+n65b+qKFYRxX+93p1kTPqzp2HbRZfRmAPhnlSxuYrZaNSkCQ7hSCG
         t8i6xnf/OLCSQN1ex0u+BUBDq2skGYoHAGC5gMy8/gnMabXuhOnOZwxnIpZR9IgJuS
         jMPZnoWS45BYJ62wrNsjKZfdX0PyaktgQfM6vFvtPYu8G42ErriXAXLyHKw2qIejl8
         5BoANJnlS9MPg==
Received: by mail-ed1-f44.google.com with SMTP id s11so38316840edy.8;
        Sun, 12 Mar 2023 05:42:22 -0700 (PDT)
X-Gm-Message-State: AO0yUKUgfcP47dQJ1ZdvMqHs30LIbx6W2H0ghKBf/FgifrdKdIRRtNOn
        V3TS4Q5e1t3Ik7GScTuJhQE8S2Y7UitRAM5KJz8=
X-Google-Smtp-Source: AK7set/J9ue8nEOQxcHGaZaDmH8jLtekYukBmKnmWZUTmBHd3+lZTFydgcK5tTNK9QRO/X7dLQsyxkALKEkk+gnWzMw=
X-Received: by 2002:a50:bb49:0:b0:4fb:adb4:d9b9 with SMTP id
 y67-20020a50bb49000000b004fbadb4d9b9mr665337ede.7.1678624941236; Sun, 12 Mar
 2023 05:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230310144710.1543070-1-robh@kernel.org>
In-Reply-To: <20230310144710.1543070-1-robh@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 12 Mar 2023 20:42:09 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRmf6C0fZs6L4VoRtNivu9dm_6Nibej-oOhZ=69FzLhrA@mail.gmail.com>
Message-ID: <CAJF2gTRmf6C0fZs6L4VoRtNivu9dm_6Nibej-oOhZ=69FzLhrA@mail.gmail.com>
Subject: Re: [PATCH] irqchip: Use of_property_read_bool() for boolean properties
To:     Rob Herring <robh@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Guo Ren <guoren@kernel.org> (csky)

On Fri, Mar 10, 2023 at 10:48=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties.
> Convert reading boolean properties to to of_property_read_bool().
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/irqchip/irq-csky-apb-intc.c | 2 +-
>  drivers/irqchip/irq-gic-v2m.c       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-csky-apb-intc.c b/drivers/irqchip/irq-cs=
ky-apb-intc.c
> index 42d8a2438ebc..6710691e4c25 100644
> --- a/drivers/irqchip/irq-csky-apb-intc.c
> +++ b/drivers/irqchip/irq-csky-apb-intc.c
> @@ -68,7 +68,7 @@ static void __init ck_set_gc(struct device_node *node, =
void __iomem *reg_base,
>         gc->chip_types[0].chip.irq_mask =3D irq_gc_mask_clr_bit;
>         gc->chip_types[0].chip.irq_unmask =3D irq_gc_mask_set_bit;
>
> -       if (of_find_property(node, "csky,support-pulse-signal", NULL))
> +       if (of_property_read_bool(node, "csky,support-pulse-signal"))
>                 gc->chip_types[0].chip.irq_unmask =3D irq_ck_mask_set_bit=
;
>  }
>
> diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.=
c
> index f1e75b35a52a..f2ff4387870d 100644
> --- a/drivers/irqchip/irq-gic-v2m.c
> +++ b/drivers/irqchip/irq-gic-v2m.c
> @@ -421,7 +421,7 @@ static int __init gicv2m_of_init(struct fwnode_handle=
 *parent_handle,
>                 u32 spi_start =3D 0, nr_spis =3D 0;
>                 struct resource res;
>
> -               if (!of_find_property(child, "msi-controller", NULL))
> +               if (!of_property_read_bool(child, "msi-controller"))
>                         continue;
>
>                 ret =3D of_address_to_resource(child, 0, &res);
> --
> 2.39.2
>


--=20
Best Regards
 Guo Ren
