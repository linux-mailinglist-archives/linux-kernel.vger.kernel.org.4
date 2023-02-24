Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B2D6A19AB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjBXKLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjBXKKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:10:54 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66002168AF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:10:07 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id d20so13209323vsf.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=958ik2d8h0rqs5xPiVi4wdegUDuAm3bJLnk3HJrVN6g=;
        b=geYtILrMhZyPN1m76Js6L2I06THILfyxZELzigrOgZaamrjIq5P20GG4Ltklb2cWIg
         ig+jb6hjYB8q0YWsHTDssLJRDLTdvCzPHF/u+MclpxDKZyNcOM+02n3x1rXwNNfPb2uO
         X4G85Wv5amgQr2H37ch3HJgI3bv3/FHEnRRJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=958ik2d8h0rqs5xPiVi4wdegUDuAm3bJLnk3HJrVN6g=;
        b=k+NHogSgLekHdma3vKRABPfJ802pnQ65DB3bwmI7savb5JSoG1nclszaPTdqq0ZK2K
         eoSsYJ6xB/iZncPZB3uCKoEbjxUIbigjJnOLmWLEW1saY/Ga2ewQI9j/vNkVd5zpXgrJ
         L5949GmRRmAmJpvMInxYekPmTXdSCFuvzDQ8KRUx8qMGq9KWrGvg+/ixjEXBUA5TvT8v
         fFwNiok7InZ0Zx/rKvHI3nLnE0JdJRmQvZGi0pKUZkZSfARHCt1d6krxrfYPmBghm1q3
         RUXQkrkFTrVI/nowqRY48EUxV9E2BhZfcze0TrR0iZrHfbw1snsPxIRUOWUt8VeR4oEU
         dRbQ==
X-Gm-Message-State: AO0yUKUQ6VrwoGP8+dMlEh/DUIyryWfMd3Xq1Xl0j/keJ2lmsUdHpgF+
        ekFQ6PflWPPItjE9IOG/OT5unMrynaHTyZ9vZ1R6xw==
X-Google-Smtp-Source: AK7set9+NfQuPrNJdufHu//12XKpnplgNgl5zZ8Ksiq0QrfjzgZUfHBB+nf4MHufeDSr6TAoH6tCu4h1r7GapdETZYw=
X-Received: by 2002:a67:ec11:0:b0:411:c62b:6bf0 with SMTP id
 d17-20020a67ec11000000b00411c62b6bf0mr2077517vso.3.1677233406576; Fri, 24 Feb
 2023 02:10:06 -0800 (PST)
MIME-Version: 1.0
References: <20230223133440.80941-1-angelogioacchino.delregno@collabora.com>
 <20230223133440.80941-3-angelogioacchino.delregno@collabora.com> <CAGXv+5FK8BjSgwS5276FJj4zG_3STMbQwQWdyn3LjOvQ=108RQ@mail.gmail.com>
In-Reply-To: <CAGXv+5FK8BjSgwS5276FJj4zG_3STMbQwQWdyn3LjOvQ=108RQ@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Feb 2023 18:09:55 +0800
Message-ID: <CAGXv+5Gv19nijoW5i8=Ouh4H24X3pknM3ZBSo9Tgv8XkLt+XbQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] dt-bindings: gpu: mali-bifrost: Split out
 MediaTek power-domains variation
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, matthias.bgg@gmail.com,
        robh@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
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

On Fri, Feb 24, 2023 at 6:08 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> On Thu, Feb 23, 2023 at 9:34 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
> >
> > In preparation for adding new bindings for new MediaTek SoCs, split out
> > the power-domain-names and power-domainsvariation from the `else` in

                                            ^ missing space

Once fixed,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> > the current mediatek,mt8183-mali conditional.
> >
> > The sram-supply part is left in place to be disallowed for anything
> > that is not compatible with "mediatek,mt8183-mali" as this regulator
> > is MediaTek-specific and it is, and will ever be, used only for this
> > specific string due to the addition of the mediatek-regulator-coupler
> > driver.
> >
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
