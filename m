Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391C867C633
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbjAZIvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbjAZIvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:51:00 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4F32194B;
        Thu, 26 Jan 2023 00:50:58 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id x5so772565qti.3;
        Thu, 26 Jan 2023 00:50:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8Yo/HtiEGSzYrRQZv+JkTOd1mtgjj1wSt54yjMvxXA=;
        b=SZROYySYLQ79ARWLyy+D72ao69fKTTKeJB5Fm5QpQrttbUc9gkNnu7c9oeXh31hjSi
         K1DvmeThZU1l4vZQz3HLLHl5EnjwdWRH1f2ZRDy9tqCYz8+Tl3Y9KJqRw/220MUjyuSk
         OffYHePolouldghJSp4/APH7kU0wW1wuNymBU38wB9VLMBcfXl+adUwReOqXJ43StPdR
         LebN6Pou+r+UYa8cFxDiEwYkRpgmDYyzUS02eWzqSQm/bG5nkUctypy6YF/uA3JvfcQO
         3J59S8Qj+oXJ95d2jnQHvj8D/U24czvDVrIy5Gxs1bNOh4uatT21At9nEkKae8gPwU7g
         g7eQ==
X-Gm-Message-State: AFqh2kotavUKSE/i0kdHggKWJhgb2vnnJ3IsNF4mT9v8n2IBmHKjy9ke
        cH5Nc/RKlrBWA0t8fphYmDiWuHoGYsto2w==
X-Google-Smtp-Source: AMrXdXtqPmAMagtNmmrZZmv/mgdDOl34t48Vbh1iMpY2rNSQ9gDDkdfblHXG/sKtNniDa931jv8HIw==
X-Received: by 2002:a05:622a:4a83:b0:3b6:3931:640d with SMTP id fw3-20020a05622a4a8300b003b63931640dmr50788197qtb.48.1674723057415;
        Thu, 26 Jan 2023 00:50:57 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id 204-20020a3703d5000000b006f9ddaaf01esm551941qkd.102.2023.01.26.00.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 00:50:56 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id e15so1162361ybn.10;
        Thu, 26 Jan 2023 00:50:55 -0800 (PST)
X-Received: by 2002:a25:37d4:0:b0:80b:8602:f3fe with SMTP id
 e203-20020a2537d4000000b0080b8602f3femr1019227yba.36.1674723055416; Thu, 26
 Jan 2023 00:50:55 -0800 (PST)
MIME-Version: 1.0
References: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org> <20230124091916.45054-10-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230124091916.45054-10-krzysztof.kozlowski@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Jan 2023 09:50:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXfD-G+SYQX5tJ8O-GSO3yTVL00xCX8A-Rc673zNkLbBw@mail.gmail.com>
Message-ID: <CAMuHMdXfD-G+SYQX5tJ8O-GSO3yTVL00xCX8A-Rc673zNkLbBw@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] dt-bindings: serial: example cleanup
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Chester Lin <clin@suse.com>, Fugang Duan <fugang.duan@nxp.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Le Ray <erwan.leray@foss.st.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Tomer Maimon <tmaimon77@gmail.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 10:20 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> Adjust example DTS indentation to match recommended style of 4-spaces
> and use lower-case hex for address in reg.  No functional change.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

>  .../bindings/serial/renesas,em-uart.yaml      | 10 +++----
>  .../bindings/serial/renesas,hscif.yaml        | 26 +++++++++----------
>  .../bindings/serial/renesas,sci.yaml          | 24 ++++++++---------
>  .../bindings/serial/renesas,scif.yaml         | 24 ++++++++---------
>  .../bindings/serial/renesas,scifa.yaml        | 22 ++++++++--------
>  .../bindings/serial/renesas,scifb.yaml        | 12 ++++-----

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
