Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10975EA7CB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 15:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbiIZN7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 09:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbiIZN7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 09:59:21 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F8983064;
        Mon, 26 Sep 2022 05:13:28 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id s9so3915947qkg.4;
        Mon, 26 Sep 2022 05:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5r7Zsy4+xPvvNRbJAnwrit2mQEm2o8Jih1/oFy1rujE=;
        b=0VG9vmeSy/Tg0y8l2TQuhKAnQ0ikXT5Npc+QQD2AqwYSoiutyUCpXn/2f2vCI1gs4a
         uvFbSpP2LE3SHsxBCVIzykDJAVKhnQryhL6dNWvQad8zOQeICXsFYVm+RI5O9pu6875H
         tNuPFbr1YT/fYq5wmtaehppjv4/kOiS5Q2g/x85Le5AGkqd4VPngyoPDz2fKMVS0Ac/1
         ahYr//gCaoxjaed4cyqMECVlW2tXMWngKJB5n87HnOueNIvYFAOpXhaZaTlX9o048obv
         lfux6S4GTuKll4L42IKoKPZH/cQW3AJIT+b9Sz2cwcSWDJIn+H+DkhIYCzDHDS/qL2nq
         RZfg==
X-Gm-Message-State: ACrzQf2rjAtEGarPL59Y5ZXXNgumPfwrInqwn3muMzk9qohoz5ZeGDxl
        5kGeW2+o9RObAULKdX0cPn7/RR7ld6vuYQ==
X-Google-Smtp-Source: AMsMyM7NnE3wwNQtKKLnMdbCUO9jA2iug6iqil27nztxYrLQX9gus2mjul8Wg7xu8T3oc+3wLz2aeA==
X-Received: by 2002:a05:620a:51cb:b0:6ce:5e82:7802 with SMTP id cx11-20020a05620a51cb00b006ce5e827802mr13751247qkb.715.1664194357277;
        Mon, 26 Sep 2022 05:12:37 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id de4-20020a05620a370400b006ce7cd81359sm11648062qkb.110.2022.09.26.05.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 05:12:36 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-349c4310cf7so66356617b3.3;
        Mon, 26 Sep 2022 05:12:36 -0700 (PDT)
X-Received: by 2002:a81:758a:0:b0:345:450b:6668 with SMTP id
 q132-20020a81758a000000b00345450b6668mr19505687ywc.316.1664194356174; Mon, 26
 Sep 2022 05:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220919104606.96553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220919104606.96553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 26 Sep 2022 14:12:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVNsDqu6WCHK37SiJ51_vO4HiwHG7KvkXBqO6i0hCaO_w@mail.gmail.com>
Message-ID: <CAMuHMdVNsDqu6WCHK37SiJ51_vO4HiwHG7KvkXBqO6i0hCaO_w@mail.gmail.com>
Subject: Re: [PATCH] soc: renesas: Kconfig: Explicitly select GPIOLIB and
 PINCTRL config under SOC_RENESAS
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
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

On Mon, Sep 19, 2022 at 12:46 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> GPIOLIB and PINCTRL config options are required by all ARM32/ARM64/RISC-V
> Renesas SoCs, so instead of selecting them under ARCH_RENESAS for each
> architecture just explicitly select them under SOC_RENESAS config option
> which will be visible for all the three architectures (if ARCH_RENESAS is
> enabled).
>
> Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.2.

> Note, only when this patch is merged I'll post the patches to drop GPIOLIB
> and PINCTRL from [0] and [1] to avoid bisect build failures.

Great!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
