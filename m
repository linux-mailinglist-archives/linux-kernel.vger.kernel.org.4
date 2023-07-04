Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655D4746CDD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjGDJGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjGDJGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:06:33 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73BBE6A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 02:06:23 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-c2cf29195f8so6161163276.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 02:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688461583; x=1691053583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIuWZEGgMW0VK0vVhbw2Bf+59fU550xPb71Z8niZj2A=;
        b=Ox1brr2QAg9qQ4DeO4nAvy2jeLw+bO/sQm+9wK5qCAkNoUFlvc9IgrDctkI1cr7ycV
         SsIvtHUTwuv7Z+IQWsW0xtFYDdOGimj0cxsihgvZfX0Dy8WfrgoWbu7khCglFUkfBko3
         ojbKhme8ifWpKeWHmKYixAzcmNcgiGYLADvGSAqdh/lb+CA3LbOhp3DEzwauEMidsbP3
         RGN7JEcHgPu/4YH4dd7vBkSIXK3JBcCFfRIW3IxuFGJ3xRktsa4UxWW9gk+9T30cDLT5
         /F410hbUiT8oTB8zFMnhuIYh85Bazd1x6meaSDTKSeewYRuiJxGFWalFBP7tYjjfRbxW
         75Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688461583; x=1691053583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIuWZEGgMW0VK0vVhbw2Bf+59fU550xPb71Z8niZj2A=;
        b=goI+wqjIOa8kKJy3Vb9PAjhWhsAZjX1RV5gnkPZ6CL+z2jp49r5R2Phy7T9DaC36x7
         6J7eKBkV4MqOezZ/wSm6nt6q+SA+Kh9mRyfNk/+Wss8zGvZteCJSvkjv2++c+gDxAmfh
         DWKpjLj81JzYU59DPDoBqe7Sh/0B7a/Nga/6R/LfFXqHLnRUVAz3Yss4fcmyutskIXPe
         zXvZz7ori4CBomIn7ipVE+vL/FTxx5MeUjppMMZkYcRVWgNq+0KVr0FMb56/C8k7H9VM
         qPVgmwxhOkvi7+ffrtha2VfRmgb2ryEfBjjJ6Zf+TxVE+YJiJvxiZMB3ORA/+orMCsSl
         rnCw==
X-Gm-Message-State: ABy/qLbQYn33s4xjuuuGGhahrrWDLcewiXl1ZKC2D2UgezoMYnSK+ter
        elnocC8i4GlYZ5d/+s3NbVVCShUOkNwUdFv9WEaG1aw2XuMlgnwO
X-Google-Smtp-Source: APBJJlHKafPKATG2fxQGQnR8ve35D79qYeeo/vlvmO6ubItM2zG9aRLyLfVT0dQKXhkrl/ZmPsTeNzC/RPoe+svyzMk=
X-Received: by 2002:a25:b296:0:b0:bac:7294:4faf with SMTP id
 k22-20020a25b296000000b00bac72944fafmr13160731ybj.27.1688461582951; Tue, 04
 Jul 2023 02:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <607bd6ab4905b0b1b119a06ef953fa1184505777.1688396717.git.geert+renesas@glider.be>
In-Reply-To: <607bd6ab4905b0b1b119a06ef953fa1184505777.1688396717.git.geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Jul 2023 11:06:11 +0200
Message-ID: <CACRpkdagL4h+UMVds51j-_i9cRgsJsM8Kq_hhzw=MiYsFvfPaA@mail.gmail.com>
Subject: Re: [PATCH/RFT] pinctrl: renesas: rzv2m: Handle non-unique subnode names
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023 at 5:07=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The eMMC and SDHI pin control configuration nodes in DT have subnodes
> with the same names ("data" and "ctrl").  As the RZ/V2M pin control
> driver considers only the names of the subnodes, this leads to
> conflicts:
>
>     pinctrl-rzv2m b6250000.pinctrl: pin P8_2 already requested by 8500000=
0.mmc; cannot claim for 85020000.mmc
>     pinctrl-rzv2m b6250000.pinctrl: pin-130 (85020000.mmc) status -22
>     renesas_sdhi_internal_dmac 85020000.mmc: Error applying setting, reve=
rse things back
>
> Fix this by constructing unique names from the node names of both the
> pin control configuration node and its child node, where appropriate.
>
> Reported by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Fixes: 92a9b825257614af ("pinctrl: renesas: Add RZ/V2M pin and gpio contr=
oller driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Untested on real hardware.
> The RZ/G2L pin control drivers needs a similar fix.

If I need to merge this for fixes it's be great if we could also
include a fix for RX/G2L.

Anyway, I expect a pull request for renesas fixes or some explicit
instruction on
what to do when it's tested and confirmed working.

Yours,
Linus Walleij
