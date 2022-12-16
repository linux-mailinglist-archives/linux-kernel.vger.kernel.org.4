Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98B664EC59
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 14:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiLPNxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 08:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLPNxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 08:53:52 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED57510B65
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 05:53:51 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id t5so2313003vsh.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 05:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UmuXeaOFho6ANXfp1SQvZE0XFVjmdQ4fKkeYxkg/yyI=;
        b=eIoiZi/4gDMxj50svw9SyjQJm2BKU8PdksFSnZHmxheG2a9r9aLgKOM4JGzgAx8has
         /04OQuIU9FLMyPBLbimX7c+1Zu/p7boOEIIq3dTGcfVJNqL22uf0DGueJt3HESk2b1OV
         yq4pnhKsdGKcz1sKN14E2/NC/cVGiNVpXZIxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UmuXeaOFho6ANXfp1SQvZE0XFVjmdQ4fKkeYxkg/yyI=;
        b=dJZrEHNgkq2PTD+ktbrpy0u1IEoueuVpfmHIfxDJGuna5yjAzKLLvE17n4524S4+7Q
         J4YIzGtiS31Lu27GNvKzZAf5OsX/7CVzCqmYF2YMQlq34vQW41mEYGhgm5lV4WvnTf1H
         +j+uO+nUkfBZBl0zy+TXpxQKVq40ka3We1pIKuTjptu+QKKRcijbPYeB/JSHSAlDQ+ai
         wnZScsmk5mqIBVvpT5ggzW6ejReDssxLr4DrdqGFbEbgglbOnaLoQPSppdY4TRulC7dU
         UAFJyqrjN346qo/ejMHnGfbbQG+6VMDUdKyfmIOMi71laSclgkyUXwsKp9UYcN9i1q0F
         xlAg==
X-Gm-Message-State: ANoB5pk2A0o4LkAunil6/T0Xsz4zs7kUAa6fitSLkCzqU1knM7b9ps5J
        oHCT3eQ8zqoJRFp/xn4kdHfMXhelxdlpVUrSt2rnuQ==
X-Google-Smtp-Source: AA0mqf5fUQgQ4R2pmyG5UrPUwro7ua/T3KJHAcqYojZPEANm6NoSCU9iii4yBsMFJEDwiY9k+YateBGOjpKKWJfIq3g=
X-Received: by 2002:a67:1c85:0:b0:3b0:92e2:37b0 with SMTP id
 c127-20020a671c85000000b003b092e237b0mr32534397vsc.9.1671198831097; Fri, 16
 Dec 2022 05:53:51 -0800 (PST)
MIME-Version: 1.0
References: <20221111082912.14557-1-matthias.bgg@kernel.org>
 <46c17d4b-d130-86a7-b5f8-73c30d7fdfdd@collabora.com> <CAGXv+5FORS=iGe55StxR_1E3sdtk9cvitfvNa1SydqCjWGcubg@mail.gmail.com>
 <dd474515-4a4f-3925-cc96-068f9818a2f4@gmail.com>
In-Reply-To: <dd474515-4a4f-3925-cc96-068f9818a2f4@gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 16 Dec 2022 21:53:40 +0800
Message-ID: <CAGXv+5EzuPrhNGiezJciaj0Hj-U-2KiSZFZc15yhNqNrpYs0Xg@mail.gmail.com>
Subject: Re: [PATCH v2] soc: mediatek: Add deprecated compatible to mmsys
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@kernel.org,
        nancy.lin@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 9:33 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 01/12/2022 12:20, Chen-Yu Tsai wrote:
> > On Mon, Nov 14, 2022 at 7:59 PM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Il 11/11/22 09:29, matthias.bgg@kernel.org ha scritto:
> >>> From: Matthias Brugger <matthias.bgg@gmail.com>
> >>>
> >>> For backward compatibility we add the deprecated compatible.
> >>>
> >>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> >>
> >> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >>
> >> ...And tested on MT8195 Cherry Chromebook.
> >
> > This now seems like a bad idea. In the dtsi we have two nodes (vdosys0 and
> > vdosys1) that both currently use the -mmsys compatible, which in the driver
> > maps to vdosys0. So not only do we have vdosys1 incorrectly probing as
> > vdosys0, we also have duplicate clks being registered and duplicate DRM
> > pipelines. On my device vdosys1 ends up winning the duplicate clock race.
> >
>
> That's true, we should fix the DTS deleting vdosys1 node as it's not
> implemented. While at it we should also fix the compatible for vdosys0 as
> "mediatek,mt8195-mmsys" is now deprecated.
>
> Would you mind to send a patch?

I'll be going on vacation shortly, and will be back after Christmas.

Reading the above, I assume you want two patches? One to drop the deprecated
compatible, and another to delete the vdosys1 node? And both should be
tag with fixes and backported?

I can take care of it after I get back. If someone wants to beat me to it,
feel free to do it.


ChenYu
