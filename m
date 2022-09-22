Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034EF5E635C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiIVNNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiIVNNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:13:11 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA94EC573;
        Thu, 22 Sep 2022 06:13:09 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id e18so13565148edj.3;
        Thu, 22 Sep 2022 06:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=oWTAgtwEdQZEhs85baSFdY/uLUUmuKOodCcZZkRj3f4=;
        b=CkbkPm9sZT92CUg2pUAWxm7FSkCIy5KuWvdm6xqGMaMSMKGjz6IUUrrt9tBEWgZEX0
         ZntdiCzhVU095A0tvYU7ASniXrU9jBgW50/EVo97KePz9AqRdDvN9V0X61qIno3RvSWD
         zIaVhqb9qo9GETB3JMFQkrD9jyfaJLeq0aFcrVSOonbUdDQk2Zoe2kaby5UkRX92IIEe
         KNRaDkOiIcqJZSowIJBnEGKEk5ysYXex8c90iWHcTadStGoLrNiHN6nCDk4yREsC2xGZ
         CMH/IYoyYxKQlwN2wEdKBIGYUFKwM/gbNjGx3YOqWbUur3OVScbTchQX3c/T1vR7+e7o
         CQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=oWTAgtwEdQZEhs85baSFdY/uLUUmuKOodCcZZkRj3f4=;
        b=iuy8h2E9C1DczGKNodg00NH8kbF9elYIRHMlxp8fvQwhMN9aZtqz5Kya1ywVaKXaia
         +70BSpk22jiyHbae7z4doSoipPIcSCUeMLc8/A95nHCVPQYlWMbIxEFRGHDhFhaBHssn
         fhwgjzHtDuEhSHAHG4HnmFmFP+5+Za4Pi6ZwQE0NjXhjduwrYAXtXWeICEO7HX17S3qn
         gWgUHqv8NMwp0xuftpzheoNfYeOpGcKkH8C/UdSoxC3uTiFVCj8fabymC7KNUYNDmdSu
         n9NZOhdUG+66HaBe6yoHrgPX2vC3oSvYncZKLu1Xlz0bWmfxXOJeBlErcJSLr9j/EMnH
         +J6g==
X-Gm-Message-State: ACrzQf3hthvbizi+tV2mximcLohjLbPZBc6AFYTGSJHEoVWv5Qh6Lovs
        TxUhC7sBpp1dK7VyZwTaSGDvqpjCPKEZf7TnJ7M=
X-Google-Smtp-Source: AMsMyM4PKMKvlYcf/hCIe7vZMEpNy8o/YdyyidtAiCi4SblTBQNrgHsP5mlk39DFfMHq3yH8TrmBzeprLQLxatdhnDA=
X-Received: by 2002:a05:6402:50d1:b0:452:899e:77c with SMTP id
 h17-20020a05640250d100b00452899e077cmr3315015edb.0.1663852387440; Thu, 22 Sep
 2022 06:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220905230406.30801-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220905230406.30801-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Yys4CRNnKP3LXyAO@pendragon.ideasonboard.com> <CA+V-a8uiT9rV=T6LmFovRwULf3SO=JKdqr1yacAqN8gJmv9VPw@mail.gmail.com>
 <YyxWOuWOrYmMexNj@paasikivi.fi.intel.com>
In-Reply-To: <YyxWOuWOrYmMexNj@paasikivi.fi.intel.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 22 Sep 2022 14:12:40 +0100
Message-ID: <CA+V-a8u=WE1roHfr_6dsB85ajKtQx-uzJn82tsekvP2GtrOkqQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] media: platform: Add Renesas RZ/G2L MIPI CSI-2
 receiver driver
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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

Hi Sakari,

On Thu, Sep 22, 2022 at 1:34 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Prabhakar,
>
> On Thu, Sep 22, 2022 at 01:08:33PM +0100, Lad, Prabhakar wrote:
> > > > * Switched to manually turn ON/OFF the clocks instead of pm_runtime so that
> > > >   the mipi/dhpy initialization happens as per the HW manual
> > >
> > > That doesn't look right. The driver doesn't use runtime PM anymore, so
> > > power domains may not be handled properly. What was the problem with
> > > clock handling using runtime PM ?
> > >
> > If we use the runtime PM all the clocks will be turned ON when we call
> > pm_runtime_resume_and_get() which I dont want to. As per the "Starting
> > reception for MIPI CSI-2 Input" section 35.3.1 for example we first
> > need to turn ON all the clocks and later further down the line we need
> > to just turn OFF VCLK -> Enable Link -> turn ON VCLK. Due to such
> > cases I have switched to individual clock handling.
>
> If that is the case, then you should control just that clock directly,
> outside runtime PM callbacks.
>
OK, I'll move the control outside runtime PM.

> Runtime PM may be needed e.g. for resuming a parent device.
>
Agreed.

Cheers,
Prabhakar
