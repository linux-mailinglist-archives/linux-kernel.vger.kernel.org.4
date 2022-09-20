Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526C05BEAC3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiITQFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiITQFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:05:42 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39585F9A4;
        Tue, 20 Sep 2022 09:05:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u9so7347652ejy.5;
        Tue, 20 Sep 2022 09:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Eoj+9YVS7ZbvdHxGcn08+V7ecurW5KQvPgCOMjMH010=;
        b=kjU9hV8Jl2mKbVH0atog7MEskvKVMD9stVp5tTaogMS7eA8whFWkcxzC+ndpdlRoSz
         cWOcC81rhxeIZlNl+1hokFH0dloCkV8m3p9yuNQ/ntyMPQER7kSoOamT1FdxqAIJu8D3
         mxnuecSURZO7Dcyysr9OiVWReIXxdHGAY5YE699JnvYLJts5wLhTrSgioCIFZEELwkYv
         q9l9TB8snGKAlRqCq7IpvZqxL40MeP+aGrBDEZuI7lrj/RSsupPYZg6YgzLXxB+IufbA
         6AZmL+8kM/E1FVR61Agrk3g28pwSc4vsAGB0BpvOf1cs5WUPsR7yYRJeskbsuZesVTcF
         /rkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Eoj+9YVS7ZbvdHxGcn08+V7ecurW5KQvPgCOMjMH010=;
        b=Sk2JYfU1XpkT67InsYTnO6CcRXyBWBXPRVjlXoyZYizrO2s68YiRihQze2MOnKbK1V
         hlv9RV8P4URTyV4g2nRY8T35MDely8tRhqcDMNVYDZmrWJhJOY+2NZbLzS1G8JkxazOt
         7UwS8GJJM+UUzTdH81hkQRJ6KlJM9Pq50+ady72Pr43MkmFo2VxyJQqcDv2X9EXhFh9X
         t/+7FwW3fErcfDDkvs57UrqMYZV3pMLOqRzTzEAb4kqK+F8XeOEC1RqKo4Q6gY+bORgr
         tEw7/YF9OcYbnX7W3+xyw3JpWVI97MJorglLbWjg9xtWNwIiE8WEK1OGUeK1soU6+z/N
         NvCg==
X-Gm-Message-State: ACrzQf13cQVcgIf8PJR1pezHha7337TAJlAXaEb5yMkvsexfwgUIdU5w
        EtCZWcPcNqA3dvSfvA7kG8L0xaRI2iXqOnzhdP0=
X-Google-Smtp-Source: AMsMyM48vhimTOMy7qPE4/TDwKwjy1/XnY2/SRfe6v6ZGuZqQeW9NiA4wGt5KXErXoSujh/QByRFk32JRBhed8tP15k=
X-Received: by 2002:a17:907:847:b0:77f:f489:cc25 with SMTP id
 ww7-20020a170907084700b0077ff489cc25mr17227555ejb.80.1663689939190; Tue, 20
 Sep 2022 09:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220915181558.354737-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdW99EutciosPtOTU9AztfvfMdKTaS+YRmpmS4VnhZ9KAA@mail.gmail.com>
 <CA+V-a8s9y0Jq4TJk9E_ptsZTW3iCoysaBSrUeQV8qfDFO3wzeQ@mail.gmail.com> <CAMuHMdWy=uU-QQgkz+-sBHfuK9tE-E4LijVLrYX7Efh9=C9vLg@mail.gmail.com>
In-Reply-To: <CAMuHMdWy=uU-QQgkz+-sBHfuK9tE-E4LijVLrYX7Efh9=C9vLg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 20 Sep 2022 17:05:12 +0100
Message-ID: <CA+V-a8uQ1XOq4v+nmoxOKk=K5tmahXeAttvE8BdbMBoU8GHr-A@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] riscv: dts: renesas: Add minimal DTS for Renesas
 RZ/Five SMARC EVK
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Atish Patra <atishp@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
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

Hi Geert,

On Tue, Sep 20, 2022 at 4:07 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Tue, Sep 20, 2022 at 3:05 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Tue, Sep 20, 2022 at 1:32 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Thu, Sep 15, 2022 at 8:17 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Enable the minimal blocks required for booting the Renesas RZ/Five
> > > > SMARC EVK with initramfs.
> > > >
> > > > Below are the blocks enabled:
> > > > - CPG
> > > > - CPU0
> > > > - DDR (memory regions)
> > > > - PINCTRL
> > > > - PLIC
> > > > - SCIF0
> > > >
> > > > Note we have deleted the nodes from the DT for which support needs to be
> > > > added for RZ/Five SoC and are enabled by RZ/G2UL SMARC EVK SoM/carrier
> > > > board DTS/I.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> > > > --- /dev/null
> > > > +++ b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
> > > > @@ -0,0 +1,42 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +/*
> > > > + * Device Tree Source for the RZ/Five SMARC EVK SOM
> > > > + *
> > > > + * Copyright (C) 2022 Renesas Electronics Corp.
> > > > + */
> > > > +
> > > > +#include <arm64/renesas/rzg2ul-smarc-som.dtsi>
> > > > +
> > > > +/ {
> > > > +       aliases {
> > > > +               /delete-property/ ethernet0;
> > > > +               /delete-property/ ethernet1;
> > >
> > > OK
> > >
> > I assume you are OK with dropping the above too?
>
> I did intend to delete these properties (hence the "OK"), as their
> presence may confuse U-Boot.
>
Thank you for the clarification.

Cheers,
Prabhakar
