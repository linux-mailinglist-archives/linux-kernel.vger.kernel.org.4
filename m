Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDE85BA2A5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiIOWSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiIOWSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:18:32 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759DA8C47D;
        Thu, 15 Sep 2022 15:18:31 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id c9so29827021ybf.5;
        Thu, 15 Sep 2022 15:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7rTBa+TZvkiKAMcEE1GZa2Hw9K4HVwTdbY/7JXJfnHE=;
        b=UYAzpgH6jbwevP5kLebZHPqxMQ1b1nKnksij3MYheAodV0Ll6zXsWBtBgWiNvEYXsP
         acVy2vgPBsUTOEkMi2hRfllKSU1jpy58kbDY+COAQUbKr5chRQW47i7cMa2Yg2UUDyCr
         4aC1JVJNdYzjHsFb4xJ7eeKI8Z23zn1Uz1HhxJob6Ap3kElHjMDMJjkjsoABrq2P4pal
         +pNxjeNyd9SU4zSwVvAG12C9bgM+HoOX+IaU/HOc8miy0mJASO52oTZVKtLnrItxhheO
         +xrV86CXjwHwYCmCjSFojngsjRLdkc1hIsiyntmKftI5anSiFv4SoZLC9MQts+ae+Ii0
         SIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7rTBa+TZvkiKAMcEE1GZa2Hw9K4HVwTdbY/7JXJfnHE=;
        b=UpF/KaI7kv5FQjsCoxVKQ4G22IdF3QoH7WsBBTOVhE4nSUJR7N3Ce4FC7UkMe87E4U
         awnJwNoet//EFxhd4QQT/GDkd+HD2uRGiZyvaHtET8cHM2f3wG2AKebI2vUKib+DgUfA
         gX/3rPU3p65l3+rALyuuDVnbcQ6mTkQO2tiFwJo7iQs9jMtKY0cv0jNLU1l1xGPSybtu
         9ULcabaQzFw9AIgrHDfLQBCxP/QKRETaCT5gorQASaBmznPJ5D3J49Y5sbcZjOEUkzFG
         eX8sKDsj54m6EdBs+BPUiAtnaWsDaZ7jmUblLPQKYje6eaPu03LE2AsPCG/z88T33kUK
         m2/A==
X-Gm-Message-State: ACrzQf0uFx8hrfRyaeTIsOkytaL9u1OA4tnJlGUdLb8Pc99kZUbnBfWD
        4yanOG7BK6vUnLXj08Q7VzXHDXtGVMM8WXwUCKQ7q5dJGkR8Eg==
X-Google-Smtp-Source: AMsMyM5qkhFr6mYLitJhEUs5llsOwuL8t3fDB1o5pzCFI52+HRBEiKw3M1v3foGS1UjlkCiHW+bL2UrNZJPYVkiP/M8=
X-Received: by 2002:a05:6902:1007:b0:6ae:6cd5:4b0b with SMTP id
 w7-20020a056902100700b006ae6cd54b0bmr1895083ybt.354.1663280310596; Thu, 15
 Sep 2022 15:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220915181558.354737-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <126c611d-b421-cff9-6384-bc468be7ec73@microchip.com>
In-Reply-To: <126c611d-b421-cff9-6384-bc468be7ec73@microchip.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 15 Sep 2022 23:18:02 +0100
Message-ID: <CA+V-a8sv9sFwGktxqkWohQF2FfxyQm=Z5GVNjPW9i2hKxtNWpg@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] RISC-V: Kconfig.socs: Add Renesas RZ/Five SoC
 kconfig option
To:     Conor.Dooley@microchip.com
Cc:     geert+renesas@glider.be, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, heiko@sntech.de,
        atishp@rivosinc.com, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com
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

Hi Conor,

Thank you for the review.

On Thu, Sep 15, 2022 at 9:59 PM <Conor.Dooley@microchip.com> wrote:
>
> On 15/09/2022 19:15, Prabhakar wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Introduce SOC_RENESAS_RZFIVE config option to enable Renesas RZ/Five
> > (R9A07G043) SoC, along side also add ARCH_RENESAS config option as most
> > of the Renesas drivers depend on this config option.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v2->v3
> > * Included RB tag from Geert
> >
> > v1->v2
> > * No Change
> > ---
> >  arch/riscv/Kconfig.socs | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > index 69774bb362d6..91b7f38b77a8 100644
> > --- a/arch/riscv/Kconfig.socs
> > +++ b/arch/riscv/Kconfig.socs
> > @@ -80,4 +80,18 @@ config SOC_CANAAN_K210_DTB_SOURCE
> >
> >  endif # SOC_CANAAN
> >
> > +config ARCH_RENESAS
> > +       bool
> > +       select GPIOLIB
> > +       select PINCTRL
> > +       select SOC_BUS
>
> Do you really need to select SOC_BUS?
> Noone else does on RISC-V, hence my curiosity.
>
Yes we do need SOC_BUS due to soc_device_register() call in [0].
Digging further I realized we can drop the above SOC_BUS as
SOC_RENESAS is selecting SOC_BUS [1]

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/soc/renesas/renesas-soc.c?h=v6.0-rc5#n487
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/soc/renesas/Kconfig?h=v6.0-rc5#n5

> > +
> > +config SOC_RENESAS_RZFIVE
> > +       bool "Renesas RZ/Five SoC"
> > +       select ARCH_R9A07G043
> > +       select ARCH_RENESAS
> > +       select RESET_CONTROLLER
> > +       help
> > +         This enables support for Renesas RZ/Five SoC.
>
> :thinking: isn't this pretty much what we decided not to do?
> And instead you would redefine ARCH_RENESAS in this file and
> not use SOC_RENESAS* at all? Will save me having to purge the
> the SOC symbol when I do the conversion.
>
I was under the impression we didn't come to a conclusion so kept the
patch as is. I'll just make ARCH_RENESAS visible as Geert suggested
something like below:

        config ARCH_RENESAS
            bool "Renesas RISC-V SoCs"
            select GPIOLIB
            select PINCTRL
            select RESET_CONTROLLER


Cheers,
Prabhakar
