Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DC2620BB8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 10:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbiKHJGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 04:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbiKHJGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:06:48 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0EE1D665;
        Tue,  8 Nov 2022 01:06:47 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id hh9so8288482qtb.13;
        Tue, 08 Nov 2022 01:06:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0T8HgYVJ1mNntgjMxG03tZyGh+ROdELpIil7Sk6K/tw=;
        b=iwApCO5lfs638Lh3CHVK6rUJCkdtM2tXAHXcZ0BYye6wEQF5IxATPiEC5nN/8DO6Sk
         v2QtJx76rCtlKTGYCKzVMrzV/3fh7dm1mWY9vASBJRS+/RSYvQU2nJy9CgcPkEj4Rw75
         Gt69s4dt4l90FtiCTTxqRWGnTHhuHfqsFyqJLP+qkfITZ5g9DcS+jli9gcKqJl+8iT6c
         9OZEra35Tfm8xBPNJ4BCwAtYWzxMCPcTdaivgU2xybr/Gv+Pis98lwHVwSDlDgtukc/l
         vX32DNF+ev258O2YZSBaxlkfs3uYPZWx4yPMTeSyjU3JjrqJ3xjsZt20q0+z/A+KvjAk
         AMbA==
X-Gm-Message-State: ACrzQf2GI7opCp1ymSSuXLVmw6v+yByXxu82x23uE6T+xpQkxUQ6v/po
        w36UJYDu3tXklPhMCKMQavDmQmtAx9sCzSvm
X-Google-Smtp-Source: AMsMyM6DYyUgtwSYbOYXQtHoid4iWH8t/FD/0NmWBetrY0hMLADBQPp10+S0PO7/XD3VXv4w5I9r7g==
X-Received: by 2002:a05:622a:1b13:b0:3a5:3ddd:bb72 with SMTP id bb19-20020a05622a1b1300b003a53dddbb72mr812093qtb.75.1667898406580;
        Tue, 08 Nov 2022 01:06:46 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id p67-20020a378d46000000b006a6ebde4799sm8668976qkd.90.2022.11.08.01.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 01:06:46 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id 129so16593761ybb.12;
        Tue, 08 Nov 2022 01:06:45 -0800 (PST)
X-Received: by 2002:a25:4fc2:0:b0:6be:afb4:d392 with SMTP id
 d185-20020a254fc2000000b006beafb4d392mr50004228ybb.604.1667898405719; Tue, 08
 Nov 2022 01:06:45 -0800 (PST)
MIME-Version: 1.0
References: <20221107165027.54150-1-fabrizio.castro.jz@renesas.com> <20221107165027.54150-3-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20221107165027.54150-3-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Nov 2022 10:06:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV=GFcR01_Rxd_u8VXaokbOvqj7kD8o+YOQFy2bG1Qamg@mail.gmail.com>
Message-ID: <CAMuHMdV=GFcR01_Rxd_u8VXaokbOvqj7kD8o+YOQFy2bG1Qamg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: renesas: r9a09g011: Fix I2C SoC
 specific strings
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Wolfram Sang <wsa@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
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

On Mon, Nov 7, 2022 at 5:50 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> The preferred form for Renesas' compatible strings is:
> "<vendor>,<family>-<module>"
>
> Somehow the compatible string for the r9a09g011 I2C IP was upstreamed
> as renesas,i2c-r9a09g011 instead of renesas,r9a09g011-i2c, which
> is really confusing, especially considering the generic fallback
> is renesas,rzv2m-i2c.
>
> The first user of renesas,i2c-r9a09g011 in the kernel is not yet in
> a kernel release, it will be in v6.1, therefore it can still be
> fixed in v6.1.
> Even if we don't fix it before v6.2, I don't think there is any
> harm in making such a change.
>
> s/renesas,i2c-r9a09g011/renesas,r9a09g011-i2c/g for consistency.
>
> Fixes: 54ac6794df9d ("arm64: dts: renesas: r9a09g011: Add i2c nodes")
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
>
> v2 - Improved changelog, as suggested by Geert and Krzysztof

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
