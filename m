Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50A56192F2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 09:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiKDIqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 04:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKDIqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 04:46:31 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE9ED2D1;
        Fri,  4 Nov 2022 01:46:30 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id x15so2655311qtv.9;
        Fri, 04 Nov 2022 01:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FRsJmJJ3TCqkJyXDCVj80Nqy5R/Sc/EQh4ophnlNiFI=;
        b=CdiUtilYSIuQoxj5lb1a0QyGGpD6r3ysaAzQ14bBiA15Si8Ude8Dl7DbTqREjV8npv
         WqsIgA7iVNqLPwypqrrZUfEv22kYG75fnE/dhFWy/BqMZlkbZmor9GX7ZmGyYCfzQODA
         frBVQDcUufaPMyAqRcwqy/GRcjnlISQsDJ5m3Owq/0YIOvc6uZO5h1YdY1wjRuzt7XVv
         cgzd8YqPk60WwBdAjaQvO+/jaMl786fg27Tuvt9nm5tZFq0Khu7trZLWbVBfVCC2vfH1
         na9o1ZC4IRSVhtGCOO+4FguL+cVbDLUGLKnPrSZyiEW1e9Gd+wf57sYQjpd05VLnAscD
         scAA==
X-Gm-Message-State: ACrzQf1SDmaQ8GEgOyxFzTJAvcFSV+A8SbLBL4BwzEdpY3fh+Ni1c7Fz
        g6lBF1agWivLavvECJWGwaU08cU+s1+HjA==
X-Google-Smtp-Source: AMsMyM5Bd8fan+kdTmTqb7rH0pUTNGU55PpiDwsQlLdZdKlH0cLuEBjV2HxmTD+54E/vaZLJEep51g==
X-Received: by 2002:ac8:6998:0:b0:3a5:410a:1a33 with SMTP id o24-20020ac86998000000b003a5410a1a33mr13571709qtq.337.1667551589381;
        Fri, 04 Nov 2022 01:46:29 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id m28-20020a05620a215c00b006ce2c3c48ebsm2460154qkm.77.2022.11.04.01.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 01:46:28 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-333a4a5d495so37474917b3.10;
        Fri, 04 Nov 2022 01:46:28 -0700 (PDT)
X-Received: by 2002:a81:5a57:0:b0:353:6de6:3263 with SMTP id
 o84-20020a815a57000000b003536de63263mr32756712ywb.358.1667551587958; Fri, 04
 Nov 2022 01:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221103230648.53748-1-fabrizio.castro.jz@renesas.com> <20221103230648.53748-2-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20221103230648.53748-2-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Nov 2022 09:46:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW0B2Botp18W7a2XzBZUjs7efxa4Mykg-=MFzhFjmuTDQ@mail.gmail.com>
Message-ID: <CAMuHMdW0B2Botp18W7a2XzBZUjs7efxa4Mykg-=MFzhFjmuTDQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: renesas: r9a09g011: Fix unit address
 format error
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
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 4, 2022 at 12:07 AM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> Although the HW User Manual for RZ/V2M states in the "Address Map"
> section that the interrupt controller is assigned addresses starting
> from 0x82000000, the memory locations from 0x82000000 0x0x8200FFFF
> are marked as reserved in the "Interrupt Controller (GIC)" section
> and are currently not used by the device tree, leading to the below
> warning:
>
> arch/arm64/boot/dts/renesas/r9a09g011.dtsi:51.38-63.5: Warning
> (simple_bus_reg): /soc/interrupt-controller@82000000: simple-bus unit
> address format error, expected "82010000"
>
> Fix the unit address accordingly.
>
> Fixes: fb1929b98f2e ("arm64: dts: renesas: Add initial DTSI for RZ/V2M SoC")
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
