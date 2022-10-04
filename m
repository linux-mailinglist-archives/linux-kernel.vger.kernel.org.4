Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512D55F3F3C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiJDJMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiJDJMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:12:48 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D7D2B621;
        Tue,  4 Oct 2022 02:12:47 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id ay9so7795376qtb.0;
        Tue, 04 Oct 2022 02:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=cNSxtiNrKbDPv0gefLyvvkj1SY75gKEiYHU4erA9wgQ=;
        b=OpUeCWbE4tJutZnh7A7Z4tuDhMsvRgF+yvdqCcJuXwTghECpLX09gwLRAC77QgRqt7
         g00ipEQ00aiUOOeNm2TPR/bmAbTwFqBU6U19kluARFN1f9S2uy4X/d5hu/r6/4Sg+Ur2
         854rG47iqf2M5yhx0+e4Ji2S4XtIpFLMzklKfgsN+RU4calRTfORAOw2Phvg00oxZbST
         vkZkllxZXd96rjx18/DA4igoM0ViY9ZaxR6+ERrWM6QtdsMlX9IEWqQHd2xj1d19rn0J
         9GzT4Dy2k4sFqoPkud77csqgp/BD73cicrhHm+mut4OFKf6YS0dbt4C93yhP64IuCrK3
         aVRQ==
X-Gm-Message-State: ACrzQf2XvZtuh7E6MEpFIe7U6zO2Ar4yocQj0owNjBLGN3pN+cj6JWVH
        Yj4HB5+X2J2Pk7ul/yBiPnaIDAUAuu330Q==
X-Google-Smtp-Source: AMsMyM63hZ7lhcgCRxqxOpIAZJyGjahUgX5uNglN+uyFdp/P+hqExAhsbUIt4TzFTLVcEHsAcbI5ew==
X-Received: by 2002:ac8:5716:0:b0:35c:bd68:d34 with SMTP id 22-20020ac85716000000b0035cbd680d34mr18400784qtw.50.1664874765962;
        Tue, 04 Oct 2022 02:12:45 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id r13-20020ae9d60d000000b006bb2cd2f6d1sm13472318qkk.127.2022.10.04.02.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 02:12:45 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 63so16074961ybq.4;
        Tue, 04 Oct 2022 02:12:45 -0700 (PDT)
X-Received: by 2002:a5b:104:0:b0:6b0:429:3fe9 with SMTP id 4-20020a5b0104000000b006b004293fe9mr24038304ybx.543.1664874764897;
 Tue, 04 Oct 2022 02:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221003223222.448551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221003223222.448551-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdX1BuvHz46QWd+ajEcwmWMeSmvN4AtODuFEysRk14ArZQ@mail.gmail.com>
 <CA+V-a8vnNQDMgjhJfz91g++dVVv5Z5FTuFrNRHLW3PjPump0Mg@mail.gmail.com>
 <YzvhaxuZbeCwLZ5m@wendy> <CA+V-a8uYwm+Z4=3beNZE7q3mG7S3uKdEagY2c-KStD0thyw6Gw@mail.gmail.com>
In-Reply-To: <CA+V-a8uYwm+Z4=3beNZE7q3mG7S3uKdEagY2c-KStD0thyw6Gw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Oct 2022 11:12:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXqV3DMLLfS5Vrkmx1KOBHqyC_pO7kHLnMf8OPSFe6doA@mail.gmail.com>
Message-ID: <CAMuHMdXqV3DMLLfS5Vrkmx1KOBHqyC_pO7kHLnMf8OPSFe6doA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] dt-bindings: soc: renesas: r9a07g043f-l2-cache:
 Add DT binding documentation for L2 cache controller
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
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
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Prabhakar,

On Tue, Oct 4, 2022 at 9:59 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Tue, Oct 4, 2022 at 8:32 AM Conor Dooley <conor.dooley@microchip.com> wrote:
> > On Tue, Oct 04, 2022 at 08:26:01AM +0100, Lad, Prabhakar wrote:
> > > On Tue, Oct 4, 2022 at 7:42 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Tue, Oct 4, 2022 at 12:32 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > >
> > > > > Add DT binding documentation for L2 cache controller found on RZ/Five SoC.
> > > > >
> > > > > The Renesas RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP
> > > > > Single) from Andes. The AX45MP core has an L2 cache controller, this patch
> > > > > describes the L2 cache block.
> > > > >
> > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Thanks for your patch!
> > > >
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/soc/renesas/r9a07g043f-l2-cache.yaml
> > > >
> > > > Not andestech,ax45mp-cache.yaml?
> > > >
> > > I wasn't sure as we were including this in soc/renesas so named it as
> > > r9a07g043f-l2-cache.yaml if there are no issues I'll rename it
> > > andestech,ax45mp-cache.yaml.
> >
> > I may be guilty of suggesting soc/renesas in the first place, but should
> > this maybe be in soc/andestech? I have no skin in the game, so at the
> > end of the day it doesnt matter to me, but I would imagine that you're
> > not going to be the only users of this l2 cache? Or is it a case of "we
> > will deal with future users when said future users arrive"? But either
> > way, naming it after the less specific compatible makes more sense to
> > me.
> >
> As there aren't any Andestech SoCs upstream, I am in favour of keeping
> in soc/renesas for maintenance. If in future there comes a new soc
> from Andestech (which will go into soc/andestech) we will have to
> split the maintenance work.
> But anyway if there will be any users of L2 cache we could always
> provide a config option which can be used by other SoCs.

What about Documentation/devicetree/bindings/cache/?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
