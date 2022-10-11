Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28855FAE4B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 10:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJKIUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 04:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJKIUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:20:11 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EA14D4F6;
        Tue, 11 Oct 2022 01:20:10 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id hh9so7801311qtb.13;
        Tue, 11 Oct 2022 01:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s5cy4m+JeTeSbqK/4ChAVWDQ8MECbJ/i57t04QpddHE=;
        b=IzgZUGtq+krgDnUd/FXSs4xJkV9y6VMdblsqToJz2/PkTkFZVRYdRTZHJEGYoOsbQJ
         MVujlFPQ6jMczgD6bKnlELldRNWvHN29JjEoKCudoM6Zv9qjgfSMbB1Ypw3EH3WozZQw
         UXf7e9Enic0Wa4HucbwDOkQfjIPBaYsOPfRbJ0fcOG3YBLEOn7ojkK82rVUJzhV7UPbL
         7Z1iWqZxz0MBZ/PJcG6JrX3UZsKxuxpG5gZnyso0bH0Tvo8yNq7DsT0SZsHU8wUxxGm7
         qEhc5InYqkIW3beKQyOg67Ghwni2w3SuqrYZRttuDXFx8rJAd3exNnteRJs1tPKxP0Db
         aG5w==
X-Gm-Message-State: ACrzQf2cuRhD589BRpiHaX9hIioxyR4ckZGNk/xCbUU7u8hWZj+rfWCG
        pewtaFLiuQ9Ax+LPd6wCFxrBNs6s/FrYCA==
X-Google-Smtp-Source: AMsMyM45v/oqmzdNUSy4TuwVAAVEOU7YLDOfbDiloQiGI9m0r7M4ATBxcZgLOZZkUo06e5q3PALgLw==
X-Received: by 2002:a05:622a:1109:b0:39c:1d87:3b6c with SMTP id e9-20020a05622a110900b0039c1d873b6cmr1964616qty.139.1665476409565;
        Tue, 11 Oct 2022 01:20:09 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id m8-20020ac84448000000b0039a1146e0e1sm4324641qtn.33.2022.10.11.01.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 01:20:09 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-3321c2a8d4cso120783297b3.5;
        Tue, 11 Oct 2022 01:20:08 -0700 (PDT)
X-Received: by 2002:a81:848c:0:b0:356:e173:2c7a with SMTP id
 u134-20020a81848c000000b00356e1732c7amr20188073ywf.502.1665476408490; Tue, 11
 Oct 2022 01:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221009230044.10961-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221009230044.10961-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221009230044.10961-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Oct 2022 10:19:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXwPnWfb8hfxNGHH8r168ToapBOkdOWJAx9Tj3D6KRTcQ@mail.gmail.com>
Message-ID: <CAMuHMdXwPnWfb8hfxNGHH8r168ToapBOkdOWJAx9Tj3D6KRTcQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: renesas: r9a07g043: Drop WDT2 node
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

On Mon, Oct 10, 2022 at 1:01 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> WDT CH2 is specifically to check the operation of Cortex-M33 CPU and if
> used from CA55 CPU would result in an unexpected behaviour. Hence drop
> WDT2 node from RZ/G2UL SoC DTSI.
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
