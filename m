Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D908460DC75
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbiJZHuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbiJZHt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:49:56 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3912B630;
        Wed, 26 Oct 2022 00:49:54 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id h24so9348846qta.7;
        Wed, 26 Oct 2022 00:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3bJMnDF5gR+5nWpRljtWn9AU/fS3ZyVJdAMd1+0CBgA=;
        b=XIiUBHOvsuW1XpVD/OymIpSxnJXpl59eiZl176X/ZcfFcoeOxROkDE7yTUrJYoa4vI
         VubFUGNyx4W4Hf7XPFpGaeoVzqUp0/mbeyqfoS+5ry56mSlVDHsdEG2ZRgQXV/5iC/Qa
         8XfwhML8JE/rqe+B607Is0lmvbr0S6cTJCBVWUdIv1iSo5ZDho8nU6YBUTPGmONilyDq
         C5gO4tOn0RJheWnr6G9vuGAMzeldZxtZIGgTjNh8YkrvjlHtTka9g7da9uGeoHndDGpy
         pUcE8CZ35IzjE7WQ0XY7pee3twBiuHmtrocqKsIDTevhRBgPuVoRmYrozC1I6vHjm8MX
         8sIw==
X-Gm-Message-State: ACrzQf2omscnEXb8CpKb64tfhEe9a1LNszuz0Qg9kqt4ohbDMv2a5b7O
        fCwq5uStDZunJauSGOzon1Yvlc0HkgkFyw==
X-Google-Smtp-Source: AMsMyM6lJHeppPeIMWm7FNxI/90n2KJrjOH6wB/pUldfuDHgo1E5pm4tBsEk5qBlYIE8+cDjzexFcw==
X-Received: by 2002:a05:622a:110:b0:39d:33f:7502 with SMTP id u16-20020a05622a011000b0039d033f7502mr30773943qtw.233.1666770593164;
        Wed, 26 Oct 2022 00:49:53 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id j6-20020a37c246000000b006eed47a1a1esm3339144qkm.134.2022.10.26.00.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 00:49:52 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id o70so17831723yba.7;
        Wed, 26 Oct 2022 00:49:52 -0700 (PDT)
X-Received: by 2002:a25:cd01:0:b0:6c2:6f0d:f4ce with SMTP id
 d1-20020a25cd01000000b006c26f0df4cemr35666539ybf.365.1666770592403; Wed, 26
 Oct 2022 00:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221026012123.159790-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221026012123.159790-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Oct 2022 09:49:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXswphZ13u5b+kgKzRe1N0UohsD56OyvYQKciOE-1dArw@mail.gmail.com>
Message-ID: <CAMuHMdXswphZ13u5b+kgKzRe1N0UohsD56OyvYQKciOE-1dArw@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: rzg2l: Fix typo
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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

On Wed, Oct 26, 2022 at 3:21 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Fix typo pll5_mux_dsi_div_params -> mux_dsi_div_params
>
> Fixes the below warning (make W=1):
>
> drivers/clk/renesas/rzg2l-cpg.c:115: warning: Function parameter or member 'mux_dsi_div_params' not described in 'rzg2l_cpg_priv'
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v6.2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
