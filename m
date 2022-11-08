Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDDA6218A5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbiKHPnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiKHPn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:43:28 -0500
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEE1C65;
        Tue,  8 Nov 2022 07:43:25 -0800 (PST)
Received: by mail-qv1-f48.google.com with SMTP id h10so10462946qvq.7;
        Tue, 08 Nov 2022 07:43:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBbeZBrYz0Ir8oJqm4j9qjBeLOLNJGXBr3pOfnglPQM=;
        b=F6/n5OUzU35GqdkQPLfCfK0+G+OLJXDLfDbtK1sH1Hbq0Di6EdKkuLJoweuC2xKvxl
         ZjD/RfrIHn8vU5ZCYBC6ehK0RWCtWFL1ta8hxOJYzRdWLU6V36pJXNVXmaq/AtakVy2t
         sCALysz7eJeAjmncE59IWsvpLYuLR2DEWxUUwRPN+hJ3FhJ5+BpY7LaWmuGTIxomy7fo
         tToAn+9jnEVlDX1Ir82v1UZEY5cjnuztMyb+tGMXl0/veDVEhSB8CzStFx5/D37TAgQM
         mhRrozr3DdcRPXYiIv59i27IEFa31Ef5m6kYKYe7tMCxLCj4Jo2oAVag4j0vBIN54LP7
         5SWQ==
X-Gm-Message-State: ACrzQf2rAGl/mtM5aF3s9CyLHMwwZQ6UrvaWClpmzY2QI9UGSB9wL6gq
        nfZh8oulhLERRX6g4fbmgoYgwTcFpQdcs6Oy
X-Google-Smtp-Source: AMsMyM4cxRv6xEDikoFMDmSPm18wmN2RO0qUsd0jshBPjVIvU5caAMMsM31Uc6ltQNRY6ZxiT2TsHQ==
X-Received: by 2002:a05:6214:1bc6:b0:4bb:abfc:4a7e with SMTP id m6-20020a0562141bc600b004bbabfc4a7emr49899718qvc.74.1667922204778;
        Tue, 08 Nov 2022 07:43:24 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id u18-20020a37ab12000000b006eeae49537bsm9241031qke.98.2022.11.08.07.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 07:43:23 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id y186so13166209yby.10;
        Tue, 08 Nov 2022 07:43:23 -0800 (PST)
X-Received: by 2002:a05:6902:503:b0:6cf:c510:6a23 with SMTP id
 x3-20020a056902050300b006cfc5106a23mr36322209ybs.380.1667922202961; Tue, 08
 Nov 2022 07:43:22 -0800 (PST)
MIME-Version: 1.0
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221028165921.94487-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221028165921.94487-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Nov 2022 16:43:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXh-aWpty=JEwB4Lx5eZZ3Mm43gxjCx2yptV+MOWx4kaw@mail.gmail.com>
Message-ID: <CAMuHMdXh-aWpty=JEwB4Lx5eZZ3Mm43gxjCx2yptV+MOWx4kaw@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] riscv: dts: renesas: Add initial devicetree for
 Renesas RZ/Five SoC
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
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

On Fri, Oct 28, 2022 at 6:59 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add initial device tree for Renesas RZ/Five RISC-V CPU Core (AX45MP
> Single).
>
> RZ/Five SoC is almost identical to RZ/G2UL Type-1 SoC (ARM64) hence we
> will be reusing r9a07g043.dtsi [0] as a base DTSI for both the SoC's.
> r9a07g043f.dtsi includes RZ/Five SoC specific blocks.
>
> Below are the RZ/Five SoC specific blocks added in the initial DTSI which
> can be used to boot via initramfs on RZ/Five SMARC EVK:
> - AX45MP CPU
> - PLIC
>
> [0] arch/arm64/boot/dts/renesas/r9a07g043.dtsi
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v4 -> v5
> * Fixed riscv,ndev value (should be 511)
> * Reworked completely (sort of new patch)

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
