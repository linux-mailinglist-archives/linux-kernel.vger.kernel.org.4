Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866C45BBCBA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 11:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiIRJRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 05:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIRJR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 05:17:27 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9262611A02;
        Sun, 18 Sep 2022 02:17:26 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id h21so18830850qta.3;
        Sun, 18 Sep 2022 02:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=OeRjUs/DtBMtRezCJLCKN2z1axmYn75dDl7PJ/c3mYk=;
        b=U+1t0kcTiEhJw/d/UpLjsLEQnkbd7c7eF5tB1uu1O4KGIkYmc6T0QzPY9+xHFaSauo
         dhvpNpftpRJaQkwh8B29I1cn/n/QfuRoIuD1obMaXTs/NavTK0BmQTvnSE9omOzwiUFL
         5pxVU5M7H0cc45wnURS7ROBd3FyYio/Nd7IShVt2kfomL/aw9kJYJGXaFvXib0iIue3K
         cwSFJ/SgeiRLKeHxN85cP3ZCi9ltRURpKenx1VVmy5qqN0pmq8+MxtwD8sphdqQnGfHq
         UcitS6k6w2OAhHVOqmKrBc1iokiFyVczHrUtUmkjSivU2afk3a7Qt+8OXYdiQ4+dulHk
         2Z5g==
X-Gm-Message-State: ACrzQf2nYzpgpWYIF5Kd92n+mo22XbN5r2jwdOEqeHoVHm86Zl5C2vDK
        S9SLjU6nH8Y+Pi7CoG1s5+A2b4gl0g0yog==
X-Google-Smtp-Source: AMsMyM6mSX4WJgoDG6M6gv7UH678zwjqWzj/q/liZ8/me/MICR9hbWSgPe23I38WvMoQ7+CXi7MT7A==
X-Received: by 2002:ac8:5d49:0:b0:35b:b660:161f with SMTP id g9-20020ac85d49000000b0035bb660161fmr10942161qtx.678.1663492645328;
        Sun, 18 Sep 2022 02:17:25 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id l20-20020a05620a28d400b006ce1bfbd603sm10463755qkp.124.2022.09.18.02.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 02:17:24 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-3457bc84d53so308944197b3.0;
        Sun, 18 Sep 2022 02:17:24 -0700 (PDT)
X-Received: by 2002:a81:1691:0:b0:345:17df:4fc6 with SMTP id
 139-20020a811691000000b0034517df4fc6mr10064527yww.502.1663492644443; Sun, 18
 Sep 2022 02:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220916100251.20329-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220916100251.20329-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 18 Sep 2022 11:17:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWyD1AZmg1TZ+V9f6AeW5FtzYim828UQO2UhKdag3NbVw@mail.gmail.com>
Message-ID: <CAMuHMdWyD1AZmg1TZ+V9f6AeW5FtzYim828UQO2UhKdag3NbVw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: Adjust whitespace around '{'
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 12:03 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Drop extra space around the '{' sign. No functional changes (same DTB).
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
