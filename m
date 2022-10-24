Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F5F60B187
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbiJXQ1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbiJXQ0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:26:30 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726041146A;
        Mon, 24 Oct 2022 08:13:05 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q9-20020a17090a178900b00212fe7c6bbeso3318031pja.4;
        Mon, 24 Oct 2022 08:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sgFso1FaRAWQJ83kT84q4SS+gpbh+wtZ0NmrEVRj1YY=;
        b=JEeYA3H21scMHN91lpqzdCc2WEyA7QBLvMBPU54OSb8+D3/TrbzghnO+nf3DP4kSwk
         top+O1KROKOqjOgfiiabZ1HMZdQw9hxvyc46rHdNfkMaydPQBDvyfLI2f2ox4HAR9Vo4
         3qvkWGSmMq6hF0NM7t3PLsoMA57/V/KcbT5by7r5WTJWfkGkzvzRz60GFU/E1BXMKNeu
         9yXLERg0b1k6LB91F7HBLY8ig8A8ZFWA9GWUjYBtxTwiZ4q+ge9WeL1qECOdjdjJkzhc
         EmOtDtw9yGYLJNjNA9mzYvl2cylOGR0Gk8d0w70TURCTw5HcWdJ7JSXR5mehLP+X7UoS
         seIw==
X-Gm-Message-State: ACrzQf0HIPIVFQX0IeigGwiHD4BKdrSLNJTYThouyDgrmCt3eE+2IgtC
        kBZcl0wWE0oYmratV3fq1s/6gbAzeWrb7A==
X-Google-Smtp-Source: AMsMyM7kV5I1xzy3WptmBGmtY5SIvtzh+zDKIMpSuQGpTci8zxKxtKKmQFNzFDiSCDHAyut8AiTibg==
X-Received: by 2002:a0c:8d4b:0:b0:4bb:798f:5251 with SMTP id s11-20020a0c8d4b000000b004bb798f5251mr1900924qvb.51.1666613360740;
        Mon, 24 Oct 2022 05:09:20 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id z15-20020a05622a124f00b0039a08c0a594sm12631508qtx.82.2022.10.24.05.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:09:20 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 63so10776097ybq.4;
        Mon, 24 Oct 2022 05:09:19 -0700 (PDT)
X-Received: by 2002:a25:687:0:b0:6c2:2b0c:26e with SMTP id 129-20020a250687000000b006c22b0c026emr28296908ybg.202.1666613359730;
 Mon, 24 Oct 2022 05:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221023182437.15263-1-afd@ti.com> <20221023182437.15263-4-afd@ti.com>
In-Reply-To: <20221023182437.15263-4-afd@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Oct 2022 14:09:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW+31HbDvKORyiNFXOGh5dyYYTM2fcpEJEnuMD8ANA5Cw@mail.gmail.com>
Message-ID: <CAMuHMdW+31HbDvKORyiNFXOGh5dyYYTM2fcpEJEnuMD8ANA5Cw@mail.gmail.com>
Subject: Re: [PATCH 3/6] of: overlay: rename overlay source files from .dts to .dtso
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 8:25 PM Andrew Davis <afd@ti.com> wrote:
> From: Frank Rowand <frank.rowand@sony.com>
>
> In drivers/of/unittest-data/:
>    - Rename .dts overlay source files to use .dtso suffix.
>
> Modify driver/of/unitest.c to use .dtbo.o based symbols instead of .dtb.o
>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
