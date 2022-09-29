Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE905EECD1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 06:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiI2EhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 00:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiI2EhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 00:37:11 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8974B1280F9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 21:37:10 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id lh5so308626ejb.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 21:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hCIr6ggWP7k5r3nMA/IQLk+9jq0v0zrFpIbWh0QT22o=;
        b=TR9E4YYcWtROuWGCseBJ1Nn/qTofn8Gd6wa7GsL307BVMqtJP7MrZqakH3Ev6A1VuQ
         6B8V4rsybpf7FKF9lu2f1fSGvfkjsIQJTRydxE4CA1gkhLx5AD+5w+GfffJ36QKRxDGU
         lETxu5SOf2snTa+ovV89JdmA+sHU4titFehnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hCIr6ggWP7k5r3nMA/IQLk+9jq0v0zrFpIbWh0QT22o=;
        b=unGTo1aQLk4mP6rgsIPt67uucB1yzG+ClZyP8nVwPUdca/743/+fLS9e7Td7P22dc3
         gAdVmtEXZm3GWvTu8mC4+KEuGX6zOWKvk/sAA7zp/H76ixwm7mWnQxXC24z7lG29wvSN
         0dZaKbg7Ae6Ey9gu7VrjP3PKkoLwJEbXRvwC0JkPPP/sAnhijqSDtg5Xs0OnWDYs6n/q
         Mmqp/OSGDk67meXnTYzwf5zaWE5+P0CwI4t4KDtO2MqJWqvJw+XcD/I71eRBjFacP74a
         W6QXKFOV0VXe6MpK50+ApuotgOqKOt+wfKCUipXcUWsmA9QGWGGlXE+YvAE1yct27tIS
         /IWQ==
X-Gm-Message-State: ACrzQf3XOk7typK0SJXKcPWc+T0s9tqoU7qamv1b1SyX3QNWCGIjsOmF
        fgCYUg2QiR3aQMI7oA5C4ikSYny8ycmlGkaqPyk7Dw==
X-Google-Smtp-Source: AMsMyM42xVrO9Sdosyvdwfr6CiAqqADoCZ5aeLBLftNjRzyuLAYvUGMUJADYo2U+hcbm0qWMjh4oR+ebBSwFXSkk/9k=
X-Received: by 2002:a17:906:8455:b0:773:c45b:d970 with SMTP id
 e21-20020a170906845500b00773c45bd970mr1070628ejy.46.1664426229162; Wed, 28
 Sep 2022 21:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220926102523.2367530-1-wenst@chromium.org>
In-Reply-To: <20220926102523.2367530-1-wenst@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 29 Sep 2022 12:36:57 +0800
Message-ID: <CAGXv+5GC28RHAj=PQyUFyZGwEOuoa3TnT3RxUEmP3SMvYCVEuw@mail.gmail.com>
Subject: Re: [PATCH 0/6] clk: mediatek: More cleanups
To:     Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 6:25 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> Here's some more cleanups for the MedaiTek clk drivers.
>
> Patches 1 and 2 fixes and cleans up some parts that were missed in the
> previous clk_hw conversion series.
>
> Patch 3 drops the duplicate registration of the top_early_divs clks for
> MT8192. Currently this only contains a fixed divider.
>
> Patch 4 prevents having a duplicate OF clk provider for the topckgen
> controller, but removing the previously registered instance.
>
> Patch 5 deduplicates the parent clock lists for MT8192.
>
> Patch 6 adds proper error handling to the clock probe functions for
> MT8192.
>
>
> Please have a look.
>
>
> Thanks
> ChenYu
>
>
> Chen-Yu Tsai (6):
>   clk: mediatek: fix unregister function in mtk_clk_register_dividers
>     cleanup
>   clk: mediatek: Migrate remaining clk_unregister_*() to
>     clk_hw_unregister_*()
>   clk: mediatek: mt8192: Do not re-register top_early_divs in probe
>     function
>   clk: mediatek: mt8192: Avoid duplicate OF clk provider for topckgen
>   clk: mediatek: mt8192: deduplicate parent clock lists
>   clk: mediatek: mt8192: Implement error handling in probe functions

I've queued patches 1, 2 and 5 up here [1] and will send a pull request
to the clock maintainer later this week.

The remaining three are related and still under discussion.


ChenYu

[1] https://git.kernel.org/pub/scm/linux/kernel/git/wens/linux.git/log/?h=clk-mtk-for-6.1
