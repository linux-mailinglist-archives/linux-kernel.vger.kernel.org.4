Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01ED26948AB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjBMOvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjBMOvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:51:45 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767401C5A1;
        Mon, 13 Feb 2023 06:51:30 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-52bfa3dfd95so165970557b3.9;
        Mon, 13 Feb 2023 06:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z/dOuMvcM1NQm8lVIrIbaxwgFwDZX70A1J7X1KjVaE0=;
        b=q7MwCKZLDcxq968XQrEAjkRBrJ8usj6WFVYNbin4ZnqYZ5D5gbQwSslMWLj1yOSVfm
         KuEVIssnIWcfsftsWswHoOQQTx+ux0ycqNj7oFSOv9ncGSlbER9buQv8ug008+v33UJk
         Q1TVG1mDm71Wq5Db9UxEAn1JgHBmNUjNxddAKo4dl0D4ag+eXDgjGqKm/rvpgIk/Hh36
         atpSyDOYxxc+un73jWshyIJG0QNBK9gM3cvLeQ7/NSqHVS2PmDNRwY6PO6tZqUdSCKz5
         nUKB4u/sO6d5JTH/+cTVWAy2ILkD+oXN4VtwFbVcr2LkqinrAfUmYlDzh5CD7v8IIatC
         dx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/dOuMvcM1NQm8lVIrIbaxwgFwDZX70A1J7X1KjVaE0=;
        b=L+bWwy9pqzZy5pDnrjbQOXrh/5Nc74E4lkbvtIoQrweVNqBqmcePl6PNLml1qEaLMp
         o5uOAH2ha3vCNZEz1fht8ggaya3hNVCJbAwlDsN13O/oHRzEbdm0AHWpmcqSS6jUAnCm
         83E7tOFrxU0NQPcy90UcKCeez8jDiMuU5AFQNY/CcxtzOVTYbYWFvTu5PelVB4SysyNn
         Kh+Qy1SWh+yJz3WAh2J4dgiUr9zoPn/diyX/c8IMx7nKOKQ8+dJfHQ92KovH2w/ctC8P
         puXB1wbUOhACXFEHC2gJgnkwWlZ2G77DrWZ3y2iX4wVKMxOWi7f5V21msUFGOR07DPxS
         B9nQ==
X-Gm-Message-State: AO0yUKXVMkXKOQKqHASduRE8qKOTQdhH5L6VJoRIH9HDMXSK3brcPtmH
        ooMdcihP04GZCzncShN/gHGKlbQQm7SLJfP6XpM=
X-Google-Smtp-Source: AK7set+lQ1JXxMZgz0LbLG6h2CJDhcSTWEzXSB+Z5785PYiJe06L+oySm8rA9DhIrgd2gLwektTzTdk2ScUsWlAp3P8=
X-Received: by 2002:a0d:ff45:0:b0:52e:e6ed:30a8 with SMTP id
 p66-20020a0dff45000000b0052ee6ed30a8mr1052026ywf.552.1676299889631; Mon, 13
 Feb 2023 06:51:29 -0800 (PST)
MIME-Version: 1.0
References: <20230131223529.11905-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230131223529.11905-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdUszsaQDOT-eZz8+BvFGsFuBbhif+-gHDEZa_oMZUG7ng@mail.gmail.com>
In-Reply-To: <CAMuHMdUszsaQDOT-eZz8+BvFGsFuBbhif+-gHDEZa_oMZUG7ng@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 13 Feb 2023 14:51:03 +0000
Message-ID: <CA+V-a8v_+afFfzjyTSJr9-YKhOum=7kyVX6hXCBDY-UZqu=egg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: renesas: r9a07g044: Use SoC specific
 macro for CPG and RESET
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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

Thank you for the review.

On Mon, Feb 13, 2023 at 2:09 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Tue, Jan 31, 2023 at 11:42 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Use a SoC specific macro for CPG and RESET so that we can re-use the
> > RZ/G2L SoC DTSI for RZ/V2L SoC by just updating the SoC specific macro.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2
> > * No change
>
> Thanks for your patch!
>
> > --- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > @@ -1,12 +1,16 @@
> >  // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >  /*
> > - * Device Tree Source for the RZ/G2L and RZ/G2LC common SoC parts
> > + * Device Tree Source for the RZ/G2L, RZ/G2LC and RZ/V2L common SoC parts
> >   *
> >   * Copyright (C) 2021 Renesas Electronics Corp.
> >   */
> >
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +#ifndef SOC_CPG_PREFIX
> >  #include <dt-bindings/clock/r9a07g044-cpg.h>
> > +#define SOC_CPG_PREFIX(X)      R9A07G044_ ## X
>
> As we're setting a precedent, this might as well be just SOC_PREFIX(X).
> Some SoCs have multiple sets of definitions.
Agreed.

> I can make that change myself while/if applying.
>
Thank you.

> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> > +#endif
>
Cheers,
Prabhakar
