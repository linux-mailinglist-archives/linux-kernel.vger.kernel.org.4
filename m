Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E541620BCC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 10:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbiKHJKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 04:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbiKHJKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:10:07 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47451A047;
        Tue,  8 Nov 2022 01:10:06 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 21so21485716edv.3;
        Tue, 08 Nov 2022 01:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wxg9R63E/LdpcjaJ1QXBZQ2mfpoLnn2CNR5q0txR95Q=;
        b=ogCSi5jgLyz06Qj/c6EJv9UE5I5iKSMxLytwg1lrGusO+4y+j4+AxQscA2mU30i42a
         JIASDnnCHv4STIP+XYOVQvGqZm7L6cWat+SmVGKGiJbMht7ZO33lSuaMyM+yy2s4TWZw
         smqOj19N4qK+Pf3tloAaYEq3NZ/ybhbC9BNxMW7VR2uIzLiOODeIKwGIaQrGoFEMrL1k
         jpKv/Xtx7iEzkApoe0yPfXaQr+B6ExWMiZD0vivjZzLMC4k/UpdQg0mcNU5J3tuZ0nzm
         Cda232w0MQ4cXFptnNwidf4Vsxb39ivcI1B3MIIrGBLa1J8bGKR5q+XR9AxG0VMoa8cZ
         dLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wxg9R63E/LdpcjaJ1QXBZQ2mfpoLnn2CNR5q0txR95Q=;
        b=DA+3K1PPBIgiWTuC4sJuxODGTLrEhuv8piuhRGouCob8FLVhB30gFJW1c+c96F1x9M
         8lMxZTDQTA+nYL0jVl1JXtCvYHt0gcfdoE2jhRfmxf4GcZefgtRJjtez8agoqHHZnSxk
         /Yl3GRq856pF9BhXmESrYnI58D65OcFRaESuJJUpJ1tdQ5RHWBc7YMXCrrm+vlR36ICv
         VuxzKk02o1lOwNw9BF8Qqq+ZOryhcPYpRbA2kjwaML0gezSdeGP1HL4CrwVYtGOvCrw/
         nOMjFB8xzLmf3tAtKSiUE0ZiAJ1AhMhaUOma5LVePRApzGlQ/f332NLEObIxUWM3vvET
         xmNA==
X-Gm-Message-State: ACrzQf36ruLK6+c3e67SsJSm/5UAd8Pd9/rtR97bHAmDcoTMdab6k0Vf
        AZkjbANkyPtX6vaqAHvcTKBtO9xsSGSQPMoV0Gw=
X-Google-Smtp-Source: AMsMyM6T8HbMBQWOPhacutnHoVxAwoc4LO6/Vkb+hKjPKYPLcf66oY+UO8xaFlbDTqs1tDwpCp3vAWrQhbUfzdh3GJs=
X-Received: by 2002:a05:6402:3217:b0:461:d6d7:7f19 with SMTP id
 g23-20020a056402321700b00461d6d77f19mr33389993eda.109.1667898605416; Tue, 08
 Nov 2022 01:10:05 -0800 (PST)
MIME-Version: 1.0
References: <20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221107175305.63975-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <OS0PR01MB592295C7DBA5E0A85B4D26AF863F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB592295C7DBA5E0A85B4D26AF863F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 8 Nov 2022 09:09:39 +0000
Message-ID: <CA+V-a8u6J3+OkANOQYec9-Xe6voAiNTkLo_Zvy6dkC03EYp-4Q@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] pinctrl: renesas: rzg2l: Fix configuring the GPIO
 pins as interrupts
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
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

On Tue, Nov 8, 2022 at 7:14 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Hi Prabhakar,
>
>
> > Subject: [PATCH RFC 2/5] pinctrl: renesas: rzg2l: Fix configuring the GPIO
> > pins as interrupts
> >
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > On the RZ/G2UL SoC we have less number of pins compared to RZ/G2L and also
> > the pin configs are completely different. This patch makes sure we use the
> > appropriate pin configs for each SoC (which is passed as part of the OF
> > data) while configuring the GPIO pin as interrupts instead of using
> > rzg2l_gpio_configs[] for all the SoCs.
> >
>
> Looks like you are missing fixes tag.
> Fixes: db2e5f21a48ed ("pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to handle GPIO interrupt")
>
I did think about but then I realised this fixes the GPIO IRQ
functions only and we didn't support IRQC and GPIO interrupts up until
now so I hadn't added the fixes tag.

Cheers,
Prabhakar
