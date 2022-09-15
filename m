Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2006C5B98D9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 12:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiIOKdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 06:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiIOKdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 06:33:08 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861BD985B7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 03:33:07 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w28so2321859edi.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 03:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6ifpauVmJUgIH/sgYWdEGfAKQC88gDxZ9NsZnNvTH0g=;
        b=EvxJNskBHSObgaO7mGBWI/uXK0Mb3OD8ALwba2dS1xR96/k3XEE79tNNfWNTafh4Ze
         lqrj8swpHsBHpqi7JBf2SLgSaHPrDDB1sNbdgF/s63+qaEDBXADRV/sM3tdDrtUKas/b
         RSXwk0600eoHlXBcigsdUZWY2LjZgTgQq5l2nCYPIAw+GO0k3U4Xo9vGoyh0gZqK52fM
         OYRIfsdBrxsh+qH3i1MiQg0kKhngWbEB7yVjLhhDhCzTM1BQhId1fazvI3+6GnWnCwYH
         EJvqwn5lO38oymxuYtoK2+m7zrDfu6P4sJL8bLAde98AVqwTt3OQt2JqGAC4szcKqlPk
         4QBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6ifpauVmJUgIH/sgYWdEGfAKQC88gDxZ9NsZnNvTH0g=;
        b=H5QGL+ZhZkS5nLQ04yIVVSTHRwTSQ/nc8mXk+mvwCEUys2mfPvhZiCFIhtCpB05PYG
         UirZjtymlALtEjgFnQ7XUOgLlCmtrhdbvJRaNUFijlCHfcON9tH3hMJAmkbgaen6DFfX
         ZZFlGkmkPIpPgx/9C4kZYUvbovBSXIuE4SdC6igfyoy1I0CznfGMR2b9j7eZ+gLU/7ou
         W2KdsJxaAeK4C8U1Py4Sqv7nX4oLMWLrX0XTat3ksXmVFW/A+3WOXmjEAVUu5uUYpUxA
         gmylD7elQM8wn0vuJ6G+wO51LhUzrkU3jzL5ixGX8yEjtuncQjnbqg6Oaxmeq88vs9DL
         8CXA==
X-Gm-Message-State: ACgBeo2RScBpbNWAj15qznUeykbKzlazrpV5y4A2QNSMVU0I1hwnaLpA
        cnbvWKFoEoMutbYBTkvEr1Phlnyvg5r/fUabGkIeqt4cG6JwMg==
X-Google-Smtp-Source: AA6agR4ylPnDzITJuO4HyK24okfIXy3SOGAp/Bfcp1DTAQbL9fSBv0XU1AwfnGlvLYEYSgPhNn2eVev0y2uFvpu0OrM=
X-Received: by 2002:a05:6402:909:b0:435:a8b:5232 with SMTP id
 g9-20020a056402090900b004350a8b5232mr34576311edz.240.1663237986096; Thu, 15
 Sep 2022 03:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220912113856.817188-1-robert.foss@linaro.org>
 <20220912113856.817188-3-robert.foss@linaro.org> <CAD=FV=WrH2AAFxV72FZqk-=xU8jzCn6KtcbZRYJAaCwhmvSWmg@mail.gmail.com>
 <Yx9FZDKjOcS9wmcI@pendragon.ideasonboard.com>
In-Reply-To: <Yx9FZDKjOcS9wmcI@pendragon.ideasonboard.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 15 Sep 2022 12:32:54 +0200
Message-ID: <CAG3jFytreStdyLLhUB+gHb3dHnEfUNr66BPQHkU8VdfjYYQiUw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] Revert "drm/bridge: ti-sn65dsi86: Implement bridge
 connector operations for DP"
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Sept 2022 at 16:43, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Sep 12, 2022 at 03:29:52PM +0100, Doug Anderson wrote:
> > On Mon, Sep 12, 2022 at 12:43 PM Robert Foss <robert.foss@linaro.org> wrote:
> > >
> > > As reported by Laurent in response to this commit[1], this functionality should
> > > not be implemented using the devicetree, because of this let's revert this series
> > > for now.
> > >
> > > This reverts commit c312b0df3b13e4c533743bb2c37fd1bc237368e5.
> > >
> > > [1] https://lore.kernel.org/all/20220902153906.31000-2-macroalpha82@gmail.com/
> > >
> > > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > > ---
> > >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 28 ---------------------------
> > >  1 file changed, 28 deletions(-)
> >
> > Any chance you got confused and reverted the wrong patch? This
> > ti-sn65dsi86 patch doesn't seem relevant to the problems talked about
> > in the commit or the cover letter. Maybe I'm missing something?
>
> Aarghhh I missed that when checking the cover letter :-( This indeed
> seems wrong.

Yep. This is a mistake. I copy/pasted the wrong line and then assumed
that ti-sn65dsi86 & chrontel-ch7033 shared a driver. I'll look into my
workflows to try to prevent future mistakes of this nature.

A series fixing this has been posted.
https://lore.kernel.org/all/20220915102924.370090-1-robert.foss@linaro.org/

Thanks for catching this Doug!


Rob.
