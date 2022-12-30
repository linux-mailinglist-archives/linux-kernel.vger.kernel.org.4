Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137D16594CF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 06:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbiL3FRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 00:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiL3FR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 00:17:26 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87831838B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 21:17:22 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id k4so16285064vsc.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 21:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dEYbMSY9mT2OK2c114me8utvLFZz2JqIKXFmopSmQiw=;
        b=RKih9fLMpxINT80ky9qXSQ53n2p/gq4DqtkictxoVB6aWfa9UX7D6geobbaZRNdi9V
         cD0zg7UKY1wl5gpbFTbIxiJlMqwsZOqM7dtq2O2aTqKYFqeoSA4YkrNJktTS7P3yDmJW
         NVl1tmtgJy8t3YgObj5WvVVF6dgavhZvjCHDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dEYbMSY9mT2OK2c114me8utvLFZz2JqIKXFmopSmQiw=;
        b=DIzyIYkj34eNn6UGGiYqvHjqNYFat2aYOyTdMq5iBfr2xFVWoW14ixeGEO6pHQXLn/
         JZsp3jYJcUUiE9sOhMgfAlZ9p3anvBCRA+nvo5K//AUIpXJlEuVzGwpPTg/iAiyB/I4H
         YQFZtDXhPlPVw9JFNeE5ircRUyGX2YaVNZm1xUyUxR+uIVh5nSU7CMIw4afrCVMzNgU1
         YI8VWmXhTjea+mhEUeX1PCn2fllPbpZg1VtCAdl4ovU6nJQzXnzx65nxUNXMTOYM+dRi
         eujGsGpT4b3p9wws5J8+Gvo2l3zLh69ws4IBgY9cbecl1wOIRhalzAMXIXXFaV3ALNBM
         B5MA==
X-Gm-Message-State: AFqh2ko2pk20Z3LAf5innyuoQ81BwwbHpIKpZyCl3q4GWKF+rRlkOfkM
        sSSXM6WJdLgDGFYJINzGRXaxL3jRM6t5t4X+I5mBCQ==
X-Google-Smtp-Source: AMrXdXtbyCSpMJ4eNW7yhoCCnZ4ewGuLOy71q3P5g49tLuLwFTAwiq8BtlKIVACuyhU5eRY9Mp/AdemXnMQUi2cYMbk=
X-Received: by 2002:a67:f985:0:b0:3b3:7477:5aa2 with SMTP id
 b5-20020a67f985000000b003b374775aa2mr3636972vsq.65.1672377442038; Thu, 29 Dec
 2022 21:17:22 -0800 (PST)
MIME-Version: 1.0
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com> <20221223094259.87373-15-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221223094259.87373-15-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 30 Dec 2022 13:17:11 +0800
Message-ID: <CAGXv+5H26DA6McV_6XJiquM44MkrhYh1HmGQr+sB-82EOGvinQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/23] clk: mediatek: clk-mt8192: Move
 CLK_TOP_CSW_F26M_D2 in top_divs
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        fparent@baylibre.com, chun-jie.chen@mediatek.com,
        sam.shih@mediatek.com, y.oudjana@protonmail.com,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        ryder.lee@kernel.org, daniel@makrotopia.org,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        pablo.sun@mediatek.com, msp@baylibre.com, weiyi.lu@mediatek.com,
        ikjn@chromium.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
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

On Fri, Dec 23, 2022 at 5:43 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> This driver is registered early in clk_mt8192_top_init_early() and
> then again in clk_mt8192_top_probe(): the difference between the
> two is that the early one is probed with CLK_OF_DECLARE_DRIVER and
> the latter is regularly probed as a platform_driver.
>
> Knowing that it is not necessary for this platform to register the
> TOP_CSW_F26M_D2 clock that early, move it to top_divs and register
> it with the others during platform_driver probe for topckgen;
>
> While at it, since the only reason why the early probe existed was
> to register that clock, remove that entirely - leaving this driver
> to use only platform_driver.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

I had some other changes dealing with this, but since the systimer DT
fixes have been merged, and this is cleaner,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
