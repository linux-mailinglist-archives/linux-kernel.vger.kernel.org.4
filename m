Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62DF7407C3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 03:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjF1BrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 21:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjF1BrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 21:47:22 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994B31BD7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 18:47:21 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-39ed35dfa91so3900246b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 18:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687916841; x=1690508841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39f5Ofs4Fut4oG/x67xmD5HKVQS6vifJS9n1Fqh5CNI=;
        b=xCwf9hAwyokrWOGO7CX935cGCvgM7aunAkp6xEeawz1c2RtC1heZey3QYcfDZD205r
         hrqHBiB4isLHaYtBq5xyNuHLup9OdGt/LRrEiH786z8vYdu+ws4UwiE2bO71ztqUfVEa
         9xdUBGg/I8Kt9nxdQnb+RZahB3yaUyYznzbdGDDJ7QA3TBxRZT9VmjAzfEDg7Q/GMGUM
         gcDVRgMXClox+ITMtyGgKcM1qZz5dkJBHaXn28Mchsxhyv+SeBYF5u9LtDSX0N2xngqs
         mPrTsZQ4pTIIY6ByM1galx7dSoRDyWiH7A/Y6LH7HanurvSyOsBwCyDTh4JvDaHceB9W
         PXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687916841; x=1690508841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39f5Ofs4Fut4oG/x67xmD5HKVQS6vifJS9n1Fqh5CNI=;
        b=i9hNvDdlKzKV5f7zBbE36id3g/+A5gTRNSGAmu9+WMniPEotm0FUI6e5+HfLzDuFDA
         6/+99ZCLpVncr7NZ/HN2Kh7MwC7nhuameL2KDuIwKTiSfyBNMOznQQOcX9ayZu7wTt3F
         xL/nBqWcSEWxtbI7G8Q8T/0T2cs91jMbGlAT6pxgi/3n6ePyg0zKJ0vaFCnmUgEa8YmF
         ZQ19vwEOzzfxXR1p+4qinJwn5fX/po1mXDXR2svZESV2lmSZLqeA6pdUZsQSQwJSUGRe
         SkF6B9LGkjLZpWsg1YGmBXn1JlrKVqmwR7Ez/QG/bma30ar7Ca4wGVhrCTPkkSxwAVpt
         iCxQ==
X-Gm-Message-State: AC+VfDz2WlWdevs57WOuSV0mDYgaQdQnSu0WcAmE9UBjjsly1B22IIgO
        SXR4APnRuh2T9cvOpERV8dIpeEBEOKGt4mUnJq3c5Q==
X-Google-Smtp-Source: ACHHUZ7c501zOPij6leqylYmOj8Qka5FCrkxofq6AvdEns+6OFM8mCOc1asFuyTCWGmGLGr1txrh4LPuXsNJwsPyEls=
X-Received: by 2002:a05:6808:1b07:b0:399:b7bd:9041 with SMTP id
 bx7-20020a0568081b0700b00399b7bd9041mr36225966oib.34.1687916840967; Tue, 27
 Jun 2023 18:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230627050148.2045691-1-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=WR=fnhCxC37Eo3hinh2MV=eTNuXG+GrwgR6K_pV4Rbaw@mail.gmail.com>
In-Reply-To: <CAD=FV=WR=fnhCxC37Eo3hinh2MV=eTNuXG+GrwgR6K_pV4Rbaw@mail.gmail.com>
From:   cong yang <yangcong5@huaqin.corp-partner.google.com>
Date:   Wed, 28 Jun 2023 09:47:09 +0800
Message-ID: <CAHwB_NLDFqDEQ14cTAo3z1pvXvCZXhMeRbTXM3u93hVtpjE52w@mail.gmail.com>
Subject: Re: [v2] drm/panel: Fine tune Starry-ili9882t panel HFP and HBP
To:     Doug Anderson <dianders@google.com>
Cc:     sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
        airlied@gmail.com, hsinyi@google.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Doug


On Wed, Jun 28, 2023 at 5:17=E2=80=AFAM Doug Anderson <dianders@google.com>=
 wrote:
>
> Hi,
>
> On Mon, Jun 26, 2023 at 10:01=E2=80=AFPM Cong Yang
> <yangcong5@huaqin.corp-partner.google.com> wrote:
> >
> > Because the setting of hproch is too small, there will be warning in
> > kernel log[1]. After fine tune the HFP and HBP, this warning can be
> > solved. The actual measurement frame rate is 60.1Hz.
> >
> > [1]: WARNING kernel:[drm] HFP + HBP less than d-phy, FPS will under 60H=
z
>
> Thanks for including the warming. This looks like something that's
> only printed on Mediatek display controllers. Just out of curiosity:
> is that because Mediatek controllers have special requirements, or is
> this something generic and the Mediatek controller is the only one
> that warns about it?

It seems to be a generic calculation formula for MTK controllers.
At least I have see this warning in both MT8186 and MT8188.
By the way, the same warning will also appear under coreboot.

>
>
> > Fixes: 8716a6473e6c ("drm/panel: Support for Starry-ili9882t TDDI
> > MIPI-DSI panel")
>
> Ideally the tool you have to send mail wouldn't wrap the Fixes line.
> Probably not worth resending just for this, but see if there's
> something you can do to fix this in the future.
>
> Since this is a tiny fix, I don't think we need to wait too long. I'll
> plan to land it on Thursday unless Neil wants to land it himself
> sooner.

Thank you, Doug.

>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
