Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623D06D2948
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjCaUSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjCaUSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:18:07 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D48B2220C;
        Fri, 31 Mar 2023 13:18:06 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id j2so5092533ila.8;
        Fri, 31 Mar 2023 13:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680293885; x=1682885885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPBrvhS4C9fH8+UVEU/PMvBSYFvObmXLuJFfdX5dcJg=;
        b=fa4BxSIgi57AMyUtvtR9HC3rjFIwqjjdJBx5G7TB5hltEcKzhqL0+Of2hzGU+B4qa1
         WjuKLQY23FBHO0RbFKvigpoXI4CmTlJEYB75WKOyWsFiCSORU37zyymm6SJpfzVEKFU+
         aNtuQXio1QuheM23jHTqY+czwzrzHDEiCtV8Ug7j/xUfTILz7oQRTZn8Bzur3xDzZaPs
         25bXr7emhd6mLVcMV4fK9rigr3mFPD9JgzpkP6tcex3TAW1prjdNg0ZHXtb1C5MPicx0
         RcqXnyrQSv4lD/wDV/UdAK/B4WBqJ5tXk3IXAPfXEEVKiMibr6D2neFqi3y3cr+2LThu
         Eslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680293885; x=1682885885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPBrvhS4C9fH8+UVEU/PMvBSYFvObmXLuJFfdX5dcJg=;
        b=5gEtKDxDZAbq7pclujIxMkNGny7WbwOqwGN2sOk15CNecJ8l1Cu+2EEobpkb07bTI/
         S5fioMtFDtepYqsAg0Qtlg7UnEF9f1zwPRB5CXaDcOe0rM8IgZtmhp5d6pUN1kHA9s3V
         7YNbTVioeWv9LC+eXBm1sK7HNtD9ckf8Zmyo0W+/AUj2MbKi+fCGKcohe7t76UZGx2dq
         dqtoSawWqIOSzrSlsW9HtNfoTvhHbjKIrEQJdyRoF7f38GNwcjq9tM5Pn8LmCmTJdnsg
         u0U77Ks6LpvJFemDGJlAzZNP1UwTpQPdb4fw2jJY/Bqi9qB6ohN4yvQoiFGueLmFC+X+
         kLLg==
X-Gm-Message-State: AAQBX9eB7OgfJbRi4I6mlmtfoHdjdRjDyNVnJqFq2mx95m5CZB7LwJ36
        ItZ6+ztiW32e6SDfc8NhoYJ4jZYUcpG1PpoTz/c=
X-Google-Smtp-Source: AKy350Y54OJxf8iUlKpXbAgqSiyCtgyMjlHCU15pwG/udlx4BQ0qKWVSD06JZkpsfbCXKsybTvlOQgTz5Kcxc8QZ5iQ=
X-Received: by 2002:a05:6e02:1528:b0:326:3b43:4c2a with SMTP id
 i8-20020a056e02152800b003263b434c2amr3463407ilu.1.1680293885621; Fri, 31 Mar
 2023 13:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230330204217.47666-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <5468019d-e688-4019-882f-6f9611443408@spud>
In-Reply-To: <5468019d-e688-4019-882f-6f9611443408@spud>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 31 Mar 2023 20:17:39 +0000
Message-ID: <CA+V-a8uzk7VmYRgHgXpN9Hz3VUoHU5hN7OUaLzB1KX6m=nkBzQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] cache: Add L2 cache management for Andes AX45MP
 RISC-V core
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Conor,

Thank you for the review.

On Fri, Mar 31, 2023 at 1:45=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Thu, Mar 30, 2023 at 09:42:16PM +0100, Prabhakar wrote:
>
> > +STANDALONE CACHE CONTROLLER DRIVERS
>
> > +F:   include/cache
>
> This can go since the file no longer exists.
>
Agreed I will drop this.

> > +config AX45MP_L2_CACHE
> > +     bool "Andes Technology AX45MP L2 Cache controller"
> > +     depends on RISCV && RISCV_DMA_NONCOHERENT
>
> This can just be depends on RISCV_DMA_NONCOHERENT, since that's only
> defined on RISC-V.
>
Agreed.

> > +static void ax45mp_get_l2_line_size(struct platform_device *pdev)
> > +{
> > +     struct device_node *np =3D pdev->dev.of_node;
> > +     struct device *dev =3D &pdev->dev;
> > +     int ret;
> > +
> > +     ret =3D of_property_read_u32(np, "cache-line-size", &ax45mp_priv-=
>ax45mp_cache_line_size);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to get cache-line-size, defaulting t=
o 64 bytes\n");
> > +             ax45mp_priv->ax45mp_cache_line_size =3D AX45MP_CACHE_LINE=
_SIZE;
> > +     }
> > +
> > +     if (ax45mp_priv->ax45mp_cache_line_size !=3D AX45MP_CACHE_LINE_SI=
ZE) {
> > +             dev_err(dev, "Expected cache-line-size to be 64 bytes (fo=
und:%u). Defaulting to 64 bytes\n",
> > +                     ax45mp_priv->ax45mp_cache_line_size);
> > +             ax45mp_priv->ax45mp_cache_line_size =3D AX45MP_CACHE_LINE=
_SIZE;
> > +     }
>
> I forget, why are we doing this defaulting rather than falling over
> immediately if we detect the property is missing or wrong?
>
No reason as such on not failing on property not existing/Invalid. I
will bail out in an error case now.

> > +}
>
> > +static const struct riscv_cache_ops ax45mp_cmo_ops =3D {
> > +     .clean_range =3D &ax45mp_cpu_dma_wb_range,
> > +     .inv_range =3D &ax45mp_cpu_dma_inval_range,
> > +     .flush_range =3D &ax45mp_cpu_dma_flush_range,
> > +};
>
> I think it would be nice if your driver functions matched the names used
> by the ops. (and as I said on the other patch, I think the ops should
> match the cross-arch naming.
>
Agreed, will do.

> Otherwise, looks grand - although I think I was mostly happy with the
> last revision too.a
>
I know you had provided the RB for the last version ;)

Cheers,
Prabhakar
