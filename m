Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD776218AD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbiKHPog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbiKHPof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:44:35 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A727B641C;
        Tue,  8 Nov 2022 07:44:34 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id w4so8898377qts.0;
        Tue, 08 Nov 2022 07:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50PklNH5QUfx4ckE9IHyJPBCOysgRvcLFQ0p1EQvvis=;
        b=Zdb16DI7byg/5Q7lsLw9/COyf2vjy75u97K3mI1MeAxA9H2q/sVzmMW4IE1q/iYO5c
         kdtbDlvm7f2LHiB11PXGBDv9XRzlUeZi7eavDlIYiFYJO/m+oDYdsJA/tyd3roqW4UaA
         Yrcvog1UKm9p+vTnAlLdyUgoEa8vXLI4AbA64A7srk/EsDG54GzV+LfGSgzjze6eokuN
         GPHo5zpmgQ2UnyKXP7sUydV97PJ5hHCnwJCohZNkefEaPsH3UHJfn19BXIp+pG1v6Cs+
         hPYTHJ8TChFK2a//vsKL+qnCJrjtfNFGKmq7DaqX5QRDQvecBbaGS/b37cdwmJAR7XpX
         GqWQ==
X-Gm-Message-State: ANoB5pmvSuAEr58Wy11spavuaZx1dLvn2tC1rRotV+zC6KwJd7H3/pXn
        dsOyqyw0CXfi09ke/1q/g3PZUq6rLflMkeSk
X-Google-Smtp-Source: AA0mqf6POoYVe+WRnjs+bcE6e89W/IVd8qgBSFz0kuGSkGLgSfRUIAd1KEuBXODII65tjkzPQrjB/w==
X-Received: by 2002:ac8:5ccd:0:b0:3a5:92a5:4427 with SMTP id s13-20020ac85ccd000000b003a592a54427mr7042475qta.391.1667922273408;
        Tue, 08 Nov 2022 07:44:33 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id 6-20020ac84e86000000b0039cb5c9dbacsm8482151qtp.22.2022.11.08.07.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 07:44:32 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id 7so13272084ybp.13;
        Tue, 08 Nov 2022 07:44:31 -0800 (PST)
X-Received: by 2002:a25:4fc2:0:b0:6be:afb4:d392 with SMTP id
 d185-20020a254fc2000000b006beafb4d392mr51553746ybb.604.1667922271344; Tue, 08
 Nov 2022 07:44:31 -0800 (PST)
MIME-Version: 1.0
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221028165921.94487-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221028165921.94487-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Nov 2022 16:44:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWt1kg2o83duedLY1LV9W6ShehCNFD1MtUKr_EBg7M4fw@mail.gmail.com>
Message-ID: <CAMuHMdWt1kg2o83duedLY1LV9W6ShehCNFD1MtUKr_EBg7M4fw@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] riscv: dts: renesas: Add minimal DTS for Renesas
 RZ/Five SMARC EVK
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 6:59 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Enable the minimal blocks required for booting the Renesas RZ/Five
> SMARC EVK with initramfs.
>
> Below are the blocks which are enabled:
> - CPG
> - CPU0
> - DDR (memory regions)
> - PINCTRL
> - PLIC
> - SCIF0
>
> As we are reusing the RZ/G2UL SoC base DTSI [0], RZ/G2UL SMARC SoM [1] and
> carrier [2] board DTSIs which enables almost all the blocks supported
> by the RZ/G2UL SMARC EVK and whereas on RZ/Five SoC we will be gradually
> enabling the blocks hence the aliases for ETH/I2C are deleted and rest
> of the IP blocks are marked as disabled/deleted.
>
> [0] arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> [1] arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
> [2] arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v4 -> v5
> * Reworked completely (sort of new patch)

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
