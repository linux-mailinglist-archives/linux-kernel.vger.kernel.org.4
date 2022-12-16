Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DCC64EC4C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 14:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiLPNvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 08:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiLPNu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 08:50:56 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55D9DEB5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 05:50:50 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id a66so2315951vsa.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 05:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cbz1CmmqId9+bDZYuPcoGryuf7U1LfPDstaViRXo87U=;
        b=T4i/qzq//6fdCaYHlNfEoSRrLrqmCxFovIEbSwW1oZ4YZKRo/hIWj6bXCStckFWlEv
         MHi0VNpg07o/AbPS4dVsrCsjd8BffW2saH9axZ4LCXoDI5WpC9sbC4mtnIDGN3qUbC8f
         UVy5JX4S0WMBKWVgdHPAuve8ToVb4sHnwXw9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbz1CmmqId9+bDZYuPcoGryuf7U1LfPDstaViRXo87U=;
        b=7hcnj+sbxS9XLuH4Xe7BBrUc4UUK9MV6Jd33A5zXViNdlpb+Tl8zhM/A3wY/bccIY4
         nSqp98shlkW67GuMy5PLD+RoFIqHLfQ0T4/8eQ+F9ElcvqLZwzdCYWYvMIzoq7kEE/Bm
         leP8JZ6Y5KHDtF/LOb2MektdYAA8YqVKL+LSXzHS2PQROGUAmhTJAxsvNhtXh0yykPxo
         pTTRZhhCUoqMp7zFfEo7s7wz9eeXEgabJab3FpPm9AtUxRh9ZiLKh20S2zgGDV32hTPh
         IMFECLIIU3aMHvfoFk6noQseHoxkWOOJhp9H4DYvKeZxMdXBkgejVzDevpywVyw8SS06
         mKXw==
X-Gm-Message-State: ANoB5pkpqNvzlCZgK83IpTHaWSEhqxFbWwssWOvE+5Pr2BYqN6YiD1gK
        hn2+naTPZotLvl49MlRMV9EJY0ImZOIoUAYbAgnVrxEerlewhA==
X-Google-Smtp-Source: AA0mqf4J17hQ+kty31TbVJ9lwVCeJHjF5elt4zuRZXXx2EaqUgcKMpqJYKtw1VJNlTldCeKshR0UJyDv+E0j3MEd8Cg=
X-Received: by 2002:a67:c98e:0:b0:3ad:3d65:22b with SMTP id
 y14-20020a67c98e000000b003ad3d65022bmr49199011vsk.65.1671198649627; Fri, 16
 Dec 2022 05:50:49 -0800 (PST)
MIME-Version: 1.0
References: <20221111082912.14557-1-matthias.bgg@kernel.org>
 <46c17d4b-d130-86a7-b5f8-73c30d7fdfdd@collabora.com> <CAGXv+5FORS=iGe55StxR_1E3sdtk9cvitfvNa1SydqCjWGcubg@mail.gmail.com>
 <CAGXv+5GfZYdhSCkhdGXRvbprwhceMJy9a9j+cNxsyUFYhMNZOw@mail.gmail.com> <52a9924a-aaea-ed31-672f-fdf8e1ef2881@gmail.com>
In-Reply-To: <52a9924a-aaea-ed31-672f-fdf8e1ef2881@gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 16 Dec 2022 21:50:38 +0800
Message-ID: <CAGXv+5E8fdFsCf5rVYx0ssZzQsDn69ThX6d3betejkE6=GdBnw@mail.gmail.com>
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

On Fri, Dec 16, 2022 at 9:35 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 01/12/2022 12:25, Chen-Yu Tsai wrote:
> > On Thu, Dec 1, 2022 at 7:20 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
> >>
> >> On Mon, Nov 14, 2022 at 7:59 PM AngeloGioacchino Del Regno
> >> <angelogioacchino.delregno@collabora.com> wrote:
> >>>
> >>> Il 11/11/22 09:29, matthias.bgg@kernel.org ha scritto:
> >>>> From: Matthias Brugger <matthias.bgg@gmail.com>
> >>>>
> >>>> For backward compatibility we add the deprecated compatible.
> >>>>
> >>>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> >>>
> >>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >>>
> >>> ...And tested on MT8195 Cherry Chromebook.
> >>
> >> This now seems like a bad idea. In the dtsi we have two nodes (vdosys0 and
> >> vdosys1) that both currently use the -mmsys compatible, which in the driver
> >> maps to vdosys0. So not only do we have vdosys1 incorrectly probing as
> >> vdosys0, we also have duplicate clks being registered and duplicate DRM
> >> pipelines. On my device vdosys1 ends up winning the duplicate clock race.
> >>
> >> I suggest just reverting this. The display stuff won't be useful unless
> >> the drivers are able to distinguish themselves from one another.
> >
> > That and try to fix the vdosys0 node ASAP.
>
> I'm not sure what you mean? If there are any patches that are in my queue that
> needs attention, please let me know.

It was more of a P.S. note.
