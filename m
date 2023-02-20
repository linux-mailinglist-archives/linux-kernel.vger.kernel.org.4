Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2970969C65F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 09:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjBTIQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 03:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBTIQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 03:16:06 -0500
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570D411EAC;
        Mon, 20 Feb 2023 00:16:03 -0800 (PST)
Received: by mail-qv1-f51.google.com with SMTP id nv15so439034qvb.7;
        Mon, 20 Feb 2023 00:16:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GhdeujqRrZ30kHbfp+IOG4sWxnU1RJIBCIHIcK/nUfw=;
        b=mAch6/WxRQr30734M+PlFZ3k0wulvkDnwQFLSC2jlmX2e0I00OYTTeuTaDdFeudzwa
         W1FE72smK4l+pfFctloub379nzNQX7xOPOD03B7pepH7VIAhE4DfWz1Nq1aIACD4xTdr
         unp4WR5Kqv4kp1lTg3jz44FCX5nLihaEMQGDMFYzxz4ZLHkvmvObpL5T7oEXDIivT73+
         JGUnvhOGQURx7uPFENLmVya8acElpg7gkzieam+GYJMFqzJLQ6uJoMrijFk7VjQjrhTI
         HKYVVTV19ndXCD5mEETfSiloREGLA6wBErEKsEFDB8bDDkcQCChVDJlyBhW+x3rV6tpE
         QM3g==
X-Gm-Message-State: AO0yUKU6stAy/L/RDACa6xO4YDKSG83EkVjOkL62Zf+MaopmMSLyn3by
        5sWxehk4LyRTPDfzIXg/AXRk27kT7H5oRw==
X-Google-Smtp-Source: AK7set+AaLu2GD+WsctcxcZEACYu/N/F6+7DGzFBzKu5gbg3+yDzec078nZ56mhtr560D7zesC6aIA==
X-Received: by 2002:a05:6214:2a86:b0:56f:5466:20d8 with SMTP id jr6-20020a0562142a8600b0056f546620d8mr801341qvb.3.1676880961801;
        Mon, 20 Feb 2023 00:16:01 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id q188-20020a378ec5000000b0073d82a8113bsm3510028qkd.126.2023.02.20.00.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 00:16:01 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id v78so392255ybe.3;
        Mon, 20 Feb 2023 00:16:01 -0800 (PST)
X-Received: by 2002:a5b:f06:0:b0:95e:613:ca4c with SMTP id x6-20020a5b0f06000000b0095e0613ca4cmr125776ybr.12.1676880960980;
 Mon, 20 Feb 2023 00:16:00 -0800 (PST)
MIME-Version: 1.0
References: <20230217185225.43310-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230217185225.43310-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230217185225.43310-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Feb 2023 09:15:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVW-rBR43QCuaBDJD407wUUZ4=nJP_+UvXUrJ4+BsXRbA@mail.gmail.com>
Message-ID: <CAMuHMdVW-rBR43QCuaBDJD407wUUZ4=nJP_+UvXUrJ4+BsXRbA@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: renesas: r9a07g044: Update IRQ numbers
 for SSI channels
To:     Prabhakar <prabhakar.csengg@gmail.com>
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

On Fri, Feb 17, 2023 at 7:53 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> From R01UH0914EJ0120 Rev.1.20 HW manual the interrupt numbers for SSI
> channels have been updated,
>
> SPI 329 - SSIF0 is now marked as reserved
> SPI 333 - SSIF1 is now marked as reserved
> SPI 335 - SSIF2 is now marked as reserved
> SPI 336 - SSIF2 is now marked as reserved
> SPI 341 - SSIF3 is now marked as reserved
>
> This patch drops the above IRQs from SoC DTSI.
>
> Fixes: 92a341315afc9 ("arm64: dts: renesas: r9a07g044: Add SSI support")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> Hi Geert,
>
> As this is is a fixes patch and we are still waiting for [0] to be merged
> shall do the same for V2L SoC?

Yes please. Thank you!

> [0] https://patchwork.kernel.org/project/linux-renesas-soc/cover/20230131223529.11905-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
