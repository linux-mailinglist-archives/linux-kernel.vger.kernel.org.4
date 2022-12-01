Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5CB63EB67
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiLAIoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiLAInh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:43:37 -0500
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E41E27B25;
        Thu,  1 Dec 2022 00:43:36 -0800 (PST)
Received: by mail-qv1-f48.google.com with SMTP id p12so870534qvu.5;
        Thu, 01 Dec 2022 00:43:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBR3BOXoBY5WpTgUL6g8XKshM6R6PFszC3zTZx0qYOk=;
        b=Yey7wguLTV5zTHb/u4y/vUTNhDqoi1MT3TaAPdsjjesk7Wq5l5Y7NniJQmVG/MwA9Z
         7h1d9ANtRo+MiCW69n4P9cj/eAzR6YzmeA2lexWgUZywytv4PS6HYS4osDOc4VRiJWBY
         oE6BF/f0rEnXwgozZS5cJyTcSE575RirE83GRxQCwqVjdHKjrkPNzmYNHJJpwRG6lREa
         Z8DZ7fbExNulSEjpdhc070TmWJ+TkGLv82dTz/V427RM7q4ye+cvM4If4I1Rn40AfcnJ
         Dh5wVeZ4wuJuqjoxNwsdQeIWOYGwP5qV+rrMvcju8AvAv3pYzmV7Xxr2BfggZEBL713E
         WT7A==
X-Gm-Message-State: ANoB5pmQY6Hk4JEqeU8dBJT5a6i6Le0Woy2hV0R0zA8TX6i+odTvxfea
        /8QJ+XOyulHAtBRC8QEmTDYZ2qVQDbhslQ==
X-Google-Smtp-Source: AA0mqf5Naw2OgCcZtLRJDNbbj4Klr+ZnFFeuAoFbyIt2ou0dI8YSMpdTEgjibjrVn8LXBSF50oxQDA==
X-Received: by 2002:a0c:e60b:0:b0:4c7:934:f598 with SMTP id z11-20020a0ce60b000000b004c70934f598mr12743139qvm.129.1669884214977;
        Thu, 01 Dec 2022 00:43:34 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id c11-20020ac8660b000000b003a586888a20sm984881qtp.79.2022.12.01.00.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 00:43:34 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id o127so1145831yba.5;
        Thu, 01 Dec 2022 00:43:33 -0800 (PST)
X-Received: by 2002:a25:d655:0:b0:6fc:1c96:c9fe with SMTP id
 n82-20020a25d655000000b006fc1c96c9femr1037423ybg.36.1669884213221; Thu, 01
 Dec 2022 00:43:33 -0800 (PST)
MIME-Version: 1.0
References: <20221118135715.14410-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221118135715.14410-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 1 Dec 2022 09:43:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVWpya10MbGceexKNd+eJnTamcYWPbkxwxOCZZNthu6Xg@mail.gmail.com>
Message-ID: <CAMuHMdVWpya10MbGceexKNd+eJnTamcYWPbkxwxOCZZNthu6Xg@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: renesas: rzfive-smarc-som: Enable WDT
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
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

On Fri, Nov 18, 2022 at 3:00 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Enable WDT node on RZ/Five SMARC SoM.
>
> Note, WDT block is enabled in RZ/G2UL SMARC SoM DTSI [0] hence deleting
> the disabled node from RZ/Five SMARC SoM DTSI enables it here too as we
> include [0] in RZ/Five SMARC SoM DTSI.
>
> [0] arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
