Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5396281DB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbiKNOCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbiKNOC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:02:28 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA9527B36;
        Mon, 14 Nov 2022 06:02:26 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id c15so6759329qtw.8;
        Mon, 14 Nov 2022 06:02:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vdYjgMgXn6UMjwDeO+ZS8VMHPTpueegMscT499nSXN4=;
        b=3IYzaInsr2qwQIwXw5X9IrpABBdyZAORkCRMP7F03uOzpMSG1LIRVtDs55cKC18mZr
         /+vqbXa5Vis6j4ECEjoYV9DiekPeY7GlTEa1ayoScQV6TzgNxXPdNCG8BcZY8gYAzYN+
         Rc+wcIBEqP6H/TXt/aJbANkTQ1K1WixdSR1/cltgW3QLe/4HULnMoaKPAuhcOeat5166
         IP38qCGsEptEyiceyeALPxhnBnfTEhUPvM3ehhiqJe6kWBOCduWc67yvqDCYycoiuVCm
         p0lUvfiYRN0W86lL/NvNBi2DxHS606qCjkEbLHLQUY0eRUlY9E2TWPkLZJgub5scCpYg
         ikhw==
X-Gm-Message-State: ANoB5pmxWXkeTpXKH8f3TayaoZSmDxr+7eFPbp1yJLGA88WqOSyFEuJO
        2xUgyM99qZJzRkHRqWM+qrpzOkWhy7uqow==
X-Google-Smtp-Source: AA0mqf6FNDmrZp3pR9/XxDfPRLrBd3E0AW5irg3fUTxUTbN40Ki+HVBkJBs1JktQFQ+AJXV1R4N4mA==
X-Received: by 2002:ac8:7dc1:0:b0:3a5:211f:1f2c with SMTP id c1-20020ac87dc1000000b003a5211f1f2cmr12554206qte.241.1668434545332;
        Mon, 14 Nov 2022 06:02:25 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id bk8-20020a05620a1a0800b006f9f3c0c63csm6511083qkb.32.2022.11.14.06.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 06:02:24 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-381662c78a9so26019027b3.7;
        Mon, 14 Nov 2022 06:02:23 -0800 (PST)
X-Received: by 2002:a81:4ed2:0:b0:370:202b:f085 with SMTP id
 c201-20020a814ed2000000b00370202bf085mr12749930ywb.502.1668434543693; Mon, 14
 Nov 2022 06:02:23 -0800 (PST)
MIME-Version: 1.0
References: <20221103223956.50575-1-fabrizio.castro.jz@renesas.com> <20221103223956.50575-4-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20221103223956.50575-4-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Nov 2022 15:02:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWsiWsH_YwmZj6O+z08oxouNGbEp-h9fmS=gLNn=vZh3w@mail.gmail.com>
Message-ID: <CAMuHMdWsiWsH_YwmZj6O+z08oxouNGbEp-h9fmS=gLNn=vZh3w@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: renesas: v2mevk2: Enable watchdog
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 3, 2022 at 11:47 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> Enable the watchdog so that we can reboot the system.
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
