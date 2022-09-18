Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEAA5BBCA3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 11:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiIRJEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 05:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiIRJEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 05:04:47 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D7D14D32;
        Sun, 18 Sep 2022 02:04:44 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id i15so19875682qvp.5;
        Sun, 18 Sep 2022 02:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9HmDwTA+Ka4IaCuWDPqivTWZiZTApC1d/LLCMUMnlps=;
        b=PtoD9Ee6oaPlFx9GDCF20opk89Z/wCKlqKLcnpC3xOtCB9XLhLU7E0C0oTcWyUm9ng
         o27FYsKrqVW5rkgp0oxDY69J+V6sVSCCO5zCQ1uASmbCVklDsujlrYeD2Q+iZ0l7xza6
         sgZB/PrfgbE+nERPbagoTkChhZzQJXkIY2OT8xxE0EgGl6m7Ppy2F8N8oZ/QEuda5BLN
         5LIzzE4pj4gWNsEj5Jv4m4+fj2iIebOzEHmsw4qjNSLZ+CSHWmHrMRIWd7Cew+8tRTnz
         3atwf+LkbZZjSVFfBUx0opBkp9ETX01aaQHKOw77dn/bu8UpUWkdaGEFjkN3u9nqGHA4
         X+ng==
X-Gm-Message-State: ACrzQf2D/jkDNcBPf4tqPmz6yB07H5Tf5hlq88vDCrixuA4rc7uGQyvi
        NxI7K/Wbhh87Cj5VdaxkekUZC5b+eF7RzA==
X-Google-Smtp-Source: AMsMyM7j8NVk9Y8j94VUu6wZEdZoEcKHYCEM/bmzb/OsbI656ZtLYj41BjeRSEUksxBtUSyQYvlPbg==
X-Received: by 2002:ad4:5f47:0:b0:4ac:b8de:1484 with SMTP id p7-20020ad45f47000000b004acb8de1484mr10440905qvg.77.1663491883347;
        Sun, 18 Sep 2022 02:04:43 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a254b00b006cbd92ca141sm10348969qko.133.2022.09.18.02.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 02:04:42 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-3454e58fe53so308392857b3.2;
        Sun, 18 Sep 2022 02:04:42 -0700 (PDT)
X-Received: by 2002:a81:758a:0:b0:345:450b:6668 with SMTP id
 q132-20020a81758a000000b00345450b6668mr10195037ywc.316.1663491882463; Sun, 18
 Sep 2022 02:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220914134211.199631-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220914134211.199631-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 18 Sep 2022 11:04:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVRmuQm5xRgpQurCJTu7goqNi5zj+Q9cLLz_s_p=znbbA@mail.gmail.com>
Message-ID: <CAMuHMdVRmuQm5xRgpQurCJTu7goqNi5zj+Q9cLLz_s_p=znbbA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: rzg2ul-smarc-som: Drop enabling wdt2
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 3:43 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> WDT CH2 is specifically to check the operation of Cortex-M33 CPU so
> don't enable WDT2 by default.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.1.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
