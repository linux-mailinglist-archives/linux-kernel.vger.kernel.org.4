Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF5C610BE4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 10:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJ1IJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 04:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiJ1IIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 04:08:45 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ABE1C25EA;
        Fri, 28 Oct 2022 01:08:18 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id 8so2968485qka.1;
        Fri, 28 Oct 2022 01:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHNjVYF81lO8OdfUhIpcIslc6s39L/2If9j6fPR0Er0=;
        b=DaXVOfTDdDMadaF/ZK7laxnQM2sKapmMQBI3nA9o0DyCYM1ICZWtCR2h9eaabPBFFb
         r1jbWfFvrwNdJyhxZnDeU3lfJObA6TWBE2d6bmSwJg2RgpnS/nCNbhuze5W6KdXH8rRT
         3drG9z7GXdauwWQg7NH9XAZGF928qHnh9CJWpnpjLLhBSKjqpB+ktj6AJOSxlOz/BEDU
         LdwWrHMEJa2n8dPIknpQnBj8J4Dd2w2YqCynAjGGHfmphJ36UoG1qz7E44Un7NZag2Ra
         TN0o5/PSmxA8KaTixVwdQ3mn9Tgopz4gAW6m8Vne8NhmbsnuJdLmAgaoXGCE+YhWTngB
         Wsbw==
X-Gm-Message-State: ACrzQf0A1Xt+WjGVrqfhE96FbcgkbJEwE332xrRPvsSWxqEzljNZdUto
        GCeu8ZhdPRfPywmWxgu4qE1kVGI8OLrtyw==
X-Google-Smtp-Source: AMsMyM6B0Zvhg/3+hQiDA3wN3OAOrnjzoRDzVHipo91MlSZS09ZzX3SqXO3Jo85RLavSa6unJgESBQ==
X-Received: by 2002:a05:620a:288b:b0:6b6:4f9b:85c6 with SMTP id j11-20020a05620a288b00b006b64f9b85c6mr37384383qkp.614.1666944486405;
        Fri, 28 Oct 2022 01:08:06 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id n16-20020ac85a10000000b0039cc82a319asm2050152qta.76.2022.10.28.01.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 01:08:06 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-3321c2a8d4cso40718317b3.5;
        Fri, 28 Oct 2022 01:08:06 -0700 (PDT)
X-Received: by 2002:a81:3d2:0:b0:36b:6772:75a3 with SMTP id
 201-20020a8103d2000000b0036b677275a3mr29098444ywd.383.1666944485753; Fri, 28
 Oct 2022 01:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221027112459.77413-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221027112459.77413-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 28 Oct 2022 10:07:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX0Nmi1_UY6xJa5Keje5WJt4grnTeUDnhhy_HPa-7EpOw@mail.gmail.com>
Message-ID: <CAMuHMdX0Nmi1_UY6xJa5Keje5WJt4grnTeUDnhhy_HPa-7EpOw@mail.gmail.com>
Subject: Re: [PATCH] arm64: renesas: Drop selecting GPIOLIB and PINCTRL
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 1:25 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Don't automatically select the GPIOLIB and PINCTRL config options as we
> already have automatically selected it as part of the SOC_RENESAS config
> option [0].
>
> [0] drivers/soc/renesas/Kconfig
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.2.

Note to self: beware dependencies, as commit b3acbca3c80e6124 ("soc:
renesas: Kconfig: Explicitly select GPIOLIB and PINCTRL config under
SOC_RENESAS") is queued in a different branch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
