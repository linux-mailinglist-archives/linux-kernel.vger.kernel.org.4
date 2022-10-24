Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A8160BEEF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiJXXsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiJXXsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:48:12 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15098C3560
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:06:19 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id q127so4337707vsa.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vRmMvviWEKka4D3lrnvrAAXXSnpPgxlIxCd5d8ajOxA=;
        b=A67982Iwiu+nKS3HmSgbb4omBV1yndzR+UlGQQ35HJQtbMRvvbqZPLw07SZkUDvOi1
         4k2oZtG80K4ZadZbBMhty3XVit5fXX2/UFyTf3fjwN5pN5HgaWMY1n858PDOJQ4gRb6N
         9rWxIK3MP9J44LaH+Xpz1sLYVE0LEw/ybcHPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRmMvviWEKka4D3lrnvrAAXXSnpPgxlIxCd5d8ajOxA=;
        b=mSQ/hTU3WQdEMoURft2RfAhBxp7oT2Vc1QN4hppbBJfKU5k1xGY+5fTxCV2LoDrSC/
         +pRUHR7TgTNaXrfl6dIzJi9PR0yEdySLxMtiAoLH8bPYYb7D8TBXQxQ6LD8pL8Q7AiVp
         zUShLCa7kivtaRvb67uxSB1bDecptXzZebjbMfily128VHufDshiIMEkcEFYwc4nsG4K
         g8hOXrn1sN5OFpr7Hg1mSHIkKicjJXu0RGHa06TkrxSNPjKMJQa/QC0uUDm7ZGWZB9gt
         znNDp911qQ8Cbn1g3AhxDPNc2i50dZjMf5N7LCzPDWP8o8Uh20iRw1YxCxgkpmqzds0l
         9/iw==
X-Gm-Message-State: ACrzQf1JVRhcNc9+Mcd1r8G4/8VuBO179vE/GxURN3jwuP5ZQ/uaNNOp
        o/YSyn8f0tt30KrKUneDvciNgnkUK3uzDk/30rPhpg==
X-Google-Smtp-Source: AMsMyM4ejiEt/3Clzr0qB4Xhl44cniyZH8Auxb0kyU4oXVS18eKRuwJRA9eSGi8jRlUeVbBw8It9KcG5DdVKmgSgCT8=
X-Received: by 2002:a67:ac0c:0:b0:3a9:e899:3b9b with SMTP id
 v12-20020a67ac0c000000b003a9e8993b9bmr14117825vse.9.1666649142869; Mon, 24
 Oct 2022 15:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221024102307.33722-1-angelogioacchino.delregno@collabora.com> <20221024102307.33722-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221024102307.33722-5-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 24 Oct 2022 15:05:31 -0700
Message-ID: <CAGXv+5Gx0PHQdfrtrUicioP1VxuRd4U24PZV2kFLus_OyrP7fw@mail.gmail.com>
Subject: Re: [PATCH 04/10] clk: mediatek: mt8183: Drop flags for sys/univpll
 fixed factors
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, matthias.bgg@gmail.com,
        miles.chen@mediatek.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, chun-jie.chen@mediatek.com,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        msp@baylibre.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 3:23 AM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The syspll and univpll clocks are used as clock sources for multiple
> peripherals of different kind, some of which are critical (like AXIs);
> a rate change on any of these two will produce a rate change on many
> devices and that's likely to produce system instability if not done
> correctly: this is the reason why we have (a lot of) "fixed factor"
> sys/univpll divider clocks, used by MUX clocks to provide different
> rates based on PLL output dividers.
>
> Following what was done on clk-mt8186-topckgen and also solving the
> same GPU DVFS issue, drop CLK_SET_RATE_PARENT from the aforementioned
> clocks.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
