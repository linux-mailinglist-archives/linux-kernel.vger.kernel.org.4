Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD36E60B3B9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbiJXROj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiJXRNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:13:34 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131919C7CA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:49:01 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bj12so5894105ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k8cUhyF+iRbpVm7ZibvpxWN910TkG4qCMbi/DBVKQRg=;
        b=QCCxpZW74bpelD0cNFpuKewanqSBjPB7XKJWDhBUTh84B2UhnfiEX7GS+upegiuLBN
         GnCLEiGyh2+g1Kl3P0dDR8QNa8afxCSggYk5rMFobYArvjr6oqrzFOf9gS3aSWB4ZFda
         Xp17BhKgvbvZPef2NqX9p2f5t6HDGFD00BTLbhbHBUEGa05KY6EZmP42uKlWCESxSQDU
         2Kg9+7nk8CAJQD0XlnwOFeQBBR0e0NvmzklW0Yz6WsNRJ+5/iRgp2e+8v/YGH2Opus7Q
         DrQdCkgbinCnYan3+pBpZfZw1E5RRsY1RLLRy1yybVUMPQ1b+5k/ni9Kr73H8v8XF5nd
         2tYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8cUhyF+iRbpVm7ZibvpxWN910TkG4qCMbi/DBVKQRg=;
        b=j97L9XyQ5GfNpsaYwzeuI+9MRQTPCxOdiMUEp7EFWZkJz3o/GXi5pldQtJVhESXLWW
         sXhqqqECvaO8eueolXr1rgRGRYA/XNsraBZ/tqSpZbH1M3qR6CaWvhSRAhNYxfsWcv9E
         jah9smG9C7JaeVflrY6utZiAmJL41NneqPH59oVSfg9FuikoIlwLA0k35S+jIYqTUIzh
         HPGNPzxnR4HcgjaQxotOI+PeIFjYypK52Yg5ziDQpx6sECAxoy5Q4PuK3zkyKGYSRIcv
         2sJ/oRsBazPInkC23p6nK0BiB8LIIWwR70XAN6d8KCQK++DCfyeyFx5VC43naPBN+Pj8
         /BLQ==
X-Gm-Message-State: ACrzQf3ynVxkLudWafQuEXzCe9TtCM/vISBl8cczTvK8Yci6WItuaawa
        pnDsT5meCxE88nQmWtmrMUCZiy9rTKmSwIeJ1bF6BA==
X-Google-Smtp-Source: AMsMyM6eSCRZlQsr3x3MX2LJ8U7dR/Lcp1uuiIC6p0cWOh1wq3htWWGbxETJTk6iSILIXgvjOp4IhCLlxGinAjrVdY0=
X-Received: by 2002:a17:907:5c2:b0:77e:def7:65d8 with SMTP id
 wg2-20020a17090705c200b0077edef765d8mr28634968ejb.487.1666626461004; Mon, 24
 Oct 2022 08:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1666357434.git.mazziesaccount@gmail.com>
 <1ed8351c2cb4911fcda21b97f7a7b089e955c301.1666357434.git.mazziesaccount@gmail.com>
 <d1ed9ab7-6d67-fd93-6a77-86ea029eedc5@gmail.com>
In-Reply-To: <d1ed9ab7-6d67-fd93-6a77-86ea029eedc5@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 24 Oct 2022 17:47:29 +0200
Message-ID: <CAG3jFyvveGsO6VW1q8-aK1psabze5gAN=wCn16+Q4A_KH=WuvA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] gpu: drm: sii902x: Use devm_regulator_bulk_get_enable()
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022 at 15:24, Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>
> On 10/21/22 16:18, Matti Vaittinen wrote:
> > Simplify using devm_regulator_bulk_get_enable()
> >
> > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > Reviewed-by: Robert Foss <robert.foss@linaro.org>
>
> Robert, I did slightly modify the return from probe when using the
> dev_err_probe(). I still decided to keep your RBT - please let me know
> if you disagree.

Not a problem. In fact, feel free to upgrade it to an acked-by, to
simplify merging this series.

Acked-by: Robert Foss <robert.foss@linaro.org>

>
> Eg, this:
> > -     if (ret < 0) {
> > -             dev_err_probe(dev, ret, "Failed to enable supplies");
> > -             return ret;
> > -     }
>
> was converted to:
>  >      if (ret < 0)
> > +             return dev_err_probe(dev, ret, "Failed to enable supplies");
>
> Yours
>         -- Matti
>
> --
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
>
> ~~ When things go utterly wrong vim users can always type :help! ~~
>
