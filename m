Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE1D5BA2E8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiIOWnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiIOWmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:42:49 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012CB82848;
        Thu, 15 Sep 2022 15:42:26 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id y82so29918391yby.6;
        Thu, 15 Sep 2022 15:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=VZkLrzQnH90/ZOn6VC9U1uJcYyUQoQOz40iJvaUx3Xw=;
        b=ALpTpBfZaO6EdxZJ3PRguyDjIOgqUpDGKA9rSQWz84KweFNQ7PB0WIAoO1bHDMVYnT
         cwqGEvu/o0hsiWxTsTlrFUxZLhKFT7ZaOo5cKGLwrRrEylyP29uQtlBJfDn1BO+WFCBz
         B9kxEW9v/rIBNKkoWzzds7giiw4/jY6t8/oC3GDP7WdNDxlJz9Yml6SiSyiGBaSFpJU3
         HktmJd2zML9MdGbjxCPpj0tUKbeNSNHRyThR8sLXu9LtcMeCaJpp+YVD8zgny4O64UIY
         NgEb09+NBp3msOjfzu4rdIoppluNfOX3zWDJNWMMFwsyMGHFfL5lY90g9m8JY1xnwgbB
         oS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=VZkLrzQnH90/ZOn6VC9U1uJcYyUQoQOz40iJvaUx3Xw=;
        b=wn67ma7paUmGkP/5HW9fAl5yx9vVdx+PmDyUNDzTJdsypINPGXt6tytZgJWRltiFef
         He8b4mC/X6DgqCS81o90lbRljzklMz5T/WVLZ74FB5z1ixq4AlkE8/ZR7msEkI19cwuK
         AXTUchIAMpdY/xvvS+VkhIq8FpsnMtPn2cYq46UtP6qMmOIyB7vH7uNZ2kkEqjgbpEF5
         KbPEU7BPpMVtuIUCWvkxIrXZgSR29eDhgkf99nqPNHfc+MMhfn5IU/gYreVxfOLSFVU8
         Kxm8SC6sLAGwX4xgLHs4RgR9tZjliw8gOwXjNedatsrBFCClSueGuYCE51ipSOzV6rPY
         Prkg==
X-Gm-Message-State: ACrzQf1XcW8izqH7T0YAhhWTtF9vmALhdUGZzqOGKQiuRloeMoCKfLBH
        wMPnmXLV8OXn8I4aQH2hHjG5tU0AoiSBHr0w5HA=
X-Google-Smtp-Source: AMsMyM6JRqPOyYQGKlzh/X2UUL4/D8J4GvS5ObaPp+Rfit/kiHbrpelPKbIn/EfXcNYewcJF+fH67RvyKrUCIeddfeI=
X-Received: by 2002:a05:6902:1007:b0:6ae:6cd5:4b0b with SMTP id
 w7-20020a056902100700b006ae6cd54b0bmr1962121ybt.354.1663281745095; Thu, 15
 Sep 2022 15:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220915181558.354737-9-prabhakar.mahadev-lad.rj@bp.renesas.com> <ce1bb9c5-c1e3-b6ff-ec8f-c9ae1f0bf3b4@microchip.com>
In-Reply-To: <ce1bb9c5-c1e3-b6ff-ec8f-c9ae1f0bf3b4@microchip.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 15 Sep 2022 23:41:58 +0100
Message-ID: <CA+V-a8tWaKPNmNjJY6sX1yyUz1V5S7JXP+Eenxo4jOtu7uXXLQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] riscv: dts: renesas: Add minimal DTS for Renesas
 RZ/Five SMARC EVK
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

On Thu, Sep 15, 2022 at 10:56 PM <Conor.Dooley@microchip.com> wrote:
>
> On 15/09/2022 19:15, Prabhakar wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Enable the minimal blocks required for booting the Renesas RZ/Five
> > SMARC EVK with initramfs.
> >
> > Below are the blocks enabled:
> > - CPG
> > - CPU0
> > - DDR (memory regions)
> > - PINCTRL
> > - PLIC
> > - SCIF0
> >
> > Note we have deleted the nodes from the DT for which support needs to be
> > added for RZ/Five SoC and are enabled by RZ/G2UL SMARC EVK SoM/carrier
> > board DTS/I.
>
> idk, I am not sure what to think of this approach.
>
> What do you mean by "for which support needs to be added"? If the support
> does not exist yet, then is surely you can just add the nodes and it will
> be fine?
>
As pointed out previously, I am re-using the below files [1] (SoM) and
[2] (Carrier board) as the RZ/Five SMARC EVK is pin compatible. Since
[1] and [2] enable almost all the peripherals (status = okay)  on the
RZ/G2UL SMARC EVK which are supported. For example [1] enables SDHI0/1
this high speed block needs DMA and without cache management fixed on
Andes core we cannot enable this on RZ/Five SoC so currently a
placeholder is added for it in the RZ/FIve SoC DTSI and is deleted in
the board DTS file.

Below blocks suffer the cache management issue:
- DMAC
- ETH
- SDHI
- USB

Rest of the blocks will be gradually enabled (as soon as this initial
patchset is merged) along with the DT binding doc updates.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi?h=v6.0-rc5
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi?h=v6.0-rc5

Cheers,
Prabhakar
