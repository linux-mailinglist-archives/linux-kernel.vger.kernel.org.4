Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD76B6B3ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjCJMKn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Mar 2023 07:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjCJMKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:10:22 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7A3FCBDC;
        Fri, 10 Mar 2023 04:09:12 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id s12so5306959qtq.11;
        Fri, 10 Mar 2023 04:09:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678450151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osXtcLpzII8HMhQvnw8NYQ8r9e4scUgeSo4VdhXXuHE=;
        b=5dEtkieSX9+kHCz8QaMU9V8XUJZ/s19MsauE4JHCZpAu2g1HywkZveQ0xWXuUVnM97
         wYDQ2Q2e/AJlRz+brJDYr0CrPvYEnoUUhTdLzPvvt8UVVJ32+Vmcsdv0VTn616QgdZp4
         TDKFweE64593eW7rO5w5nH3GiDYOyPdBI/x7gIEslwM5RS3UPLHYonseAra6c0CBbOGg
         mR+StBSCJg/736OJ1AqZjsoGURbzm22BKYS2mYfP5F5Ex9ylnWSXSy+4ZaZ3GhaiyaGM
         ZdxGD1dUI6YU8HmqtFlQbhFHQvtuLHhMj76ZtUj6uEbGTSzbBijb0Pv6EhbwVqoon1+K
         nAnw==
X-Gm-Message-State: AO0yUKUYq9lhs/0sNAKqLp+A1Pkp34pYCQXqtcD/fYVBzSu+tfvZ+HeZ
        0Tp3opag1sDjwCM9oq1pHQvV/I7S/b9slA==
X-Google-Smtp-Source: AK7set934mArPxO5dbqovGMYLgSAAPJIfOG8DTjMSXBlIWDrgXtKI/SoxXM+uHqZZ5IbmVEn2arOng==
X-Received: by 2002:ac8:5715:0:b0:3b9:bc8c:c1f8 with SMTP id 21-20020ac85715000000b003b9bc8cc1f8mr2589875qtw.3.1678450150861;
        Fri, 10 Mar 2023 04:09:10 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id i6-20020a378606000000b00741b312c899sm1234512qkd.6.2023.03.10.04.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 04:09:10 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-53d277c1834so93230327b3.10;
        Fri, 10 Mar 2023 04:09:09 -0800 (PST)
X-Received: by 2002:a81:ae4a:0:b0:52e:b7cf:4cd1 with SMTP id
 g10-20020a81ae4a000000b0052eb7cf4cd1mr16210644ywk.5.1678450149576; Fri, 10
 Mar 2023 04:09:09 -0800 (PST)
MIME-Version: 1.0
References: <20230217185225.43310-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230217185225.43310-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230217185225.43310-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 Mar 2023 13:08:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXDJe7pSM8buhwRkYF-DXy4C9NnxbgTWefhRwOXFs0DAA@mail.gmail.com>
Message-ID: <CAMuHMdXDJe7pSM8buhwRkYF-DXy4C9NnxbgTWefhRwOXFs0DAA@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: renesas: r9a07g043: Update IRQ numbers
 for SSI channels
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 7:54 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> From R01UH0968EJ0100 Rev.1.00 HW manual the interrupt numbers for SSI
> channels have been updated,
>
> SPI 329 - SSIF0 is now marked as reserved
> SPI 333 - SSIF1 is now marked as reserved
> SPI 335 - SSIF2 is now marked as reserved
> SPI 336 - SSIF2 is now marked as reserved
> SPI 341 - SSIF3 is now marked as reserved
>
> This patch drops the above IRQs from SoC DTSI.
>
> Fixes: 559f2b0708c70 ("arm64: dts: renesas: r9a07g043: Add SSI{1,2,3} nodes and fillup the SSI0 stub node")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.4.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
