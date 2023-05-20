Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B3C70A436
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 03:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjETBQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 21:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjETBQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 21:16:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8374C1AC;
        Fri, 19 May 2023 18:16:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02700644DC;
        Sat, 20 May 2023 01:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608A5C433A7;
        Sat, 20 May 2023 01:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684545397;
        bh=cmPyGCDj3qYpYiJY3BxliTqaHfvx5UhxPrQyG6kxeS4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lXQGijUOEm+xkhPEy7uN3Yw9xNiuxFfHKXog5I2f2KPdVq6ruBtfNJP5I/KFJk+IR
         gqcCw58L69rFicAeGpMZiDATP6ljYaZS6ozhxB81pknfM1O7umGsNk8BuqM1RPbdix
         ZW4XU8iAicsoPwGpnGPqcjDUUIOfsWaTipNUj44htuOS9hqr0vPjn3di83e2kN8qbX
         DaY7QZKYf0hrp0zPbDjkZxN3Xz6vN0oJ1q1IoPCWlVewjwQKW4cQkArfQErf5ZNtHJ
         v+CzvoYHrPDdEfn42PnXi23bwP7QEC4zRtraE8/MMCFb6Of4Row0Z521cGGzDaG65Y
         0ZlgRfy5WD0ug==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-96aadfb19d7so738735966b.2;
        Fri, 19 May 2023 18:16:37 -0700 (PDT)
X-Gm-Message-State: AC+VfDyc0RzRvRK04RpqQECRiliB5mltyFPrSAqqiS2e4X5bDnxH+wsf
        YxVsaPI12z9/zYPCqoPgtHh+sqx1Al8aBWWnndo=
X-Google-Smtp-Source: ACHHUZ5BJxethRchVhvqgx4k+CmNvVMLwKMqXE8ThR/0TeGuD/7A9IKk1GVtu6KMRelWQhhuu+wSq2pSNp/02QFmE9M=
X-Received: by 2002:a17:907:8a10:b0:96a:d916:cb2f with SMTP id
 sc16-20020a1709078a1000b0096ad916cb2fmr4107322ejc.36.1684545395510; Fri, 19
 May 2023 18:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230518184541.2627-10-jszhang@kernel.org> <mhng-e1d500da-688e-49bf-a2d8-bef0e2df48f8@palmer-ri-x1c9a>
In-Reply-To: <mhng-e1d500da-688e-49bf-a2d8-bef0e2df48f8@palmer-ri-x1c9a>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 20 May 2023 09:16:24 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQrfGyitzi7yhcs1dedG9NH2wnieoLu78SUNSaRiyL9dg@mail.gmail.com>
Message-ID: <CAJF2gTQrfGyitzi7yhcs1dedG9NH2wnieoLu78SUNSaRiyL9dg@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] riscv: defconfig: enable T-HEAD SoC
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     jszhang@kernel.org, tglx@linutronix.de,
        Marc Zyngier <maz@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        frank.li@vivo.com, wefu@redhat.com, uwu@icenowy.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Guo Ren <guoren@kernel.org>

On Sat, May 20, 2023 at 4:56=E2=80=AFAM Palmer Dabbelt <palmer@dabbelt.com>=
 wrote:
>
> On Thu, 18 May 2023 11:45:41 PDT (-0700), jszhang@kernel.org wrote:
> > Enable T-HEAD SoC config in defconfig to allow the default
> > upstream kernel to boot on Sipeed Lichee Pi 4A board.
> >
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/riscv/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfi=
g
> > index d98d6e90b2b8..109e4b5b003c 100644
> > --- a/arch/riscv/configs/defconfig
> > +++ b/arch/riscv/configs/defconfig
> > @@ -27,6 +27,7 @@ CONFIG_EXPERT=3Dy
> >  CONFIG_PROFILING=3Dy
> >  CONFIG_SOC_MICROCHIP_POLARFIRE=3Dy
> >  CONFIG_ARCH_RENESAS=3Dy
> > +CONFIG_ARCH_THEAD=3Dy
> >  CONFIG_SOC_SIFIVE=3Dy
> >  CONFIG_SOC_STARFIVE=3Dy
> >  CONFIG_ARCH_SUNXI=3Dy
>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>



--=20
Best Regards
 Guo Ren
