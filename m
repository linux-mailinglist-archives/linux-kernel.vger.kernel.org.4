Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7815460BEBF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJXXj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiJXXjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:39:31 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23102317E3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:58:48 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id h3so9201673vsa.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BzSJYeJmaTtTxu26Xk7PIR207/FtZbc1yEGzfOkJ+8U=;
        b=AFR5IkY1THjsaMBnZeQKwLYzIr9rrM6ni3gipAZKPDAEIe/ZGpVLpuD4pUFK0izrIU
         Iexsw5MQ6s8SqjK8P+TyE7pURsY+RfYmeh+5VhtJliGnTKLRWXxdcK3KfafIdF9EtDd5
         3ONuGx+5L5V0soyNKdJYLdTlJvp3MlQxIyxms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzSJYeJmaTtTxu26Xk7PIR207/FtZbc1yEGzfOkJ+8U=;
        b=Z/uYdEAiNMHL7VtoWTtZJ8BJspevAJqteTpZnRH+R0YxuQyF3nsjENw40mdQtKjZfc
         eIcbpibmFjSvy84++MKK1qatmehdMWOf7uWbQFQkIhLtemWjKb4K3luvkyl+W7TYWo32
         5iQKJ2ulqrQlm6Hz4pX4LoeofJXQjER/YRAGPBRuQRNSX2dKGOTQW9A3Espwf7rjLXzy
         k5+q9k4HN8CkxDw0Ya5QV96mNTeoooGl++Uep47ELTeVLqRIxqeIUROHh/SsPBnBNKR1
         x2AdoAMoWLW0UKq/d4sga3Y/FmQPSVeJzvhzN6ZU2O3Tf/vWlRk9k2sAfORZJHyI0PEi
         8s/g==
X-Gm-Message-State: ACrzQf1cKH9goGiMH8Js1PBILBu8Q1JHyvK6PQP/o8m5XdXYE8bnD4Iv
        8K4Bc1v/ZQFyChlxn3Rk6exmskQ4W1O2ulx8JLGkxw==
X-Google-Smtp-Source: AMsMyM7xsfjKi9PBasDfAnPzuNevqgPkwVbkWIklAY6Btc1FAexcrTrDwOWAJj+nVch8ctcQNpEKCIhfuV4+G7aJBn0=
X-Received: by 2002:a05:6102:3a4d:b0:3aa:762:5933 with SMTP id
 c13-20020a0561023a4d00b003aa07625933mr9658131vsu.17.1666648719970; Mon, 24
 Oct 2022 14:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221024102307.33722-1-angelogioacchino.delregno@collabora.com> <20221024102307.33722-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221024102307.33722-3-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 24 Oct 2022 14:58:29 -0700
Message-ID: <CAGXv+5FPUchS36ObBZQ73zh7cR5wyfk6bpNO4u5h3AH1GzSP0Q@mail.gmail.com>
Subject: Re: [PATCH 02/10] clk: mediatek: mt8186-topckgen: Drop flags for
 main/univpll fixed factors
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
> The mainpll and univpll clocks are used as clock sources for multiple
> peripherals of different kind, some of which are critical (like AXIs);
> a rate change on any of these two will produce a rate change on many
> devices and that's likely to produce system instability if not done
> correctly: this is the reason why we have "fixed factor" clocks, used
> by MUX clocks to provide different rates based on PLL output dividers.
>
> Though, there's one fundamental issue that must be resolved somehow:
>
> When performing GPU DVFS, we get a rate request that will try to change
> the frequency of MAINPLL due to the CLK_TOP_MFG mux having clk26m,
> mfgpll (the GPU dedicated PLL), mainpll_d3, mainpll_d5 (fixed factor
> dividers) as possible parents.
>
> In order to solve that, there are two ways:
>  1. Add new "fake" mainpll_d3_fixed, mainpll_d5_fixed clocks, clones
>     of mainpll_d3, mainpll_d5 clocks, for the only purpose of not
>     declaring CLK_SET_RATE_PARENT; or
>  2. Simply drop said flag from the original dividers.
>
> After some careful validation, I cannot see anything calling a rate
> change request during runtime for MAINPLL, nor for UNIVPLL (which would,
> again, mean that we're reclocking lots of peripherals at once!), so it
> is safe *and sane* to simply remove the CLK_SET_RATE_PARENT flag to all
> of the main/univpll fixed factor divider clocks.
>
> Besides, if for any (doubtful) reason main/univpll rate change will be
> required in the future, it's still possible to call that on the PLL main
> clocks, so we're still covered anyway.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

AFAIK this matches what we do for some other SoC families, so

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
