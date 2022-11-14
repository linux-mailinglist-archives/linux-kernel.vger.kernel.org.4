Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D896281D0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbiKNOA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiKNOAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:00:54 -0500
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF43B84C;
        Mon, 14 Nov 2022 06:00:54 -0800 (PST)
Received: by mail-qk1-f172.google.com with SMTP id g10so7382901qkl.6;
        Mon, 14 Nov 2022 06:00:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1GhVSMgJR05/nAScHpCfHzFiRHojqTKjgS5bregNYrM=;
        b=oZt6SNNR2JVdG0WUps+/5y0yRjlgcQcVZKKig3os2WuyzwJpLq8ADOZcHppiWx4jpa
         7e+Ybh2x+jNAcgoRBGuScJpL4ADbNpK+4IC+cnas/PAr5bHtbY2nbb5b23VIYb4LKbXD
         KmbL20ZLdVCzkmLAQPMz2eA3DGbWO4/iwWvjroz+AUuwutqoSuwFeUgdEHmyWoorUv9o
         FnC/b0BG6+HZqgRD2mSTcoCLG/FZujZE9R+ApnJ8zHHALNWq00BCcfxXW8KMMo9sKPKI
         nMt8hf3phMzhPQcy1PVD4MFsTo7iAiPY+MUjWmftIkC3sLN4YkAfqL6K0D27dfGQOqgv
         08iA==
X-Gm-Message-State: ANoB5pmCjzBqOlMKgB0YUKR1oKqr4PusbCd2z7iLnp8XIzZQruaEITDj
        t71zLH9HRzl7C+DZS4jJByzobNfdC0PFjA==
X-Google-Smtp-Source: AA0mqf7kyg2yt2du1i1VWRbXpFV/pAefSSBk0uDGh7E2+LrP0m9bTur8j7xD5IzrF8JQGJWVOp+Npg==
X-Received: by 2002:a05:620a:459f:b0:6ba:e9c7:a54f with SMTP id bp31-20020a05620a459f00b006bae9c7a54fmr11338194qkb.218.1668434453036;
        Mon, 14 Nov 2022 06:00:53 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id g11-20020ac87f4b000000b0039a9b55b829sm5738812qtk.29.2022.11.14.06.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 06:00:52 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-369426664f9so106705827b3.12;
        Mon, 14 Nov 2022 06:00:52 -0800 (PST)
X-Received: by 2002:a0d:f6c6:0:b0:373:5c0c:9b37 with SMTP id
 g189-20020a0df6c6000000b003735c0c9b37mr12937943ywf.358.1668434452343; Mon, 14
 Nov 2022 06:00:52 -0800 (PST)
MIME-Version: 1.0
References: <20221103223956.50575-1-fabrizio.castro.jz@renesas.com> <20221103223956.50575-3-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20221103223956.50575-3-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Nov 2022 15:00:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV4XaXDMEUCar9i1mLxKcTHwDSE04EQAyUSQBG9S6V5KQ@mail.gmail.com>
Message-ID: <CAMuHMdV4XaXDMEUCar9i1mLxKcTHwDSE04EQAyUSQBG9S6V5KQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: renesas: r9a09g011: Add watchdog node
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
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

On Thu, Nov 3, 2022 at 11:40 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> The r9a09g011 (a.k.a. RZ/V2M) comes with two watchdog IPs,
> but Linux is only allowed one.
>
> Add a node for the watchdog allowed to Linux to the SoC
> specific dtsi.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
