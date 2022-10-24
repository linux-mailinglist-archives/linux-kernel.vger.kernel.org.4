Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B7A60A8D6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 15:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbiJXNLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 09:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbiJXNJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 09:09:10 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0C2A0249;
        Mon, 24 Oct 2022 05:22:31 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id a5so5915231qkl.6;
        Mon, 24 Oct 2022 05:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgmDg2ARLgo0WshQ+wzSuhO5OWLg+Wj7tJFGuvTdLnc=;
        b=eiKGrkXAPibHikZYc8djUb7jtoM27ZGLyL324qyJ5kKfaBANVnUMfT8a+IvITYOuVq
         JLFyK72+92etrW/cf+svlm4kKYG582IddZFBEj+kf89jdYMvA1/MPSApspgln9gVJcce
         fS0g5LaHSDq1eNhM8itjBgI0FiNW20NG/S169oCvabHRbkmsB1YZ63npIFSnTFy0+2bp
         nqmNubsht5sTSnEbpoRvL3gpi1+u7cdF4jb866UcK9UJ8bx2lYanrhN9c8cbYJHpJwPH
         n5VcCcBtcOxMfrHE5o0o4Mf3XSiYK4yckoG71/znqgZ4AeOqHSf5rgc7XmA45Gc8m1j0
         MctQ==
X-Gm-Message-State: ACrzQf0Ep/X9p6NF0nKpYu437WcFwpPf8pkMgXj/243NBKTCJ821EFxE
        zrejkmIIArcr+RSnilL4lgzMkiJPFn3aFw==
X-Google-Smtp-Source: AMsMyM49b/uRzLSPPQVjsi6KXKRex7YytWf0U+TIvA/Yg2BUbdexUTb7+xWRNRm21Shq8Adg9mB4Iw==
X-Received: by 2002:ae9:e315:0:b0:6ee:761d:4b8b with SMTP id v21-20020ae9e315000000b006ee761d4b8bmr22501454qkf.748.1666613977070;
        Mon, 24 Oct 2022 05:19:37 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id w18-20020a05620a425200b006eeb25369e9sm15078483qko.25.2022.10.24.05.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:19:35 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id o70so10789336yba.7;
        Mon, 24 Oct 2022 05:19:35 -0700 (PDT)
X-Received: by 2002:a25:2:0:b0:6c4:dc1:d37c with SMTP id 2-20020a250002000000b006c40dc1d37cmr27042715yba.380.1666613974849;
 Mon, 24 Oct 2022 05:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221023182437.15263-1-afd@ti.com> <20221023182437.15263-5-afd@ti.com>
In-Reply-To: <20221023182437.15263-5-afd@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Oct 2022 14:19:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVLfmyWDRU0jhn-F4odWnBWkfkJrLrg_atMnXAwz3Pwpg@mail.gmail.com>
Message-ID: <CAMuHMdVLfmyWDRU0jhn-F4odWnBWkfkJrLrg_atMnXAwz3Pwpg@mail.gmail.com>
Subject: Re: [PATCH 4/6] arm64: dts: freescale: Rename DTB overlay source
 files from .dts to .dtso
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

Hi Andrew,

Thanks for your patch!

On Sun, Oct 23, 2022 at 8:24 PM Andrew Davis <afd@ti.com> wrote:
> DTB Overlays (.dtbo) can now be built from source files with the
> extension (.dtso). This makes it clear the content of the file

... clear what is .. files?

> and differentiates them from base DTB source files.
>
> Convert the DTB overlay source files in the arm64/freescale directory.
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
