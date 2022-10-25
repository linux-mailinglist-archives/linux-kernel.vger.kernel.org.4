Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CBD60C465
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 08:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiJYG5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 02:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiJYG52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 02:57:28 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087E162C3;
        Mon, 24 Oct 2022 23:57:26 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id w3so6979576qtv.9;
        Mon, 24 Oct 2022 23:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3QYintIKLSO/5/dPNaNKqiylY6TQ4PQK7lYP/tlZYSw=;
        b=IELxruD5ijyoHHjG0ysg8Cru3TMpzNoRDagQq3xYVFiZ15Uzi76LYtl94KVL6QYOtn
         fiEassSflgAMuZVnAlY6jnpEW6XHNF6Zm2QGqQONsU6o8jj/3A9pCHuDMmcjhSs/0jiy
         /wjyNX+acELrfIrzrvlYo/Xl/cJjK8w847kq9mHQ7WyOTNvx2SOn5Kuv+Tetg5KAEn3n
         2I5ihMfpwGDRmmwDZEOnJ4PoWHwpt9hdXJTJ63PXPCOs/nogtkjxeP2Vp6eLdlOOpH75
         uMiw3rMwTo3p+a7P50i374thEllvRS//8FHpdHkQaPWNv4mveoSNKoCIzki0Yz9LI/hl
         U0aA==
X-Gm-Message-State: ACrzQf0oped5oIKvoBV/n072oFJ6u8x8Omz1AJPWPjTByVua4hcfl/YI
        3QGokIn1P13WTrum/qLX8QLw0m52G8BKZg==
X-Google-Smtp-Source: AMsMyM7DXI8LKKrba+CS3zADWP6A05C7Zv2sSIPE5eSjgpzaHMKcgzn7pFXO8KVcYzlZF3w2LNZw6Q==
X-Received: by 2002:ac8:7e96:0:b0:39c:d833:e8c3 with SMTP id w22-20020ac87e96000000b0039cd833e8c3mr30699526qtj.303.1666681044738;
        Mon, 24 Oct 2022 23:57:24 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id bi24-20020a05620a319800b006eeca296c00sm1548652qkb.104.2022.10.24.23.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 23:57:24 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id f205so13544456yba.2;
        Mon, 24 Oct 2022 23:57:23 -0700 (PDT)
X-Received: by 2002:a25:26c1:0:b0:6c3:bdae:c6d6 with SMTP id
 m184-20020a2526c1000000b006c3bdaec6d6mr34190989ybm.36.1666681043700; Mon, 24
 Oct 2022 23:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20221024173434.32518-1-afd@ti.com> <20221024173434.32518-8-afd@ti.com>
In-Reply-To: <20221024173434.32518-8-afd@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Oct 2022 08:57:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWrL1U7qOM+qOCa6-YhdJEe_5bCCDnXp_Fx3_6eDgkkSA@mail.gmail.com>
Message-ID: <CAMuHMdWrL1U7qOM+qOCa6-YhdJEe_5bCCDnXp_Fx3_6eDgkkSA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] staging: pi433: overlay: Rename overlay source
 file from .dts to .dtso
To:     Andrew Davis <afd@ti.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 7:34 PM Andrew Davis <afd@ti.com> wrote:
> DTB Overlays (.dtbo) can now be built from source files with the
> extension (.dtso). This makes it clear what is the content of the files
> and differentiates them from base DTB source files.
>
> Rename the pi433-overlay.dts file to pi433-overlay.dtso and update
> the information file pi433.txt for the same.
>
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
