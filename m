Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44544662706
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236855AbjAIN3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbjAIN2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:28:35 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191A78FE2;
        Mon,  9 Jan 2023 05:28:35 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id v14so7780683qtq.3;
        Mon, 09 Jan 2023 05:28:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tNPWeAzlRFUhQDC+UGHF6x7r2OGa8Y3G0j9qoaAmJCY=;
        b=afygxGte1bioWpjX3Evh5e4JDINoRU50j6Bx5w4OLErxiNG0OrVMjwO1khEu2hu/zs
         HcWTywyTS3q1cBQV97NyHms7yVxw3WzGVhkOsTP8AIOtik/8Xf4uAvh09sGoJaOGhlBk
         1uaCitcT99GbvpZMg9/bI22AgWFljNE/hSs224jdqmwMhGatT67IlZt/gH59eLXnSuTa
         lqrkJJ4McisSzFONCwdFJ4ARrM0MC4HUjVCQiqGg3+SJ37uGR5XXu1ARpgLD8sLt1sux
         PNE+LinxYKKtyjI1I8Nja9kiS5IuDMpegQ5cvdvdnFRcCPXkExuwkX8exRDbLkuKLtkk
         rbrA==
X-Gm-Message-State: AFqh2krmox0ot9vYHFlZ8OjNT6t7poPwOXFyMEqJb+lz/T5t78tatxtu
        WnqG2UDZYluBJrZHt6arCczW7Y/oSv7lzQ==
X-Google-Smtp-Source: AMrXdXupbhzpiPXjIRIkJisaOIKFg0QEny/Ej9INUT9AZZz6Rt3JAIbOKwePJr97choTy+qW6g/cew==
X-Received: by 2002:a05:622a:6108:b0:3ab:97cc:6ed6 with SMTP id hg8-20020a05622a610800b003ab97cc6ed6mr61126333qtb.48.1673270914047;
        Mon, 09 Jan 2023 05:28:34 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id m5-20020ac86885000000b0039cba52974fsm4565788qtq.94.2023.01.09.05.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 05:28:33 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id c124so8451154ybb.13;
        Mon, 09 Jan 2023 05:28:33 -0800 (PST)
X-Received: by 2002:a25:3143:0:b0:77a:b5f3:d0ac with SMTP id
 x64-20020a253143000000b0077ab5f3d0acmr4418010ybx.202.1673270913184; Mon, 09
 Jan 2023 05:28:33 -0800 (PST)
MIME-Version: 1.0
References: <20221213230129.549968-1-fabrizio.castro.jz@renesas.com> <20221213230129.549968-5-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20221213230129.549968-5-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Jan 2023 14:28:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUrAF7CRGSirfZE+aKB9dmWe9mjZoUJW3yRNu1dSuhFig@mail.gmail.com>
Message-ID: <CAMuHMdUrAF7CRGSirfZE+aKB9dmWe9mjZoUJW3yRNu1dSuhFig@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: renesas: r9a09g011: Add eMMC and SDHI support
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
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

Hi Fabrizio,

On Wed, Dec 14, 2022 at 12:02 AM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> The RZ/V2M comes with 2 SDHI interfaces and 1 eMMC interface.
> Add the relevant nodes to the SoC specific device tree.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.3.

Note that this causes "make dtbs_check" failures, due to a bug in
the bindings. I have sent a fix.
https://lore.kernel.org/054c9f4dbb0bb1525f780d1e85c724436465c20c.1673270716.git.geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
