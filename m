Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE185F3D49
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 09:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJDHc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 03:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiJDHcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:32:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789EC4CA27;
        Tue,  4 Oct 2022 00:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664868741; x=1696404741;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B7CtfrCbolV18LxT8S0d6Hty+iGNajgoYldBeI1fZ6g=;
  b=xZ6IScUChAfAUbTBFRgreegluf/K5bs/vfDS/yxDStHG/U1DHN+IEfVV
   M4hRNuLxCxWWuyK8+LLdjHEBXOt7aqNhnKpfjqLZbJEtoCbTz9FSE8i2t
   934XF6zxqdq7X5ljwkJnbtrWjNMuTqdpFY3EYFo+Y6GdF18SSYUlHNspM
   d1Gu4h4W7kc+yfMJ7GWOIjd/w3KlqiCzCcnGNulc2/rkhsXpYoU9wq3+P
   HBqXYx4VLNq5JlCd/FborYwqwTG6gQnWUUqWrA1RmuTGIPixhH8Yw3XwJ
   E3PJWWoLn1DZw8gmSfY6ncllAsbcCaN/FgdsMtFt8ye8Gmp/94x649cUn
   A==;
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="193694898"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Oct 2022 00:32:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 4 Oct 2022 00:32:20 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 4 Oct 2022 00:32:17 -0700
Date:   Tue, 4 Oct 2022 08:31:55 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [RFC PATCH v2 1/2] dt-bindings: soc: renesas:
 r9a07g043f-l2-cache: Add DT binding documentation for L2 cache controller
Message-ID: <YzvhaxuZbeCwLZ5m@wendy>
References: <20221003223222.448551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221003223222.448551-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdX1BuvHz46QWd+ajEcwmWMeSmvN4AtODuFEysRk14ArZQ@mail.gmail.com>
 <CA+V-a8vnNQDMgjhJfz91g++dVVv5Z5FTuFrNRHLW3PjPump0Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+V-a8vnNQDMgjhJfz91g++dVVv5Z5FTuFrNRHLW3PjPump0Mg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 08:26:01AM +0100, Lad, Prabhakar wrote:
> Hi Geert,
> 
> Thank you for the review.
> 
> On Tue, Oct 4, 2022 at 7:42 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Prabhakar,
> >
> > On Tue, Oct 4, 2022 at 12:32 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Add DT binding documentation for L2 cache controller found on RZ/Five SoC.
> > >
> > > The Renesas RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP
> > > Single) from Andes. The AX45MP core has an L2 cache controller, this patch
> > > describes the L2 cache block.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/soc/renesas/r9a07g043f-l2-cache.yaml
> >
> > Not andestech,ax45mp-cache.yaml?
> >
> I wasn't sure as we were including this in soc/renesas so named it as
> r9a07g043f-l2-cache.yaml if there are no issues I'll rename it
> andestech,ax45mp-cache.yaml.

I may be guilty of suggesting soc/renesas in the first place, but should
this maybe be in soc/andestech? I have no skin in the game, so at the
end of the day it doesnt matter to me, but I would imagine that you're
not going to be the only users of this l2 cache? Or is it a case of "we
will deal with future users when said future users arrive"? But either
way, naming it after the less specific compatible makes more sense to
me.

Thanks,
Conor.



