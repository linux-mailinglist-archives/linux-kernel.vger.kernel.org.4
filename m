Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829B65FF561
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJNV23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiJNV2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:28:23 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63923AD9A2;
        Fri, 14 Oct 2022 14:28:22 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id sc25so13064656ejc.12;
        Fri, 14 Oct 2022 14:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cBdVRz3aai++/yfNem0cRz4vqtS6rcLCQcx1bOqCTrk=;
        b=aDyZmY5asYVMBAavAWE7H8xl6PPVHJfQrQLZDLFqQW38Y70En1nlsWHTbAxNE+tRUF
         EvFsjWVoVyTnFUTWnSKyiefPyZ8/Yt09noyzqU24OTyaVOGieZ7xkqh1ffIUKL/PQAyC
         U72GXUyBdQ7Ffn17P/WlCKTwjQD8gtwSoCHz95QHCgVXFcOF2l0MoMsLFKec0vqvVLVw
         2kRKTbo8JDpfxQQzcoSUUjTm9WnWw047g+Pk0d1rcyFxY3oPd3D2VawdFsVSFd+9rd6h
         bPbPf06UnRyD27DTnvX49W5NYziIKfpZ7gZfrOsaiA1EtMK+a+KNffRtZLajmBZOOVNX
         BQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cBdVRz3aai++/yfNem0cRz4vqtS6rcLCQcx1bOqCTrk=;
        b=bz/85Sw5WlMtgLfwG9l75+mQP4rypt+s67JT5zAltw5ZTXy0kCbW6aWt69jvhzr+pP
         P2s6B1V8p9TMdEIL7IwxfPV8jVGSF4PxDTQwdUsPa34KbWaLpOC9GvshaAF3NSSgevx6
         nLPmtDxbc0wpq/fWlwNtKsXvHscBd6eXooP5DOZbb7aGWUSQm6Y6jgS8Q+NF2+MjaJ5b
         5bbKphRkB/Vn7139h4gZDGYNJasLOaBqOgmRdvzpg7bh3PXKy8eqS+LB+wLDOKEkzLZa
         yPMne0i47f2LliPzh1oyLAJjZ5kpXQK860qPdtzImUJjPq84oRR6JfRq6rgRdGO4FOE2
         Ss0w==
X-Gm-Message-State: ACrzQf2AG16zOKN7Dg/yv3dIptCMt60+tcyHOknQ7fsF0dEki0/4+h5s
        JCKdEA+B4ZKSFZ+T0kDx5WfecLI6u4ge94zRZTw=
X-Google-Smtp-Source: AMsMyM5J33tCN546/v5heQ+s7KXdA4foVh9BKALQn2p1Dom3wmThyVPXwcIHhGdAXqGGySaefAeAkOXtP/Q3IAsYV6M=
X-Received: by 2002:a17:906:591:b0:73d:c3ef:84ae with SMTP id
 17-20020a170906059100b0073dc3ef84aemr4866942ejn.155.1665782900837; Fri, 14
 Oct 2022 14:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221014183459.181567-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAL_JsqKC_BJDJLLFck_0CbQ-0rZ0oVWMAdiwwGep23nh2pP19g@mail.gmail.com>
In-Reply-To: <CAL_JsqKC_BJDJLLFck_0CbQ-0rZ0oVWMAdiwwGep23nh2pP19g@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 14 Oct 2022 22:27:53 +0100
Message-ID: <CA+V-a8vMLuzJ8h5UDNXUiZRXPV1vJ9gguUMywe_+sPcU8tK+tA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] media: dt-bindings: ov5645: Convert OV5645 binding
 to a schema
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Rob,

Thank you for the review.

On Fri, Oct 14, 2022 at 10:05 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Fri, Oct 14, 2022 at 1:35 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> >
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Convert the simple OV5645 Device Tree binding to json-schema.
> >
> > The previous binding marked the below properties as required which was a
> > driver requirement and not the device requirement so just drop them from
> > the required list during the conversion.
> > - clock-frequency
> > - enable-gpios
> > - reset-gpios
> >
> > Also drop the "clock-names" property as we have a single clock source for
> > the sensor and the driver has been updated to drop the clk referencing by
> > name.
>
> Driver requirements are the ABI!
>
> This breaks a kernel without the driver change and a DTB that has
> dropped the properties.
>
I already have a patch for the driver [0] which I missed to include
along with the series.

> Also, with 'clock-names' dropped, you've just introduced a bunch of
> warnings on other people's platforms. Are you going to 'fix' all of
> them?
>
Yes I will fix them, once the patch driver patch [0] is merged in.

[0] https://patchwork.kernel.org/project/linux-media/patch/20220919143350.176746-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar
