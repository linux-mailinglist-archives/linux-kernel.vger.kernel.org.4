Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A446FA00A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjEHGm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjEHGmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:42:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88476EB9;
        Sun,  7 May 2023 23:42:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58D8D61F1D;
        Mon,  8 May 2023 06:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE278C433D2;
        Mon,  8 May 2023 06:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683528143;
        bh=r4iJVdq+kSsrznQO5iASjJKSVcwHIpX8k/weFqPL9PI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q7kcmg1iT3UqoMWAplBRwyuluRJxI8j7Y+GLwaHViQ7KuLs7RGOUVeVyY7gwJyOyB
         KG94ukA6ksrI4RkIM9j0YBB9EajPNCkD/mNhkfsuMonQFvf1XYcfXdK1VWoU+HjMSd
         SheLyaDBcWQ5Ks8REeDwSqHWzBLYkuKcFnNoiCd/wqWN1O/fArsOYIzDBvVXYANcz3
         EdCHu8W+TwziYxkltnqmQ3lGDMFvH9xbjK5MmUgGptXTEAjzPWjxniclbc5Bq1/Di/
         0tMPHMPhP0XYEnjSWjpEpqOeJgFg//ImzuwDJS5L7QobAv5AzPaPYKJBUkorYBF02r
         7CFgBQ9gQR7Vg==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-965e4be7541so568268666b.1;
        Sun, 07 May 2023 23:42:23 -0700 (PDT)
X-Gm-Message-State: AC+VfDzqgsudndp3sXQzYdJOHubSc6omZScJBcFn8o3TqHvGTonqTqsm
        Qg9pwZhJb7LvQXiAED3vqvmWVpx+Mvmfnb37Ew0=
X-Google-Smtp-Source: ACHHUZ4mwkcqjrAbBZUuOGbMCbkwPBgYeaGSSqohUR7fCRsoF+JinJDShKS4My6aDu+hZJHKsZERSxfc7mVo1Rq0h1Q=
X-Received: by 2002:a17:907:7f87:b0:965:d7c7:24d4 with SMTP id
 qk7-20020a1709077f8700b00965d7c724d4mr10802839ejc.77.1683528141910; Sun, 07
 May 2023 23:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230507182304.2934-1-jszhang@kernel.org> <20230507182304.2934-3-jszhang@kernel.org>
 <20230507-sleeve-tacky-21e817e31fb2@spud>
In-Reply-To: <20230507-sleeve-tacky-21e817e31fb2@spud>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 8 May 2023 14:42:10 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTSRQUX8C3C-tgq4o5iGJqKTja7-1Dv8epG_qZizUvSow@mail.gmail.com>
Message-ID: <CAJF2gTTSRQUX8C3C-tgq4o5iGJqKTja7-1Dv8epG_qZizUvSow@mail.gmail.com>
Subject: Re: [PATCH 2/5] riscv: Add the T-HEAD SoC family Kconfig option
To:     Conor Dooley <conor@kernel.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 8, 2023 at 5:22=E2=80=AFAM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Mon, May 08, 2023 at 02:23:01AM +0800, Jisheng Zhang wrote:
> > The first SoC in the T-HEAD series is light(a.k.a th1520), containing
> > quad T-HEAD C910 cores.
> >
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/riscv/Kconfig.socs | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > index 1cf69f958f10..ce10a38dff37 100644
> > --- a/arch/riscv/Kconfig.socs
> > +++ b/arch/riscv/Kconfig.socs
> > @@ -41,6 +41,12 @@ config ARCH_SUNXI
> >         This enables support for Allwinner sun20i platform hardware,
> >         including boards based on the D1 and D1s SoCs.
> >
> > +config ARCH_THEAD
>
> Could you please add a defconfig patch, adding this option, so that we
> build support for this platform by default?
Yes, but it's another patch, see: 'commit eb20e7cb91ba ("riscv:
defconfig: Enable the Allwinner D1 platform and drivers")'


>
> Thanks,
> Conor.
>
> > +     bool "T-HEAD RISC-V SoCs"
> > +     select ERRATA_THEAD
> > +     help
> > +       This enables support for the RISC-V based T-HEAD SoCs.
> > +
> >  config ARCH_VIRT
> >       def_bool SOC_VIRT
> >
> > --
> > 2.40.0
> >



--=20
Best Regards
 Guo Ren
