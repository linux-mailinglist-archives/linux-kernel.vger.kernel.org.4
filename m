Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EC360AA0D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 15:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbiJXN2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 09:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236401AbiJXNZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 09:25:39 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2830A9DD84;
        Mon, 24 Oct 2022 05:31:20 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id x13so4892020qvn.6;
        Mon, 24 Oct 2022 05:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNStuAYK228vf5LzbOeaSSraZdrDlZ0Sjhs1zL+VQXA=;
        b=aetePGMNRUTGhTxl+a2+y0oXCuyNsQZtyS/7Eux79lxe3tm6ZG8C5bGNWQboOF62IP
         ZRdKAmn6x2bO6jkPjo4Wa2zzV1z/6ipcBld2PRZwx/Pkw5/6CB157iUy7MUglthnC/ip
         16vQ81X+mP4lFT9cwmfARQ4BcZ3Is0ufPELUIVgtdnxX36/6ccUHgYaYjYDg2ijtMdvr
         VqLg23hfjzgS+vt0ZAYN5V/v2zQSG4xHQ8cmp0V4z07TmpkxmUnFDVs2sRCOd+uTJgie
         np85bDbiwFQC4zACzo8lSkIU8UW7GjhkuRue8Ag24ye0DH4G7XOou3KYovEwLAnUXl3G
         YinQ==
X-Gm-Message-State: ACrzQf2ChBQmGunVGigwko1OYdZzGeirx7N8x99n/KF7bLEta2a+Vq7N
        A98vZ4WN6SD7uebPmOT1NdBIKLDW+Hgs2w==
X-Google-Smtp-Source: AMsMyM5Rrr1o3yktWRbt9a9lsU1jlKSQ4Tonxkm1QHUtyNCgn4pHDNfL6DrDIuYaqr+yIONtv2yacw==
X-Received: by 2002:a05:6214:76a:b0:4bb:6fa5:bee2 with SMTP id f10-20020a056214076a00b004bb6fa5bee2mr4265934qvz.53.1666614517409;
        Mon, 24 Oct 2022 05:28:37 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id bi17-20020a05620a319100b006eeca296c00sm5072062qkb.104.2022.10.24.05.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:28:36 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 187so1732755ybe.1;
        Mon, 24 Oct 2022 05:28:36 -0700 (PDT)
X-Received: by 2002:a5b:104:0:b0:6b0:429:3fe9 with SMTP id 4-20020a5b0104000000b006b004293fe9mr27655514ybx.543.1666614516350;
 Mon, 24 Oct 2022 05:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221023182437.15263-1-afd@ti.com>
In-Reply-To: <20221023182437.15263-1-afd@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Oct 2022 14:28:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVSeqcgj=ocY-9XAf9A312xBwdypBCNk-fsnh+bWiCtTg@mail.gmail.com>
Message-ID: <CAMuHMdVSeqcgj=ocY-9XAf9A312xBwdypBCNk-fsnh+bWiCtTg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Rename DTB overlay source files
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Sun, Oct 23, 2022 at 8:24 PM Andrew Davis <afd@ti.com> wrote:
> This is a series based on my patch here[0]. As suggested by Rob
> I've resurrected Frank's patch and appended it to mine as a series.
>
> First patch here is my original patch, 3rd is Frank's patch but with
> the unittest changes pulled out into the 2nd patch. That was re-worked
> moving the source building macro into scripts/Makefile.lib.
>
> Patches 4, 5, and 6 are an attempt at renaming all the existing DTB
> overlays. Split out by platform so they could be taken by platform
> maintainers or if easier ACK'd here and taken all together.
>
> This should cover all the DTB overlays so we can remove the old .dts
> rule for overlays and make .dtso the only supported way, let me know
> if we want that this cycle and I can post that too.

Thanks a lot for picking this up!

Everything builds still fine, and the OF unit tests still run fine, so
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

BTW, you missed the Smarthome-Wolf Pi433 overlay[1] and its
documentation[2] under drivers/staging/, but perhaps that was
intentional, as it is not tied into the build system?

[1] drivers/staging/pi433/Documentation/devicetree/pi433-overlay.dts
[2] drivers/staging/pi433/Documentation/devicetree/pi433.txt

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
