Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49896DAA36
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 10:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjDGIes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 04:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjDGIeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 04:34:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B1911C;
        Fri,  7 Apr 2023 01:34:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B1D9648CA;
        Fri,  7 Apr 2023 08:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DECAC4339C;
        Fri,  7 Apr 2023 08:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680856484;
        bh=WJH5Kn+G+Mpn2d43oNBGeROdsHIA2VvrZQA7fMNx0lg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uGTYH2xcdt+o04q0JPEsqFu72dRr+q44w5Rkn+deddTQ6rGjATvbkJGoVKU2fVDn5
         bwJ6FfevUOakhBnl4Fo/FetmziQumwa7nZFsxiLw2EpEyOY92XuJfPFancW08Svvby
         zbMHwvR/cczv5V6T9Dsdrzno1rcg78Hm34knkrS84snfJHT0qk8iMXgDClykR719TI
         yuVUHvC6ksIPpG0oy2gpaA0mYtiX+l7bpNezV03k1BiKYw/+Zpcli4SRe4wzABq4y0
         IROpo1Gp5N6ZLaY5+qdyoOciD2/XYNAn6HtN+hpLbvITS2ioWl0zY+mjFkL25loysK
         DEAHSB2chZt4A==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-942e6555947so160090566b.2;
        Fri, 07 Apr 2023 01:34:44 -0700 (PDT)
X-Gm-Message-State: AAQBX9dEXBynpvQaPljhdJe/J7oSjHE7nAKSuODZeaIqG5at10zfsYDW
        gZmu/ppcJ8rME0LQE52+lL82eydjGnXdpHX1erg=
X-Google-Smtp-Source: AKy350ZkAgTWHQwTncWH37YSTupT2jbEF7Bd7DZ3BElkwFqpJ5PRGZc35iYbOigftxmXdOqn0uQrzQtqlRb23I5eMlI=
X-Received: by 2002:aa7:dcc4:0:b0:4f9:deb4:b97f with SMTP id
 w4-20020aa7dcc4000000b004f9deb4b97fmr1942589edu.13.1680856482789; Fri, 07 Apr
 2023 01:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230406220206.3067006-1-chenjiahao16@huawei.com> <20230406220206.3067006-3-chenjiahao16@huawei.com>
In-Reply-To: <20230406220206.3067006-3-chenjiahao16@huawei.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 7 Apr 2023 16:34:31 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR-3a6X2_XPWzOaDdfMehQnQhU0aAxOXOPqOJ=CM5fFUw@mail.gmail.com>
Message-ID: <CAJF2gTR-3a6X2_XPWzOaDdfMehQnQhU0aAxOXOPqOJ=CM5fFUw@mail.gmail.com>
Subject: Re: [PATCH -next v3 2/2] docs: kdump: Update the crashkernel
 description for riscv
To:     Chen Jiahao <chenjiahao16@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, bjorn@rivosinc.com,
        alex@ghiti.fr, akpm@linux-foundation.org, atishp@rivosinc.com,
        bhe@redhat.com, thunder.leizhen@huawei.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Thu, Apr 6, 2023 at 10:05=E2=80=AFPM Chen Jiahao <chenjiahao16@huawei.co=
m> wrote:
>
> Now "crashkernel=3D" parameter on riscv has been updated to support
> crashkernel=3DX,[high,low]. Through which we can reserve memory region
> above/within 32bit addressible DMA zone.
>
> Here update the parameter description accordingly.
>
> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 54702bd488eb..41865aae9eaa 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -866,7 +866,7 @@
>                         memory region [offset, offset + size] for that ke=
rnel
>                         image. If '@offset' is omitted, then a suitable o=
ffset
>                         is selected automatically.
> -                       [KNL, X86-64, ARM64] Select a region under 4G fir=
st, and
> +                       [KNL, X86-64, ARM64, RISCV] Select a region under=
 4G first, and
>                         fall back to reserve region above 4G when '@offse=
t'
>                         hasn't been specified.
>                         See Documentation/admin-guide/kdump/kdump.rst for=
 further details.
> @@ -879,14 +879,14 @@
>                         Documentation/admin-guide/kdump/kdump.rst for an =
example.
>
>         crashkernel=3Dsize[KMG],high
> -                       [KNL, X86-64, ARM64] range could be above 4G. All=
ow kernel
> -                       to allocate physical memory region from top, so c=
ould
> -                       be above 4G if system have more than 4G ram insta=
lled.
> -                       Otherwise memory region will be allocated below 4=
G, if
> -                       available.
> +                       [KNL, X86-64, ARM64, RISCV] range could be above =
4G.
> +                       Allow kernel to allocate physical memory region f=
rom top,
> +                       so could be above 4G if system have more than 4G =
ram
> +                       installed. Otherwise memory region will be alloca=
ted
> +                       below 4G, if available.
>                         It will be ignored if crashkernel=3DX is specifie=
d.
>         crashkernel=3Dsize[KMG],low
> -                       [KNL, X86-64, ARM64] range under 4G. When crashke=
rnel=3DX,high
> +                       [KNL, X86-64, ARM64, RISCV] range under 4G. When =
crashkernel=3DX,high
>                         is passed, kernel could allocate physical memory =
region
>                         above 4G, that cause second kernel crash on syste=
m
>                         that require some amount of low memory, e.g. swio=
tlb
> @@ -897,6 +897,7 @@
>                         size is platform dependent.
>                           --> x86: max(swiotlb_size_or_default() + 8MiB, =
256MiB)
>                           --> arm64: 128MiB
> +                         --> riscv: 128MiB
>                         This one lets the user specify own low range unde=
r 4G
>                         for second kernel instead.
>                         0: to disable low allocation.
> --
> 2.31.1
>


--=20
Best Regards
 Guo Ren
