Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB5F5F54C5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 14:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiJEMyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 08:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiJEMyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 08:54:13 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18EB72FCD;
        Wed,  5 Oct 2022 05:54:12 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g27so5983411edf.11;
        Wed, 05 Oct 2022 05:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=+/BpHNUiX7JadelGxCPFlNmOoEOJtPwIvuyPjnCDWlw=;
        b=e6fMM1BObwqE0wCzwzVi+O9wL9KCw6rpt+K5AX6yF1M3XtoO4odTQWR/BN64rJMnLu
         O+qTNHQH8wGgicBOpPJlk0I2X4fyHJ8K40TB6xXmPWAP77uBxYD5QJusdMe/r8ZBmm+C
         UkaqYh7sbI/hwmtTzZ482u7hK7qz3ZqsQ9SU5vKT9FbwPzuHKVwMII8q2u4o1TDSzHDi
         Xz3j+33pbpb/abtNZy14KFzbpmfsCwOtgAIUOi5z3VQuVmPxBQEJdVqOYiyAm9WPRBXq
         WVc9vhXOcr4vkm+NyMhIdpX+QpCjKKa0U2fLjtSKEQoRT8C53PuERGoAMRKBmDhqp/fH
         rbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+/BpHNUiX7JadelGxCPFlNmOoEOJtPwIvuyPjnCDWlw=;
        b=xylUQ0rvChdRBE6MBZFOmTPHyGurYLxjbVl1eZOzCskXmfkwEH8+NVnOUL+cPxoXJz
         BaL/biCna7MpKye11N3xZ+aDF2kzS1XFZFy7Cm5pia4EEq/0OncMUsxHudfwv0LJ2W4H
         b3oM4tQ4kAadF7zII2xhLIV7IUnPpBGevR7RmOP4vOv28Fp7csS7WigR+W8C0Y3J6GHV
         Y4KWi2hXC+evEwYhwEDYqSdgG3Ffb1k2HU25vKxt3Ri8cdPQk8iC7e9gIHcCJZyPrhu1
         QZOygTqMISt9Tbr3V/l4rMbFm2Rsdwkt82C44sueeZeYE0bAt3X1hQf5RCXaHIBkNHKd
         cUPw==
X-Gm-Message-State: ACrzQf13dWMcHsUbez9ck7PUH2SMN++/kWr5pyFGQe+QJNa0osj0NWlw
        McBa3SCjPdtzxBfAQ9YH5Y+Kmx1drBMvc+GEaWI=
X-Google-Smtp-Source: AMsMyM68FFkOONmspqWdcj7OVMrZtTASnunn2gJ0ZrCK2kwFFJdpz25HPbRCfns2zjcZ8yq0n+iRi5/tOZOg8OBAiIw=
X-Received: by 2002:a05:6402:50d1:b0:452:899e:77c with SMTP id
 h17-20020a05640250d100b00452899e077cmr28041684edb.0.1664974451331; Wed, 05
 Oct 2022 05:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221003223222.448551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221003223222.448551-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAJF2gTQuSX9idEyNmGRwpAsSP8V=+QKQ7UAp28T-seM8rbkwOA@mail.gmail.com>
In-Reply-To: <CAJF2gTQuSX9idEyNmGRwpAsSP8V=+QKQ7UAp28T-seM8rbkwOA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 5 Oct 2022 13:53:44 +0100
Message-ID: <CA+V-a8smkDmQbz76sTA5XfUm7bkY4Ee-L5xYW+-xRWkE1TYiAw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] soc: renesas: Add L2 cache management for
 RZ/Five SoC
To:     Guo Ren <guoren@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
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

Hi Guo,

On Wed, Oct 5, 2022 at 2:29 AM Guo Ren <guoren@kernel.org> wrote:
>
> On Tue, Oct 4, 2022 at 6:32 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> >
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > On the AX45MP core, cache coherency is a specification option so it may
> > not be supported. In this case DMA will fail. As a workaround, firstly we
> > allocate a global dma coherent pool from which DMA allocations are taken
> > and marked as non-cacheable + bufferable using the PMA region as specified
> > in the device tree. Synchronization callbacks are implemented to
> > synchronize when doing DMA transactions.
> >
> > The Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
> > block that allows dynamic adjustment of memory attributes in the runtime.
> > It contains a configurable amount of PMA entries implemented as CSR
> > registers to control the attributes of memory locations in interest.
> >
> > Below are the memory attributes supported:
> > * Device, Non-bufferable
> > * Device, bufferable
> > * Memory, Non-cacheable, Non-bufferable
> > * Memory, Non-cacheable, Bufferable
> > * Memory, Write-back, No-allocate
> > * Memory, Write-back, Read-allocate
> > * Memory, Write-back, Write-allocate
> > * Memory, Write-back, Read and Write-allocate
> Seems Svpbmt's PMA, IO, and NC wouldn't fit your requirements, could
> give a map list of the types of Svpbmt? And give out what you needed,
> but Svpbmt can't.
>
Sorry I didn't get what you meant here, could you please elaborate.

> Here is the Linux dma type to Svpbmt map:
> PMA -> Normal
> IO -> ioremap, pgprot_noncached
> NC -> pgprot_writecombine
>
> How about AX45MP?
>
Svpbmt extension is not supported on AX45MP (reported by
riscv_isa_extension_available())

Cheers,
Prabhakar
