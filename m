Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFC05EA843
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbiIZOUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbiIZOUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:20:31 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AE8B4EB9;
        Mon, 26 Sep 2022 05:29:18 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id s9so3940732qkg.4;
        Mon, 26 Sep 2022 05:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yQYUi9rtHxzjnq1LUMbIkH4itTobdLfxS8nJcmd6jKA=;
        b=qY56S/x13w8hk8Jw8nrQomBdY78ZVUboxWvgMsuMX4qw8XZ9pcVlXc/ucz3VoluReW
         yQJnt7ISl/Lex0mJl5EpMBwkMFHKA+Blbz7Mepe6ZscQU7pDzjwUFI/bBzBGtTbAV7gy
         Dh2rQTTQ8l6uecXKlYcnWt2/tHpm2Zd7+VYoYDJg64D9lvnUWcDiGnl108KC0VGe0Dj1
         68SUOI44kcHJXkbZY9pSLpx2ehIYXxp/ZKpsnHKJVzyrKdLvIJ9H/MOJAuE8jmav2dkU
         Wz5m2L+ahpu4OrVruTsMO8005B4+c0XseS5qnSil37NNxeTv6czN4fIpRobCxeqHe+rJ
         KPGQ==
X-Gm-Message-State: ACrzQf2xxNY3NNEGWXMNo403Di0zqwiWhIHKx+e2jL54w7qmJy+3CYJe
        PhpM9bP77uNrRE3z89lQbo3zzg0DZHa/IA==
X-Google-Smtp-Source: AMsMyM5qP0Y3VA1L+xgbv2dgT8aK1Zwx1aKIeu0QLWlNXL1LC3cZA5tOjX2sEYr+lfVIEZNCF1Ml4Q==
X-Received: by 2002:a05:620a:31a1:b0:6ce:d7be:496b with SMTP id bi33-20020a05620a31a100b006ced7be496bmr13996526qkb.192.1664195347395;
        Mon, 26 Sep 2022 05:29:07 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id f19-20020a05620a409300b006ce3e4fb328sm11977818qko.42.2022.09.26.05.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 05:29:07 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id e81so8088508ybb.13;
        Mon, 26 Sep 2022 05:29:07 -0700 (PDT)
X-Received: by 2002:a25:8e84:0:b0:696:466c:baa with SMTP id
 q4-20020a258e84000000b00696466c0baamr19598860ybl.604.1664195346868; Mon, 26
 Sep 2022 05:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220919092130.93074-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220919092130.93074-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 26 Sep 2022 14:28:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWEdY5AdjbH-1FvtPQS+5H3LSAF_281k06Y0Bi9mfxQZw@mail.gmail.com>
Message-ID: <CAMuHMdWEdY5AdjbH-1FvtPQS+5H3LSAF_281k06Y0Bi9mfxQZw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: rzg2lc-smarc: Include SoM DTSI into
 board DTS
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 11:22 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Move including the rzg2lc-smarc-som.dtsi from the carrier board
> rzg2lc-smarc.dtsi to the actual RZ/G2LC SMARC EVK board dts
> r9a07g044c2-smarc.dts. Also move the SW1 related macros along with
> PMOD1_SER0 to board dts so that we have all the configuration options
> in the same file.
>
> This patch is to keep consistency with other SMARC EVKs (RZ/G2L, RZ/G2UL)
> and it makes sense not include the SoM into the carrier board as we might
> in future have a different carrier board with the same SoM.
>
> Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
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
