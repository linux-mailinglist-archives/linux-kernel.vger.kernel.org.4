Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6057763EF6A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiLAL0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLAL0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:26:00 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7071B233
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:25:58 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id g65so1223044vsc.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 03:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1+OjgymNTgpya4cFDzkY6TioB8zsQW+gfuuC/5sIFGI=;
        b=WJm3P5MCtjzSoLs7LiGyBy2a9Y+3xHS3FkTOUDFaDfO3xpAyiimaBU3hyYR2AkCfMP
         Bl66OvmqYD030PEcT/Md+1x8A9+WD+v27EW5zPDUnTldrKs44PgYCsj4dYXS1S4AzO/2
         AFofI6KaRIxKQElpiGpkTJdmM7JCHoxKNtJTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1+OjgymNTgpya4cFDzkY6TioB8zsQW+gfuuC/5sIFGI=;
        b=lSilSUT4xJeNyeS8HkjkcX8heJY2tHBtNx2O/5Fa4M+xhqSurnB9Vb1ON+VTOtHR1y
         /HXr7qYW+QRsZeNpEaeSaF5LwSsnxq1SKusB7rDq8PflhKAe9+iXV275Q6y0lj/R+ej1
         dGD9FdrH9ifIjf/EfGlSIvkD2QgUmPDPp8Y/6dzv9SbyLAp74iLTwSSNN1vb9blCcEvX
         SYSzeN1FZzpsIYpc9T2iXvbgizx6AdsELG546xvT8Jg7dSkPq09Ad5YVCEE2dwep+I9/
         jE8P+sTzTEvJYhSh2RRUL51ZKE2ibBvqJEtFu3yu3mbJMJZSjVfXrO/F1/U3V8+FcdQM
         FYWg==
X-Gm-Message-State: ANoB5plCAqtqzaQsdFMwwDCZeND29+ra9ur9GSR1iBHWUQkhpCaOWUWT
        hwzcZyTzKcbYH2AH1YXQ8ZL5bafciDARFM4nxwrPsA==
X-Google-Smtp-Source: AA0mqf4AYXsolIEAOErn11wxr7jiZlTxjgFcbV7F7SwpGeJg2LHiSLwosnWl4RljWivcFnk5n832mUFOiPN4aGcNMhw=
X-Received: by 2002:a05:6102:b16:b0:3a7:a88a:6bce with SMTP id
 b22-20020a0561020b1600b003a7a88a6bcemr28995324vst.65.1669893957629; Thu, 01
 Dec 2022 03:25:57 -0800 (PST)
MIME-Version: 1.0
References: <20221111082912.14557-1-matthias.bgg@kernel.org>
 <46c17d4b-d130-86a7-b5f8-73c30d7fdfdd@collabora.com> <CAGXv+5FORS=iGe55StxR_1E3sdtk9cvitfvNa1SydqCjWGcubg@mail.gmail.com>
In-Reply-To: <CAGXv+5FORS=iGe55StxR_1E3sdtk9cvitfvNa1SydqCjWGcubg@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 1 Dec 2022 19:25:46 +0800
Message-ID: <CAGXv+5GfZYdhSCkhdGXRvbprwhceMJy9a9j+cNxsyUFYhMNZOw@mail.gmail.com>
Subject: Re: [PATCH v2] soc: mediatek: Add deprecated compatible to mmsys
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@kernel.org
Cc:     matthias.bgg@gmail.com, nancy.lin@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
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

On Thu, Dec 1, 2022 at 7:20 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> On Mon, Nov 14, 2022 at 7:59 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
> >
> > Il 11/11/22 09:29, matthias.bgg@kernel.org ha scritto:
> > > From: Matthias Brugger <matthias.bgg@gmail.com>
> > >
> > > For backward compatibility we add the deprecated compatible.
> > >
> > > Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> >
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >
> > ...And tested on MT8195 Cherry Chromebook.
>
> This now seems like a bad idea. In the dtsi we have two nodes (vdosys0 and
> vdosys1) that both currently use the -mmsys compatible, which in the driver
> maps to vdosys0. So not only do we have vdosys1 incorrectly probing as
> vdosys0, we also have duplicate clks being registered and duplicate DRM
> pipelines. On my device vdosys1 ends up winning the duplicate clock race.
>
> I suggest just reverting this. The display stuff won't be useful unless
> the drivers are able to distinguish themselves from one another.

That and try to fix the vdosys0 node ASAP.

> Regards
> ChenYu
