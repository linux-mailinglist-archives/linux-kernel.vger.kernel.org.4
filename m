Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFF360D515
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiJYT54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbiJYT5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:57:48 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13B310EA18
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:57:47 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id x66so12241169vsb.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIZ7E5sm0oVhsFi7Syn1ZuCebIsgM//+qsvyda8C3ww=;
        b=e+qZj/QT7BhnoLzJRhfbZB8ytdCtnQT+EOebSeFOrEpqlQvGI9ku8p0ouxhXeQC90R
         cRR65HJVboQ0DaJOdu5FN826Twnr/HDNbCNgIR/fazK5GRVLx5K2Caup9By3OEvRc6VL
         XBzcF3L7iVveJmBZAFmITG2HQ4cJGeDC9ZuW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIZ7E5sm0oVhsFi7Syn1ZuCebIsgM//+qsvyda8C3ww=;
        b=7pzmHk5aMumfvWYJfS9nRr2lz1wCPo3D8yZcQYNcq/KNESWhoKO37APDdC0PHHzUNi
         G7qemAwntsjCm9z2tipJcpiaq9mgvnPeN5JjdU4lbyoc9tJNNrYSeC6QFOQyQKyuo0Hg
         LHYOaAxeA/Re/GPaB8SDZSCf6vtq/OoJ4hCzTg9KE37L+PwbhGwxS7Su1ApFYa56inJI
         nLnyvEGvF72rUm5ZMBSenwiQG/au8kiy1uNfd7YAkX+rb1sap8oI2o97CwT92rZCtQk/
         XvqXkazM2Pi3OMja3Rc7Apq2Z4qVFoh+Ch9n6cwjRScddAzNJF1x+X5V6tcn+/8XbI/c
         vu6g==
X-Gm-Message-State: ACrzQf1dUdf2c1H24loNR/g/Nj/IaRp+ltkqanaeKjAligqIf08xggIK
        aT8M+Ze0+jEdzOOF4k7bEHp3Dhn6MPM16npjlabrFw==
X-Google-Smtp-Source: AMsMyM68yxjtygGzCNmwCEf3ID4HFVpQ7xTLBDVwuunh8zLtsSitwC+a8tjP/31TtJUhFd+flFlgXTV/pYKdu1XQ+UY=
X-Received: by 2002:a67:f684:0:b0:392:ac17:f9b0 with SMTP id
 n4-20020a67f684000000b00392ac17f9b0mr23400930vso.85.1666727866859; Tue, 25
 Oct 2022 12:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221024220015.1759428-1-nfraprado@collabora.com>
 <20221024220015.1759428-2-nfraprado@collabora.com> <b1863393-0b73-ca44-12ae-567982b07f68@collabora.com>
In-Reply-To: <b1863393-0b73-ca44-12ae-567982b07f68@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 25 Oct 2022 12:57:35 -0700
Message-ID: <CAGXv+5HJQYjkQ7Vrggn5oYRYQu6YH8NS4QmfcP16Zk9kbEJNeA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ASoC: dt-bindings: realtek,rt5682s: Add #sound-dai-cells
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Derek Fang <derek.fang@realtek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 3:07 AM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 25/10/22 00:00, N=C3=ADcolas F. R. A. Prado ha scritto:
> > The rt5682s codec is a DAI provider with two interfaces - AIF1 and AIF2
> > - and therefore should have a #sound-dai-cells property that is equal t=
o
> > 1. Add it.
> >
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> >
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
