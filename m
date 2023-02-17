Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DB369A686
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjBQIF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjBQIFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:05:14 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC7246144
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:05:12 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id v16so3626857vss.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EeRQ8wllN3fSx/sorPDxTIgU0OrrDmKry0tPIXvN7Uk=;
        b=SnTHTOgJjuXl8DOkKBIpg88cQ+grTfSC8WmJOR4VpW4Q4UtYnR05e7F3+32Ch13Uxv
         pw7SfZOUbscY1uo2Mq5a9ug9N+Tb0zEuKAfeENogGYaRyjKbezhY46uEGoFxvljZEL6p
         pLaHHrTQyFU3eZPP2pA8tIceWodcSWC+0K/ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EeRQ8wllN3fSx/sorPDxTIgU0OrrDmKry0tPIXvN7Uk=;
        b=QEMPpczt+oCrATgRFQt+YKN5anoIACgWRvEWg58o0JWc7A+uN92ytPFYSenyHsLOJQ
         73FuYDJY/d+hz/bSEx01vMrLD63kRmC/JJozdkIzpzrAcoVlO94BDTbuOEulLUMTxpYU
         RRFOzj0h1hIIez0LKEeURQaQhdhics/2fMVOm280YUkuOUxbZyWn57buiEfxqGIk4q8X
         MQ+gsY717hdE2DpBoM0WXW1g6vCvj/2E5BeS5WoqD2TqLP1cl6PkRJu2OrwaRo3xurwL
         y/JsE4z+AUSTI5A9DB0q6KBmvq9xSG0LbqWlxNG94qNa1Rtc8o7RYgcdp4flnqHQ2cDs
         Sc+A==
X-Gm-Message-State: AO0yUKW/Nsmfa4Frvaz0yBlsrofizHAERGKoiEkJsRwP8MdnIHrw5Kz+
        fxd+DyM1jWHspnG0Tt33Q8ECS/nw5tTuPJYxBFbKjA==
X-Google-Smtp-Source: AK7set9pEGiUlwznvRLCIKFI6anMPSKgYHXbx2RNDKwGHP2jw9728TFy/wcMO/sbgddWinMcfY44dyhrBL5zpZwByuc=
X-Received: by 2002:a67:f749:0:b0:3fc:58d:f90f with SMTP id
 w9-20020a67f749000000b003fc058df90fmr1615594vso.60.1676621111880; Fri, 17 Feb
 2023 00:05:11 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 17 Feb 2023 16:05:00 +0800
Message-ID: <CAGXv+5HrP2TCacuOBcF3OG-22pAuukhtTHUoA+D2zY6wNfoYAA@mail.gmail.com>
Subject: Re: [PATCH v2 00/47] MediaTek clocks: full module build and cleanups
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 9:41 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Changes in v2:
>  - Fixed issues on MT8183 (thanks Chen-Yu!)
>  - Changed builtin_platform_driver() -> module_platform_driver() for
>    MT8167 vdecsys clocks (as that was a mistake!)
>  - Some patches were split, some others were reordered
>  - Summarized: applied changes from Chen-Yu's review
>
> This is part 2 of the "MediaTek clocks cleanups and improvements" series,
> which was already picked.
>
> If reading this full cover letter is too boring for you, here's a short
> summary of the changes of this series:
>  - Added mtk_clk_pdev_probe() for mtk-mmsys probed clocks;
>  - Added divider clock support to common probe mechanism;
>  - Various cleanups here and there;
>  - Converted most clock drivers to platform_driver;
>  - MediaTek clocks can now be built as modules.
>
> NOTE: Applies on top of [1] and [2].

I think I covered all the patches. Was there any particular reason for
skipping clk-mt8135.c for the conversions?

Thanks
ChenYu
