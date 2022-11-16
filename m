Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978D162B613
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiKPJJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238740AbiKPJJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:09:23 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BE4240AD;
        Wed, 16 Nov 2022 01:08:48 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id jr19so10295778qtb.7;
        Wed, 16 Nov 2022 01:08:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FIWXjhE2AkSBl2f/+niXCfGWT7FJ5HFVL2ihSjlnu8U=;
        b=gmNAT8kiXUJDyFo+E6XUA1D+sWqpXOfJapJQOrf6CajLk589JNaqXpFwtlIDF5+AQ9
         YdfGApXgE8J/3uuc9r3pcrLmZgKN1XJJ7FDTipn6+hluaCk47FT/xMxhZUtpX+L4Hczw
         YA8Wd5h5TIDF0SZuCfIeS5VNQffL6MDtORDW5SN7iozz4pVTuK07Zma0HbouLCMI3ADy
         DcaVkVY5d645lPYo6YF5IQwox2gusPg04A3AxGEhiugluaCHDAJwf/2F1LbAHnTKcefl
         rxyRVFPzNVjoZOdHabV85feeqy8dt6TUS9ueVpUnP6u6aaVpuTuOr/v8+qUTqt5bPoff
         1efg==
X-Gm-Message-State: ANoB5pmWBrt+DwKU3OTn+TuFNFecraJENu2BbF6zYIPX9HjcneDUymFV
        GAFEpV0GIi0hgmPmAJ7SIOKk3CtTmkb6Pw==
X-Google-Smtp-Source: AA0mqf64Nt6DWu4X3OX2wq9Sx0TokKICsU4Jmj+10vB5fmMLv4PQuNTKhUIdjuj2jeo0vGG1632Dvw==
X-Received: by 2002:a05:622a:4a16:b0:3a5:cb82:109b with SMTP id fv22-20020a05622a4a1600b003a5cb82109bmr20308440qtb.61.1668589727044;
        Wed, 16 Nov 2022 01:08:47 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id i10-20020ac8488a000000b0039492d503cdsm8401165qtq.51.2022.11.16.01.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 01:08:46 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-367b8adf788so161795857b3.2;
        Wed, 16 Nov 2022 01:08:46 -0800 (PST)
X-Received: by 2002:a81:1c52:0:b0:357:66a5:bb25 with SMTP id
 c79-20020a811c52000000b0035766a5bb25mr21236225ywc.383.1668589725887; Wed, 16
 Nov 2022 01:08:45 -0800 (PST)
MIME-Version: 1.0
References: <20221115105135.1180490-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221115105135.1180490-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221115105135.1180490-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Nov 2022 10:08:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXhn6UT+SnQsVOy52NJ9f+W_zuEBB-Yh9qVK4kxrVdbOw@mail.gmail.com>
Message-ID: <CAMuHMdXhn6UT+SnQsVOy52NJ9f+W_zuEBB-Yh9qVK4kxrVdbOw@mail.gmail.com>
Subject: Re: [PATCH 3/3] riscv: dts: renesas: rzfive-smarc: Enable CANFD/I2C
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 11:57 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Enable CANFD and I2C on RZ/Five SMARC EVK.
>
> Note, these blocks are enabled in RZ/G2UL SMARC EVK DTSI [0] hence
> deleting these disabled nodes from RZ/Five SMARC EVK DTSI enables them
> here too as we include [0] in RZ/Five SMARC EVK DTSI.
>
> [0] arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.2, with the other DTS patch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
