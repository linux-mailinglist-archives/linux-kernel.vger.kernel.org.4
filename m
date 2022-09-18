Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B365BBCD7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 11:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiIRJdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 05:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIRJdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 05:33:14 -0400
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D69720BD1;
        Sun, 18 Sep 2022 02:33:13 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id l14so11443223qvq.8;
        Sun, 18 Sep 2022 02:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LPGiBWWb45s9RkifR19ArZuPJdzE5P+5xfpQvE6SSME=;
        b=udKigqX5Tr5KCdXdqlOHzJ/PwZHZKeEwqV6WmUmoUpYScoiTwRE92OM6jCC1glpM19
         4xNEaZKVIe/1l9TB9orgPxKbA1oVBog+0ocPl7551mP8FV95u7v566+nM91I1yytetzy
         CpxYGOJPmqfO1k2mbwkekCVr5LHMtT4NH8hEMxrsMmQo+5G9z8SBfg5OgjL2/lMgE6T3
         gnVzlnrWbCS55ZioRSKcourqFlA72LTrnGrL1UPgK9r7WMjFynp5GrbXaQNk7VG+9nPh
         YZWhTItmv7qN7+Met9W7Af5nKPt85aDRhjqCsK0ltw2/qisoKHex/zd3eYtk4c/dVVsO
         X5PA==
X-Gm-Message-State: ACrzQf1pd0JTLyZUkWs8+R+so+SDwHL5MvJ2aSlLDJM8ECcs7Xy0AE++
        NL7Pj6K6gKfDliRZO9a63oqepEeKMB0zvQ==
X-Google-Smtp-Source: AMsMyM5xa59FaayAj4F5An4xBi43ZSQE80bDA8S2qYcPiCjKfg+1hOVqW8NzVZj0BZmTsyplGHrfFg==
X-Received: by 2002:a0c:f349:0:b0:4aa:b3a6:9774 with SMTP id e9-20020a0cf349000000b004aab3a69774mr10743230qvm.112.1663493592081;
        Sun, 18 Sep 2022 02:33:12 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id p13-20020ac8740d000000b0034454067d24sm8158537qtq.64.2022.09.18.02.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 02:33:11 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-324ec5a9e97so308306677b3.7;
        Sun, 18 Sep 2022 02:33:11 -0700 (PDT)
X-Received: by 2002:a81:758a:0:b0:345:450b:6668 with SMTP id
 q132-20020a81758a000000b00345450b6668mr10243365ywc.316.1663493591294; Sun, 18
 Sep 2022 02:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220915233640.415305-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220915233640.415305-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 18 Sep 2022 11:33:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUEsqNsGqPbS_T0Z+DM01xCWpPNpOzXZda6DQAriNe=gQ@mail.gmail.com>
Message-ID: <CAMuHMdUEsqNsGqPbS_T0Z+DM01xCWpPNpOzXZda6DQAriNe=gQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: Kconfig.platforms: renesas: Drop selecting SOC_BUS
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Fri, Sep 16, 2022 at 1:37 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Don't automatically select the SOC_BUS config option as we already have
> automatically selected it as part of the SOC_RENESAS config option [0]
> as renesas-soc.c [1] uses the APIs provided by SOC_BUS config option.
>
> [0] drivers/soc/renesas/Kconfig
> [1] drivers/soc/renesas/renesas-soc.c
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
