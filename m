Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1AF68D0AE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjBGHhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjBGHhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:37:05 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E348B15545
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 23:37:03 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id b81so7418289vkf.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 23:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Eq83+zfltzHzioahkJ/gN8eByDKiNqSvaMwpTmz0cc=;
        b=fofbZd8M7f/nElHNqP5oEVeOB93RlhdFD1P7vohrxMeScOqN8g0wdp9JUBQ3L4hX4y
         dRxmCMtI5Tlp7mRuh2CTRoXdFKlHZmkXiltfO6rRc4bz4Gd9nXS+pyp/gjE+/GBgT9Mx
         uKBGf9AXHgJWnckS66ksBT5JNGUnKjP2F/208=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Eq83+zfltzHzioahkJ/gN8eByDKiNqSvaMwpTmz0cc=;
        b=15Y3KeAlQRCOmH/tCr2/Jp3nI7/qVyqMnpEFkkBYsWtM/q4jDl2029ufIYHpWxGMse
         4rGiaoSMZDFp5YWkBuA3EBEkgBtBjoCwdjIqfm2VXtTjxMMu/5s0wuc9kzkNvKcmvC02
         mK6vq4kUD6epwl3AYDloA13LScKfC5byQAgbmhqyV27TCp6ISEaLFkZ2Jws+zJIIZatS
         1Ot7P4nGUucsHaKbq5Uhr0as84ja5Idh0KOP5TGTDIG4/RJTlDDb2Z56iA7Y5sdeVu59
         eXh4j4aLmm8R4xKKxfE0L+r23opelGAvj8GSDLFxl+6um3XVR/RFJJTuc039s8cmvnat
         qydQ==
X-Gm-Message-State: AO0yUKWfHBHyv3oe2e3h/XqD9ASXu87RpaJmPAtvTSmCz4p30vgs2oSA
        11+lm35l3l5qEZXhE0z2VB8D9kId1zMuTk0TJPdsxg==
X-Google-Smtp-Source: AK7set8+oe/35euhPGKOWNpwP1rIWDVm30YdB2iF9lTAcAZMzHT6Ovh83su0kOSRO015TReuBdiXOyyFb2V1TUCsJ0c=
X-Received: by 2002:a1f:1dd3:0:b0:3e8:8f:f3a7 with SMTP id d202-20020a1f1dd3000000b003e8008ff3a7mr266299vkd.30.1675755423013;
 Mon, 06 Feb 2023 23:37:03 -0800 (PST)
MIME-Version: 1.0
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com> <20230206152928.918562-15-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230206152928.918562-15-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Feb 2023 15:36:51 +0800
Message-ID: <CAGXv+5FA3TzQc0L6AEi0O_gzDmRjJ=9gZdWhQZQ2wUnVm_T2Mw@mail.gmail.com>
Subject: Re: [PATCH v1 14/45] clk: mediatek: mt8167: Move apmixedsys as
 platform_driver in new file
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 11:30 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> In preparation for migrating all other MT8167 clocks to the common
> mtk_clk_simple_probe(), move apmixedsys clocks to a different file.
> While at it, also migrate away from the legacy CLK_OF_DECLARE and
> convert this clock driver to be a platform_driver instead.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

`git diff --color-moved=dimmed-zebra --color-moved-ws=ignore-all-space`
agrees this is mostly code movement.

Same comment about clk-provider.h. Otherwise

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
