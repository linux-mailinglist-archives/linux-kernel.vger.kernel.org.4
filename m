Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CFE6B6AEE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjCLUJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjCLUJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:09:15 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4B21350C;
        Sun, 12 Mar 2023 13:08:48 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id v196so2431388ybe.9;
        Sun, 12 Mar 2023 13:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678651727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mmi+J++OGCebvXG2OuteACsXG7VG8WEMmH0VAhRv8oA=;
        b=qSqjIZy125h3FNoRcrriOFeNadFlctDcytOGs+PrwpqMpRKmZZgQQcobiIcwzcmcUe
         oNeZLvnbL7M7wddMHg3nedL2yHXhT3/Fi+f5/X/yCxPtszsPbJo5ffbGgRq06/C/gJNg
         w9ZxFvYKON/0jDT0k2UB9gMj3+sSkSAVfwXZiG3+BYWFy2QqVMtsEkBZZOMx/ml1UsZy
         8VZDUiduKT52X1hvS8BNtVAUtWUGAb7W5yw8UKeb0i493JF/CzHgo7P6GUi7Ql+Pkhh5
         mMQuJgXmWSHF+v4AkkkRXxVA4ihmcbkTSy27mwjOlAvHnTkG04eqLvITKYU7EXwo/JKt
         m5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678651727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mmi+J++OGCebvXG2OuteACsXG7VG8WEMmH0VAhRv8oA=;
        b=skY4Gm654uWp56U6hjgOGDZFfcbEGGVqhsSTZkNyvJVkpZik7DNI32xMXnt+OTaibL
         z/V6Ya3epp942Yu/Um3dxV7wNKloYPj8bmmnEihL97miiZhQ+CjwsnLFi+JMvRL25LRL
         3ZpJSH6/6MYjL+jBu8C3VSDrX5NgJlN9zYuQAj1TomRkvRf8rhzWLu7eIBE6fl6Y1ZFZ
         XHT+f4vhhxVBmHySOtEiA+uOxMDRfGC6CRiWiKmGCFzO3p4Cc7unZFM4WKdRNzs2BZjG
         2grEzSPtGYNSLDO6x5CZpeaXr2xkIkKozBRm5NaNnyC7/k6kOYp3zEIDTd7z/RT5OVcI
         sh+g==
X-Gm-Message-State: AO0yUKXUMVVUsfT6/vofj+2CPHkTkMgoEkfhmdSSnhmhQep+VDTjiXrz
        qs5kLsfc1pWHkg4pxSWQoFX7nNPZF+DkGjlpQxs=
X-Google-Smtp-Source: AK7set+6kHalpwaiIcd3v7fpFSrd6c7dAP8piuDmYsjqoY/hPg2fu8i7tGskRB1bAa2poI7EYmOdjFdiPyRigEoQq24=
X-Received: by 2002:a25:9109:0:b0:b13:7a6:f462 with SMTP id
 v9-20020a259109000000b00b1307a6f462mr5610638ybl.3.1678651726777; Sun, 12 Mar
 2023 13:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230217185225.43310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230217185225.43310-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdU=mCAWQNFCkkCxBkDyYTLM87QdrYMYE9hpOv1fuS=bWw@mail.gmail.com>
In-Reply-To: <CAMuHMdU=mCAWQNFCkkCxBkDyYTLM87QdrYMYE9hpOv1fuS=bWw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sun, 12 Mar 2023 20:08:20 +0000
Message-ID: <CA+V-a8u4ovdBjdijGCJ3cfoQ-p=G55YwNCY-14DVfsLjCeVGcQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: renesas: r9a07g044: Update IRQ numbers
 for SSI channels
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Fri, Mar 10, 2023 at 12:05=E2=80=AFPM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Fri, Feb 17, 2023 at 7:53=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail=
.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > From R01UH0914EJ0120 Rev.1.20 HW manual the interrupt numbers for SSI
> > channels have been updated,
> >
> > SPI 329 - SSIF0 is now marked as reserved
> > SPI 333 - SSIF1 is now marked as reserved
> > SPI 335 - SSIF2 is now marked as reserved
> > SPI 336 - SSIF2 is now marked as reserved
> > SPI 341 - SSIF3 is now marked as reserved
> >
> > This patch drops the above IRQs from SoC DTSI.
> >
> > Fixes: 92a341315afc9 ("arm64: dts: renesas: r9a07g044: Add SSI support"=
)
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v6.4.
>
> > As this is is a fixes patch and we are still waiting for [0] to be merg=
ed
> > shall do the same for V2L SoC?
> >
> > [0] https://patchwork.kernel.org/project/linux-renesas-soc/cover/202301=
31223529.11905-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>
> No need to send, I cloned the above with
>     s/G2L/V2L/
>     s/g044/g054/
>     s/G044/G054/
>     s/R01UH0914EJ0120/R01UH0936EJ0120/
>
> and
> Fixes: cd0339ec25895c0b ("arm64: dts: renesas: r9a07g054: Add
> SSI{1,2,3} nodes and fillup the SSI0 stub node")
>
Thank you for taking care of this.

Cheers,
Prabhakar
