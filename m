Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1C65BBCC0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 11:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiIRJVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 05:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIRJVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 05:21:05 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231ED1D0FD;
        Sun, 18 Sep 2022 02:21:05 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id i3so13995975qkl.3;
        Sun, 18 Sep 2022 02:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6ZrC9E0hc0F9wSlef6D98otfK/intsoP1xPxZaVL8F0=;
        b=Sg9AQKWBbn0q4u8gtpYRoHnLmKhdFpv3Y+XRe8omwvK/2UM/E3IL3fGEroQjvUu7HE
         pOxQV2RPnViSFuZWzSvZHGXUIERlvuet6IbgaOqOi8O3G4myUYrJ2e4QICVlGmVwmRKP
         Z+V4InzVrHwC3dvekXi89GytD7DUZxtMJ6mr6HfcCokbNtztsLUVOcsUySNoSLSB9Aw4
         W9YjxwSgtFjEIAQsNUQ2R2CWAj63n3SvOzLNBXDJCJZJY8fgGrxbuTcrJt5QmWdYqP9/
         S4R8ZFMuTFjLh0CW6tWf60nK6U5IBN3f3J61btSfy9SC/ZkBj50o64ECUHnIJtPATmqi
         vf8A==
X-Gm-Message-State: ACrzQf1L5C0J2muh7kE6TDVPZ65uw4AnWzetaK+flTGoxGwmNQsYbhee
        BgPwb4D26sqborrB1KDbLDXGl1qx0xaUDQ==
X-Google-Smtp-Source: AMsMyM7ej1FGoe4WDYBly6cVRD5Oh19Qhbd1Fl3ReXzl2DjbQpVP5+kPmpPupZ2ylLsjtgjxxVye7w==
X-Received: by 2002:ae9:c217:0:b0:6bc:e9a:f50a with SMTP id j23-20020ae9c217000000b006bc0e9af50amr9683909qkg.588.1663492863887;
        Sun, 18 Sep 2022 02:21:03 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id bn32-20020a05620a2ae000b006b615cd8c13sm10175664qkb.106.2022.09.18.02.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 02:21:03 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id s14so5812164ybe.7;
        Sun, 18 Sep 2022 02:21:03 -0700 (PDT)
X-Received: by 2002:a25:3851:0:b0:6ad:9cba:9708 with SMTP id
 f78-20020a253851000000b006ad9cba9708mr10855819yba.36.1663492863107; Sun, 18
 Sep 2022 02:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220915165256.352843-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220915165256.352843-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220915165256.352843-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 18 Sep 2022 11:20:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVKYqHu-mmviwO5oLS-F8nEg5wynLmy=+tJrQ26=VfV2g@mail.gmail.com>
Message-ID: <CAMuHMdVKYqHu-mmviwO5oLS-F8nEg5wynLmy=+tJrQ26=VfV2g@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: renesas: rzg2ul-smarc: Include SoM DTSI
 into board DTS
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Prabhakar,

On Thu, Sep 15, 2022 at 6:53 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Move including the rzg2ul-smarc-som.dtsi from the carrier board
> rzg2ul-smarc.dtsi to the actual RZ/G2UL SMARC EVK board dts
> r9a07g043u11-smarc.dts. Also move the SW_SW0_DEV_SEL and
> SW_ET0_EN_N macros to board dts as they are used by SoM and carrier
> board DTS/I.
>
> This is in preparation of re-using the SoM and carrier board DTSIs
> for RZ/Five SMARC EVK.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.1.

For consistency, you may want to do the same with rzg2lc-smarc-som.dtsi.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
