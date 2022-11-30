Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257A963E091
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 20:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiK3TS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 14:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiK3TS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 14:18:27 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8642E8326B;
        Wed, 30 Nov 2022 11:18:26 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id y15so3199394qtv.5;
        Wed, 30 Nov 2022 11:18:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=viurBIMrrjVhVQQ2xklycs4TlNU9Q00m6IkXE2RY5KA=;
        b=VGNQH2vybvQQRmKlcl6OpXLUxY7ukQzlWh1FGZeBYY8uZAsEr2k/7c7T2U3jvbqR18
         ALR6/IU5z6LwGmaAczzQU2wrLZTlWz9PnQpKgjQX1BVyPIkrKCNSwAu3cIkvkMJgG1m2
         82f4xW394JGxQj9CY6wDks74D7KeKpIm8ElpZCoVWpVLIK4rLMbRvMqip5IJxXiRp1Rl
         HdO/saSmcnH7HEv84mWbYT3PbQVjKf/cQfwxqv94+APn61eJBwquRGeP3V7lkvFHeiKE
         aPHKy7cIMNTLMh1xPxwKSAi/wSgUvUMQJrNJLIubte9nFm/t86Z0rooEcQecGdA/S0ih
         hLfw==
X-Gm-Message-State: ANoB5pkLei6+bjloEarS9SQU4Nt4F02aTj5wA62+NTX/7lKAscd3p/v1
        gDyL3SqIHztH/0kKzScDk2ENFTRRmR0Tsg==
X-Google-Smtp-Source: AA0mqf6B7bNKsRDU0//K/zRDE4dKnG0sdM10D1DuUgN4izuhKD3B/I4aEHjxknrHYgBsfJTMbxFwig==
X-Received: by 2002:ac8:5547:0:b0:3a5:36ab:b870 with SMTP id o7-20020ac85547000000b003a536abb870mr42713392qtr.650.1669835905468;
        Wed, 30 Nov 2022 11:18:25 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id y14-20020a05620a44ce00b006fb7c42e73asm1867827qkp.21.2022.11.30.11.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 11:18:23 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id 7so22840600ybp.13;
        Wed, 30 Nov 2022 11:18:22 -0800 (PST)
X-Received: by 2002:a25:bcc6:0:b0:6dd:1c5c:5602 with SMTP id
 l6-20020a25bcc6000000b006dd1c5c5602mr61739204ybm.36.1669835902496; Wed, 30
 Nov 2022 11:18:22 -0800 (PST)
MIME-Version: 1.0
References: <20221123065946.40415-1-tomi.valkeinen+renesas@ideasonboard.com> <20221123065946.40415-4-tomi.valkeinen+renesas@ideasonboard.com>
In-Reply-To: <20221123065946.40415-4-tomi.valkeinen+renesas@ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 30 Nov 2022 20:18:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUjCS6q44XmTanu=R68GyuVECLa0B-1AFg1CUD_oV4DuA@mail.gmail.com>
Message-ID: <CAMuHMdUjCS6q44XmTanu=R68GyuVECLa0B-1AFg1CUD_oV4DuA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] clk: renesas: r8a779g0: Add display related clocks
To:     Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
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

Hi Tomi,

On Wed, Nov 23, 2022 at 8:00 AM Tomi Valkeinen
<tomi.valkeinen+renesas@ideasonboard.com> wrote:
> Add clocks related to display which are needed to get the DSI output
> working.
>
> Extracted from Renesas BSP tree.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks for your patch!

> --- a/drivers/clk/renesas/r8a779g0-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
> @@ -145,6 +145,8 @@ static const struct cpg_core_clk r8a779g0_core_clks[] __initconst = {
>         DEF_FIXED("viobusd2",   R8A779G0_CLK_VIOBUSD2,  CLK_VIO,        2, 1),
>         DEF_FIXED("vcbus",      R8A779G0_CLK_VCBUS,     CLK_VC,         1, 1),
>         DEF_FIXED("vcbusd2",    R8A779G0_CLK_VCBUSD2,   CLK_VC,         2, 1),
> +       DEF_FIXED("dsiref",     R8A779G0_CLK_DSIREF,    CLK_PLL5_DIV4,  48, 1),
> +       DEF_DIV6P1("dsiext",    R8A779G0_CLK_DSIEXT,    CLK_PLL5_DIV4,  0x884),
>
>         DEF_GEN4_SDH("sd0h",    R8A779G0_CLK_SD0H,      CLK_SDSRC,         0x870),
>         DEF_GEN4_SD("sd0",      R8A779G0_CLK_SD0,       R8A779G0_CLK_SD0H, 0x870),
> @@ -161,6 +163,14 @@ static const struct mssr_mod_clk r8a779g0_mod_clks[] __initconst = {
>         DEF_MOD("avb0",         211,    R8A779G0_CLK_S0D4_HSC),
>         DEF_MOD("avb1",         212,    R8A779G0_CLK_S0D4_HSC),
>         DEF_MOD("avb2",         213,    R8A779G0_CLK_S0D4_HSC),
> +

Weird horizontal and vertical spacing below...

> +       DEF_MOD("dis0",                 411,    R8A779G0_CLK_S0D3),

I doubt this parent clock is correct.
Based on Table 8.1.4e ("Lists of CPG clocks generated from PLL5"),
this should be one of the VIOBUS clocks.
VIOBUSD2 has the same rate as S0D3, so I'd use that one.

> +       DEF_MOD("dsitxlink0",           415,    R8A779G0_CLK_DSIREF),
> +       DEF_MOD("dsitxlink1",           416,    R8A779G0_CLK_DSIREF),
> +
> +       DEF_MOD("fcpvd0",               508,    R8A779G0_CLK_S0D3),
> +       DEF_MOD("fcpvd1",               509,    R8A779G0_CLK_S0D3),

Likewise.

> +
>         DEF_MOD("hscif0",       514,    R8A779G0_CLK_SASYNCPERD1),
>         DEF_MOD("hscif1",       515,    R8A779G0_CLK_SASYNCPERD1),
>         DEF_MOD("hscif2",       516,    R8A779G0_CLK_SASYNCPERD1),
> @@ -193,6 +203,10 @@ static const struct mssr_mod_clk r8a779g0_mod_clks[] __initconst = {
>         DEF_MOD("tmu3",         716,    R8A779G0_CLK_SASYNCPERD2),
>         DEF_MOD("tmu4",         717,    R8A779G0_CLK_SASYNCPERD2),
>         DEF_MOD("tpu0",         718,    R8A779G0_CLK_SASYNCPERD4),
> +
> +       DEF_MOD("vspd0",                830,    R8A779G0_CLK_S0D1_VIO),
> +       DEF_MOD("vspd1",                831,    R8A779G0_CLK_S0D1_VIO),

While S0D1_VIO is a VIO clock, it is clocked from PLL1, which supports
spread-spectrum, unlike PLL5.
Again, based on Table 8.1.4e ("Lists of CPG clocks generated from
PLL5"), this should be one of the VIOBUS clocks.

Not that all of this matters a lot: all of these parents are always-on,
and I think "dis0" is the only clock where we care about the actual
clock rate?

> +
>         DEF_MOD("wdt1:wdt0",    907,    R8A779G0_CLK_R),
>         DEF_MOD("cmt0",         910,    R8A779G0_CLK_R),
>         DEF_MOD("cmt1",         911,    R8A779G0_CLK_R),

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
