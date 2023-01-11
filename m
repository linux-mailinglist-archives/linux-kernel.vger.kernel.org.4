Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461C96660DD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjAKQm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbjAKQmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:42:32 -0500
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01647CE0B;
        Wed, 11 Jan 2023 08:41:46 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-4d19b2686a9so75069857b3.6;
        Wed, 11 Jan 2023 08:41:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zptl82ttrhrV63pMTO0viIa9cKU9Map9hB06vVk8Wqo=;
        b=2W24tW4ZOys7/S3b5X4RgxaWvzroJkwclGHRT19DrtaeEToFJPhT0kVFOwt2+QYKuh
         EzvL+0Xc4cpNclWkXLv5Azn7fjw89hHazT5U9p0t0zGgw8FCEc/7FATOWcFUsI5gKOd/
         lunoahT/CT7UD3BXVP6WOTKIRvtbIKPRnoeibD3bZtDQxlQkB6cMfL//7r17pbAOwnyB
         ntQukFImLqC+qVBKa/6Sfn/exSvlYEsBlI200pFA8kR9rVYNe0PKHCR1OOFY++c0Ckhi
         W3cEetqIPgzYAPwHlHoZS1PZKL0tfBn3GNs0rKxOk4H4F6qfFGiGUnbNpHGT5LYwsc8G
         Uxgw==
X-Gm-Message-State: AFqh2krcAhpQh+cNFYoLTK7r5nOnZGE6M7iEbvZUlSkGbDo5FbGeIPu5
        lpSwaNDe4HmSTfiO4TWhSpr6XgQHddzvUA==
X-Google-Smtp-Source: AMrXdXv51sHXafLWUndB9GkOMJxfIsj8bY4lK6Nov3GUZRCvhiyFFELSXAaJsCB+l5NLjwsMEfTD2g==
X-Received: by 2002:a81:190a:0:b0:364:1ba6:7e6 with SMTP id 10-20020a81190a000000b003641ba607e6mr19485322ywz.37.1673455304695;
        Wed, 11 Jan 2023 08:41:44 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id 64-20020a370c43000000b006cfc1d827cbsm9115697qkm.9.2023.01.11.08.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 08:41:44 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-4d0f843c417so88646397b3.7;
        Wed, 11 Jan 2023 08:41:43 -0800 (PST)
X-Received: by 2002:a81:1751:0:b0:4bd:caff:589e with SMTP id
 78-20020a811751000000b004bdcaff589emr2155587ywx.502.1673455303487; Wed, 11
 Jan 2023 08:41:43 -0800 (PST)
MIME-Version: 1.0
References: <20230102222233.274021-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230102222233.274021-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 11 Jan 2023 17:41:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXVPdWb2GGSOoVSLNNE6k-JpKnqMGXwpJH=HaGz94GHQQ@mail.gmail.com>
Message-ID: <CAMuHMdXVPdWb2GGSOoVSLNNE6k-JpKnqMGXwpJH=HaGz94GHQQ@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: dts: renesas: rzfive-smarc-som: Enable OSTM nodes
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
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

On Mon, Jan 2, 2023 at 11:22 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Enable OSTM{1,2} nodes on RZ/Five SMARC SoM.
>
> Note, OSTM{1,2} nodes are enabled in the RZ/G2UL SMARC SoM DTSI [0] hence
> deleting the disabled nodes from RZ/Five SMARC SoM DTSI enables it here
> too as we include [0] in RZ/Five SMARC SoM DTSI.
>
> [0] arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> * Rebased patch on top of [0]
>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git/log/?h=renesas-riscv-dt-for-v6.3

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
