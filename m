Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9F473CC89
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 21:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbjFXTMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 15:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjFXTMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 15:12:05 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D44194
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 12:12:02 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-c01e1c0402cso1255103276.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 12:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687633922; x=1690225922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtWxvzR4uTKbUwOB1AIsZeFNL0PNxlG/EmtMr5TnJiQ=;
        b=wt32RpXDMbDbbikjXhaLI9xRb4hmK9Oh+EQ+2Xr1WE5YrCH4BTvYkIgThJcsmPk2MS
         PGgJVna75bQdhLdETfmjHL0l9NePlSH0a2mAelTpO4afxsLohqkG/GbyimZvtxLQjI2D
         VmSkyAMPkXMj+GYPzDLluwFhp3a2I6vdXO8IIHQmCfPnWua5P3X+UbSIqWYY/JYc7kCX
         ON++MCEn1oik/Un7U/ClrK49WMMVvpj5ISww7V+HuYqaZS5TUUNq/ed7pbbidKzDlejy
         PkZWWz/YMnQ+IfGKULB0QNBXbWzs0OPmTGJSB1n9k+lMm6FK3hsSV74YZtUHmm9KU4aI
         Ffvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687633922; x=1690225922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NtWxvzR4uTKbUwOB1AIsZeFNL0PNxlG/EmtMr5TnJiQ=;
        b=LOKbuqb4AiM1Oec4O0k9HZPitxxWtfCeYBbD6Gao6KtyQ01uTZD0C+yyUmBvNqaVn9
         rIxNwcDvHT354iaP+TcK6NwW0vM22DDa0WrnfLG6LqWm4KM9U5i5fsQzzyh5HrNaeLDA
         Y4k+Yv4v2vt1OE+/SYJ0q/igTxNWVWtHXzldNXH6fNBbHv8xtboH4Ui5ZfLVN4LT819t
         HCxZ37aMeRQG6sU+YLyRIR2sGe9outvot38Gs5yvriaJa6qPvohSJICkOxjDbk4K0Scb
         3jIPxPcfLfNRrGdVMX9ib1E2Me2Kd5J8hvQrBj+ayfeDc1CfDPxecB7qFBRyx7FTpo6d
         PZig==
X-Gm-Message-State: AC+VfDzdo0r3xPuuT8oaxZpiGBrSwwt/yo6dP+0mcuGUeRFLe4W1ra5N
        YUAHOCQxK4vkG+6w2kknKlL/skHgR5OYBrzx8aD9kw==
X-Google-Smtp-Source: ACHHUZ4Fxc3tNghyeBZz8mFIClfbkSqctAt/Q+uSfLRzdZmNIXLLgOsC3Q32jk+9huyth6+cT/C5h/htReBze+JOqRc=
X-Received: by 2002:a25:6d45:0:b0:bc6:8015:1dc8 with SMTP id
 i66-20020a256d45000000b00bc680151dc8mr15218355ybc.33.1687633920950; Sat, 24
 Jun 2023 12:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230623080135.15696-1-fabrizio.castro.jz@renesas.com> <CAMuHMdVNG_LENbU_nu-W+x_snXxbz3vbs=Yb-__FF3DBR2JEUA@mail.gmail.com>
In-Reply-To: <CAMuHMdVNG_LENbU_nu-W+x_snXxbz3vbs=Yb-__FF3DBR2JEUA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 24 Jun 2023 21:11:49 +0200
Message-ID: <CACRpkdavQ1X29LyZscvdkBOS53H5sdYhZbKhWL9fpdghiddCTw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: rzv2mevk2: Fix eMMC/SDHI pinctrl names
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
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

On Fri, Jun 23, 2023 at 10:40=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, Jun 23, 2023 at 10:01=E2=80=AFAM Fabrizio Castro
> <fabrizio.castro.jz@renesas.com> wrote:

> > the below issue:
> >
> > pinctrl-rzv2m b6250000.pinctrl: pin P8_2 already requested by 85000000.=
mmc; cannot claim for 85020000.mmc
> > pinctrl-rzv2m b6250000.pinctrl: pin-130 (85020000.mmc) status -22
> > renesas_sdhi_internal_dmac 85020000.mmc: Error applying setting, revers=
e things back
>
> To me, that sounds like a bug in the pinctrl core.
> Or am I missing something?

The pin control core tracks on a per-pin basis, it has no clue about
the name of certain dt nodes.

This bug would be in the DT parsing code for the different states
I think, and rzv2m is not using the core helpers for this but
rather rzv2m_dt_subnode_to_map() etc.

Yours,
Linus Walleij
