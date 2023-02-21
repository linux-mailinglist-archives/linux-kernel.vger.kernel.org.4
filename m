Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1A769DA05
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 05:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbjBUEEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 23:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjBUEE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 23:04:28 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254F9149B2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 20:04:27 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id f31so2901762vsv.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 20:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1676952266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GFPspBBy8xRufvz9CrVUPQBGieB+Oke55A7SPp7VcJM=;
        b=R5dfSm55zBS1tfl/U+ty43hb5qh/e8QSIHUYJq08Bvh2y7vb7a1Ab//RpRC8Bs/TI0
         6TQx07CRBlQ+YuqI2bdCR0+VTltSmArbpwH+x4ZDNSGynnZqKB4j7J/ynXHC82RxwKYv
         9NifwhJyspIjPHym9ORnrV0e5HPsxFjA7tYew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676952266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFPspBBy8xRufvz9CrVUPQBGieB+Oke55A7SPp7VcJM=;
        b=tPxFHDWE3JX81t+8yGpL/laWBKj0Ivlo77LeNqzA3gidZ9FMNSnB5K6YQX7C1rU/O8
         ynXgzGurIScEBAc32W4zPalO1tmkpiqivvzNR4thTi5zYLEagVzUSiKIxQwZHrXydovA
         8/aRA8vvDbb/v5OvGUJsrhIqXAFd/aQNmzQ6rTWPeIKkWkKAGUdiRDza7XPzLi3Lm/sw
         GfocM4YgOuJLj/XlZJIEGnARVZW50mVrP2TSnGV86g4HfeGf2FuASdoUeNs+JKahuFsI
         w/Z4w308nFF/ZZRkZ7TXoGgK0TbnIrWwmeBvOCbRjgzszRo70GFYj7GnogNI7LkTvIKH
         QCoA==
X-Gm-Message-State: AO0yUKWYSVI+VPvFLxXlNde8Y3m7/RIOSBIOrSDrUSMVqsx+VZoEke+1
        MS30VMP0/Ty1kvaxnanKdDyxAN6xPhhVIPvfR8/mAA==
X-Google-Smtp-Source: AK7set9hjJHUXRV5a23fFX2CF7M2ZWALeU2SIlHI0oUS3F1iYlKirBG0RLvsqmYV+ZISRZOZozFJ+0+oYrW0V7+H900=
X-Received: by 2002:a67:f6c1:0:b0:411:a14d:6bac with SMTP id
 v1-20020a67f6c1000000b00411a14d6bacmr836863vso.44.1676952266287; Mon, 20 Feb
 2023 20:04:26 -0800 (PST)
MIME-Version: 1.0
References: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com> <20230220150111.77897-56-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230220150111.77897-56-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 21 Feb 2023 12:04:15 +0800
Message-ID: <CAGXv+5EpnmBu8iAd9Ec0AAHvDUBRUUJx3uzv2MkaRLSRJfFD-w@mail.gmail.com>
Subject: Re: [PATCH v3 55/55] clk: mediatek: mt8135: Remove __initconst
 annotation from clock arrays
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
        linux-mediatek@lists.infradead.org
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

On Mon, Feb 20, 2023 at 11:02 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Being this a platform driver, these arrays are not only used during
> init anymore, but also during runtime: remove the __initconst annotation
> from all of them.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

I think this should be squashed into the previous patch. Otherwise with just
that one, and with modules disabled, the driver would break if unbound
and rebound after late init, when the __initconst data has been dropped.

ChenYu
