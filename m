Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482255FAE3D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 10:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiJKIPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 04:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiJKIPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:15:05 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32114286E7;
        Tue, 11 Oct 2022 01:14:45 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id hh9so7796201qtb.13;
        Tue, 11 Oct 2022 01:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UK3dXGDPuN8xcwMtb1yXl5D14DsaayP6a4XmyECWV0o=;
        b=qgZFm49ArBIMQAAu809aGEjPhS6EVwP6D6/DIZuR6OU5beSEyx0BxIS1TnPA95RDcp
         FuGKLZYAY87D9krW6gynTCaQQ7GtJRXwCx1ooiRFm8wEWZoWyIEoqDFxPfYmfs5fPpYf
         PHPk9BtV4Ht01EBO6oDgaLun+xNZjJRjUq6lwpilj6JW8MiUttKaViErNS3ijiR6yLer
         hvz4U37wkDzpYq1BtOldtvv27UgcOiNPsQub9b0ItBYnPE66gngcFEj0X1BSYueWCd6Z
         DPJwct+c9fDULORFLqbMBEWzWsYEW6lpeOZE1NRHZ+QdcAIowKySnN4hIqfvJ/USvQDZ
         majA==
X-Gm-Message-State: ACrzQf0FuXtcG42ZyNI2JUHArSea1UZiNhEwHjmWjTsD+9cu3QZu+pZP
        mBw0X4b5g9jToneoKYwFTRFxm79tYZH1hw==
X-Google-Smtp-Source: AMsMyM4SRsJr/VikcsesFmzNVNy9sgkv6qq+eNfnl9RqNBwLs3yuI2NhbDIwAV5PLj84bs3D7yHvug==
X-Received: by 2002:a05:622a:1209:b0:35d:29b:8c4c with SMTP id y9-20020a05622a120900b0035d029b8c4cmr17666155qtx.124.1665476073600;
        Tue, 11 Oct 2022 01:14:33 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id fc8-20020a05622a488800b003938a65479bsm10037276qtb.10.2022.10.11.01.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 01:14:33 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-333a4a5d495so120366137b3.10;
        Tue, 11 Oct 2022 01:14:32 -0700 (PDT)
X-Received: by 2002:a81:98d:0:b0:357:2422:13b4 with SMTP id
 135-20020a81098d000000b00357242213b4mr20001140ywj.316.1665476072511; Tue, 11
 Oct 2022 01:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221009230044.10961-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221009230044.10961-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221009230044.10961-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Oct 2022 10:14:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUXvBb_wYhmso_P=RRQv1N2W+oaKC9J=nMVvq0yLLNhzg@mail.gmail.com>
Message-ID: <CAMuHMdUXvBb_wYhmso_P=RRQv1N2W+oaKC9J=nMVvq0yLLNhzg@mail.gmail.com>
Subject: Re: [PATCH 3/5] arm64: dts: renesas: r9a07g044: Drop WDT2 node
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

On Mon, Oct 10, 2022 at 1:01 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> WDT CH2 is specifically to check the operation of Cortex-M33 CPU and if
> used from CA55 CPU would result in an unexpected behaviour. Hence drop
> WDT2 node from RZ/G2L SoC DTSI.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
