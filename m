Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6700260BF01
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiJXXw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiJXXwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:52:34 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE28283F26
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:10:31 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id x66so9237180vsb.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=stUhgmxHOajI9uqfx7NpPsmu7P60GiPKRF/7gBID+dg=;
        b=aI7jghSe4eTqhLetWbp1CUXeviJT+nB0niZcj1EYJhDL5AD7HaUHBIBnjyFt5wHzMX
         kuoy1TdwweW1mYpeAVavBgwSy7Cv65g5xnnQB6RTCg6Ou9V1otGvwMjJixkYCFuabC5v
         yIqXOu/FOjlFETGXBPo0qK53a/g8ByJg0I/uI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stUhgmxHOajI9uqfx7NpPsmu7P60GiPKRF/7gBID+dg=;
        b=uRCBdoOS2xpzzCqFiXioyne7vqSYVv8ZQIZ8T0cTpRryMW3GNk/Q/qGgk7W1am3mnQ
         BnfhZrtVn2KjhZXWk9HQN0piPuoiSoCjmy32k+auaHd8qeWBdEXIwM6KBJYHlx0BOzPl
         dQb7P6Zo6EXms8sCoWkWhjzx4z8joL8lAybP7E7i1V9/8vZlC7yWsdFdcLztmPg8dl/X
         9U+VhWSsEDHZXLndYKGiAG171cFIFQYWlZb2lbL4j/30z+nSSnmUUii2rMrIX2lT1JgF
         Cn2yqvNU6XQjcoRvLJCitLKHHLP1qiW2vDc3dXuNuXX4vn9yJG1/LYiozkq9zArNPxQI
         iLSw==
X-Gm-Message-State: ACrzQf1a81QD3BIuA4NSbWKSV6dxkNh24zNsI/E7ITLgQrT++6jUJb5i
        hKfIuMk1dDpmoNzHmEUY7ygUezazJfCRpH/jyt/iSA==
X-Google-Smtp-Source: AMsMyM4mF8OtH43I5lB0/0j3s/Xrw1R6qcOOGU77MvOGbIdfp4X/GbRrXsUymIVx+BbzSWL5HqwmMg4nQImm+z6TjYI=
X-Received: by 2002:a67:f684:0:b0:392:ac17:f9b0 with SMTP id
 n4-20020a67f684000000b00392ac17f9b0mr20569192vso.85.1666649420213; Mon, 24
 Oct 2022 15:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221024102307.33722-1-angelogioacchino.delregno@collabora.com> <20221024102307.33722-8-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221024102307.33722-8-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 24 Oct 2022 15:10:09 -0700
Message-ID: <CAGXv+5GLWLcG8n0vVjKV2rNHpVOxGfz_63OmZSfjqk503gADLw@mail.gmail.com>
Subject: Re: [PATCH 07/10] clk: mediatek: mt8192: Drop flags for main/univpll
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 3:23 AM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The main/univpll clocks are used as clock sources for multiple
> peripherals of different kind, some of which are critical (like AXIs);
> a rate change on any of these two will produce a rate change on many
> devices and that's likely to produce system instability if not done
> correctly: this is the reason why we have (a lot of) "fixed factor"
> main/univpll divider clocks, used by MUX clocks to provide different
> rates based on PLL output dividers.
>
> Following what was done on clk-mt8186-topckgen and also preventing the
> same GPU DVFS issue, drop CLK_SET_RATE_PARENT from the aforementioned
> clocks.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
