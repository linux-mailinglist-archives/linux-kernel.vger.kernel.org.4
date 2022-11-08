Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A3E621875
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbiKHPiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbiKHPiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:38:04 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8644258038;
        Tue,  8 Nov 2022 07:38:03 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id z6so8855712qtv.5;
        Tue, 08 Nov 2022 07:38:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1z+a2J7Rl+GyLpkq46imOOD0yWvTx4mqso+OFzooPY=;
        b=1mTqDMnmb96dDTpkIodXOu9X+Pk/grKsN+VzQGiVkhUZZOQPiwXhPK3S3KXq3Ic30U
         LXE3RYSRFbVmIqTl1Lt40mlEyarZQlrsmAa65mrodaNyokg1ZixBLlzX0RTYq/yhzBY0
         sqG5zuNlXhqtJibhxno0Plhn7tgpCr3iFLTQb7z/6CUbxers2WkcU3Sz7bm4KfGa9NFJ
         Ah0XSVtE9TisTQJB0rpvhQUieAABfyfdM/QNm7FiIgLQg97te7+Da+aSX/yz9MgTmEbP
         GdSGISp2TMCRrhwchQXRirupVs5ZP/h73N/YdwP3J6faz51eMH62AQikJgwn1R1ObxI4
         z7Yg==
X-Gm-Message-State: ACrzQf0zl7VJfFaHCsS98gC+b+dXNqkkRCChn75FOm266S0ZtxZ0IYSl
        gBDgZxQsWrk65DDwMG9vmAMhr8clEkzz+9HS
X-Google-Smtp-Source: AMsMyM4uyTbfjxwhaBma4SAODuQ7cjGmK32pMHXXk5PPI5AHfj9hLyZh1O0xdOfjkWfA777ojCh2zg==
X-Received: by 2002:ac8:6a18:0:b0:3a5:49fb:2365 with SMTP id t24-20020ac86a18000000b003a549fb2365mr25772988qtr.587.1667921882522;
        Tue, 08 Nov 2022 07:38:02 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id f1-20020a05620a408100b006fa4a81e895sm9498087qko.67.2022.11.08.07.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 07:38:01 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-36a4b86a0abso137141317b3.7;
        Tue, 08 Nov 2022 07:38:01 -0800 (PST)
X-Received: by 2002:a81:12c8:0:b0:36a:bd6b:92fb with SMTP id
 191-20020a8112c8000000b0036abd6b92fbmr51884942yws.316.1667921881301; Tue, 08
 Nov 2022 07:38:01 -0800 (PST)
MIME-Version: 1.0
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221028165921.94487-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221028165921.94487-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Nov 2022 16:37:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVFnCDz2FaH6hCxADBgrzkcCC8ASh2qDXbkcJq4=B1UUQ@mail.gmail.com>
Message-ID: <CAMuHMdVFnCDz2FaH6hCxADBgrzkcCC8ASh2qDXbkcJq4=B1UUQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] riscv: Kconfig.socs: Add ARCH_RENESAS kconfig option
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
> Add ARCH_RENESAS config option to allow selecting the Renesas RISC-V SoCs.
> We currently have the newly added RZ/Five (R9A07G043) RISC-V based SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> v4 -> v5
> * Sorted as per SoC name
> * Included RB tag from Conor

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
