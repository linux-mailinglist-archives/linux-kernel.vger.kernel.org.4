Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE1667EFE6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 21:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjA0UpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 15:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjA0UpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:45:13 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64C84696;
        Fri, 27 Jan 2023 12:44:54 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-4ff1fa82bbbso82729867b3.10;
        Fri, 27 Jan 2023 12:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HpfHBLEjr2vdbKV+0dkwO8LQDxC3RbdmQBbQmVgbYeU=;
        b=fFagbbDp+Ukm9XHs7OdXdGNLoP7WegQWoczuvA4bhv3lf6pfuLkvTyAGTdYJTzAjYT
         QkDHWma5P606j23UUP+86fAPSIs6DLX72H9SGk+CmJctEA6Zeg0KPjj9+JoMCz8RZINZ
         rpY4fpAJ7oIoBicCj7K5AOMoksyRHFYpMGRNI3VyhJEHRhDdexc20vZW/NQBXro4pNQT
         4e+Qgx+gpW4lVnYyb9RM532xdsmYDFuO7lvPAlZIJ09dzQDDViBQ0SEa64how1Lzbdst
         H+cXNP4ptZiYQ4wX3+vfsf6AaSaivzGrpMj2teMQgG5474GjTQWUUrbKzi0MqDPe0dYt
         aoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HpfHBLEjr2vdbKV+0dkwO8LQDxC3RbdmQBbQmVgbYeU=;
        b=6tr7Cbh6nZErbudt2M6x79S6BXHTnfKNwoxP58u3NbzaR939JvcyrhM3fcCARGdGR5
         y6L1nCKHk5VbivCoIpxsyXkWY5QjGIiarBcybVv1DfckpAcN4gAYZ6hiofhcu3WiCsyn
         90glogHp7oayCuw0cudSPBOf3DsFFXBhrMMkSS6FneK0rH+SZzhVZzWD+xnHTIH6XN3V
         lb9HulFAjpJkq9fq7LVV6ishQ9F5+D0Ex0J8s3JHBkOoG8g5dIwLpv9+iyN5zryXP07M
         hkQq6YvP/j47mnunVcJqhvbzUtelAUZnXVw5Ppj0h+gheZV6v3NiomsyUaaFe5RUCuj+
         TN9Q==
X-Gm-Message-State: AO0yUKWi3CYS9CohYBDxFfgcB4/IYR3S3fLuThsFASbVwBf9QoUNCs6P
        e1vfBSRaX9pr+0ztxFusQHObngiIId2/gyIgm5c=
X-Google-Smtp-Source: AK7set8DZ0Zl/oEivruVXnSx64gdAEaYCLKBzVkAmUzaD7E4Zuoo8DLDHz3uhW+S7X2xqy15206NHE2PN0iel6UdohI=
X-Received: by 2002:a81:4656:0:b0:4fd:9685:d982 with SMTP id
 t83-20020a814656000000b004fd9685d982mr19078ywa.304.1674852293921; Fri, 27 Jan
 2023 12:44:53 -0800 (PST)
MIME-Version: 1.0
References: <20230127174014.251539-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <OS0PR01MB592258905AC3979803C473D786CC9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB592258905AC3979803C473D786CC9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 27 Jan 2023 20:44:27 +0000
Message-ID: <CA+V-a8s+cZpuUXWRa573a373n7YPsHrdLnUVXHjez6O101oneQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Biju,

Thank you for the review.

On Fri, Jan 27, 2023 at 6:38 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Hi Prabhakar,
>
> Thanks for the patch.
>
> > Subject: [PATCH] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
> >
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Enable the performance monitor unit for the Cortex-A55 cores on the RZ/G2L
> > (r9a07g044) SoC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > index 80b2332798d9..ff9bdc03a3ed 100644
> > --- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > @@ -161,6 +161,11 @@ opp-50000000 {
> >               };
> >       };
> >
> > +     pmu_a55 {
> > +             compatible = "arm,cortex-a55-pmu";
> > +             interrupts-extended = <&gic GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
>
> Just a question, Is it tested?
Yes this was tested with perf test (https://pastebin.com/dkckcYHr)

> timer node[1] defines irq type as LOW, here it is high.
You are right looking at the RZG2L_InterruptMapping_rev01.xlsx this
should be LOW. (I followed the SPI IRQS where all the LEVEL interrupts
are HIGH)

> Also do we need to define (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW) as it has 2 cores??
>
No this is not required for example here [0] where it has 6 cores.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/renesas/r8a779f0.dtsi?h=v6.2-rc5#n203

Cheers,
Prabhakar
