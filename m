Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548CF60BF0F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiJXXyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiJXXxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:53:49 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAC476969
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:11:06 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id s28so9231987vsr.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=stUhgmxHOajI9uqfx7NpPsmu7P60GiPKRF/7gBID+dg=;
        b=bEFddOpdoZI+TExGmAdpUfmJNoo8dPBXr0GJGSgul5kqwh++/sgfJQl8+oGEvFD2ne
         kpz6K8eWDmAVOCEWOuk3k3vaLpcYn1giG0Y4laOx4hW3kM36CeJfyuYRXRoygTCeOInv
         vgzrStxX8eomyhmjrg03uh7HfE8n1gEyEMRiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stUhgmxHOajI9uqfx7NpPsmu7P60GiPKRF/7gBID+dg=;
        b=RtL71EC7ZzOcYcj1Y2iTTcXguBqwo1VoVr8gq3VCI3iLr46bdO6zK5I6HHbss6fi29
         S/gHI+w3S7T40FNaryFaZe+xJxka8+9EvYJMTQvF3bqzkCCmXcyjcV8mHnwCdMu5MR02
         gSjFfGcW3QuYiAO2H45BecgJKJDCHG3cBeCF3B3fKsZ14k7mGGDqTRMIwU/C7kD6zN5p
         MMKjxvYOKWJQQfAoGnncdt+CcFv6O4UVd8NHbf5EUEmE4ebuzNSqijjgni5GuXnmkuTi
         ecYJuH4WvJzbOdygHyloI7jT8kMCUmcua9l4GvzdLS1vR19s7TVApdgVsYCUqeml+tWH
         1Tqw==
X-Gm-Message-State: ACrzQf2e/N7NBIMFMAlUl5+/4uKdzuUEvOzhLzAyqnBeh0qhk46mOmTb
        Qt6NTvk26UfVIwEUEUKwiaoaPaau5ViHaQalU0f3+Q==
X-Google-Smtp-Source: AMsMyM4Efc9ufDsXBeEA5wir0gCDCtXUofm53iFeyXJEoyskf089urS75VK07NTr4nbtrLk6Bk5gGbtapSYnxvi7JQg=
X-Received: by 2002:a67:f106:0:b0:3aa:efc:8610 with SMTP id
 n6-20020a67f106000000b003aa0efc8610mr6032143vsk.65.1666649460086; Mon, 24 Oct
 2022 15:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221024102307.33722-1-angelogioacchino.delregno@collabora.com> <20221024102307.33722-9-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221024102307.33722-9-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 24 Oct 2022 15:10:48 -0700
Message-ID: <CAGXv+5EG0TwE6pEyEb3sK3bU8DWzbtQqPgtWcudJ0KpbR3XrCg@mail.gmail.com>
Subject: Re: [PATCH 08/10] clk: mediatek: mt8195-topckgen: Drop flags for
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
