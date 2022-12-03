Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C118164153B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 10:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiLCJXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 04:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiLCJW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 04:22:59 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C2212A88
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 01:22:58 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 189so8750840ybe.8
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 01:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQEVpJWky6tIJ89XqczxI7S0ZUfSn6CIT0hg/X+OSlY=;
        b=Rgbj5fbB+ubXc5lxB75411Bq0YmdYG16G6Y4s8Bew+CQGHNAiOQfiXNuLqe7UTm8rJ
         DOZ9Pa8SlSBOucCgI358McADb8KVdwQOPUXPEmJInzjAs5sghOG1QuDuAsaDlEPn/f29
         oOAov/y1c9gnUiqembRyjEXpk47JHllvwX4bxUcXP3YAfbG+ji8sqfi9v8ZiZaOgZhMK
         Ez1ejr1CKCwK1iGF+dRePOkFRuQsU971NosoDjxupXHgb5WdafzCOLqNkATzIo5/nbeY
         xZBo0BhSHDTV5YdM/on3vlA+1/WnKfbvvCU1xkHiRMN7bEQ93FmQLnsZKxYLYGgIkIle
         qWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQEVpJWky6tIJ89XqczxI7S0ZUfSn6CIT0hg/X+OSlY=;
        b=1WGRtjrKQ9WxKl2OVU6cJob3PuK1Fvt1FPBCOVXIuOz+pFEKBcrSsLTeiIPbHbGx2r
         ttTMq6nLzNve91qLkB1jGmuK2MqO0x59EDfH+dYVIsIKz4aXak55g4f2L2e7g/LfNZlD
         o44kaPqyRT/i/aPaiVM8+ARRKlENc1vPvlVaBfiqBYY4F28CSRnLXxBIf8f92AteAzoe
         auQ1xKKHYXEGbO5V69AtlMK6RkmzUuBfhvRL6qWez0A2w6BCzp1yy5risIMVXx9ycBdV
         IxRqcpla4fCv8rpE4/RxnKP1eaNRVV4vhgsZp7icK9kQZYG+P+hz8LHxDibRh+Kc+GTY
         GIaQ==
X-Gm-Message-State: ANoB5pnOSslxzi4pzUgmkSlnG3HZ4r0B5qqXC96lwteGcyVMwrApO8/Z
        JHhUiU5Knmn4qN7Y7oSO41rLFxmAk7kQ37vXBaWbqg==
X-Google-Smtp-Source: AA0mqf5ZQfNSD0/07kd5VFeFh5McEsaO3GSOFBR7Nh6mdhMxqXu71Xyg3wJZ63scyLjajbGzBwDjWGjBa0hVSp8aKBc=
X-Received: by 2002:a25:bc8a:0:b0:6ee:e865:c2e2 with SMTP id
 e10-20020a25bc8a000000b006eee865c2e2mr8564584ybk.206.1670059377999; Sat, 03
 Dec 2022 01:22:57 -0800 (PST)
MIME-Version: 1.0
References: <20221129023401.278780-1-bero@baylibre.com>
In-Reply-To: <20221129023401.278780-1-bero@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 3 Dec 2022 10:22:47 +0100
Message-ID: <CACRpkda75U=b50rK=WecNvaEoTdN2UzGyEwfPRaO6jG9FGyWhw@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Remove the pins-are-numbered DT property
To:     =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        krzysztof.kozlowski@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bero,

long time no see!

On Tue, Nov 29, 2022 at 3:34 AM Bernhard Rosenkr=C3=A4nzer <bero@baylibre.c=
om> wrote:

> During the review of my MT8365 support patchset
> (https://lore.kernel.org/linux-mediatek/20221117210356.3178578-1-bero@bay=
libre.com/),
> the issue of the "pins-are-numbered" DeviceTree property has come up.

(...)
> This patchset removes all uses of pins-are-numbered and marks the
> property as deprecated.

I don't remember any more why this property was introduced, but
I am happy to see it go.

> Bernhard Rosenkr=C3=A4nzer (7):
>   pinctrl: mediatek: common: Remove check for pins-are-numbered
>   pinctrl: stm32: Remove check for pins-are-numbered
>   dt-bindings: pinctrl: mediatek,mt65xx: Deprecate pins-are-numbered
>   dt-bindings: pinctrl: st,stm32: Deprecate pins-are-numbered

I applied patches 1-4 to the pin control tree for v6.2,
please funnel the rest through mediatek/stm32 and
SoC trees!

Yours,
Linus Walleij
