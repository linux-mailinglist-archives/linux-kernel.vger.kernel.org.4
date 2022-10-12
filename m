Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3D15FCB3B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 21:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJLTAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 15:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJLTAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 15:00:43 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207918307A;
        Wed, 12 Oct 2022 12:00:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y14so22825299ejd.9;
        Wed, 12 Oct 2022 12:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kjhsuI/Z6GQOe2e/zNEe4d946JQ/hFUZIJZDiMDxcZs=;
        b=bNLW2l8ZMkxoyhYaq/Mh1uMqzXmJxJtVWWJVYc7im0ysg8sZLPjdPL+JqnFO9w6yJL
         8gA8FKterjujW3nNQ1TK8O6+q/qiZ5TKcUN+TwQo4qBthHSuRknFmXe37lSwUWA/qN6o
         qpV6/4+nz7C+B/DJ6vYCbcmNrDHEMXeaqc3Hok+m4aAwU1ttq67pZ1J11niOlgrJMI5e
         IsIrmMwQYxWO5EavIq8r6ueId/+VBxRd+UDClg2ci/LC5fU1FWjWomcGY8VDjNFytlb0
         ZzMgJfMqilLz+ACVZ6MgDEF1FEaAK09pz5xZQ6OO7qzyNFS/XfcXT99oSs6lCRS13R10
         WVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kjhsuI/Z6GQOe2e/zNEe4d946JQ/hFUZIJZDiMDxcZs=;
        b=yCyxQqIb/+ILphjpw2RqL+jHp41OjMd53AbGp+AiBKem2B+T9LUX0k3hWWTuBHeNEX
         EgAOOByyBE+w9mwfP1kvrOhzCir68Eg3tnFrUK5WSlarDw9zDarMLolCZIzKuTGi2eBX
         e2buNGeEKPiYBzEzNfJCOWBJGjWYodm7P88F54hdquPcVTkL0gh9hRMB5sPZIEo2/fLR
         gT7HY7Q4zcViwPi3paRxj/zHXJtonfGbHxqPoMb8t2dQRukEDKOHqVs+juxdUvH3pNh0
         miEZ0ixXuYlK55K+V0YPJQA1fcFrno57+gBf9tiSVSy9Urw1FmmATyBTWafzClyPEhHA
         mj5w==
X-Gm-Message-State: ACrzQf1V10hBe7gMIUuDRiTAL0BXI4HBaKbGG/8kTMHJ1AYTaXQUrPct
        YZXh8nTzY3LrReorVfwedsRCD28+Q5cP2D09Wzcq4m/FyTNzjQ==
X-Google-Smtp-Source: AMsMyM4GRmbcLMxX+m/5cASM72GTHHI1Fm/kjxgLgJL5/pKlhwbCuKt0BVYY1gUEJsvJuYijKhRBe5x/wZc5wD8GsFg=
X-Received: by 2002:a17:907:b07:b0:78d:ce2b:1999 with SMTP id
 h7-20020a1709070b0700b0078dce2b1999mr9976482ejl.267.1665601238329; Wed, 12
 Oct 2022 12:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220929172356.301342-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CA+V-a8vD1+kbby8rbZqYv2Ux1GaT=7n7V9qHJS3Djv-fKdWrAQ@mail.gmail.com> <57e454f4-6767-bf42-8337-ce1f486137ca@linaro.org>
In-Reply-To: <57e454f4-6767-bf42-8337-ce1f486137ca@linaro.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 12 Oct 2022 20:00:11 +0100
Message-ID: <CA+V-a8sfhHeFa=NAUvZH+DDUjRbdFoCqr4itiYHzxv_jSY9HWg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] RZ/G2UL separate out SoC specific parts
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        DT <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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

Hi Krzysztof,

On Wed, Oct 12, 2022 at 4:38 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 10/10/2022 05:41, Lad, Prabhakar wrote:
> > Hi Rob, Krzysztof,
> >
> > On Thu, Sep 29, 2022 at 6:24 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> >>
> >> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>
> >> Hi All,
> >>
> >> This patch series aims to split up the RZ/G2UL SoC DTSI into common parts
> >> so that this can be shared with the RZ/Five SoC.
> >>
> >> Implementation is based on the discussion [0] where I have used option#2.
> >>
> >> The Renesas RZ/G2UL (ARM64) and RZ/Five (RISC-V) have almost the same
> >> identical blocks to avoid duplication a base SoC dtsi (r9a07g043.dtsi) is
> >> created which will be used by the RZ/G2UL (r9a07g043u.dtsi) and RZ/Five
> >> (r9a07g043F.dtsi)
> >>
> >> Sending this as an RFC to get some feedback.
> >>
> >> r9a07g043f.dtsi will look something like below:
> >>
> >> #include <dt-bindings/interrupt-controller/irq.h>
> >>
> >> #define SOC_PERIPHERAL_IRQ_NUMBER(nr)   (nr + 32)
> >> #define SOC_PERIPHERAL_IRQ(nr, na)      SOC_PERIPHERAL_IRQ_NUMBER(nr) na
> >>
> >> #include <arm64/renesas/r9a07g043.dtsi>
> >>
> >> / {
> >>    ...
> >>    ...
> >> };
> >>
> >> Although patch#2 can be merged into patch#1 just wanted to keep them separated
> >> for easier review.
> >>
> >> [0] https://lore.kernel.org/linux-arm-kernel/Yyt8s5+pyoysVNeC@spud/T/
> >>
> >> Cheers,
> >> Prabhakar
> >>
> >> Lad Prabhakar (2):
> >>   arm64: dts: renesas: r9a07g043: Introduce SOC_PERIPHERAL_IRQ() macro
> >>     to specify interrupt property
> >
> > Can either of you please review patch #1.
> >
>
> Why? This is a DTS patch, isn't it? You should CC rather platform
> maintainers, architecture maintainers and SoC folks (the latter you
> missed for sure). You missed them, so please resend.
>
Mainly because we are using the SOC_PERIPHERAL_IRQ() macro while
specifying the interrupts property and just wanted to make sure the DT
maintainers are OK with that.

Sure I'll resend the patches CC'ing ARCH maintainers after v6.1-rc1.

Cheers,
Prabhakar
