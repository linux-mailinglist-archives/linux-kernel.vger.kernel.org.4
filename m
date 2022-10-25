Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F060760D54F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 22:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiJYUNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 16:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbiJYUNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 16:13:40 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301807B1DF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:13:40 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id a2so12259629vsc.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAPmmifa2/HcHB2qPav/4923vIZAl9TQd5J4SGzrQ0A=;
        b=WRa1eOJ1K81r/SUmnntIankHeHKKywXwyFJDwjNCmatVV8G+BItMgNQVaKyTZD+KEW
         bAm1zlAB12EDCGkC762udKuZPfW3iyP73wMq+ybNWskymy48ElCG/KCRK/moNnSR17dQ
         QwO/avAYCvLx9rhLlMG/BOBtCw3+Xzsbxm/So=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAPmmifa2/HcHB2qPav/4923vIZAl9TQd5J4SGzrQ0A=;
        b=MO7K0Lh0qbH/sv+vZrW23C04+7R1b5nAwNDaZvzW1fiDx/lS2Nsfsp4cKlckLq+eNH
         1GmqQr8W6zKgm7L51RQssuY19LddZ/5bH66zMXBxu2FDMAmunyzbi8Wwvqd1/KZrrZ9V
         qrohtcJ1hOIS6ccFkrZnkdlr+jiprEbEaBnFrMZICbcprMmThaTNoJeOkJbJboAb92tt
         fDZ3ByhK/R4QjTkUilKbOio0ZA9bpa1hIOWUc1ZPUIzpE4MIweRl2jMMHHcEfGIrOV8n
         lNslvbIg1PuS8Yf8ubOvdNzJ0zl/DFbE6A9FcDw9kut/IB4pxYAY4Xr6k4L8iTc2I0Ki
         M2Gg==
X-Gm-Message-State: ACrzQf3aJEyCES71JGkqZrHEz+54RaXp9vHrBdO+hXNFGzx/m6efwyfl
        IZaCFNi8izDMHAOXF9ejeAyvKTwUHXrNAy3t/ydUVA==
X-Google-Smtp-Source: AMsMyM5IB8RgcuzYzbkFmYZrPSXEs1oFyu5ZgLVs7Z6aLBG8OIFrAtoBUdy5htlVYoqfUMIXTvOVS3pYIt5SK/aEe3U=
X-Received: by 2002:a05:6102:3ed5:b0:386:91a5:a246 with SMTP id
 n21-20020a0561023ed500b0038691a5a246mr23144507vsv.26.1666728819322; Tue, 25
 Oct 2022 13:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221024220015.1759428-1-nfraprado@collabora.com> <20221024220015.1759428-4-nfraprado@collabora.com>
In-Reply-To: <20221024220015.1759428-4-nfraprado@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 25 Oct 2022 13:13:28 -0700
Message-ID: <CAGXv+5GUtP_mqbO4uJkMUL-=AxytUbEsMxgYtYdNis=zCzvFnQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] ASoC: dt-bindings: rt5682: Set sound-dai-cells to 1
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 3:02 PM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Commit 0adccaf1eac9 ("ASoC: dt-bindings: rt5682: Add #sound-dai-cells")
> defined the sound-dai-cells property as 0. However, rt5682 has two DAIs,
> AIF1 and AIF2, and therefore should have sound-dai-cells set to 1. Fix
> it.
>
> Fixes: 0adccaf1eac9 ("ASoC: dt-bindings: rt5682: Add #sound-dai-cells")
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
