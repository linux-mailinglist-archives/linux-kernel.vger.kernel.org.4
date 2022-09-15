Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9C65BA301
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiIOWv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiIOWvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:51:55 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413D15301C;
        Thu, 15 Sep 2022 15:51:54 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id c9so29920745ybf.5;
        Thu, 15 Sep 2022 15:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=o1EVXmyOGUfFQkox8g7eU5ep5qYnL2D0Sb1HeWjL6OI=;
        b=CmEDtGhYhc+kSiKpnXWIzm1IaPnUZh0/4urfe+lEcZBnQO8ynI9TceiVqOUvUmzQda
         OQ4FTVbHwsz1dNV9fNIaZdVwUajnWpUnTW/uAAONievZjeYZyT/65z/OtGUe/yyTKoxU
         UfUxHdctbG8/tZL7pWiZjLS5gZwhMoZcyooqGxn16AO7w0sjfXZzlKCiGDBH1epIDbsF
         JKehjj10NX0KgdxS9k5J+dGnPY95YwvDewuoc+vtK9UW3/0XuWx5UeYM54dHTRy5RrRb
         2stDthatvNV2TYzS1sYlclkII9xrg+gQzw8Q5+aVpYgVSwpeRCwwGPfJxEoDqSD5NEW+
         2yGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=o1EVXmyOGUfFQkox8g7eU5ep5qYnL2D0Sb1HeWjL6OI=;
        b=1FyhDjwqhp59fFCjER4gtmlIx145g9PLKKrtfJQs0i+J4gB0ckTL0QettDw+WuzlMk
         MXN/MkNkjEhJTyKEBNc+Xtwcy+R/UB/b637qjBEikGoYX0iX54Ydn1SI08SvWeilKiJz
         m5/KghbwDUf4/1uQA4eQPv16TJb5hmGoT787T4eXzpy5SqhLlHZBZ5sxW7FlfalkQP0U
         rne+NStuGiQg59JV/YCc9HnGO+Ez+0tuaehRXr8o0mFuogHvnod+1SqDGbQ4MN4NOilP
         2G7x/O7cw+J/rf1/RIfZ3ttlO7WNVTuNGt36nP7HnJFEsaQkrO54sEhjkSRQ3DizcONF
         IOIg==
X-Gm-Message-State: ACrzQf16W6kx2rcRN3CWPyQK/pujNOhNULpbiUZkxqhTPxLDznvvAEcC
        q5mQ/3PHPl1Uc7hdURT88elZa2SLWVgoMI5FdRk=
X-Google-Smtp-Source: AMsMyM6fMB5rSpVPOQBw4/ro/bIVfsiOS1VtXuR20b64oyEoe9sQv/Tfxv1POcyhHFztI/g3eCFqxVV0iHYOCWc9leI=
X-Received: by 2002:a25:3c45:0:b0:6af:f2b8:e15e with SMTP id
 j66-20020a253c45000000b006aff2b8e15emr1997729yba.299.1663282313489; Thu, 15
 Sep 2022 15:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220915181558.354737-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ce1bb9c5-c1e3-b6ff-ec8f-c9ae1f0bf3b4@microchip.com> <CA+V-a8tWaKPNmNjJY6sX1yyUz1V5S7JXP+Eenxo4jOtu7uXXLQ@mail.gmail.com>
 <cdd42171-872c-cb6d-e540-240b233b74fc@microchip.com>
In-Reply-To: <cdd42171-872c-cb6d-e540-240b233b74fc@microchip.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 15 Sep 2022 23:51:26 +0100
Message-ID: <CA+V-a8thCFB1OBeVBecCEHw2ZVcKQRq4Pe850BVHU23uESBjtA@mail.gmail.com>
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

On Thu, Sep 15, 2022 at 11:44 PM <Conor.Dooley@microchip.com> wrote:
>
>
>
> On 15/09/2022 23:41, Lad, Prabhakar wrote:
> > Hi Conor,
> >
> > Thank you for the review.
> >
> > On Thu, Sep 15, 2022 at 10:56 PM <Conor.Dooley@microchip.com> wrote:
> >>
> >> On 15/09/2022 19:15, Prabhakar wrote:
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>
> >>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>>
> >>> Enable the minimal blocks required for booting the Renesas RZ/Five
> >>> SMARC EVK with initramfs.
> >>>
> >>> Below are the blocks enabled:
> >>> - CPG
> >>> - CPU0
> >>> - DDR (memory regions)
> >>> - PINCTRL
> >>> - PLIC
> >>> - SCIF0
> >>>
> >>> Note we have deleted the nodes from the DT for which support needs to be
> >>> added for RZ/Five SoC and are enabled by RZ/G2UL SMARC EVK SoM/carrier
> >>> board DTS/I.
> >>
> >> idk, I am not sure what to think of this approach.
> >>
> >> What do you mean by "for which support needs to be added"? If the support
> >> does not exist yet, then is surely you can just add the nodes and it will
> >> be fine?
> >>
> > As pointed out previously, I am re-using the below files [1] (SoM) and
> > [2] (Carrier board) as the RZ/Five SMARC EVK is pin compatible. Since
> > [1] and [2] enable almost all the peripherals (status = okay)  on the
> > RZ/G2UL SMARC EVK which are supported. For example [1] enables SDHI0/1
> > this high speed block needs DMA and without cache management fixed on
> > Andes core we cannot enable this on RZ/Five SoC so currently a
> > placeholder is added for it in the RZ/FIve SoC DTSI and is deleted in
> > the board DTS file.
> >
> > Below blocks suffer the cache management issue:
> > - DMAC
> > - ETH
> > - SDHI
> > - USB
> >
> > Rest of the blocks will be gradually enabled (as soon as this initial
> > patchset is merged) along with the DT binding doc updates.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi?h=v6.0-rc5
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi?h=v6.0-rc5
>
>
> Explanations are reasonable, but again - that information is important
> and really needs to be included in the commit message etc.
>
Sure, I will update the commit message while sending the v4.

Cheers,
Prabhakar
