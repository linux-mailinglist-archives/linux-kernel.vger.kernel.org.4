Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9917960BEF8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJXXt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbiJXXtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:49:19 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D228B2EF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:07:28 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id q127so4340160vsa.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EcRp0GH5Esc6snP7VZR4xY25U16N2wvcVl6BzgZRJeE=;
        b=Rz792NgLGIt9O6goUOd/iW8LTGXrspz73YCmrZB+Up47bT7wDV4ZlERoSGu76oNU91
         aAI62iK++sU/HWObuMN2cxyUGpi0j8izoltf4IvsqM/IkAKGo2W4rjmqAeLlWi9mOcMf
         KfYrNN2PONwPUxRs/qenV6Mjka7riMeSpwBag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EcRp0GH5Esc6snP7VZR4xY25U16N2wvcVl6BzgZRJeE=;
        b=3npN22E3qtE36NumPbEQ5Oyp3Cv8E7/r4iFZsS1qlSSBsODlUB37DDVt0b/cnDp1qk
         8m8g+eYEHl7uW3ahWgchh0UxF4/gi5yfLibVlmGdcg1kOXeqAg6mcI7qquhn/cqA6pYR
         5muGpqFayNhrAHDdT+x68TW3HaVmrnDydFHVg7HpPJaWgc2F64REXydq5Y34PrYH4k91
         NKadSS/cr9H0s4snJGS/3F9h0EIT4cwSHHV0q2BL+xHFBD8A0IqSc7b5skBgTSMfBrib
         wOviqanghSLDjIqBiuwwKAI+pbaDXs8tbVIXxzjxJrr80eAZooey4BYTYmMD5G0Xf7hO
         w4gA==
X-Gm-Message-State: ACrzQf2UwJmzbG5UvQLTw2sJ9/3/TSADzVS7Z9ylqBH8C/igXopUdY4I
        MD5j22Gqv/639CD1Dm5bjzpjZFClFxf5wAZNkFTOiQ==
X-Google-Smtp-Source: AMsMyM7cxOfeBextqdk7aBE5SgrcTfc1CGSj3S0ktMl8h7EY71ngkdmETifGxNNJtvu+TcnOV/yL86UlEA0UACMkihI=
X-Received: by 2002:a05:6102:3ed5:b0:386:91a5:a246 with SMTP id
 n21-20020a0561023ed500b0038691a5a246mr20273302vsv.26.1666649206639; Mon, 24
 Oct 2022 15:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221024102307.33722-1-angelogioacchino.delregno@collabora.com> <20221024102307.33722-6-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221024102307.33722-6-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 24 Oct 2022 15:06:35 -0700
Message-ID: <CAGXv+5EwrRqNuqunzLHtRyZ+AMyO1DDwP01TC9CjbxHnRxbH0g@mail.gmail.com>
Subject: Re: [PATCH 05/10] clk: mediatek: mt8173: Drop flags for
 main/sys/univpll fixed factors
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
> The main/sys/univpll clocks are used as clock sources for multiple
> peripherals of different kind, some of which are critical (like AXIs);
> a rate change on any of these two will produce a rate change on many
> devices and that's likely to produce system instability if not done
> correctly: this is the reason why we have (a lot of) "fixed factor"
> main/sys/univpll divider clocks, used by MUX clocks to provide
> different rates based on PLL output dividers.
>
> Following what was done on clk-mt8186-topckgen and also preventing the
> same GPU DVFS issue, drop CLK_SET_RATE_PARENT from the aforementioned
> clocks.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
