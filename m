Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C68B6A194A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjBXJ7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjBXJ7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:59:49 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A074063A3D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:59:47 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id j14so20772634vse.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XDFb6KeNmasOI1qk97qirsv6TtkzS7nvrtVQovIHZ00=;
        b=LSmpN9MlszDsbEDP8QIsbK73FRDgKC/rd7maeEsnoqDytLsGWPmglbaxivl4STVvh0
         SNbZ6mC13X+83SRqHUVG1o/ex6xdorycgF+G3OhN+w+u7i6+gbdHoZRjA5j7Et577BzX
         o2wY77iHLN0epiYsWcUGhdte3amFGW8fhfIYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XDFb6KeNmasOI1qk97qirsv6TtkzS7nvrtVQovIHZ00=;
        b=HnMVZvW8bC/kXHzEeyOMLyq1UDXUWyfgrL+RkAmid6dlI0XajuXj4Jv7GiTZyuU4C1
         y39qpTOHIpt2y8eO2PZ5JQuWwecWPXWCTmRtZLDNg9wGtnFHYWrYRKEYFshV/8RbSThi
         /cPNeR62PGkr9m7UY8HfCf1KC89nQxEeSv+5G+qz0sna7J64QC4QOOh3dYUhWAKj3p66
         bYH0BzJKz+CCFKhFUWkERV10YdPSdP8wCY/iSidkqBXSsl5gDvJsL8yDq1D25m0jTcIh
         NvByfYuEOHe8WthYh5BKC9rJYSrCZEEEiiSnDrstzmWlYNwncT3uQak3iHVO6tThGObR
         Q6QA==
X-Gm-Message-State: AO0yUKUW2FjkN/nTpL3O7VjMh7PGMfThLq/7pFqd4iUYW7ks9UCRgSBd
        3rZNfald/eYJIOky6KOhXLif/wSC3AqNX3rpR8coiA==
X-Google-Smtp-Source: AK7set+aMwFWGjpsMC5b96w+gUlhNcPIgk7qkMUNRC4SeaL5ULZphNqq0SXxZFrs2voH/SGCxlw7aI9cRmd0865OK7k=
X-Received: by 2002:a67:d21c:0:b0:402:999f:51dd with SMTP id
 y28-20020a67d21c000000b00402999f51ddmr2202544vsi.3.1677232786837; Fri, 24 Feb
 2023 01:59:46 -0800 (PST)
MIME-Version: 1.0
References: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com> <20230223134345.82625-14-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230223134345.82625-14-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Feb 2023 17:59:35 +0800
Message-ID: <CAGXv+5GPki1Oz-yF-kReoTGV9eA2io==rQCR3A2L0R4zzj8Wtw@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] arm64: dts: mediatek: mt8195: Add mfg_core_tmp
 clock to MFG1 domain
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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

On Thu, Feb 23, 2023 at 9:44 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Similarly to what can be seen in MT8192, on MT8195 the mfg_core_tmp
> clock is a mux used to switch between different "safe" (and slower)
> clock sources for the GPU: this is used during MFGPLL reconfiguration
> and eventually during idling at very low frequencies.
>
> This clock getting turned off means that the GPU will occasionally be
> unclocked, producing obvious consequences such as system crash or
> unpredictable behavior: assigning it to the top level MFG power domain
> will make sure that this stays on at all times during any operation on
> the MFG domain (only GPU-related transactions).
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
