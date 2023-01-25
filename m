Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE2167B380
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 14:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbjAYNg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 08:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbjAYNgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:36:23 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2692E56EEE;
        Wed, 25 Jan 2023 05:35:59 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id x5so15896839qti.3;
        Wed, 25 Jan 2023 05:35:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZdfK27Pl8Qf1bAkgWDJxIwjqiS39wBNSM1xYlk/CDM=;
        b=FIbGohxrkjfjCRPOy34GNKQ3U9GsTYeTAiLhe2PLbLWdhlTrp7/pnGlRfkkj4tOHWe
         Jx7Rdz2UJ5lY3gnMGaDw3tLfouX2lYbRV1pOEfwVUqLd84qA9PbbbnpsjbHh1A8ADsML
         dia8g+c/iCS0F1wVnzFsL44efItJWxTcwzgB5akQ8LDAX2nBNQriPuMaZgg8Bk4B0QJH
         W5mMKX96sSmg9H12Nrxzzw0ZhmdfujFLvU5dwHV4YHo+8sCoumTIjJZVV6Azca9FrK+S
         8VcD6qQ3j8fpzcg+8Lc4MUkprCQDvTqdWun3CkwOyEKXe7RFGhE1F2MHitdxgevrCVYw
         bXxA==
X-Gm-Message-State: AO0yUKUYoBn5h5hl0MpM7dDaNxi5jW5wo7FNiJOgxrZNXMwiwXSf/N08
        2Si6sIRLayUDIFEYicwvGR9s4SvvM+YDFQ==
X-Google-Smtp-Source: AK7set8OWGyZs/3aI/xEYqC6lH6tLUIbbkZLf/26wjOd2swYlbLxk7ivjWN+Bd2ROO+zIznV7Co8Fw==
X-Received: by 2002:ac8:5e54:0:b0:3b6:2e12:4d25 with SMTP id i20-20020ac85e54000000b003b62e124d25mr3691517qtx.31.1674653758122;
        Wed, 25 Jan 2023 05:35:58 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id pa30-20020a05620a831e00b006fa43e139b5sm3482352qkn.59.2023.01.25.05.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 05:35:57 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id t16so18319929ybk.2;
        Wed, 25 Jan 2023 05:35:57 -0800 (PST)
X-Received: by 2002:a25:9801:0:b0:7d5:b884:3617 with SMTP id
 a1-20020a259801000000b007d5b8843617mr2856626ybo.380.1674653756828; Wed, 25
 Jan 2023 05:35:56 -0800 (PST)
MIME-Version: 1.0
References: <20230118144747.24968-1-fabrizio.castro.jz@renesas.com> <20230118144747.24968-2-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230118144747.24968-2-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Jan 2023 14:35:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXbTED0hkWsVhOj6mgCp0hrOUiSS7GQpyj1BKPMhnoh=A@mail.gmail.com>
Message-ID: <CAMuHMdXbTED0hkWsVhOj6mgCp0hrOUiSS7GQpyj1BKPMhnoh=A@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: renesas: r9a09g011: Add PWC support
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
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

On Wed, Jan 18, 2023 at 3:48 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> The RZ/V2M SoC contains an External Power Sequence Controller (PWC)
> module. This module provides an external power supply on/off
> sequence, on/off signal for the LPDDR4 core power supply, General
> Purpose Outputs, and key input signals.
>
> This patch adds PWC support to the SoC specific device tree.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
