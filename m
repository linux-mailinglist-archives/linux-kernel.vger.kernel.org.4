Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06F5634907
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 22:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbiKVVSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 16:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiKVVSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 16:18:03 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD4C898E3;
        Tue, 22 Nov 2022 13:18:00 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id l24so9805947edj.8;
        Tue, 22 Nov 2022 13:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4sZiP84p7jF0pvs4MBIhQmWYULIbZ0e6iwSZJzE5pwQ=;
        b=XpOZcqaQ0eMy/qeOh4hvhz9LsEcgUzveEG9u9Fem4DsxLAHM9lStEAPal0RGO4cpki
         zStG3ZXk7GTzR18Pv4KIzhH3tg9WjCLXjS9yxaLfFXMZR+5H7MrGL0B105PEdTkS1Lnf
         Ijx3MsUFnkA8u7hJfAfZbtT3XzuUcCe6/q5rUFo2GacXNAWIsEa17ZghJE67RMQQmV2T
         lSQdvM2f8VgGG+cyLRawFSkPzcus9keTYvs8A4i0vGuWHppRUMZXpVcRPwYo5a4VcWM/
         oDl5vAiGKYINf+6OEfeDdWxchkocvnF+Yl+9ifT3QGszHng7uJwRtzrpMStHgGUJVAQy
         aL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4sZiP84p7jF0pvs4MBIhQmWYULIbZ0e6iwSZJzE5pwQ=;
        b=RdG9PL3YT1QaN+EYfSYxeO4yw7CxyOzOXx4/E0OPT/0NbbHIxdIjqJJJIoxRbzzOx+
         VIEzdgmp18Ez/dAdufhwa2je0mkZBP4nmVKWwo9u7sPmldJK0Nc++UGL3KVTxYJ9QDVR
         ckdT56Jd09Iw1qBjVaJ4Jtc/cs5HEgX9vLQIMOI6hutrtWSEmwcbp7nxjcwFi8EAIOCl
         4mEPrMIJ78zFH70Bn/nstdYXIM6LURSc1UU0SAPFOxgkuJ0JIwTd5r7Xm5E4ANJKXDme
         mze/V0kU6vwUF1WApNOIfhYnqGHjKdIFshDm4VsMJlPf8MzenU5zhloYoSsgpfwDiSnS
         zLjw==
X-Gm-Message-State: ANoB5pnGoFYaqYmNgGJp6aRv48LHW0/zOKr/8hnXLKhR946tDcHFMYpk
        PEzjfoR7IOxETCHUGgvoHF/to6QLs3KoJEN0ORE=
X-Google-Smtp-Source: AA0mqf7a2qbPeIAlQFrXSPAv9kBr2mK5cslq6jWPZVgJUbf8ANOsbilaUn7fkRFUZ8rW12ZdrinbI6kEnM+ZgCGI0OY=
X-Received: by 2002:a05:6402:2987:b0:45c:a9d3:d535 with SMTP id
 eq7-20020a056402298700b0045ca9d3d535mr22548328edb.0.1669151879209; Tue, 22
 Nov 2022 13:17:59 -0800 (PST)
MIME-Version: 1.0
References: <20221102004329.5410-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221102004329.5410-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y3yYkQhJJFLau08X@paasikivi.fi.intel.com> <CA+V-a8u9QS6Wk8SSmmJheHmtRiUWyOpv9DDJO6qDR8viz1Wp7A@mail.gmail.com>
 <Y30jdErgPI223eoM@paasikivi.fi.intel.com>
In-Reply-To: <Y30jdErgPI223eoM@paasikivi.fi.intel.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 22 Nov 2022 21:17:32 +0000
Message-ID: <CA+V-a8uLWqqqhs=vkzSVeNegg8uEXfTgJe26Jpap=eOb85aSGg@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] media: platform: Add Renesas RZ/G2L CRU driver
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Hi Sakari,

On Tue, Nov 22, 2022 at 7:31 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Prabhakar,
>
> On Tue, Nov 22, 2022 at 10:26:28AM +0000, Lad, Prabhakar wrote:
> > Hi Sakari,
> >
> > On Tue, Nov 22, 2022 at 9:38 AM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Prabhakar,
> > >
> > > On Wed, Nov 02, 2022 at 12:43:29AM +0000, Prabhakar wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Add v4l driver for Renesas RZ/G2L Camera data Receiving Unit.
> > > >
> > > > Based on a patch in the BSP by Hien Huynh
> > > > <hien.huynh.px@renesas.com>
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Laurent's comment arrive a little late but the patch does not compile
> > > against the media tree anymore. The argument of the media_pipeline_start()
> > > and media_pipeline_stop() is now a pad, not an entity. See what the changes
> > > look like in other drivers (the commit id is
> > > 12cecbf9150f67b0ce7d88bc2e243e67637726c2).
> > >
> > I'll go through them soon, when do you plan to close the v6.2 window?
> >
> > > I'll still take the DT binding patches.
> > >
> > Or maybe we could wait and get them alongside the drivers?
>
> Can you send a new version by tomorrow morning (Finnish time)? The needed
> changes didn't seem too complicated, I wouldn't want to delay my PR much
> later as chances slipping to 6.3 will increase.
>
Okay, I'll try and get this asap.

Cheers,
Prabhakar
