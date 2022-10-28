Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46647610FE3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 13:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiJ1LlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 07:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiJ1LlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 07:41:19 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D2B61D80;
        Fri, 28 Oct 2022 04:41:18 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k2so12339368ejr.2;
        Fri, 28 Oct 2022 04:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5y5A9pG1/H0U+8RgwnxHXSQw6+Rfn/giVW1kToYs3Y=;
        b=Csf6zZS0/kCTQiC1yhxCCUQQrGy4No9ZwiINBJnWGpQCa2tG0KVfBIdKNllX+F85uz
         vzZ5VFkfvUdJkGdJriHLfOY89Q4WOKODXwTdZVhsOdwWOQ+OJbnxRF1k2g65xQJlQb6L
         ImdBaFL8609ImsALNyovHlAtjGeyD0t3h/YpavNYYIEmP5CfZ1sLdWiSYnIQSI9+iVUJ
         slLwnX6Ycwasc/zYFb4nlwfdF31S99ZisgeiZHMr7PhDejYZ182nBfMGMp1FybyegHzJ
         CP9i85gdja1QLPowrSviaFSJWu8xRm3aL3PjboYiuFpnoWVEjDs09zff16/mOj+H//ec
         R+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y5y5A9pG1/H0U+8RgwnxHXSQw6+Rfn/giVW1kToYs3Y=;
        b=ZknsGsU82EOePBOam0v6qqzVIU+hJnSDaFKIpK3PRmrTnzhW0rnx32DN6NRJdHvKa4
         2Lxxm6D0IjX744Cf1H9VErRTqqDt2lTXJH0er6iI2+Sx2YreRf8q6bixjyzX4N1IKMVK
         NG9lCoCLpfWZXNQs8JL5fAn5/cXOEPIOdVoWJjPYtWvqa9PR/sag1b3XTdlNH7lbX7LJ
         2osiFQW1akZ8p7+pl4SPJELQd6MfMFWxLif7GM6JDNp42QEI2eo4RA4RmFdHNOy2q0ZB
         GOCBNrADLtgf+O4ldQd2FDhFrS8ow2FOp9oDiLHiWVmI3r6ppIqqN/GZlAr04kfzrZhm
         dpyQ==
X-Gm-Message-State: ACrzQf294nvJLllwbqcM0U7vKyiG0SpORas9DyQkkHPAD8rlzpsjQ2us
        +qO0gIQuUANWiN/z3Nwjyo5pZPoACJCiWEPp2p+YAFWdFfI=
X-Google-Smtp-Source: AMsMyM7k7NlrLg2TkNTq5MWbYtY7EI7PuCwUCR7FFMsv2VcliAPc0Yg89vfXdfHM4lu0CUxKH39lgb2/kVF9LDK8Kqk=
X-Received: by 2002:a17:907:847:b0:77f:f489:cc25 with SMTP id
 ww7-20020a170907084700b0077ff489cc25mr46178042ejb.80.1666957277120; Fri, 28
 Oct 2022 04:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221025220629.79321-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221025220629.79321-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXw0DTAXFjqutP4X2E3gzkBQ579tHPfjtLC2X0j3R-+Lw@mail.gmail.com>
In-Reply-To: <CAMuHMdXw0DTAXFjqutP4X2E3gzkBQ579tHPfjtLC2X0j3R-+Lw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 28 Oct 2022 12:40:50 +0100
Message-ID: <CA+V-a8v2RkNSuVxVsoYhS3c-xJ7bJAm+ApaDCoK6oBzTx5gsnA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: renesas: r9a07g043: Split out RZ/G2UL
 SoC specific parts
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Fri, Oct 28, 2022 at 12:35 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Wed, Oct 26, 2022 at 12:06 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Move RZ/G2UL SoC specific parts to r9a07g043u.dtsi so that r9a07g043.dtsi
> > can be shared with RZ/Five (RISC-V SoC).
> >
> > Below are the changes due to which SoC specific parts are moved to
> > r9a07g043u.dtsi:
> > - RZ/G2UL has Cortex-A55 (ARM64) whereas the RZ/Five has AX45MP (RISC-V)
> > - RZ/G2UL has GICv3 as interrupt controller whereas the RZ/Five has PLIC
> > - RZ/G2UL has interrupts for SYSC block whereas interrupts are missing
> >   for SYSC block on RZ/Five
> > - RZ/G2UL has armv8-timer whereas the RZ/Five has riscv-timer
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v6.2.
>
> > ---
> > RFC->v2
> > * Updated commit message about timer
>
> Right. And I'll add while applying:
>
>   - RZ/G2UL has PSCI whereas RZ/Five have OpenSBI
>
That makes sense, thanks.

Cheers,
Prabhakar
