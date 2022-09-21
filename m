Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447FD5BF82F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiIUHuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiIUHt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:49:59 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C1F4BD33;
        Wed, 21 Sep 2022 00:49:59 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id h28so3459571qka.0;
        Wed, 21 Sep 2022 00:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=YKleuzdmkhtfbEdrDq5PbIw/9ZW5U210A5YEzz/fnok=;
        b=8HGrLnoBaqZpbIO8Qwov4JNT44jkbRiMl+evntahSFYDNHG6ecLkvcfTDnoz1AwTfz
         WsEsggbeG+P3iyhUPCbnWKGqRAC2aTlOf+Ct8ZHTNhJZ8MVDH+vFAJywLk5t70sV77Dg
         5/CpHfdaXkdDzrw59K2IxIPdZg4z+C7xkxHhTfjv/PtAsnQ5EcngnWu6seUB3GWvWikW
         kruyzuv8bm3Gz/qsRJCzyu2sjaBb909ATSAEAnoq1Q51nxfEBRWTv1YV/Iis26KvZYfO
         eiD2jvrpRobsRf7MWOiu+UKNMv11fQc4ZdNzF8+QFQWZd06ExBZWAMLACXI86hRahoaN
         r5pA==
X-Gm-Message-State: ACrzQf3/cdMfw1eG/VzzzK5PTycF4ZYN95YjZnp8M7g28+h1jJWuQGTI
        TJ3NqVrW3D7nelFF5Ox0YYdOgK7Kl2rhdA==
X-Google-Smtp-Source: AMsMyM7AtAsKVnL9Jxy1KyI9u4g8uqj+1+M9TJmbqRqcuiGiiueg1RLjz3ysy/3exuN2JuZnPLlW5g==
X-Received: by 2002:a05:620a:2697:b0:6cf:33cd:2bd2 with SMTP id c23-20020a05620a269700b006cf33cd2bd2mr6397411qkp.341.1663746597903;
        Wed, 21 Sep 2022 00:49:57 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id u2-20020ae9d802000000b006ce407b996asm1378518qkf.69.2022.09.21.00.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 00:49:57 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 125so6815498ybt.12;
        Wed, 21 Sep 2022 00:49:55 -0700 (PDT)
X-Received: by 2002:a5b:506:0:b0:6af:ffac:4459 with SMTP id
 o6-20020a5b0506000000b006afffac4459mr21105286ybp.365.1663746594861; Wed, 21
 Sep 2022 00:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220920184904.90495-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220920184904.90495-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922AFDAFE3DEBBFFF875875864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB59224D591B8A227A5655ECDE864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8s-6FLu-5D44-Szt8eN1V0rhPxm+cO4OrcKmT90O8LoXg@mail.gmail.com> <OS0PR01MB59220E0803C83EC63954340E864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59220E0803C83EC63954340E864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 21 Sep 2022 09:49:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdViUPjWHg0=99HE=GdsuKRTEF37A-OcTf218Kag=sByMg@mail.gmail.com>
Message-ID: <CAMuHMdViUPjWHg0=99HE=GdsuKRTEF37A-OcTf218Kag=sByMg@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] riscv: dts: r9a07g043: Add placeholder nodes
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atishp@rivosinc.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju,

On Wed, Sep 21, 2022 at 7:22 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Subject: Re: [PATCH v4 07/10] riscv: dts: r9a07g043: Add placeholder
> > nodes
> > On Tue, Sep 20, 2022 at 8:26 PM Biju Das <biju.das.jz@bp.renesas.com>
> > wrote:
> > > Just ignore my mail, As I realised IRQ property in each node will be
> > a problem.
> > >
> > Yes the IRQ numbers are different (offset of 32) along with the IRQ
> > parent.
> >
> > Refer this thread [0] where other SoC vendors have similar issues,
> > maybe in future when DTC becomes more clever we can use single SoC
> > DTSI for both.
>
> Not sure, May be the macro suggestion mentioned in that thread will work for us??
> As it is just only the interrupt properties that differ which is
> handled in macro. A Generic macro in common dtsi which is
> expanded in RISCV or arm64 specific dtsi to get proper one??

I brought it up with the DT people in a separate thread[1].
Please continue the discussion there.
Thanks!

[1] https://lore.kernel.org/r/CAMuHMdUPm36RsxHdVwspR3NCAR3C507AyB6R65W42N2gXWq0ag@mail.gmail.com

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
