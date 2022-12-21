Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDA5652A7D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbiLUAbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLUAbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:31:45 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168A9201AC;
        Tue, 20 Dec 2022 16:31:44 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id i15so19949546edf.2;
        Tue, 20 Dec 2022 16:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VCqofWIdcRE0wcGcSYV7leS63wz3iWTm3oh5pG3tFkc=;
        b=ErTUjWAMWzlIL8k4rTRrQFek0BdgPOCmhnjqDcWpWtonCq6c1XTEGzH6sp4pn0lUxz
         x3z+eUpewj90wgHmbPH3/EgJiZXLKuT8fltUObTY4ZeGXrqq/kCdICQ3ta3JYJ5w9lZv
         LbmSdH44cxFZgLnTjl96cxPJ2vsx1QSRRkayQwawxQXDXEI+Bk7ncl5SlvTv1ZzF7MkD
         hvQd2e+Lj3d/lA47bPPz0K0gUAmL5G6iHf5Qq/+uLYvDEb6vo03SWYNjyFgDVcwduge0
         8B6c3GDvoK23djOrnLLEw9yfz0K/4tqWn/jPN+MkpoN8+Z+X8eMPEn8KSYBwXhg2klHU
         K5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCqofWIdcRE0wcGcSYV7leS63wz3iWTm3oh5pG3tFkc=;
        b=QnCEhhkubMGcj3ZbPVfJXXQI5BOhh50Eoxw3b95QFG7llJWaarEzlpTYC9cT/XnWbQ
         pED5kPgIqEIBIc0gYCFg/wezTiwLLKOQhKCDF/SgBxNEDA319pMfhUU/DYbMj8mci1KQ
         k+9y7/bikUekY6AzS+sG9JOs8whfNFj3SvfWX/vk264IJewkqQlEGhnbs6cCuVSbYHcv
         /BvAGN7dJNpwpXFnymD0CT5ikSNR+GLakIgoQjOsVrVTKWdcjVbOlp4ZzdhqilQXe9jV
         pKpm2GHHtWhOQbJWIfOEVcVhVBHyom68Megv/mA9wDqNrZ1jNlq9CJqkS17e3cFhXi/w
         60Aw==
X-Gm-Message-State: ANoB5plEWbqYnMh7UXpSd0vAYA0OEnx/oq4+RpesKCAp6gApW7//UMDj
        +nk3GaFoK1QxA+OLhCsHO9GLAouo69upTDDogL4=
X-Google-Smtp-Source: AA0mqf7Vj4LDQTGT2qms5U1xLKxeAG3aN068iuTz4pDqzDHwntSg3DsFDaeiJD2ru6wqI5VUjpTXdMYzkArTY5MWRxQ=
X-Received: by 2002:aa7:cc08:0:b0:461:8a43:e93 with SMTP id
 q8-20020aa7cc08000000b004618a430e93mr10657639edt.275.1671582702709; Tue, 20
 Dec 2022 16:31:42 -0800 (PST)
MIME-Version: 1.0
References: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221212115505.36770-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y54ycZdMLjU5QVn5@spud> <CA+V-a8sa1H=Hh2SzbKDWhiAO=C+Y2YN7sk9APBeqktBeHf49jA@mail.gmail.com>
 <Y6CPQWHrPLk1O6jB@spud>
In-Reply-To: <Y6CPQWHrPLk1O6jB@spud>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 21 Dec 2022 00:31:16 +0000
Message-ID: <CA+V-a8sZeFgbUuuxHmXGEMKoayB02K22dZuw0TZHHv36UcdcVw@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] riscv: errata: Add Andes alternative ports
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Guo Ren <guoren@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Mon, Dec 19, 2022 at 4:20 PM Conor Dooley <conor@kernel.org> wrote:
>
> On Mon, Dec 19, 2022 at 11:19:13AM +0000, Lad, Prabhakar wrote:
> > Hi Conor,
> >
> > Thank you for the review.
> >
> > On Sat, Dec 17, 2022 at 9:19 PM Conor Dooley <conor@kernel.org> wrote:
> > >
> > > On Mon, Dec 12, 2022 at 11:55:02AM +0000, Prabhakar wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Add required ports of the Alternative scheme for Andes CPU cores.
> > > >
> > > > I/O Coherence Port (IOCP) provides an AXI interface for connecting external
> > > > non-caching masters, such as DMA controllers. IOCP is a specification
> > > > option and is disabled on the Renesas RZ/Five SoC due to this reason cache
> > > > management needs a software workaround.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > > v4 -> v5
> > > > * Sorted the Kconfig/Makefile/Switch based on Core name
> > > > * Added a comments
> > > > * Introduced RZFIVE_SBI_EXT_IOCP_SW_WORKAROUND SBI EXT ID to check if
> > > >   CMO needs to be applied. Is there a way we can access the DTB while patching
> > > >   as we can drop this SBI EXT ID and add a DT property instead for cmo?
> > > >
<snip>
> > > Seeing as you need a new version for some of the other bits, I think it
> > > would be good to add a minor comment here somewhere (be it here or the
> > > commit message) that links to the SBI specs for this.
> > > I think this looks pretty good though.
> > Sure I'll add a comment here.
> >
> > I was wondering if we can get rid of this vendor specific extension
> > here if we get access to the DT here (for example having a DT property
> > which would indicate if IOCP CMO should be applied or not). Do you
> > think that would be good approach?  ATM we dont have a pointer here
> > for FDT whie early patching.
>
> I dunno. I think it is fine to use the ECALL to be honest - I'd rather
> that than a property that someone may omit.
>
Ok, I was so I will stick with the current implementation.

> That said, for the cache management stuff we are gonna need for
> PolarFire SoC, we will need to have info from the DT AFAICT - marchid
> etc are all set to zero on our platform so cannot be used.
>
Aha so while patching you will need a pointer to FDT node.

> I was thinking about using the compatible instead, but...
> we've not tried to "forward"-port our stuff from 5.15 yet as we have
> not yet completed testing testing on our vendor tree (and need some PCI
> changes accepted upstream first anyway), as a result I have not looked
> into what's needed there for use with alternatives. We've been using a
> pre-alternatives version of that patchset from around the 5.15
> development point in time instead.
>
Good to know. Let me know if you plan to implement the patching
mechanism based on FDT soon. I can give it a test.

Cheers,
Prabhakar
