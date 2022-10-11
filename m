Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A19C5FAE5D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 10:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJKIZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 04:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiJKIZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:25:43 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCCF6EF05;
        Tue, 11 Oct 2022 01:25:41 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id s21so7827760qtx.6;
        Tue, 11 Oct 2022 01:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uc8mlP1Bb6ZoEtqh2ABXLZMg75TrHHL0bj3Jd8LQsuE=;
        b=Eh8P/Ob/yhzLV4PRXekB2iz5BrBH87AVPhhBtbzTcRRhWU8UPTaiTuw5nlY2i3S9ha
         wY9YVPB3olSeUwrjzqfyEYbaL9qNRPKOcHnpcYmD2A5kX/RP/DQ1QFTG1QzvpIDukhMD
         h+KF+yl21pKbTz5YkhJwshm9F9Cl1+MZ9eHwwSRbv/ne+lq6pHTTJEpcy0vACQCSTNbj
         TRy31T9M/ISmYFvDLT+DFcGI1AzopNwp1B67mdqqGTgEH4pG0tIMt8tJzYtPsnZRoTHJ
         f0xyJx2WbWxtrgqw+kgWV8vlk8BySVRCAdzVMuAIMLpPD/GbIjD0GgQTGWb3WoP7y+lH
         4S8w==
X-Gm-Message-State: ACrzQf02t+fa+oZh/4RVQaZxceUhmMtCemIfiEQiC4nvP9P2EDS4Inn4
        jyEZvNepec1AiJgBHYR3mnBDjsAZ4uQo4w==
X-Google-Smtp-Source: AMsMyM4KSEd2ApiBgrYFLJezcKVeJQhJBFjYOwNO5rysTAWfEZbNKxRhnb7Xe9IozKqx0WktwxQOjg==
X-Received: by 2002:ac8:5a41:0:b0:35c:fa93:f227 with SMTP id o1-20020ac85a41000000b0035cfa93f227mr18055534qta.102.1665476740565;
        Tue, 11 Oct 2022 01:25:40 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id f14-20020a05620a408e00b006bb83c2be40sm3380476qko.59.2022.10.11.01.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 01:25:38 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id y205so15606107yby.13;
        Tue, 11 Oct 2022 01:25:37 -0700 (PDT)
X-Received: by 2002:a25:2d49:0:b0:6bf:87:706f with SMTP id s9-20020a252d49000000b006bf0087706fmr21550886ybe.202.1665476737646;
 Tue, 11 Oct 2022 01:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221009231013.14791-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221009231013.14791-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Oct 2022 10:25:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUVmEppLQ7_oH6M0dtZS+qoU32tZAv4YTOoiw5vzP9r+Q@mail.gmail.com>
Message-ID: <CAMuHMdUVmEppLQ7_oH6M0dtZS+qoU32tZAv4YTOoiw5vzP9r+Q@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: r9a07g044: Drop WDT2 clock and reset entry
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
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

On Mon, Oct 10, 2022 at 1:10 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> WDT CH2 is specifically to check the operation of Cortex-M33 CPU and if
> used from CA55 CPU would result in an unexpected behaviour. Hence drop
> WDT2 clock and reset entries.
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
