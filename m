Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAC85E987D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 06:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiIZEpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 00:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiIZEpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 00:45:52 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D57C24F20
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 21:45:44 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y3so11569929ejc.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 21:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=inQx/B+myoBQVAF3vsFN8D/0R7rZQjwNrUieRpG8clU=;
        b=j/uFU1KOCRqduTJlrlEoIn6ttforECuEoaRHf2Jkb1/p00FI72BhA+ja0+iw0yrlSt
         PyWtg1GZTi4rAHzt4bV8b93gt95RdcPppHsOHk7Sj0JJB63rSc1AZSvmj5mmHrUTV55b
         9Srf43HDAj1z8qqOrmCkboDh9b2nghcIx73IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=inQx/B+myoBQVAF3vsFN8D/0R7rZQjwNrUieRpG8clU=;
        b=7/YjquCc8QWhnuGyqAFspMTkgLo7y0szCAafhKdQxiW6GUUHi1tPOF2dgP4rdGPLeN
         xYcZLp6Xm5j3GV/EfAqyidnBEaTRk1iGagRGH1W9XUYWAE13q83LGt4TPF8EUQ0Ig/T2
         EBSwR8gSXttPRnImIsRbOXNLK4gcwf7rs6XvgJwTDmTBt7cyjMTw4EEIdL7MsNo9S+cd
         Xi+ZZereGpCzmEnj+wloG+Lh4HS1GBv3A/6Xybxdp0ZypAOqZvlMYzyrW5IVAyLqWPUs
         3vNyT6riyM7Vpz7BO2KAbMXDvnbWUrsUBi9QxXMZ9pOqETQOCETGW3ceM/auV4sy0qwj
         BGBg==
X-Gm-Message-State: ACrzQf1spO/bl6Q6UF/JaDmmiQvDnVdt+Ksz2b/qIbP7u7YHx0+oobLJ
        X4NmWVDHgV2WBAhJbPii37oQKhtbOIZQGDMuNnhLOQ==
X-Google-Smtp-Source: AMsMyM50baM0xEgY1j/hLICZS6Ro1n/Ox33rLV2Rl1Yb22kNPgKw8xFU3i402SgQ5Dfectw+su70alxJjafTx80ETlM=
X-Received: by 2002:a17:906:8455:b0:773:c45b:d970 with SMTP id
 e21-20020a170906845500b00773c45bd970mr16452870ejy.46.1664167542843; Sun, 25
 Sep 2022 21:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220921091455.41327-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220921091455.41327-1-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 26 Sep 2022 12:45:31 +0800
Message-ID: <CAGXv+5HayW7XFcPJyV4xWvndmLau5T068nc_XYEbyiFX=pMzVQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 0/8] MediaTek Helio X10 MT6795 - Clock drivers
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, y.oudjana@protonmail.com,
        jason-jh.lin@mediatek.com, ck.hu@mediatek.com,
        fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, ikjn@chromium.org,
        miles.chen@mediatek.com, sam.shih@mediatek.com,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 5:15 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> In an effort to give some love to the apparently forgotten MT6795 SoC,
> I am upstreaming more components that are necessary to support platforms
> powered by this one apart from a simple boot to serial console.
>
> This (very big) series introduces system clock, multimedia clock drivers
> (including resets) for this SoC.
>
> Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.
>
> AngeloGioacchino Del Regno (8):
>   dt-bindings: mediatek: Document MT6795 system controllers bindings
>   dt-bindings: clock: Add MediaTek Helio X10 MT6795 clock bindings
>   dt-bindings: reset: Add bindings for MT6795 Helio X10 reset
>     controllers
>   dt-bindings: clock: mediatek: Add clock driver bindings for MT6795
>   clk: mediatek: clk-apmixed: Remove unneeded __init annotation
>   clk: mediatek: Export required symbols to compile clk drivers as
>     module
>   clk: mediatek: clk-apmixed: Add helper function to unregister
>     ref2usb_tx
>   clk: mediatek: Add MediaTek Helio X10 MT6795 clock drivers

I've queued this series up here [1] and will send a pull request to
the clock maintainer later this week.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/wens/linux.git/log/?h=clk-mtk-for-6.1
