Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F875E6394
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiIVN1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiIVN1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:27:45 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639B1E3EC2;
        Thu, 22 Sep 2022 06:27:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x21so6524390edd.11;
        Thu, 22 Sep 2022 06:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=GfDOH3Jon3LZczj1G1VLJYGGbFNCEA02UiZeXWZy9+k=;
        b=hif0g0HseARCaUTv7LneolSToCeCpqwcD8FGLV/jJbP3gxyplN7LmjqI80BuO9Os9Q
         sswktMIzxvl/AVbE4k6P4qdrDa+/MdIYr2V5b5a5X3BZEuj7dONlbzOEeWORcNqAKqih
         0iF1cRLKrthqqimysu9x8U05GYDaKiM4VKrUng7rC7R17nS4lucImmCQf7y17RbhDVnB
         vGjbQ6FbdYExu+be5WuTjg2CCxNwbXaAFzAyd60saH1doqta7PtD5CZjGjb04iACUL9q
         uPyAatDxEDIiwso2g+ubYr4ubEpG7N0wK1Bli2F9JrTIN/7B1OfRefvMvrTK8dJDvXt1
         nNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=GfDOH3Jon3LZczj1G1VLJYGGbFNCEA02UiZeXWZy9+k=;
        b=ymHaerePL76EDpTb3aJXXfPG44GTzHYHD3VQiO/x8Y7vpXB5JV5DyQ6ZvwHZ1T1L7o
         qA5jwWy7Jp7mI/G2XCvg3p4A5eWgGYOVbirIZ57z/l7uPWBP0CVnbjfwSepIjjhRt5W7
         LLntUe0t+73aGOG83lBfMMu1xEowsVDIjGkgiANCSuPNOS676cjrKZa4gb3swW93bM+o
         B99D0iMfmngLhbGKM02OXBwktogeF9cpge8oil8qUwWFFjAulgAWKRLr6R6t8rJyOZKW
         5Mbh6ruZQlqL0ysxB7NK4aKgH2hGcmo9eVxF5Bw2FFE/zsvs/35CfUxzhCQIOPNtmLm9
         ZKAw==
X-Gm-Message-State: ACrzQf1En7jC1FdczfJaqNfy4yj5YyQHKFUeRFpyfcxr+FnZ+n71FtyV
        YurwaH5Aoisi9aGEGkHYwk+luNiN4sMU/6kqL+E=
X-Google-Smtp-Source: AMsMyM7ba5r7bm3C3G5a4yke+Lid3XcbkkD0mY3+g3iS/ETXCxmQqk09XieYxa+H5d0Rx3S6C1KgmoXrhfHfiW8b4y0=
X-Received: by 2002:a05:6402:50d1:b0:452:899e:77c with SMTP id
 h17-20020a05640250d100b00452899e077cmr3385432edb.0.1663853261902; Thu, 22 Sep
 2022 06:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220905230406.30801-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220905230406.30801-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Yys4CRNnKP3LXyAO@pendragon.ideasonboard.com> <CA+V-a8uiT9rV=T6LmFovRwULf3SO=JKdqr1yacAqN8gJmv9VPw@mail.gmail.com>
 <YyxWOuWOrYmMexNj@paasikivi.fi.intel.com> <CAMuHMdXKz56jxw56fXa7CMh_y4MVYiUT25dqRntJw6481s1FWw@mail.gmail.com>
In-Reply-To: <CAMuHMdXKz56jxw56fXa7CMh_y4MVYiUT25dqRntJw6481s1FWw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 22 Sep 2022 14:27:15 +0100
Message-ID: <CA+V-a8sW=a6auFH-1WqwK+o2MZGCQk+MAO4+cWKm1M+YrQE+CA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] media: platform: Add Renesas RZ/G2L MIPI CSI-2
 receiver driver
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Thu, Sep 22, 2022 at 1:51 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Thu, Sep 22, 2022 at 2:34 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> > On Thu, Sep 22, 2022 at 01:08:33PM +0100, Lad, Prabhakar wrote:
> > > > > * Switched to manually turn ON/OFF the clocks instead of pm_runtime so that
> > > > >   the mipi/dhpy initialization happens as per the HW manual
> > > >
> > > > That doesn't look right. The driver doesn't use runtime PM anymore, so
> > > > power domains may not be handled properly. What was the problem with
> > > > clock handling using runtime PM ?
> > > >
> > > If we use the runtime PM all the clocks will be turned ON when we call
> > > pm_runtime_resume_and_get() which I dont want to. As per the "Starting
> > > reception for MIPI CSI-2 Input" section 35.3.1 for example we first
> > > need to turn ON all the clocks and later further down the line we need
> > > to just turn OFF VCLK -> Enable Link -> turn ON VCLK. Due to such
> > > cases I have switched to individual clock handling.
> >
> > If that is the case, then you should control just that clock directly,
> > outside runtime PM callbacks.
> >
> > Runtime PM may be needed e.g. for resuming a parent device.
>
> Exactly.
> So probably you should not consider R9A07G044_CRU_VCLK a PM clock,
> i.e. you need changes to rzg2l_cpg_is_pm_clk() to exclude it.
>
Thanks for the pointer. In that case we will have to consider
R9A07G044_CRU_VCLK and R9A07G044_CRU_SYSCLK as not PM clocks.

Does the below sound good?
- DEF_NO_PM() macro
- bool is_pm_clk in struct rzg2l_mod_clk.

I still have to implement it, just wanted your opinion beforehand.

Cheers,
Prabhakar
