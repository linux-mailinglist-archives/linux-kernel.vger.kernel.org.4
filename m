Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53226E1F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 11:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjDNJJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 05:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjDNJJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 05:09:26 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8855BB9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 02:09:24 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id by8so1901217ybb.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 02:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681463364; x=1684055364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F81GLoXLZtL8vSYDorqAiL9CnEzuuMOCcLiXsP3TrCA=;
        b=pfnBK13xoj6MOIemvnh+e0VZmwkcUJ+TfhPfedGgirQgO5YLUTQmosJzSNe/gHWo/1
         ubKpJ+UjeNxA0eSLk5uTboLOoZ9CVbVps5jQPOuhddVcfEKIRj36V9F6j/Uvfkh+TPpH
         TbQifVNV4ANZnCz2cCmhsbu7MeK1YAI1WPcIgpMyBNuUbh+3rF6x2e5kF/6sSyEanncz
         84fruTtD5nT1/ka61tFRLkbHsJzoaWR7jznJ/7MVP0nShZDKy6/Vq8Fpf9Vled7Z2UhU
         anNFj2syL0/CaF4FpMeFmRw6ZmyAYU8Rq1jnzZZISGDvS81vlH7jZVdZy3oZB7lF9Jbn
         xrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681463364; x=1684055364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F81GLoXLZtL8vSYDorqAiL9CnEzuuMOCcLiXsP3TrCA=;
        b=X1tYBdvw5keirc8vthbzOf0LLwP2l+CbSxFiIF6C/jQrhU5NNHrGrEfb5fr4tNYW2G
         zxPj0z/o/3icGHQ9p5RlaO+SIJGQuhqM5IqdF/+cTPlVsD+y8tsoQ0y5lwPcK6m3iVyE
         iN4dK9DSVMGXtgfAAOSVAiq8LWmZ3CWanDh+7kmQTE2CjgFPq1W2/1LMPnOwsHUAC+Ps
         5z7A8UvWVYdtFzy63M9tp6GHFgZxXhRx+d8mB2d4+mCkwQCfDHUbiGUEkwKVgHJKst3D
         wLrs7o+rtxozQQo/RT1qPZO9546P0PT3OM+yY+8x5Xg3OWU39yQN3ynXCEpcquZm1v3y
         7NXw==
X-Gm-Message-State: AAQBX9eDc/XXhHgi01SAlk6eILosLrGfzbNfHqfNmGHFIQelP4iC3UoT
        RiYiUB7dUjq4nSGJW7r0D4di91iGo0drk/oF2sJKWQ==
X-Google-Smtp-Source: AKy350bIQo/9mA1ytvcDNUEaapfEg+kfYekEH3BIQxSuBh0eEJRichKnj01FOdNlxlgxYYScjklm2+r1l0zhYAyvmps=
X-Received: by 2002:a25:d40a:0:b0:b8f:32c4:5cc4 with SMTP id
 m10-20020a25d40a000000b00b8f32c45cc4mr3383651ybf.4.1681463364094; Fri, 14 Apr
 2023 02:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230403-immutable-irqchips-v1-0-503788a7f6e6@linaro.org>
In-Reply-To: <20230403-immutable-irqchips-v1-0-503788a7f6e6@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Apr 2023 11:09:12 +0200
Message-ID: <CACRpkda8Lp2j_-RWfDb2AppRvkSQ0fdyS56RXS9_OsmeEXqxKg@mail.gmail.com>
Subject: Re: [PATCH 0/9] Convert low hanging pinctrl irqchips to be immutable
To:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 11:43=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:

> This repeats the two-fold exercise in the GPIO subsystem
> by doing the same for pin control: let's switch over all
> easily identifiable irqchips to be immutable.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Linus Walleij (9):
>       pinctrl: iproc: Convert to immutable irq_chip
>       pinctrl: nsp: Convert to immutable irq_chip
>       pinctrl: armada-37xx: Convert to immutable irq_chip
>       pinctrl: npcm7xx: Convert to immutable irq_chip
>       pinctrl: equilibrium: Convert to immutable irq_chip
>       pinctrl: mcp23s08: Convert to immutable irq_chip
>       pinctrl: st: Convert to immutable irq_chip
>       pinctrl: stmfx: Convert to immutable irq_chip
>       pinctrl: sx150x: Convert to immutable irq_chip

No reaction to these patches, so I just merged them.

Yours,
Linus Walleij
