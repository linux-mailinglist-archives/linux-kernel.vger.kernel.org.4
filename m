Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68FA633A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbiKVKcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbiKVKba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:31:30 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DA856D43;
        Tue, 22 Nov 2022 02:26:56 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id f27so34819038eje.1;
        Tue, 22 Nov 2022 02:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yq5BeDsfOkj486y5H1ERahq8TpRQn9TfZ3ScikXfWmM=;
        b=XPSVUQXoXr3PvCCxBKMQN7m6u6cu4taFeNyyljtGb7W+WI1Nh81lOHWO/k6MAhDs22
         sMIGwku1WXvVymnbxBiLnnBKoFjmaOzNaxJjKIthlPEtVbRN7/bg3t48g4W13Rhs/cOP
         oIyZfL9n4AI1/KBNDnbtStEAIwOTi+ydUCiE0SyJ9v72UPjxgshY+qlnhyMKOT13O1Ua
         3lS9qdaMLnTDSna34HVodPM3vlgVegYeB1gd4mZAC89bmD9WrjrpQF4jsAFpcbV/jN9Y
         iI1pr3sVa4SujG6A/1fe1wjfySY8Z7ms56XfbbjJcht+mGKcCuDd/IqtuFo2w2HdcgBs
         4eUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yq5BeDsfOkj486y5H1ERahq8TpRQn9TfZ3ScikXfWmM=;
        b=UWF72qlsmYASbW3soYhjlRuiA/xk4xObtKgFqkDjN1c3HsGcKZsjyk89gTRK8Yn6JO
         p0RPuH0K2KodojAWRWYD5+L1HIESGOadtRQ+lSvbEcQUm6rZVNE6Et1vtUWVxPb0MJRO
         MpyCTXapmLJo4wer20ceBZoe6dUr8KMa1bQfvmUfWS3e7Y7+M40LL5TBOB8Mp2Zn5xYB
         HRXgg3Z02M0IxO+2NoGxXE41zoAWsUEJK6fcKkmC2o+5BVuh8LLXSYQ9tyf+jUNbI/dd
         rMeRLDKFqGoMMbxuqveWRHGTH/yLad8pC0TjrCDVSmvFgQ6/SoTti+0XKELW981R3dh2
         rPqQ==
X-Gm-Message-State: ANoB5pn9muWuDF3P1ne1hzgasoEukVQDtloUPTw+2Cli1jiXPBBteWac
        QA6J/gUBTXZuwDK5nnxX4r6KEGLaLQg28h4Q55g=
X-Google-Smtp-Source: AA0mqf514JQr3DRpS4KD4jCrWqs6HRrx1z6hGT/uOBoAk0jHHJTdNY9ByeiniQQ/5/vW8d3+za1uOc6O0xKW+qEGM0w=
X-Received: by 2002:a17:906:3792:b0:7aa:97c7:2bfe with SMTP id
 n18-20020a170906379200b007aa97c72bfemr19067753ejc.196.1669112814960; Tue, 22
 Nov 2022 02:26:54 -0800 (PST)
MIME-Version: 1.0
References: <20221102004329.5410-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221102004329.5410-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <Y3yYkQhJJFLau08X@paasikivi.fi.intel.com>
In-Reply-To: <Y3yYkQhJJFLau08X@paasikivi.fi.intel.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 22 Nov 2022 10:26:28 +0000
Message-ID: <CA+V-a8u9QS6Wk8SSmmJheHmtRiUWyOpv9DDJO6qDR8viz1Wp7A@mail.gmail.com>
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

On Tue, Nov 22, 2022 at 9:38 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Prabhakar,
>
> On Wed, Nov 02, 2022 at 12:43:29AM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add v4l driver for Renesas RZ/G2L Camera data Receiving Unit.
> >
> > Based on a patch in the BSP by Hien Huynh
> > <hien.huynh.px@renesas.com>
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Laurent's comment arrive a little late but the patch does not compile
> against the media tree anymore. The argument of the media_pipeline_start()
> and media_pipeline_stop() is now a pad, not an entity. See what the changes
> look like in other drivers (the commit id is
> 12cecbf9150f67b0ce7d88bc2e243e67637726c2).
>
I'll go through them soon, when do you plan to close the v6.2 window?

> I'll still take the DT binding patches.
>
Or maybe we could wait and get them alongside the drivers?

Cheers,
Prabhakar
