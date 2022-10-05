Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041295F5256
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 12:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiJEKPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 06:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiJEKO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 06:14:56 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E93FD06;
        Wed,  5 Oct 2022 03:14:51 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id qn17so1566783ejb.0;
        Wed, 05 Oct 2022 03:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=pXVo7Cs71/tg5/xPQSHIws0jZdPnU8iJoGi0JM0s6PA=;
        b=arPd/QQa9fe/Rw9XyvYa+vZ2+MI8iBZcEmBgqSvclDUSSOCqjMUw8AfpfDOdRZkgwB
         7++563BWRst48OCU8+1Aoqz1dzmgrKYcNVIm21moPiu5O1k/dJQRQr+nIOjFHVZ00X7u
         BqjsgkRpQ3x7yD2qJj4YC7nHi8MPpsy9ykPxjvBV6hxz7YtAdHMhnzV5wu0BUEH1xvR3
         nyGnCAbxnewCBtFjsERZJRJMEdiWbOgNCnHxpS8n3BJUhIS3GKh4D+1K7ULISreAfqnZ
         mpVpr4dNpM3P9TdAcDbYZD/LpXEnCMuYqrmNusywH0Ol+m9G3gpVwstYK3PVWFWEV5Yl
         KcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pXVo7Cs71/tg5/xPQSHIws0jZdPnU8iJoGi0JM0s6PA=;
        b=EhIy41kRFZjZih9yF19M9ovW/Evv8kwlp2in8SDb+hUgWa00s5FF0PQnAjSP45mlg3
         DuqkFxWbozS7WvSLjz7AE4rikhTiH9p5xQg6x6Z/2LTlTnMvt32/4jpOZn6xx6ZCVHh4
         n85mzwsgJiUyCPzuDWHG69SuWknzUx8Oe4K1Q7HOAgrElOCtgLJ/eEBHwBYQgG0hg41E
         5OcSpgiLKjVq4yqYwshKCc4T9FqsY7a7RNOSil/UTNkFDMxisl6oAXesYf8vThqgCsGq
         YKgDx09KA3YKt3R24uaCyjeXrHRdrMrBKxUiryqo0D0/3+Q/48E4lv0XiJEiyNldoC92
         5DcA==
X-Gm-Message-State: ACrzQf0NfG9wqxpIa5duTQ78I09Xbxn38gZxS7Q0UUqumgO48WkYlZXl
        NNIFrTt73D2KZEEZ/3Bcx9WQzeCNvSvbsThqNx4=
X-Google-Smtp-Source: AMsMyM7xXJNCoERdhmhuTM7BqnBPmPnAjrk0xQutO5ohc44YQZYfyQ01mi7FS4e/VFr3sHX7diHSkNtWtFmGwWDXThY=
X-Received: by 2002:a17:906:5a4e:b0:78c:8106:9cc1 with SMTP id
 my14-20020a1709065a4e00b0078c81069cc1mr9072279ejc.196.1664964889317; Wed, 05
 Oct 2022 03:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221003223222.448551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221003223222.448551-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <YzxwoELNBctbhjJb@spud> <e7340230-9a5b-4caf-a7b0-d048cc335994@app.fastmail.com>
In-Reply-To: <e7340230-9a5b-4caf-a7b0-d048cc335994@app.fastmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 5 Oct 2022 11:14:22 +0100
Message-ID: <CA+V-a8uxuMPr+Jwizn13FjGYtnStG7Nw_MCRkdSz6y9HoEeA=Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] soc: renesas: Add L2 cache management for
 RZ/Five SoC
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Conor Dooley <conor@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        guoren <guoren@kernel.org>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Arnd,

On Wed, Oct 5, 2022 at 10:58 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Oct 4, 2022, at 7:42 PM, Conor Dooley wrote:
> > On Mon, Oct 03, 2022 at 11:32:22PM +0100, Prabhakar wrote:
> >>
> >> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >> ---
> >>  arch/riscv/include/asm/cacheflush.h    |   8 +
> >>  arch/riscv/include/asm/errata_list.h   |   2 +
> >>  arch/riscv/include/asm/sbi.h           |   1 +
> >>  arch/riscv/mm/dma-noncoherent.c        |  20 ++
> >
> > Stupid question maybe, but I assume you mixed the driver addition and
> > the changes to arch/riscv for the sake of easily creating the RFC?
> >
> >>  drivers/soc/renesas/Makefile           |   4 +
> >>  drivers/soc/renesas/rzf/Makefile       |   3 +
> >>  drivers/soc/renesas/rzf/ax45mp_cache.c | 365 +++++++++++++++++++++++++
> >>  drivers/soc/renesas/rzf/rzf_sbi.h      |  27 ++
>
> My feeling is that L2 cache behavior should live in arch/riscv
> rather than drivers/soc/, since this is not specific to a SoC
> family but rather the CPU core. I would also expect that the
> actual implementation and DT binding can be shared with
> non-renesas SoCs using the same CPU core.
>
Totally agree it is related to the CPU core and not the SoC. During
the BoF session it was agreed that unratified extensions code shouldnt
go under the arch/riscv. Since the code has vendor specific SBI calls
RISC-V maintainers asked to move it SoC specific so that maintenance
of the code falls under SoC vendors.

Cheers,
Prabhakar
